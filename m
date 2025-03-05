Return-Path: <netdev+bounces-172161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF71A50669
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C919189102F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5C24EAAE;
	Wed,  5 Mar 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCv3BJ+M"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2C17B401;
	Wed,  5 Mar 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196050; cv=none; b=q6eWovRr9YqUEgmc6uZmf4FddHlsvczIDGw6CwA7LT/9iAXIuY5yvFS6XW2klJRFDDwXiw36MVBWh1DtXK9x/psz1zRTv0i3Sx91yCIbiqiIHWnkaKet845DqvOw+egT0hJvjj4Ei6VqCQ9blFT9ohBCEJgD8HUS/mh1JGkeJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196050; c=relaxed/simple;
	bh=SKSWvYC04svyGWHbgE7USXfQH7mof3y+MWaaJFzQX9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/PawmNe60FCHVXls6ugQYJiZYUHZsZNzds+cVY+2+Lpn7O25Vc9pn1KIQrAjvUhyYnZid2MSJ0CStMBfQ9d7axHWx/0aCPYubuvSiCYO8zwD2SuO0KNQBPnYPhRWAoy9UO2mirkFvCHqMq8nXPEEs0wpPgvHwgDxf3bFg55/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCv3BJ+M; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27B5044291;
	Wed,  5 Mar 2025 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741196045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DwHothkqnnZD2cDwrBzGKTVbpxBa1FlU5XGgdBSMx0=;
	b=fCv3BJ+MkPdQKMJmEHpphHOlB+6XJkQZ8NGgury7FukqjF9vnFC4jD0f6ur8C5rF89sfoL
	pg75HbcpTCWDG1YtzefP+LSg9KoA1iIo4wgH/ek4K3p7oXS6sW8pH6tGJcgNdIGK8Pabs7
	9rOA5vj/KGMgldVfbbsesrEeiWNo/yV0jmVQgOkY4rBSRH7g4jmhE1XQh/qvvTZxihvFiW
	Y2ZMDT4SvfEIQNynw4GLZLL8vCxnpnBHrWqd3Sjwz5+a831m7t0BsxMORKGApbi59tsep1
	ILd2lF0yfvA0NANLLIFH15GP4gU4wzVER/q38EQMaPphMZDZyMP0PzDEAeY+1w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 05 Mar 2025 18:33:39 +0100
Subject: [PATCH ethtool-next 3/3] netlink: Add support for tsconfig command
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-feature_ptp-v1-3-f36f64f69aaa@bootlin.com>
References: <20250305-feature_ptp-v1-0-f36f64f69aaa@bootlin.com>
In-Reply-To: <20250305-feature_ptp-v1-0-f36f64f69aaa@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhigihhnghesthgvnhgtvghnthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtl
 hhinhdrtghomhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Add support for the tsconfig command to get and set the hardware timestamp
configuration. Currently, only allows selecting the hardware timestamp
provider within a network interface topology.
The configuration of tx_types and rx_filter is already handled by the
linuxptp tool, so ethtool should not modify these parameters.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Makefile.am        |   1 +
 ethtool.8.in       |  25 +++++++++
 ethtool.c          |  11 ++++
 netlink/extapi.h   |   4 ++
 netlink/ts.h       |  22 ++++++++
 netlink/tsconfig.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink/tsinfo.c   |  21 ++++----
 7 files changed, 227 insertions(+), 10 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 862886b77754846b99bcaf9a1b2af30accaa9b04..7389d00ca4447462d1c18fd22020773e513604d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -49,6 +49,7 @@ ethtool_SOURCES += \
 		  netlink/plca.c \
 		  netlink/pse-pd.c \
 		  netlink/phy.c \
+		  netlink/tsconfig.c \
 		  uapi/linux/ethtool_netlink.h \
 		  uapi/linux/netlink.h uapi/linux/genetlink.h \
 		  uapi/linux/rtnetlink.h uapi/linux/if_link.h \
diff --git a/ethtool.8.in b/ethtool.8.in
index 7188e6ab5005cd0221ae0d2c6a0ec6a1566181fc..5e4586d45f08624bb696da30c53aedca799f28b7 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -347,6 +347,16 @@ ethtool \- query or control network driver and hardware settings
 .BI qualifier
 .IR precise|approx ]
 .HP
+.B ethtool \-\-get\-hwtimestamp\-cfg
+.I devname
+.HP
+.B ethtool \-\-set\-hwtimestamp\-cfg
+.I devname
+.RB [ index
+.IR N
+.BI qualifier
+.IR precise|approx ]
+.HP
 .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
 .I devname
 .HP
@@ -1249,6 +1259,21 @@ Qualifier of the ptp hardware clock. Mainly "precise" the default one is
 for IEEE 1588 quality and "approx" is for NICs DMA point.
 .RE
 .TP
