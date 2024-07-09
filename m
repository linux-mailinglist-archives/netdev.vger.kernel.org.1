Return-Path: <netdev+bounces-110298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6317992BC32
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187EE281CEC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFA7193061;
	Tue,  9 Jul 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HQl5EBvY"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EE192B71;
	Tue,  9 Jul 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533261; cv=none; b=JhM6uSlFjhTg7ki+0GWsbPSqZwpbBbpv/I944JBbG47SvwJWqh0LxP5G7DdXHY++JyIZNo+w3f670aJ9VisqiKSZRozGT4pta2v919y32iYsM34Nn/ru1rE7303cbyPjYlJef4QNZLBNdOhd6EXl/Q8e0UmrWuKrWlzqTscYaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533261; c=relaxed/simple;
	bh=U/rrxL89230dfCn1N7xyO76Wb3rr5XDLFItX8MIGiuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcMQEOJAP5BvhuEcSPP61Nfm0qCa1OjgXe95H3Fg2r48+lUUbwGdpCA01gyrDyiNoKWjIadaJoiSSjo+dT311kjFDAlizSGFRw9PCW8g/aOMQXaoael4O2R8Z9mhLNdjjbOYSx6kXeDmaW89LTp1Webyj90FjWSt+3L7iOAwc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HQl5EBvY; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEE011BF215;
	Tue,  9 Jul 2024 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720533257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTRtCRpypwFu3ITgB0O8mCGVy40pFL3Vl2LtOLRtGRI=;
	b=HQl5EBvYzTLbQK9fVYV+kNpgPqD9VwAp90AZECH+dJmkJUOfANObaBfZv++97n3ToRLrnK
	rCWjGCUf4N0nWs6B7E6UZXk7Xa4N+s+jP2n5tukbP0GENBIQEAUlKUT/lQ0wxCbz9rVQDq
	Ab3eKkjBdes5jkIIahQ/6Vvkfkg3Wx5pe9JW8OKfLnL9OrJbvtROQ/fK8NJFO53pGmzL7r
	N58PCKLv4dq6CQNKT/bcm6+8Bmu8ioAGvEHMwgAnHo8A8XykbTNsNIMDwDJ7BhOC3Gzhw2
	p0sfZjc2rGXX2eLb1rE+z1dMbjhY+Aa3NcWF24u01pyONGgvQwBmCbyiHYTBoQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Jul 2024 15:53:46 +0200
Subject: [PATCH net-next v17 14/14] netlink: specs: Enhance tsinfo netlink
 attributes and add a tsconfig set command
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-feature_ptp_netnext-v17-14-b5317f50df2a@bootlin.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
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
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
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
None

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
---
 Documentation/netlink/specs/ethtool.yaml | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 495e35fcfb21..9bd1f8a7bd3f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -624,6 +624,15 @@ attribute-sets:
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
@@ -650,6 +659,10 @@ attribute-sets:
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
@@ -1085,6 +1098,28 @@ attribute-sets:
       -
         name: total
         type: uint
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
@@ -1526,6 +1561,7 @@ operations:
         request:
           attributes:
             - header
+            - hwtstamp-provider
         reply:
           attributes:
             - header
@@ -1534,6 +1570,7 @@ operations:
             - rx-filters
             - phc-index
             - stats
+            - hwtstamp-provider
       dump: *tsinfo-get-op
     -
       name: cable-test-act
@@ -1877,3 +1914,39 @@ operations:
           - status-msg
           - done
           - total
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
+          attributes:
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
+          attributes:
+            - header
+            - hwtstamp-provider
+            - tx-types
+            - rx-filters
+            - hwtstamp-flags
+    -
+      name: tsconfig-ntf
+      doc: Notification for change in tsconfig configuration.
+      notify: tsconfig-get

-- 
2.34.1


