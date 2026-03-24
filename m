Return-Path: <netdev+bounces-271209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI45LlXPwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:52:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF831A586
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 379E130C2DA1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347240B6CD;
	Tue, 24 Mar 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv7zsCTx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8B40825C
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374489; cv=none; b=jp9bc8QvgWd0XUV9mGOP6FCRk0cYVAsoUIfwquYr4YdMqMOGgg16mTDr9oTALWa7JOl0fTKgSl/MPQJnEowjn5GPzzRT/vQNwoA5dWGCHeq+gTPUFwE4ampdO8QSvBhWhVUW+06O9+8iGQZPfDbAXFMj2u15llz8EuxcOKvQCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374489; c=relaxed/simple;
	bh=Q3BIh9qqJsKZ390EM//PER572SaAlm3A/Oyw5ISIYrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSoJOC6SsHhmSwY8mUhJDRYhliTJdRlvJMVC4XrF2UrTuWd35HaLiJXs3pcLjHCiJpP5g+pPnkVMlX7fMOtn0OfY0yRK6PWMFp93jiDaFJ8HSCrw8hS22fH2A6R3Aq9ZHUYT/mBRNKM+d+6U60iEcG3GlrOqQ7fzXs/XtcZ6G5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv7zsCTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D376C19424;
	Tue, 24 Mar 2026 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374489;
	bh=Q3BIh9qqJsKZ390EM//PER572SaAlm3A/Oyw5ISIYrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fv7zsCTx80QccRXrThXaHBLVOXhFhR79mnEwLsbRKX5jKLfpFmi85AfwNMhUnuXzN
	 pGB0Cf4/AxjqwGGz466nhe9ZqZhpWrw4C32H4i7j11Rvbo58sDyu2ZeQDMsCFPqzqQ
	 WMikjqZy40fmrZzeHOseOfC7a4QGw5+wEql4rkfYCjEAE/kxdSXZzY9ZDVR+TMxjVN
	 8g05nfJ61pDmNLoSp2m2ixDknWxNKEUgjGX4Y7Y6nhqJo5uuNqHNXrbk+x98V2NDFO
	 lDQwc4ClXsArDqY7RWHt9xY3xFZ7RQ5HCoZ6i5TN+Efpm4vH8Fo3HGEInaCAL2LlwL
	 m6nvEkg5kqglw==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	j.koeppeler@tu-berlin.de,
	kernel-team@cloudflare.com
Subject: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
Date: Tue, 24 Mar 2026 18:47:04 +0100
Message-ID: <20260324174719.1224337-7-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324174719.1224337-1-hawk@kernel.org>
References: <20260324174719.1224337-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271209-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-berlin.de:email,lib.sh:url]
X-Rspamd-Queue-Id: 33AF831A586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add a selftest that exercises veth's BQL (Byte Queue Limits) code path
under sustained UDP load. The test creates a veth pair with GRO enabled
(activating the NAPI path and BQL), attaches a qdisc, optionally loads
iptables rules in the consumer namespace to slow NAPI processing, and
floods UDP packets for a configurable duration.

The test serves two purposes: benchmarking BQL's latency impact under
configurable load (iptables rules, qdisc type and parameters), and
detecting kernel BUG/Oops from DQL accounting mismatches. It monitors
dmesg throughout the run and reports PASS/FAIL via kselftest (lib.sh).

Diagnostic output is printed every 5 seconds:
  - BQL sysfs inflight/limit and watchdog tx_timeout counter
  - qdisc stats: packets, drops, requeues, backlog, qlen, overlimits
  - consumer PPS and NAPI-64 cycle time (shows fq_codel target impact)
  - sink PPS (per-period delta), latency min/avg/max (stddev at exit)
  - ping RTT to measure latency under load

Generating enough traffic to fill the 256-entry ptr_ring requires care:
the UDP sendto() path charges each SKB to sk_wmem_alloc, and the SKB
stays charged (via sock_wfree destructor) until the consumer NAPI thread
finishes processing it -- including any iptables rules in the receive
path. With the default sk_sndbuf (~208KB from wmem_default), only ~93
packets can be in-flight before sendto(MSG_DONTWAIT) returns EAGAIN.
Since 93 < 256 ring entries, the ring never fills and no backpressure
occurs. The test raises wmem_max via sysctl and sets SO_SNDBUF=1MB on
the flood socket to remove this bottleneck. An earlier multi-namespace
routing approach avoided this limit because ip_forward creates new SKBs
detached from the sender's socket.

The --bql-disable option (sets limit_min=1GB) enables A/B comparison.
Typical results with --nrules 6000 --qdisc-opts 'target 2ms interval 20ms':

  fq_codel + BQL disabled:  ping RTT ~10.8ms, 15% loss, 400KB in ptr_ring
  fq_codel + BQL enabled:   ping RTT ~0.6ms,   0% loss, 4KB in ptr_ring

Both cases show identical consumer speed (~20Kpps) and fq_codel drops
(~255K), proving the improvement comes purely from where packets buffer.

BQL moves buffering from the ptr_ring into the qdisc, where AQM
(fq_codel/CAKE) can act on it -- eliminating the "dark buffer" that
hides congestion from the scheduler.

The --qdisc-replace mode cycles through sfq/pfifo/fq_codel/noqueue
under active traffic to verify that stale BQL state (STACK_XOFF) is
properly handled during live qdisc transitions.

A companion wrapper (veth_bql_test_virtme.sh) launches the test inside
a virtme-ng VM, with .config validation to prevent silent stalls.

Usage:
  sudo ./veth_bql_test.sh [--duration 300] [--nrules 100]
                          [--qdisc sfq] [--qdisc-opts '...']
                          [--bql-disable] [--normal-napi]
                          [--qdisc-replace]

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 tools/testing/selftests/net/veth_bql_test.sh  | 784 ++++++++++++++++++
 .../selftests/net/veth_bql_test_virtme.sh     | 124 +++
 2 files changed, 908 insertions(+)
 create mode 100755 tools/testing/selftests/net/veth_bql_test.sh
 create mode 100755 tools/testing/selftests/net/veth_bql_test_virtme.sh

