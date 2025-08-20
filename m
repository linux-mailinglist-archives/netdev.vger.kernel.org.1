Return-Path: <netdev+bounces-215183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D7B2D79E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9835A0BB7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DD2E0916;
	Wed, 20 Aug 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C8jgJuGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8842DECA1;
	Wed, 20 Aug 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680873; cv=none; b=WwXIQCeUBUEoMkCJgJGSCm4AgQUuKMZRF2tHxQ0wC+Af0MiT4gAEgtOcSpJ/VJOOxjUBx95hLttwhoqnJPeFdUG8ZjyPkLRqECiml3fQh0aCw6k7eodgSU2hpbtWH23+LHelmLLXmmWsbxumIZ5iDctPqasIXe6BXiaH0teR+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680873; c=relaxed/simple;
	bh=VrjHvrSL5QIhW51uCmcfRPbG25k53AyjW4E7xJMdBvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxfR2tVBjR0ec/D04WMCKMpIoIsV5M4sSxgKPgTuSfI3aaaT6ns21SfkPr1zSuukenIUXYJ7MPwnr1LksRGa/dJekjSaUZIGQBTnvbtFP09Y5+mkzEwfwu03JotNF/9XQwPndF424Z+zxOm71SFnPKkbB6gMfymQD5+9R6PQxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C8jgJuGg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EF5B1C6B3BE;
	Wed, 20 Aug 2025 09:07:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9398A606A0;
	Wed, 20 Aug 2025 09:07:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 647AD1C22D468;
	Wed, 20 Aug 2025 11:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755680868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aBfAQYLk80uQ0sZ8VK7L/49M4AQ2IfTAo8FjJAj5W1s=;
	b=C8jgJuGgrwdEZk+SulBlYjG4Xi1pCaSl4YaU7BrfJUNUDjBNUrd3+N0+uhg2xx9FQffvyz
	3LoE31UPB+HUSbzICFtRJCNTfQvqJiIG0OvdDriVJmuZEnVcwYI+rOZK2pbKoYZ05T5fN3
	fmRePHSkJ5UiswaPUzlbiyJbA8n9fTy/6HGmaKWT1K+65H2RrgjWU5QCZzzP8M9Td8M61e
	frc+yNwcBwYJKe4gKCnxYmHIranmr+rBfjyzoXoK0qrmL1pVz9R5k2Ge++q3OgnMImODb/
	/dNX0WI9pUBHJNNPQ3g5cW/fLzMOdTwhX+RrGBnHSQJzhv//l6WACyr20DzOkA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 20 Aug 2025 11:07:34 +0200
Subject: [PATCH ethtool v3 3/3] ethtool: pse-pd: Add PSE event monitoring
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-b4-feature_poe_pw_budget-v3-3-c3d57362c086@bootlin.com>
References: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
In-Reply-To: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Dent Project <dentproject@linuxfoundation.org>, 
 Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) event monitoring
capabilities through the monitor command.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Change event loop limit to not ignore events that could be out of scope.
- Fix incorrect attribute usage.
---
 netlink/monitor.c |  9 ++++++++-
 netlink/netlink.h |  1 +
 netlink/pse-pd.c  | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

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
index f761871..77d599b 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -475,6 +475,66 @@ int nl_gpse(struct cmd_context *ctx)
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
+	const struct nlattr *tb[ETHTOOL_A_PSE_NTF_MAX + 1] = {};
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
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PSE_NTF_HEADER]);
+	if (!dev_ok(nlctx))
+		return MNL_CB_OK;
+
+	open_json_object(NULL);
+	print_string(PRINT_ANY, "ifname", "PSE event for %s:\n",
+		     nlctx->devname);
+	open_json_array("events", "Events:");
+	val = attr_get_uint(tb[ETHTOOL_A_PSE_NTF_EVENTS]);
+	for (i = 0;
+	     i < mnl_attr_get_payload_len(tb[ETHTOOL_A_PSE_NTF_EVENTS]) * 8;
+	     i++)
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


