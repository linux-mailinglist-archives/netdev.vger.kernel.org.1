Return-Path: <netdev+bounces-42677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E987CFCAC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9281C20AF6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE732194;
	Thu, 19 Oct 2023 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZwkAqxoo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849932188;
	Thu, 19 Oct 2023 14:29:58 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8A182;
	Thu, 19 Oct 2023 07:29:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D976260007;
	Thu, 19 Oct 2023 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697725795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctQqRyF0VKpba4qDoD9bfkE+XzRdvDu4EZKoEFJZ5Y8=;
	b=ZwkAqxooU+fvld0S9DTZQdLs/SHO4YlQHDJ17vJfZE9XulwB7WkLfItcN6kO174entp4hr
	reDx7Pur2OHObXNdshmTQ4j9ZzhNcFes9XPLG2L6y9PpTJdVvlPPMQAWwLsOPqQuByG618
	jCquTcIUWMrts0Jp0ei1Rad0B1OaV+83XV2NPg/py19RXqpnDmn1Nj2s9AYEQBLAxIafd+
	hcUl+IcEPy2qaE3XNxtOH5FIeLTq+/NHfz/6NU6nWGKQgJ4IdqD3FtRcb66Q1rA13OsIaj
	EnXDMe27K9wolTH5J2L7Tujpj07ZNQiosGSRouwN/b8Ok4AsTzjA2OLXCNVfFA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 19 Oct 2023 16:29:26 +0200
Subject: [PATCH net-next v6 11/16] netlink: specs: Introduce new netlink
 command to list available time stamping layers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231019-feature_ptp_netnext-v6-11-71affc27b0e5@bootlin.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
In-Reply-To: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
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
X-Mailer: b4 0.12.3
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


