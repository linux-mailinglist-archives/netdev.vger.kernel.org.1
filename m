Return-Path: <netdev+bounces-41127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EF7C9D9D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 05:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AE51C208F0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B53185C;
	Mon, 16 Oct 2023 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF41C04;
	Mon, 16 Oct 2023 03:06:56 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA8AD;
	Sun, 15 Oct 2023 20:06:50 -0700 (PDT)
X-QQ-mid:Yeas6t1697425530t634t42350
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.254.108])
X-QQ-SSF:00400000000000F0FRF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 336924250621600963
To: "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Justin Stitt'" <justinstitt@google.com>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
References: <20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-v1-1-c9bb3270ac98@google.com> <1c0e94ff-617b-4672-addb-8933f92edc29@lunn.ch>
In-Reply-To: <1c0e94ff-617b-4672-addb-8933f92edc29@lunn.ch>
Subject: RE: [PATCH] net: txgbe: replace deprecated strncpy with strscpy
Date: Mon, 16 Oct 2023 11:05:29 +0800
Message-ID: <002101d9ffdd$9ea59f90$dbf0deb0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcK3turiHmB5HqJcjT9d5vqg1iWAIh9y4rsLZREeA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sunday, October 15, 2023 12:31 AM, Andrew Lunn wrote:
> On Thu, Oct 12, 2023 at 09:20:04PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > Based on usage part_str usage within txgbe_read_pba_string(), we expect
> > part_str to be NUL-terminated but not necessarily NUL-padded:
> > |       /* put a null character on the end of our string */
> > |       pba_num[10] = '\0';
> >
> > Interestingly, part_str is not used after txgbe_read_pba_string():
> > | ...
> > |	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
> > |	if (err)
> > |		strscpy(part_str, "Unknown", sizeof(part_str));
> > |
> > |	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
> > |
> > |	return 0;
> > |
> > |err_remove_phy:
> > |	txgbe_remove_phy(txgbe);
> > |err_release_hw:
> > |	wx_clear_interrupt_scheme(wx);
> > |	wx_control_hw(wx, false);
> > |err_free_mac_table:
> > |	kfree(wx->mac_table);
> > |err_pci_release_regions:
> > |	pci_release_selected_regions(pdev,
> > |				     pci_select_bars(pdev, IORESOURCE_MEM));
> > |err_pci_disable_dev:
> > |	pci_disable_device(pdev);
> > |	return err;
> > |}
> > ... this means this strncpy (or now strscpy) is probably useless. For
> > now, let's make the swap to strscpy() as I am not sure if this is truly
> > dead code or not.
> 
> Hi Julian
> 
> I agree, this looks like dead code.
> 
> Jiawen, please could you submit a patch cleaning this up. Either swap
> to strscpy() and make use of the string, or delete it all.

Ah, I think I missed a line to print this string. I'm going to add it.



