Return-Path: <netdev+bounces-257671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANRfDe2IhmmNOgQAu9opvQ
	(envelope-from <netdev+bounces-257671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A1510451F
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78743059A50
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827F22A1D4;
	Sat,  7 Feb 2026 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbv3sGOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36592222AA;
	Sat,  7 Feb 2026 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424521; cv=none; b=nQGwg+GA+vyS0EZFsvgLov+Bqw+QGog9xzCuYiI/wk6sebP1ymVOQo/eUWp+lKqPR+deYgxbACMGOE8HvX5TuShv/7ugvzLbC29+osReUovFEWTkK2lHuWh9B0sn6eYRb88UXozIEI5OOtVtIeCQPObThxIzetrnl7+zeUbvJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424521; c=relaxed/simple;
	bh=GPvNgvwQASFRwNDzM8NpDT304rpWiK7HdMYz3Xtz7WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR1g4Ji3NjNEHfJru7R3WDpnfbhtFW+zfzsptMTZU6u3F3lenKbtImB86LUA58KdOiXe7x8TUpDtVTfnsUjdT2Qgt6BM2gH2UB5322vjtdn/5MgFBPRYnGZwTZAJfAKRzgnxdeW9TKseUy6mH3pf5Ahno+0W+H6BdYfewzekE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbv3sGOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC03C19424;
	Sat,  7 Feb 2026 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424521;
	bh=GPvNgvwQASFRwNDzM8NpDT304rpWiK7HdMYz3Xtz7WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tbv3sGOqX3wc1p9bcrtFvQRNvQcN1iUNNkwELGionTNs9fKO5ak+ZEVJ0JKYV0l9g
	 rpvbj8+qtq1z0YBVxpQEI2Xgq2xOLsKrZfkdKqx0W+ex4VmmU/aYra7rPEj4Byy2Sy
	 1coroZEly+DRDTHVmVi5pp6iDJfuUfd/33osxhpEMWRhnNbChGJRoR1l8RU3iV7/ni
	 z4wcOC2CxYiGc+cJ9i/7q0VMfFnp/m5oFfG6WdWtTsWs76vrG39VIMKosgZC/ZfAj+
	 S+j9kEB0pWcwDleglU/krrHL/HP/OmK2Yzvl31ekKzahRxi1fnE6hkJbtovf9Falbp
	 7xa3+EsuBUuZg==
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
Subject: [PATCH net-next v2 7/9] selftests: drv-net: gro: test GRO stats
Date: Fri,  6 Feb 2026 16:35:07 -0800
Message-ID: <20260207003509.3927744-8-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-257671-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2A1510451F
X-Rspamd-Action: no action

Test accuracy of GRO stats. We want to cover two potentially tricky
cases:
 - single segment GRO
 - packets which were eligible but didn't get GRO'd

The first case is trivial, teach gro.c to send one packet, and check
GRO stats didn't move.

Second case requires gro.c to send a lot of flows expecting the NIC
to run out of GRO flow capacity.

To avoid system traffic noise we steer the packets to a dedicated
queue and operate on qstat.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/net/lib/gro.c         | 163 ++++++++++-
 .../selftests/drivers/net/hw/gro_hw.py        | 271 ++++++++++++++++++
 3 files changed, 433 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/gro_hw.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index a64140333a46..19e5ca223273 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS = \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
 	ethtool_rmon.sh \
+	gro_hw.py \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	iou-zcrx.py \
diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 5b3f8fca08e6..41794b9f6f8a 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -43,6 +43,10 @@
  *   - large_max: exceeding max size
  *   - large_rem: remainder handling
  *
+ * single, capacity:
+ *  Boring cases used to test coalescing machinery itself and stats
+ *  more than protocol behavior.
+ *
  * MSS is defined as 4096 - header because if it is too small
  * (i.e. 1500 MTU - header), it will result in many packets,
  * increasing the "large" test case's flakiness. This is because
@@ -126,6 +130,9 @@ static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
 static bool ipip;
 static uint64_t txtime_ns;
+static int num_flows = 4;
+
+#define CAPACITY_PAYLOAD_LEN 200
 
 #define TXTIME_DELAY_MS 5
 
@@ -389,6 +396,45 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
+static void create_capacity_packet(void *buf, int flow_id, int pkt_idx, int psh)
+{
+	int seq_offset = pkt_idx * CAPACITY_PAYLOAD_LEN;
+	struct tcphdr *tcph;
+
+	create_packet(buf, seq_offset, 0, CAPACITY_PAYLOAD_LEN, 0);
+
+	/* Customize for this flow id */
+	memset(buf + total_hdr_len, 'a' + flow_id, CAPACITY_PAYLOAD_LEN);
+
+	tcph = buf + tcp_offset;
+	tcph->source = htons(SPORT + flow_id);
+	tcph->psh = psh;
+	tcph->check = 0;
+	tcph->check = tcp_checksum(tcph, CAPACITY_PAYLOAD_LEN);
+}
+
+/* Send a capacity test, 2 packets per flow, all first packets then all second:
+ *  A1 B1 C1 D1 ... A2 B2 C2 D2 ...
+ */
+static void send_capacity(int fd, struct sockaddr_ll *daddr)
+{
+	static char buf[MAX_HDR_LEN + CAPACITY_PAYLOAD_LEN];
+	int pkt_size = total_hdr_len + CAPACITY_PAYLOAD_LEN;
+	int i;
+
+	/* Send first packet of each flow (no PSH) */
+	for (i = 0; i < num_flows; i++) {
+		create_capacity_packet(buf, i, 0, 0);
+		write_packet(fd, buf, pkt_size, daddr);
+	}
+
+	/* Send second packet of each flow (with PSH to flush) */
+	for (i = 0; i < num_flows; i++) {
+		create_capacity_packet(buf, i, 1, 1);
+		write_packet(fd, buf, pkt_size, daddr);
+	}
+}
+
 #ifndef TH_CWR
 #define TH_CWR 0x80
 #endif
@@ -1085,6 +1131,93 @@ static void check_recv_pkts(int fd, int *correct_payload,
 	printf("Test succeeded\n\n");
 }
 
+static void check_capacity_pkts(int fd)
+{
+	static char buffer[IP_MAXPACKET + ETH_HLEN + 1];
+	struct iphdr *iph = (struct iphdr *)(buffer + ETH_HLEN);
+	struct ipv6hdr *ip6h = (struct ipv6hdr *)(buffer + ETH_HLEN);
+	const char *fail_reason = NULL;
+	int flow_order[num_flows * 2];
+	int coalesced[num_flows];
+	struct tcphdr *tcph;
+	int ip_ext_len = 0;
+	int total_data = 0;
+	int pkt_size = -1;
+	int data_len = 0;
+	int num_pkt = 0;
+	int num_coal = 0;
+	int flow_id;
+	int sport;
+
+	memset(coalesced, 0, sizeof(coalesced));
+	memset(flow_order, -1, sizeof(flow_order));
+
+	while (total_data < num_flows * CAPACITY_PAYLOAD_LEN * 2) {
+		ip_ext_len = 0;
+		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
+		if (pkt_size < 0)
+			recv_error(fd, errno);
+
+		if (iph->version == 4)
+			ip_ext_len = (iph->ihl - 5) * 4;
+		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
+			ip_ext_len = MIN_EXTHDR_SIZE;
+
+		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
+
+		/* FIN packet terminates reception */
+		if (tcph->fin)
+			break;
+
+		sport = ntohs(tcph->source);
+		flow_id = sport - SPORT;
+
+		if (flow_id < 0 || flow_id >= num_flows) {
+			vlog("Invalid flow_id %d from sport %d\n",
+			     flow_id, sport);
+			fail_reason = fail_reason ?: "invalid packet";
+			continue;
+		}
+
+		/* Calculate payload length */
+		if (pkt_size == ETH_ZLEN && iph->version == 4) {
+			data_len = ntohs(iph->tot_len)
+				- sizeof(struct tcphdr) - sizeof(struct iphdr);
+		} else {
+			data_len = pkt_size - total_hdr_len - ip_ext_len;
+		}
+
+		flow_order[num_pkt] = flow_id;
+		coalesced[flow_id] = data_len;
+
+		if (data_len == CAPACITY_PAYLOAD_LEN * 2) {
+			num_coal++;
+		} else {
+			vlog("Pkt %d: flow %d, sport %d, len %d (expected %d)\n",
+			     num_pkt, flow_id, sport, data_len,
+			     CAPACITY_PAYLOAD_LEN * 2);
+			fail_reason = fail_reason ?: "not coalesced";
+		}
+
+		num_pkt++;
+		total_data += data_len;
+	}
+
+	if (!fail_reason) {
+		vlog("All %d flows coalesced correctly\n", num_flows);
+		printf("Test succeeded\n\n");
+	} else {
+		printf("FAILED\n");
+	}
+
+	/* Always print stats for external validation */
+	printf("STATS: received=%d wire=%d coalesced=%d\n",
+	       num_pkt, num_pkt + num_coal, num_coal);
+
+	if (fail_reason)
+		error(1, 0, "capacity test failed %s", fail_reason);
+}
+
 static void gro_sender(void)
 {
 	int bufsize = 4 * 1024 * 1024; /* 4 MB */
@@ -1103,7 +1236,7 @@ static void gro_sender(void)
 	/* Enable SO_TXTIME unless test case generates more than one flow
 	 * SO_TXTIME could result in qdisc layer sorting the packets at sender.
 	 */
-	if (true) {
+	if (strcmp(testname, "single") && strcmp(testname, "capacity")) {
 		struct sock_txtime so_txtime = { .clockid = CLOCK_MONOTONIC, };
 		struct timespec ts;
 
@@ -1250,6 +1383,19 @@ static void gro_sender(void)
 
 		send_large(txfd, &daddr, remainder + 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+	/* machinery sub-tests */
+	} else if (strcmp(testname, "single") == 0) {
+		static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+
+		create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
+		write_packet(txfd, buf, total_hdr_len + PAYLOAD_LEN, &daddr);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "capacity") == 0) {
+		send_capacity(txfd, &daddr);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
 	} else {
 		error(1, 0, "Unknown testcase: %s", testname);
 	}
@@ -1445,6 +1591,15 @@ static void gro_receiver(void)
 		correct_payload[2] = remainder + 1;
 		printf("last segment sent individually: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+
+	/* machinery sub-tests */
+	} else if (strcmp(testname, "single") == 0) {
+		printf("single data packet: ");
+		correct_payload[0] = PAYLOAD_LEN;
+		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "capacity") == 0) {
+		check_capacity_pkts(rxfd);
+
 	} else {
 		error(1, 0, "Test case error: unknown testname %s", testname);
 	}
@@ -1462,6 +1617,7 @@ static void parse_args(int argc, char **argv)
 		{ "ipv4", no_argument, NULL, '4' },
 		{ "ipv6", no_argument, NULL, '6' },
 		{ "ipip", no_argument, NULL, 'e' },
+		{ "num-flows", required_argument, NULL, 'n' },
 		{ "rx", no_argument, NULL, 'r' },
 		{ "saddr", required_argument, NULL, 's' },
 		{ "smac", required_argument, NULL, 'S' },
@@ -1471,7 +1627,7 @@ static void parse_args(int argc, char **argv)
 	};
 	int c;
 
-	while ((c = getopt_long(argc, argv, "46d:D:ei:rs:S:t:v", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "46d:D:ei:n:rs:S:t:v", opts, NULL)) != -1) {
 		switch (c) {
 		case '4':
 			proto = PF_INET;
@@ -1495,6 +1651,9 @@ static void parse_args(int argc, char **argv)
 		case 'i':
 			ifname = optarg;
 			break;
+		case 'n':
+			num_flows = atoi(optarg);
+			break;
 		case 'r':
 			tx_socket = false;
 			break;
diff --git a/tools/testing/selftests/drivers/net/hw/gro_hw.py b/tools/testing/selftests/drivers/net/hw/gro_hw.py
new file mode 100755
index 000000000000..3bca19e8f339
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/gro_hw.py
@@ -0,0 +1,271 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+HW GRO tests focusing on device machinery like stats, rather than protocol
+processing.
+"""
+
+import glob
+import re
+
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq, ksft_ge
+from lib.py import NetDrvEpEnv, NetdevFamily
+from lib.py import KsftSkipEx
+from lib.py import bkg, cmd, defer, ethtool, ip
+
+
+# gro.c uses hardcoded DPORT=8000
+GRO_DPORT = 8000
+
+
+def _get_queue_stats(cfg, queue_id):
+    """Get stats for a specific Rx queue."""
+    cfg.wait_hw_stats_settle()
+    data = cfg.netnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]},
+                                dump=True)
+    for q in data:
+        if q.get('queue-type') == 'rx' and q.get('queue-id') == queue_id:
+            return q
+    return {}
+
+
+def _resolve_dmac(cfg, ipver):
+    """Find the destination MAC address for sending packets."""
+    attr = "dmac" + ipver
+    if hasattr(cfg, attr):
+        return getattr(cfg, attr)
+
+    route = ip(f"-{ipver} route get {cfg.addr_v[ipver]}",
+               json=True, host=cfg.remote)[0]
+    gw = route.get("gateway")
+    if not gw:
+        setattr(cfg, attr, cfg.dev['address'])
+        return getattr(cfg, attr)
+
+    cmd(f"ping -c1 -W0 -I{cfg.remote_ifname} {gw}", host=cfg.remote)
+    neigh = ip(f"neigh get {gw} dev {cfg.remote_ifname}",
+               json=True, host=cfg.remote)[0]
+    setattr(cfg, attr, neigh['lladdr'])
+    return getattr(cfg, attr)
+
+
+def _setup_isolated_queue(cfg):
+    """Set up an isolated queue for testing using ntuple filter.
+
+    Remove queue 1 from the default RSS context and steer test traffic to it.
+    """
+    test_queue = 1
+
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftSkipEx(f"Need at least 2 queues, have {qcnt}")
+
+    # Remove queue 1 from default RSS context by setting its weight to 0
+    weights = ["1"] * qcnt
+    weights[test_queue] = "0"
+    ethtool(f"-X {cfg.ifname} weight " + " ".join(weights))
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    # Set up ntuple filter to steer our test traffic to the isolated queue
+    flow  = f"flow-type tcp{cfg.addr_ipver} "
+    flow += f"dst-ip {cfg.addr} dst-port {GRO_DPORT} action {test_queue}"
+    output = ethtool(f"-N {cfg.ifname} {flow}").stdout
+    ntuple_id = int(output.split()[-1])
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    return test_queue
+
+
+def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False):
+    """Run gro binary with given test and return output."""
+    if not hasattr(cfg, "bin_remote"):
+        cfg.bin_local = cfg.net_lib_dir / "gro"
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+    ipver = cfg.addr_ipver
+    protocol = f"--ipv{ipver}"
+    dmac = _resolve_dmac(cfg, ipver)
+
+    base_args = [
+        protocol,
+        f"--dmac {dmac}",
+        f"--smac {cfg.remote_dev['address']}",
+        f"--daddr {cfg.addr}",
+        f"--saddr {cfg.remote_addr_v[ipver]}",
+        f"--test {test_name}",
+    ]
+    if num_flows:
+        base_args.append(f"--num-flows {num_flows}")
+
+    args = " ".join(base_args)
+
+    rx_cmd = f"{cfg.bin_local} {args} --rx --iface {cfg.ifname}"
+    tx_cmd = f"{cfg.bin_remote} {args} --iface {cfg.remote_ifname}"
+
+    with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=False) as rx_proc:
+        cmd(tx_cmd, host=cfg.remote)
+
+    if not ignore_fail:
+        ksft_eq(rx_proc.ret, 0)
+        if rx_proc.ret != 0:
+            ksft_pr(rx_proc)
+
+    return rx_proc.stdout
+
+
+def _require_hw_gro_stats(cfg, queue_id):
+    """Check if device reports HW GRO stats for the queue."""
+    stats = _get_queue_stats(cfg, queue_id)
+    required = ['rx-packets', 'rx-hw-gro-packets', 'rx-hw-gro-wire-packets']
+    for stat in required:
+        if stat not in stats:
+            raise KsftSkipEx(f"Driver does not report '{stat}' via qstats")
+
+
+def _set_ethtool_feat(cfg, current, feats):
+    """Set ethtool features with defer to restore original state."""
+    s2n = {True: "on", False: "off"}
+
+    new = ["-K", cfg.ifname]
+    old = ["-K", cfg.ifname]
+    no_change = True
+    for name, state in feats.items():
+        new += [name, s2n[state]]
+        old += [name, s2n[current[name]["active"]]]
+
+        if current[name]["active"] != state:
+            no_change = False
+            if current[name]["fixed"]:
+                raise KsftSkipEx(f"Device does not support {name}")
+    if no_change:
+        return
+
+    eth_cmd = ethtool(" ".join(new))
+    defer(ethtool, " ".join(old))
+
+    # If ethtool printed something kernel must have modified some features
+    if eth_cmd.stdout:
+        ksft_pr(eth_cmd)
+
+
+def _setup_hw_gro(cfg):
+    """Enable HW GRO on the device, disabling SW GRO."""
+    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+
+    # Try to disable SW GRO and enable HW GRO
+    _set_ethtool_feat(cfg, feat,
+                      {"generic-receive-offload": False,
+                       "rx-gro-hw": True,
+                       "large-receive-offload": False})
+
+    # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
+    # will also clear HW GRO. Use a hack of installing XDP generic
+    # to skip SW GRO, even when enabled.
+    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not feat["rx-gro-hw"]["active"]:
+        ksft_pr("Driver clears HW GRO when SW GRO is cleared, using generic XDP workaround")
+        prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+        ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
+        defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
+
+        # Attaching XDP may change features, fetch the latest state
+        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+
+        _set_ethtool_feat(cfg, feat,
+                          {"generic-receive-offload": True,
+                           "rx-gro-hw": True,
+                           "large-receive-offload": False})
+
+
+def _check_gro_stats(cfg, test_queue, stats_before,
+                     expect_rx, expect_gro, expect_wire):
+    """Validate GRO stats against expected values."""
+    stats_after = _get_queue_stats(cfg, test_queue)
+
+    rx_delta = (stats_after.get('rx-packets', 0) -
+                stats_before.get('rx-packets', 0))
+    gro_delta = (stats_after.get('rx-hw-gro-packets', 0) -
+                 stats_before.get('rx-hw-gro-packets', 0))
+    wire_delta = (stats_after.get('rx-hw-gro-wire-packets', 0) -
+                  stats_before.get('rx-hw-gro-wire-packets', 0))
+
+    ksft_eq(rx_delta, expect_rx, comment="rx-packets")
+    ksft_eq(gro_delta, expect_gro, comment="rx-hw-gro-packets")
+    ksft_eq(wire_delta, expect_wire, comment="rx-hw-gro-wire-packets")
+
+
+def test_gro_stats_single(cfg):
+    """
+    Test that a single packet doesn't affect GRO stats.
+
+    Send a single packet that cannot be coalesced (nothing to coalesce with).
+    GRO stats should not increase since no coalescing occurred.
+    rx-packets should increase by 2 (1 data + 1 FIN).
+    """
+    _setup_hw_gro(cfg)
+
+    test_queue = _setup_isolated_queue(cfg)
+    _require_hw_gro_stats(cfg, test_queue)
+
+    stats_before = _get_queue_stats(cfg, test_queue)
+
+    _run_gro_test(cfg, "single")
+
+    # 1 data + 1 FIN = 2 rx-packets, no coalescing
+    _check_gro_stats(cfg, test_queue, stats_before,
+                     expect_rx=2, expect_gro=0, expect_wire=0)
+
+
+def test_gro_stats_full(cfg):
+    """
+    Test GRO stats when overwhelming HW GRO capacity.
+
+    Send 500 flows to exceed HW GRO flow capacity on a single queue.
+    This should result in some packets not being coalesced.
+    Validate that qstats match what gro.c observed.
+    """
+    _setup_hw_gro(cfg)
+
+    test_queue = _setup_isolated_queue(cfg)
+    _require_hw_gro_stats(cfg, test_queue)
+
+    num_flows = 500
+    stats_before = _get_queue_stats(cfg, test_queue)
+
+    # Run capacity test - will likely fail because not all packets coalesce
+    output = _run_gro_test(cfg, "capacity", num_flows=num_flows,
+                           ignore_fail=True)
+
+    # Parse gro.c output: "STATS: received=X wire=Y coalesced=Z"
+    match = re.search(r'STATS: received=(\d+) wire=(\d+) coalesced=(\d+)',
+                      output)
+    if not match:
+        raise KsftSkipEx(f"Could not parse gro.c output: {output}")
+
+    rx_frames = int(match.group(2))
+    gro_coalesced = int(match.group(3))
+
+    ksft_ge(gro_coalesced, 1,
+            comment="At least some packets should coalesce")
+
+    # received + 1 FIN, coalesced super-packets, coalesced * 2 wire packets
+    _check_gro_stats(cfg, test_queue, stats_before,
+                     expect_rx=rx_frames + 1,
+                     expect_gro=gro_coalesced,
+                     expect_wire=gro_coalesced * 2)
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.netnl = NetdevFamily()
+        ksft_run([test_gro_stats_single,
+                  test_gro_stats_full], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


