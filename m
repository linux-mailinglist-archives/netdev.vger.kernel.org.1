Return-Path: <netdev+bounces-257672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BxdO/CIhmmNOgQAu9opvQ
	(envelope-from <netdev+bounces-257672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD810452D
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F25305AAC6
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877722B8C5;
	Sat,  7 Feb 2026 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1UWnNoj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552951F4615;
	Sat,  7 Feb 2026 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424522; cv=none; b=Scl0j0MQtL2E/PJg1Y3IYgbOX/PthDKr0MNZ/VTFg8xEjKwpa2EMmXAwh9MRHj73c6Hpq+uBz56nw/mDANriVlvSABzUc8x9jryqW5booNIFADmpg4VaGtiLodUmZ87JgeOhhBSnFVD11FUq8iaIM5VC8E0UwkKVXq25tWNxnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424522; c=relaxed/simple;
	bh=N+MC2YTLbWisKan3R/bg99qccx+TRNEKfqNl+U0loKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj+Nb44xIaXiE3HKgu8FdlNPqehX+SiHZiMgZ+YILJNhMU0XvNNt13Z55keaxP884IHfOj+1+ELDlY9qsaIbs6W1X8GQ5fQDGyR5E4y7tD1nSFDqlpXn3EGRgdFnUQXOfGeHMExPtma9Zp0RkVPdC0X80R1Vg81y1ERdAifOOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1UWnNoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D18EC2BC86;
	Sat,  7 Feb 2026 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424522;
	bh=N+MC2YTLbWisKan3R/bg99qccx+TRNEKfqNl+U0loKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1UWnNojoSLGyYIdOnJ/FKaHIv8JTbVcw6bhOcY47dzeLSziF4cqk+ZyIQz7GG07Z
	 r9eWCfrkhmSc+4AHY/IhM5/BhSkD+XJs3cuJmCA1zfstYymtK5pN8z3EO73p4wih7a
	 EbNtimaSF58zCPvwcuVMrG5y7EbC2YAHWfaOFSH3Q4DXNTjYVPY8J+KqKFu9OcTS7n
	 /nyjQke50d9tr56/gEvhB0uDyL5nHB82sWRtfMor5C58piiUbJTCfciQr2nG/G1azs
	 1NhDt0KPSCN5tWmZag8cBj72hWiV16TJeQ2p7k5OHzv1Lpp6YIDIlwlZ9M18qJse04
	 87Uz+wLfKgfBQ==
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
Subject: [PATCH net-next v2 8/9] selftests: drv-net: gro: add test for packet ordering
Date: Fri,  6 Feb 2026 16:35:08 -0800
Message-ID: <20260207003509.3927744-9-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207003509.3927744-1-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257672-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1FD810452D
X-Rspamd-Action: no action

Add a test to check if the NIC reorders packets if the hit GRO.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c         | 38 +++++++++++++++++--
 .../selftests/drivers/net/hw/gro_hw.py        | 29 ++++++++++++--
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 41794b9f6f8a..3e611ae25f61 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -131,6 +131,7 @@ static int ethhdr_proto = -1;
 static bool ipip;
 static uint64_t txtime_ns;
 static int num_flows = 4;
+static bool order_check;
 
 #define CAPACITY_PAYLOAD_LEN 200
 
@@ -1136,6 +1137,7 @@ static void check_capacity_pkts(int fd)
 	static char buffer[IP_MAXPACKET + ETH_HLEN + 1];
 	struct iphdr *iph = (struct iphdr *)(buffer + ETH_HLEN);
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(buffer + ETH_HLEN);
+	int num_pkt = 0, num_coal = 0, pkt_idx;
 	const char *fail_reason = NULL;
 	int flow_order[num_flows * 2];
 	int coalesced[num_flows];
@@ -1144,8 +1146,6 @@ static void check_capacity_pkts(int fd)
 	int total_data = 0;
 	int pkt_size = -1;
 	int data_len = 0;
-	int num_pkt = 0;
-	int num_coal = 0;
 	int flow_id;
 	int sport;
 
@@ -1203,6 +1203,34 @@ static void check_capacity_pkts(int fd)
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
@@ -1622,12 +1650,13 @@ static void parse_args(int argc, char **argv)
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
@@ -1666,6 +1695,9 @@ static void parse_args(int argc, char **argv)
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
index 3bca19e8f339..10e08b22ee0e 100755
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
+    Packets may get delayed until the aggregate is released,
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


