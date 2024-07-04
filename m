Return-Path: <netdev+bounces-109137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE792715F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7184D1C22E4A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD801AB533;
	Thu,  4 Jul 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5OfdyPW"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247C1AAE06;
	Thu,  4 Jul 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080749; cv=none; b=FbQzbyOnNB3I3+yFvmdjS2c6dQz+qtjSR+Et5yLnYx/oQBNIT9H54kSBtwwlxBeEDJP3xNgqWwM+ne9R18XiVPrdFogInOpR73/asR4gbOTNWKpnp14XQCWPi80KB9K4FUwsq+NrB5EOPxcEXvkxnEjsZ629aJJQFbExhjv2dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080749; c=relaxed/simple;
	bh=Px14lcNx7tsQJW8CRr8vmJ0jpTYSSNY44xxpfAAe5rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eI7g0dnxMmciDRxmb4pRNc5tyOjOBy0UfVCtPvq5G/aL8pwtnzeSSD8AddafNMHIKaNkYL1Moqmsa78rScW8XUq0DuKnduPgJOzgoKVCvehZ/Dk3KdNe907hERcuNC1hkMDZ7RG36dQnuORLVwhHHWSgAFBeW34dzHeG6L5BpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5OfdyPW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 955221BF204;
	Thu,  4 Jul 2024 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720080739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvkrHKHQtIC8A1L+Oh+K1HuCuS0UkTTJGUfsF6I7aC0=;
	b=N5OfdyPWrtFlzYOupLBKZVIgXZb0IBtmNfCpzRil7Dqfla6H6AVq8fvZhd9MitR3y/xild
	JVVsx1dSZEhzRlC3ob4cqQxsStlDr3jOIE4zvCgsooIn+az94MWeQBNe1j5I5zOz70PD8b
	D9EFKOCSfIayKKo7W6xP/qfPmwVGMOb01JflyCV5jqtNF0q+5zXZFl7bOvCxjnuUwnlcZX
	lElqGAGhNTKu/2F4o1quxIBwrbK3G0QMnxxZKG57vKe4/9WEztZcxXzE36N7Oxhu85CuTx
	MJ/1IHRIS6fk/LH74QNQ5MFndAZYqAfjRcLDm7fln5G54EtPts0MOD2t5k9TsA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 04 Jul 2024 10:12:01 +0200
Subject: [PATCH net-next v6 6/7] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-feature_poe_power_cap-v6-6-320003204264@bootlin.com>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
In-Reply-To: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with power limit to be able to set and get
the PSE Power Interface power limit.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
             --json '{"header":{"dev-name":"eth1"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-avail-pw-limit': 97500,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit-ranges': [{'max': 18100, 'min': 15000},
                             {'max': 38000, 'min': 30000},
                             {'max': 65000, 'min': 60000},
                             {'max': 97500, 'min': 90000}],
 'header': {'dev-index': 5, 'dev-name': 'eth1'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
             --json '{"header":{"dev-name":"eth1"},
                      "c33-pse-avail-pw-limit":19000}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v4:
- Add support for c33 pse power limit ranges.
---
 Documentation/netlink/specs/ethtool.yaml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 3c7744acc6c7..495e35fcfb21 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -939,6 +939,15 @@ attribute-sets:
       -
         name: power-mode
         type: u8
+  -
+    name: c33-pse-pw-limit
+    attributes:
+      -
+        name: min
+        type: u32
+      -
+        name: max
+        type: u32
   -
     name: pse
     attributes:
@@ -987,6 +996,16 @@ attribute-sets:
         name: c33-pse-ext-substate
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-avail-pw-limit
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-limit-ranges
+        name-prefix: ethtool-a-
+        type: nest
+        multi-attr: true
+        nested-attributes: c33-pse-pw-limit
   -
     name: rss
     attributes:
@@ -1708,6 +1727,8 @@ operations:
             - c33-pse-actual-pw
             - c33-pse-ext-state
             - c33-pse-ext-substate
+            - c33-pse-avail-pw-limit
+            - c33-pse-pw-limit-ranges
       dump: *pse-get-op
     -
       name: pse-set
@@ -1721,6 +1742,7 @@ operations:
             - header
             - podl-pse-admin-control
             - c33-pse-admin-control
+            - c33-pse-avail-pw-limit
     -
       name: rss-get
       doc: Get RSS params.

-- 
2.34.1


