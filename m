Return-Path: <netdev+bounces-100190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5C8D819B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D4F1C2144F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377888612E;
	Mon,  3 Jun 2024 11:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8C84D06
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415561; cv=none; b=SfFAGNSzeoo2Em5eNSg829Y001JrBtmoO3dczhLJYovhCKTTnM0W9LZRxafwZOxciaLVATBl3Dly4drkNnLSbSaC58bC7icl2AfArVtOsv7WhTqG1EBsLZEtrUAbkKwT362pV3AgKKE2FkRzGop5RorTOtuMq8Ll4nrKIPgFPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415561; c=relaxed/simple;
	bh=2ndrjIrlrVKC2aqjAPl5MDLAMZXVZCpspHyRHuBJKDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOJaP3EPqosCTZt5jjYLkfzsBkGwP/9PBaU2AZpa2KRE5Sfmds/7TZrCu30+SuU54bEGYE5aoup4YyFAkpRdhsPHbTV9I0CKIKspkAhQvnlKOkMsdPIHehsNE7SwkSBfoJHW6bIyWWJUaLAv/3WuxALOR9EIIjlXb01JfTNYScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1sE6El-0001ub-Jt; Mon, 03 Jun 2024 13:52:27 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <fpf@pengutronix.de>)
	id 1sE6El-0004In-4v; Mon, 03 Jun 2024 13:52:27 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1sE6El-00HCkC-0L;
	Mon, 03 Jun 2024 13:52:27 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: mkubecek@suse.cz,
	netdev@vger.kernel.org
Cc: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH ethtool 1/2]: add json support for base command
Date: Mon,  3 Jun 2024 13:44:42 +0200
Message-Id: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Most subcommands already implement json support for their output. The
base command (without supplying any subcommand) still lacks this
option. This patch implments the needed changes to get json output,
which is printed via "ethtool --json [iface]"

The following design decision were made during implementation:
- json values like Yes/No are printed as true/false
- values that are "Unknown" are not printed at all
- all other json values are not changed
- keys are printed in lowercase with dashes in between

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 common.c           |  70 ++++++++----
 ethtool.c          |   1 +
 netlink/eee.c      |   6 +-
 netlink/netlink.h  |   2 +-
 netlink/settings.c | 263 ++++++++++++++++++++++++++++-----------------
 test-cmdline.c     |   1 +
 6 files changed, 222 insertions(+), 121 deletions(-)

diff --git a/common.c b/common.c
index b8fd4d5..4fda4b4 100644
--- a/common.c
+++ b/common.c
@@ -5,6 +5,7 @@
  */
 
 #include "internal.h"
+#include "json_print.h"
 #include "common.h"
 
 #ifndef HAVE_NETIF_MSG