+.B \-\-get\-hwtimestamp\-cfg
+Show the selected time stamping PTP hardware clock configuration.
+.TP
+.B \-\-set\-hwtimestamp\-cfg
+Select the device's time stamping PTP hardware clock.
+.RS 4
+.TP
+.BI index \ N
+Index of the ptp hardware clock
+.TP
+.BI qualifier \ precise | approx
+Qualifier of the ptp hardware clock. Mainly "precise" the default one is
+for IEEE 1588 quality and "approx" is for NICs DMA point.
+.RE
+.TP
 .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
 Retrieves the receive flow hash indirection table and/or RSS hash key.
 .TP
diff --git a/ethtool.c b/ethtool.c
index cd3434021857e8c441325e321378323481fd98e0..707454be1269ca0b0434af6e453e44b1e52884c4 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5977,6 +5977,17 @@ static const struct option args[] = {
 		.help	= "Show time stamping capabilities",
 		.xhelp	= "		[ index N qualifier precise|approx ]\n"
 	},
+	{
+		.opts	= "--get-hwtimestamp-cfg",
+		.nlfunc	= nl_gtsconfig,
+		.help	= "Get selected hardware time stamping"
+	},
+	{
+		.opts	= "--set-hwtimestamp-cfg",
+		.nlfunc	= nl_stsconfig,
+		.help	= "Select hardware time stamping",
+		.xhelp	= "		[ index N qualifier precise|approx ]\n"
+	},
 	{
 		.opts	= "-x|--show-rxfh-indir|--show-rxfh",
 		.json	= true,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 9d6eddfb31dbda87bfd3338f70386f2e1cdffba6..f2bf422a3f2d6f8b9fb068bea6930a33ddec420e 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -36,6 +36,8 @@ int nl_spause(struct cmd_context *ctx);
 int nl_geee(struct cmd_context *ctx);
 int nl_seee(struct cmd_context *ctx);
 int nl_tsinfo(struct cmd_context *ctx);
+int nl_gtsconfig(struct cmd_context *ctx);
+int nl_stsconfig(struct cmd_context *ctx);
 int nl_cable_test(struct cmd_context *ctx);
 int nl_cable_test_tdr(struct cmd_context *ctx);
 int nl_gtunnels(struct cmd_context *ctx);
@@ -114,6 +116,8 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_geee			NULL
 #define nl_seee			NULL
 #define nl_tsinfo		NULL
+#define nl_gtsconfig		NULL
+#define nl_stsconfig		NULL
 #define nl_cable_test		NULL
 #define nl_cable_test_tdr	NULL
 #define nl_gtunnels		NULL
diff --git a/netlink/ts.h b/netlink/ts.h
new file mode 100644
index 0000000000000000000000000000000000000000..9442b44cb72bee97faa2c57fdc91219c5f3d8d22
--- /dev/null
+++ b/netlink/ts.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ts.h - netlink timestamping
+ *
+ * Copyright (c) 2025 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
+ */
+
+#ifndef ETHTOOL_NETLINK_TS_H__
+#define ETHTOOL_NETLINK_TS_H__
+
+const char *tsinfo_hwprov_qualifier_names(u32 val);
+int tsinfo_show_hwprov(const struct nlattr *nest);
+int tsinfo_qualifier_parser(struct nl_context *nlctx,
+			    uint16_t type __maybe_unused,
+			    const void *data __maybe_unused,
+			    struct nl_msg_buff *msgbuff __maybe_unused,
+			    void *dest);
+int tsinfo_dump_list(struct nl_context *nlctx, const struct nlattr *attr,
+		     const char *label, const char *if_empty,
+		     unsigned int stringset_id);
+
+#endif /* ETHTOOL_NETLINK_TS_H__ */
diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
new file mode 100644
index 0000000000000000000000000000000000000000..d427c7bfc7d203ebb03345fff3f0f077395c82be
--- /dev/null
+++ b/netlink/tsconfig.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tsconfig.c - netlink implementation of hardware timestamping
+ *		configuration
+ *
+ * Implementation of "ethtool --get-hwtimestamp-cfg <dev>" and
+ * "ethtool --set-hwtimestamp-cfg <dev> ..."
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "../internal.h"
+#include "../common.h"
+#include "netlink.h"
+#include "bitset.h"
+#include "parser.h"
+#include "ts.h"
+
+/* TSCONFIG_GET */
+
+int tsconfig_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_TSCONFIG_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	struct nl_context *nlctx = data;
+	bool silent;
+	int err_ret;
+	int ret;
+
+	silent = nlctx->is_dump;
+	err_ret = silent ? MNL_CB_OK : MNL_CB_ERROR;
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return err_ret;
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_TSCONFIG_HEADER]);
+	if (!dev_ok(nlctx))
+		return err_ret;
+
+	if (silent)
+		print_nl();
+	printf("Time stamping configuration for %s:\n", nlctx->devname);
+
+	if (!tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER])
+		return MNL_CB_OK;
+
+	ret = tsinfo_show_hwprov(tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER]);
+	if (ret < 0)
+		return err_ret;
+
+	ret = tsinfo_dump_list(nlctx, tb[ETHTOOL_A_TSCONFIG_TX_TYPES],
+			       "Hardware Transmit Timestamp Mode", " none",
+			       ETH_SS_TS_TX_TYPES);
+	if (ret < 0)
+		return err_ret;
+
+	ret = tsinfo_dump_list(nlctx, tb[ETHTOOL_A_TSCONFIG_RX_FILTERS],
+			       "Hardware Receive Filter Mode", " none",
+			       ETH_SS_TS_RX_FILTERS);
+	if (ret < 0)
+		return err_ret;
+
+	ret = tsinfo_dump_list(nlctx, tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS],
+			       "Hardware Flags", " none",
+			       ETH_SS_TS_FLAGS);
+	if (ret < 0)
+		return err_ret;
+
+	return MNL_CB_OK;
+}
+
+int nl_gtsconfig(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_TSINFO_GET, true))
+		return -EOPNOTSUPP;
+	if (ctx->argc > 0) {
+		fprintf(stderr, "ethtool: unexpected parameter '%s'\n",
+			*ctx->argp);
+		return 1;
+	}
+
+	ret = nlsock_prep_get_request(nlsk, ETHTOOL_MSG_TSCONFIG_GET,
+				      ETHTOOL_A_TSCONFIG_HEADER, 0);
+	if (ret < 0)
+		return ret;
+	return nlsock_send_get_request(nlsk, tsconfig_reply_cb);
+}
+
+/* TSCONFIG_SET */
+
+static const struct param_parser stsconfig_params[] = {
+	{
+		.arg		= "index",
+		.type		= ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX,
+		.group		= ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "qualifier",
+		.type		= ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER,
+		.group		= ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER,
+		.handler	= tsinfo_qualifier_parser,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_stsconfig(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_msg_buff *msgbuff;
+	struct nl_socket *nlsk;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_TSCONFIG_SET, false))
+		return -EOPNOTSUPP;
+
+	nlctx->cmd = "--set-hwtstamp-cfg";
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	nlctx->devname = ctx->devname;
+	nlsk = nlctx->ethnl_socket;
+	msgbuff = &nlsk->msgbuff;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_TSCONFIG_SET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return ret;
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
+			       ctx->devname, 0))
+		return -EMSGSIZE;
+
+	ret = nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = nlsock_process_reply(nlsk, tsconfig_reply_cb, nlctx);
+	if (ret == 0)
+		return 0;
+	else
+		return nlctx->exit_code ?: 1;
+}
diff --git a/netlink/tsinfo.c b/netlink/tsinfo.c
index c12070fc877b68d925d845caee6fe8a126e19882..187c3ad3e08a9e47dde29831bd41c47f73b404f7 100644
--- a/netlink/tsinfo.c
+++ b/netlink/tsinfo.c
@@ -14,10 +14,11 @@
 #include "netlink.h"
 #include "bitset.h"
 #include "parser.h"
