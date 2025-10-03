Return-Path: <netdev+bounces-227822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E8BB8597
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 00:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCF119E0536
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD42701C4;
	Fri,  3 Oct 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CUH0a1YH"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9B13A3ED
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531996; cv=none; b=HJw59Lu2vl7seuYfjaHzebR7iFQlAxyMIY2YdlkgtQbFgYqywUc905vuzFgShHBmyT5LyEjr56h8A4+yHeC0R3Wj9sMuit0kxhDEMlpfhssv8fXIiUju0s2S8b2DuanvM5/EXpAII/VFFRpGzC9zp6RAQNxqto5hy5NWdaSVmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531996; c=relaxed/simple;
	bh=DvlBmsIvgfiVCanPO77FQzU1xYuL4fBwyxIdWdKyYQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctP4DVb7VRPf6bVjMx0s27Y8V08GXt/ZUcC1SISsRxMepHIF3SvNyCA+pKBiJyBV3ATd6wYsi5XDJCy1g6xjMx+TLgWfMtlUQegSou3hJ7uwR9sbY5JWCb9dBqsuvt9i8BR4jwt9G10NgLmxDWy10VrYDpnZuVKn8ZONwnogOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CUH0a1YH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759531985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fd2uz4n+Xauzdqb6GLQJ9QAKZShShP+/btvZE9A7J4M=;
	b=CUH0a1YHkRRmpoa4EycYhM1UYU5NLDT2qHwtBL+O9DZx/in2tRze99D62/SRqnIT/wacrc
	0Jf4qmVFMQuffxdMEeCdr2PgLCIsojqxd/f7BNJuB0A6FRmgF2xlAUxajmE3aPRF+NxWuH
	ZcpLc1fGZoL7zSiIYzQz7g39A/OTrMQ=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: mkubecek@suse.cz
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH ethtool-next] netlink: fec: add errors histogram statistics
Date: Fri,  3 Oct 2025 22:52:53 +0000
Message-ID: <20251003225253.3291333-1-vadim.fedorenko@linux.dev>
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
  fec_bit_err_0: 445 [ per_lane:  125, 120, 100, 100 ]
  fec_bit_err_1_to_3: 12
  fec_bit_err_4_to_7: 2

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
 netlink/fec.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/netlink/fec.c b/netlink/fec.c
index ed100d7..32f7ca7 100644
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
+		printf("  fec_bit_err_%d", bin_low);
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
@@ -108,6 +166,20 @@ static int fec_show_stats(const struct nlattr *nest)
 
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


