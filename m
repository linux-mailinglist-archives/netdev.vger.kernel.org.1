Return-Path: <netdev+bounces-227879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF62BB91C5
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 22:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A57F04E1572
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFB272E71;
	Sat,  4 Oct 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wz1QeI4v"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EB78F29
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759609692; cv=none; b=aK7JV2d38Ctw5JcfUSUqO8+tbiZeOFS0QIOUFpxvpWQ7YnsSZ5vMuus/dlHRSSbgT9oU964wgeR6DyH/Es/VcnBmczrhvHPL2MNKd/YulaZyS5EyA+iXp8lcngqL9Pwu6XZKF6W7TeEb9RW1xo9wn/P/HIR4AZWZLbUbREMhiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759609692; c=relaxed/simple;
	bh=+RDqqTzrE2VVxsFxHEFdidHJAcNhgL+eF25Rj69yVl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2rPK2+yWLGrbN2mXljYOng56v0m5kcmUIRi9F6Gy1BrFnYMcKIJk2JvIdKtYbOboWt1JduKiJNwp4H5pHfCQKThaIh3RTaFSdzKpgSP6dPo+7lNYx1iCOSBQDGaz9JhGVinpSkLrDkj0o2q4JTUIjpWgnRATwdsbCIYty3GVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wz1QeI4v; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759609684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ebrN1GK7gaGp4+E9rGVYWgyDanP/Mm79PDqOdPFUpGo=;
	b=Wz1QeI4vswuM6cbmxm7SREzgXhCLQsuZ0LlvOzM393TiynihCaYdkwWQrJKN8mz41LbNvo
	dGOwSSX66dfx3tYSV3lz81abZtWlXnpWCVQAV39bgcK93hH4n+iAaLPVo4r9Is+MGLEsMf
	LLCPeP0wSLD0fsOdTiTAzJrSwEu7S2g=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: mkubecek@suse.cz
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping configuration
Date: Sat,  4 Oct 2025 20:27:15 +0000
Message-ID: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kernel supports configuring HW time stamping modes via netlink
messages, but previous implementation added support for HW time stamping
source configuration. Add support to configure TX/RX time stamping.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 ethtool.8.in       | 12 ++++++-
 ethtool.c          |  1 +
 netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 553592b..e9eb2d7 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -357,6 +357,10 @@ ethtool \- query or control network driver and hardware settings
 .IR N
 .BI qualifier
 .IR precise|approx ]
+.RB [ tx
+.IR TX-TYPE ]
+.RB [ rx-filter
+.IR RX-FILTER ]
 .HP
 .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
 .I devname
@@ -1286,7 +1290,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA point.
 Show the selected time stamping PTP hardware clock configuration.
 .TP
 .B \-\-set\-hwtimestamp\-cfg
-Select the device's time stamping PTP hardware clock.
+Sets the device's time stamping PTP hardware clock configuration.
 .RS 4
 .TP
 .BI index \ N
@@ -1295,6 +1299,12 @@ Index of the ptp hardware clock
 .BI qualifier \ precise | approx
 Qualifier of the ptp hardware clock. Mainly "precise" the default one is
 for IEEE 1588 quality and "approx" is for NICs DMA point.
+.TP
+.BI tx \ TX-TYPE
+Type of TX time stamping to configure
+.TP
+.BI rx-filter \ RX-FILTER
+Type of RX time stamping filter to configure
 .RE
 .TP
 .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
diff --git a/ethtool.c b/ethtool.c
index 948d551..2e03b74 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6063,6 +6063,7 @@ static const struct option args[] = {
 		.nlfunc	= nl_stsconfig,
 		.help	= "Select hardware time stamping",
 		.xhelp	= "		[ index N qualifier precise|approx ]\n"
+			  "		[ tx TX-TYPE ] [ rx-filter RX-FILTER ]\n"
 	},
 	{
 		.opts	= "-x|--show-rxfh-indir|--show-rxfh",
diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
index d427c7b..7dee4d1 100644
--- a/netlink/tsconfig.c
+++ b/netlink/tsconfig.c
@@ -17,6 +17,7 @@
 #include "netlink.h"
 #include "bitset.h"
 #include "parser.h"
+#include "strset.h"
 #include "ts.h"
 
 /* TSCONFIG_GET */
@@ -94,6 +95,67 @@ int nl_gtsconfig(struct cmd_context *ctx)
 
 /* TSCONFIG_SET */
 
+int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
+			 const void *data __maybe_unused,
+			 struct nl_msg_buff *msgbuff,
+			 void *dest __maybe_unused)
+{
+	const struct stringset *values;
+	const char *arg = *nlctx->argp;
+	unsigned int count, i;
+
+	nlctx->argp++;
+	nlctx->argc--;
+	if (netlink_init_ethnl2_socket(nlctx) < 0)
+		return -EIO;
+
+	switch (type) {
+	case ETHTOOL_A_TSCONFIG_TX_TYPES:
+		values = global_stringset(ETH_SS_TS_TX_TYPES, nlctx->ethnl2_socket);
+		break;
+	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
+		values = global_stringset(ETH_SS_TS_RX_FILTERS, nlctx->ethnl2_socket);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	count = get_count(values);
+	for (i = 0; i < count; i++) {
+		const char *name = get_string(values, i);
+
+		if (!strcmp(name, arg))
+			break;
+	}
+
+	if (i != count) {
+		struct nlattr *bits_attr, *bit_attr;
+
+		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
+			return -EMSGSIZE;
+
+		bits_attr = ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS);
+		if (!bits_attr)
+			return -EMSGSIZE;
+
+		bit_attr = ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS_BIT);
+		if (!bit_attr) {
+			ethnla_nest_cancel(msgbuff, bits_attr);
+			return -EMSGSIZE;
+		}
+		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
+		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE, true)) {
+			ethnla_nest_cancel(msgbuff, bits_attr);
+			ethnla_nest_cancel(msgbuff, bit_attr);
+			return -EMSGSIZE;
+		}
+		mnl_attr_nest_end(msgbuff->nlhdr, bit_attr);
+		mnl_attr_nest_end(msgbuff->nlhdr, bits_attr);
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct param_parser stsconfig_params[] = {
 	{
 		.arg		= "index",
@@ -109,6 +171,20 @@ static const struct param_parser stsconfig_params[] = {
 		.handler	= tsinfo_qualifier_parser,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "tx",
+		.type		= ETHTOOL_A_TSCONFIG_TX_TYPES,
+		.handler	= tsconfig_txrx_parser,
+		.group		= ETHTOOL_A_TSCONFIG_TX_TYPES,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-filter",
+		.type		= ETHTOOL_A_TSCONFIG_RX_FILTERS,
+		.handler	= tsconfig_txrx_parser,
+		.group		= ETHTOOL_A_TSCONFIG_RX_FILTERS,
+		.min_argc	= 1,
+	},
 	{}
 };
 
@@ -134,7 +210,7 @@ int nl_stsconfig(struct cmd_context *ctx)
 	if (ret < 0)
 		return ret;
 	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
-			       ctx->devname, 0))
+			       ctx->devname, ETHTOOL_FLAG_COMPACT_BITSETS))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST, NULL);
-- 
2.47.3


