Return-Path: <netdev+bounces-107585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F6F91B9FD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6243B2837C5
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9FE14E2E2;
	Fri, 28 Jun 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="njeUK9Rk"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309401487EB;
	Fri, 28 Jun 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563545; cv=none; b=nzpPo89qun2SWLF8xxMnnjSv2cuYhcCdim5giUlCJC+w0x8mJen+pvsfgVR0cA6ykynPPJ0pI2SIf/EGqhUuz/0AA7pIn2Pp2aQDK46Fv6VBehQjOZRbxZfjyne82nZpXvZhKyRxmyRadlpKtZEEkODaa0N83oAsTkhz0/tuLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563545; c=relaxed/simple;
	bh=YxZOhsOthN5Fh6ORrjIFbXYyaiBTjLSNhUEwTym/l6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QauOHHcjq+jVSewoqug3o/RqoFZfbABfkMQ/yovpySzHOYAMgZzLgvlBae+9FyTpgpsZUv/ejSx9b1KRhMiaob1aGDMJ9s2zWONr2qhMmEtsRwoe5OaNp+bRdTAKJ3p2kTzO5dD7sHDsduNRID3CsdknYSY6RyZGzvQe3Cl5sMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=njeUK9Rk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D51CD40002;
	Fri, 28 Jun 2024 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719563541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayBKEGZnU80RMrHoutp6S+LJBKFgPV0+ua6dwD1WzTc=;
	b=njeUK9Rk6irGJEem5P1DMETgGtIYMo7HWClnHa4g+o1Fx4FeQlXxf9YlHxRuhzfrSarxs1
	h5WTYDszip4/fQHM2LTDxkW3+VIbtUbciTMsc3BlVH+RuVquMCbpc/GmnczCT4EFTcTz+P
	aUFeTV5G5U8Vflfp33jEJlgLn92DjUMabfonXxR/DZ1X+tzTj4qbqd/V1oAPWj7qBnby+b
	NEG4YLPsko5V7kD7pqDTzV6p9n9A3hcfmke2hhL/JnWG7Y2xOGB0wNt+RR1VNRX1sjAhjx
	uAoSd5c0OLnUDxYzdj8r5wQAtMA4kADveVwANYbEG9TWb7BEadva4d26saIG8A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 28 Jun 2024 10:31:55 +0200
Subject: [PATCH net-next v5 2/7] netlink: specs: Expand the PSE netlink
 command with C33 new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-feature_poe_power_cap-v5-2-5e1375d3817a@bootlin.com>
References: <20240628-feature_poe_power_cap-v5-0-5e1375d3817a@bootlin.com>
In-Reply-To: <20240628-feature_poe_power_cap-v5-0-5e1375d3817a@bootlin.com>
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

Expand the c33 PSE attributes with PSE class, extended state information
and power consumption.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-admin-state': 3,
 'c33-pse-ext-state': 'mr-mps-valid',
 'c33-pse-ext-substate': 2,
 'c33-pse-pw-d-status': 2,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Update c33-pse-ext-state and c33-pse-ext-substate to u32
- Add enum for listing c33-pse-ext-state

Change in v4:
- Add name-prefix.
- Use hyphen-case instead of snwke_case.
- Use yaml list format.
- Updated substate list.
---
 Documentation/netlink/specs/ethtool.yaml | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 683f5c3f30ad..820cff47722d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -20,6 +20,21 @@ definitions:
     name: header-flags
     type: flags
     entries: [ compact-bitsets, omit-reply, stats ]
+  -
+    name: c33-pse-ext-state
+    enum-name:
+    type: enum
+    name-prefix: ethtool-c33-pse-ext-state-
+    entries:
+        - none
+        - error-condition
+        - mr-mps-valid
+        - mr-pse-enable
+        - option-detect-ted
+        - option-vport-lim
+        - ovld-detected
+        - power-not-available
+        - short-detected
 
 attribute-sets:
   -
@@ -951,6 +966,23 @@ attribute-sets:
         name: c33-pse-pw-d-status
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-class
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-actual-pw
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-ext-state
+        type: u32
+        name-prefix: ethtool-a-
+        enum: c33-pse-ext-state
+      -
+        name: c33-pse-ext-substate
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1642,6 +1674,10 @@ operations:
             - c33-pse-admin-state
             - c33-pse-admin-control
             - c33-pse-pw-d-status
+            - c33-pse-pw-class
+            - c33-pse-actual-pw
+            - c33-pse-ext-state
+            - c33-pse-ext-substate
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


