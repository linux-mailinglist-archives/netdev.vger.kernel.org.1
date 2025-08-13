Return-Path: <netdev+bounces-213272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF641B244D0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFA33B2D04
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121C2F069F;
	Wed, 13 Aug 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hWF2448L"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB22EA173;
	Wed, 13 Aug 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075503; cv=none; b=HaeLFl5pZrOxvJpo8iBJjH38Ybxcj1iHAQTnHoiLgnj8EgD520f1UEI8EA9ZNigYubIqgbywc++nnencrd3iOLq/pt8pg8zW+8nl8+ke8qtItvZx5ksElC9alujv8uE0p7L9PaEjuPST8G3OTsxYPZQsbkj7Iq+faRXgeneTbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075503; c=relaxed/simple;
	bh=//LU4C3dGZGXgjTjR8HjeBOEI0UcEV3tKZSZBIsCEFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOTJAyLfxQ9Rfc81fgbTVqVQLO60r3Vfnai4hpORpSlDO2ouK16BuKvz8f0UIAcX0VDIZlVzRaPeYxthbdGENtuOFNmT/Q5SC6nqKsN+XGl9GWSwGgL2UxCiqm17IP44QxiofUnApQb7tojmxqNGuSVlVX2rBFJWE9h3hh5E/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hWF2448L; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DEF2438CF;
	Wed, 13 Aug 2025 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755075499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2qBZdjRghAkqmiJN8JMvHrldaOmMvvC5ejcCBkZEI0=;
	b=hWF2448LkeIdTe44KD3uTOPTr8Pg4NWkp+1M0v8Vc9pQSsCtZo44proSeEYUtBLGOIERJm
	DYc+z3JfuiEXNAayJGe0mX1dvw0AwMndU31oignz+/62n/+lbllBI5fRKpdf9oAngA4U9V
	O6MqOwMZta6Po9TUaL1nwBW2Clmup+3Fsgd7lGayPCZ+V6WwNQEUnV/+2iPAohh0265LPi
	VPnUfEdML8/OuUPqtc1yijwa0gvjPwgIYV0dpOWQ8KTxE5w54Z6yHjdy8Q3h06mhuFDR0W
	yv33V/JK99csGobiBnZcsMlsUeqpEhjguBo97fbCh41ZJTTgAR8KIyHLnO4Bag==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 13 Aug 2025 10:57:51 +0200
Subject: [PATCH ethtool v2 2/3] ethtool: pse-pd: Add PSE priority support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-b4-feature_poe_pw_budget-v2-2-0bef6bfcc708@bootlin.com>
References: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
In-Reply-To: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Dent Project <dentproject@linuxfoundation.org>, 
 Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhkuhgsvggtvghksehsuhhsvgdrtgiipdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehkhihlvgdrshifvghns
 hhonhesvghsthdrthgvtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) priority management:
- Add priority configuration parameter (prio) for port priority management
- Display power domain index, maximum priority, and current priority

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.8.in     | 13 +++++++++++++
 ethtool.c        |  1 +
 netlink/pse-pd.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 29b8a8c..163b2b0 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -561,6 +561,7 @@ ethtool \- query or control network driver and hardware settings
 .RB [ c33\-pse\-admin\-control
 .BR enable | disable ]
 .BN c33\-pse\-avail\-pw\-limit N
+.BN prio N
 .HP
 .B ethtool \-\-flash\-module\-firmware
 .I devname
@@ -1911,6 +1912,15 @@ This attribute specifies the allowed power limit ranges in mW for
 configuring the c33-pse-avail-pw-limit parameter. It defines the valid
 power levels that can be assigned to the c33 PSE in compliance with the
 c33 standard.
+.TP
+.B power-domain-index
+This attribute defines the index of the PSE Power Domain.
+.TP
+.B priority-max
+This attribute defines the maximum priority available for the PSE.
+.TP
+.B priority
+This attribute defines the currently configured priority for the PSE.
 
 .RE
 .TP
@@ -1930,6 +1940,9 @@ This parameter manages c33 PSE Admin operations in accordance with the IEEE
 This parameter manages c33 PSE Available Power Limit in mW, in accordance
 with the IEEE 802.3-2022 33.2.4.4 Variables (pse_available_power)
 specification.
+.TP
+.B prio \ N
+This parameter manages port priority.
 
 .RE
 .TP
diff --git a/ethtool.c b/ethtool.c
index 215f566..948d551 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6339,6 +6339,7 @@ static const struct option args[] = {
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-avail-pw-limit N ]\n"
+			  "		[ prio N ]\n"
 	},
 	{
 		.opts	= "--flash-module-firmware",
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index fd1fc4d..5bde176 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -420,6 +420,29 @@ int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		}
 	}
 
+	if (tb[ETHTOOL_A_PSE_PW_D_ID]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PW_D_ID]);
+		print_uint(PRINT_ANY, "power-domain-index",
+			   "Power domain index: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_PSE_PRIO_MAX]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO_MAX]);
+		print_uint(PRINT_ANY, "priority-max",
+			   "Max allowed priority: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_PSE_PRIO]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
+		print_uint(PRINT_ANY, "priority", "Priority %u\n", val);
+	}
+
 	close_json_object();
 
 	return MNL_CB_OK;
@@ -487,6 +510,12 @@ static const struct param_parser spse_params[] = {
 		.handler	= nl_parse_direct_u32,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "prio",
+		.type		= ETHTOOL_A_PSE_PRIO,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
 	{}
 };
 

-- 
2.43.0


