Return-Path: <netdev+bounces-150699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05AA9EB32A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631DB18860EC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C81B6525;
	Tue, 10 Dec 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AKIWA3cH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B1AE01F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840754; cv=none; b=G5vd6UGAGR18b9Xybr+DT0rMOh4uoVmyoSC8HQlh+7zPTgRGNyJrclzuS+At/RgM91K4HUlNsD1HG7pgXEM//NAyD/hMvfJLpzNiOmu0q1cMWRV9cAZ2oA/BPLp2Hni1UO6xPsqn2LiEAPJwazN5kmFu/OEtuqLUQ7nv6KLq5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840754; c=relaxed/simple;
	bh=wkMR3JVUZOv6bStq/ogKU8sDcr0ZqDYgtXeeY/dtfqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eu7xmyYC4OKNECw2kSIQ9P6EWTXnHYlwnuZqzJNFVZb9z6claX4GDfudsI/ofjkHZHbh0wNgvmmhIXv5QFKhm++GmusqjEP9xMD+PHGjYhwfsd08HXl12ateV00j06XYhxreG0i8LiPN0FxQmbEJ1FLC2UxO7A6rEGyXgFPnEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AKIWA3cH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8klcd2PAM522x3dWqvo2Lw2BOKlGeDiAINFPDg9PijQ=; b=AKIWA3cHAUv09CeSmnBR2eySzp
	YF1KfKzMVajmck8k9ZeiReT8HhnoC025faSkwc5THR9P84IJNXkCg2B9WDt6CBYbBhkUUfI1LeJhc
	ppBamZp+TNAbaUKpG10qtunU17YXUuWPZq/OKCUfnG/2xrbNFJkXv1jj0BaZZQYx30I3xj0/6YiBo
	Gu/P/CFirruV7URNUV6XfQwmik0794wv8a2kMhX5xTYCi4OU5X5hesdZNfO9ON+S/Q/HOYvC+RUKc
	PxjWGHDIBSFnM6i9B5Sk63boVFQ693W5YAHJWqBcEXLU5u/shVPjumEWfzihSh3PkCajOMxWDTVMl
	ya+cX/2Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58926)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tL1BK-0002X3-2V;
	Tue, 10 Dec 2024 14:25:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tL1BJ-000323-0O;
	Tue, 10 Dec 2024 14:25:45 +0000
Date: Tue, 10 Dec 2024 14:25:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 0/7] net: dsa: cleanup EEE (part 2)
Message-ID: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This is part 2 of the DSA EEE cleanups, and is being sent out becaues it
is relevant for the review of part 1, but would make part 1 too large.

Patch 1 removes the useless setting of tx_lpi parameters in the
ksz driver.

Patch 2 removes the DSA core code that calls the get_mac_eee() operation.
This needs to be done before removing the implementations because doing
otherwise would cause dsa_user_get_eee() to return -EOPNOTSUPP.

Patches 3..6 remove the trivial get_mac_eee() implementations from DSA
drivers.

Patch 7 finally removes the get_mac_eee() method from struct
dsa_switch_ops.

For part 2:

 drivers/net/dsa/b53/b53_common.c       |  7 -------
 drivers/net/dsa/b53/b53_priv.h         |  1 -
 drivers/net/dsa/bcm_sf2.c              |  1 -
 drivers/net/dsa/microchip/ksz_common.c | 15 ---------------
 drivers/net/dsa/mv88e6xxx/chip.c       |  8 --------
 drivers/net/dsa/qca/qca8k-8xxx.c       |  1 -
 drivers/net/dsa/qca/qca8k-common.c     |  7 -------
 drivers/net/dsa/qca/qca8k.h            |  1 -
 include/net/dsa.h                      |  2 --
 net/dsa/user.c                         | 12 ------------
 10 files changed, 55 deletions(-)

For part 1 and part 2 combined results in a net reduction of 33 LOC:

 drivers/net/dsa/b53/b53_common.c       | 14 ++++----------
 drivers/net/dsa/b53/b53_priv.h         |  2 +-
 drivers/net/dsa/bcm_sf2.c              |  2 +-
 drivers/net/dsa/microchip/ksz_common.c | 35 +++++-----------------------------
 drivers/net/dsa/mt7530.c               |  1 +
 drivers/net/dsa/mv88e6xxx/chip.c       |  9 +--------
 drivers/net/dsa/qca/qca8k-8xxx.c       |  2 +-
 drivers/net/dsa/qca/qca8k-common.c     |  7 -------
 drivers/net/dsa/qca/qca8k.h            |  1 -
 include/net/dsa.h                      |  4 ++--
 net/dsa/port.c                         | 16 ++++++++++++++++
 net/dsa/user.c                         | 18 +++++++----------
 12 files changed, 39 insertions(+), 72 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

