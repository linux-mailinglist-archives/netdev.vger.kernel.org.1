Return-Path: <netdev+bounces-103632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F212C908D7A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2691C215FC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230310A1E;
	Fri, 14 Jun 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RpzXopFn"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77D910979;
	Fri, 14 Jun 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375611; cv=none; b=KT7c05h5aFb8bmDdCShk3cNCz1SPNez/nzMMauCxNAik0h6xcu6YQA5QKoeTnRWGFPHfPAL+tsxfKIyfhu/RwVl2zrBe1CHKMzP9Njno/146fA+tBDceKYOl9pS0/BHO3kMc+PXmxDKLthKYHJR/C9/IhKpY/oDowb5p78eMAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375611; c=relaxed/simple;
	bh=NEu+v449TWFePr40Prcd/PKsp0nXuwloceBfUZn5F9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzlyS16Ju5+j+4pHGhBIYfoHLb/KcHazNJ4e5z8HgOJ69ukHCQyVKbYrF44zyRiZ6xCskBUQL8uuPYL8ISRDylMCuYS4x/pE141SuNB3mD2LG1R1MqNmbImkVrUxAHiJKKkJwgxGWo5OmD6Mjm0KuqYMuixsqc1AxeMCqBPyCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RpzXopFn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C145D1C000D;
	Fri, 14 Jun 2024 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718375602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rsc210g2S3Of6rk4P/OtxrijW8772bJQXkzbN2fK+Tk=;
	b=RpzXopFnHWccf3OV0pXRiLhSCpdV8GkItgXASkuBf7QMCaZHq3NhEPFn4HsYV6S4UTom2t
	6qFozCt+XaDdqlB0k6M9MMp3H4LsFfoCTmPWpkEmJoBcKK9n4mBSyqs4bJqgZAaIS0XO24
	+PQ4IbZ2xczZ7qD9xo17F+XPTbxT40CPTzmmYNKFajpYMe3XPZNZx37njy4iidTIJMMAfJ
	nier5khqA3CQqSpruWI58lV0opPLXOiDXEDxIrTuTQHvMIvtxOVg2Tk6S17Tm95lyO2jQq
	IKCJcX72Pa+HWGV1pp4gcUi7vMY2/GcQQEtJdqvytJOZ2jodg8J2jlKGCcYDag==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 14 Jun 2024 16:33:18 +0200
Subject: [PATCH net-next v3 2/7] netlink: specs: Expand the PSE netlink
 command with C33 new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-feature_poe_power_cap-v3-2-a26784e78311@bootlin.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
In-Reply-To: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
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
 'c33-pse-ext-state': 5,
 'c33-pse-ext-substate': 5,
 'c33-pse-pw-d-status': 2,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Update c33-pse-ext-state and c33-pse-ext-substate to u32
- Add enum for listing c33-pse-ext-state
---
 Documentation/netlink/specs/ethtool.yaml | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..0ff27319856c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -20,6 +20,20 @@ definitions:
     name: header-flags
     type: flags
     entries: [ compact-bitsets, omit-reply, stats ]
+  -
+    name: c33-pse-ext-state
+    enum-name:
+    type: enum
+    entries: [ none,
+               ethtool_c33_pse_ext_state_class_num_events,
+               ethtool_c33_pse_ext_state_error_condition,
+               ethtool_c33_pse_ext_state_mr_pse_enable,
+               ethtool_c33_pse_ext_state_option_detect_ted,
+               ethtool_c33_pse_ext_state_option_vport_lim,
+               ethtool_c33_pse_ext_state_ovld_detected,
+               ethtool_c33_pse_ext_state_pd_dll_power_type,
+               ethtool_c33_pse_ext_state_power_not_available,
+               ethtool_c33_pse_ext_state_short_detected ]
 
 attribute-sets:
   -
@@ -922,6 +936,23 @@ attribute-sets:
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
@@ -1611,6 +1642,10 @@ operations:
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


