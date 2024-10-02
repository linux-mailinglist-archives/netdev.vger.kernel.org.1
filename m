Return-Path: <netdev+bounces-131286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78498E059
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C31F1F232B7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33B1D0E39;
	Wed,  2 Oct 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DPWomRlT"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A51D014D;
	Wed,  2 Oct 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885691; cv=none; b=fPb7sa5d5rQSZED5rb9j22VqyNkP/63bc9O+Fxfz3FYV07CTtiWzYW6+rMrXb8qKY1ihRygRNbWeX4sAKpRlBKVn1omryRp2GgBmW0s2BHhIPZwuPJEDhinxClkTzJRrfOG0cULw3PI8skQSycePnl/QHXIEIJZVHDd4yeGxXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885691; c=relaxed/simple;
	bh=rVpijr8Ej3ERIa9M7Wj2D8vGyGBd8oUb+lInsTA0JrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvZ8soXjYP5s++pqpkyJv8YbHL80cEFne11FdjGvbNWFMOOv3g8emd4QLE0WWt0xCh8gjkCJAeR91NWz83mrDnJKzwqAWVP+FTjxqUTpR6fqCbL/WqFSqMIeb5tUw642GBtPiX4VLmjNJDqfUrtvQknX4WoVNNBohphuzHA/b2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DPWomRlT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2A0EFF80E;
	Wed,  2 Oct 2024 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q42vlEq9SAx89Xute+BoOnfEctMoZLGsOE40ryVf9pw=;
	b=DPWomRlTMMGSztWOP2fzIuNo2vn4VPCscviVPD7kzV4EH3AD4Zuj+gu2f3DuooRkGv3eRn
	m1PUpBsZNdg0Ozvba3Ds8ir33vRCwk7Z+Q1d5f2L5pybaZ9jn4ZmiLZLMDQP6g+9q9Y/xT
	UVxY15Qwzaa9f5qu7EOWLVFwAgMNpyIF5tmdNLRADLu2S7UFVrAMM9FbtmuFJR20C8VBP0
	Vuu1trp2Viz0WzWuycY5fWBUrOUBMQGycfywDMGyQV2kaDkF2O+xrd8dKNRKuwSi5iWXe4
	LCmv0avSPeHnCUtDV5qlZM6I31vVkZsPDORGdR6fzZspS3rSFp4TZoLJ5/1V6A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:14:18 +0200
Subject: [PATCH 07/12] netlink: specs: Expand the PSE netlink command with
 C33 prio attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-7-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
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


