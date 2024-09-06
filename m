Return-Path: <netdev+bounces-125992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2196F794
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD251C21892
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B31D2F56;
	Fri,  6 Sep 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hAgVrvq3"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525D1D1F70;
	Fri,  6 Sep 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634655; cv=none; b=fhNY6ChD9q6DM6FFXJWfDR9Ns1UeZzcvMW9JJmKRCBh63uRzBTER3vEXv9izvGS7NYtIyKn/2r/33tAIFT8KHF91NRCt22gJY4gN08i3YXJx8jaPY0yXlMBY6u2O1URjblAPttquBti4owOAYUrdRSR59bzlWkbqzmQga+LP+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634655; c=relaxed/simple;
	bh=dbqPb1VEUqjrkp5tIRjbloP34ygnXymNUnZt42oVgKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZmHar8qqAEqJTmsnnXcWdqMVmDLQDcZWw+Y62CSiPRSUvscW0bwhWHXShmwjsrnnLjdoUi9FTLIZULTjRpLyJeFlOpGb4a0oJK2mD2q0/wFq59bSN0E+0QNh3UpI6QswEX6azXhBj5346UmTJoODgBUpV0DJeb7fTWyvZWjFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hAgVrvq3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D08F1C0002;
	Fri,  6 Sep 2024 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725634646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grEyzTHGkHhLankOV/hQ2IHe64hUAeaH7W8DoxhvTQ8=;
	b=hAgVrvq3R7IaNQyw6z5a5Ri1A8BmZX7ZuygOTRrysTIt0Y+nQRVSDTOxHNA71JjnKsv4u7
	9ZPbTUK+SoAOynWYHPCVAUhuGnHfYmdRtAq9MVxQ4T/hMKmz4Qbqar4yJIQ/edwXQpoixn
	NmTdYuZfeWSTawPGKwgwcCLQhVT9qN5Ci5gqu43eP2/592ZHwbUWWzDIkMp/WXRGzYcdeR
	2KxTxLMgqnp02/37ID3yZ0pvG/A7F6VTxTmVgThDYZqFx38DhbHbKtf1JZEFaG2NvEHSbc
	r1QRa1yL3sWVrNhfCp6ODHvcMlNHkIR1QlOIA0JmRtUofc30zO/DnoLKAqWf0A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next v4 2/3] ethtool: Allow passing a PHY index for phy-targetting commands
Date: Fri,  6 Sep 2024 16:57:17 +0200
Message-ID: <20240906145719.387824-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906145719.387824-1-maxime.chevallier@bootlin.com>
References: <20240906145719.387824-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

With the introduction of PHY topology and the ability to list PHYs, we
can now target some netlink commands to specific PHYs. This is done by
passing a PHY index as a request parameter in the netlink GET command.

This is useful for PSE-PD, PLCA and Cable-testing operations when
multiple PHYs are on the link (e.g. when a PHY is used as an SFP
upstream controller, and when there's another PHY within the SFP
module).

Introduce a new, generic, option "--phy N" that can be used in
conjunction with PHY-targetting commands to pass the PHY index for the
targetted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 ethtool.8.in         | 21 ++++++++++++++++++
 ethtool.c            | 28 +++++++++++++++++++++++-
 internal.h           |  1 +
 netlink/cable_test.c |  4 ++--
 netlink/msgbuff.c    | 52 ++++++++++++++++++++++++++++++++++----------
 netlink/msgbuff.h    |  3 +++
 netlink/nlsock.c     |  3 ++-
 netlink/plca.c       |  4 ++--
 netlink/pse-pd.c     |  4 ++--
 9 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 11bb0f9..f16cdbd 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -143,6 +143,10 @@ ethtool \- query or control network driver and hardware settings
 .B ethtool [-I | --include-statistics]
 .I args
 .HP
