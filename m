Return-Path: <netdev+bounces-199745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85246AE1B05
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD6A4A7B04
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195C28C00D;
	Fri, 20 Jun 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HPXtqixP"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B328B7C5;
	Fri, 20 Jun 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422804; cv=none; b=JdldTRYbEyjD6F/ciClRcE6rca/Sl56+5ktKqTUz5mZULabOz9NpmWgfZUKsU8KGkaWJtlGjddka7maVavMZGnO1tyseF0rwOEOGB5XeK5a06CB9/bmiQKPQnFggKaIyr9/dMWEm9O4lPWWxUYtxc2ZInh+kWU9KjeJ9MAJbV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422804; c=relaxed/simple;
	bh=6vl7PF+/T9auoFlR4HnEk0oD6IcObTEXZv0Bj419scI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIgazBC4jI4Z6lolGfTh/3lJ6AUoLiU3mkEjre8EvRCNZ/ZEOc94sDuEZWebRwHYn/tTGCV4Llx0RPf21jwgyIVzNLo7LMy26Vwrc+OAx2xbnCtIH8YeWqYM6RLN+DIJLgTar1gYscV3xsLjTL6RMGWOyNSINfQqqnghWG42+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HPXtqixP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8A781FD3C;
	Fri, 20 Jun 2025 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750422800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aMJMPvcSqljiCkLImJkk0ab9T8QK7AAmCb1QEL0KHg=;
	b=HPXtqixPr8tc9EUHMRN0Lltavg8KQMGbEQjarjeyzjmXmxwKjrwWEeLCAfFIzCrz3WjG/q
	cxtHa2kx9kTQXhhXhmvutJC97KrwvLtvqWwlpgaC/M6enMVyg33Mpu/OLd4z/D+FcPjE3J
	mooDzOMwdTRQIoJar5gTvECIOgJXNdH5ZKsktvAO/NKdYpPTvfbVtlSFkwKPTkNvVMuEGr
	P0n+PhY6TW9xX1ng1XmD1EiT5uAdHg8hhFjMemWqSeXRsWSlQETQdd0fq5PJ0NvFzACiDR
	ix+XLET/PqR12j8iYN68ChdWyKDnW2EUiOc0yYMeI6FHcKnP2c9utztMxaUSlQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 20 Jun 2025 14:33:07 +0200
Subject: [PATCH ethtool-next 2/2] ethtool: pse-pd: Add PSE priority and
 event monitoring support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-b4-feature_poe_pw_budget-v1-2-0bdb7d2b9c8f@bootlin.com>
References: <20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com>
In-Reply-To: <20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepn
 hgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtii
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) priority management and
event monitoring capabilities:

- Add priority configuration parameter (prio) for port priority management
- Display power domain index, maximum priority, and current priority
- Add PSE event monitoring support in ethtool monitor command

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.8.in      | 13 ++++++++
 ethtool.c         |  1 +
 netlink/monitor.c |  8 +++++
 netlink/netlink.h |  1 +
 netlink/pse-pd.c  | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 7e164a6..b9025bd 100644
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
@@ -1893,6 +1894,15 @@ This attribute specifies the allowed power limit ranges in mW for
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
@@ -1912,6 +1922,9 @@ This parameter manages c33 PSE Admin operations in accordance with the IEEE
 This parameter manages c33 PSE Available Power Limit in mW, in accordance
 with the IEEE 802.3-2022 33.2.4.4 Variables (pse_available_power)
 specification.
+.TP
+.B prio \ N
+This parameter manages port priority.
 
 .RE
 .TP
diff --git a/ethtool.c b/ethtool.c
index 327a2da..281484f 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6283,6 +6283,7 @@ static const struct option args[] = {
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-avail-pw-limit N ]\n"
+			  "		[ prio N ]\n"
 	},
 	{
 		.opts	= "--flash-module-firmware",
diff --git a/netlink/monitor.c b/netlink/monitor.c
index ace9b25..cc5163e 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -75,6 +75,10 @@ static struct {
 		.cmd	= ETHTOOL_MSG_MODULE_NTF,
 		.cb	= module_reply_cb,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PSE_NTF,
+		.cb	= pse_ntf_cb,
+	},
 };
 
 static void clear_filter(struct nl_context *nlctx)
@@ -186,6 +190,10 @@ static struct monitor_option monitor_opts[] = {
 		.pattern	= "--show-module|--set-module",
 		.cmd		= ETHTOOL_MSG_MODULE_NTF,
 	},
+	{
+		.pattern	= "--pse-event",
+		.cmd		= ETHTOOL_MSG_PSE_NTF,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/netlink.h b/netlink/netlink.h
index ad2a787..6a91336 100644
--- a/netlink/netlink.h
+++ b/netlink/netlink.h
@@ -92,6 +92,7 @@ int cable_test_tdr_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int cable_test_tdr_ntf_cb(const struct nlmsghdr *nlhdr, void *data);
 int fec_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int module_reply_cb(const struct nlmsghdr *nlhdr, void *data);
+int pse_ntf_cb(const struct nlmsghdr *nlhdr, void *data);
 
 /* dump helpers */
 
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index fd1fc4d..41af9de 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -13,6 +13,7 @@
 
 #include "../internal.h"
 #include "../common.h"
+#include "bitset.h"
 #include "netlink.h"
 #include "parser.h"
 
@@ -420,6 +421,29 @@ int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
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
@@ -452,6 +476,64 @@ int nl_gpse(struct cmd_context *ctx)
 	return ret;
 }
 
+static const char *pse_events_name(u64 val)
+{
+	switch (val) {
+	case ETHTOOL_PSE_EVENT_OVER_CURRENT:
+		return "over-current";
+	case ETHTOOL_PSE_EVENT_OVER_TEMP:
+		return "over-temperature";
+	case ETHTOOL_C33_PSE_EVENT_DETECTION:
+		return "detection";
+	case ETHTOOL_C33_PSE_EVENT_CLASSIFICATION:
+		return "classification";
+	case ETHTOOL_C33_PSE_EVENT_DISCONNECTION:
+		return "disconnection";
+	case ETHTOOL_PSE_EVENT_OVER_BUDGET:
+		return "over-budget";
+	case ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR:
+		return "software power control error";
+	default:
+		return "unknown";
+	}
+}
+
+int pse_ntf_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_PSE_MAX + 1] = {};
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	u64 val;
+	int ret, i;
+
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return MNL_CB_OK;
+
+	if (!tb[ETHTOOL_A_PSE_NTF_EVENTS])
+		return MNL_CB_OK;
+
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PSE_HEADER]);
+	if (!dev_ok(nlctx))
+		return MNL_CB_OK;
+
+	open_json_object(NULL);
+	print_string(PRINT_ANY, "ifname", "PSE event for %s:\n",
+		     nlctx->devname);
+	open_json_array("events", "Events:");
+	val = attr_get_uint(tb[ETHTOOL_A_PSE_NTF_EVENTS]);
+	for (i = 0; 1 << i <= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR; i++)
+		if (val & 1 << i)
+			print_string(PRINT_ANY, NULL, " %s",
+				     pse_events_name(val & 1 << i));
+	close_json_array("\n");
+	if (ret < 0)
+		return MNL_CB_OK;
+
+	close_json_object();
+	return MNL_CB_OK;
+}
+
 /* PSE_SET */
 
 static const struct lookup_entry_u32 podl_pse_admin_control_values[] = {
@@ -487,6 +569,12 @@ static const struct param_parser spse_params[] = {
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