@@ -129,21 +130,28 @@ static char *unparse_wolopts(int wolopts)
 
 int dump_wol(struct ethtool_wolinfo *wol)
 {
-	fprintf(stdout, "	Supports Wake-on: %s\n",
-		unparse_wolopts(wol->supported));
-	fprintf(stdout, "	Wake-on: %s\n",
-		unparse_wolopts(wol->wolopts));
+	print_string(PRINT_ANY, "supports-wake-on",
+		    "	Supports Wake-on: %s\n", unparse_wolopts(wol->supported));
+	print_string(PRINT_ANY, "wake-on",
+		    "	Wake-on: %s\n", unparse_wolopts(wol->wolopts));
+
 	if (wol->supported & WAKE_MAGICSECURE) {
 		int i;
 		int delim = 0;
 
-		fprintf(stdout, "        SecureOn password: ");
+		open_json_array("secureon-password", "");
+		if (!is_json_context())
+			fprintf(stdout, "        SecureOn password: ");
 		for (i = 0; i < SOPASS_MAX; i++) {
-			fprintf(stdout, "%s%02x", delim ? ":" : "",
-				wol->sopass[i]);
+			__u8 sopass = wol->sopass[i];
+
+			if (!is_json_context())
+				fprintf(stdout, "%s%02x", delim ? ":" : "", sopass);
+			else
+				print_hex(PRINT_JSON, NULL, "%02u", sopass);
 			delim = 1;
 		}
-		fprintf(stdout, "\n");
+		close_json_array("\n");
 	}
 
 	return 0;
@@ -151,26 +159,50 @@ int dump_wol(struct ethtool_wolinfo *wol)
 
 void dump_mdix(u8 mdix, u8 mdix_ctrl)
 {
-	fprintf(stdout, "	MDI-X: ");
+	bool mdi_x = false;
+	bool mdi_x_forced = false;
+	bool mdi_x_auto = false;
+
 	if (mdix_ctrl == ETH_TP_MDI) {
-		fprintf(stdout, "off (forced)\n");
+		mdi_x = false;
+		mdi_x_forced = true;
 	} else if (mdix_ctrl == ETH_TP_MDI_X) {
-		fprintf(stdout, "on (forced)\n");
+		mdi_x = true;
+		mdi_x_forced = true;
 	} else {
 		switch (mdix) {
-		case ETH_TP_MDI:
-			fprintf(stdout, "off");
-			break;
 		case ETH_TP_MDI_X:
-			fprintf(stdout, "on");
+			mdi_x = true;
 			break;
 		default:
-			fprintf(stdout, "Unknown");
-			break;
+			print_string(PRINT_FP, NULL, "\tMDI-X: %s\n", "Unknown");
+			return;
 		}
 		if (mdix_ctrl == ETH_TP_MDI_AUTO)
-			fprintf(stdout, " (auto)");
-		fprintf(stdout, "\n");
+			mdi_x_auto = true;
+	}
+
+	if (is_json_context()) {
+		print_bool(PRINT_JSON, "mdi-x", NULL, mdi_x);
+		print_bool(PRINT_JSON, "mdi-x-forced", NULL, mdi_x_forced);
+		print_bool(PRINT_JSON, "mdi-x-auto", NULL, mdi_x_auto);
+	} else {
+		fprintf(stdout, "	MDI-X: ");
+		if (mdi_x_forced) {
+			if (mdi_x)
+				fprintf(stdout, "on (forced)\n");
+			else
+				fprintf(stdout, "off (forced)\n");
+		} else {
+			if (mdi_x)
+				fprintf(stdout, "on");
+			else
+				fprintf(stdout, "off");
+
+			if (mdi_x_auto)
+				fprintf(stdout, " (auto)");
+			fprintf(stdout, "\n");
+		}
 	}
 }
 
diff --git a/ethtool.c b/ethtool.c
index e587597..73c26e2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5731,6 +5731,7 @@ static const struct option args[] = {
 	{
 		/* "default" entry when no switch is used */
 		.opts	= "",
+		.json	= true,
 		.func	= do_gset,
 		.nlfunc	= nl_gset,
 		.help	= "Display standard information about device",
diff --git a/netlink/eee.c b/netlink/eee.c
index 04d8f0b..6c53756 100644
--- a/netlink/eee.c
+++ b/netlink/eee.c
@@ -69,19 +69,19 @@ int eee_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	ret = dump_link_modes(nlctx, tb[ETHTOOL_A_EEE_MODES_OURS], true,
 			      LM_CLASS_REAL,
 			      "Supported EEE link modes:  ", NULL, "\n",
-			      "Not reported");
+			      "Not reported", "supported-eee-link-modes");
 	if (ret < 0)
 		return err_ret;
 	ret = dump_link_modes(nlctx, tb[ETHTOOL_A_EEE_MODES_OURS], false,
 			      LM_CLASS_REAL,
 			      "Advertised EEE link modes:  ", NULL, "\n",
-			      "Not reported");
+			      "Not reported", "advertised-eee-link-modes");
 	if (ret < 0)
 		return err_ret;
 	ret = dump_link_modes(nlctx, tb[ETHTOOL_A_EEE_MODES_PEER], false,
 			      LM_CLASS_REAL,
 			      "Link partner advertised EEE link modes:  ", NULL,
-			      "\n", "Not reported");
+			      "\n", "Not reported", "link-partner-advertised-eee-link-modes");
 	if (ret < 0)
 		return err_ret;
 