+.B ethtool
+.BN --phy
+.I args
+.HP
 .B ethtool \-\-monitor
 [
 .I command
@@ -588,6 +592,23 @@ plain text in the presence of this option.
 Include command-related statistics in the output. This option allows
 displaying relevant device statistics for selected get commands.
 .TP
+.BI \-\-phy \ N
+Target a PHY within the interface. The PHY index can be retrieved with
+.B \-\-show\-phys. PHY index 0 targets the phy device directly attached to
+the ethernet MAC, if any.
+The following commands can accept a PHY index:
+.TS
+nokeep;
+lB	l.
+\-\-cable\-test
+\-\-cable\-test\-tdr
+\-\-get\-plca\-cfg
+\-\-set\-plca\-cfg
+\-\-get\-plca\-status
+\-\-show-pse
+\-\-set-pse
+.TE
+.TP
 .B \-a \-\-show\-pause
 Queries the specified Ethernet device for pause parameter information.
 .RS 4
diff --git a/ethtool.c b/ethtool.c
index 7f47407..4dc05c2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5739,6 +5739,7 @@ struct option {
 	const char	*opts;
 	bool		no_dev;
 	bool		json;
+	bool		targets_phy;
 	int		(*func)(struct cmd_context *);
 	nl_chk_t	nlchk;
 	nl_func_t	nlfunc;
@@ -6158,12 +6159,14 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--cable-test",
+		.targets_phy	= true,
 		.json	= true,
 		.nlfunc	= nl_cable_test,
 		.help	= "Perform a cable test",
 	},
 	{
 		.opts	= "--cable-test-tdr",
+		.targets_phy	= true,
 		.json	= true,
 		.nlfunc	= nl_cable_test_tdr,
 		.help	= "Print cable test time domain reflectrometery data",
@@ -6191,11 +6194,13 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--get-plca-cfg",
+		.targets_phy	= true,
 		.nlfunc	= nl_plca_get_cfg,
 		.help	= "Get PLCA configuration",
 	},
 	{
 		.opts	= "--set-plca-cfg",
+		.targets_phy	= true,
 		.nlfunc	= nl_plca_set_cfg,
 		.help	= "Set PLCA configuration",
 		.xhelp  = "		[ enable on|off ]\n"
@@ -6207,6 +6212,7 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--get-plca-status",
+		.targets_phy	= true,
 		.nlfunc	= nl_plca_get_status,
 		.help	= "Get PLCA status information",
 	},
@@ -6228,12 +6234,14 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--show-pse",
+		.targets_phy	= true,
 		.json	= true,
 		.nlfunc	= nl_gpse,
 		.help	= "Show settings for Power Sourcing Equipment",
 	},
 	{
 		.opts	= "--set-pse",
+		.targets_phy	= true,
 		.nlfunc	= nl_spse,
 		.help	= "Set Power Sourcing Equipment settings",
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
@@ -6270,7 +6278,8 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout,	"Usage:\n");
 	for (i = 0; args[i].opts; i++) {
 		fputs("        ethtool [ FLAGS ] ", stdout);
-		fprintf(stdout, "%s %s\t%s\n",
+		fprintf(stdout, "%s%s %s\t%s\n",
+			args[i].targets_phy ? "[ --phy PHY ] " : "",
 			args[i].opts,
 			args[i].no_dev ? "\t" : "DEVNAME",
 			args[i].help);
@@ -6550,6 +6559,19 @@ int main(int argc, char **argp)
 			argc -= 1;
 			continue;
 		}
+		if (*argp && !strcmp(*argp, "--phy")) {
+			char *eptr;
+
+			if (argc < 2)
+				exit_bad_args_info("--phy parameters expects a phy index");
+
+			ctx.phy_index = strtoul(argp[1], &eptr, 0);
+			if (!argp[1][0] || *eptr)
+				exit_bad_args_info("invalid phy index");
+			argp += 2;
+			argc -= 2;
+			continue;
+		}
 		break;
 	}
 	if (*argp && !strcmp(*argp, "--monitor")) {
@@ -6585,6 +6607,10 @@ int main(int argc, char **argp)
 	}
 	if (ctx.json && !args[k].json)
 		exit_bad_args_info("JSON output not available for this subcommand");
+
+	if (!args[k].targets_phy && ctx.phy_index)
+		exit_bad_args_info("Unexpected --phy parameter");
+
 	ctx.argc = argc;
 	ctx.argp = argp;
 	netlink_run_handler(&ctx, args[k].nlchk, args[k].nlfunc, !args[k].func);
diff --git a/internal.h b/internal.h
index 4b994f5..afb8121 100644
--- a/internal.h
+++ b/internal.h
@@ -222,6 +222,7 @@ struct cmd_context {
 	unsigned long debug;	/* debugging mask */
 	bool json;		/* Output JSON, if supported */
 	bool show_stats;	/* include command-specific stats */
+	uint32_t phy_index;	/* the phy index this command targets */
 #ifdef ETHTOOL_ENABLE_NETLINK
 	struct nl_context *nlctx;	/* netlink context (opaque) */
 #endif
diff --git a/netlink/cable_test.c b/netlink/cable_test.c
index 9305a47..ba21c6c 100644
--- a/netlink/cable_test.c
+++ b/netlink/cable_test.c
@@ -572,8 +572,8 @@ int nl_cable_test_tdr(struct cmd_context *ctx)
 	if (ret < 0)
 		return 2;
 
-	if (ethnla_fill_header(msgbuff, ETHTOOL_A_CABLE_TEST_TDR_HEADER,
-			       ctx->devname, 0))
+	if (ethnla_fill_header_phy(msgbuff, ETHTOOL_A_CABLE_TEST_TDR_HEADER,
+				   ctx->devname, ctx->phy_index, 0))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, tdr_params, NULL, PARSER_GROUP_NEST, NULL);
diff --git a/netlink/msgbuff.c b/netlink/msgbuff.c
index 216f5b9..2275840 100644
--- a/netlink/msgbuff.c
+++ b/netlink/msgbuff.c
@@ -138,17 +138,9 @@ struct nlattr *ethnla_nest_start(struct nl_msg_buff *msgbuff, uint16_t type)
 	return NULL;
 }
 
