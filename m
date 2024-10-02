Return-Path: <netdev+bounces-131309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93DC98E0BA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E798D1C23B23
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45841D174B;
	Wed,  2 Oct 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B+ci74lo"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656D1D151E;
	Wed,  2 Oct 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886554; cv=none; b=s/OYTtcmdkpcKs/9yfZf5pupMEvwpVaByUpkcmYE43TbNvNq6df7ve7r3wgrRYZh+oWiNV/SZdUQO/3EdOVGJFWO3+A3H3vGRTHaATYmd6KP+D9dRR8UZcpUr+GX8dhp5Fp6Fjrfcb1Oa/NKzZTpxSeOVMORcQQ3ZA2J2ZXBjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886554; c=relaxed/simple;
	bh=rVpijr8Ej3ERIa9M7Wj2D8vGyGBd8oUb+lInsTA0JrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvFnpRSuBvRXh38umTBtmb1/wIiw3Bs1BwakvbqEf4wpclFo+5ehcgTA/ElgiKugov4+8eaJQPCL6mL1Dw/uCg/3/VwRJridxuGsntieVroHGrorQ8KQ8+mtJYgXDZgs1sogoeGF8Up+ZX4ip2gBR9OhEue/K/nhDhlEtxKEuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B+ci74lo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6792B1BF204;
	Wed,  2 Oct 2024 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q42vlEq9SAx89Xute+BoOnfEctMoZLGsOE40ryVf9pw=;
	b=B+ci74loAGXNI2/+BFpp5iyuy8Pj218w7C7E/UHHh38y+87bxkZyQ7GXqE4UxAoIyh4VTI
	i/iFdcvojuK1GDPJJMtRVfS5ttujiSwPPm3FagkJO5giWSqgo5RSD1tHeyDJ+7ArZx9wqp
	gkYfc/D7TsGSrDLRPVeGmvBifevW/lBrlvUrwaeah/hbl7xEe/YxpGcssokEl/42WG+sY2
	U4tENZmwF3K8VPgKoorfoh8dusSEFard5FOvQFff1o/Lrdi1eFJYLnIcMlT4plTb0aKcbv
	dG5JWwOTPBEwLiH26AadfDi0bdKhuEi3+mCezQM6s76zj3+eYpz4WG7IR46diA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:03 +0200
Subject: [PATCH net-next 07/12] netlink: specs: Expand the PSE netlink
 command with C33 prio attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-7-787054f74ed5@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with priority and priority max to be able to
set and get the PSE Power Interface priority.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
             --json '{"header":{"dev-name":"eth1"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-avail-pw-limit': 97500,
 'c33-pse-prio': 2,
 'c33-pse-prio-max': 2,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit-ranges': [{'max': 18100, 'min': 15000},
                             {'max': 38000, 'min': 30000},
                             {'max': 65000, 'min': 60000},
                             {'max': 97500, 'min': 90000}],
 'header': {'dev-index': 5, 'dev-name': 'eth1'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
             --json '{"header":{"dev-name":"eth1"},
                      "c33-pse-prio":1}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9c..e2967645fbf2 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1020,6 +1020,14 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: c33-pse-pw-limit
+      -
+        name: c33-pse-prio-max
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1776,6 +1784,8 @@ operations:
             - c33-pse-ext-substate
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
+            - c33-pse-prio-max
+            - c33-pse-prio
       dump: *pse-get-op
     -
       name: pse-set
@@ -1790,6 +1800,7 @@ operations:
             - podl-pse-admin-control
             - c33-pse-admin-control
             - c33-pse-avail-pw-limit
+            - c33-pse-prio
     -
       name: rss-get
       doc: Get RSS params.

-- 
2.34.1


