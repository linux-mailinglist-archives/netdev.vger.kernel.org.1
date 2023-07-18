Return-Path: <netdev+bounces-18618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE719757FEC
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352A91C20D5D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE018D518;
	Tue, 18 Jul 2023 14:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A25FBEE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:44:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542861722
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MyjuQFFOSVWNImy1ViiZvdVe63Pg+kRcLzQofizjbro=; b=5aLF05vQVMzFJERHw3d/DNAO3Z
	VxShcBwV8YFQFCICbiVOWuUruJkujdXC9tPwPvvBWRKrSXqYZUDFOhOWLzX9pqvOO0o9l1Zh4xENY
	8CavWr53dmgHlMsUpzJcqnJs/n5ae5aOraBAZlEF0N1kQnKL/n6PECyY29HNKH/7nat8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLlvT-001dId-I3; Tue, 18 Jul 2023 16:43:43 +0200
Date: Tue, 18 Jul 2023 16:43:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: core: add member ncsi_enabled to
 net_device
Message-ID: <7f0107c6-ce31-4e1b-aad5-e7b21cdf0be3@lunn.ch>
References: <E807CF57548EE44C+20230718022057.30806-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E807CF57548EE44C+20230718022057.30806-1-mengyuanlou@net-swift.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 10:20:57AM +0800, Mengyuan Lou wrote:
> Add flag ncsi_enabled to struct net_device indicating whether
> NCSI is enabled. Phy_suspend() will use it to decide whether PHY
> can be suspended or not.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/phy/phy_device.c | 4 +++-
>  include/linux/netdevice.h    | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2cad9cc3f6b8..6587b35071e9 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1859,7 +1859,9 @@ int phy_suspend(struct phy_device *phydev)
>  		return 0;
>  
>  	phy_ethtool_get_wol(phydev, &wol);
> -	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
> +	phydev->wol_enabled = wol.wolopts ||
> +			      (netdev && netdev->wol_enabled) ||
> +			      (netdev && netdev->ncsi_enabled);

I don't really like this. phydev->wol_enabled no longer means
wol_enabled. Please rename phydev->wol_enabled to indicate that the
PHY should not be suspended because it is being used for something.

>  	/* If the device has WOL enabled, we cannot suspend the PHY */
>  	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
>  		return -EBUSY;

This comment also needs updating.

     Andrew

