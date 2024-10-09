Return-Path: <netdev+bounces-133583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660E99665C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6A7B2573A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980418C900;
	Wed,  9 Oct 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HyM3Rd6K"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D915382F;
	Wed,  9 Oct 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468139; cv=none; b=jOMMqMZQ7/ydVonsMLiy43ZVOWpItOX2M1qh4hpDRp0X7f/kj8XkyoHoe1xVFTPN5THkDkO5h/41toD0Bpuxa109en9M05DtQlHPdyBiMXpJCHzn+LmX70IPjiwUFNUrnLb9muOdUvze9jdRScqIZqFLwaEl0nXkCugnFkybib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468139; c=relaxed/simple;
	bh=fFhZ5yj/ZxR2o5xfilsh66lO0PAntRJA0HDbYd4k/h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGblAB6+mnqW01vgNzXfbOaEmcJ2sweiWE8YpgMn/GUbHeF5igX/eiit4d/PoKUtpPXIz7keMxZQBftHsapEMfAsnfiHolztncBeguePRfJJbOLATVeFvFZ1K1R61Ta5qKEWrX0jPCpKH5WX0OVqs6EMpPEtoKgPLY/Rf3rYKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HyM3Rd6K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ueEdb1+ly/wSFqjFR74BysYq/bPJvI7Xo0vEBOm9Eg0=; b=HyM3Rd6KES4FjeuJXXYLocsAfP
	yjWruA+frfcaZ0yqLpl7DHuwJRSKAWOmFDYJeEkwdrGLNWaJpc3zoiRTYWOXxDmqJXkBH768vbsql
	9Tb4Td53RgyuTgYH9EhdTwe+Gg1ZRaHlcdOIr/gLwuhMFBsUyWykAaevuc5cEXt9VTmzIDG5Edpep
	3lgorpmU/2XqdJkxDdoKH1zHbuS5F8f57s5kyMwrdZmjpgHCEul391wBp4nk9Kkwesnx2VqbcWP4y
	JXH/nSH3OQjWSJ6/8tEnElB//8e8bT1KEgb3T5N4GuSDQZX2VRC810n9ePNTFcIGmCU1ScdJQSZJX
	NHoalZYA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35924)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syTW8-0000Kd-2R;
	Wed, 09 Oct 2024 11:02:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syTW4-0006CI-0d;
	Wed, 09 Oct 2024 11:02:00 +0100
Date: Wed, 9 Oct 2024 11:01:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: realtek: read duplex and gbit
 master from PHYSR register
Message-ID: <ZwZUl1jG0bc2q8Le@shell.armlinux.org.uk>
References: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 02:53:03AM +0100, Daniel Golle wrote:
> -static void rtlgen_decode_speed(struct phy_device *phydev, int val)
> +static void rtlgen_decode_physr(struct phy_device *phydev, int val)
>  {
> -	switch (val & RTLGEN_SPEED_MASK) {
> +	/* bit 2
> +	 * 0: Link not OK
> +	 * 1: Link OK
> +	 */
> +	phydev->link = !!(val & RTL_VND2_PHYSR_LINK);

Be careful with this. The link status bit in the BMSR is latched-low,
meaning that it guarantees to inform the reader that the link failed at
some point between the preceding read and current read.

This is important to know, so code can react to a possibly different
negotiation result (we must see a link-fail to recognise a different
set of negotiation results.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

