Return-Path: <netdev+bounces-236878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A638C41456
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 19:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C42F34E94AD
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBF33A00C;
	Fri,  7 Nov 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GgTFGBwn"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D672DECDF
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539659; cv=none; b=lZvBH7biWtHoFKB3U2HKm4x7APOpJjAy7F+CU1HrNCc2GnoyxdDAwOMV7LBwzvssudpbsg7/MD0SIyuWc6KPXXaJTQyin7o/291ICODeoS+LzBzxJz/lGWFG3yn4HR/PXtieH4V6E2ol/fb3f2gdZjNidtc71Hwl0x1bMiXM9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539659; c=relaxed/simple;
	bh=Q/gR2HYyuZ615NXxkfo/E+QmBiaqZa/aLTNQ0aQB40w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs4kUcc4HfNxXRl4kIemo2n1G/83rnYK07eUV2Vncr6cvB0yiloAahTfwHKG5Agr0jIIpsJrxcV891ddfFVOwwrhYeqc1ZBuPFjs59xQa5Ia3sPBwzDt44J8ZZ4hJ0e9rFSC+QBRi7HRr+wfAy3ZHl7HU6NRI8tZwEmU/sPp2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GgTFGBwn; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762539654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QoZULchYy7trdqIxzOWKX9dVYUWTQazldyq633QAi6Y=;
	b=GgTFGBwnxZQG2M0sg0HkFF8oNuIXuky3rWp1p5cLZ8G+ICUNK6efSd24RZdJ45T6bbsoGz
	aUxccronMeW5v0mIuv0QqmW4xGAOm7Hfnj8LnXfiHAG+3R6ZWkmZJf43CCPfGxa+0eJUhG
	nVDSsSfTRNIhIuznWlOfmMVK2ZVVf/g=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH ethtool-next v3] netlink: tsconfig: add HW time stamping configuration
Date: Fri,  7 Nov 2025 18:20:44 +0000
Message-ID: <20251107182044.3545092-1-vadim.fedorenko@linux.dev>
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
We keep TX type and RX filter configuration as a bit value, but if we
will need multibit value to be set in the future, there is an option to
use "rx-filters" keyword which will be mutually exclusive with current
"rx-filter" keyword. The same applies to "tx-type".

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
v2 -> v3:
* improve code style
v1 -> v2:
* improve commit message
---
 ethtool.8.in       | 12 +++++++-
 ethtool.c          |  1 +
 netlink/tsconfig.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 8874ade..1788588 100644
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
@@ -1287,7 +1291,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA point.
 Show the selected time stamping PTP hardware clock configuration.
 .TP
 .B \-\-set\-hwtimestamp\-cfg
-Select the device's time stamping PTP hardware clock.
+Sets the device's time stamping PTP hardware clock configuration.
 .RS 4
 .TP
 .BI index \ N
@@ -1296,6 +1300,12 @@ Index of the ptp hardware clock
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
index bd45b9e..521e6fe 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6068,6 +6068,7 @@ static const struct option args[] = {
 		.nlfunc	= nl_stsconfig,
 		.help	= "Select hardware time stamping",
 		.xhelp	= "		[ index N qualifier precise|approx ]\n"
+			  "		[ tx TX-TYPE ] [ rx-filter RX-FILTER ]\n"
 	},
 	{
 		.opts	= "-x|--show-rxfh-indir|--show-rxfh",
diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
index d427c7b..f4ed10e 100644
--- a/netlink/tsconfig.c
+++ b/netlink/tsconfig.c
@@ -17,6 +17,7 @@
 #include "netlink.h"
 #include "bitset.h"
 #include "parser.h"
+#include "strset.h"
 #include "ts.h"
 
 /* TSCONFIG_GET */
@@ -94,6 +95,66 @@ int nl_gtsconfig(struct cmd_context *ctx)
 
 /* TSCONFIG_SET */
 
+int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
+			 const void *data __maybe_unused,
+			 struct nl_msg_buff *msgbuff,
+			 void *dest __maybe_unused)
+{
+	struct nlattr *bits_attr, *bit_attr;
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
+	if (i != count)
+		return -EINVAL;
+
+	if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
+		return -EMSGSIZE;
+
+	bits_attr = ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS);
+	if (!bits_attr)
+		return -EMSGSIZE;
+
+	bit_attr = ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS_BIT);
+	if (!bit_attr) {
+		ethnla_nest_cancel(msgbuff, bits_attr);
+		return -EMSGSIZE;
+	}
+	if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
+	    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE, true)) {
+		ethnla_nest_cancel(msgbuff, bits_attr);
+		ethnla_nest_cancel(msgbuff, bit_attr);
+		return -EMSGSIZE;
+	}
+	mnl_attr_nest_end(msgbuff->nlhdr, bit_attr);
+	mnl_attr_nest_end(msgbuff->nlhdr, bits_attr);
+	return 0;
+}
+
 static const struct param_parser stsconfig_params[] = {
 	{
 		.arg		= "index",
@@ -109,6 +170,20 @@ static const struct param_parser stsconfig_params[] = {
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
 
@@ -134,7 +209,7 @@ int nl_stsconfig(struct cmd_context *ctx)
 	if (ret < 0)
 		return ret;
 	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
-			       ctx->devname, 0))
+			       ctx->devname, ETHTOOL_FLAG_COMPACT_BITSETS))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST, NULL);
-- 
2.47.3


