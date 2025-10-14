Return-Path: <netdev+bounces-229380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD82BDB670
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F84EAAFE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3402DF71C;
	Tue, 14 Oct 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KcVP8tWQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCE2DE202
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476907; cv=none; b=KmT1DGiS66fnDg4Mq0MkjdOtJPl2VAL50hvsGSAKhF+/0WgLlnRhK4Q8WjlV/oKqKHgUdWc+N8kuevPFXZb5SbhqnM1ZQpa8EqsW13RKTnfbxelwfpo2IqzyjBJPyWesLOYZVWuBi7hFIFzPD3O28SleP4qOnBleJfdEN9eMYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476907; c=relaxed/simple;
	bh=Kg/cKYNu75hX4cxFjLuiVFsCNzeyHrXt3FuiCvzQ5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiEgBpXlqkicySeHPzaMYS26L0AoStKQbCHFDjXzfLw/82i3+s5Nmmr2P4MqtgPsVbnjVk7gon6zIpQ4QASPenU3PGu0QIDoLc8LqwGefcKY+ZRfmg73R0a/uTwtgQr5htdP73h4OA9goGnxyFazeJ2aeBLvr9HAPJJViXO0p9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KcVP8tWQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760476902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U8dNo68ZSUoZou1dQJ6uS5OmcpwaCXlR69MzCPyrbBI=;
	b=KcVP8tWQVx42CqxBcj70ARDt3l/Bxe3uoxxc5wkITxhjXqiZuMLXiaz7wyyrL3R0Ib8TXD
	6EIYQeGdpESK0RDGMuenubDwSYX2Ev6wv9dWi3wZNmpoJVc8rm/cFdgto2rXpeZ+iAL/Ll
	AYA6VAiGTo6fj6nItWBsPUMDcCntI2o=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: mkubecek@suse.cz
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH ethtool-next v2] netlink: fec: add errors histogram statistics
Date: Tue, 14 Oct 2025 21:20:18 +0000
Message-ID: <20251014212018.7933-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Linux 6.18 has FEC errors histogram statistics API added. Add support
for extra attributes in ethtool.

 # ethtool -I --show-fec eni8np1
FEC parameters for eni8np1:
Supported/Configured FEC encodings: None
Active FEC encoding: None
Statistics:
  corrected_blocks: 123
  uncorrectable_blocks: 4
  fec_symbol_err_0: 445 [ per_lane:  125, 120, 100, 100 ]
  fec_symbol_err_1_to_3: 12
  fec_symbol_err_4_to_7: 2

 # ethtool -j -I --show-fec eni8np1
[ {
        "ifname": "eni8np1",
        "config": [ "None" ],
        "active": [ "None" ],
        "statistics": {
            "corrected_blocks": {
                "total": 123
            },
            "uncorrectable_blocks": {
                "total": 4
            },
            "hist": [ {
                    "bin_low": 0,
                    "bin_high": 0,
                    "total": 445,
                    "lanes": [ 125,120,100,100 ]
                },{
                    "bin_low": 1,
                    "bin_high": 3,
                    "total": 12
                },{
                    "bin_low": 4,
                    "bin_high": 7,
                    "total": 2
                } ]
        }
    } ]

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---

v1 -> v2:
- change field name fec_bit_error -> fec_symbol_error as by standard
- align format of blocks per-lane statistics to histogram per-lane

 netlink/fec.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/netlink/fec.c b/netlink/fec.c
index ed100d7..36ad3f5 100644
--- a/netlink/fec.c
+++ b/netlink/fec.c
@@ -44,6 +44,64 @@ fec_mode_walk(unsigned int idx, const char *name, bool val, void *data)
 	print_string(PRINT_ANY, NULL, " %s", name);
 }
 
