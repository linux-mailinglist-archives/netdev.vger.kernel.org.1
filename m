Return-Path: <netdev+bounces-101705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3D8FFD21
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375861F21454
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E666155307;
	Fri,  7 Jun 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iATodo3g"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103879DC;
	Fri,  7 Jun 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745442; cv=none; b=U7kYfXrYgxWmvm/HTTy7LWzvjG+EQQSWanLtPfvdg22apdjsCk0E9IJa6UEKHODk7dywH/cHrZfqlSGKWKbj9mvczPZeXjOWCcliACrWTxmda5Uj/sgksVxxGje57XykkMoixLZfr19hEiymbrMMZznmmeQyUabDLro3pxQS30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745442; c=relaxed/simple;
	bh=k1fwHIPAYc4O0HyC1r1Yd/I+nKqa1dDfQpwzGjUQX5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liEH1EPm8nS0gUHrvpXVlnAdeFLqJWY49Vyt09Ab8CfIx7Um+WX7ej9G2cjhnppE0cS+Hv9pJp/qvA+IciOoFppAOtCx5jfjgNPb/f58JO+FaXCYtAR457AU/1NYYHPkkCl6GreZSxY4qCizUsvOLaHTnS3k5udi29sy3ZkaUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iATodo3g; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77D9B40005;
	Fri,  7 Jun 2024 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vU/AedogyJdjRHzhE1ZYEiKhLlkByPwNNkJwKzcRaE=;
	b=iATodo3gdBUkZ33m29OSqMpgMD0r/ojk2FpbhgAaf0P+Ltpy4srfg0t2JcOsu53wf+4Mju
	28PlVvkbVYJQfPcWkW1hnVAw60SaCn0JMknpTKNZkli5vLKGoIWNsg24tsmdk7VZEiqy+0
	V0geQUXgVPM5M4FjTRfn/aSZJZHMNFACnysX7iEJKhBXo6x1xxnmQneJi6Wm7ktD7QJ2dt
	jKsT+d0IKjhP1sf4z4DHytmJM0P0h+HnfcSuL8oOIF0yc/iU6df02MZnnvH+fRnRVeXsV5
	WQg4oAsWPj4Pd1g/4x9e+adwC73cLuWlUsyZwjn3rC260z8PLbs5mdPCa8fPdA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:20 +0200
Subject: [PATCH net-next v2 3/8] netlink: specs: Expand the PSE netlink
 command with C33 new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-3-c03c2deb83ab@bootlin.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
In-Reply-To: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

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
 'c33-pse-ext-state': 5,
 'c33-pse-ext-substate': 5,
 'c33-pse-pw-d-status': 2,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..8aa064f2f466 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -922,6 +922,22 @@ attribute-sets:
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
+        type: u8
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-ext-substate
+        type: u8
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1611,6 +1627,10 @@ operations:
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