diff --git a/tools/testing/selftests/net/veth_bql_test.sh b/tools/testing/selftests/net/veth_bql_test.sh
new file mode 100755
index 000000000000..9b5923341040
--- /dev/null
+++ b/tools/testing/selftests/net/veth_bql_test.sh
@@ -0,0 +1,784 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Veth BQL (Byte Queue Limits) stress test and A/B benchmarking tool.
+#
+# Creates a veth pair with GRO on and TSO off (ensures all packets use
+# the NAPI/ptr_ring path where BQL operates), attaches a configurable
+# qdisc, optionally loads iptables rules to slow the consumer NAPI
+# processing, and floods UDP packets at maximum rate.
+#
+# Primary uses:
+#   1) A/B comparison of latency with/without BQL (--bql-disable flag)
+#   2) Testing different qdiscs and their parameters (--qdisc, --qdisc-opts)
+#   3) Detecting kernel BUG/Oops from DQL accounting mismatches
+#
+# Key design detail -- SO_SNDBUF and wmem_max:
+#   The UDP sendto() path charges each SKB to the socket's sk_wmem_alloc
+#   counter.  The SKB carries a destructor (sock_wfree) that releases the
+#   charge only after the consumer NAPI thread on the peer veth finishes
+#   processing it -- including any iptables rules in the receive path.
+#   With the default sk_sndbuf (~208KB from wmem_default), only ~93
+#   packets (1442B each) can be in-flight before sendto() returns EAGAIN.
+#   Since 93 < 256 ptr_ring entries, the ring never fills and no qdisc
+#   backpressure occurs.  The test temporarily raises the global wmem_max
+#   sysctl and sets SO_SNDBUF=1MB to allow enough in-flight SKBs to
+#   saturate the ptr_ring.  The original wmem_max is restored on exit.
+#
+# Two TX-stop mechanisms and the dark-buffer problem:
+#   DRV_XOFF backpressure (commit dc82a33297fc) stops the TX queue when
+#   the 256-entry ptr_ring is full.  The queue is released at the end of
+#   veth_poll() (commit 5442a9da6978) after processing up to 64 packets
+#   (NAPI budget).  Without BQL, the entire ring is a FIFO "dark buffer"
+#   in front of the qdisc -- packets there are invisible to AQM.
+#
+#   BQL adds STACK_XOFF, which dynamically limits in-flight bytes and
+#   stops the queue *before* the ring fills.  This keeps the ring
+#   shallow and moves buffering into the qdisc where sojourn-based AQM
+#   (codel, fq_codel, CAKE/COBALT) can measure and drop packets.
+#
+# Sojourn time and NAPI budget interaction:
+#   DRV_XOFF releases backpressure once per NAPI poll (up to 64 pkts).
+#   During that cycle, packets queued in the qdisc accumulate sojourn
+#   time.  With fq_codel's default target of 5ms, the threshold is:
+#     5000us / 64 pkts = 78us/pkt --> ~12,800 pps consumer speed.
+#   Below that rate the NAPI-64 cycle exceeds the target and fq_codel
+#   starts dropping.  Use --nrules and --qdisc-opts to experiment.
+#
+cd "$(dirname -- "$0")" || exit 1
+source lib.sh
+
+# Defaults
+DURATION=300      # seconds; 307M pkts @ ~1Mpps needs ~5min
+NRULES=3500       # iptables rules in consumer NS (0 to disable)
+QDISC=sfq         # qdisc to use (sfq, pfifo, fq_codel, etc.)
+QDISC_OPTS=""     # extra qdisc parameters (e.g. "target 1ms interval 10ms")
+BQL_DISABLE=0     # 1 to disable BQL (sets limit_min high)
+NORMAL_NAPI=0     # 1 to use normal softirq NAPI (skip threaded NAPI)
+QDISC_REPLACE=0   # 1 to test qdisc replacement under active traffic
+VETH_A="veth_bql0"
+VETH_B="veth_bql1"
+IP_A="10.99.0.1"
+IP_B="10.99.0.2"
+PORT=9999
+PKT_SIZE=1400     # large packets: slower producer, bigger BQL charges
+
+usage() {
+    echo "Usage: $0 [OPTIONS]"
+    echo "  --duration SEC   test duration (default: $DURATION)"
+    echo "  --nrules N       iptables rules to slow consumer (default: $NRULES, 0=disable)"
+    echo "  --qdisc NAME     qdisc to install (default: $QDISC)"
+    echo "  --qdisc-opts STR extra qdisc params (e.g. 'target 1ms interval 10ms')"
+    echo "  --bql-disable    disable BQL for A/B comparison"
+    echo "  --normal-napi    use softirq NAPI instead of threaded NAPI"
+    echo "  --qdisc-replace  test qdisc replacement under active traffic"
+    exit 1
+}
+
+while [ $# -gt 0 ]; do
+    case "$1" in
+    --duration)   DURATION="$2"; shift 2 ;;
+    --nrules)     NRULES="$2"; shift 2 ;;
+    --qdisc)      QDISC="$2"; shift 2 ;;
+    --qdisc-opts) QDISC_OPTS="$2"; shift 2 ;;
+    --bql-disable) BQL_DISABLE=1; shift ;;
+    --normal-napi) NORMAL_NAPI=1; shift ;;
+    --qdisc-replace) QDISC_REPLACE=1; shift ;;
+    --help|-h)    usage ;;
+    *)            echo "Unknown option: $1" >&2; usage ;;
+    esac
+done
+
+TMPDIR=$(mktemp -d)
+
+FLOOD_PID=""
+SINK_PID=""
+PING_PID=""
+BPFTRACE_PID=""
+
+cleanup() {
+    [ -n "$BPFTRACE_PID" ] && kill_process $BPFTRACE_PID
+    [ -n "$FLOOD_PID" ] && kill_process $FLOOD_PID
+    [ -n "$SINK_PID" ] && kill_process $SINK_PID
+    [ -n "$PING_PID" ] && kill_process $PING_PID
+    cleanup_all_ns
+    ip link del "$VETH_A" 2>/dev/null || true
+    [ -n "$ORIG_WMEM_MAX" ] && sysctl -qw net.core.wmem_max="$ORIG_WMEM_MAX"
+    rm -rf "$TMPDIR"
+}
+trap cleanup EXIT
+
+require_command gcc
+require_command ethtool
+require_command tc
+
+# --- Function definitions ---
+
+compile_tools() {
+    echo "--- Compiling UDP flood tool ---"
+cat > "$TMPDIR"/udp_flood.c << 'CEOF'
+#include <arpa/inet.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <time.h>
+#include <unistd.h>
+
+static volatile int running = 1;
+
+static void stop(int sig) { running = 0; }
+
+struct pkt_hdr {
+	struct timespec ts;
+	unsigned long seq;
+};
+
+int main(int argc, char **argv)
+{
+	struct sockaddr_in dst;
+	struct pkt_hdr hdr;
+	unsigned long count = 0;
+	char buf[1500];
+	int sndbuf = 1048576;
+	int pkt_size;
+	int duration;
+	int fd;
+
+	if (argc < 5) {
+		fprintf(stderr, "Usage: %s <ip> <pkt_size> <port> <duration_sec>\n",
+			argv[0]);
+		return 1;
+	}
+
+	pkt_size = atoi(argv[2]);
+	if (pkt_size < (int)sizeof(struct pkt_hdr))
+		pkt_size = sizeof(struct pkt_hdr);
+	if (pkt_size > (int)sizeof(buf))
+		pkt_size = sizeof(buf);
+	duration = atoi(argv[4]);
+
+	memset(&dst, 0, sizeof(dst));
+	dst.sin_family = AF_INET;
+	dst.sin_port = htons(atoi(argv[3]));
+	inet_pton(AF_INET, argv[1], &dst.sin_addr);
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	/* Raise send buffer so sk_wmem_alloc limit doesn't cap
+	 * in-flight packets before the ptr_ring (256 entries) fills.
+	 * Default wmem_default ~208K only allows ~93 packets.
+	 */
+	setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));
+
+	memset(buf, 0xAA, sizeof(buf));
+	signal(SIGINT, stop);
+	signal(SIGTERM, stop);
+	signal(SIGALRM, stop);
+	alarm(duration);
+
+	while (running) {
+		clock_gettime(CLOCK_MONOTONIC, &hdr.ts);
+		hdr.seq = count;
+		memcpy(buf, &hdr, sizeof(hdr));
+		sendto(fd, buf, pkt_size, MSG_DONTWAIT,
+		       (struct sockaddr *)&dst, sizeof(dst));
+		count++;
+		if (!(count % 10000000))
+			fprintf(stderr, "  sent: %lu M packets\n",
+				count / 1000000);
+	}
+
+	fprintf(stderr, "Total sent: %lu packets (%.1f M)\n",
+		count, (double)count / 1e6);
+	close(fd);
+	return 0;
+}
+CEOF
+gcc -O2 -Wall -o "$TMPDIR"/udp_flood "$TMPDIR"/udp_flood.c || exit $ksft_fail
+
+# UDP sink with latency measurement
+cat > "$TMPDIR"/udp_sink.c << 'CEOF'
+#include <arpa/inet.h>
+#include <math.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <time.h>
+#include <unistd.h>
+
+static volatile int running = 1;
+
+static void stop(int sig) { running = 0; }
+
+struct pkt_hdr {
+	struct timespec ts;
+	unsigned long seq;
+};
+
+static void print_periodic(unsigned long count, unsigned long delta_count,
+			   double delta_sec, unsigned long drops,
+			   unsigned long reorders,
+			   double lat_min, double lat_sum,
+			   double lat_max)
+{
+	unsigned long pps;
+
+	if (!count)
+		return;
+	pps = delta_sec > 0 ? (unsigned long)(delta_count / delta_sec) : 0;
+	fprintf(stderr, "  sink: %lu pkts (%lu pps)  drops=%lu  reorders=%lu"
+		"  latency min/avg/max = %.3f/%.3f/%.3f ms\n",
+		count, pps, drops, reorders,
+		lat_min * 1e3, (lat_sum / count) * 1e3,
+		lat_max * 1e3);
+}
+
+static void print_final(unsigned long count, double elapsed_sec,
+			unsigned long drops, unsigned long reorders,
+			double lat_min, double lat_sum,
+			double lat_sum_sq, double lat_max)
+{
+	unsigned long pps;
+	double avg, stddev;
+
+	if (!count)
+		return;
+	pps = elapsed_sec > 0 ? (unsigned long)(count / elapsed_sec) : 0;
+	avg = lat_sum / count;
+	stddev = sqrt(lat_sum_sq / count - avg * avg);
+	fprintf(stderr, "  sink: %lu pkts (%lu avg pps)  drops=%lu  reorders=%lu"
+		"  latency min/avg/max/stddev = %.3f/%.3f/%.3f/%.3f ms\n",
+		count, pps, drops, reorders,
+		lat_min * 1e3, avg * 1e3,
+		lat_max * 1e3, stddev * 1e3);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long next_seq = 0, drops = 0, reorders = 0;
+	double lat_min = 1e9, lat_max = 0, lat_sum = 0, lat_sum_sq = 0;
+	unsigned long count = 0, last_count = 0;
+	struct sockaddr_in addr;
+	char buf[2048];
+	int fd, one = 1;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s <port>\n", argv[0]);
+		return 1;
+	}
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return 1;
+	}
+	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+
+	/* Timeout so recv() unblocks periodically to check 'running' flag.
+	 * Needed because glibc signal() sets SA_RESTART, so SIGTERM
+	 * does not interrupt recv().
+	 */
+	struct timeval tv = { .tv_sec = 1 };
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_port = htons(atoi(argv[1]));
+	addr.sin_addr.s_addr = INADDR_ANY;
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("bind");
+		return 1;
+	}
+
+	signal(SIGINT, stop);
+	signal(SIGTERM, stop);
+
+	struct timespec t_start, t_last_print;
+
+	clock_gettime(CLOCK_MONOTONIC, &t_start);
+	t_last_print = t_start;
+
+	while (running) {
+		struct pkt_hdr hdr;
+		struct timespec now;
+		ssize_t n;
+		double lat;
+
+		n = recv(fd, buf, sizeof(buf), 0);
+		if (n < (ssize_t)sizeof(struct pkt_hdr))
+			continue;
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		memcpy(&hdr, buf, sizeof(hdr));
+
+		/* Track drops (gaps) and reorders (late arrivals) */
+		if (hdr.seq > next_seq)
+			drops += hdr.seq - next_seq;
+		if (hdr.seq < next_seq)
+			reorders++;
+		if (hdr.seq >= next_seq)
+			next_seq = hdr.seq + 1;
+
+		lat = (now.tv_sec - hdr.ts.tv_sec) +
+		      (now.tv_nsec - hdr.ts.tv_nsec) * 1e-9;
+
+		if (lat < lat_min)
+			lat_min = lat;
+		if (lat > lat_max)
+			lat_max = lat;
+		lat_sum += lat;
+		lat_sum_sq += lat * lat;
+		count++;
+
+		{
+			double since_print;
+
+			since_print = (now.tv_sec - t_last_print.tv_sec) +
+				      (now.tv_nsec - t_last_print.tv_nsec) * 1e-9;
+			if (since_print >= 5.0) {
+				print_periodic(count, count - last_count,
+					       since_print, drops,
+					       reorders, lat_min,
+					       lat_sum, lat_max);
+				last_count = count;
+				t_last_print = now;
+			}
+		}
+	}
+
+	{
+		struct timespec t_now;
+		double elapsed;
+
+		clock_gettime(CLOCK_MONOTONIC, &t_now);
+		elapsed = (t_now.tv_sec - t_start.tv_sec) +
+			  (t_now.tv_nsec - t_start.tv_nsec) * 1e-9;
+		print_final(count, elapsed, drops, reorders,
+			    lat_min, lat_sum, lat_sum_sq, lat_max);
+	}
+	close(fd);
+	return 0;
+}
+CEOF
+gcc -O2 -Wall -o "$TMPDIR"/udp_sink "$TMPDIR"/udp_sink.c -lm || exit $ksft_fail
+}
+
+setup_veth() {
+    log_info "Setting up veth pair with GRO"
+    setup_ns NS || exit $ksft_skip
+    ip link add "$VETH_A" type veth peer name "$VETH_B" || \
+        { echo "Failed to create veth pair (need root?)"; exit $ksft_skip; }
+    ip link set "$VETH_B" netns "$NS" || \
+        { echo "Failed to move veth to namespace"; exit $ksft_skip; }
+
+    # Configure IPs
+    ip addr add "${IP_A}/24" dev "$VETH_A"
+    ip link set "$VETH_A" up
+
+    ip -netns "$NS" addr add "${IP_B}/24" dev "$VETH_B"
+    ip -netns "$NS" link set "$VETH_B" up
+
+    # Raise wmem_max so the flood tool's SO_SNDBUF takes effect.
+    # Default 212992 caps in-flight to ~93 packets (sk_wmem_alloc limit),
+    # which is less than the 256-entry ptr_ring and prevents backpressure.
+    ORIG_WMEM_MAX=$(sysctl -n net.core.wmem_max)
+    sysctl -qw net.core.wmem_max=1048576
+
+    # Enable GRO on both ends -- activates NAPI -- BQL code path
+    ethtool -K "$VETH_A" gro on 2>/dev/null || true
+    ip netns exec "$NS" ethtool -K "$VETH_B" gro on 2>/dev/null || true
+
+    # Disable TSO so veth_skb_is_eligible_for_gro() returns true for all
+    # packets, ensuring every SKB takes the NAPI/ptr_ring path.  With TSO
+    # enabled, only packets matching sock_wfree + GRO features are eligible;
+    # disabling TSO removes that filter unconditionally.
+    ethtool -K "$VETH_A" tso off gso off 2>/dev/null || true
+    ip netns exec "$NS" ethtool -K "$VETH_B" tso off gso off 2>/dev/null || true
+
+    # Enable threaded NAPI -- this is critical: BQL backpressure (STACK_XOFF)
+    # only engages when producer and consumer run on separate CPUs.
+    # Without threaded NAPI, softirq completions happen too fast for BQL
+    # to build up enough in-flight bytes to trigger the limit.
+    if [ "$NORMAL_NAPI" -eq 0 ]; then
+        echo 1 > /sys/class/net/"$VETH_A"/threaded 2>/dev/null || true
+        ip netns exec "$NS" sh -c "echo 1 > /sys/class/net/$VETH_B/threaded" 2>/dev/null || true
+        log_info "Threaded NAPI enabled"
+    else
+        log_info "Using normal softirq NAPI (threaded NAPI disabled)"
+    fi
+}
+
+install_qdisc() {
+    local qdisc="${1:-$QDISC}"
+    local opts="${2:-}"
+    # Add a qdisc -- veth defaults to noqueue, but BQL needs a qdisc
+    # because STACK_XOFF is checked by the qdisc layer.
+    # Note: qdisc_create() auto-fixes txqueuelen=0 on IFF_NO_QUEUE devices
+    # to DEFAULT_TX_QUEUE_LEN (commit 84c46dd86538).
+    log_info "Installing qdisc: $qdisc $opts"
+    tc qdisc replace dev "$VETH_A" root $qdisc $opts
+    ip netns exec "$NS" tc qdisc replace dev "$VETH_B" root $qdisc $opts
+}
+
+remove_qdisc() {
+    log_info "Removing qdisc (reverting to noqueue)"
+    tc qdisc del dev "$VETH_A" root 2>/dev/null || true
+    ip netns exec "$NS" tc qdisc del dev "$VETH_B" root 2>/dev/null || true
+}
+
+setup_iptables() {
+    # Bulk-load iptables rules in consumer namespace to slow NAPI processing.
+    # Many rules force per-packet linear rule traversal, increasing consumer
+    # overhead and BQL inflight bytes -- simulates realistic k8s-like workload.
+    if [ "$NRULES" -gt 0 ]; then
+        ip netns exec "$NS" bash -c '
+        iptables-restore < <(
+        echo "*filter"
+        for n in $(seq 1 '"$NRULES"'); do
+          echo "-I INPUT -d '"$IP_B"'"
+        done
+        echo "COMMIT"
+        )
+        ' 2>/dev/null || log_info "iptables not available, skipping rules"
+        log_info "Loaded $NRULES iptables rules in consumer NS"
+    fi
+}
+
+check_bql_sysfs() {
+    BQL_DIR="/sys/class/net/${VETH_A}/queues/tx-0/byte_queue_limits"
+    if [ -d "$BQL_DIR" ]; then
+        log_info "BQL sysfs found: $BQL_DIR"
+        if [ "$BQL_DISABLE" -eq 1 ]; then
+            echo 1073741824 > "$BQL_DIR/limit_min"
+            log_info "BQL effectively disabled (limit_min=1G)"
+        fi
+    else
+        log_info "BQL sysfs absent (veth IFF_NO_QUEUE+lltx, DQL accounting still active)"
+        BQL_DIR=""
+    fi
+}
+
+start_traffic() {
+    # Snapshot dmesg before test
+    DMESG_BEFORE=$(dmesg | wc -l)
+
+    log_info "Starting UDP sink in namespace"
+    ip netns exec "$NS" "$TMPDIR"/udp_sink "$PORT" &
+    SINK_PID=$!
+    sleep 0.2
+
+    log_info "Starting ping to $IP_B (5/s) to measure latency under load"
+    ping -i 0.2 -w "$DURATION" "$IP_B" > "$TMPDIR"/ping.log 2>&1 &
+    PING_PID=$!
+
+    log_info "Flooding ${PKT_SIZE}-byte UDP packets for ${DURATION}s"
+    "$TMPDIR"/udp_flood "$IP_B" "$PKT_SIZE" "$PORT" "$DURATION" &
+    FLOOD_PID=$!
+
+    # Optional: start bpftrace napi_poll histogram (best-effort)
+    local bt_script="$(dirname -- "$0")/napi_poll_hist.bt"
+    if command -v bpftrace >/dev/null 2>&1 && [ -f "$bt_script" ]; then
+        bpftrace "$bt_script" > "$TMPDIR"/napi_poll.log 2>&1 &
+        BPFTRACE_PID=$!
+        log_info "bpftrace napi_poll histogram started (pid=$BPFTRACE_PID)"
+    fi
+}
+
+stop_traffic() {
+    [ -n "$FLOOD_PID" ] && kill_process $FLOOD_PID
+    FLOOD_PID=""
+    [ -n "$SINK_PID" ] && kill_process $SINK_PID
+    SINK_PID=""
+    [ -n "$PING_PID" ] && kill_process $PING_PID
+    PING_PID=""
+    [ -n "$BPFTRACE_PID" ] && kill_process $BPFTRACE_PID
+    BPFTRACE_PID=""
+}
+
+check_dmesg_bug() {
+    local bug_pattern='kernel BUG|BUG:|Oops:|dql_completed'
+    local warn_pattern='WARNING:|asks to queue packet|NETDEV WATCHDOG'
+    if dmesg | tail -n +$((DMESG_BEFORE + 1)) | \
+       grep -qE "$bug_pattern"; then
+        dmesg | tail -n +$((DMESG_BEFORE + 1)) | \
+            grep -B2 -A20 -E "$bug_pattern|$warn_pattern"
+        return 1
+    fi
+    # Log new warnings since last check (don't repeat old ones)
+    local cur_lines
+    cur_lines=$(dmesg | wc -l)
+    if [ "$cur_lines" -gt "${DMESG_WARN_SEEN:-$DMESG_BEFORE}" ]; then
+        local new_warns
+        new_warns=$(dmesg | tail -n +$(("${DMESG_WARN_SEEN:-$DMESG_BEFORE}" + 1)) | \
+            grep -E "$warn_pattern") || true
+        if [ -n "$new_warns" ]; then
+            local cnt
+            cnt=$(echo "$new_warns" | wc -l)
+            echo "  WARN: $cnt new kernel warning(s):"
+            echo "$new_warns" | tail -5
+        fi
+    fi
+    DMESG_WARN_SEEN=$cur_lines
+    return 0
+}
+
+print_periodic_stats() {
+    local elapsed="$1"
+
+    # BQL stats and watchdog counter
+    WD_CNT=$(cat /sys/class/net/${VETH_A}/queues/tx-0/tx_timeout \
+        2>/dev/null) || WD_CNT="?"
+    if [ -n "$BQL_DIR" ] && [ -d "$BQL_DIR" ]; then
+        INFLIGHT=$(cat "$BQL_DIR/inflight" 2>/dev/null || echo "?")
+        LIMIT=$(cat "$BQL_DIR/limit" 2>/dev/null || echo "?")
+        echo "  [${elapsed}s] BQL inflight=${INFLIGHT} limit=${LIMIT}" \
+            "watchdog=${WD_CNT}"
+    else
+        echo "  [${elapsed}s] watchdog=${WD_CNT} (no BQL sysfs)"
+    fi
+
+    # Qdisc stats
+    JQ_FMT='"qdisc \(.kind) pkts=\(.packets) drops=\(.drops)'
+    JQ_FMT+=' requeues=\(.requeues) backlog=\(.backlog)'
+    JQ_FMT+=' qlen=\(.qlen) overlimits=\(.overlimits)"'
+    CUR_QPKTS=$(tc -j -s qdisc show dev "$VETH_A" root 2>/dev/null |
+        jq -r '.[0].packets // 0' 2>/dev/null) || CUR_QPKTS=0
+    QSTATS=$(tc -j -s qdisc show dev "$VETH_A" root 2>/dev/null |
+        jq -r ".[0] | $JQ_FMT" 2>/dev/null) &&
+        echo "  [${elapsed}s] $QSTATS" || true
+
+    # Consumer PPS and per-packet processing time
+    if [ "$PREV_QPKTS" -gt 0 ] 2>/dev/null; then
+        DELTA=$((CUR_QPKTS - PREV_QPKTS))
+        PPS=$((DELTA / INTERVAL))
+        if [ "$PPS" -gt 0 ]; then
+            PKT_MS=$(awk "BEGIN {printf \"%.3f\", 1000.0/$PPS}")
+            NAPI_MS=$(awk "BEGIN {printf \"%.1f\", 64000.0/$PPS}")
+            echo "  [${elapsed}s] consumer: ${PPS} pps" \
+                "(~${PKT_MS}ms/pkt, NAPI-64 cycle ~${NAPI_MS}ms)"
+        fi
+    fi
+    PREV_QPKTS=$CUR_QPKTS
+
+    # softnet_stat: per-CPU tracking to detect same-CPU vs multi-CPU NAPI
+    # /proc/net/softnet_stat columns: processed, dropped, time_squeeze (hex, per-CPU)
+    local cpu=0 total_proc=0 total_sq=0 active_cpus=""
+    while read -r line; do
+        set -- $line
+        local cur_p=$((0x${1})) cur_sq=$((0x${3}))
+        if [ -f "$TMPDIR/softnet_cpu${cpu}" ]; then
+            read prev_p prev_sq < "$TMPDIR/softnet_cpu${cpu}"
+            local dp=$((cur_p - prev_p)) dsq=$((cur_sq - prev_sq))
+            total_proc=$((total_proc + dp))
+            total_sq=$((total_sq + dsq))
+            [ "$dp" -gt 0 ] && active_cpus="${active_cpus} cpu${cpu}(+${dp})"
+        fi
+        echo "$cur_p $cur_sq" > "$TMPDIR/softnet_cpu${cpu}"
+        cpu=$((cpu + 1))
+    done < /proc/net/softnet_stat
+    local n_active=$(echo $active_cpus | wc -w)
+    local cpu_mode="single-CPU"
+    [ "$n_active" -gt 1 ] && cpu_mode="multi-CPU(${n_active})"
+    if [ "$total_sq" -gt 0 ] && [ "$INTERVAL" -gt 0 ]; then
+        echo "  [${elapsed}s] softnet: processed=${total_proc}" \
+            "time_squeeze=${total_sq} (${total_sq}/${INTERVAL}s)" \
+            "${cpu_mode}:${active_cpus}"
+    else
+        echo "  [${elapsed}s] softnet: processed=${total_proc}" \
+            "time_squeeze=${total_sq}" \
+            "${cpu_mode}:${active_cpus}"
+    fi
+
+    # napi_poll histogram (from bpftrace, if running)
+    if [ -n "$BPFTRACE_PID" ] && [ -f "$TMPDIR"/napi_poll.log ]; then
+        local napi_line
+        napi_line=$(grep '^napi_poll:' "$TMPDIR"/napi_poll.log | tail -1)
+        [ -n "$napi_line" ] && echo "  [${elapsed}s] $napi_line"
+    fi
+
+    # Ping RTT
+    PING_RTT=$(tail -1 "$TMPDIR"/ping.log 2>/dev/null | grep -oP 'time=\K[0-9.]+') &&
+        echo "  [${elapsed}s] ping RTT=${PING_RTT}ms" || true
+}
+
+monitor_loop() {
+    ELAPSED=0
+    INTERVAL=5
+    PREV_QPKTS=0
+    # Seed per-CPU softnet baselines
+    local cpu=0
+    while read -r line; do
+        set -- $line
+        echo "$((0x${1})) $((0x${3}))" > "$TMPDIR/softnet_cpu${cpu}"
+        cpu=$((cpu + 1))
+    done < /proc/net/softnet_stat
+    while kill -0 "$FLOOD_PID" 2>/dev/null; do
+        sleep "$INTERVAL"
+        ELAPSED=$((ELAPSED + INTERVAL))
+
+        if ! check_dmesg_bug; then
+            RET=$ksft_fail
+            retmsg="BUG_ON triggered in dql_completed at ${ELAPSED}s"
+            log_test "veth_bql"
+            exit $EXIT_STATUS
+        fi
+
+        print_periodic_stats "$ELAPSED"
+    done
+    wait "$FLOOD_PID" || true
+    FLOOD_PID=""
+}
+
+# Verify traffic is flowing by checking device tx_packets counter.
+# Works for both qdisc and noqueue modes.
+verify_traffic_flowing() {
+    local label="$1"
+    local prev_tx cur_tx
+
+    # Skip check if flood producer already exited (not a stall)
+    if [ -n "$FLOOD_PID" ] && ! kill -0 "$FLOOD_PID" 2>/dev/null; then
+        log_info "$label flood producer exited (duration reached)"
+        return 0
+    fi
+
+    prev_tx=$(cat /sys/class/net/${VETH_A}/statistics/tx_packets \
+        2>/dev/null) || prev_tx=0
+    sleep 0.5
+    cur_tx=$(cat /sys/class/net/${VETH_A}/statistics/tx_packets \
+        2>/dev/null) || cur_tx=0
+    if [ "$cur_tx" -gt "$prev_tx" ]; then
+        log_info "$label traffic flowing (tx: $prev_tx -> $cur_tx)"
+        return 0
+    fi
+    log_info "$label traffic STALLED (tx: $prev_tx -> $cur_tx)"
+    return 1
+}
+
+collect_results() {
+    local test_name="${1:-veth_bql}"
+
+    # Ping summary
+    wait "$PING_PID" 2>/dev/null || true
+    PING_PID=""
+    if [ -f "$TMPDIR"/ping.log ]; then
+        PING_LOSS=$(grep -o '[0-9.]*% packet loss' "$TMPDIR"/ping.log) &&
+            log_info "Ping loss: $PING_LOSS"
+        PING_SUMMARY=$(tail -1 "$TMPDIR"/ping.log)
+        log_info "Ping summary: $PING_SUMMARY"
+    fi
+
+    # Watchdog summary
+    WD_FINAL=$(cat /sys/class/net/${VETH_A}/queues/tx-0/tx_timeout \
+        2>/dev/null) || WD_FINAL=0
+    if [ "$WD_FINAL" -gt 0 ] 2>/dev/null; then
+        log_info "Watchdog fired ${WD_FINAL} time(s)"
+        dmesg | tail -n +$((DMESG_BEFORE + 1)) | \
+            grep -E 'NETDEV WATCHDOG|veth backpressure' || true
+    fi
+
+    # Final dmesg check -- only upgrade to fail, never override existing fail
+    if ! check_dmesg_bug; then
+        RET=$ksft_fail
+        retmsg="BUG_ON triggered in dql_completed"
+    fi
+    log_test "$test_name"
+    exit $EXIT_STATUS
+}
+
+# --- Test modes ---
+
+test_bql_stress() {
+    RET=$ksft_pass
+    compile_tools
+    setup_veth
+    install_qdisc "$QDISC" "$QDISC_OPTS"
+    setup_iptables
+    log_info "kernel: $(uname -r)"
+    check_bql_sysfs
+    start_traffic
+    monitor_loop
+    collect_results "veth_bql"
+}
+
+# Test qdisc replacement under active traffic.  Cycles through several
+# qdiscs including a transition to noqueue (tc qdisc del) to verify
+# that stale BQL state (STACK_XOFF) is properly reset during qdisc
+# transitions.
+test_qdisc_replace() {
+    local qdiscs=("sfq" "pfifo" "fq_codel")
+    local step=2
+    local elapsed=0
+    local idx
+
+    RET=$ksft_pass
+    compile_tools
+    setup_veth
+    install_qdisc "$QDISC" "$QDISC_OPTS"
+    setup_iptables
+    log_info "kernel: $(uname -r)"
+    check_bql_sysfs
+    start_traffic
+
+    while [ "$elapsed" -lt "$DURATION" ] && kill -0 "$FLOOD_PID" 2>/dev/null; do
+        sleep "$step"
+        elapsed=$((elapsed + step))
+
+        if ! check_dmesg_bug; then
+            RET=$ksft_fail
+            retmsg="BUG_ON during qdisc replacement at ${elapsed}s"
+            break
+        fi
+
+        # Cycle: sfq -> pfifo -> fq_codel -> noqueue -> sfq -> ...
+        idx=$(( (elapsed / step - 1) % (${#qdiscs[@]} + 1) ))
+        if [ "$idx" -eq "${#qdiscs[@]}" ]; then
+            remove_qdisc
+        else
+            install_qdisc "${qdiscs[$idx]}"
+        fi
+
+        # Print BQL and qdisc stats after each replacement
+        if [ -n "$BQL_DIR" ] && [ -d "$BQL_DIR" ]; then
+            local inflight limit limit_min limit_max holding
+            inflight=$(cat "$BQL_DIR/inflight" 2>/dev/null || echo "?")
+            limit=$(cat "$BQL_DIR/limit" 2>/dev/null || echo "?")
+            limit_min=$(cat "$BQL_DIR/limit_min" 2>/dev/null || echo "?")
+            limit_max=$(cat "$BQL_DIR/limit_max" 2>/dev/null || echo "?")
+            holding=$(cat "$BQL_DIR/holding_time" 2>/dev/null || echo "?")
+            echo "  [${elapsed}s] BQL inflight=${inflight} limit=${limit}" \
+                "limit_min=${limit_min} limit_max=${limit_max}" \
+                "holding=${holding}"
+        fi
+        local cur_qdisc
+        cur_qdisc=$(tc qdisc show dev "$VETH_A" root 2>/dev/null | \
+            awk '{print $2}') || cur_qdisc="none"
+        local txq_state
+        txq_state=$(cat /sys/class/net/${VETH_A}/queues/tx-0/tx_timeout \
+            2>/dev/null) || txq_state="?"
+        echo "  [${elapsed}s] qdisc=${cur_qdisc} watchdog=${txq_state}"
+
+        if ! verify_traffic_flowing "[${elapsed}s]"; then
+            RET=$ksft_fail
+            retmsg="Traffic stalled after qdisc replacement at ${elapsed}s"
+            break
+        fi
+    done
+
+    stop_traffic
+    collect_results "veth_bql_qdisc_replace"
+}
+
+# --- Main ---
+if [ "$QDISC_REPLACE" -eq 1 ]; then
+    test_qdisc_replace
+else
+    test_bql_stress
+fi
diff --git a/tools/testing/selftests/net/veth_bql_test_virtme.sh b/tools/testing/selftests/net/veth_bql_test_virtme.sh
new file mode 100755
index 000000000000..b097e5670808
--- /dev/null
+++ b/tools/testing/selftests/net/veth_bql_test_virtme.sh
@@ -0,0 +1,124 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Launch veth BQL test inside virtme-ng
+#
+# Must be run from the kernel build tree root.
+#
+# Options:
+#   --verbose       Show kernel console (vng boot messages) in real time.
+#                   Useful for debugging kernel panics / BUG_ON crashes.
+#   All other options are forwarded to veth_bql_test.sh (see --help there).
+#
+# Examples:
+#   ./tools/testing/selftests/net/veth_bql_test_virtme.sh
+#   ./tools/testing/selftests/net/veth_bql_test_virtme.sh --duration 20 --nrules 1000 --qdisc fq_codel
+#   ./tools/testing/selftests/net/veth_bql_test_virtme.sh --qdisc fq_codel --bql-disable
+#   ./tools/testing/selftests/net/veth_bql_test_virtme.sh --verbose --qdisc-replace --duration 60
+
+set -eu
+
+# Parse --verbose (consumed here, not forwarded to the inner test).
+VERBOSE=""
+INNER_ARGS=()
+for arg in "$@"; do
+    if [ "$arg" = "--verbose" ]; then
+        VERBOSE="--verbose"
+    else
+        INNER_ARGS+=("$arg")
+    fi
+done
+TEST_ARGS=$(printf '%q ' "${INNER_ARGS[@]+${INNER_ARGS[@]}}")
+TEST="tools/testing/selftests/net/veth_bql_test.sh"
+
+if [ ! -f "$TEST" ]; then
+    echo "ERROR: Run this from the kernel tree root" >&2
+    echo "  cd /path/to/kernel && $0" >&2
+    exit 1
+fi
+
+# Verify .config has the options needed for virtme-ng and this test.
+# Without these the VM silently stalls with no output.
+KCONFIG=".config"
+if [ ! -f "$KCONFIG" ]; then
+    echo "ERROR: No .config found -- build the kernel first" >&2
+    exit 1
+fi
+
+MISSING=""
+for opt in CONFIG_VIRTIO CONFIG_VIRTIO_PCI CONFIG_VIRTIO_NET \
+           CONFIG_VIRTIO_CONSOLE CONFIG_NET_9P CONFIG_NET_9P_VIRTIO \
+           CONFIG_9P_FS CONFIG_VETH CONFIG_BQL; do
+    if ! grep -q "^${opt}=[ym]" "$KCONFIG"; then
+        MISSING+="  $opt\n"
+    fi
+done
+if [ -n "$MISSING" ]; then
+    echo "ERROR: .config is missing options required by virtme-ng:" >&2
+    echo -e "$MISSING" >&2
+    echo "Consider: vng --kconfig (or make defconfig + enable above)" >&2
+    exit 1
+fi
+
+TESTDIR="tools/testing/selftests/net"
+TESTNAME="veth_bql_test.sh"
+LOGFILE="veth_bql_test.log"
+LOGPATH="$TESTDIR/$LOGFILE"
+CONSOLELOG="veth_bql_console.log"
+rm -f "$LOGPATH" "$CONSOLELOG"
+
+echo "Starting VM... test output in $LOGPATH, kernel console in $CONSOLELOG"
+echo "(VM is booting, please wait ~30s)"
+
+# Always capture kernel console to a file via a second QEMU serial port.
+# vng claims ttyS0 (mapped to /dev/null); --qemu-opts adds ttyS1 on COM2.
+# earlycon registers COM2's I/O port (0x2f8) as a persistent console.
+# (plain console=ttyS1 does NOT work: the 8250 driver registers once,
+# ttyS0 wins, and ttyS1 is never picked up.)
+# --verbose additionally shows kernel console in real time on the terminal.
+SERIAL_CONSOLE="earlycon=uart8250,io,0x2f8,115200"
+SERIAL_CONSOLE+=" console=uart8250,io,0x2f8,115200"
+set +e
+vng $VERBOSE --cpus 4 --memory 2G \
+    --rwdir "$TESTDIR" \
+    --append "panic=5 loglevel=4 $SERIAL_CONSOLE" \
+    --qemu-opts="-serial file:$CONSOLELOG" \
+    --exec "cd $TESTDIR && \
+        ./$TESTNAME $TEST_ARGS 2>&1 | \
+        tee $LOGFILE; echo EXIT_CODE=\$? >> $LOGFILE"
+VNG_RC=$?
+set -e
+
+echo ""
+if [ "$VNG_RC" -ne 0 ]; then
+    echo "***********************************************************"
+    echo "* VM CRASHED -- kernel panic or BUG_ON (vng rc=$VNG_RC)"
+    echo "***********************************************************"
+    if [ -s "$CONSOLELOG" ] && \
+       grep -qiE 'kernel BUG|BUG:|Oops:|panic|dql_completed' "$CONSOLELOG"; then
+        echo ""
+        echo "--- kernel backtrace ($CONSOLELOG) ---"
+        grep -iE -A30 'kernel BUG|BUG:|Oops:|panic|dql_completed' \
+            "$CONSOLELOG" | head -50
+    else
+        echo ""
+        echo "Re-run with --verbose to see the kernel backtrace:"
+        echo "  $0 --verbose ${INNER_ARGS[*]}"
+    fi
+    exit 1
+elif [ ! -f "$LOGPATH" ]; then
+    echo "No log file found -- VM may have crashed before writing output"
+    exit 2
+else
+    echo "=== VM finished ==="
+fi
+
+# Scan console log for unexpected kernel warnings (even on clean exit)
+if [ -s "$CONSOLELOG" ]; then
+    WARN_PATTERN='kernel BUG|BUG:|Oops:|dql_completed|WARNING:|asks to queue packet|NETDEV WATCHDOG'
+    WARN_LINES=$(grep -cE "$WARN_PATTERN" "$CONSOLELOG" 2>/dev/null) || WARN_LINES=0
+    if [ "$WARN_LINES" -gt 0 ]; then
+        echo ""
+        echo "*** kernel warnings in $CONSOLELOG ($WARN_LINES lines) ***"
+        grep -E "$WARN_PATTERN" "$CONSOLELOG" | head -20
+    fi
+fi
-- 
2.43.0


