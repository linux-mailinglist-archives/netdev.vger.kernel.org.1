Return-Path: <netdev+bounces-41004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC67C9562
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38DC281ACB
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C41803B;
	Sat, 14 Oct 2023 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2M5x3pC1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA091864C;
	Sat, 14 Oct 2023 16:31:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135FB7;
	Sat, 14 Oct 2023 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=THW6nJ2E4AHZv1MDVtsblWf1vbWublGZsqD9188DwRQ=; b=2M5x3pC1mi007B7pI4y7wNG/un
	A1lastkRpMyrGbf3qUyYHJTvyTclWO0y1uI+gDzqvhwxHe/1GML/NHgwZXFSz22Uy+jtlymWPRuXn
	EoLmFOnO4bPYCIbab1hOci/DMstEoEvC3nhLI4SEK08YRYRvdzgVR94u2pvwQcyH34Fg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrhXo-002Bdy-5p; Sat, 14 Oct 2023 18:31:16 +0200
Date: Sat, 14 Oct 2023 18:31:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Stitt <justinstitt@google.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: txgbe: replace deprecated strncpy with strscpy
Message-ID: <1c0e94ff-617b-4672-addb-8933f92edc29@lunn.ch>
References: <20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-v1-1-c9bb3270ac98@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-v1-1-c9bb3270ac98@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 09:20:04PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on usage part_str usage within txgbe_read_pba_string(), we expect
> part_str to be NUL-terminated but not necessarily NUL-padded:
> |       /* put a null character on the end of our string */
> |       pba_num[10] = '\0';
> 
> Interestingly, part_str is not used after txgbe_read_pba_string():
> | ...
> |	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
> |	if (err)
> |		strscpy(part_str, "Unknown", sizeof(part_str));
> |
> |	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
> |
> |	return 0;
> |
> |err_remove_phy:
> |	txgbe_remove_phy(txgbe);
> |err_release_hw:
> |	wx_clear_interrupt_scheme(wx);
> |	wx_control_hw(wx, false);
> |err_free_mac_table:
> |	kfree(wx->mac_table);
> |err_pci_release_regions:
> |	pci_release_selected_regions(pdev,
> |				     pci_select_bars(pdev, IORESOURCE_MEM));
> |err_pci_disable_dev:
> |	pci_disable_device(pdev);
> |	return err;
> |}
> ... this means this strncpy (or now strscpy) is probably useless. For
> now, let's make the swap to strscpy() as I am not sure if this is truly
> dead code or not.

Hi Julian

I agree, this looks like dead code.

Jiawen, please could you submit a patch cleaning this up. Either swap
to strscpy() and make use of the string, or delete it all.


    Andrew

---
pw-bot: cr

