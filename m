Return-Path: <netdev+bounces-172160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DCA50668
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E64B7A71D4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FAC19C569;
	Wed,  5 Mar 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HA7vUGfT"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F29A95C;
	Wed,  5 Mar 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196049; cv=none; b=F0pqbZ8ochqUT02ZhbSgh4wxMru5BHQBfUTZId0W9TEeWMICp5ruF5m3jTqbS3P4fz1Pu37RLtkwa+RIm/UTGfVUsVEJ1Iprx0CJ/oubQxH28pyqevaYHRcDzoI70RJR5FFqMJPwSe+6hFLCyyE9a/2JM8WO+D4tEoDzserNgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196049; c=relaxed/simple;
	bh=rRm/nX3HORKGH4E5Fib2TAEBQ4Npz5BTDc5/0mnYr/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjhoA4VVvHHTXk85Js/ORT9YAW1OFrFU/pCzPdLaGAE2halx1knzfYLgtRsMs3X2CVd8UabFQAdeEVSH5ApHDiJayKZUDT1+ImvrIv2cOhYBgWKDYS9KfaU7IywfV/dgQypuMpguF+Cxlsm+y+ehmVdjLZ/gkoRBlwHLEBdvkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HA7vUGfT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 711CF443BC;
	Wed,  5 Mar 2025 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741196045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzxGwDEPZtB7KagOsMG3rLKE9agCT9Rsr8B4ykwG3uk=;
	b=HA7vUGfTxVY7jFbZTUjDna9Y55jhR2acna86OiIqEaX/Axv/xooHMR9tqG3l0I8pwdo9Ed
	6rep4MwcjSBf2uody4hJRMnDVkxFyS6dqmtHHJXKq7y6HJaKPCkHLkQgX0OFsUG6+qU9qG
	tH6vkrLRG8iukWJ5NiJPG4EUcw7ztQg4Pp2tcoV5PBp/A/GGnUJUmoNXD022MUxeWlWTF7
	TVIij0QTtZXDg7R6DcgJdwKSkLFkEdAJwpkWtBKFSJHQPodVJQi1Covjc0+dLk+U6Tw+8t
	ILcS/GaHjR59SqO+FIOoijz+R1DmneWTseF7Y/6d3EqJKGjaUP/qmQyjG567fg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 05 Mar 2025 18:33:38 +0100
Subject: [PATCH ethtool-next 2/3] tsinfo: Add support for hwtstamp provider
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-feature_ptp-v1-2-f36f64f69aaa@bootlin.com>
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

Add support for retrieving the hwtstamp provider description, which
consists of an index and a qualifier.

Extend tsinfo to allow querying timestamping information for a specific
hwtstamp provider within a network interface topology.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.8.in     |  16 ++++++++-
 ethtool.c        |   3 +-
 netlink/tsinfo.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 9e272f7056a8c9122b122ade745f3bc601c13c27..7188e6ab5005cd0221ae0d2c6a0ec6a1566181fc 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -342,6 +342,10 @@ ethtool \- query or control network driver and hardware settings
 .HP
 .B ethtool \-T|\-\-show\-time\-stamping
 .I devname
+.RB [ index
+.IR N
+.BI qualifier
+.IR precise|approx ]
 .HP
 .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
 .I devname
@@ -1233,7 +1237,17 @@ Sets the dump flag for the device.
 .TP
 .B \-T \-\-show\-time\-stamping
 Show the device's time stamping capabilities and associated PTP
-hardware clock.
+hardware clock. Show the capabilities of the currently selected time
+stamping if no \fBindex\fR and \fBqualifier\fR is provided.
+.RS 4
+.TP
+.BI index \ N
+Index of the ptp hardware clock
+.TP
+.BI qualifier \ precise | approx
+Qualifier of the ptp hardware clock. Mainly "precise" the default one is
+for IEEE 1588 quality and "approx" is for NICs DMA point.
+.RE
 .TP
 .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
 Retrieves the receive flow hash indirection table and/or RSS hash key.
