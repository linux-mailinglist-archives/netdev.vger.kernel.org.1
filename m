Return-Path: <netdev+bounces-249463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA15D19658
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3431E300DA4B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603F283C87;
	Tue, 13 Jan 2026 14:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEF259C9C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314038; cv=none; b=m+2QtOCEDyKtiRW/g2gZNdCd4xFDoJsU75Pou8u98qxkmIDO6kSnKb5c0ILIJ9IuybasBKqyFlncsyljr/HBb8R+Ta5WmnN57P4fZss8c/fpFoAX5QCCf1yltYD43fBV3v9Q2t2OEwF4XbmwV/GeiEcB/Q1YWj9/eJc0KQR1Sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314038; c=relaxed/simple;
	bh=VQX7ugOC0oOhY6597obs7YiCyso3ieb7MemWr3gz86c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mq3aFwLSJQbzu1BqkaJ29YVq58Qifbn6IUEYL6Bwkyi9MOOY1WsmtxGH7J0+CWtiSFXE830YCSWL2V8d1l9juTaPcjAH77HgoIggRBV1t5Sba3b9jQhIm+n1eHLDJ6YIUBXS/8vThHF1PEucxmiJOhvZEdPf6dHGFrrioLjW5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vffG4-0005Gp-MR; Tue, 13 Jan 2026 15:20:32 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vffG5-000RCs-0U;
	Tue, 13 Jan 2026 15:20:32 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vffG4-00000002Kan-1kh9;
	Tue, 13 Jan 2026 15:20:32 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH ethtool v1] ethtool: add --show-mse netlink support
Date: Tue, 13 Jan 2026 15:20:31 +0100
Message-ID: <20260113142031.555787-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add support for querying PHY Mean Square Error (MSE) diagnostics via
ETHTOOL_MSG_MSE_GET. This exposes MSE capability information and the
latest available snapshots for supported PHYs.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Makefile.am      |   1 +
 ethtool.8.in     |  46 ++++++
 ethtool.c        |   7 +
 netlink/extapi.h |   2 +
 netlink/mse.c    | 388 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 444 insertions(+)
 create mode 100644 netlink/mse.c

diff --git a/Makefile.am b/Makefile.am
index c58325c71a82..524b0922fd62 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -55,6 +55,7 @@ ethtool_SOURCES += \
 		  netlink/pse-pd.c \
 		  netlink/phy.c \
 		  netlink/tsconfig.c \
+		  netlink/mse.c \
 		  uapi/linux/ethtool_netlink.h \
 		  uapi/linux/ethtool_netlink_generated.h \
 		  uapi/linux/netlink.h uapi/linux/genetlink.h \
diff --git a/ethtool.8.in b/ethtool.8.in
index 0aafb4b0321b..e73f8e7cfcca 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -639,6 +639,7 @@ lB	l.
 \-\-get\-plca\-status
 \-\-show-pse
 \-\-set-pse
+\-\-show-mse
 .TE
 .TP
 .B \-a \-\-show\-pause
@@ -1977,6 +1978,51 @@ When a single domain exceeds its budget, ports in that domain are
 powered up/down by priority (highest first for power-up; lowest shed
 first).

+.RE
+.TP
+.B \-\-show\-mse
+Show PHY Mean Square Error (MSE) diagnostics.
+.RS 4
+.P
+Metrics follow the OPEN Alliance PHY diagnostics model (used by automotive and
+industrial PHYs). Numeric scaling, sampling windows, and update intervals are
+vendor specific and reported by the capability block.
+.P
+Values are raw snapshots from the PHY DSP. Lower values generally indicate
+better signal quality; 0 is ideal. Interpret values relative to the reported
+max-* scales for this PHY and link mode.
+.P
+The set of returned channels depends on PHY support. When per-channel data is
+available, Channel A/B/C/D nests are returned. Otherwise, the kernel may return
+a single WORST or LINK aggregate snapshot.
+.TP
+.B Capabilities
+Driver-provided scale and timing:
+.RS 4
+.TP
+.B max\-average\-mse
+Scale for average MSE values.
+.TP
+.B max\-peak\-mse
+Scale for peak MSE values. Present only if the PHY reports peak-mse and/or
+worst-peak-mse.
+.TP
+.B refresh\-rate\-ps
+Typical hardware update interval in picoseconds.
+.TP
+.B symbols\-per\-sample
+Number of symbols collected per hardware sample.
+.RE
+.TP
+.B Snapshots
+One nest per selector (Channel A/B/C/D, WORST, or LINK). Each contains the
+metrics supported by the PHY: average-mse and optionally peak-mse and/or
+worst-peak-mse. Values are raw and must be interpreted using the capability
+scales above.
+.P
+Short windows (low refresh-rate-ps or few symbols-per-sample) can yield high
+variance; userspace can improve stability by polling and averaging over time.
+
 .RE
 .TP
 .B \-\-flash\-module\-firmware
