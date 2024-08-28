Return-Path: <netdev+bounces-122844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F2962C3E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF61C21003
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659C1A7062;
	Wed, 28 Aug 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="miERa8pc"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EA19AD7E;
	Wed, 28 Aug 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858724; cv=none; b=BNdQJnk804495586Bec1P3tcNwHwmrCAcYEyjc8IhhbM1JaG55+gXZ9LINQ7o16zz5NnZyA0nm2p8DlVd3Ils997JXZDDXctUf0eSvV4VA9yRXHWFFvu0W+0rLXraimyGAkHCGwgYYOekbUul7TIZWO5TD5+j4xNwUXwJkcL6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858724; c=relaxed/simple;
	bh=BgVAPj2YAUq1wbWIV/dt7fzM2PLLid4gw/GIWl8kWmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoL7bN4fjGYy8qssvL5MIBdYmSPGyFFVuleOlV0o+CxmNv3vK634Lf5HNjFC1gN49O6FYxhIw5wIuXIXWdZylft1JMXE9q5Wg8ZH9tRseRWXBKLirh5Ud3iA6FUNt3fDjWbPQPjwIzGvB1uUUMEAyhn+D26SBlLRXCuwg55Z79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=miERa8pc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFFF4FF80B;
	Wed, 28 Aug 2024 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724858719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ARYQHriCQ+XWCpEfhU8KtlYZVCAcMdAOgbLL/Q6O2I=;
	b=miERa8pc44Nm11bz1pWPoLI1FMPE3/aHBmgFOhJK7V8O43grR2NZT/BSQXbjqNegSCFu0S
	qWhHFUwGnKtOQZcwok/OLY1blhFG2o7ze2EhrnPejugP4H3exuBMxbhp0rVzDupyPX22nW
	OW4m7Pm85jCnME/XyJr8uin0KAGQ6ye5h9RC986gFNNtNhEauQMyT2xUU1/LrjdZti+vG6
	eNr3UhHY/tvKDsD5Xj54oDCjiphTKjklG940HHn59E/kAs9GEfMeAXpJvaq1GIn/OHJD7y
	bvy5PFGMpMaNbg1/j6GhEwTs/UI1TDBTh81xlce0Q1MznGgdAWeO4olgMuGwBA==
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
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next v2 2/3] ethtool: Allow passing a PHY index for phy-targetting commands
Date: Wed, 28 Aug 2024 17:25:09 +0200
Message-ID: <20240828152511.194453-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
References: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
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
 ethtool.8.in         | 20 +++++++++++++++++
 ethtool.c            | 25 ++++++++++++++++++++-
 internal.h           |  1 +
 netlink/cable_test.c |  4 ++--
 netlink/msgbuff.c    | 52 ++++++++++++++++++++++++++++++++++----------
 netlink/msgbuff.h    |  3 +++
 netlink/nlsock.c     |  3 ++-
 netlink/plca.c       |  4 ++--
 netlink/pse-pd.c     |  4 ++--
 9 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 11bb0f9..a455b5d 100644
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
@@ -588,6 +592,22 @@ plain text in the presence of this option.
 Include command-related statistics in the output. This option allows
 displaying relevant device statistics for selected get commands.
 .TP
+.BI \-\-phy \ N
+Target a PHY within the interface. The PHY index can be retrieved with
+.B \-\-show\-phys.
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
index 7f47407..3bd777e 100644
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
@@ -6550,6 +6559,16 @@ int main(int argc, char **argp)
 			argc -= 1;
 			continue;
 		}
+		if (*argp && !strcmp(*argp, "--phy")) {
+			char *eptr;
+
+			ctx.phy_index = strtoul(argp[1], &eptr, 0);
+			if (!argp[1][0] || *eptr)
+				exit_bad_args();
+			argp += 2;
+			argc -= 2;
+			continue;
+		}
 		break;
 	}
 	if (*argp && !strcmp(*argp, "--monitor")) {
@@ -6585,6 +6604,10 @@ int main(int argc, char **argp)
 	}
 	if (ctx.json && !args[k].json)
 		exit_bad_args_info("JSON output not available for this subcommand");
+
+	if (!args[k].targets_phy && ctx.phy_index)
+		exit_bad_args();
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
2.45.2


