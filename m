Return-Path: <netdev+bounces-41703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94527CBBCB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F02281408
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23228156F9;
	Tue, 17 Oct 2023 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8A11728
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:56:28 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34656AB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:56:23 -0700 (PDT)
X-QQ-mid:Yeas47t1697525707t444t52469
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.254.108])
X-QQ-SSF:00400000000000F0FRF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16759421726094174930
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20231016094831.139939-1-jiawenwu@trustnetic.com> <23d363d0-70d6-42b7-9efd-d9953b3bc7f5@lunn.ch>
In-Reply-To: <23d363d0-70d6-42b7-9efd-d9953b3bc7f5@lunn.ch>
Subject: RE: [PATCH] net: txgbe: clean up PBA string
Date: Tue, 17 Oct 2023 14:55:06 +0800
Message-ID: <010901da00c6$dca02ba0$95e082e0$@trustnetic.com>
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
Thread-Index: AQK9HPdu1S25dJV4PK5RCAPTMaA92AGvHQB4rnnTNkA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, October 17, 2023 3:19 AM, Andrew Lunn wrote:
> On Mon, Oct 16, 2023 at 05:48:31PM +0800, Jiawen Wu wrote:
> > Replace deprecated strncpy with strscpy, and add the missing PBA prints.
> >
> > This issue is reported by: Justin Stitt <justinstitt@google.com>
> > Link: https://lore.kernel.org/netdev/002101d9ffdd$9ea59f90$dbf0deb0$@trustnetic.com/T/#t
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index 394f699c51da..123e3ca78ef0 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -741,8 +741,9 @@ static int txgbe_probe(struct pci_dev *pdev,
> >  	/* First try to read PBA as a string */
> >  	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
> >  	if (err)
> > -		strncpy(part_str, "Unknown", TXGBE_PBANUM_LENGTH);
> > +		strscpy(part_str, "Unknown", sizeof(part_str));
> >
> > +	netif_info(wx, probe, netdev, "PBA No: %s\n", part_str);
> >  	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
> 
> In general, we try not to spam the kernel log, especially not for the
> good case. You can get the MAC address with ip link show. How
> important is the part? Can you get the same information from lspci?
> Or maybe you could append it to the driver name in wx_get_drvinfo()?

PBA info can be read from lspci, also the log for MAC address can be removed.
I'll submit a patch to clean them up in txgbe/ngbe.



