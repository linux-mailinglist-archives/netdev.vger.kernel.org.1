Return-Path: <netdev+bounces-138342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB89ACF85
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1638B2A57A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0E1D0799;
	Wed, 23 Oct 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hDxh8RIm"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC31D0411;
	Wed, 23 Oct 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698597; cv=none; b=LwTE0yc8MCum04ReACssJC195xL4j7MGXMJjYIytrpDzdEicxAfK8f82+kIwPx4zvgNOzbxhaOXduqsiwaFCgiZ6xfkeeQqe3lrQHUSeiQwoZGXP085IDDsoRi8JtvxJkpMYE3te1/0DnTvSdQq1RqzYPdh/hf2iPh55GB0bhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698597; c=relaxed/simple;
	bh=LrsGh3qmzchnmqG2MM3YOk05oabiM6pDWIcBkA50Nxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RoMrdTcwmEedXejcv8Sj7tEWFTeT0fnzF9lfC6YPLsS/VOmcSK71G1qirpm5Gt8Ii7/QaqsgP4+Ea7QnJwQN0Sp2kIs0aCCUBaHY0ca/sVSF1WF0KcDRijyxcXXVyJG6XEPs0ygiE4SNauVrKMs+W6lYz7zqCOl259AM/jbfOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hDxh8RIm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FA0C60009;
	Wed, 23 Oct 2024 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729698593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U981dne136mJZRxylVkDHEeRlMRiiF/+nXZbj0TIeeA=;
	b=hDxh8RImEVnV3cQWPJGzq0FhOiwarKGOfSybqucEUAJ8FfcAWWvB0n7kBTNT7iSrtY/bsi
	6VwB/f1IkYX2RGqUPrllSxS8MdJBR+HT3B+2Qu50zpSIWmrCthhleZQVMl3SfNrPtTpQmR
	lnUD57UQZQvmjoupYqvYVvytCQtpp0YWlLcrSwQbWtxn+tBzO8FYEwHcEvKTOzQ9jEIagC
	veLxceP0IxYtnRKCW66rg9BTlvedUbtCQhpAKIB/FVPfATcp0lcoEMdKDQlD3VVqiMRlre
	kJX9jDdBFg8ibXI2632rpM7IcJPg4asmyD+IwI3k9fdenwpCj+saeQLxZd6pCg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 23 Oct 2024 17:49:20 +0200
Subject: [PATCH net-next v18 10/10] netlink: specs: Enhance tsinfo netlink
 attributes and add a tsconfig set command
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-feature_ptp_netnext-v18-10-ed948f3b6887@bootlin.com>
References: <20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com>
In-Reply-To: <20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com>
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
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Add new attributed to tsinfo allowing to get the tsinfo from a phc provider
(composed by a phc index and a phc qualifier) on a netdevice's link.
Add simultaneously a tsconfig command to be able to get and set hwtstamp
configuration for a specified phc provider.

Here is few examples:
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema
             --dump tsinfo-get
             --json '{"header":{"dev-name":"eth0"}}'
[{'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 0, 'qualifier': 0},
  'phc-index': 0,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 2, 'name': 'some'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'}]},
               'nomask': True,
               'size': 4}},
 {'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 2, 'qualifier': 0},
  'phc-index': 2,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 1, 'name': 'all'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 1, 'name': 'software-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'},
                                {'index': 2, 'name': 'onestep-sync'}]},
               'nomask': True,
               'size': 4}}]

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":0, "qualifier":0 }
}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtst-provider': {'index': 0, 'qualifier': 0},
 'phc-index': 0,
 'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                 {'index': 2, 'name': 'some'}]},
                'nomask': True,
                'size': 16},
 'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                   {'index': 2, 'name': 'hardware-receive'},
                                   {'index': 6, 'name': 'hardware-raw-clock'}]},
                  'nomask': True,
                  'size': 17},
 'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                               {'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":2, "qualifier":0}}'
