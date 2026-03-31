Return-Path: <netdev+bounces-273756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIguENs5zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BAF371823
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A603127950
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAEE44BCA8;
	Tue, 31 Mar 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBYJ+OWb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CF4266A3;
	Tue, 31 Mar 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991303; cv=none; b=iymiiXlA9FpxzGaRZsrga4xWCNGZaPWVwP5lFtNaYwiZPGhMT+tq3Q799bx4Ct1U29hjwNgW81FQhqCT+ertHCG0rEiRvyxTkVHdfmEAA+vR1bJvFppx47fbthROclY0uRtBd3FPJ5ld3e+vlBSfIkOMv5/7x0EAVOQgbnq4sk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991303; c=relaxed/simple;
	bh=FYCIpMbPcjDO83WNIwjmoQl8ZJBIFtcZmblHiPhwTio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cibmFxak5/6W3ld0fXmkCuYXHLE0GTr8JbzvG9dRuNDqSrt/PMRffDZWQE3mhTmSpObuYUmy1A6opBimd4HZMrfjZvfUH0wSnntxYXYxfaeUuLhipFnHy2hLPzOP4Frq8k9I+ZBfdj+9wY5+Z6N5lcPCQx28EPLewxyYyFTWZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBYJ+OWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816E2C2BC9E;
	Tue, 31 Mar 2026 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991303;
	bh=FYCIpMbPcjDO83WNIwjmoQl8ZJBIFtcZmblHiPhwTio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBYJ+OWbfV59Q30ypK1Ic6wPvhUcVc/o9PGkpH87TQM22NDpOdSEA4NGqj4mv9Al5
	 NjegDPq9BteqjG2w5IWN4JVoXj1+ZenKMvy0IcDh1AGeeNoQxknQgUPprc+UqtcRvu
	 WPpzGHfO7ysugGYq57SIuolFvShZeMMrWXdVK1C+8bVUu6AthpSJG4CTUWSPCBKWl6
	 0wAJe/4WOLTh+FuRnZZu1cWL21Ji9Ax7VW9B07PscqkqzOd0qYiHhvVjxa1QnyJFPM
	 sdbRfKYixHIA7tZX8Tpt4weIQ/ccxlfxeyLltiPPdtPY6ZJ5otagBc3gDM1HV0gA7B
	 0SZcGwfyzmWNQ==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hawk@kernel.org,
	ivan@cloudflare.com,
	kernel-team@cloudflare.com
Subject: [RFC PATCH net-next 4/4] selftests: net: add IPv4 address lookup stress test
Date: Tue, 31 Mar 2026 23:07:39 +0200
Message-ID: <20260331210739.3998753-5-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331210739.3998753-1-hawk@kernel.org>
References: <20260331210739.3998753-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273756-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ipv4_addr_lookup_test_virtme.sh:url,ipv4_addr_lookup_trace.bt:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ipv4_addr_lookup_test.sh:url]
X-Rspamd-Queue-Id: 68BAF371823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add a test that exercises the IPv4 local address hash table
(inet_addr_lst) insert, lookup, and remove paths under load:

 - Add/remove 1000 addresses to trigger rhltable growth and shrinking
 - Unconnected UDP sendmsg stress to exercise the __ip_dev_find()
   lookup hot path (each sendto triggers a hash table lookup)
 - Duplicate key test: same IP on two different interfaces
 - Address lifetime expiry via check_lifetime() work function
 - Ping-based lookup verification from sampled addresses

The test uses network namespaces and veth pairs to avoid polluting the
host. A C helper (ipv4_addr_lookup_udp_sender) pre-creates sockets
during setup for low-noise measurement with per-round statistics.

Optional bpftrace integration (--bpftrace, --bpftrace-debug) provides
latency histograms and resize event tracing for A/B kernel comparison.
A virtme-ng wrapper script is included for isolated VM testing.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 tools/testing/selftests/net/Makefile          |   4 +
 .../selftests/net/ipv4_addr_lookup_test.sh    | 804 ++++++++++++++++++
 .../net/ipv4_addr_lookup_test_virtme.sh       | 282 ++++++
 .../selftests/net/ipv4_addr_lookup_trace.bt   | 178 ++++
 .../net/ipv4_addr_lookup_udp_sender.c         | 401 +++++++++
 5 files changed, 1669 insertions(+)
 create mode 100755 tools/testing/selftests/net/ipv4_addr_lookup_test.sh
 create mode 100755 tools/testing/selftests/net/ipv4_addr_lookup_test_virtme.sh
 create mode 100644 tools/testing/selftests/net/ipv4_addr_lookup_trace.bt
 create mode 100644 tools/testing/selftests/net/ipv4_addr_lookup_udp_sender.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6bced3ed798b..1724d1478020 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -42,6 +42,7 @@ TEST_PROGS := \
 	gre_ipv6_lladdr.sh \
 	icmp.sh \
 	icmp_redirect.sh \
+	ipv4_addr_lookup_test.sh \
 	io_uring_zerocopy_tx.sh \
 	ioam6.sh \
 	ip6_gre_headroom.sh \
@@ -127,6 +128,8 @@ TEST_PROGS := \
 # end of TEST_PROGS
 
 TEST_PROGS_EXTENDED := \
+	ipv4_addr_lookup_test_virtme.sh \
+	ipv4_addr_lookup_trace.bt \
 	xfrm_policy_add_speed.sh \
 # end of TEST_PROGS_EXTENDED
 
@@ -135,6 +138,7 @@ TEST_GEN_FILES := \
 	cmsg_sender \
 	fin_ack_lat \
 	hwtstamp_config \
+	ipv4_addr_lookup_udp_sender \
 	io_uring_zerocopy_tx \
 	ioam6_parser \
 	ip_defrag \