diff --git a/netlink/netlink.h b/netlink/netlink.h
index 1274a3b..4a4b68b 100644
--- a/netlink/netlink.h
+++ b/netlink/netlink.h
@@ -98,7 +98,7 @@ int module_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int dump_link_modes(struct nl_context *nlctx, const struct nlattr *bitset,
 		    bool mask, unsigned int class, const char *before,
 		    const char *between, const char *after,
-		    const char *if_none);
+		    const char *if_none, const char *json_key);
 
 static inline void show_u32(const char *key,
 			    const char *fmt,
diff --git a/netlink/settings.c b/netlink/settings.c
index a506618..b2aef4b 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -11,6 +11,8 @@
 
 #include "../internal.h"
 #include "../common.h"
+#include "json_print.h"
+#include "json_writer.h"
 #include "netlink.h"
 #include "strset.h"
 #include "bitset.h"
@@ -192,15 +194,21 @@ static bool lm_class_match(unsigned int mode, enum link_mode_class class)
 }
 
 static void print_enum(const char *const *info, unsigned int n_info,
-		       unsigned int val, const char *label)
+		       unsigned int val, const char *label, const char *json_key)
 {
-	if (val >= n_info || !info[val])
-		printf("\t%s: Unknown! (%d)\n", label, val);
-	else
-		printf("\t%s: %s\n", label, info[val]);
+	if (val >= n_info || !info[val]) {
+		if (!is_json_context())
+			printf("\t%s: Unknown! (%d)\n", label, val);
+	} else {
+		if (!is_json_context())
+			printf("\t%s: %s\n", label, info[val]);
+		else
+			print_string(PRINT_JSON, json_key, "%s", info[val]);
+	}
 }
 
