Return-Path: <netdev+bounces-244656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7476FCBC22B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 01:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2EBF300D429
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C6218ACC;
	Mon, 15 Dec 2025 00:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA02116F4;
	Mon, 15 Dec 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765757532; cv=none; b=j1LSXBw9ji7PeAbEPqyyHezkQY3Oz9Vq5o5nOTIBTYGru23oLJAmdx0ssxv9zSSkB93WUA61nVVrBhlw0mbx9gh4MV5oa1GXO5P9qPCTTzKjKBCdw6cew6Vmmui6S4uaO6zNTAEZULPJ4c5gGvrb4G2nWi1fG6mxRRlGhNHhliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765757532; c=relaxed/simple;
	bh=1z7+7/ORHzgA02BlWk4B1jV2aWOw1+YuttbSVMYHGi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgUTCRoU3Ndqp4Q84jMUxKts2VrjxptT8NehoC2bgFrE9R4SkZRlGVLZqT81p0Z/Zy5+hiIZIqijQExP6nDNRQ+eSj3SJ3KWSVPe9uYkJO8p3JvZbOnMBH7S0DvCLvfP87B1JwtnKqBIjjnnBu0J93AiUhwnjjcEloT8zPyEnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vUwC5-000000002Jp-1afR;
	Mon, 15 Dec 2025 00:12:05 +0000
Date: Mon, 15 Dec 2025 00:12:01 +0000
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
Subject: [PATCH RFC net-next v3 3/4] net: mdio: add unlocked mdiodev C45 bus
 accessors
Message-ID: <552e004f6919e0dac90c9edc83120b84085309df.1765757027.git.daniel@makrotopia.org>
References: <cover.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765757027.git.daniel@makrotopia.org>

Add helper inline functions __mdiodev_c45_read() and
__mdiodev_c45_write(), which are the C45 equivalents of the existing
__mdiodev_read() and __mdiodev_write() added by commit e6a45700e7e1
("net: mdio: add unlocked mdiobus and mdiodev bus accessors")

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
RFC v3: no changes
RFC v2: add this patch, initial submission

 include/linux/mdio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 42d6d47e445b7..f39b4dba5cd4f 100644
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
+				 val);
+}
+
 static inline int mdiodev_c45_modify(struct mdio_device *mdiodev, int devad,
 				     u32 regnum, u16 mask, u16 set)
 {
-- 
2.52.0

