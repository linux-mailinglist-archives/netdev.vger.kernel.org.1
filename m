Return-Path: <netdev+bounces-140395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814629B64F6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4185128115F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459C1F8EE1;
	Wed, 30 Oct 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J8817F02"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688A1F8900;
	Wed, 30 Oct 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296524; cv=none; b=pHcVlCRi4A8d5BoaZUZ/nLlbQp6uRxWAnec4/nmJ4mnOTbdnyM7MQn4p7jrYxr0rh2t+KPXYWQTraC9fIJbopz3oZ9G1Om5sXIQomycbkpUTh2AV8UZRvhgTCEJl4L/aU6xtYrMihdKHHcP2kESTNgat+Oht7MHL69A5BoRrlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296524; c=relaxed/simple;
	bh=LrsGh3qmzchnmqG2MM3YOk05oabiM6pDWIcBkA50Nxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjEg/UDtRf7wkpOFtrlWCUhkv9603ZP95nNTKr5s0qNL+b5nxIF9yeZ1LTxUeuiOWXSjQNQD7iLH16bFA1ggKWD9rL3khmehqoU36qYMNW24HkTVEJouCx8IEPKc3UR70Qjpoo+qlCDuR74qlbdVXaI0ZWO9w/FzbBDzOUKBg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J8817F02; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A8B31C0004;
	Wed, 30 Oct 2024 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730296520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U981dne136mJZRxylVkDHEeRlMRiiF/+nXZbj0TIeeA=;
	b=J8817F02quQ1eKrhKd+uXon5xmSaNc4dPvFZXxRhjJ3sR2HZdKfY08zctkIu/4Qae8vCCW
	d778sibi0rfRO/TUjIFjflc4f2oRFR93Ws+8oU4C0L1gQsTFyQe3PBW1NbgSdtVURRfl8S
	y7IqvX3whEAHjTLo28XARUENQNcBXKO/OHyNU7Am9fY4kpADr8IHjs7qrkiXo1QTgE+EFt
	i8gCFT/LQK3prG3eCRs4a4/V8MUZi9fPHCTcGRnoqDrBltafCRvpnZ+3F4BvH3iaLV+JSD
	+uYod3GAvPBib0FRSuvPYDBn/jR0Xt7XRjuA2bIl1e8oCkpUDj7W7S1GHPw5+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 14:54:52 +0100
Subject: [PATCH net-next v19 10/10] netlink: specs: Enhance tsinfo netlink
 attributes and add a tsconfig set command
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_ptp_netnext-v19-10-94f8aadc9d5c@bootlin.com>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
In-Reply-To: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
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


