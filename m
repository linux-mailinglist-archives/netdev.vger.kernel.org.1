Return-Path: <netdev+bounces-39221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B47BE57C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776B4281E88
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1312637C82;
	Mon,  9 Oct 2023 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="flLpiW9H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91535898
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:52:30 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79711F;
	Mon,  9 Oct 2023 08:52:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4785A1C0012;
	Mon,  9 Oct 2023 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696866738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiv+yxDSpeeBqHfOwRUQw3mS7Lf3CBbyGOYxIaD7WCE=;
	b=flLpiW9HxWrEEDJ3VIZB37TnzkKrjuWnVmK6tZ2Gb0w6wDpRpRSF3sEndafzvcQuVOmlRC
	hEKNJdrLeYWBSfbBiXX41cPeNyaN/RAzS6+Ljxv9NKPxXJWJN73kSoDL2chMfqMKVkIZM+
	EwbQdtWes55EaDgUxRZyxoFGV7SJqZkn4fPL/FJzNQsL9JCLQsfNuoybXSpHYQLAY265LD
	5gFIodeY3uiubSzmSzaeowfU4PWwaLz1i3/ynePtC0brzvAzyu3VN14eg6FzWJC4CrCHoP
	+4nzddMNDP2+8px2jTy3wbAtjEQ1vUSxrg55QfMms59aH8B1i0PgeJ6gbGLMWg==
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
Subject: [PATCH net-next v5 09/16] netlink: specs: Introduce new netlink command to get current timestamp
Date: Mon,  9 Oct 2023 17:51:31 +0200
Message-Id: <20231009155138.86458-10-kory.maincent@bootlin.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kory Maincent <kory.maincent@bootlin.com>

Add a new commands allowing to get the current time stamping on a
netdevice's link.

Example usage :
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do ts-get \
	     --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'}, 'ts-layer': 1}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 837b565577ca..49ee028e97ca 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -942,6 +942,16 @@ attribute-sets:
       -
         name: burst-tmr
         type: u32
+  -
+    name: ts
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: ts-layer
+        type: u32
 
 operations:
   enum-model: directional
@@ -1692,3 +1702,17 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: ts-get
+      doc: Get current timestamp
+
+      attribute-set: ts
+
+      do:
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &ts
+            - header
+            - ts-layer
-- 
2.25.1