-static int dump_pause(const struct nlattr *attr, bool mask, const char *label)
+static int dump_pause(const struct nlattr *attr, bool mask, const char *label,
+		      const char *label_json)
 {
 	bool pause, asym;
 	int ret = 0;
@@ -213,11 +221,13 @@ static int dump_pause(const struct nlattr *attr, bool mask, const char *label)
 	if (ret < 0)
 		goto err;
 
-	printf("\t%s", label);
+	if (!is_json_context())
+		printf("\t%s", label);
 	if (pause)
-		printf("%s\n", asym ?  "Symmetric Receive-only" : "Symmetric");
+		print_string(PRINT_ANY, label_json, "%s\n",
+			     asym ?  "Symmetric Receive-only" : "Symmetric");
 	else
-		printf("%s\n", asym ? "Transmit-only" : "No");
+		print_string(PRINT_ANY, label_json, "%s\n", asym ? "Transmit-only" : "No");
 
 	return 0;
 err:
@@ -229,13 +239,14 @@ static void print_banner(struct nl_context *nlctx)
 {
 	if (nlctx->no_banner)
 		return;
-	printf("Settings for %s:\n", nlctx->devname);
+	print_string(PRINT_ANY, "ifname", "Settings for %s:\n", nlctx->devname);
 	nlctx->no_banner = true;
 }
 
 int dump_link_modes(struct nl_context *nlctx, const struct nlattr *bitset,
 		    bool mask, unsigned int class, const char *before,
-		    const char *between, const char *after, const char *if_none)
+		    const char *between, const char *after, const char *if_none,
+			const char *json_key)
 {
 	const struct nlattr *bitset_tb[ETHTOOL_A_BITSET_MAX + 1] = {};
 	DECLARE_ATTR_TB_INFO(bitset_tb);
@@ -260,6 +271,7 @@ int dump_link_modes(struct nl_context *nlctx, const struct nlattr *bitset,
 
 	bits = bitset_tb[ETHTOOL_A_BITSET_BITS];
 
+	open_json_array(json_key, "");
 	if (!bits) {
 		const struct stringset *lm_strings;
 		unsigned int count;
@@ -280,7 +292,9 @@ int dump_link_modes(struct nl_context *nlctx, const struct nlattr *bitset,
 		if (mnl_attr_get_payload_len(bits) / 4 < (count + 31) / 32)
 			goto err_nonl;
 
-		printf("\t%s", before);
+		if (!is_json_context())
+			printf("\t%s", before);
+
 		for (idx = 0; idx < count; idx++) {
 			const uint32_t *raw_data = mnl_attr_get_payload(bits);
 			char buff[14];
@@ -298,21 +312,27 @@ int dump_link_modes(struct nl_context *nlctx, const struct nlattr *bitset,
 				first = false;
 			/* ugly hack to preserve old output format */
 			if (class == LM_CLASS_REAL && (idx == prev + 1) &&
-			    prev < link_modes_count &&
-			    link_modes[prev].class == LM_CLASS_REAL &&
-			    link_modes[prev].duplex == DUPLEX_HALF)
-				putchar(' ');
-			else if (between)
-				printf("\t%s", between);
+				prev < link_modes_count &&
+				link_modes[prev].class == LM_CLASS_REAL &&
+				link_modes[prev].duplex == DUPLEX_HALF) {
+				if (!is_json_context())
+					putchar(' ');
+			} else if (between) {
+				if (!is_json_context())
+					printf("\t%s", between);
+			}
 			else
-				printf("\n\t%*s", before_len, "");
-			printf("%s", name);
+				if (!is_json_context())
+					printf("\n\t%*s", before_len, "");
+			print_string(PRINT_ANY, NULL, "%s", name);
 			prev = idx;
 		}
 		goto after;
 	}
 
-	printf("\t%s", before);
+	if (!is_json_context())
+		printf("\t%s", before);
+
 	mnl_attr_for_each_nested(bit, bits) {
 		const struct nlattr *tb[ETHTOOL_A_BITSET_BIT_MAX + 1] = {};
 		DECLARE_ATTR_TB_INFO(tb);
@@ -342,27 +362,31 @@ int dump_link_modes(struct nl_context *nlctx, const struct nlattr *bitset,
 			if ((class == LM_CLASS_REAL) && (idx == prev + 1) &&
 			    (prev < link_modes_count) &&
 			    (link_modes[prev].class == LM_CLASS_REAL) &&
-			    (link_modes[prev].duplex == DUPLEX_HALF))
-				putchar(' ');
-			else if (between)
-				printf("\t%s", between);
+			    (link_modes[prev].duplex == DUPLEX_HALF)) {
+				if (!is_json_context())
+					putchar(' ');
+			} else if (between) {
+				if (!is_json_context())
+					printf("\t%s", between);
+			}
 			else
-				printf("\n\t%*s", before_len, "");
+				if (!is_json_context())
+					printf("\n\t%*s", before_len, "");
 		}
-		printf("%s", name);
+		print_string(PRINT_ANY, NULL, "%s", name);
 		prev = idx;
 	}
 after:
 	if (first && if_none)
-		printf("%s", if_none);
-	printf("%s", after);
-
+		print_string(PRINT_FP, NULL, "%s", if_none);
+	close_json_array(after);
 	return 0;
 err:
 	putchar('\n');
 err_nonl:
 	fflush(stdout);
 	fprintf(stderr, "malformed netlink message (link_modes)\n");
+	close_json_array("");
 	return ret;
 }
 
@@ -373,16 +397,16 @@ static int dump_our_modes(struct nl_context *nlctx, const struct nlattr *attr)
 
 	print_banner(nlctx);
 	ret = dump_link_modes(nlctx, attr, true, LM_CLASS_PORT,
-			      "Supported ports: [ ", " ", " ]\n", NULL);
+			      "Supported ports: [ ", " ", " ]\n", NULL, "supported-ports");
 	if (ret < 0)
 		return ret;
 
 	ret = dump_link_modes(nlctx, attr, true, LM_CLASS_REAL,
 			      "Supported link modes:   ", NULL, "\n",
-			      "Not reported");
+			      "Not reported", "supported-link-modes");
 	if (ret < 0)
 		return ret;
-	ret = dump_pause(attr, true, "Supported pause frame use: ");
+	ret = dump_pause(attr, true, "Supported pause frame use: ", "supported-pause-frame-use");
 	if (ret < 0)
 		return ret;
 
@@ -390,32 +414,40 @@ static int dump_our_modes(struct nl_context *nlctx, const struct nlattr *attr)
 				 &ret);
 	if (ret < 0)
 		return ret;
