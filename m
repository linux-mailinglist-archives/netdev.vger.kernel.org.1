Return-Path: <netdev+bounces-213273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C506EB244D1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34392A537B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC92F0C60;
	Wed, 13 Aug 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SoYwp4dv"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB672ECEAB;
	Wed, 13 Aug 2025 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075504; cv=none; b=nLZ8mX77Rt506AYOon06KCl2fv8EKp/lmUQtWoU892wkA/Wi80oLsaPlODwSxjlWUkb7qFAHqQN/m4hhEVEzXvfEmuesum3eUk5M4Z3mYeQGUkDn6IfL8yqu38gtfJ9TeMMMTrA6jZWDgTlJRIBC4WJgnEB4jcJIetBaQp2SxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075504; c=relaxed/simple;
	bh=m+7o+1Ic/T0orkEE9ky3aV4o9PJITE6/Qv1tLgb8MCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoSsR7DsLaRfYbvN3NUYlJSwTYzrP8L9lzi5+e+I9Qf0PVIF2cqJTy9e7aGvYoui25v462LPTc4VKaWcWbLF/cMqobgEpjS4LmnGzL2tnN547PVwWfcWleyTsN50BrUT/Y8EX/GLFI4aCWpP1AbkWFAPOznmQ+drEEauHZfshiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SoYwp4dv; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAFB843886;
	Wed, 13 Aug 2025 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755075500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl/jw1Po2n0fP2rKzOZFTry11UjH76uQNUviCPXT1xc=;
	b=SoYwp4dvOn7KJyRPS7vxNIdjmlWUJEFKP5GQFzxYWVEqQ/PP5t3J0cCzW/q6SdmYKyQQST
	X/lz4gooMTBPIaHkWgScwKvWbddgxOeIXzvABdXcMZmqCFuPgH68vICfKiGhfPzn6KGqTO
	GsZe9XvvGnZY7VmK7l4v/omROW3IZ7393dIc4l3oh97W3ktSjaJNUFFPrrEANN3CiZAvdR
	QnCglYssUfqwtZpIoeNQgdWPbS+V/oyCquj8MWrtHXF3AAcAVTbw5fsEeBnsGMW1tKUzH9
	pDJll6QELrZdUgLa3z4Z0qElHaHFPa6UEGY5mgdjzpYQu6CeQsTKAy9CgWwJbw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 13 Aug 2025 10:57:52 +0200
Subject: [PATCH ethtool v2 3/3] ethtool: pse-pd: Add PSE event monitoring
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-b4-feature_poe_pw_budget-v2-3-0bef6bfcc708@bootlin.com>
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

Add support for PSE (Power Sourcing Equipment) event monitoring
capabilities through the monitor command.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 netlink/monitor.c |  9 ++++++++-
 netlink/netlink.h |  1 +
 netlink/pse-pd.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/netlink/monitor.c b/netlink/monitor.c
index c511389..a16cb97 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -79,6 +79,10 @@ static struct {
 		.cmd	= ETHTOOL_MSG_PLCA_NTF,
 		.cb	= plca_get_cfg_reply_cb,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PSE_NTF,
+		.cb	= pse_ntf_cb,
+	},
 };
 
 static void clear_filter(struct nl_context *nlctx)
@@ -194,7 +198,10 @@ static struct monitor_option monitor_opts[] = {
 		.pattern	= "--get-plca-cfg|--set-plca-cfg",
 		.cmd		= ETHTOOL_MSG_PLCA_NTF,
 	},
-
+	{
+		.pattern	= "--pse-event",
+		.cmd		= ETHTOOL_MSG_PSE_NTF,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/netlink.h b/netlink/netlink.h
index 290592b..eefedf7 100644
--- a/netlink/netlink.h
+++ b/netlink/netlink.h
@@ -93,6 +93,7 @@ int cable_test_tdr_ntf_cb(const struct nlmsghdr *nlhdr, void *data);
 int fec_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int module_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int plca_get_cfg_reply_cb(const struct nlmsghdr *nlhdr, void *data);
+int pse_ntf_cb(const struct nlmsghdr *nlhdr, void *data);
 
 /* dump helpers */
 
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index 5bde176..3fb0616 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -475,6 +475,64 @@ int nl_gpse(struct cmd_context *ctx)
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

-- 
2.43.0


