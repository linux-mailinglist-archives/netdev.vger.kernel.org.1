Return-Path: <netdev+bounces-163970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E35A2C346
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C189166E4B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EE1E1A33;
	Fri,  7 Feb 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dR2rJva/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A887FD
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933755; cv=none; b=d1DjW4aichRlAm84d58LkTtK76kULPFDzCHOz+PQIf3eEesKskRFfwQnxX/mFa7mKrmVVNqst8kw8uhli9ozxUDApbQPsDby81vzw4hKw4RnZgeCo6wqOjckhbfNc9gZZELn3GaW9nMshnizZh/qLudHBuoqjr1NV7ijlvmt83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933755; c=relaxed/simple;
	bh=7Rm+pBEtcMX5wEEfGdYLaX1AHnHPmMjBAUawoNiT3ik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QiUtmuDxumM38Rql7fYyQZggYPH4e/tGCI69SrZrUbkz0KYZsfOeMkWrr4pc4wtreyWG45HHJlfN+DJibjkbhxqh4/bF+n5GnZQjv3v0i10JT4QoJ6HuhWY+Q57CQeaqS7gJE8Tk7NXCTrovryvhKzlvhQhm5GkuCJFi3FxPgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dR2rJva/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T4RI4nX9+gSCb65G1EaTQtd7vTXqjAhlRZ71a0d/Fho=; b=dR2rJva/ceVGAF2nIpm+KjWRMj
	52PJ0R4PPoRZ+3WJwmEXgvlTI8xzW0nmpzoKQWG14q0NfoqO+QaST1N+RMvmHEYw0bv9mf/NlJaOR
	Wo664Z6lzYpm8e4qmWiZHMoM2zaS6KWb50N0RxWCAQLOnmtKpriXGW7ek7rAvqezgr2yiK2wjgy+f
	yyOiJg4YFISeqWS11YZXeFEN6LM6lux5fj5zyjHdS+JNq93evvQF1lHXOvA/x10V56Nm3aEt10r+Z
	5NXg1dz9Z/m3Z/kqDWeZ2zTYznFw0WjW6QPv9STeea/O+dczD9PqWmpawNvJENzIzCsxtaNXSA8tI
	6+Getf3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tgO6K-0005gr-0H;
	Fri, 07 Feb 2025 13:08:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tgO6E-0004T4-1s;
	Fri, 07 Feb 2025 13:08:50 +0000
Date: Fri, 7 Feb 2025 13:08:50 +0000
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
Subject: [PATCH net-next v2 0/3] net: dsa: add support for phylink managed EEE
Message-ID: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
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

v2: fix mt7530 build error

 drivers/net/dsa/mt7530.c  | 68 ++++++++++++++++++++++++++++++++---------------
 drivers/net/phy/phylink.c |  3 +--
 include/linux/phylink.h   | 12 +++++++++
 net/dsa/user.c            | 21 +++++++++------
 4 files changed, 73 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

