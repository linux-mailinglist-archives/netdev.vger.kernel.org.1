Return-Path: <netdev+bounces-32401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987747973F2
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536732816B3
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410A12B71;
	Thu,  7 Sep 2023 15:35:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865629B4
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:35:00 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7411A8;
	Thu,  7 Sep 2023 08:34:28 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7D7CDD6781;
	Thu,  7 Sep 2023 09:24:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6E1140032;
	Thu,  7 Sep 2023 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694078660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=da+6NJOJEm++PNss5/CyJhpocrTl9IbiBTOkyc0NiIU=;
	b=D0xm9lzpjQN6rJaPPDGdOkBud3WdI0MIuYRbaLyVf5gp172r+LKVbuWciVT4M/JyuowyO6
	vD/nTBVDCAnfLiqAn3VwquNxtIW1CGcVGSihG6AS/+rCew0l4SkNe2RrUaMnfwvVs47W4D
	yYybwNxT84Pw9OSEGIjvu9Ll9uEqxo5hg1uWjaHlo3nuY9/0eq7Xy9pFGgNLsNV0VdP7SM
	LDj5KyXstKCg5XgEbIuIjveeOWb7wBdoKRgx3n3LXfhBDBKv3QryU7dMcn2AFr58yW3OfZ
	Lg1xHroyNPE2rZIe73zTtSzCaGwYTa8RDP3FREM7WdvV1Vd/C6uHxH+0tT5Yfw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH net-next 5/7] netlink: specs: add phy_list command
Date: Thu,  7 Sep 2023 11:24:03 +0200
Message-ID: <20230907092407.647139-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new command allowing to list PHYs that are present on a
netdevice's link. The list is an array of phyindex, per-netdevice unique
numbers that describe a PHY device.

Example messages :

 - No PHY on the link (Pure SFP interface) :

./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
	 --do phy-list-get --json '{"header" : {"dev-name" : "eth3"}}'
{'header': {'dev-index': 5, 'dev-name': 'eth3'}, 'phy-count': 0}

 - One PHY on the link :

./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
         --do phy-list-get --json '{"header" : {"dev-name" : "eth2"}}'
{'header': {'dev-index': 4, 'dev-name': 'eth2'},
 'phy-count': 1,
 'phy-indices': b'\x01\x00\x00\x00'}

 - 2 PHYs on the link (MAC - PHY - SFP[PHY]) :

./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
         --do phy-list-get --json '{"header" : {"dev-name" : "eth0"}}'
{'header': {'dev-index': 2, 'dev-name': 'eth0'},
 'phy-count': 2,
 'phy-indices': b'\x02\x00\x00\x00\x01\x00\x00\x00'}

This PHY inddices can then be used by other netlink commands that would
target PHYs.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 837b565577ca..1139c88ed65c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -942,6 +942,19 @@ attribute-sets:
       -
         name: burst-tmr
         type: u32
+  -
+    name: phy-list
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: phy-count
+        type: u8
+      -
+        name: phy-indices
+        type: binary
 
 operations:
   enum-model: directional
@@ -1692,3 +1705,18 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: phy-list-get
+      doc: Get list of PHY devices attached to an interface
+
+      attribute-set: phy-list
+
+      do: &phy-list-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - phy-count
+            - phy-indices
-- 
2.41.0