-	printf("\tSupports auto-negotiation: %s\n", autoneg ? "Yes" : "No");
+
+	if (is_json_context())
+		print_bool(PRINT_JSON, "supports-auto-negotiation", NULL, autoneg);
+	else
+		printf("\tSupports auto-negotiation: %s\n", autoneg ? "Yes" : "No");
 
 	ret = dump_link_modes(nlctx, attr, true, LM_CLASS_FEC,
 			      "Supported FEC modes: ", " ", "\n",
-			      "Not reported");
+			      "Not reported", "supported-fec-modes");
 	if (ret < 0)
 		return ret;
 
 	ret = dump_link_modes(nlctx, attr, false, LM_CLASS_REAL,
 			      "Advertised link modes:  ", NULL, "\n",
-			      "Not reported");
+			      "Not reported", "advertised-link-modes");
 	if (ret < 0)
 		return ret;
 
-	ret = dump_pause(attr, false, "Advertised pause frame use: ");
+	ret = dump_pause(attr, false, "Advertised pause frame use: ", "advertised-pause-frame-use");
 	if (ret < 0)
 		return ret;
 	autoneg = bitset_get_bit(attr, false, ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 &ret);
 	if (ret < 0)
 		return ret;
-	printf("\tAdvertised auto-negotiation: %s\n", autoneg ? "Yes" : "No");
+
+	if (!is_json_context())
+		printf("\tAdvertised auto-negotiation: %s\n", autoneg ? "Yes" : "No");
+	else
+		print_bool(PRINT_JSON, "advertised-auto-negotiation", NULL, autoneg);
 
 	ret = dump_link_modes(nlctx, attr, false, LM_CLASS_FEC,
 			      "Advertised FEC modes: ", " ", "\n",
-			      "Not reported");
+			      "Not reported", "advertised-fec-modes");
 	return ret;
 }
 
@@ -427,12 +459,13 @@ static int dump_peer_modes(struct nl_context *nlctx, const struct nlattr *attr)
 	print_banner(nlctx);
 	ret = dump_link_modes(nlctx, attr, false, LM_CLASS_REAL,
 			      "Link partner advertised link modes:  ",
-			      NULL, "\n", "Not reported");
+			      NULL, "\n", "Not reported", "link-partner-advertised-link-modes");
 	if (ret < 0)
 		return ret;
 
 	ret = dump_pause(attr, false,
-			 "Link partner advertised pause frame use: ");
+			 "Link partner advertised pause frame use: ",
+			 "link-partner-advertised-pause-frame-use");
 	if (ret < 0)
 		return ret;
 
@@ -440,12 +473,16 @@ static int dump_peer_modes(struct nl_context *nlctx, const struct nlattr *attr)
 				 ETHTOOL_LINK_MODE_Autoneg_BIT, &ret);
 	if (ret < 0)
 		return ret;
-	printf("\tLink partner advertised auto-negotiation: %s\n",
-	       autoneg ? "Yes" : "No");
+
+	if (!is_json_context())
+		print_string(PRINT_FP, NULL, "\tLink partner advertised auto-negotiation: %s\n",
+			autoneg ? "Yes" : "No");
+	else
+		print_bool(PRINT_JSON, "link-partner-advertised-auto-negotiation", NULL, autoneg);
 
 	ret = dump_link_modes(nlctx, attr, false, LM_CLASS_FEC,
 			      "Link partner advertised FEC modes: ",
-			      " ", "\n", "Not reported");
+			      " ", "\n", "Not reported", "link-partner-advertised-fec-modes");
 	return ret;
 }
 
@@ -479,30 +516,36 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		uint32_t val = mnl_attr_get_u32(tb[ETHTOOL_A_LINKMODES_SPEED]);
 
 		print_banner(nlctx);
