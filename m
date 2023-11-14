Return-Path: <netdev+bounces-47672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73A7EAF13
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB691C20AC7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08F3FB32;
	Tue, 14 Nov 2023 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWf88vpf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115433FB14;
	Tue, 14 Nov 2023 11:29:15 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD181171A;
	Tue, 14 Nov 2023 03:29:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15F8C60006;
	Tue, 14 Nov 2023 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699961344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+SY8AKnRFrNOxgVIzZVyhyhuZrxEQtFskw3kq2cJaM=;
	b=lWf88vpftvGUGvU6lZvAPaIUeayDQzIwOFLsDEwKw4Mp/CSeCsLsO2NV45nZ7llBj1OXJp
	/EyclrBAdU8ojAOn8I3H/n06jIy0BNzx6+bGwuXmCxdSJCGF5gfx+rDc1sC1RwxCvgsw6a
	k8TrYnIgy7jZqBUNS3VkppBPFZBN5zv+MuxoIY+ztQM+F3AjPZ1CX1sXJCAIiIo4bfJ9m9
	sTm5UwUGdowfanQBZkn9Sau3//uYJeXJtLKd1qCChR0IgK6YL98MOgOXzyccOsFEe5e0iQ
	wTxsrnEDkdfqyrdRRzDUkGuUAvEq6eOgrpCSZZCE5OebMlwSHIRgXqlx6mg63g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 12:28:39 +0100
Subject: [PATCH net-next v7 11/16] netlink: specs: Introduce new netlink
 command to list available time stamping layers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-11-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

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
index 61b30701fdad..591425f7fa76 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -949,6 +949,16 @@ attribute-sets:
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
@@ -1713,3 +1723,17 @@ operations:
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


