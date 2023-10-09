Return-Path: <netdev+bounces-39224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE67BE581
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40318281B1A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1B37C84;
	Mon,  9 Oct 2023 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JjlwVlqY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D337CA1
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:52:36 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40A1A3;
	Mon,  9 Oct 2023 08:52:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2ED11C000C;
	Mon,  9 Oct 2023 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696866746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNVv7aXW4R7kMn/Y3UYMw4xmcy2L8JPMN/pu3cSuY3s=;
	b=JjlwVlqY62tsqrxerlPjaYNBSUO/s2YW9hVsPmrHUS2t5FPVwdtp6Gn2F0bnn002sdbX+m
	QsrZNFrpxVJneMTAuaO7lL5Wclo2wQCfl123smr01R1PGWxBv1zM/WWTR5lh545hx10/OY
	d7WFEjOeRgpEAwMaXsDhNKVZrkVAaOVMoouA6z704JeJrpIVL+TTK8eUp9JVYIIPw2jL7F
	8ne0Zb87q04AMjAVz2gvGpCjjaWrvyWNIVvkOgy8qnf9xdtashqfR8dabEQHR6G7uGelW6
	pxQAyPw3Ql6JPFztGPxQ32ezr+9o8+PF/FyYYk3yc9IwIXyJB021OzEJ9btAgQ==
From: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <michael@walle.cc>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 11/16] netlink: specs: Introduce new netlink command to list available time stamping layers
Date: Mon,  9 Oct 2023 17:51:33 +0200
Message-Id: <20231009155138.86458-12-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kory Maincent <kory.maincent@bootlin.com>

Add a new commands allowing to list available time stamping layers on a
netdevice's link.

Example usage :
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema \
	     --do ts-list-get \
	     --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'ts-list-layer': b'\x01\x00\x00\x00\x05\x00\x00\x00'}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 49ee028e97ca..81ed8e5f2f55 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -952,6 +952,16 @@ attribute-sets:
       -
         name: ts-layer
         type: u32
+  -
+    name: ts-list
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: ts-list-layer
+        type: binary
 
 operations:
   enum-model: directional
@@ -1716,3 +1726,17 @@ operations:
           attributes: &ts
             - header
             - ts-layer
+    -
+      name: ts-list-get
+      doc: Get list of timestamp devices available on an interface
+
+      attribute-set: ts-list
+
+      do:
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - ts-list-layer
-- 
2.25.1