+static void fec_show_hist_bin(const struct nlattr *hist)
+{
+	const struct nlattr *tb[ETHTOOL_A_FEC_HIST_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	unsigned int i, lanes, bin_high, bin_low;
+	uint64_t val, *vals;
+	int ret;
+
+	ret = mnl_attr_parse_nested(hist, attr_cb, &tb_info);
+	if (ret < 0)
+		return;
+
+	if (!tb[ETHTOOL_A_FEC_HIST_BIN_LOW] || !tb[ETHTOOL_A_FEC_HIST_BIN_HIGH])
+		return;
+
+	bin_high = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_HIGH]);
+	bin_low  = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_LOW]);
+	/* Bin value is uint, so it may be u32 or u64 depeding on the value */
+	if (mnl_attr_validate(tb[ETHTOOL_A_FEC_HIST_BIN_VAL], MNL_TYPE_U32) < 0)
+		val = mnl_attr_get_u64(tb[ETHTOOL_A_FEC_HIST_BIN_VAL]);
+	else
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_VAL]);
+
+	if (is_json_context()) {
+		print_u64(PRINT_JSON, "bin_low", NULL, bin_low);
+		print_u64(PRINT_JSON, "bin_high", NULL, bin_high);
+		print_u64(PRINT_JSON, "total", NULL, val);
+	} else {
+		printf("  fec_symbols_err_%d", bin_low);
+		if (bin_low != bin_high)
+			printf("_to_%d", bin_high);
+		printf(": %" PRIu64, val);
+	}
+	if (!tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]) {
+		if (!is_json_context())
+			print_nl();
+		return;
+	}
+
+	vals = mnl_attr_get_payload(tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]);
+	lanes = mnl_attr_get_payload_len(tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]) / 8;
+	if (is_json_context())
+		open_json_array("lanes", "");
+	else
+		printf(" [ per_lane:");
+	for (i = 0; i < lanes; i++) {
+		if (is_json_context())
+			print_u64(PRINT_JSON, NULL, NULL, *vals++);
+		else
+			printf("%s %" PRIu64, i ? "," : "", *vals++);
+	}
+
+	if (is_json_context())
+		close_json_array("");
+	else
+		printf(" ]\n");
+}
+
 static int fec_show_stats(const struct nlattr *nest)
 {
 	const struct nlattr *tb[ETHTOOL_A_FEC_STAT_MAX + 1] = {};
@@ -87,27 +145,45 @@ static int fec_show_stats(const struct nlattr *nest)
 		lanes = mnl_attr_get_payload_len(tb[stats[i].attr]) / 8 - 1;
 
 		if (!is_json_context()) {
-			fprintf(stdout, "  %s: %" PRIu64 "\n",
+			fprintf(stdout, "  %s: %" PRIu64,
 				stats[i].name, *vals++);
 		} else {
 			open_json_object(stats[i].name);
 			print_u64(PRINT_JSON, "total", NULL, *vals++);
 		}
 
-		if (lanes)
+		if (lanes) {
 			open_json_array("lanes", "");
+			printf(" [ per_lane:");
+		}
+
 		for (l = 0; l < lanes; l++) {
 			if (!is_json_context())
-				fprintf(stdout, "    Lane %d: %" PRIu64 "\n",
-					l, *vals++);
+				printf("%s %" PRIu64, l ? "," : "", *vals++);
 			else
 				print_u64(PRINT_JSON, NULL, NULL, *vals++);
 		}
-		if (lanes)
+		if (lanes) {
 			close_json_array("");
+			printf(" ]\n");
+		}
 
 		close_json_object();
 	}
+
+	if (tb[ETHTOOL_A_FEC_STAT_HIST]) {
+		const struct nlattr *attr;
+
+		open_json_array("hist", "");
+		mnl_attr_for_each_nested(attr, nest) {
+			if (mnl_attr_get_type(attr) == ETHTOOL_A_FEC_STAT_HIST) {
+				open_json_object(NULL);
+				fec_show_hist_bin(attr);
+				close_json_object();
+			}
+		}
+		close_json_array("");
+	}
 	close_json_object();
 
 	return 0;
-- 
2.47.3


