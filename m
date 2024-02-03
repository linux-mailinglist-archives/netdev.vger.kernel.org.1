Return-Path: <netdev+bounces-68867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B78488FD
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211E3B23E33
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADC11714;
	Sat,  3 Feb 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dyg95770"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBD11721
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706996035; cv=none; b=oLsFZ9zl0yORCDy1cjwt/SjvlEfoyTK+EfJxZtGwUGL4yhbe/Z4EiqxuNfxpHiRgRf9zuG1Vy7snExEp1B7ZIUY+zdHWHjctLWMsymootDPcs9F8dS+DiJDg4pFVKW8kI/e7AGqxa08ECWLThHuU1AlipyCNAr4RxYmVfeOSTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706996035; c=relaxed/simple;
	bh=HvCBQVLGnJhhdsZNQb1CR58eM7ldTgAY/BiNv0yhFX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYx3dctS+3ttbclzC87oeFLgk1CLpht5AibLCouTIU/a0/YrXRIBa8NQNY+6HyI4BxmffMM1GweeWfXVocQBVWO2NgTmJjnnFpRyUMBFx+rsFbImsrH22dFLa9uPjo1v/TNkLW5rBLJCubgERpgmy7GYb3/uF3aUkBjTAs+acE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dyg95770; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0PUweqmyfu39Pl04pTqkgBuH6ihtzFxPtpRWFFfXTzg=; b=dyg95770286oFniDPBV5qPw7Jo
	86hVdmESMKk1xKRDIiBBCZ52Mzlrcm8qa5hUk05PcaD9Ver9YzkmSHjp5B33o8wtiTiP8EFyLExax
	UAAklWtYNheTVWOi/ATdNUw6mKf1auYYAS0KK16GE7i3UJGKKKN6F7161IOH/3hQRDQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWNdw-006vZK-Ci; Sat, 03 Feb 2024 22:33:44 +0100
Date: Sat, 3 Feb 2024 22:33:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bnx2x: convert EEE handling to use linkmode
 bitmaps
Message-ID: <f87eac1a-0f75-44d1-a52c-1ad15b0ccd59@lunn.ch>
References: <ca984f60-b08a-42d8-a127-13572190d155@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca984f60-b08a-42d8-a127-13572190d155@gmail.com>

On Sat, Feb 03, 2024 at 10:19:43PM +0100, Heiner Kallweit wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for
> removing the legacy bitmaps from struct ethtool_keee.
> No functional change intended.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 45 +++++++++----------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> index 5f0e1759d..0672188bc 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> @@ -2081,28 +2081,26 @@ static const char bnx2x_private_arr[BNX2X_PRI_FLAG_LEN][ETH_GSTRING_LEN] = {
>  	"Storage only interface"
>  };
>  
> -static u32 bnx2x_eee_to_adv(u32 eee_adv)
> +static void bnx2x_eee_to_linkmode(unsigned long *mode, u32 eee_adv)
>  {
> -	u32 modes = 0;
> -
> +	linkmode_zero(mode);

While i agree this is a straight translation, i don't think it is
needed. bnx2x_eee_to_adv() is only called from bnx2x_get_eee() and the
ethtool core will already of zeroed all the fields.

Apart from that

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

