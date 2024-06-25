Return-Path: <netdev+bounces-106468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8F916801
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0DF28667F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B7D169AD0;
	Tue, 25 Jun 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GtaQyPKi"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A9158D91;
	Tue, 25 Jun 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318847; cv=none; b=nMsU4mhHPycAZ7PzGbDPuRkmfEW1dArAX0JeW4zaKsv8/FmeMsbcnTwaeZ9MDi93dCy66JukUTYgYFXdxPqml1IIkX+Q+ZFzFlHrvlJI1n5CElz/wgJnIo+VKdScO4pcvK0RMxvW275faswGCfZaTf5Z/XPhr63hSPhqu0azsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318847; c=relaxed/simple;
	bh=kiHrlygSWvGVHvSTsFwYr0gnmAXEkIvErPg22iq6ve0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuyFvTF8VuYrRP0YHK9z/WbiPJ2CsQny4AkRtZVSqOzjuSqqtNbcUjLVxpzhaNWFUUBoJSRFbRKFecs7pydeeHjnsSpo9Xa6/fn9ILXKQQ/7+Fa0J7XWUU7GCnMCZIC4uU4C8wfmVX6AFfMVQr0+d9cXwL1SLq4KFe7n0bxbaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GtaQyPKi; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DED2E6000E;
	Tue, 25 Jun 2024 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28TUn8RZ9Esj0BNXjuYy+/+Ue61gr4vVxkuv1GVAnYs=;
	b=GtaQyPKi5FezaAYDeQ/wa1PrsP2vPsT8Ezz/vUr/FCQ92RihSeza7xekogodvxqTMvwiu1
	ZvKOk0Qw5hTSisGd1TEdvxWrKOJURtYAn73RUl15HllHaMDiPu3NAgfPyvn+3SDLrIaSpu
	x/DBMQ6pK3GCtOPdKetwm4PI7cNl5kVfXVMlDy0VlGh1tMX7f3ePsr+wWyO01IgzKnSMXi
	faG0/QUwLBJ0pSMQbmio6QzEwp5Nltbrt1XreyWSGoNzH6P8p0O0pC4ZM6Gg/XOOdX6+cl
	tIB6WueDBowtyPj2N7BaNB/YKOojc//NrpfOYymBH6TmTeFx+CV2dWmLbFQqzQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 25 Jun 2024 14:33:51 +0200
Subject: [PATCH net-next v4 6/7] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-feature_poe_power_cap-v4-6-b0813aad57d5@bootlin.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
In-Reply-To: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
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
index 492fad73bf75..f441886c9e45 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -906,6 +906,15 @@ attribute-sets:
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
@@ -954,6 +963,16 @@ attribute-sets:
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
@@ -1647,6 +1666,8 @@ operations:
             - c33-pse-actual-pw
             - c33-pse-ext-state
             - c33-pse-ext-substate
+            - c33-pse-avail-pw-limit
+            - c33-pse-pw-limit-ranges
       dump: *pse-get-op
     -
       name: pse-set
@@ -1660,6 +1681,7 @@ operations:
             - header
             - podl-pse-admin-control
             - c33-pse-admin-control
+            - c33-pse-avail-pw-limit
     -
       name: rss-get
       doc: Get RSS params.

-- 
2.34.1