-/**
- * ethnla_fill_header() - write standard ethtool request header to message
- * @msgbuff: message buffer
- * @type:    attribute type for header nest
- * @devname: device name (NULL to omit)
- * @flags:   request flags (omitted if 0)
- *
- * Return: pointer to the nest attribute or null of error
- */
-bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
-			const char *devname, uint32_t flags)
+static bool __ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16_t type,
+				     const char *devname, uint32_t phy_index,
+				     uint32_t flags)
 {
 	struct nlattr *nest;
 
@@ -159,7 +151,9 @@ bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
 	if ((devname &&
 	     ethnla_put_strz(msgbuff, ETHTOOL_A_HEADER_DEV_NAME, devname)) ||
 	    (flags &&
-	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)))
+	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)) ||
+	    (phy_index &&
+	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_PHY_INDEX, phy_index)))
 		goto err;
 
 	ethnla_nest_end(msgbuff, nest);
@@ -170,6 +164,40 @@ err:
 	return true;
 }
 
+/**
+ * ethnla_fill_header() - write standard ethtool request header to message
+ * @msgbuff: message buffer
+ * @type:    attribute type for header nest
+ * @devname: device name (NULL to omit)
+ * @flags:   request flags (omitted if 0)
+ *
+ * Return: pointer to the nest attribute or null of error
+ */
+bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
+			const char *devname, uint32_t flags)
+{
+	return __ethnla_fill_header_phy(msgbuff, type, devname, 0, flags);
+}
+
+/**
+ * ethnla_fill_header_phy() - write standard ethtool request header to message,
+ *			      targetting a device's phy
+ * @msgbuff: message buffer
+ * @type:    attribute type for header nest
+ * @devname: device name (NULL to omit)
+ * @phy_index: phy index to target (0 to omit)
+ * @flags:   request flags (omitted if 0)
+ *
+ * Return: pointer to the nest attribute or null of error
+ */
+bool ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16_t type,
+			    const char *devname, uint32_t phy_index,
+			    uint32_t flags)
+{
+	return __ethnla_fill_header_phy(msgbuff, type, devname, phy_index,
+					flags);
+}
+
 /**
  * __msg_init() - init a genetlink message, fill netlink and genetlink header
  * @msgbuff: message buffer
diff --git a/netlink/msgbuff.h b/netlink/msgbuff.h
index 7d6731f..7df19fc 100644
--- a/netlink/msgbuff.h
+++ b/netlink/msgbuff.h
@@ -47,6 +47,9 @@ bool ethnla_put(struct nl_msg_buff *msgbuff, uint16_t type, size_t len,
 struct nlattr *ethnla_nest_start(struct nl_msg_buff *msgbuff, uint16_t type);
 bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
 			const char *devname, uint32_t flags);
+bool ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16_t type,
+			    const char *devname, uint32_t phy_index,
+			    uint32_t flags);
 
 /* length of current message */
 static inline unsigned int msgbuff_len(const struct nl_msg_buff *msgbuff)
diff --git a/netlink/nlsock.c b/netlink/nlsock.c
index 0ec2738..0b873a3 100644
--- a/netlink/nlsock.c
+++ b/netlink/nlsock.c
@@ -291,7 +291,8 @@ int nlsock_prep_get_request(struct nl_socket *nlsk, unsigned int nlcmd,
 	ret = msg_init(nlctx, &nlsk->msgbuff, nlcmd, nlm_flags);
 	if (ret < 0)
 		return ret;
-	if (ethnla_fill_header(&nlsk->msgbuff, hdr_attrtype, devname, flags))
+	if (ethnla_fill_header_phy(&nlsk->msgbuff, hdr_attrtype, devname,
+				   nlctx->ctx->phy_index, flags))
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/netlink/plca.c b/netlink/plca.c
index 7d61e3b..7dc30a3 100644
--- a/netlink/plca.c
+++ b/netlink/plca.c
@@ -211,8 +211,8 @@ int nl_plca_set_cfg(struct cmd_context *ctx)
 		       NLM_F_REQUEST | NLM_F_ACK);
 	if (ret < 0)
 		return 2;
-	if (ethnla_fill_header(msgbuff, ETHTOOL_A_PLCA_HEADER,
-			       ctx->devname, 0))
+	if (ethnla_fill_header_phy(msgbuff, ETHTOOL_A_PLCA_HEADER,
+				   ctx->devname, ctx->phy_index, 0))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, set_plca_params, NULL, PARSER_GROUP_NONE, NULL);
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index 2c8dd89..3f6b6aa 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -240,8 +240,8 @@ int nl_spse(struct cmd_context *ctx)
 		       NLM_F_REQUEST | NLM_F_ACK);
 	if (ret < 0)
 		return 2;
-	if (ethnla_fill_header(msgbuff, ETHTOOL_A_PSE_HEADER,
-			       ctx->devname, 0))
+	if (ethnla_fill_header_phy(msgbuff, ETHTOOL_A_PSE_HEADER,
+				   ctx->devname, ctx->phy_index, 0))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, spse_params, NULL, PARSER_GROUP_NONE, NULL);
-- 
2.46.0


