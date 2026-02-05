Return-Path: <netdev+bounces-257324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPR2IS4VhWkh8QMAu9opvQ
	(envelope-from <netdev+bounces-257324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:09:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C4F7F96
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFA7230495C4
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2233554B;
	Thu,  5 Feb 2026 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAdwSOIq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522D3358B0;
	Thu,  5 Feb 2026 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329247; cv=none; b=mF/LkJRTQEOWKkZO0guaHJiiAsGOEqE9PZS9V/lLsNxxN/gf/NR2WFxaQ+BQ4pzB7AvIY+cFzeRTT1ryA4r4N+8p8METJlPwb8LlP1JKHn51H92JPjeGmsdEFOxS/vCEUCio/LwGS6ZY8upP3iZj5343wMX1HF2m4CCIIUNE2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329247; c=relaxed/simple;
	bh=vrKmapDKVFUNawVdemJagrQcA18lZGaXtDwlwlwLev8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQc4cDUDALxIpX/Zk3X0bPjxzDKHzr4nrHo9G09fGfqDSNymM0TLySLg939ZCT4Tyrl2rpBAeVQ5TR7Cu8UOZWVnS5sz/cxqdHva6+Z3TgPdqDmTzwhOOa5uSTf+A8ccMH5pL7hHNmMqybtg3t8y3Y8/De52mJ48Qfl83H+vjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAdwSOIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B308FC19424;
	Thu,  5 Feb 2026 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770329247;
	bh=vrKmapDKVFUNawVdemJagrQcA18lZGaXtDwlwlwLev8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAdwSOIq/e33Oyfo9W8PlwmL37Mv3LszcElGEwrMMdJONHVA5jTYHGfKaXC/+1tBb
	 YBdr54L3F4+E9u2ySsRgJUxAYD46YhZO7gKccl4Q3rBiIjpWZ0OBR0F3/+IpgrVAMN
	 DAXDfyIUbiJLw8QCzystPjElZDaw9dA3R4Eh2vPP23IGrJU/LsIjzR86KXNfpzSA0f
	 rHoKrVU6vjTXMCjsPX2glgbtIbhoBSgBGIsEajy3NNqcUsm9949ZZS8PwPGWwTSZF+
	 Dk9za8k/zATr/Br5V+b8ZZx90z/NsuMklDuZocHWcagAc9zoZFeOxqM18y2s1zB+eW
	 iS2+p73NMvFgw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/9] selftests: drv-net: gro: add test for packet ordering
Date: Thu,  5 Feb 2026 14:05:40 -0800
Message-ID: <20260205220541.2992807-9-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205220541.2992807-1-kuba@kernel.org>
References: <20260205220541.2992807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257324-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: DF1C4F7F96
X-Rspamd-Action: no action

Add a test to check if the NIC reorders packets if the hit GRO.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c         | 38 +++++++++++++++++--
 .../selftests/drivers/net/hw/gro_hw.py        | 29 ++++++++++++--
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index d37676c009e8..3d3312b37248 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -131,6 +131,7 @@ static int ethhdr_proto = -1;
 static bool ipip;
 static uint64_t txtime_ns;
 static int num_flows = 4;
+static bool order_check;
 
 #define CAPACITY_PAYLOAD_LEN 200
 
@@ -1134,6 +1135,7 @@ static void check_capacity_pkts(int fd)
 	static char buffer[IP_MAXPACKET + ETH_HLEN + 1];
 	struct iphdr *iph = (struct iphdr *)(buffer + ETH_HLEN);
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(buffer + ETH_HLEN);
+	int num_pkt = 0, num_coal = 0, pkt_idx;
 	const char *fail_reason = NULL;
 	int flow_order[num_flows * 2];
 	int coalesced[num_flows];
@@ -1142,8 +1144,6 @@ static void check_capacity_pkts(int fd)
 	int total_data = 0;
 	int pkt_size = -1;
 	int data_len = 0;
-	int num_pkt = 0;
-	int num_coal = 0;
 	int flow_id;
 	int sport;
 
@@ -1201,6 +1201,34 @@ static void check_capacity_pkts(int fd)
 		total_data += data_len;
 	}
 