diff --git a/ethtool.c b/ethtool.c
index 86214581e55f..c9c15023f8b2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6371,6 +6371,13 @@ static const struct option args[] = {
 		.nlfunc	= nl_get_phy,
 		.help	= "List PHYs"
 	},
+	{
+		.opts	= "--show-mse",
+		.targets_phy	= true,
+		.json	= true,
+		.nlfunc	= nl_gmse,
+		.help	= "Show Mean Square Error (MSE) diagnostics",
+	},
 	{
 		.opts	= "-h|--help",
 		.no_dev	= true,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index f2bf422a3f2d..b0e458804297 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -59,6 +59,7 @@ int nl_gpse(struct cmd_context *ctx);
 int nl_spse(struct cmd_context *ctx);
 int nl_flash_module_fw(struct cmd_context *ctx);
 int nl_get_phy(struct cmd_context *ctx);
+int nl_gmse(struct cmd_context *ctx);

 void nl_monitor_usage(void);

@@ -138,6 +139,7 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_spse			NULL
 #define nl_flash_module_fw	NULL
 #define nl_get_phy		NULL
+#define nl_gmse			NULL

 #endif /* ETHTOOL_ENABLE_NETLINK */

diff --git a/netlink/mse.c b/netlink/mse.c
new file mode 100644
index 000000000000..cca0c1f272f5
--- /dev/null
+++ b/netlink/mse.c
@@ -0,0 +1,388 @@
+/*
+ * Implementation of "ethtool --show-mse <dev>"
+ *
+ * Background:
+ * - Kernel MSE GET is defined in Documentation/netlink/specs/ethtool.yaml
+ *   and implemented in net/ethtool/mse.c.
+ * - Capabilities describe scale and timing for MSE readings:
+ *     max-average-mse / max-peak-mse : scale
+ *     refresh-rate-ps                : nominal update interval (picoseconds)
+ *     num-symbols                    : symbols per sample window
+ *   These two timing fields are mandatory in the kernel reply; limits are
+ *   present only when the corresponding metrics are supported.
+ * - Metrics originate from OPEN Alliance PHY diagnostics (100/1000BASE-T1),
+ *   but scaling, windows, and refresh reate are vendor-specific; the
+ *   capability block reports the implementation details provided by the PHY
+ *   driver.
+ * - Snapshots carry per-channel values (A-D, WORST, LINK) chosen by the
+ *   kernel in priority order (per-channel first, else WORST, else LINK).
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
+#include "parser.h"
+
+enum mse_attr_kind {
+	MSE_ATTR_HEADER,
+	MSE_ATTR_CAPS,
+	MSE_ATTR_SNAPSHOT,
+	MSE_ATTR_UNKNOWN,
+};
+
+struct mse_field_desc {
+	uint16_t attr;
+	const char *json_key;
+	const char *plain_fmt;
+	bool required;
+};
+
+static const struct mse_field_desc mse_cap_fields[] = {
+	{
+		.attr = ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
+		.json_key = "refresh-rate-ps",
+		.plain_fmt = "\tRefresh Rate: %" PRIu64 " ps\n",
+		.required = true,
+	},
+	{
+		.attr = ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
+		.json_key = "symbols-per-sample",
+		.plain_fmt = "\tSymbols per Sample: %" PRIu64 "\n",
+		.required = true,
+	},
+	{
+		.attr = ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE,
+		.json_key = "max-average-mse",
+		.plain_fmt = "\tMax Average MSE: %" PRIu64 "\n",
+		.required = false,
+	},
+	{
+		.attr = ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
+		.json_key = "max-peak-mse",
+		.plain_fmt = "\tMax Peak MSE: %" PRIu64 "\n",
+		.required = false,
+	},
+};
+
+static const struct mse_field_desc mse_snapshot_fields[] = {
+	{
+		.attr = ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE,
+		.json_key = "average-mse",
+		.plain_fmt = "\tAverage MSE: %" PRIu64 "\n",
+		.required = false,
+	},
+	{
+		.attr = ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+		.json_key = "peak-mse",
+		.plain_fmt = "\tPeak MSE: %" PRIu64 "\n",
+		.required = false,
+	},
+	{
+		.attr = ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+		.json_key = "worst-peak-mse",
+		.plain_fmt = "\tWorst-Peak MSE: %" PRIu64 "\n",
+		.required = false,
+	},
+};
+
+static enum mse_attr_kind mse_classify_attr(uint16_t at)
+{
+	switch (at) {
+	case ETHTOOL_A_MSE_HEADER:
+		return MSE_ATTR_HEADER;
+	case ETHTOOL_A_MSE_CAPABILITIES:
+		return MSE_ATTR_CAPS;
+	case ETHTOOL_A_MSE_CHANNEL_A:
+	case ETHTOOL_A_MSE_CHANNEL_B:
+	case ETHTOOL_A_MSE_CHANNEL_C:
+	case ETHTOOL_A_MSE_CHANNEL_D:
+	case ETHTOOL_A_MSE_WORST_CHANNEL:
+	case ETHTOOL_A_MSE_LINK:
+		return MSE_ATTR_SNAPSHOT;
+	default:
+		return MSE_ATTR_UNKNOWN;
+	}
+}
+
+/* Validate presence (if required) and width of integer attrs, then fetch the
+ * value. The kernel uses nla_put_uint(), which may encode values in
+ * 8/16/32/64-bit payloads; rely on attr_get_uint() for size handling.
+ * @present reports whether the attribute was found.
+ *
+ * Return: 0 on success, -EINVAL/-EMSGSIZE on malformed attributes.
+ */
+static int mse_validate_get_u64_attr(const struct nlattr *attr, const char *name,
+				     bool required, u64 *val, bool *present)
+{
+	if (present)
+		*present = false;
+	if (!attr) {
+		if (required)
+			fprintf(stderr, "warning: missing %s attribute in MSE reply; skipping\n",
+				name);
+		if (val)
+			*val = 0;
+		return 0;
+	}
+
+	*val = attr_get_uint(attr);
+	if (*val == UINT64_MAX) {
+		fprintf(stderr, "invalid %s attribute size in MSE reply\n", name);
+		return -EMSGSIZE;
+	}
+	if (present)
+		*present = true;
+
+	return 0;
+}
+
+static int mse_print_fields(const struct nlattr **tb,
+			    const struct mse_field_desc *fields, size_t n,
+			    bool *has_value)
+{
+	const struct mse_field_desc *f;
+	bool present;
+	u64 val;
+	int ret;
+
+	for (f = fields; f < fields + n; f++) {
+		ret = mse_validate_get_u64_attr(tb[f->attr], f->json_key,
+						f->required, &val, &present);
+		if (ret < 0)
+			return ret;
+		if (present) {
+			print_u64(PRINT_ANY, f->json_key, f->plain_fmt, val);
+			if (has_value)
+				*has_value = true;
+		}
+	}
+
+	return 0;
+}
+
+static const char *mse_get_channel_name(uint16_t channel)
+{
+	switch (channel) {
+	case ETHTOOL_A_MSE_CHANNEL_A:
+		return "a";
+	case ETHTOOL_A_MSE_CHANNEL_B:
+		return "b";
+	case ETHTOOL_A_MSE_CHANNEL_C:
+		return "c";
+	case ETHTOOL_A_MSE_CHANNEL_D:
+		return "d";
+	case ETHTOOL_A_MSE_WORST_CHANNEL:
+		return "worst";
+	case ETHTOOL_A_MSE_LINK:
+		return "link";
+	default:
+		return "unknown";
+	}
+}
+
+static int mse_dump_capabilities(const struct nlattr *cap_attr)
+{
+	const struct nlattr *tb[ETHTOOL_A_MSE_CAPABILITIES_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	bool has_value = false;
+	int ret;
+
+	ret = mnl_attr_parse_nested(cap_attr, attr_cb, &tb_info);
+	if (ret != MNL_CB_OK) {
+		fprintf(stderr, "malformed netlink message (capabilities)\n");
+		return -EINVAL;
+	}
+
+	open_json_object("mse-capabilities");
+	if (!is_json_context())
+		printf("MSE Capabilities:\n");
+
+	/* Kernel sends max-average/peak only if corresponding PHY_MSE_CAP_* bits
+	 * are set; refresh-rate-ps and num-symbols are always present.
+	 */
+	ret = mse_print_fields(tb, mse_cap_fields, ARRAY_SIZE(mse_cap_fields),
+			       &has_value);
+
+	if (!has_value)
+		fprintf(stderr, "warning: kernel returned empty MSE capability block\n");
+
+	close_json_object();
+
+	return ret;
+}
+
+static int mse_dump_snapshot(const struct nlattr *snapshot_attr,
+			     uint16_t channel)
+{
+	const struct nlattr *tb[ETHTOOL_A_MSE_SNAPSHOT_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	const char *channel_name;
+	bool has_value = false;
+	int ret;
+
+	ret = mnl_attr_parse_nested(snapshot_attr, attr_cb, &tb_info);
+	if (ret != MNL_CB_OK) {
+		fprintf(stderr, "malformed netlink message (snapshot)\n");
+		return -EINVAL;
+	}
+
+	channel_name = mse_get_channel_name(channel);
+	print_string(PRINT_ANY, "channel", "\nMSE Snapshot (Channel: %s):\n",
+		     channel_name);
+
+	ret = mse_print_fields(tb, mse_snapshot_fields,
+			       ARRAY_SIZE(mse_snapshot_fields), &has_value);
+	if (ret < 0)
+		return ret;
+
+	if (!has_value)
+		fprintf(stderr, "warning: kernel returned empty MSE snapshot for channel %s\n",
+			channel_name);
+
+	return 0;
+}
+
+static int mse_process_snapshot_attr(const struct nlattr *attr)
+{
+	uint16_t channel = mnl_attr_get_type(attr);
+	int ret;
+
+	open_json_object(NULL);
+
+	ret = mse_dump_snapshot(attr, channel);
+
+	close_json_object();
+
+	return ret;
+}
+
+static int mse_dump_snapshots(const struct nlmsghdr *nlhdr)
+{
+	bool snapshots_started = false;
+	unsigned int unknown_cnt = 0;
+	const struct nlattr *attr;
+	int ret = 0;
+
+	/*
+	 * If the kernel provides no per-channel snapshot nests, still emit an
+	 * empty "mse-snapshots" array in JSON mode. This keeps the JSON schema
+	 * stable for consumers (always an array, possibly empty).
+	 */
+	if (is_json_context())
+		open_json_array("mse-snapshots", NULL);
+
+	/* Kernel already picks per-channel over WORST over LINK; we just dump
+	 * whatever nests are present.
+	 */
+	mnl_attr_for_each(attr, nlhdr, GENL_HDRLEN) {
+		uint16_t at = mnl_attr_get_type(attr);
+
+		switch (mse_classify_attr(at)) {
+		case MSE_ATTR_SNAPSHOT:
+			ret = mse_process_snapshot_attr(attr);
+			if (ret < 0)
+				goto out;
+
+			snapshots_started = true;
+
+			break;
+		case MSE_ATTR_UNKNOWN:
+			unknown_cnt++;
+			break;
+		case MSE_ATTR_HEADER:
+		case MSE_ATTR_CAPS:
+		default:
+			break;
+		}
+	}
+
+	if (!snapshots_started)
+		fprintf(stderr, "warning: no MSE snapshot data available from kernel\n");
+
+	if (unknown_cnt)
+		fprintf(stderr, "warning: %u unknown MSE attribute(s) ignored\n",
+			unknown_cnt);
+out:
+	if (is_json_context())
+		close_json_array(NULL);
+
+	return ret;
+}
+
+int mse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_MSE_MAX + 1] = {};
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret != MNL_CB_OK)
+		return -EINVAL;
+
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_MSE_HEADER]);
+	if (!dev_ok(nlctx))
+		return 0;
+
+	open_json_object(NULL);
+	print_string(PRINT_ANY, "ifname", "MSE diagnostics for %s:\n",
+		     nlctx->devname);
+
+	if (tb[ETHTOOL_A_MSE_CAPABILITIES]) {
+		ret = mse_dump_capabilities(tb[ETHTOOL_A_MSE_CAPABILITIES]);
+		if (ret < 0)
+			goto out;
+	} else {
+		fprintf(stderr, "warning: missing MSE capabilities; continuing with snapshots\n");
+	}
+
+	ret = mse_dump_snapshots(nlhdr);
+
+	print_nl();
+out:
+	close_json_object();
+
+	return ret;
+}
+
+int nl_gmse(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_msg_buff *msgbuff;
+	struct nl_socket *nlsk;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_MSE_GET, true))
+		return -EOPNOTSUPP;
+
+	nlctx->cmd = "--show-mse";
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	nlctx->devname = ctx->devname;
+	nlsk = nlctx->ethnl_socket;
+	msgbuff = &nlsk->msgbuff;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_MSE_GET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return ret;
+	ret = ethnla_fill_header_phy(msgbuff, ETHTOOL_A_MSE_HEADER,
+				     ctx->devname, ctx->phy_index, 0);
+	if (ret < 0)
+		return ret;
+
+	new_json_obj(ctx->json);
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		goto out;
+	ret = nlsock_process_reply(nlsk, mse_reply_cb, nlctx);
+
+out:
+	delete_json_obj();
+	return ret;
+}
--
2.47.3