-		if (val == 0 || val == (uint16_t)(-1) || val == (uint32_t)(-1))
-			printf("\tSpeed: Unknown!\n");
-		else
-			printf("\tSpeed: %uMb/s\n", val);
+		if (val == 0 || val == (uint16_t)(-1) || val == (uint32_t)(-1)) {
+			if (!is_json_context())
+				printf("\tSpeed: Unknown!\n");
+		} else {
+			print_uint(PRINT_ANY, "speed", "\tSpeed: %uMb/s\n", val);
+		}
 	}
 	if (tb[ETHTOOL_A_LINKMODES_LANES]) {
 		uint32_t val = mnl_attr_get_u32(tb[ETHTOOL_A_LINKMODES_LANES]);
 
 		print_banner(nlctx);
-		printf("\tLanes: %u\n", val);
+		print_uint(PRINT_ANY, "lanes", "\tLanes: %s\n", val);
 	}
 	if (tb[ETHTOOL_A_LINKMODES_DUPLEX]) {
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKMODES_DUPLEX]);
 
 		print_banner(nlctx);
 		print_enum(names_duplex, ARRAY_SIZE(names_duplex), val,
-			   "Duplex");
+			   "Duplex", "duplex");
 	}
 	if (tb[ETHTOOL_A_LINKMODES_AUTONEG]) {
 		int autoneg = mnl_attr_get_u8(tb[ETHTOOL_A_LINKMODES_AUTONEG]);
 
 		print_banner(nlctx);
-		printf("\tAuto-negotiation: %s\n",
-		       (autoneg == AUTONEG_DISABLE) ? "off" : "on");
+		if (!is_json_context())
+			printf("\tAuto-negotiation: %s\n",
+						(autoneg == AUTONEG_DISABLE) ? "off" : "on");
+		else
+			print_bool(PRINT_JSON, "auto-negotiation", NULL,
+				   autoneg == AUTONEG_DISABLE);
 	}
 	if (tb[ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG]) {
 		uint8_t val;
@@ -512,7 +555,7 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		print_banner(nlctx);
 		print_enum(names_master_slave_cfg,
 			   ARRAY_SIZE(names_master_slave_cfg), val,
-			   "master-slave cfg");
+			   "master-slave cfg", "master-slave-cfg");
 	}
 	if (tb[ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE]) {
 		uint8_t val;
@@ -521,7 +564,7 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		print_banner(nlctx);
 		print_enum(names_master_slave_state,
 			   ARRAY_SIZE(names_master_slave_state), val,
-			   "master-slave status");
+			   "master-slave status", "master-slave-status");
 	}
 
 	return MNL_CB_OK;
@@ -554,14 +597,14 @@ int linkinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKINFO_PORT]);
 
 		print_banner(nlctx);
-		print_enum(names_port, ARRAY_SIZE(names_port), val, "Port");
+		print_enum(names_port, ARRAY_SIZE(names_port), val, "Port", "port");
 		port = val;
 	}
 	if (tb[ETHTOOL_A_LINKINFO_PHYADDR]) {
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKINFO_PHYADDR]);
 
 		print_banner(nlctx);
-		printf("\tPHYAD: %u\n", val);
+		print_uint(PRINT_ANY, "phyad", "\tPHYAD: %x\n", val);
 	}
 	if (tb[ETHTOOL_A_LINKINFO_TRANSCEIVER]) {
 		uint8_t val;
@@ -569,7 +612,7 @@ int linkinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKINFO_TRANSCEIVER]);
 		print_banner(nlctx);
 		print_enum(names_transceiver, ARRAY_SIZE(names_transceiver),
-			   val, "Transceiver");
+			   val, "Transceiver", "transceiver");
 	}
 	if (tb[ETHTOOL_A_LINKINFO_TP_MDIX] && tb[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL] &&
 	    port == PORT_TP) {
@@ -714,9 +757,9 @@ static void linkstate_link_ext_substate_print(const struct nlattr *tb[],
 
 	link_ext_substate_str = link_ext_substate_get(link_ext_state_val, link_ext_substate_val);
 	if (!link_ext_substate_str)
-		printf(", %u", link_ext_substate_val);
+		print_uint(PRINT_ANY, NULL, ", %u", link_ext_state_val);
 	else
-		printf(", %s", link_ext_substate_str);
+		print_string(PRINT_ANY, NULL, ", %s", link_ext_substate_str);
 }
 
 static void linkstate_link_ext_state_print(const struct nlattr *tb[])
@@ -732,13 +775,14 @@ static void linkstate_link_ext_state_print(const struct nlattr *tb[])
 	link_ext_state_str = get_enum_string(names_link_ext_state,
 					     ARRAY_SIZE(names_link_ext_state),
 					     link_ext_state_val);
+	open_json_array("link-state", "");
 	if (!link_ext_state_str)
-		printf(" (%u", link_ext_state_val);
+		print_uint(PRINT_ANY, NULL, " (%u", link_ext_state_val);
 	else
-		printf(" (%s", link_ext_state_str);
+		print_string(PRINT_ANY, NULL, " (%s", link_ext_state_str);
 
 	linkstate_link_ext_substate_print(tb, link_ext_state_val);
-	printf(")");
+	close_json_array(")");
 }
 
 int linkstate_reply_cb(const struct nlmsghdr *nlhdr, void *data)
