Return-Path: <netdev+bounces-163032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838EA293AF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F30A7A3B86
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783618A6D2;
	Wed,  5 Feb 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zINUhAre"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A9158536
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768284; cv=none; b=C9gqe7MrEqD4kicL25NbGxqoUl7WX5GxBzSI8oMUmXbrchr7rRGDh4s8Exu/qgAdIBk3UV7VNOjuVvZzZBRF9ABExifbjHKyOveAcVXYJUQZlWYc6moVnAcuUYNonU8Sn5qOYzj7hdqlxTe74hc6i2749AxEzz4oPPLFhmROeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768284; c=relaxed/simple;
	bh=X6vyEBj3rGnvaxpdxQ2xwXp0G7MbB55eLzI4Gj7bu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i6/3jEZALMC57eKBuDooy69Pw8CpuH79geyo5G1cGW+ZlnE5b0a22WLSOHLWIPGfUKQV22BQYQkGWCGcZGWYUWY6E3iAqpbuLFwIlk5/oR6+O6K1gSaRDTbTgaoq2HZTDraglwgWcD9L7yx6Bp/RLtWVdiIoRR9QQv8t/5c77M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zINUhAre; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=asjGkuilfuFLJnSpoKLSbi0nWNbGb+gg0jInBWQp74k=; b=zINUhAreYraWVOimVGIKsPbkuK
	1KANzkOOeCL74/NExiEa+vl7my11e0x9zwtnsGzpebzdHKGA+WXOTn0wkOkatNUmg0ij6W31nWvBt
	gq2vdE2dzHZ93vCbrLpbTO51Xb9poKCDdLyDx2+gloxxu7CL6FhTsl1X+kqkyTecQb2MHLTHYeMlz
	xW5i/Iarel+jr8dJgSfL5fCl8ltY/HsoGLIZxUV2zdp9vfBNUl+JDvRi9ZycLJNdWoXp/YDPNJkzG
	4SxOIznT57230T2yQPvQb8ygVtwU+w/lK+UuTxM/Z55jt+nTpP4sfvRsyDp9udySnL2gMmCGVS8+p
	8Xh9LmsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41434)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfh3O-0007SW-2X;
	Wed, 05 Feb 2025 15:11:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfh3J-0002Vt-1S;
	Wed, 05 Feb 2025 15:10:57 +0000
Date: Wed, 5 Feb 2025 15:10:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 0/3] net: dsa: add support for phylink managed EEE
Message-ID: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series adds support for phylink managed EEE to DSA, and converts
mt753x to make use of this feature.

Patch 1 implements a helper to indicate whether the MAC LPI operations
are populated (suggested by Vladimir)

Patch 2 makes the necessary changes to the core code - we retain calling
set_mac_eee(), but this method now becomes a way to merely validate the
arguments when using phylink managed EEE rather than performing any
configuration.

Patch 3 converts the mt7530 driver to use phylink managed EEE.

 drivers/net/dsa/mt7530.c  | 69 ++++++++++++++++++++++++++++++++---------------
 drivers/net/phy/phylink.c |  3 +--
 include/linux/phylink.h   | 12 +++++++++
 net/dsa/user.c            | 21 +++++++++------
 4 files changed, 74 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