+#include "ts.h"
 
 /* TSINFO_GET */
 
-static const char *tsinfo_hwprov_qualifier_names(u32 val)
+const char *tsinfo_hwprov_qualifier_names(u32 val)
 {
 	switch (val) {
 	case HWTSTAMP_PROVIDER_QUALIFIER_PRECISE:
@@ -29,7 +30,7 @@ static const char *tsinfo_hwprov_qualifier_names(u32 val)
 	}
 }
 
-static int tsinfo_show_hwprov(const struct nlattr *nest)
+int tsinfo_show_hwprov(const struct nlattr *nest)
 {
 	const struct nlattr *tb[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {};
 	DECLARE_ATTR_TB_INFO(tb);
@@ -117,9 +118,9 @@ static void tsinfo_dump_cb(unsigned int idx, const char *name, bool val,
 		printf("\tbit%u\n", idx);
 }
 
-static int tsinfo_dump_list(struct nl_context *nlctx, const struct nlattr *attr,
-			    const char *label, const char *if_empty,
-			    unsigned int stringset_id)
+int tsinfo_dump_list(struct nl_context *nlctx, const struct nlattr *attr,
+		     const char *label, const char *if_empty,
+		     unsigned int stringset_id)
 {
 	const struct stringset *strings = NULL;
 	int ret;
@@ -205,11 +206,11 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	return MNL_CB_OK;
 }
 
-static int tsinfo_qualifier_parser(struct nl_context *nlctx,
-				   uint16_t type __maybe_unused,
-				   const void *data __maybe_unused,
-				   struct nl_msg_buff *msgbuff __maybe_unused,
-				   void *dest __maybe_unused)
+int tsinfo_qualifier_parser(struct nl_context *nlctx,
+			    uint16_t type __maybe_unused,
+			    const void *data __maybe_unused,
+			    struct nl_msg_buff *msgbuff __maybe_unused,
+			    void *dest __maybe_unused)
 {
 	const char *arg = *nlctx->argp;
 	u32 val;

-- 
2.34.1


