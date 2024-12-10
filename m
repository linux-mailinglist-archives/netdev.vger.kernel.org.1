Return-Path: <netdev+bounces-150688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3A9EB2F8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D8328505A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD511AD5D8;
	Tue, 10 Dec 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nd+65dSk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE61AB533
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840297; cv=none; b=GqFRZlOXBjPCNS4qfDhHkmqMefLaWTUzu2nbye9rOPZvVrONCe9q+AWyAilDlRXoZS8GvnahgQURc4CAfjivklsbbW0f8uRuQjshPug1uKyv2zYI6MdGyQgwAtIOw5v9Sch6uNC99469BepJoM3E3471y1UJHI8x9VUxRuUBwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840297; c=relaxed/simple;
	bh=XHiDIK8bSZFZbia4YoXHH5zW1+QO4g2SOw1E/vMszAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hs71cz5I31L9Z5hkD6LFqEWYj9TsylC4K/wJiWxZECJE5bmVSSTzPKufKqEleTkZt9wAJVG3CgUE4erBnwHAgyLbrq81LoHBI7hkZoaf8WnHNRi9UcFd/QZRtmtQilTLwgIagI5DQXNXw5kcUDfS/c1MoofUTwKvy8ZeO2qtz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nd+65dSk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E1k1NKAG0VAHn8y+herauQKsleTkHdP588nI/DUPH50=; b=nd+65dSkyWy+Hb9E/SJk7+8tXl
	E1WpfAUxa077/fD+yAFuIYs+J8Uqy0tXl1tvktTwvOghB/xgZMht3SH6XTx5BeaVp6XAZ9J3i9RR8
	xuDRfcUJ1yV7igrOxM6swWEoyet/VP4OGdyRl8Vab0s/zx/pMcf4w+eaiS7+9rwe1hQjMudZvZV1G
	3yqNLrJphwPaQyQ63t92mhzDBDNkB4lzTEX/QR1VsJBFOkaER3xj5/r0xBUUbn9eF4ss8J3KHs2xz
	l59TafXWPoiFG0X2Zsf7Gtp8LD+Dkpg5AedIz/rd285jcX1xHwAIffrpdkWOsm3pwtml8bBksFvA6
	pQsMwcPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40906)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tL13l-0002SM-2n;
	Tue, 10 Dec 2024 14:17:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tL13g-00031q-2T;
	Tue, 10 Dec 2024 14:17:52 +0000
Date: Tue, 10 Dec 2024 14:17:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 0/9] net: dsa: cleanup EEE (part 1)
Message-ID: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
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

First part of DSA EEE cleanups.

Patch 1 removes a useless test that is always false. dp->pl will always
be set for user ports, so !dp->pl in the EEE methods will always be
false.

Patch 2 adds support for a new DSA support_eee() method, which tells
DSA whether the DSA driver supports EEE, and thus whether the ethtool
set_eee() and get_eee() methods should return -EOPNOTSUPP.

Patch 3 adds a trivial implementation for this new method which
indicates that EEE is supported.

Patches 4..8 adds implementations for .supports_eee() to all drivers
that support EEE in some form.

Patch 9 switches the core DSA code to require a .supports_eee()
implementation if DSA is supported. Any DSA driver that doesn't
implement this method after this patch will not support the ethtool
EEE methods.

Part 2 will remove the (now) useless .get_mac_eee() DSA operation.

 drivers/net/dsa/b53/b53_common.c       | 13 +++++++------
 drivers/net/dsa/b53/b53_priv.h         |  1 +
 drivers/net/dsa/bcm_sf2.c              |  1 +
 drivers/net/dsa/microchip/ksz_common.c | 20 +++++---------------
 drivers/net/dsa/mt7530.c               |  1 +
 drivers/net/dsa/mv88e6xxx/chip.c       |  1 +
 drivers/net/dsa/qca/qca8k-8xxx.c       |  1 +
 include/net/dsa.h                      |  2 ++
 net/dsa/port.c                         | 16 ++++++++++++++++
 net/dsa/user.c                         | 12 ++++++++++--
 10 files changed, 45 insertions(+), 23 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