@@ -761,24 +805,29 @@ int linkstate_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKSTATE_LINK]);
 
 		print_banner(nlctx);
-		printf("\tLink detected: %s", val ? "yes" : "no");
+		if (!is_json_context())
+			print_string(PRINT_FP, NULL, "\tLink detected: %s", val ? "yes" : "no");
+		else
+			print_bool(PRINT_JSON, "link-detected", NULL, val);
 		linkstate_link_ext_state_print(tb);
-		printf("\n");
+		if (!is_json_context())
+			printf("\n");
 	}
 
 	if (tb[ETHTOOL_A_LINKSTATE_SQI]) {
 		uint32_t val = mnl_attr_get_u32(tb[ETHTOOL_A_LINKSTATE_SQI]);
 
 		print_banner(nlctx);
-		printf("\tSQI: %u", val);
+		print_uint(PRINT_ANY, "sqi", "\tSQI: %u", val);
 
 		if (tb[ETHTOOL_A_LINKSTATE_SQI_MAX]) {
 			uint32_t max;
 
 			max = mnl_attr_get_u32(tb[ETHTOOL_A_LINKSTATE_SQI_MAX]);
-			printf("/%u\n", max);
+			print_uint(PRINT_ANY, "sqi-max", "/%u\n", max);
 		} else {
-			printf("\n");
+			if (!is_json_context())
+				printf("\n");
 		}
 	}
 
@@ -786,7 +835,7 @@ int linkstate_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		uint32_t val;
 
 		val = mnl_attr_get_u32(tb[ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT]);
-		printf("\tLink Down Events: %u\n", val);
+		print_uint(PRINT_ANY, "link-down-events", "\tLink Down Events: %u\n", val);
 	}
 
 	return MNL_CB_OK;
@@ -856,7 +905,7 @@ void msgmask_cb2(unsigned int idx __maybe_unused, const char *name,
 		 bool val, void *data __maybe_unused)
 {
 	if (val)
-		printf(" %s", name);
+		print_string(PRINT_FP, NULL, " %s", name);
 }
 
 int debug_reply_cb(const struct nlmsghdr *nlhdr, void *data)
@@ -889,13 +938,16 @@ int debug_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 
 	print_banner(nlctx);
 	walk_bitset(tb[ETHTOOL_A_DEBUG_MSGMASK], NULL, msgmask_cb, &msg_mask);
-	printf("        Current message level: 0x%08x (%u)\n"
-	       "                              ",
-	       msg_mask, msg_mask);
+
+	print_uint(PRINT_ANY, "current-message-level",
+		   "        Current message level: 0x%1$08x (%1$u)\n                              ",
+		   msg_mask);
+
 	walk_bitset(tb[ETHTOOL_A_DEBUG_MSGMASK], msgmask_strings, msgmask_cb2,
-		    NULL);
-	fputc('\n', stdout);
+			NULL);
 
+	if (!is_json_context())
+		fputc('\n', stdout);
 	return MNL_CB_OK;
 }
 
@@ -916,18 +968,26 @@ int plca_cfg_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		return MNL_CB_OK;
 
 	print_banner(nlctx);
