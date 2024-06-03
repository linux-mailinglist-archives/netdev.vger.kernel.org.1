Return-Path: <netdev+bounces-100191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57038D819C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72281C21C7A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF38624C;
	Mon,  3 Jun 2024 11:52:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614A8615A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415578; cv=none; b=BwGwdk4IKGnpFUQbClnTEvJcuXKn+ayvsgD+rgcUySbKvO4K8XJbrykaCGeIbBNDt7U4mWThKmu5GAK61Yer0HJOZJaivyEhLiX6iKvaXNfTh/SwOOBrjRw5i6pia+KI9AcxI2NpJ60D5+ynQ45aL/H79ipT9S5zjrqLdCqQVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415578; c=relaxed/simple;
	bh=51ZIgkeTXQ+jzHkn7epfo1XcAiuyXC2oBO4EUnWcwPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbKnZOO35k2bErRv4fwgiz1b+dXoLO1Tj5qDn/kz/6YabVZ97o1Ykd0y2iU09uONigMv4/a4xI/vYcIeA32zC+qR+jmG06sOavfi+rQSAGpLJmGF5xOfAdbdodYZmGIUgbedEIE2Y9L6BONGSPGbKfLUqrRcm3LwIhhsr5Us0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1sE6FB-0001zT-SQ; Mon, 03 Jun 2024 13:52:53 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <fpf@pengutronix.de>)
	id 1sE6FB-0004Ix-Fs; Mon, 03 Jun 2024 13:52:53 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1sE6FB-00HCly-1R;
	Mon, 03 Jun 2024 13:52:53 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: mkubecek@suse.cz,
	netdev@vger.kernel.org
Cc: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH ethtool 2/2]: add json support for --show-eee command
Date: Mon,  3 Jun 2024 13:44:44 +0200
Message-Id: <20240603114442.4099003-2-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
References: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: fpf@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Implement the option to output json for the --show-eee sub command.

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 ethtool.c     |  1 +
 netlink/eee.c | 35 ++++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 73c26e2..f08c198 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6041,6 +6041,7 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--show-eee",
+		.json	= true,
 		.func	= do_geee,
 		.nlfunc	= nl_geee,
 		.help	= "Show EEE settings",
diff --git a/netlink/eee.c b/netlink/eee.c
index 6c53756..51b9d10 100644
--- a/netlink/eee.c
+++ b/netlink/eee.c
@@ -14,6 +14,7 @@
 #include "netlink.h"
 #include "bitset.h"
 #include "parser.h"
+#include "../json_writer.h"
 
 /* EEE_GET */
 
@@ -21,13 +22,13 @@ int eee_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHTOOL_A_EEE_MAX + 1] = {};
 	DECLARE_ATTR_TB_INFO(tb);
-	bool enabled, active, tx_lpi_enabled;
+	bool enabled, active, tx_lpi_enabled, status_support;
 	struct nl_context *nlctx = data;
 	bool silent;
 	int err_ret;
 	int ret;
 
-	silent = nlctx->is_dump || nlctx->is_monitor;
+	silent = nlctx->is_dump || nlctx->is_monitor || is_json_context();
 	err_ret = silent ? MNL_CB_OK : MNL_CB_ERROR;
 	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
 	if (ret < 0)
@@ -46,25 +47,26 @@ int eee_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	active = mnl_attr_get_u8(tb[ETHTOOL_A_EEE_ACTIVE]);
 	enabled = mnl_attr_get_u8(tb[ETHTOOL_A_EEE_ENABLED]);
 	tx_lpi_enabled = mnl_attr_get_u8(tb[ETHTOOL_A_EEE_TX_LPI_ENABLED]);
+	status_support = bitset_is_empty(tb[ETHTOOL_A_EEE_MODES_OURS], true, &ret);
 
 	if (silent)
 		putchar('\n');
-	printf("EEE settings for %s:\n", nlctx->devname);
-	printf("\tEEE status: ");
-	if (bitset_is_empty(tb[ETHTOOL_A_EEE_MODES_OURS], true, &ret)) {
-		printf("not supported\n");
+	print_string(PRINT_ANY, "ifname", "EEE settings for %s:\n", nlctx->devname);
+	print_string(PRINT_FP, NULL, "\tEEE status: ", NULL);
+	if (status_support) {
+		print_string(PRINT_ANY, "status", "%s\n", "not supported");
 		return MNL_CB_OK;
 	}
 	if (!enabled)
-		printf("disabled\n");
+		print_string(PRINT_ANY, "status", "%s\n", "disabled");
 	else
-		printf("enabled - %s\n", active ? "active" : "inactive");
-	printf("\tTx LPI: ");
+		print_string(PRINT_ANY, "status", "enabled - %s\n", active ? "active" : "inactive");
+	print_string(PRINT_FP, NULL, "\tTx LPI: ", NULL);
 	if (tx_lpi_enabled)
-		printf("%u (us)\n",
+		print_uint(PRINT_ANY, "tx-lpi", "%u (us)\n",
 		       mnl_attr_get_u32(tb[ETHTOOL_A_EEE_TX_LPI_TIMER]));
 	else
-		printf("disabled\n");
+		print_string(PRINT_FP, NULL, "%s\n", "disabled");
 
 	ret = dump_link_modes(nlctx, tb[ETHTOOL_A_EEE_MODES_OURS], true,
 			      LM_CLASS_REAL,
@@ -102,11 +104,18 @@ int nl_geee(struct cmd_context *ctx)
 		return 1;
 	}
 
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
+
 	ret = nlsock_prep_get_request(nlsk, ETHTOOL_MSG_EEE_GET,
 				      ETHTOOL_A_EEE_HEADER, 0);
 	if (ret < 0)
-		return ret;
-	return nlsock_send_get_request(nlsk, eee_reply_cb);
+		goto out;
+	ret =  nlsock_send_get_request(nlsk, eee_reply_cb);
+out:
+	close_json_object();
+	delete_json_obj();
+	return ret;
 }
 
 /* EEE_SET */
-- 
2.39.2