diff --git a/tools/testing/selftests/net/ipv4_addr_lookup_test.sh b/tools/testing/selftests/net/ipv4_addr_lookup_test.sh
new file mode 100755
index 000000000000..df9924e165af
--- /dev/null
+++ b/tools/testing/selftests/net/ipv4_addr_lookup_test.sh
@@ -0,0 +1,804 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Stress test for IPv4 address hash table (inet_addr_lst / rhltable).
+#
+# Exercises the rhltable insert, lookup, and remove paths by:
+#  1. Adding many IPv4 addresses (triggers rhltable growth/resizing)
+#  2. Sending unconnected UDP to exercise the __ip_dev_find lookup hot path
+#  3. Removing all addresses (triggers rhltable shrinking)
+#  4. Testing duplicate keys (same IP on different devices)
+#
+# Uses veth pairs in network namespaces to avoid polluting the host.
+#
+# Options:
+#   --num-addrs N    Number of addresses to add (default: 1000)
+#   --rounds N       Measurement rounds for UDP benchmark (default: 10)
+#   --duration  S    Seconds per measurement round (default: 3)
+#   --bench-only     Only run the UDP sendmsg benchmark (skip other tests)
+#   --sink           Use C receiver to count packets (adds CPU overhead)
+#   --threaded-napi  Move veth RX to separate CPU (cleaner perf profiles)
+#   --verbose        Show detailed output
+#   --help           Show usage
+
+source "$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")/lib.sh"
+
+NUM_ADDRS=1000
+ROUNDS=10
+DURATION=3
+BENCH_ONLY=0
+VERBOSE=0
+USE_BPFTRACE=0
+BPFTRACE_DEBUG=0
+USE_SINK=0
+USE_THREADED_NAPI=0
+RET=0
+BPFTRACE_PID=0
+BPFTRACE_LOG=""
+
+usage() {
+	echo "Usage: $0 [OPTIONS]"
+	echo "  --num-addrs N   Number of IPv4 addresses to add (default: $NUM_ADDRS)"
+	echo "  --rounds N      Measurement rounds for benchmark (default: $ROUNDS)"
+	echo "  --duration S    Seconds per measurement round (default: $DURATION)"
+	echo "  --bench-only    Only run the UDP sendmsg benchmark"
+	echo "  --verbose       Show detailed output"
+	echo "  --bpftrace      Trace __ip_dev_find latency (minimal overhead for A/B)"
+	echo "  --sink            Use C receiver to count packets (adds CPU overhead)"
+	echo "  --threaded-napi   Move veth RX to separate CPU (cleaner perf profiles)"
+	echo "  --bpftrace-debug  Trace all code paths (lookup, insert, remove, resize)"
+	exit 0
+}
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--num-addrs)	NUM_ADDRS="$2"; shift 2 ;;
+	--rounds)	ROUNDS="$2"; shift 2 ;;
+	--duration)	DURATION="$2"; shift 2 ;;
+	--bench-only)	BENCH_ONLY=1; shift ;;
+	--verbose)	VERBOSE=1; shift ;;
+	--bpftrace)	USE_BPFTRACE=1; shift ;;
+	--sink)		USE_SINK=1; shift ;;
+	--threaded-napi)	USE_THREADED_NAPI=1; shift ;;
+	--bpftrace-debug)	USE_BPFTRACE=1; BPFTRACE_DEBUG=1; shift ;;
+	--help)		usage ;;
+	*)		echo "Unknown option: $1"; usage ;;
+	esac
+done
+
+log() {
+	[ "$VERBOSE" -eq 1 ] && echo "  $*"
+}
+
+log_config() {
+	echo "  Config: $*"
+}
+
+PASS=0
+FAIL=0
+
+# ---------------------------------------------------------------------------
+# bpftrace helpers
+# ---------------------------------------------------------------------------
+
+BT_SCRIPT_GEN=""
+
+# Check if a kernel function is actually kprobe-able (not notrace)
+can_kprobe() {
+	local f="$1"
+	# available_filter_functions lists what kprobes can actually attach to
+	local aff
+	for aff in /sys/kernel/tracing/available_filter_functions \
+		   /sys/kernel/debug/tracing/available_filter_functions; do
+		[ -r "$aff" ] && { grep -qw "$f" "$aff" 2>/dev/null; return; }
+	done
+	# Fallback: check kallsyms (may include notrace functions)
+	grep -q "^[0-9a-f]* [tT] ${f}$" /proc/kallsyms 2>/dev/null
+}
+
+# Build bpftrace script dynamically based on available symbols.
+# Sets NPROBES and writes to BT_SCRIPT_GEN (must be set before calling).
+bpftrace_build_script() {
+	NPROBES=0
+
+	# Resolve bucket_table_alloc (may have .isra.0 suffix from GCC)
+	local bta_sym=""
+	local aff
+	for aff in /sys/kernel/tracing/available_filter_functions \
+		   /sys/kernel/debug/tracing/available_filter_functions; do
+		[ -r "$aff" ] && {
+			bta_sym=$(grep -oP 'bucket_table_alloc\S*' "$aff" 2>/dev/null | head -1)
+			break
+		}
+	done
+	[ -z "$bta_sym" ] && \
+		bta_sym=$(grep -oP '(?<= )[tT] \K(bucket_table_alloc[.\w]*)' \
+			  /proc/kallsyms 2>/dev/null | head -1)
+
+	# --- BEGIN block ---
+	if [ "$BPFTRACE_DEBUG" -eq 1 ]; then
+		cat > "$BT_SCRIPT_GEN" <<'BTEOF'
+BEGIN {
+  printf("Tracing inet_addr_lst rhltable paths (debug mode)...\n\n");
+  @ipdev_count = 0; @lookup_count = 0;
+  @insert_count = 0; @insert_slow = 0; @remove_count = 0;
+  @resize_events = 0; @bucket_allocs = 0; @rehash_count = 0;
+  @tbl_size = 0; @tbl_resizes = 0;
+}
+BTEOF
+	else
+		cat > "$BT_SCRIPT_GEN" <<'BTEOF'
+BEGIN {
+  printf("Tracing inet_addr_lst rhltable paths...\n\n");
+  @ipdev_count = 0;
+}
+BTEOF
+	fi
+
+	# Detect old (hlist) vs new (rhltable) kernel:
+	#   old kernel: inet_hash_insert does hlist hash+insert, visible to kprobe
+	#   new kernel: inet_hash_insert wraps rhltable_insert, inlined away
+	local has_rhltable=0
+	if can_kprobe inet_hash_insert; then
+		log "  detected OLD kernel (inet_hash_insert is kprobe-able)"
+	else
+		has_rhltable=1
+		log "  detected NEW kernel (inet_hash_insert inlined -> rhltable)"
+	fi
+
+	# --- Core probe: __ip_dev_find (always, minimal overhead for A/B) ---
+	if can_kprobe __ip_dev_find; then
+		log "  probe: __ip_dev_find (full lookup)"
+		if [ "$BPFTRACE_DEBUG" -eq 1 ] && [ "$has_rhltable" -eq 1 ]; then
+			# New kernel: read rhltable bucket count via BTF to detect resize
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:__ip_dev_find {
+  @ipdev_entry[tid] = nsecs;
+  $net = (struct net *)arg0;
+  $tbl = $net->ipv4.inet_addr_lst.ht.tbl;
+  $size = $tbl->size;
+  if ($size != @tbl_size) {
+    printf("TABLE RESIZE: buckets %lld -> %d  (nelems=%d)\n",
+           @tbl_size, $size, $net->ipv4.inet_addr_lst.ht.nelems.counter);
+    @tbl_size = $size;
+    @tbl_resizes++;
+  }
+}
+BTEOF
+		else
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:__ip_dev_find { @ipdev_entry[tid] = nsecs; }
+BTEOF
+		fi
+		cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kretprobe:__ip_dev_find /@ipdev_entry[tid]/ {
+  $dt = nsecs - @ipdev_entry[tid];
+  @ipdev_ns = hist($dt); @ipdev_stats = stats($dt); @ipdev_count++;
+  delete(@ipdev_entry[tid]);
+}
+BTEOF
+		NPROBES=$((NPROBES + 1))
+	fi
+
+	# --- Debug probes (only with --bpftrace-debug) ---
+	local has_lookup=0 has_resize_wq=0 has_bta=0 has_rehash=0
+
+	if [ "$BPFTRACE_DEBUG" -eq 1 ]; then
+		log "  debug mode: attaching extra probes"
+
+		if can_kprobe inet_lookup_ifaddr_rcu; then
+			has_lookup=1
+			log "  probe: inet_lookup_ifaddr_rcu (inner lookup)"
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:inet_lookup_ifaddr_rcu { @lookup_entry[tid] = nsecs; }
+kretprobe:inet_lookup_ifaddr_rcu /@lookup_entry[tid]/ {
+  $dt = nsecs - @lookup_entry[tid];
+  @lookup_ns = hist($dt); @lookup_stats = stats($dt); @lookup_count++;
+  delete(@lookup_entry[tid]);
+}
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+
+		if can_kprobe inet_hash_insert; then
+			log "  probe: inet_hash_insert (old kernel insert path)"
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:inet_hash_insert { @insert_count++; }
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+
+		if can_kprobe rhashtable_insert_slow; then
+			log "  probe: rhashtable_insert_slow (insert slow path)"
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:rhashtable_insert_slow { @insert_slow++; }
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+
+		if can_kprobe inet_hash_remove; then
+			log "  probe: inet_hash_remove (remove)"
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:inet_hash_remove { @remove_count++; }
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+
+		if can_kprobe rht_deferred_worker; then
+			has_resize_wq=1
+			log "  probe: rht_deferred_worker (resize worker)"
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:rht_deferred_worker {
+  @resize_wq_entry[tid] = nsecs; @resize_events++;
+  printf(">>> RESIZE #%lld: deferred_worker started\n", @resize_events);
+}
+kretprobe:rht_deferred_worker /@resize_wq_entry[tid]/ {
+  $dt = nsecs - @resize_wq_entry[tid];
+  @resize_wq_ns = hist($dt);
+  printf("    RESIZE: done in %lld us\n", $dt / 1000);
+  delete(@resize_wq_entry[tid]);
+}
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+
+		if [ -n "$bta_sym" ] && can_kprobe "$bta_sym"; then
+			has_bta=1
+			log "  probe: $bta_sym (table alloc, arg1=nbuckets)"
+			cat >> "$BT_SCRIPT_GEN" <<BTEOF
+kprobe:${bta_sym} {
+  @bucket_allocs++; @last_alloc_size = arg1;
+  printf("    RESIZE: bucket_table_alloc nbuckets=%lld\\n", arg1);
+  print(kstack(5));
+}
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+
+		if can_kprobe rhashtable_rehash_table; then
+			has_rehash=1
+			log "  probe: rhashtable_rehash_table (data migration)"
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+kprobe:rhashtable_rehash_table { @rehash_entry[tid] = nsecs; }
+kretprobe:rhashtable_rehash_table /@rehash_entry[tid]/ {
+  $dt = nsecs - @rehash_entry[tid];
+  @rehash_ns = hist($dt); @rehash_count++;
+  printf("    RESIZE: rehash done in %lld us\n", $dt / 1000);
+  delete(@rehash_entry[tid]);
+}
+BTEOF
+			NPROBES=$((NPROBES + 1))
+		fi
+	fi
+
+	# --- END block -- only reference maps that actually exist ---
+	cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+END {
+  printf("\n========================================================\n");
+  printf("  inet_addr_lst rhltable trace summary\n");
+  printf("========================================================\n\n");
+  printf("--- __ip_dev_find latency (ns) ---\n");
+  print(@ipdev_ns);
+  printf("  stats (count/avg/total): "); print(@ipdev_stats);
+  printf("\nCOMPARISON: __ip_dev_find calls=%lld\n", @ipdev_count);
+BTEOF
+	if [ "$BPFTRACE_DEBUG" -eq 1 ]; then
+		if [ "$has_rhltable" -eq 1 ]; then
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("\n--- rhltable state (via BTF struct reads) ---\n");
+  printf("  kernel type            : rhltable (new)\n");
+  printf("  final bucket count     : %8lld\n", @tbl_size);
+  printf("  resize events observed : %8lld\n", @tbl_resizes);
+BTEOF
+		else
+			cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("\n--- hash table type ---\n");
+  printf("  kernel type            : hlist (old)\n");
+BTEOF
+		fi
+		[ "$has_lookup" -eq 1 ] && cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("\n--- inet_lookup_ifaddr_rcu latency (ns) ---\n");
+  print(@lookup_ns);
+  printf("  stats (count/avg/total): "); print(@lookup_stats);
+  printf("COMPARISON: inet_lookup_ifaddr_rcu calls=%lld\n", @lookup_count);
+  clear(@lookup_entry);
+BTEOF
+		cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("\n--- Debug call counts ---\n");
+  printf("  inet_hash_insert       : %8lld\n", @insert_count);
+  printf("  rhashtable_insert_slow : %8lld\n", @insert_slow);
+  printf("  inet_hash_remove       : %8lld\n", @remove_count);
+  printf("  rht_deferred_worker    : %8lld\n", @resize_events);
+  printf("  bucket_table_alloc     : %8lld\n", @bucket_allocs);
+BTEOF
+		[ "$has_rehash" -eq 1 ] && cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("  rhashtable_rehash      : %8lld\n", @rehash_count);
+BTEOF
+		[ "$has_resize_wq" -eq 1 ] && cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("\n--- rht_deferred_worker duration (ns) ---\n");
+  print(@resize_wq_ns);
+  clear(@resize_wq_entry);
+BTEOF
+		[ "$has_rehash" -eq 1 ] && cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  printf("\n--- rhashtable_rehash_table duration (ns) ---\n");
+  print(@rehash_ns);
+  clear(@rehash_entry);
+BTEOF
+		[ "$has_bta" -eq 1 ] && cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  clear(@last_alloc_size);
+BTEOF
+	fi
+	cat >> "$BT_SCRIPT_GEN" <<'BTEOF'
+  clear(@ipdev_entry);
+}
+BTEOF
+}
+
+bpftrace_start() {
+	[ "$USE_BPFTRACE" -eq 0 ] && return
+
+	if ! command -v bpftrace >/dev/null 2>&1; then
+		echo "WARN: bpftrace not found, skipping tracing"
+		USE_BPFTRACE=0
+		return
+	fi
+
+	BT_SCRIPT_GEN=$(mktemp /tmp/rhltable_trace_XXXXXX.bt)
+	echo "Probing /proc/kallsyms for available trace points..."
+	bpftrace_build_script
+
+	if [ "$NPROBES" -eq 0 ]; then
+		echo "WARN: no kprobe-able symbols found, skipping tracing"
+		USE_BPFTRACE=0
+		rm -f "$BT_SCRIPT_GEN"
+		return
+	fi
+	echo "Built dynamic bpftrace script with $NPROBES probe groups"
+	log "Script: $BT_SCRIPT_GEN"
+
+	BPFTRACE_LOG=$(mktemp /tmp/rhltable_trace.XXXXXX)
+	bpftrace "$BT_SCRIPT_GEN" > "$BPFTRACE_LOG" 2>&1 &
+	BPFTRACE_PID=$!
+	# Give bpftrace time to attach probes
+	sleep 2
+	if ! kill -0 $BPFTRACE_PID 2>/dev/null; then
+		echo "WARN: bpftrace failed to start"
+		cat "$BPFTRACE_LOG"
+		USE_BPFTRACE=0
+		rm -f "$BT_SCRIPT_GEN"
+		return
+	fi
+	echo "bpftrace attached (pid $BPFTRACE_PID)"
+}
+
+bpftrace_stop() {
+	[ "$USE_BPFTRACE" -eq 0 ] && return
+	[ "$BPFTRACE_PID" -eq 0 ] && return
+
+	# Send INT so bpftrace prints its END summary
+	kill -INT $BPFTRACE_PID 2>/dev/null || true
+	wait $BPFTRACE_PID 2>/dev/null || true
+	BPFTRACE_PID=0
+
+	echo ""
+	echo "============================================"
+	echo "bpftrace output"
+	echo "============================================"
+	cat "$BPFTRACE_LOG"
+	echo ""
+
+	# Validate expected code paths were hit
+	local rc=0
+	if grep -q '__ip_dev_find calls=0' "$BPFTRACE_LOG" 2>/dev/null; then
+		echo "FAIL: __ip_dev_find was never called"
+		rc=1
+	elif grep -q 'COMPARISON: __ip_dev_find' "$BPFTRACE_LOG" 2>/dev/null; then
+		echo "PASS: __ip_dev_find lookup path verified"
+	fi
+	if grep -q 'TABLE RESIZE:' "$BPFTRACE_LOG" 2>/dev/null; then
+		echo "PASS: rhltable resize detected (BTF struct reads)"
+	elif grep -q 'RESIZE.*bucket_table_alloc' "$BPFTRACE_LOG" 2>/dev/null; then
+		echo "PASS: rhltable resize detected (kprobe)"
+	else
+		echo "INFO: no resize observed (use --bpftrace-debug to detect via BTF)"
+	fi
+	check_result "bpftrace code path verification" $rc
+
+	rm -f "$BPFTRACE_LOG" "$BT_SCRIPT_GEN"
+}
+
+check_result() {
+	local desc="$1"
+	local rc="$2"
+
+	if [ "$rc" -eq 0 ]; then
+		echo "PASS: $desc"
+		PASS=$((PASS + 1))
+	else
+		echo "FAIL: $desc"
+		FAIL=$((FAIL + 1))
+		RET=1
+	fi
+}
+
+cleanup() {
+	# Stop bpftrace if running
+	if [ "$BPFTRACE_PID" -ne 0 ]; then
+		kill -INT $BPFTRACE_PID 2>/dev/null || true
+		wait $BPFTRACE_PID 2>/dev/null || true
+		BPFTRACE_PID=0
+	fi
+
+	# Kill any other background jobs
+	local jobs
+	jobs="$(jobs -p 2>/dev/null)" || true
+	[ -n "$jobs" ] && kill $jobs 2>/dev/null || true
+	wait 2>/dev/null || true
+
+	cleanup_all_ns
+	[ -n "$BPFTRACE_LOG" ] && rm -f "$BPFTRACE_LOG"
+}
+
+trap cleanup EXIT
+
+# Helper: generate address from index (spreads across octets to avoid /24 limits)
+# Returns 10.B2.B3.1 where B2.B3 encodes the index
+idx_to_addr() {
+	local i=$1
+	local b2=$(( (i >> 8) & 0xff ))
+	local b3=$(( i & 0xff ))
+	echo "10.${b2}.${b3}.1"
+}
+
+# ---------------------------------------------------------------------------
+# Setup
+# ---------------------------------------------------------------------------
+
+setup() {
+	if ! setup_ns NS_SRC NS_DST; then
+		echo "SKIP: Could not create namespaces"
+		exit $ksft_skip
+	fi
+
+	# Create veth pair
+	ip link add veth_src type veth peer name veth_dst
+	ip link set veth_src netns "$NS_SRC"
+	ip link set veth_dst netns "$NS_DST"
+	ip -n "$NS_SRC" link set veth_src up
+	ip -n "$NS_DST" link set veth_dst up
+
+	if [ "$USE_THREADED_NAPI" -eq 1 ]; then
+		# Move veth RX to a separate NAPI kthread for cleaner perf profiles.
+		# Disable TSO on src so packets travel individually through the
+		# veth ptr_ring (256 entries), enable GRO on dst for NAPI polling.
+		ip netns exec "$NS_SRC" ethtool -K veth_src tso off 2>/dev/null || true
+		ip netns exec "$NS_DST" ethtool -K veth_dst gro on 2>/dev/null || true
+		ip netns exec "$NS_DST" \
+			bash -c 'echo 1 > /sys/class/net/veth_dst/threaded' 2>/dev/null || true
+		log_config "threaded-napi: veth_dst (TSO off, GRO on, NAPI kthread on CPU 0)"
+	fi
+
+	# Base addresses for connectivity
+	ip -n "$NS_SRC" addr add 192.168.1.1/24 dev veth_src
+	ip -n "$NS_DST" addr add 192.168.1.2/24 dev veth_dst
+
+	# Accept packets from any source on dst side
+	ip netns exec "$NS_DST" sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec "$NS_DST" sysctl -wq net.ipv4.conf.veth_dst.rp_filter=0
+
+	# Route the 10.0.0.0/8 range toward veth_src from dst side
+	ip -n "$NS_DST" route add 10.0.0.0/8 via 192.168.1.1
+
+	log "Namespaces: NS_SRC=$NS_SRC NS_DST=$NS_DST"
+}
+
+# ---------------------------------------------------------------------------
+# Test 1: Add many addresses (rhltable insert + resize)
+# ---------------------------------------------------------------------------
+
+test_add_many_addrs() {
+	local i addr
+	local rc=0
+
+	echo "Test: Adding $NUM_ADDRS addresses..."
+	local batch
+	batch=$(mktemp /tmp/ip_batch_add.XXXXXX)
+	for ((i = 1; i <= NUM_ADDRS; i++)); do
+		echo "addr add 10.$(( (i >> 8) & 0xff )).$(( i & 0xff )).1/32 dev veth_src"
+	done > "$batch"
+	ip -n "$NS_SRC" -batch "$batch" 2>/dev/null || true
+	rm -f "$batch"
+
+	# Verify address count
+	local count
+	count=$(ip -n "$NS_SRC" -4 addr show dev veth_src | grep -c "inet " || true)
+	log "Addresses on veth_src: $count (expected $((NUM_ADDRS + 1)))"
+
+	[ "$count" -ge "$NUM_ADDRS" ] || rc=1
+	check_result "add $NUM_ADDRS addresses" $rc
+}
+
+# ---------------------------------------------------------------------------
+# Test 2: Verify lookup works (ping from specific source addresses)
+# ---------------------------------------------------------------------------
+
+test_lookup_ping() {
+	local rc=0
+
+	echo "Test: Verify address lookup via ping..."
+	# Ping dst from a few of the added addresses
+	for idx in 1 100 $((NUM_ADDRS / 2)) $NUM_ADDRS; do
+		[ "$idx" -gt "$NUM_ADDRS" ] && continue
+		local addr
+		addr=$(idx_to_addr $idx)
+		if ! ip netns exec "$NS_SRC" ping -c 1 -W 1 -I "$addr" 192.168.1.2 \
+				>/dev/null 2>&1; then
+			log "ping from $addr failed"
+			rc=1
+		else
+			log "ping from $addr OK"
+		fi
+	done
+
+	check_result "address lookup via ping" $rc
+}
+
+# ---------------------------------------------------------------------------
+# Test 3: Unconnected UDP sendmsg stress (exercises __ip_dev_find hot path)
+# ---------------------------------------------------------------------------
+
+test_udp_sendmsg_stress() {
+	local rc=0
+
+	local total_time=$((ROUNDS * DURATION + 1))
+	echo "Test: UDP sendmsg bench ($NUM_ADDRS addrs, ${ROUNDS}x${DURATION}s + 1s warmup = ~${total_time}s)..."
+
+	# Locate C binary (used for both sink and sender)
+	local sender_bin=""
+	local script_dir
+	script_dir=$(dirname "$0")
+
+	if [ -x "${script_dir}/ipv4_addr_lookup_udp_sender" ]; then
+		sender_bin="${script_dir}/ipv4_addr_lookup_udp_sender"
+	elif gcc -O2 -Wall -o /tmp/udp_sender \
+		"${script_dir}/ipv4_addr_lookup_udp_sender.c" 2>/dev/null; then
+		sender_bin="/tmp/udp_sender"
+	else
+		echo "SKIP: ipv4_addr_lookup_udp_sender not found (run make first)"
+		check_result "UDP sender binary available" 1
+		return
+	fi
+
+	local sink_pid=0 sink_log=""
+
+	if [ "$USE_SINK" -eq 1 ]; then
+		# C receiver counts packets (adds CPU overhead to perf profiles)
+		log_config "sink: C receiver on CPU 0 (verifies packet counts)"
+		sink_log=$(mktemp /tmp/udp_sink.XXXXXX)
+		ip netns exec "$NS_DST" \
+			taskset -c 0 "$sender_bin" --sink > "$sink_log" 2>&1 &
+		sink_pid=$!
+		sleep 0.2
+	else
+		# Default: iptables DROP -- zero userspace overhead in perf profiles
+		ip netns exec "$NS_DST" \
+			iptables -A INPUT -p udp --dport 9000 -j DROP
+	fi
+
+	if [ "$USE_THREADED_NAPI" -eq 1 ]; then
+		# Pin veth_dst NAPI kthread to CPU 0 (sender is on CPU 1)
+		local napi_pid
+		napi_pid=$(pgrep -f "napi/veth_dst" 2>/dev/null | head -1)
+		if [ -n "$napi_pid" ]; then
+			taskset -p 0x1 "$napi_pid" >/dev/null 2>&1 || true
+			log "Pinned NAPI thread (pid $napi_pid) to CPU 0"
+		fi
+	fi
+
+	# Snapshot softnet_stat before sending (per-CPU: processed, time_squeeze)
+	local softnet_before
+	softnet_before=$(mktemp /tmp/softnet_before.XXXXXX)
+	cat /proc/net/softnet_stat > "$softnet_before"
+
+	# Send unconnected UDP from many source addresses.
+	# Each sendto() triggers ip_route_output -> __ip_dev_find -> rhltable_lookup.
+	local sender_log
+	sender_log=$(mktemp /tmp/udp_sender.XXXXXX)
+
+	log "Using C UDP sender (pre-created sockets, $ROUNDS rounds)"
+	local sndbuf_arg=""
+	[ "$USE_THREADED_NAPI" -eq 1 ] && sndbuf_arg="--sndbuf 4194304"
+
+	ip netns exec "$NS_SRC" \
+		taskset -c 1 "$sender_bin" "$NUM_ADDRS" "$ROUNDS" "$DURATION" $sndbuf_arg \
+		2>&1 | tee "$sender_log"
+	[ "${PIPESTATUS[0]}" -ne 0 ] && rc=1
+
+	# Show per-CPU softnet activity (detect same-CPU vs multi-CPU NAPI)
+	local cpu=0 active_cpus=""
+	while read -r line; do
+		# shellcheck disable=SC2086
+		set -- $line
+		local cur_p=$((0x${1})) cur_sq=$((0x${3}))
+		local prev_p=0 prev_sq=0
+		if [ -n "$softnet_before" ]; then
+			local prev_line
+			prev_line=$(sed -n "$((cpu + 1))p" "$softnet_before")
+			if [ -n "$prev_line" ]; then
+				# shellcheck disable=SC2086
+				set -- $prev_line
+				prev_p=$((0x${1})); prev_sq=$((0x${3}))
+			fi
+		fi
+		local dp=$((cur_p - prev_p))
+		[ "$dp" -gt 0 ] && active_cpus="${active_cpus} cpu${cpu}(+${dp})"
+		cpu=$((cpu + 1))
+	done < /proc/net/softnet_stat
+	rm -f "$softnet_before"
+	local n_active
+	n_active=$(echo "$active_cpus" | wc -w)
+	local cpu_mode="single-CPU"
+	[ "$n_active" -gt 1 ] && cpu_mode="multi-CPU(${n_active})"
+	echo "  softnet: ${cpu_mode}:${active_cpus}"
+
+	[ "$sender_bin" = "/tmp/udp_sender" ] && rm -f "$sender_bin"
+
+	if [ "$USE_SINK" -eq 1 ] && [ "$sink_pid" -ne 0 ]; then
+		# Let last packets reach socket buffer, then stop the sink
+		sleep 0.1
+		kill -TERM $sink_pid 2>/dev/null || true
+		wait $sink_pid 2>/dev/null || true
+
+		# Verify no packet drops: sent (includes warmup) should equal received
+		local total_sent sink_received
+		total_sent=$(sed -n 's/.*sent=\([0-9]*\).*/\1/p' "$sender_log" | head -1)
+		sink_received=$(sed -n 's/.*received=\([0-9]*\).*/\1/p' "$sink_log" | head -1)
+		rm -f "$sink_log"
+
+		if [ -n "$total_sent" ] && [ -n "$sink_received" ]; then
+			if [ "$total_sent" -eq "$sink_received" ]; then
+				echo "  Sink received: $sink_received (matches sent)"
+			else
+				local diff=$((total_sent - sink_received))
+				echo "  WARN: sent=$total_sent but sink received=$sink_received (diff=$diff)"
+			fi
+		fi
+	else
+		ip netns exec "$NS_DST" \
+			iptables -D INPUT -p udp --dport 9000 -j DROP 2>/dev/null
+	fi
+	rm -f "$sender_log"
+
+	check_result "unconnected UDP sendmsg stress" $rc
+}
+
+# ---------------------------------------------------------------------------
+# Test 4: Duplicate keys (same IP on two different veth devices)
+# ---------------------------------------------------------------------------
+
+test_duplicate_addrs() {
+	local rc=0
+
+	echo "Test: Duplicate address keys (same IP, different devices)..."
+
+	# Create a second veth pair in NS_SRC
+	ip link add veth_src2 type veth peer name veth_dup
+	ip link set veth_src2 netns "$NS_SRC" up
+	ip link set veth_dup netns "$NS_DST" up
+	ip -n "$NS_DST" link set veth_dup up
+
+	# Add the same address that's already on veth_src
+	local dup_addr
+	dup_addr=$(idx_to_addr 1)
+	ip -n "$NS_SRC" addr add "${dup_addr}/32" dev veth_src2 2>/dev/null || true
+
+	# Verify both devices have the address
+	local count
+	count=$(ip -n "$NS_SRC" -4 addr show | grep -c "$dup_addr" || true)
+	log "Address $dup_addr appears on $count devices"
+
+	[ "$count" -ge 2 ] || rc=1
+
+	# Lookup should still work
+	if ! ip netns exec "$NS_SRC" ping -c 1 -W 1 -I "$dup_addr" 192.168.1.2 \
+			>/dev/null 2>&1; then
+		log "ping from duplicate addr failed (expected -- routing may prefer one)"
+	fi
+
+	# Remove duplicate and verify no crash
+	ip -n "$NS_SRC" addr del "${dup_addr}/32" dev veth_src2 2>/dev/null || true
+	ip -n "$NS_SRC" link del veth_src2 2>/dev/null || true
+
+	check_result "duplicate address keys" $rc
+}
+
+# ---------------------------------------------------------------------------
+# Test 5: Remove all addresses (rhltable shrink)
+# ---------------------------------------------------------------------------
+
+test_remove_all_addrs() {
+	local i addr
+	local rc=0
+
+	echo "Test: Removing $NUM_ADDRS addresses..."
+	local batch
+	batch=$(mktemp /tmp/ip_batch_del.XXXXXX)
+	for ((i = 1; i <= NUM_ADDRS; i++)); do
+		echo "addr del 10.$(( (i >> 8) & 0xff )).$(( i & 0xff )).1/32 dev veth_src"
+	done > "$batch"
+	ip -n "$NS_SRC" -batch "$batch" 2>/dev/null || true
+	rm -f "$batch"
+
+	# Verify only the base address remains
+	local count
+	count=$(ip -n "$NS_SRC" -4 addr show dev veth_src | grep -c "inet " || true)
+	log "Addresses remaining: $count (expected 1)"
+
+	[ "$count" -eq 1 ] || rc=1
+	check_result "remove all addresses (rhltable shrink)" $rc
+}
+
+# ---------------------------------------------------------------------------
+# Test 6: Re-add and check address lifetime (exercises check_lifetime)
+# ---------------------------------------------------------------------------
+
+test_addr_lifetime() {
+	local rc=0
+
+	echo "Test: Address lifetime expiry..."
+
+	# Add an address with short valid/preferred lifetime
+	ip -n "$NS_SRC" addr add 10.99.99.1/32 dev veth_src \
+		valid_lft 3 preferred_lft 2
+
+	# Verify it exists
+	local exists
+	exists=$(ip -n "$NS_SRC" -4 addr show dev veth_src | grep -c "10.99.99.1" || true)
+	[ "$exists" -ge 1 ] || { rc=1; check_result "address lifetime" $rc; return; }
+
+	log "Address 10.99.99.1 added with valid_lft=3s"
+
+	# Wait for it to expire (check_lifetime runs periodically)
+	sleep 5
+
+	exists=$(ip -n "$NS_SRC" -4 addr show dev veth_src | grep -c "10.99.99.1" || true)
+	log "After 5s: addr present=$exists (expected 0)"
+
+	[ "$exists" -eq 0 ] || rc=1
+	check_result "address lifetime expiry" $rc
+}
+
+# ---------------------------------------------------------------------------
+# Main
+# ---------------------------------------------------------------------------
+
+echo "============================================"
+echo "inet_addr_lst rhltable stress test"
+echo "  addresses: $NUM_ADDRS"
+echo "  rounds:    $ROUNDS x ${DURATION}s"
+[ "$BENCH_ONLY" -eq 1 ] && echo "  mode:      bench-only"
+echo "============================================"
+
+setup
+bpftrace_start
+
+if [ "$BENCH_ONLY" -eq 1 ]; then
+	test_add_many_addrs
+	test_udp_sendmsg_stress
+else
+	test_add_many_addrs
+	test_lookup_ping
+	test_udp_sendmsg_stress
+	test_duplicate_addrs
+	test_remove_all_addrs
+	test_addr_lifetime
+fi
+
+bpftrace_stop
+
+echo ""
+echo "============================================"
+echo "Results: $PASS passed, $FAIL failed"
+echo "============================================"
+
+exit $RET
diff --git a/tools/testing/selftests/net/ipv4_addr_lookup_test_virtme.sh b/tools/testing/selftests/net/ipv4_addr_lookup_test_virtme.sh
new file mode 100755
index 000000000000..4d308b3e5346
--- /dev/null
+++ b/tools/testing/selftests/net/ipv4_addr_lookup_test_virtme.sh
@@ -0,0 +1,282 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Launch ipv4_addr_lookup stress test inside virtme-ng
+#
+# Must be run from the kernel build tree root.
+#
+# Options:
+#   --verbose       Show kernel console (vng boot messages) in real time.
+#   --taskset CPUS  Pin the VM to specific CPUs via taskset.
+#                   Example: --taskset 12-19  (pin to E-cores on i7-12800H)
+#   --isolated      Run VM in bench.slice cgroup (proper CPU isolation).
+#   --no-turbo      Disable turbo boost for stable CPU frequency.
+#   --freq MHZ      Pin CPU frequency on bench CPUs (e.g. --freq 1200).
+#                   Sets scaling_min_freq=scaling_max_freq for thermal stability.
+#   All other options are forwarded to ipv4_addr_lookup_test.sh (see --help).
+#
+# bench.slice setup (required for --isolated):
+#   The --isolated option uses a dedicated cgroup slice to pin the VM to
+#   specific CPUs while keeping other system processes off those CPUs.
+#   The script also sets cpuset.cpus.partition=isolated at runtime to
+#   remove bench CPUs from the scheduler's load balancing domain
+#   (similar to isolcpus= but reversible). Restored on exit.
+#
+#   One-time setup (as root, adjust CPU range for your system):
+#
+#     # Create the slice (example: reserve CPUs 12-19 for benchmarks)
+#     systemctl set-property --runtime bench.slice AllowedCPUs=12-19
+#
+#     # Confine everything else to the remaining CPUs
+#     systemctl set-property --runtime user.slice AllowedCPUs=0-11
+#     systemctl set-property --runtime system.slice AllowedCPUs=0-11
+#     systemctl set-property --runtime init.scope AllowedCPUs=0-11
+#
+#   To make persistent, drop the --runtime flag (writes to /etc/systemd).
+#
+# Examples (run from kernel tree root):
+#   ./tools/testing/selftests/net/ipv4_addr_lookup_test_virtme.sh
+#     --num-addrs 1000 --duration 10
+#     --verbose --num-addrs 2000
+#     --taskset 12-19 --num-addrs 10000   # pinned to E-cores
+#     --isolated --num-addrs 10000         # proper cgroup isolation
+
+set -eu
+
+# Parse options consumed here (not forwarded to the inner test).
+VERBOSE=""
+TASKSET_CPUS=""
+BENCH_SLICE=0
+NO_TURBO=0
+PIN_FREQ_KHZ=0
+INNER_ARGS=()
+while [ $# -gt 0 ]; do
+    case "$1" in
+        --verbose)  VERBOSE="--verbose"; INNER_ARGS+=("--verbose"); shift ;;
+        --taskset)  TASKSET_CPUS="$2"; shift 2 ;;
+        --isolated) BENCH_SLICE=1; shift ;;
+        --no-turbo) NO_TURBO=1; shift ;;
+        --freq)     PIN_FREQ_KHZ=$(( $2 * 1000 )); shift 2 ;;
+        *)          INNER_ARGS+=("$1"); shift ;;
+    esac
+done
+TEST_ARGS=""
+[ ${#INNER_ARGS[@]} -gt 0 ] && TEST_ARGS=$(printf '%q ' "${INNER_ARGS[@]}")
+
+if [ ! -f "vmlinux" ]; then
+    echo "ERROR: virtme-ng needs vmlinux; run from a compiled kernel tree:" >&2
+    echo "  cd /path/to/kernel && $0" >&2
+    exit 1
+fi
+
+# Verify .config has the options needed for virtme-ng and this test.
+KCONFIG=".config"
+if [ ! -f "$KCONFIG" ]; then
+    echo "ERROR: No .config found -- build the kernel first" >&2
+    exit 1
+fi
+
+MISSING=""
+for opt in CONFIG_VIRTIO CONFIG_VIRTIO_PCI CONFIG_VIRTIO_NET \
+           CONFIG_VIRTIO_CONSOLE CONFIG_NET_9P CONFIG_NET_9P_VIRTIO \
+           CONFIG_9P_FS CONFIG_VETH CONFIG_IP_MULTIPLE_TABLES; do
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
+TESTNAME="ipv4_addr_lookup_test.sh"
+LOGFILE="ipv4_addr_lookup_test.log"
+LOGPATH="$TESTDIR/$LOGFILE"
+CONSOLELOG="ipv4_addr_lookup_console.log"
+rm -f "$LOGPATH" "$CONSOLELOG"
+
+log_config() {
+    echo "  Config: $*"
+}
+
+echo "Starting VM... test output in $LOGPATH, kernel console in $CONSOLELOG"
+
+# earlycon on COM2 for reliable kernel console capture.
+SERIAL_CONSOLE="earlycon=uart8250,io,0x2f8,115200"
+SERIAL_CONSOLE+=" console=uart8250,io,0x2f8,115200"
+CPU_PIN_CMD=""
+if [ "$BENCH_SLICE" -eq 1 ]; then
+    # bench.slice + systemd overrides confine all other processes to CPUs 0-11.
+    # Move ourselves into bench.slice cgroup (user.slice blocks affinity to
+    # CPUs 12-19), then use taskset. vng needs a PTY so systemd-run --scope
+    # is not an option.
+    BENCH_CPUS=$(systemctl show bench.slice -p AllowedCPUs --value 2>/dev/null)
+    if [ -z "$BENCH_CPUS" ]; then
+        echo "ERROR: bench.slice cgroup not configured." >&2
+        echo "" >&2
+        echo "One-time setup (adjust CPU range for your system):" >&2
+        echo "  sudo systemctl set-property --runtime bench.slice AllowedCPUs=12-19" >&2
+        echo "  sudo systemctl set-property --runtime user.slice AllowedCPUs=0-11" >&2
+        echo "  sudo systemctl set-property --runtime system.slice AllowedCPUs=0-11" >&2
+        echo "  sudo systemctl set-property --runtime init.scope AllowedCPUs=0-11" >&2
+        echo "" >&2
+        echo "Or use --taskset CPUS for simple pinning without isolation." >&2
+        exit 1
+    fi
+    # Set partition to isolated: removes bench CPUs from scheduler load
+    # balancing (like isolcpus= but reversible). Restore in EXIT trap.
+    PARTITION_PATH="/sys/fs/cgroup/bench.slice/cpuset.cpus.partition"
+    ORIG_PARTITION=""
+    if [ -f "$PARTITION_PATH" ]; then
+        ORIG_PARTITION=$(cat "$PARTITION_PATH")
+        if [ "$ORIG_PARTITION" != "isolated" ]; then
+            echo isolated | sudo tee "$PARTITION_PATH" >/dev/null 2>&1 || true
+        fi
+    fi
+    log_config "bench.slice CPUs: $BENCH_CPUS (partition=isolated)"
+    echo $$ | sudo tee /sys/fs/cgroup/bench.slice/cgroup.procs >/dev/null
+    CPU_PIN_CMD="taskset -c $BENCH_CPUS"
+elif [ -n "$TASKSET_CPUS" ]; then
+    # Try taskset directly first. If it fails (e.g. user.slice excludes
+    # the requested CPUs), move into bench.slice and retry.
+    if ! taskset -cp "$TASKSET_CPUS" $$ >/dev/null 2>&1; then
+        if [ -d /sys/fs/cgroup/bench.slice ]; then
+            echo $$ | sudo tee /sys/fs/cgroup/bench.slice/cgroup.procs >/dev/null
+            log_config "moved into bench.slice to reach CPUs $TASKSET_CPUS"
+        else
+            echo "ERROR: taskset to CPUs $TASKSET_CPUS failed and no bench.slice available" >&2
+            exit 1
+        fi
+    fi
+    log_config "taskset CPUs: $TASKSET_CPUS"
+    CPU_PIN_CMD="taskset -c $TASKSET_CPUS"
+fi
+
+# Disable turbo boost for stable frequencies during benchmarks
+TURBO_RESTORED=0
+NO_TURBO_PATH="/sys/devices/system/cpu/intel_pstate/no_turbo"
+ORIG_FREQS=()
+cleanup() {
+    # Restore CPU frequencies
+    for entry in "${ORIG_FREQS[@]}"; do
+        local cpu="${entry%%:*}" freq="${entry#*:}"
+        echo "$freq" | sudo tee /sys/devices/system/cpu/cpu"$cpu"/cpufreq/scaling_max_freq >/dev/null 2>&1 || true
+        echo "$freq" | sudo tee /sys/devices/system/cpu/cpu"$cpu"/cpufreq/scaling_min_freq >/dev/null 2>&1 || true
+    done
+    # Restore turbo boost
+    if [ "$NO_TURBO" -eq 1 ] && [ -f "$NO_TURBO_PATH" ]; then
+        echo 0 | sudo tee "$NO_TURBO_PATH" >/dev/null 2>&1 || true
+    fi
+    # Restore cpuset partition
+    if [ -n "${ORIG_PARTITION:-}" ] && [ -f "${PARTITION_PATH:-}" ]; then
+        echo "$ORIG_PARTITION" | sudo tee "$PARTITION_PATH" >/dev/null 2>&1 || true
+    fi
+}
+trap cleanup EXIT
+
+if [ "$NO_TURBO" -eq 1 ]; then
+    if [ -f "$NO_TURBO_PATH" ]; then
+        echo 1 | sudo tee "$NO_TURBO_PATH" >/dev/null
+        log_config "turbo boost disabled (will restore on exit)"
+    else
+        echo "WARN: $NO_TURBO_PATH not found, cannot disable turbo" >&2
+    fi
+fi
+
+# Pin CPU frequency for thermal stability
+if [ "$PIN_FREQ_KHZ" -gt 0 ]; then
+    # Determine which CPUs to pin: bench.slice CPUs, --taskset CPUs, or all
+    if [ -n "${BENCH_CPUS:-}" ]; then
+        FREQ_CPUS="$BENCH_CPUS"
+    elif [ -n "$TASKSET_CPUS" ]; then
+        FREQ_CPUS="$TASKSET_CPUS"
+    else
+        echo "WARN: --freq without --isolated or --taskset, skipping" >&2
+        PIN_FREQ_KHZ=0
+    fi
+    if [ "$PIN_FREQ_KHZ" -gt 0 ]; then
+        # Expand CPU list (e.g. "12-15,18" -> "12 13 14 15 18")
+        FREQ_CPU_LIST=""
+        IFS=',' read -ra parts <<< "$FREQ_CPUS"
+        for part in "${parts[@]}"; do
+            if [[ "$part" == *-* ]]; then
+                IFS='-' read -r a b <<< "$part"
+                FREQ_CPU_LIST+=" $(seq "$a" "$b")"
+            else
+                FREQ_CPU_LIST+=" $part"
+            fi
+        done
+        PIN_FREQ_MHZ=$((PIN_FREQ_KHZ / 1000))
+        for cpu in $FREQ_CPU_LIST; do
+            freq_dir="/sys/devices/system/cpu/cpu${cpu}/cpufreq"
+            [ -d "$freq_dir" ] || continue
+            orig=$(cat "$freq_dir/scaling_max_freq" 2>/dev/null) || continue
+            ORIG_FREQS+=("${cpu}:${orig}")
+            echo "$PIN_FREQ_KHZ" | sudo tee "$freq_dir/scaling_max_freq" >/dev/null 2>&1 || true
+            echo "$PIN_FREQ_KHZ" | sudo tee "$freq_dir/scaling_min_freq" >/dev/null 2>&1 || true
+        done
+        log_config "CPU frequency pinned to ${PIN_FREQ_MHZ} MHz on CPUs: $FREQ_CPUS (will restore on exit)"
+    fi
+fi
+
+echo "(VM is booting, please wait ~30s)"
+set +e
+$CPU_PIN_CMD vng $VERBOSE --cpus 4 --memory 2G \
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
+       grep -qiE 'kernel BUG|BUG:|Oops:|panic|WARN' "$CONSOLELOG"; then
+        echo ""
+        echo "--- kernel backtrace ($CONSOLELOG) ---"
+        grep -iE -A30 'kernel BUG|BUG:|Oops:|panic|WARN' \
+            "$CONSOLELOG" | head -50
+    else
+        echo ""
+        echo "Re-run with --verbose to see the kernel backtrace:"
+        echo "  $0 --verbose ${INNER_ARGS[*]:-}"
+    fi
+    exit 1
+elif [ ! -f "$LOGPATH" ]; then
+    echo "No log file found -- VM may have crashed before writing output"
+    exit 2
+else
+    echo "=== VM finished ==="
+fi
+
+# Show test results from the log
+echo ""
+if grep -q "^Results:" "$LOGPATH"; then
+    grep "^Results:" "$LOGPATH"
+fi
+grep -E "^(PASS|FAIL):" "$LOGPATH" || true
+
+# Scan console log for unexpected kernel warnings (even on clean exit)
+if [ -s "$CONSOLELOG" ]; then
+    WARN_PATTERN='kernel BUG|BUG:|Oops:|WARNING:|WARN_ON|rhashtable'
+    WARN_LINES=$(grep -cE "$WARN_PATTERN" "$CONSOLELOG" 2>/dev/null) || WARN_LINES=0
+    if [ "$WARN_LINES" -gt 0 ]; then
+        echo ""
+        echo "*** kernel warnings in $CONSOLELOG ($WARN_LINES lines) ***"
+        grep -E "$WARN_PATTERN" "$CONSOLELOG" | head -20
+    fi
+fi
+
+# Extract exit code from log
+if grep -q "^EXIT_CODE=" "$LOGPATH"; then
+    INNER_RC=$(grep "^EXIT_CODE=" "$LOGPATH" | tail -1 | cut -d= -f2)
+    exit "$INNER_RC"
+fi
diff --git a/tools/testing/selftests/net/ipv4_addr_lookup_trace.bt b/tools/testing/selftests/net/ipv4_addr_lookup_trace.bt
new file mode 100644
index 000000000000..c63105faac03
--- /dev/null
+++ b/tools/testing/selftests/net/ipv4_addr_lookup_trace.bt
@@ -0,0 +1,178 @@
+#!/usr/bin/env bpftrace
+/*
+ * ipv4_addr_lookup_trace.bt - Trace inet_addr_lst rhltable code paths
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Run alongside ipv4_addr_lookup_test.sh to verify that the correct
+ * kernel functions are exercised and to capture per-call overhead.
+ *
+ * Traces:
+ *  - inet_lookup_ifaddr_rcu  : hot lookup (latency histogram)
+ *  - __ip_dev_find           : full lookup incl. FIB fallback
+ *  - inet_hash_remove        : hash remove path
+ *  - rhashtable_insert_slow  : slow-path insert (fast path is inline)
+ *  - rht_deferred_worker     : resize worker (expand / shrink)
+ *  - bucket_table_alloc      : new table allocation (reveals new size)
+ *  - rhashtable_rehash_table : actual data migration between tables
+ *
+ * Usage:
+ *   bpftrace ipv4_addr_lookup_trace.bt          # in one terminal
+ *   ./ipv4_addr_lookup_test.sh --num-addrs 500  # in another
+ *   # Ctrl-C the bpftrace when test finishes
+ */
+
+BEGIN
+{
+	printf("Tracing inet_addr_lst rhltable paths... Ctrl-C to stop.\n\n");
+	@phase = "idle";
+}
+
+/* ------------------------------------------------------------------ */
+/* Hot lookup path: inet_lookup_ifaddr_rcu (called from __ip_dev_find) */
+/* ------------------------------------------------------------------ */
+
+kprobe:inet_lookup_ifaddr_rcu
+{
+	@lookup_entry[tid] = nsecs;
+}
+
+kretprobe:inet_lookup_ifaddr_rcu
+/@lookup_entry[tid]/
+{
+	$dt = nsecs - @lookup_entry[tid];
+	@lookup_ns = hist($dt);
+	@lookup_count++;
+	delete(@lookup_entry[tid]);
+}
+
+/* __ip_dev_find: full overhead including FIB fallback path */
+
+kprobe:__ip_dev_find
+{
+	@ipdev_entry[tid] = nsecs;
+}
+
+kretprobe:__ip_dev_find
+/@ipdev_entry[tid]/
+{
+	$dt = nsecs - @ipdev_entry[tid];
+	@ipdev_ns = hist($dt);
+	@ipdev_count++;
+	delete(@ipdev_entry[tid]);
+}
+
+/* ------------------------------------------------------------------ */
+/* Insert / Remove                                                     */
+/* ------------------------------------------------------------------ */
+
+/* rhashtable_insert_slow is the non-inline slow path called on insert */
+kprobe:rhashtable_insert_slow
+{
+	@insert_slow++;
+}
+
+/* inet_hash_remove is static but not inlined in this build */
+kprobe:inet_hash_remove
+{
+	@remove_count++;
+}
+
+/* ------------------------------------------------------------------ */
+/* Resize events                                                       */
+/* ------------------------------------------------------------------ */
+
+/* rht_deferred_worker: the workqueue callback that drives resize */
+kprobe:rht_deferred_worker
+{
+	@resize_wq_entry[tid] = nsecs;
+	@resize_events++;
+	printf(">>> RESIZE #%lld: deferred_worker started\n",
+	       @resize_events);
+}
+
+kretprobe:rht_deferred_worker
+/@resize_wq_entry[tid]/
+{
+	$dt = nsecs - @resize_wq_entry[tid];
+	@resize_wq_ns = hist($dt);
+	printf("    RESIZE: deferred_worker done in %lld us\n", $dt / 1000);
+	delete(@resize_wq_entry[tid]);
+}
+
+/* bucket_table_alloc: reveals the NEW table size being allocated.
+ * Signature: bucket_table_alloc(struct rhashtable *ht, size_t nbuckets, gfp_t)
+ * arg1 = nbuckets = new table size.
+ */
+kprobe:bucket_table_alloc*
+{
+	@new_tbl_size = arg1;
+	@bucket_allocs++;
+	printf("    RESIZE: bucket_table_alloc nbuckets=%lld\n", arg1);
+	print(kstack(6));
+}
+
+/* rhashtable_rehash_table: actual entry migration between old/new table */
+kprobe:rhashtable_rehash_table
+{
+	@rehash_entry[tid] = nsecs;
+}
+
+kretprobe:rhashtable_rehash_table
+/@rehash_entry[tid]/
+{
+	$dt = nsecs - @rehash_entry[tid];
+	@rehash_ns = hist($dt);
+	@rehash_count++;
+	printf("    RESIZE: rehash_table done in %lld us\n", $dt / 1000);
+	delete(@rehash_entry[tid]);
+}
+
+/* ------------------------------------------------------------------ */
+/* Summary on Ctrl-C                                                   */
+/* ------------------------------------------------------------------ */
+
+END
+{
+	printf("\n");
+	printf("========================================================\n");
+	printf("  inet_addr_lst rhltable trace summary\n");
+	printf("========================================================\n");
+
+	printf("\n--- Call counts ---\n");
+	printf("  inet_lookup_ifaddr_rcu : %8lld  (hot lookup)\n",
+	       @lookup_count);
+	printf("  __ip_dev_find          : %8lld  (full lookup)\n",
+	       @ipdev_count);
+	printf("  rhashtable_insert_slow : %8lld  (insert slow path)\n",
+	       @insert_slow);
+	printf("  inet_hash_remove       : %8lld  (remove)\n",
+	       @remove_count);
+
+	printf("\n--- Resize activity ---\n");
+	printf("  rht_deferred_worker    : %8lld  (resize worker runs)\n",
+	       @resize_events);
+	printf("  bucket_table_alloc     : %8lld  (table allocations)\n",
+	       @bucket_allocs);
+	printf("  rhashtable_rehash      : %8lld  (rehash completions)\n",
+	       @rehash_count);
+
+	printf("\n--- inet_lookup_ifaddr_rcu latency (ns) ---\n");
+	print(@lookup_ns);
+
+	printf("\n--- __ip_dev_find latency (ns) ---\n");
+	print(@ipdev_ns);
+
+	printf("\n--- rht_deferred_worker duration (ns) ---\n");
+	print(@resize_wq_ns);
+
+	printf("\n--- rhashtable_rehash_table duration (ns) ---\n");
+	print(@rehash_ns);
+
+	/* clean up maps */
+	clear(@lookup_entry);
+	clear(@ipdev_entry);
+	clear(@resize_wq_entry);
+	clear(@rehash_entry);
+	clear(@new_tbl_size);
+	clear(@phase);
+}
diff --git a/tools/testing/selftests/net/ipv4_addr_lookup_udp_sender.c b/tools/testing/selftests/net/ipv4_addr_lookup_udp_sender.c
new file mode 100644
index 000000000000..ad1913ebba15
--- /dev/null
+++ b/tools/testing/selftests/net/ipv4_addr_lookup_udp_sender.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fast UDP sender/sink for ipv4_addr_lookup benchmarking.
+ *
+ * Sender mode: sends unconnected UDP packets from many source addresses
+ * to stress __ip_dev_find -> inet_lookup_ifaddr_rcu (rhltable_lookup).
+ * Each sendto() triggers: ip_route_output_key -> __ip_dev_find -> hash lookup.
+ *
+ * Sink mode (--sink): minimal C UDP receiver that counts packets received.
+ * Not used by default -- the test script uses an iptables DROP rule instead
+ * to avoid polluting perf profiles with recv() overhead.  Enable with
+ * --sink on the test script command line for packet drop verification.
+ *
+ * Sender design for low-noise measurement:
+ *  - Pre-create all sockets during setup (not timed)
+ *  - Tight sendto() loop during measurement (no socket lifecycle overhead)
+ *  - Clock check only every 1024 packets (avoid paravirt clock overhead)
+ *  - 1 second warm-up to stabilize caches and hash table
+ *  - Multiple rounds with per-round statistics (median, min, max, stdev)
+ *
+ * Usage:
+ *   ipv4_addr_lookup_udp_sender <num_addrs> <rounds> <duration_sec>
+ *   ipv4_addr_lookup_udp_sender --sink [port]
+ *
+ * Example: ipv4_addr_lookup_udp_sender 1000 10 3
+ *   -> 10 rounds of 3s each (+ 1s warm-up) = ~31s total
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/socket.h>
+#include <time.h>
+#include <unistd.h>
+
+#define DST_ADDR	"192.168.1.2"
+#define DST_PORT	9000
+#define SINK_PORT	DST_PORT
+#define SINK_BUF	4096
+#define WARMUP_SEC	1
+#define CLOCK_INTERVAL	1024	/* check clock every N packets */
+#define MAX_ROUNDS	100
+#define PAYLOAD_LEN	64
+
+static double ts_diff(struct timespec *a, struct timespec *b)
+{
+	return (b->tv_sec - a->tv_sec) +
+	       (b->tv_nsec - a->tv_nsec) * 1e-9;
+}
+
+static int cmp_double(const void *a, const void *b)
+{
+	double da = *(const double *)a;
+	double db = *(const double *)b;
+
+	return (da > db) - (da < db);
+}
+
+static void run_round(int *fds, int num_addrs, int duration,
+		      struct sockaddr_in *dst, char *payload, int payload_len,
+		      long long *out_sent, long long *out_errors,
+		      double *out_rate)
+{
+	struct timespec ts_start, ts_now;
+	long long sent = 0, errors = 0;
+	double elapsed;
+	int i = 0;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	for (;;) {
+		if (fds[i] >= 0) {
+			if (sendto(fds[i], payload, payload_len, 0,
+				   (struct sockaddr *)dst,
+				   sizeof(*dst)) < 0)
+				errors++;
+			else
+				sent++;
+		}
+		i = (i + 1) % num_addrs;
+		if ((sent & (CLOCK_INTERVAL - 1)) == 0) {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+			if (ts_diff(&ts_start, &ts_now) >= duration)
+				break;
+		}
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_now);
+	elapsed = ts_diff(&ts_start, &ts_now);
+
+	*out_sent = sent;
+	*out_errors = errors;
+	*out_rate = elapsed > 0 ? sent / elapsed : 0;
+}
+
+static volatile int sink_running = 1;
+
+static void sink_stop(int sig)
+{
+	sink_running = 0;
+}
+
+/* Not used by default -- the test script uses iptables DROP instead to keep
+ * perf profiles clean.  Enable with: test_script --sink
+ */
+static int run_sink(int port)
+{
+	struct timeval tv = { .tv_sec = 0, .tv_usec = 100000 }; /* 100ms */
+	int rcvbuf = 4 * 1024 * 1024; /* 4 MB - prevent drops during bursts */
+	struct sigaction sa = { };
+	struct sockaddr_in addr;
+	long long received = 0;
+	char buf[SINK_BUF];
+	int fd;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	/* SO_RCVBUFFORCE bypasses net.core.rmem_max (requires root) */
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf, sizeof(rcvbuf)))
+		setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_port = htons(port);
+	addr.sin_addr.s_addr = htonl(INADDR_ANY);
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("bind");
+		close(fd);
+		return 1;
+	}
+
+	/* Use sigaction without SA_RESTART so recv() returns -EINTR
+	 * immediately on signal, rather than being silently restarted.
+	 */
+	sa.sa_handler = sink_stop;
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	fprintf(stderr, "sink: listening on port %d\n", port);
+
+	while (sink_running) {
+		if (recv(fd, buf, sizeof(buf), 0) > 0)
+			received++;
+	}
+
+	/* Drain in-flight packets (e.g. still traversing veth pipe).
+	 * SO_RCVTIMEO (100ms) ensures we exit once the queue is idle.
+	 */
+	while (recv(fd, buf, sizeof(buf), 0) > 0)
+		received++;
+
+	close(fd);
+
+	fprintf(stderr, "sink: received %lld packets\n", received);
+	/* Parseable output for test script */
+	printf("received=%lld\n", received);
+	fflush(stdout);
+	return 0;
+}
+
+/* Create and bind one UDP socket per source address: 10.B2.B3.1
+ * Returns the number of successfully bound sockets.
+ */
+static int setup_sockets(int *fds, int num_addrs, int sndbuf)
+{
+	struct sockaddr_in src;
+	int i, n_ok = 0;
+
+	for (i = 0; i < num_addrs; i++) {
+		int idx = i + 1;
+
+		fds[i] = -1;
+		memset(&src, 0, sizeof(src));
+		src.sin_family = AF_INET;
+		/* 10.<high byte>.<low byte>.1 */
+		src.sin_addr.s_addr = htonl(0x0a000001 |
+					    ((idx & 0xff) << 8) |
+					    (((idx >> 8) & 0xff) << 16));
+
+		fds[i] = socket(AF_INET, SOCK_DGRAM, 0);
+		if (fds[i] < 0)
+			continue;
+		if (sndbuf > 0) {
+			if (setsockopt(fds[i], SOL_SOCKET, SO_SNDBUFFORCE,
+				       &sndbuf, sizeof(sndbuf)))
+				setsockopt(fds[i], SOL_SOCKET, SO_SNDBUF,
+					   &sndbuf, sizeof(sndbuf));
+		}
+		if (bind(fds[i], (struct sockaddr *)&src, sizeof(src)) < 0) {
+			close(fds[i]);
+			fds[i] = -1;
+			continue;
+		}
+		n_ok++;
+	}
+	return n_ok;
+}
+
+/* Warm-up: send for WARMUP_SEC to stabilize caches, hash table, softirq */
+static long long run_warmup(int *fds, int num_addrs, struct sockaddr_in *dst,
+			    char *payload)
+{
+	struct timespec ts_start, ts_now;
+	long long sent = 0;
+	int i = 0;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	for (;;) {
+		if (fds[i] >= 0) {
+			if (sendto(fds[i], payload, PAYLOAD_LEN, 0,
+				   (struct sockaddr *)dst, sizeof(*dst)) >= 0)
+				sent++;
+		}
+		i = (i + 1) % num_addrs;
+		if ((sent & (CLOCK_INTERVAL - 1)) == 0) {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+			if (ts_diff(&ts_start, &ts_now) >= WARMUP_SEC)
+				break;
+		}
+	}
+	return sent;
+}
+
+/* Compute and print summary statistics (parseable by test script).
+ * sent= includes warmup so it matches the sink's received count.
+ */
+static void print_summary(double *rates, int rounds,
+			  long long total_sent, long long warmup_sent,
+			  long long total_errors)
+{
+	double median, mean, stdev, sum, sumsq;
+	int i;
+
+	qsort(rates, rounds, sizeof(double), cmp_double);
+
+	if (rounds % 2 == 0)
+		median = (rates[rounds / 2 - 1] + rates[rounds / 2]) / 2.0;
+	else
+		median = rates[rounds / 2];
+
+	sum = 0;
+	sumsq = 0;
+	for (i = 0; i < rounds; i++) {
+		sum += rates[i];
+		sumsq += rates[i] * rates[i];
+	}
+	mean = sum / rounds;
+
+	if (rounds > 1) {
+		double variance = (sumsq - sum * sum / rounds) /
+				  (rounds - 1);
+
+		/* Sqrt via Newton's method (avoids -lm) */
+		stdev = variance;
+		if (stdev > 0) {
+			double s = stdev / 2;
+
+			for (i = 0; i < 20; i++)
+				s = (s + variance / s) / 2;
+			stdev = s;
+		}
+	} else {
+		stdev = 0;
+	}
+
+	printf("sent=%lld warmup=%lld errors=%lld rounds=%d "
+	       "rate=%.0f pkt/s median=%.0f min=%.0f max=%.0f stdev=%.0f\n",
+	       total_sent + warmup_sent, warmup_sent, total_errors, rounds,
+	       mean, median, rates[0], rates[rounds - 1], stdev);
+}
+
+/* Prevent CPU C-state transitions for stable benchmark results.
+ * Holds /dev/cpu_dma_latency open with value 0 (lowest latency).
+ * Returns fd (caller must close), or -1 on failure (non-fatal).
+ */
+static int set_cpu_dma_latency(void)
+{
+	int32_t lat = 0;
+	int fd;
+
+	fd = open("/dev/cpu_dma_latency", O_WRONLY);
+	if (fd < 0)
+		return -1;
+	if (write(fd, &lat, sizeof(lat)) != sizeof(lat)) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
+static int run_sender(int num_addrs, int rounds, int duration, int sndbuf)
+{
+	long long total_sent = 0, total_errors = 0, warmup_sent;
+	long long round_sent, round_errors;
+	int *fds, n_ok, i, dma_fd;
+	double rates[MAX_ROUNDS];
+	char payload[PAYLOAD_LEN];
+	struct sockaddr_in dst;
+	double round_rate;
+	struct rlimit rl;
+
+	if (rounds < 1)
+		rounds = 1;
+	if (rounds > MAX_ROUNDS)
+		rounds = MAX_ROUNDS;
+
+	/* Raise fd limit for high address counts */
+	if (num_addrs + 64 > 1024) {
+		rl.rlim_cur = num_addrs + 256;
+		rl.rlim_max = num_addrs + 256;
+		setrlimit(RLIMIT_NOFILE, &rl);
+	}
+
+	memset(payload, 'X', sizeof(payload));
+	memset(&dst, 0, sizeof(dst));
+	dst.sin_family = AF_INET;
+	dst.sin_port = htons(DST_PORT);
+	inet_pton(AF_INET, DST_ADDR, &dst.sin_addr);
+
+	/* Phase 1: Pre-create and bind all sockets (not timed) */
+	fds = calloc(num_addrs, sizeof(int));
+	if (!fds) {
+		perror("calloc");
+		return 1;
+	}
+
+	n_ok = setup_sockets(fds, num_addrs, sndbuf);
+	fprintf(stderr, "setup: %d/%d sockets bound\n", n_ok, num_addrs);
+
+	dma_fd = set_cpu_dma_latency();
+	if (dma_fd >= 0)
+		fprintf(stderr, "setup: cpu_dma_latency=0 (C-states disabled)\n");
+	if (n_ok == 0) {
+		fprintf(stderr, "no sockets created\n");
+		free(fds);
+		return 1;
+	}
+
+	/* Phase 2: Warm-up */
+	warmup_sent = run_warmup(fds, num_addrs, &dst, payload);
+
+	/* Phase 3: Measurement rounds */
+	for (i = 0; i < rounds; i++) {
+		run_round(fds, num_addrs, duration, &dst, payload,
+			  PAYLOAD_LEN, &round_sent, &round_errors, &round_rate);
+		rates[i] = round_rate;
+		total_sent += round_sent;
+		total_errors += round_errors;
+		fprintf(stderr, "  round %2d: %8.0f pkt/s\n",
+			i + 1, round_rate);
+	}
+
+	print_summary(rates, rounds, total_sent, warmup_sent, total_errors);
+
+	/* Cleanup */
+	if (dma_fd >= 0)
+		close(dma_fd);
+	for (i = 0; i < num_addrs; i++) {
+		if (fds[i] >= 0)
+			close(fds[i]);
+	}
+	free(fds);
+
+	return (total_errors > num_addrs / 10) ? 1 : 0;
+}
+
+int main(int argc, char **argv)
+{
+	int sndbuf = 0;
+	int port;
+
+	if (argc >= 2 && strcmp(argv[1], "--sink") == 0) {
+		port = (argc >= 3) ? atoi(argv[2]) : SINK_PORT;
+
+		return run_sink(port);
+	}
+
+	if (argc < 4) {
+		fprintf(stderr,
+			"Usage: %s <num_addrs> <rounds> <duration_sec> [--sndbuf bytes]\n"
+			"       %s --sink [port]\n",
+			argv[0], argv[0]);
+		return 1;
+	}
+
+	if (argc >= 6 && strcmp(argv[4], "--sndbuf") == 0)
+		sndbuf = atoi(argv[5]);
+
+	return run_sender(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), sndbuf);
+}
-- 
2.43.0


