Return-Path: <netdev+bounces-144972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D486C9C8FA8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFA2B3C1F7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51C1B0F17;
	Thu, 14 Nov 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uaBedl8H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B425150997;
	Thu, 14 Nov 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598695; cv=none; b=mdo4otjB/x1UFi2dZJpGVrf0FSb24SCVb6ADOiErsl6hFMxSdkV5LvIOiC5ED/UdfxQD1w6ojdF+2bizvszV0nyyyPVsItUW+rrA+iQreU5bfEj6CUtDLJu3OhDuR9/s+axOorkEDD5gy/uijmZDDLFcFXFEU/S9DJ0+0C1ulzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598695; c=relaxed/simple;
	bh=mlAXRAgMve6+f/4rnGWaWmCnOK8cUZsS6OQ6L22iv7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZqeaj2SDhOBB55/0RQpdncL3kthqtfl3KCKo9JHz8pOErSeL+66rMTyV9pFFVPfzJ4XJ+8Alqe7Qo9eKFF6z6ZVGw6ASQ1ceBk1FXmS+OmqjPgoA2XNtn0kF5hrsDzF4EMCIYvGeqfvZrxwm+KW7ebOaYD8tVbLm+PrbITTWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uaBedl8H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FNMWD0/TBlzi7ZB1FB7EAN9VcYluVvAfBP4VmUMbiC8=; b=uaBedl8HRP4sqxCNN4VErMwkyu
	T79AvEg+S6PYzlhTobsS3EFfw4mWPjqN02RRHtb3Ww/1xhhpOZQNA0I7UBTuGQlBTMBPsXN94TJ1h
	tXWeTw9k+GzIq4a9QrQMThecdgdsFfToZK+lAaG1eD7gWA9CHuWnNSSVE43sZ/9zd6g8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBbv6-00DJZ7-3J; Thu, 14 Nov 2024 16:38:08 +0100
Date: Thu, 14 Nov 2024 16:38:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net 1/4] rtase: Refactor the
 rtase_check_mac_version_valid() function
Message-ID: <2fac05ba-7766-4586-8676-e30f09cd2d09@lunn.ch>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
 <20241114111443.375649-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114111443.375649-2-justinlai0215@realtek.com>

On Thu, Nov 14, 2024 at 07:14:40PM +0800, Justin Lai wrote:
> 1. Sets tp->hw_ver.
> 2. Changes the return type from bool to int.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 21 +++++++++++--------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> index 583c33930f88..547c71937b01 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -327,6 +327,8 @@ struct rtase_private {
>  	u16 int_nums;
>  	u16 tx_int_mit;
>  	u16 rx_int_mit;
> +
> +	u32 hw_ver;
>  };
>  
>  #define RTASE_LSO_64K 64000
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index f8777b7663d3..33808afd588d 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1972,20 +1972,21 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
>  	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
>  }
>  
> -static bool rtase_check_mac_version_valid(struct rtase_private *tp)
> +static int rtase_check_mac_version_valid(struct rtase_private *tp)
>  {
> -	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
> -	bool known_ver = false;
> +	int ret = -ENODEV;
>  
> -	switch (hw_ver) {
> +	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
> +
> +	switch (tp->hw_ver) {
>  	case 0x00800000:
>  	case 0x04000000:
>  	case 0x04800000:

Since these magic numbers are being used in more places, please add
some #define with sensible names.

> -	if (!rtase_check_mac_version_valid(tp))
> -		return dev_err_probe(&pdev->dev, -ENODEV,
> -				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
> +	ret = rtase_check_mac_version_valid(tp);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev,
> +			"unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
> +	}

Since you are changing this, maybe include the hw_ver?

	Andrew