-	printf("\tPLCA support: ");
+	if (!is_json_context())
+		printf("\tPLCA support: ");
 
 	if (tb[ETHTOOL_A_PLCA_VERSION]) {
 		uint16_t val = mnl_attr_get_u16(tb[ETHTOOL_A_PLCA_VERSION]);
 
-		printf("OPEN Alliance v%u.%u",
+		if (!is_json_context()) {
+			printf("OPEN Alliance v%u.%u\n",
 		       (unsigned int)((val >> 4) & 0xF),
 		       (unsigned int)(val & 0xF));
-	} else
-		printf("non-standard");
+		} else {
+			unsigned int length = snprintf(NULL, 0, "%1$u.%1$u", val);
+			char buff[length];
 
-	printf("\n");
+			snprintf(buff, length, "%u.%u", (unsigned int)((val >> 4) & 0xF),
+				(unsigned int)(val & 0xF));
+			print_string(PRINT_JSON, "open-alliance-v", NULL, buff);
+		}
+	} else
+		print_string(PRINT_ANY, "plca-support", "%s\n", "non-standard");
 
 	return MNL_CB_OK;
 }
@@ -949,16 +1009,14 @@ int plca_status_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		return MNL_CB_OK;
 
 	print_banner(nlctx);
-	printf("\tPLCA status: ");
-
+	const char *status;
 	if (tb[ETHTOOL_A_PLCA_STATUS]) {
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_PLCA_STATUS]);
-
-		printf(val ? "up" : "down");
-	} else
-		printf("unknown");
-
-	printf("\n");
+		status = val ? "up" : "down";
+		print_string(PRINT_ANY, "plca-status", "PLCA status: %s", status);
+	} else {
+		print_string(PRINT_FP, NULL, "PLCA status: %s", "unknown");
+	}
 
 	return MNL_CB_OK;
 }
@@ -984,7 +1042,10 @@ static int gset_request(struct cmd_context *ctx, uint8_t msg_type,
 
 int nl_gset(struct cmd_context *ctx)
 {
-	int ret;
+	int ret = 0;
+
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
 
 	/* Check for the base set of commands */
 	if (netlink_cmd_check(ctx, ETHTOOL_MSG_LINKMODES_GET, true) ||
@@ -999,44 +1060,50 @@ int nl_gset(struct cmd_context *ctx)
 	ret = gset_request(ctx, ETHTOOL_MSG_LINKMODES_GET,
 			   ETHTOOL_A_LINKMODES_HEADER, linkmodes_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	ret = gset_request(ctx, ETHTOOL_MSG_LINKINFO_GET,
 			   ETHTOOL_A_LINKINFO_HEADER, linkinfo_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	ret = gset_request(ctx, ETHTOOL_MSG_WOL_GET, ETHTOOL_A_WOL_HEADER,
 			   wol_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	ret = gset_request(ctx, ETHTOOL_MSG_PLCA_GET_CFG,
 			   ETHTOOL_A_PLCA_HEADER, plca_cfg_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	ret = gset_request(ctx, ETHTOOL_MSG_DEBUG_GET, ETHTOOL_A_DEBUG_HEADER,
 			   debug_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	ret = gset_request(ctx, ETHTOOL_MSG_LINKSTATE_GET,
 			   ETHTOOL_A_LINKSTATE_HEADER, linkstate_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	ret = gset_request(ctx, ETHTOOL_MSG_PLCA_GET_STATUS,
 			   ETHTOOL_A_PLCA_HEADER, plca_status_reply_cb);
 	if (ret == -ENODEV)
-		return ret;
+		goto out;
 
 	if (!ctx->nlctx->no_banner) {
-		printf("No data available\n");
-		return 75;
+		print_string(PRINT_FP, NULL, "%s", "No data available\n");
+		ret = 75;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	close_json_object();
+	delete_json_obj();
+	return ret;
 }
 
 /* SET_SETTINGS */
diff --git a/test-cmdline.c b/test-cmdline.c
index cb803ed..daa7829 100644
--- a/test-cmdline.c
+++ b/test-cmdline.c
@@ -25,6 +25,7 @@ static struct test_case {
 	{ 1, "" },
 	{ 0, "devname" },
 	{ 0, "15_char_devname" },
+	{ 0, "--json devname" },
 	/* netlink interface allows names up to 127 characters */
 	{ !IS_NL, "16_char_devname!" },
 	{ !IS_NL, "127_char_devname0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcde" },
-- 
2.39.2