None
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsconfig-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtstamp-flags': 1,
 'hwtstamp-provider': {'index': 1, 'qualifier': 0},
 'rx-filters': {'bits': {'bit': [{'index': 12, 'name': 'ptpv2-event'}]},
                'nomask': True,
                'size': 16},
 'tx-types': {'bits': {'bit': [{'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

 ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsconfig-set
	      --json '{"header":{"dev-name":"eth0"},
		       "hwtstamp-provider":{"index":1, "qualifier":0 },
		       "rx-filters":{"bits": {"bit": {"name":"ptpv2-l4-event"}},
				     "nomask": 1},
		       "tx-types":{"bits": {"bit": {"name":"on"}},
				   "nomask": 1}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtstamp-flags': 1,
 'hwtstamp-provider': {'index': 1, 'qualifier': 0},
 'rx-filters': {'bits': {'bit': [{'index': 12, 'name': 'ptpv2-event'}]},
                'nomask': True,
                'size': 16},
 'tx-types': {'bits': {'bit': [{'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v8:
- New patch

Changes in v10:
- Add ghwtstamp attributes
- Add tsinfo ntf command

Changes in v11:
- Add examples in the commit message.

Changes in v13:
- Replace shorter name by real name.
- Fix an issue reported by "make -C tools/net/ynl" on the namings.

Changes in v16:
- Move to tsconfig command to get and set hwtstamp configuration.

Changes in v18:
- Add a tsconfig-set reply command description
---
 Documentation/netlink/specs/ethtool.yaml | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93369f0eb816..8bd04ff89122 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -637,6 +637,15 @@ attribute-sets:
       -
         name: tx-err
         type: uint
+  -
+    name: ts-hwtstamp-provider
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: qualifier
+        type: u32
   -
     name: tsinfo
     attributes:
@@ -663,6 +672,10 @@ attribute-sets:
         name: stats
         type: nest
         nested-attributes: ts-stat
+      -
+        name: hwtstamp-provider
+        type: nest
+        nested-attributes: ts-hwtstamp-provider
   -
     name: cable-result
     attributes:
@@ -1137,6 +1150,28 @@ attribute-sets:
       -
         name: downstream-sfp-name
         type: string
+  -
+    name: tsconfig
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: hwtstamp-provider
+        type: nest
+        nested-attributes: ts-hwtstamp-provider
+      -
+        name: tx-types
+        type: nest
+        nested-attributes: bitset
+      -
+        name: rx-filters
+        type: nest
+        nested-attributes: bitset
+      -
+        name: hwtstamp-flags
+        type: u32
 
 operations:
   enum-model: directional
@@ -1578,6 +1613,7 @@ operations:
         request:
           attributes:
             - header
+            - hwtstamp-provider
         reply:
           attributes:
             - header
@@ -1586,6 +1622,7 @@ operations:
             - rx-filters
             - phc-index
             - stats
+            - hwtstamp-provider
       dump: *tsinfo-get-op
     -
       name: cable-test-act
@@ -1960,3 +1997,36 @@ operations:
       name: phy-ntf
       doc: Notification for change in PHY devices.
       notify: phy-get
+    -
+      name: tsconfig-get
+      doc: Get hwtstamp config.
+
+      attribute-set: tsconfig
+
+      do: &tsconfig-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &tsconfig
+            - header
+            - hwtstamp-provider
+            - tx-types
+            - rx-filters
+            - hwtstamp-flags
+      dump: *tsconfig-get-op
+    -
+      name: tsconfig-set
+      doc: Set hwtstamp config.
+
+      attribute-set: tsconfig
+
+      do:
+        request:
+          attributes: *tsconfig
+        reply:
+          attributes: *tsconfig
+    -
+      name: tsconfig-ntf
+      doc: Notification for change in tsconfig configuration.
+      notify: tsconfig-get

-- 
2.34.1


