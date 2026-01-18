Return-Path: <netdev+bounces-250798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC88D3929B
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 466CE300387F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BE30EF8C;
	Sun, 18 Jan 2026 03:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE530EF83;
	Sun, 18 Jan 2026 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768707960; cv=none; b=aXPWR6tlOQLXv2Q5c5LKQUQEcygLNf4g2kzV30f47458PRENkTLZuyWTQ0PVv2VvF1pc5bqzOoeNOPN9kH3B88bQs4IEZ8VdHq7/T3oCIvyEPH/zefdt52IJziEGXnQOK1PddUieu6CbqM2m63KnQ1LDapjMA6ukrtwxQ/L2JAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768707960; c=relaxed/simple;
	bh=56wMgwDUmz+bOJFXmg2DSTGleTUg5iDCDOvS9I3yOaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTa4dFiULKDd4uI96EoDmA5gexuNfI61M+SKg87Zwp4IbDOOZMGsg4Zth72vZlorY+zNqhlk7NCiinVcoQHgeTUYoo0Vy/tsKIKkfjMomDkAQKx4/0Mgsu0/7c+pNCHKsP/Rnfd/hwGF0fWiBXid2a8mcvDKofnBIyAFS+aXYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJjf-000000000kO-0kqr;
	Sun, 18 Jan 2026 03:45:55 +0000
Date: Sun, 18 Jan 2026 03:45:46 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH v7 net-next 3/4] net: mdio: add unlocked mdiodev C45 bus
 accessors
Message-ID: <b14a86ea58c7f8b26ebcc2fb789dede3dfd7dad8.1768707226.git.daniel@makrotopia.org>
References: <cover.1768707226.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768707226.git.daniel@makrotopia.org>

Add helper inline functions __mdiodev_c45_read() and
__mdiodev_c45_write(), which are the C45 equivalents of the existing
__mdiodev_read() and __mdiodev_write() added by commit e6a45700e7e1
("net: mdio: add unlocked mdiobus and mdiodev bus accessors")

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: no changes
v6: no changes
v5: fix indentation
RFC v4: no changes
RFC v3: no changes
RFC v2: add this patch, initial submission
---
 include/linux/mdio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 42d6d47e445b7..52d94b8ae371e 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -648,6 +648,19 @@ static inline int mdiodev_modify_changed(struct mdio_device *mdiodev,
 				      mask, set);
 }
 
+static inline int __mdiodev_c45_read(struct mdio_device *mdiodev, int devad,
+				     u16 regnum)
+{
+	return __mdiobus_c45_read(mdiodev->bus, mdiodev->addr, devad, regnum);
+}
+
+static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
+				      u16 regnum, u16 val)
+{
+	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
+				   val);
+}
+
 static inline int mdiodev_c45_modify(struct mdio_device *mdiodev, int devad,
 				     u32 regnum, u16 mask, u16 set)
 {
-- 
2.52.0

