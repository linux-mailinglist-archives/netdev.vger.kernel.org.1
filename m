Return-Path: <netdev+bounces-100998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7E8FCF37
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0846B2E0EE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8911C2226;
	Wed,  5 Jun 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FsPFe1u8"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B71ABE21;
	Wed,  5 Jun 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591781; cv=none; b=htpzAbgxFlN9/1nTH8zT6He+rRb7mrUWEBzI681zGpSTYiZWHBq6AFXuhDHtu+r+m+v/AbF5MdIpCN9hPNlAxg7OoxAf6ICeqteRV2aWKBEVOwXECLFaAR0MZBzUlWiO8fNMwtHSEG0Ov2sr+OqgrFdU2Ntdxd/EjwfqWAB3l/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591781; c=relaxed/simple;
	bh=MOSUved5dJTjsW/e08011rYRD+JJTkhOLjH/Asc2Jlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbF2iBZvSzRchYt4BqXrnKYhEi4xgBKpTUqfQquUH66dCqTjiVvGhdjAzBa9w9A796ttZ8GO4XR3sOXGse12V0x+dx3lAtSbpbSypZ/c5agfx3dJt8rs7qHFAPcpuT4NWRucxjODbQZI3DsoPkFGoa47zVKN/fFQ6pztkAvyfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FsPFe1u8; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 827D72000E;
	Wed,  5 Jun 2024 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717591778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+K5HZ0TX/4jhgoWeL41AioHWepkacjBGpBgmMLrFUY=;
	b=FsPFe1u8uqoHBLcw/33gOq4bfmm1RaqnsDDxZK0Ylhjk3LSzTfsciIfF8h3mG/RKmGbgvP
	DM6ZtKH5dE8cu4IfjnBjXXlyvi3i6Sd+aXzvaJm/4OyeQjkVY8mCKm15rHyBYCahKbm8G3
	DQLeLpoaYqiZFj3hXHsliAl8+lKAQEyHAhsLA85C+rIVPP1dq/wSyWfqSoPLeTG0MX7z7J
	zHDVatlNX4Zx3NKeVDIl6mpjFlPi1Ie37ACBPZQv+RpxFS+crqZhgaJz891o8YKW+qZhOh
	AFcP3PFjICSOzfZ1SJt+xURrr2IAENsJsd9hnBLWIMQN3cADynzc6oogLD4msw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next v12 08/13] netlink: specs: add ethnl PHY_GET command set
Date: Wed,  5 Jun 2024 14:49:13 +0200
Message-ID: <20240605124920.720690-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The PHY_GET command, supporting both DUMP and GET operations, is used to
retrieve the list of PHYs connected to a netdevice, and get topology
information to know where exactly it sits on the physical link.

Add the netlink specs corresponding to that command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 38c2ed0da739..92a89a70ed9e 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -20,6 +20,11 @@ definitions:
     name: header-flags
     type: flags
     entries: [ compact-bitsets, omit-reply, stats ]
+  -
+    name: phy-upstream-type
+    enum-name:
+    type: enum
+    entries: [ mac, phy ]
 
 attribute-sets:
   -
@@ -978,6 +983,38 @@ attribute-sets:
       -
         name: burst-tmr
         type: u32
+  -
+    name: phy
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: index
+        type: u32
+      -
+        name: drvname
+        type: string
+      -
+        name: name
+        type: string
+      -
+        name: upstream-type
+        type: u32
+        enum: phy-upstream-type
+      -
+        name: upstream-index
+        type: u32
+      -
+        name: upstream-sfp-name
+        type: string
+      -
+        name: downstream-sfp-name
+        type: string
+      -
+        name: id
+        type: u32
 
 operations:
   enum-model: directional
@@ -1733,3 +1770,25 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: phy-get
+      doc: Get PHY devices attached to an interface
+
+      attribute-set: phy
+
+      do: &phy-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - index
+            - drvname
+            - name
+            - upstream-type
+            - upstream-index
+            - upstream-sfp-name
+            - downstream-sfp-name
+            - id
+      dump: *phy-get-op
-- 
2.45.1


