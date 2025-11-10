Return-Path: <netdev+bounces-237358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0018C49772
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53EA18879E2
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A0331A51;
	Mon, 10 Nov 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mdVljZdI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2A2E7F03
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811833; cv=none; b=MEOErvDkMKmKo83bQnw/mJtAql84dXgVxq2jftloePQolgG/cDIrsDnMoC+43AOfdeAwQLJtzQ6fp154dJItVr8HNwK25rvjQdjwxA1HbSAJiHNOzc/isROi4mu4fWQnWVH2Vm0y0xT5BTRcvtpMlBLIRkdfHVUDipN+MP7xeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811833; c=relaxed/simple;
	bh=Xd4yjBfAyJ7WIjueA3uY0bwo3lW8plzFar6f8bGG6V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWyyZ/Z8wQXSYWHam5XfW4/x8GifQRo3uVDqTYcz1lmiAVnefhILuVuHS1DYSH/XY12QDToiVptoPu1oI3ENAM9hFb+T33m3Bxugoaql+sFAThGxGZn+9NQgPoUUk6/MD5VzTb+XwKnGaHTl6Vvikb/DSGveoKpm0SEbr5ZmC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mdVljZdI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MPj5lLILXJm/fFdL+c+qxM1mbap6FqdsVQaAiJwf41A=; b=mdVljZdIzrbRYiwdsEIsecse58
	6Q0fycpZeV2ULG0elO590gA5ZzsZ+aWwbNl8IYyH0qXs05ZhgLGujjPqTlAlbCkrom4mpxINe+OKt
	OWHiZakgvsFaFFYCcgpVJZrnNXGlQsPDJiuAarBgJ5wjq3BTwRdDuZUERYGHeqNgvnJB2ZXNGOsHz
	efWj2pBoN5X273SvVqfilol1LhbGtl1HZRBxAE12KMeRXfg//FNwhGBzAx2H6L/hRxzfdfF8njgo2
	zWlPgk6zmbfPQK5OnsHz2dMlYfY/yI2qOZn8v5xcdVN59p7lKz6mYiNIF1rBaGWhV7tKxC3UP/hti
	J47XWNJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55574)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vIZsm-000000001eZ-023F;
	Mon, 10 Nov 2025 21:57:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vIZsj-000000002KU-3ZWs;
	Mon, 10 Nov 2025 21:57:01 +0000
Date: Mon, 10 Nov 2025 21:57:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: use genphy_read_abilities
 to simplify the code
Message-ID: <aRJfrUQ0hSKETbxp@shell.armlinux.org.uk>
References: <ed9eb89b-8205-4ca3-9182-d7e091972846@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9eb89b-8205-4ca3-9182-d7e091972846@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 10, 2025 at 10:11:24PM +0100, Heiner Kallweit wrote:
> Populating phy->supported can be achieved easier by using
> genphy_read_abilities().

Are you sure about that?

> -	switch (status->speed) {
> -	case SPEED_1000:
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> -				 phy->supported);
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> -				 phy->supported);
> -		fallthrough;
> -	case SPEED_100:
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> -				 phy->supported);
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> -				 phy->supported);
> -		fallthrough;
> -	case SPEED_10:
> -	default:
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> -				 phy->supported);
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> -				 phy->supported);

This code sets both HD and FD for each speed, and if at 1G it sets
100M and 10M as well, if at 100M, it sets 10M as well.

However, swphy emulation (including what was reported through BMSR
and ESTAT) has only ever indicated one speed and duplex supported
via the normal ability bits in these registers. So, "simplifying"
the code introduces user visible changes. This needs to be mentioned
in the commit message.

The next questions are:
1. does this difference matter?
2. is it a bug fix?
3. is swphy wrong?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