diff --git a/ethtool.c b/ethtool.c
index a1393bc14b7b1a473853965fd3557b51efabc3c6..cd3434021857e8c441325e321378323481fd98e0 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5974,7 +5974,8 @@ static const struct option args[] = {
 		.opts	= "-T|--show-time-stamping",
 		.func	= do_tsinfo,
 		.nlfunc	= nl_tsinfo,
-		.help	= "Show time stamping capabilities"
+		.help	= "Show time stamping capabilities",
+		.xhelp	= "		[ index N qualifier precise|approx ]\n"
 	},
 	{
 		.opts	= "-x|--show-rxfh-indir|--show-rxfh",
diff --git a/netlink/tsinfo.c b/netlink/tsinfo.c
index 4df41415dc478415fa5e991b31c4feb91b0cb5e4..c12070fc877b68d925d845caee6fe8a126e19882 100644
--- a/netlink/tsinfo.c
+++ b/netlink/tsinfo.c
@@ -13,9 +13,44 @@
 #include "../common.h"
 #include "netlink.h"
 #include "bitset.h"
+#include "parser.h"
 
 /* TSINFO_GET */
 
+static const char *tsinfo_hwprov_qualifier_names(u32 val)
+{
+	switch (val) {
+	case HWTSTAMP_PROVIDER_QUALIFIER_PRECISE:
+		return "Precise (IEEE 1588 quality)";
+	case HWTSTAMP_PROVIDER_QUALIFIER_APPROX:
+		return "Approximate";
+	default:
+		return "unsupported";
+	}
+}
+
+static int tsinfo_show_hwprov(const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	u32 val;
+	int ret;
+
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	val = mnl_attr_get_u32(tb[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX]);
+	print_uint(PRINT_ANY, "hwtstamp-provider-index",
+		   "Hardware timestamp provider index: %u\n", val);
+	val = mnl_attr_get_u32(tb[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER]);
+	print_string(PRINT_ANY, "hwtstamp-provider-qualifier",
+		     "Hardware timestamp provider qualifier: %s\n",
+		     tsinfo_hwprov_qualifier_names(val));
+
+	return 0;
+}
+
 static int tsinfo_show_stats(const struct nlattr *nest)
 {
 	const struct nlattr *tb[ETHTOOL_A_TS_STAT_MAX + 1] = {};
@@ -135,12 +170,19 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (ret < 0)
 		return err_ret;
 
-	printf("PTP Hardware Clock: ");
-	if (tb[ETHTOOL_A_TSINFO_PHC_INDEX])
+	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER]) {
+		ret = tsinfo_show_hwprov(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER]);
+		if (ret < 0)
+			return err_ret;
+
+	} else if (tb[ETHTOOL_A_TSINFO_PHC_INDEX]) {
+		printf("PTP Hardware Clock: ");
 		printf("%d\n",
 		       mnl_attr_get_u32(tb[ETHTOOL_A_TSINFO_PHC_INDEX]));
-	else
+	} else {
+		printf("PTP Hardware Clock: ");
 		printf("none\n");
+	}
 
 	ret = tsinfo_dump_list(nlctx, tb[ETHTOOL_A_TSINFO_TX_TYPES],
 			       "Hardware Transmit Timestamp Modes", " none",
@@ -163,6 +205,46 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	return MNL_CB_OK;
 }
 
+static int tsinfo_qualifier_parser(struct nl_context *nlctx,
+				   uint16_t type __maybe_unused,
+				   const void *data __maybe_unused,
+				   struct nl_msg_buff *msgbuff __maybe_unused,
+				   void *dest __maybe_unused)
+{
+	const char *arg = *nlctx->argp;
+	u32 val;
+
+	nlctx->argp++;
+	nlctx->argc--;
+
+	if (!strncmp(arg, "precise", sizeof("precise")))
+		val = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
+	else if (!strncmp(arg, "approx", sizeof("approx")))
+		val = HWTSTAMP_PROVIDER_QUALIFIER_APPROX;
+	else
+		return -EINVAL;
+
+	return (type && ethnla_put_u32(msgbuff, type, val)) ? -EMSGSIZE : 0;
+}
+
+static const struct param_parser tsinfo_params[] = {
+	{
+		.arg		= "index",
+		.type		= ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX,
+		.group		= ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "qualifier",
+		.type		= ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER,
+		.group		= ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+		.handler	= tsinfo_qualifier_parser,
+		.min_argc	= 1,
+	},
+	{}
+};
+
 int nl_tsinfo(struct cmd_context *ctx)
 {
 	struct nl_context *nlctx = ctx->nlctx;
@@ -172,16 +254,21 @@ int nl_tsinfo(struct cmd_context *ctx)
 
 	if (netlink_cmd_check(ctx, ETHTOOL_MSG_TSINFO_GET, true))
 		return -EOPNOTSUPP;
-	if (ctx->argc > 0) {
-		fprintf(stderr, "ethtool: unexpected parameter '%s'\n",
-			*ctx->argp);
-		return 1;
-	}
 
 	flags = get_stats_flag(nlctx, ETHTOOL_MSG_TSINFO_GET, ETHTOOL_A_TSINFO_HEADER);
 	ret = nlsock_prep_get_request(nlsk, ETHTOOL_MSG_TSINFO_GET,
 				      ETHTOOL_A_TSINFO_HEADER, flags);
 	if (ret < 0)
 		return ret;
+
+	nlctx->cmd = "-T";
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	nlctx->devname = ctx->devname;
+
+	ret = nl_parser(nlctx, tsinfo_params, NULL, PARSER_GROUP_NEST, NULL);
+	if (ret < 0)
+		return ret;
+
 	return nlsock_send_get_request(nlsk, tsinfo_reply_cb);
 }

-- 
2.34.1