+	/* Check flow ordering. We expect to see all non-coalesced first segs
+	 * then interleaved coalesced and non-coalesced second frames.
+	 */
+	pkt_idx = 0;
+	for (flow_id = 0; order_check && flow_id < num_flows; flow_id++) {
+		bool coaled = coalesced[flow_id] > CAPACITY_PAYLOAD_LEN;
+
+		if (coaled)
+			continue;
+
+		if (flow_order[pkt_idx] != flow_id) {
+			vlog("Flow order mismatch (non-coalesced) at position %d: expected flow %d, got flow %d\n",
+			     pkt_idx, flow_id, flow_order[pkt_idx]);
+			fail_reason = fail_reason ?: "bad packet order (1)";
+		}
+		pkt_idx++;
+	}
+	for (flow_id = 0; order_check && flow_id < num_flows; flow_id++) {
+		bool coaled = coalesced[flow_id] > CAPACITY_PAYLOAD_LEN;
+
+		if (flow_order[pkt_idx] != flow_id) {
+			vlog("Flow order mismatch at position %d: expected flow %d, got flow %d, coalesced: %d\n",
+			     pkt_idx, flow_id, flow_order[pkt_idx], coaled);
+			fail_reason = fail_reason ?: "bad packet order (2)";
+		}
+		pkt_idx++;
+	}
+
 	if (!fail_reason) {
 		vlog("All %d flows coalesced correctly\n", num_flows);
 		printf("Test succeeded\n\n");
@@ -1614,12 +1642,13 @@ static void parse_args(int argc, char **argv)
 		{ "saddr", required_argument, NULL, 's' },
 		{ "smac", required_argument, NULL, 'S' },
 		{ "test", required_argument, NULL, 't' },
+		{ "order-check", no_argument, NULL, 'o' },
 		{ "verbose", no_argument, NULL, 'v' },
 		{ 0, 0, 0, 0 }
 	};
 	int c;
 
-	while ((c = getopt_long(argc, argv, "46d:D:ei:n:rs:S:t:v", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "46d:D:ei:n:rs:S:t:ov", opts, NULL)) != -1) {
 		switch (c) {
 		case '4':
 			proto = PF_INET;
@@ -1658,6 +1687,9 @@ static void parse_args(int argc, char **argv)
 		case 't':
 			testname = optarg;
 			break;
+		case 'o':
+			order_check = true;
+			break;
 		case 'v':
 			verbose = true;
 			break;
diff --git a/tools/testing/selftests/drivers/net/hw/gro_hw.py b/tools/testing/selftests/drivers/net/hw/gro_hw.py
index 3bca19e8f339..18a3b1bceefd 100755
--- a/tools/testing/selftests/drivers/net/hw/gro_hw.py
+++ b/tools/testing/selftests/drivers/net/hw/gro_hw.py
@@ -10,7 +10,7 @@ import glob
 import re
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_eq, ksft_ge
+from lib.py import ksft_eq, ksft_ge, ksft_variants
 from lib.py import NetDrvEpEnv, NetdevFamily
 from lib.py import KsftSkipEx
 from lib.py import bkg, cmd, defer, ethtool, ip
@@ -78,7 +78,8 @@ GRO_DPORT = 8000
     return test_queue
 
 
-def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False):
+def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
+                  order_check=False):
     """Run gro binary with given test and return output."""
     if not hasattr(cfg, "bin_remote"):
         cfg.bin_local = cfg.net_lib_dir / "gro"
@@ -98,6 +99,8 @@ GRO_DPORT = 8000
     ]
     if num_flows:
         base_args.append(f"--num-flows {num_flows}")
+    if order_check:
+        base_args.append("--order-check")
 
     args = " ".join(base_args)
 
@@ -257,13 +260,33 @@ def _check_gro_stats(cfg, test_queue, stats_before,
                      expect_wire=gro_coalesced * 2)
 
 
+@ksft_variants([4, 32, 512])
+def test_gro_order(cfg, num_flows):
+    """
+    Test that HW GRO preserves packet ordering between flows.
+
+    Packets may get delayed until the aggreate is released,
+    but reordering between aggregates and packet terminating
+    the aggregate and normal packets should not happen.
+
+    Note that this test is stricter than truly required.
+    Reordering packets between flows should not cause issues.
+    This test will also fail if traffic is run over an ECMP fabric.
+    """
+    _setup_hw_gro(cfg)
+    _setup_isolated_queue(cfg)
+
+    _run_gro_test(cfg, "capacity", num_flows=num_flows, order_check=True)
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.netnl = NetdevFamily()
         ksft_run([test_gro_stats_single,
-                  test_gro_stats_full], args=(cfg,))
+                  test_gro_stats_full,
+                  test_gro_order], args=(cfg,))
     ksft_exit()
 
 
-- 
2.53.0


