Return-Path: <netdev+bounces-291922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDnpNfQDFmrNgwcAu9opvQ
	(envelope-from <netdev+bounces-291922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:35:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E15DC5B1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD0F3046FF6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A93BBA1E;
	Tue, 26 May 2026 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uU/3FY2w"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E13B4E9D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827654; cv=none; b=PzMypRbZh7wVNVLQe0+rCfnPuFOfnrAGfpKFgNXr/I43TOkzUMNf9hOIlepYYK22/zblo+xOE+RXd2c2frcxWMI1uJL6f31rOEqsWwmB1JzdhKK+e4N0f0RwydMtazJ+O6VYakvhug3MuEuli0iyHB3Hbhwcj11qiiuS7hrMzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827654; c=relaxed/simple;
	bh=HTMs/4Hwy5tqN6vHE24H6PwLKynXiTMmb+3NpPeftsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwD9sBvuoo0sVdb3iFcyN70uHei7vO+Ql6XxIQa24EzeOBEGbC/DVlIoOQo84JAjZMC9YmtoGz25//ijyYq4pVnnGEwfj7omOFvccvQV86Gjja4Oj0zn+BqI1UJZJ3sZYl+CzrZPXN5tXETsHI7zBoFbhJS1RD5F1svLCmCe5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uU/3FY2w; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QHxarO2438093
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:34:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=MIJwXsv
	/0laqfqTBAiiemVlRxYkDdprYcEoPdM55d14=; b=uU/3FY2wcLQkiDt5bxS47hf
	LkOI9vVwi2B7PIIyBiNFU3z0setgrbqd27bNRC6ZwBcD7Pfb9Okc/eWWUnXlSJka
	2r8+5zdh8BLKL6F7hJMItXSM2L+woo6bSI9YBYKTMY/ay9VuJkzQuO1CDF6RI8Cy
	ihC73N6j1m9lCZsCLUnMYU1mw6/ML3N/kQOENhtz2F0zXFjnFI0U40AIFGD/cTcb
	nu3zcJtY4rHUmR4DJsoHZrtXGrOtKQbMJV9qmsM/e7xmQbxrHsBinInu0lSoY714
	3wqeIdF2XbD9xw58qlzBNs0isxAPCs4064R5ScEqswWfZaxpMveKCoiBhPW/aPA=
	=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ebwthwa0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:34:10 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-43b7190b56dso3758599fac.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827650; x=1780432450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIJwXsv/0laqfqTBAiiemVlRxYkDdprYcEoPdM55d14=;
        b=sVkmrvVF/THXgbBFaIEIcw4cSDKzYIP17lG2jCn2XthjKd67mhxFfAV/u+31wjjE8B
         bOdz9pC+4HfopM3su0MUD4opPPGBjpuCQNSat/PRV/HTgqn8nrrWyw3/tz/pONpTma7n
         XpJuNhtcjOq/sXYurAAW/Wu5912LEF+atD4xCF3qhWHDX2LE7uixR2ypq8abgfTraZ5+
         AU78xhvblwfSRPprL5S94AySW3fbNtP1dfzYaXNx0T2NbVAsCDQnkoQGYqsf3/tdyIXe
         LA4CNAqew9BNi1fL2hmVuhBPv/CHf+A3iDtS3pCgu0VwLObgOWPMlaf80xHqVdAy/01e
         42pA==
X-Gm-Message-State: AOJu0YyvEeDCYOVvY4nGSgNBG7jsy4XYOQ8+fjASVkin8K6wCeCswh71
	YAgIC8C6PoBLV9EmpeTp89KX+Iw7lFII8P2rceHsvgrWeKqps7+yIwk1+kdHW/Xnld+39pQGC7j
	1Nwb5PVNKhY3UtJ0OrIMCSg4GAPdmrPbE/IxgmQZwQQ78UPcQY3MthJDND9FXQ/gjizd1N0SdcF
	GuT4bjUW6CUO4iYH/mtKiXUMD4eIJlezVFeDYT
X-Gm-Gg: Acq92OFrtglv5R+h+YvMRzMFbuKi6IJYPyRce/YFQvtS3Sd8NotHmkMP8aviVIP69WD
	+efJssT2nR8LnsntBodrLKdp4WN6v1oIIesOfjfcN7kT8678WOStBw1KFABfFb7tL4mFnMKtB/g
	yqmhtz6Lpo2dwcciggTXFYOYanBUFAiS7qaPi2gYYg5gQltspOBp2im8K72jY6OJMSrZC543Sgu
	p9fS2mG9cakdUGNn7av1KjEisHi9HkQK2QO1CePHx50w7iHazv2qxRyg7C015FQiPpZrIgePG/f
	ASiOxPmKxjrWwHjwq7Id490rBBe5wR8xgbPhXk8toIxgB3QhRKeS5sSRJUgOuzFkY+OJyOoMx7Y
	DL1GWUrWZLA==
X-Received: by 2002:a05:6870:2403:b0:41c:43bb:7f1f with SMTP id 586e51a60fabf-43b5a5e4071mr11806939fac.0.1779827649296;
        Tue, 26 May 2026 13:34:09 -0700 (PDT)
X-Received: by 2002:a05:6870:2403:b0:41c:43bb:7f1f with SMTP id 586e51a60fabf-43b5a5e4071mr11806870fac.0.1779827648245;
        Tue, 26 May 2026 13:34:08 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63a15569sm14264534fac.16.2026.05.26.13.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:34:07 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v9 2/2] selftests: net: add local ECMP rehash test
Date: Tue, 26 May 2026 13:34:03 -0700
Message-ID: <20260526203403.3517607-3-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526203403.3517607-1-ntspring@meta.com>
References: <20260526203403.3517607-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HC3HzAXp2aLikRLZNDl9k7hZH2RFaG00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4MiBTYWx0ZWRfX171fVIvtN49g
 9STYTrH78gEkbsw5D9gwUOmGuOcdoxJ7hmF6RVufFoDAauIIKc20klmwEXs87geXeMHG1R5CT2f
 NakVYWp3aVkSw2vWF3vI9n9JZWtTsky5P6uC2ElIvM2pZYHSIws7r3I8yt551UrP7yks2ZX5XyD
 iidJt8Y31NUu0L2G72+pZMjvuqJ1T/hznsf4ciHDqhP0r/LI7GvtV8tPFWnNzSd7M62Ia0MYmvi
 BxoCRYbwpW58/bO3sCfBVYio7vxSgkz1pkF/TfPe/C3R8qboi3MlPZX9o7NJonpmtGA8LMeSJpx
 2YZozncT6IFizCgbLqltIbA0oadpSe9kt7GVlBzGJGmHFgSC8uujS5QIInVi//LKaR/s1+/L8ly
 133dJEkQEZqGsarp7ZgOuOibsnZ6Nm3JJaicEigOZ8IiDNW5j1LGEFB2XopBnXgh+9E+ZFNw6R9
 EjfkJCzwb/m0QDwRZnA==
X-Proofpoint-ORIG-GUID: HC3HzAXp2aLikRLZNDl9k7hZH2RFaG00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a1603c2 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=TTkU_mty8rFlMtFDi8AA:9
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ecmp_rehash.sh:url,meta.com:email,meta.com:mid,meta.com:dkim];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 084E15DC5B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ecmp_rehash.sh with ten scenarios verifying that TCP rehash
selects a different local ECMP path for IPv6:

  - SYN retransmission (forward path blocked during setup)
  - SYN/ACK retransmission (reverse path blocked during setup)
  - Midstream RTO (forward path blocked on established connection)
  - Midstream ACK rehash (reverse path blocked on established connection)
  - PLB rehash (ECN-driven congestion on established connection)
  - Hash policy 1 negative test (rehash attempted but path unchanged)
  - No flowlabel leak (client mp_hash does not alter on-wire flowlabel)
  - Dst rebuild consistency (dst invalidation does not change path)
  - Dst rebuild consistency with syncookies (server socket created
    via cookie_v6_check instead of the normal three-way handshake)
  - Syncookie server path consistency (SYN-ACK and post-cookie ACKs
    use the same ECMP path)

The policy 1 test verifies that fib_multipath_hash_policy=1 computes
a deterministic 5-tuple hash, so txhash re-rolls do not change the
ECMP path while TcpTimeoutRehash still increments.

The flowlabel leak test sets auto_flowlabels=0 on the client and
installs tc filters on client egress that drop TCP packets with
nonzero flowlabel, confirming that the client's fl6->mp_hash does
not leak into the on-wire IPv6 flow label.

The dst rebuild tests stream data, invalidate the cached dst by
adding and removing a dummy route (bumping the fib6_node sernum),
and verify that traffic stays on the same path.  The sernum change
causes ip6_dst_check() to fail on the next transmit, triggering a
fresh route lookup via inet6_csk_route_socket().
ECMP_REBUILD_ROUNDS=10 repeats the check to reduce the probability
of a buggy kernel passing by chance with 2-way ECMP.

The syncookie server path consistency test verifies that the
server's SYN-ACK and subsequent ACKs use the same ECMP path.
With syncookies, the request socket is freed after the SYN-ACK,
so cookie_tcp_reqsk_init() must derive the same txhash (from the
cookie) that was used for the SYN-ACK's route lookup.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1050 ++++++++++++++++++++
 3 files changed, 1052 insertions(+)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index baa30287cf22..6ec1b24218ad 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS := \
 	cmsg_time.sh \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
+	ecmp_rehash.sh \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
 	fcnal-other.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 94d722770420..20fce6e4500b 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -122,6 +122,7 @@ CONFIG_PSAMPLE=m
 CONFIG_RPS=y
 CONFIG_SYSFS=y
 CONFIG_TAP=m
+CONFIG_TCP_CONG_DCTCP=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_TEST_BPF=m
diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/selftests/net/ecmp_rehash.sh
new file mode 100755
index 000000000000..c2c1c14078e9
--- /dev/null
+++ b/tools/testing/selftests/net/ecmp_rehash.sh
@@ -0,0 +1,1050 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test local ECMP path re-selection on TCP retransmission timeout and PLB.
+#
+# Two namespaces connected by two parallel veth pairs with a 2-way ECMP
+# route.  When a TCP path is blocked (via tc drop) or congested (via
+# netem ECN marking), the kernel rehashes the connection via
+# sk_rethink_txhash() + __sk_dst_reset(), causing the next route lookup
+# to select the other ECMP path.
+#
+# Expected runtime: ~15 seconds.  The large timeouts in individual tests
+# (slowwait 30-60s, socat connect-timeout=60-120s) are worst-case bounds
+# that are never reached on a correctly functioning kernel.
+
+source lib.sh
+
+SUBNETS=(a b)
+PORT=9900
+: "${ECMP_REBUILD_ROUNDS:=10}"
+
+ALL_TESTS="
+	test_ecmp_syn_rehash
+	test_ecmp_synack_rehash
+	test_ecmp_midstream_rehash
+	test_ecmp_midstream_ack_rehash
+	test_ecmp_plb_rehash
+	test_ecmp_hash_policy1_no_rehash
+	test_ecmp_no_flowlabel_leak
+	test_ecmp_dst_rebuild_consistency
+	test_ecmp_dst_rebuild_syncookie_consistency
+	test_ecmp_syncookie_path_consistency
+"
+
+link_tx_packets_get()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" cat "/sys/class/net/$dev/statistics/tx_packets"
+}
+
+# Return the number of packets matched by the tc filter action on a device.
+# When tc drops packets via "action drop", the device's tx_packets is not
+# incremented (packet never reaches veth_xmit), but the tc action maintains
+# its own counter.
+tc_filter_pkt_count()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc -s filter show dev "$dev" parent 1: 2>/dev/null |
+		awk '/Sent .* pkt/ {
+			for (i=1; i<=NF; i++)
+				if ($i == "pkt") { print $(i-1); exit }
+		}'
+}
+
+# Read a TcpExt counter from /proc/net/netstat in a namespace.
+# Returns 0 if the counter is not found.
+get_netstat_counter()
+{
+	local ns=$1; shift
+	local field=$1; shift
+	local val
+
+	# shellcheck disable=SC2016
+	val=$(ip netns exec "$ns" awk -v key="$field" '
+		/^TcpExt:/ {
+			if (!h) { split($0, n); h=1 }
+			else {
+				split($0, v)
+				for (i in n)
+					if (n[i] == key) print v[i]
+			}
+		}
+	' /proc/net/netstat)
+	echo "${val:-0}"
+}
+
+# Apply netem ECN marking: CE-mark all ECT packets instead of dropping them.
+mark_ecn()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc add dev "$dev" root netem loss 100% ecn
+}
+
+# Block TCP (IPv6 next-header = 6) egress, allowing ICMPv6 through.
+block_tcp()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc add dev "$dev" root handle 1: prio
+	ip netns exec "$ns" tc filter add dev "$dev" parent 1: \
+		protocol ipv6 prio 1 u32 match u8 0x06 0xff at 6 action drop
+}
+
+unblock_tcp()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc del dev "$dev" root 2>/dev/null
+}
+
+# Return success when a device's TX counter exceeds a baseline value.
+dev_tx_packets_above()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+	local baseline=$1; shift
+
+	local cur
+	cur=$(link_tx_packets_get "$ns" "$dev")
+	[ "$cur" -gt "$baseline" ]
+}
+
+# Return success when both devices have dropped at least one TCP packet.
+both_devs_attempted()
+{
+	local ns=$1; shift
+	local dev0=$1; shift
+	local dev1=$1; shift
+
+	local c0 c1
+	c0=$(tc_filter_pkt_count "$ns" "$dev0")
+	c1=$(tc_filter_pkt_count "$ns" "$dev1")
+	[ "${c0:-0}" -ge 1 ] && [ "${c1:-0}" -ge 1 ]
+}
+
+link_tx_packets_total()
+{
+	local ns=$1; shift
+
+	echo $(( $(link_tx_packets_get "$ns" veth0a) +
+		 $(link_tx_packets_get "$ns" veth1a) ))
+}
+
+setup()
+{
+	setup_ns NS1 NS2
+
+	local ns
+	for ns in "$NS1" "$NS2"; do
+		ip netns exec "$ns" sysctl -qw net.ipv6.conf.all.accept_dad=0
+		ip netns exec "$ns" sysctl -qw net.ipv6.conf.default.accept_dad=0
+		ip netns exec "$ns" sysctl -qw net.ipv6.conf.all.forwarding=1
+		ip netns exec "$ns" sysctl -qw net.core.txrehash=1
+	done
+
+	local i sub
+	for i in 0 1; do
+		sub=${SUBNETS[$i]}
+		ip link add "veth${i}a" type veth peer name "veth${i}b"
+		ip link set "veth${i}a" netns "$NS1"
+		ip link set "veth${i}b" netns "$NS2"
+		ip -n "$NS1" addr add "fd00:${sub}::1/64" dev "veth${i}a"
+		ip -n "$NS2" addr add "fd00:${sub}::2/64" dev "veth${i}b"
+		ip -n "$NS1" link set "veth${i}a" up
+		ip -n "$NS2" link set "veth${i}b" up
+	done
+
+	ip -n "$NS1" addr add fd00:ff::1/128 dev lo
+	ip -n "$NS2" addr add fd00:ff::2/128 dev lo
+
+	# Allow many SYN retries at 1-second intervals (linear, no
+	# exponential backoff) so the rehash test has enough attempts
+	# to exercise both ECMP paths.
+	if ! ip netns exec "$NS1" sysctl -qw \
+	     net.ipv4.tcp_syn_linear_timeouts=25; then
+		echo "SKIP: tcp_syn_linear_timeouts not supported"
+		return "$ksft_skip"
+	fi
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_syn_retries=25
+
+	# Keep the server's request socket alive during the blocking
+	# period so SYN/ACK retransmits continue.
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_synack_retries=25
+
+	ip -n "$NS1" -6 route add fd00:ff::2/128 \
+		nexthop via fd00:a::2 dev veth0a \
+		nexthop via fd00:b::2 dev veth1a
+
+	ip -n "$NS2" -6 route add fd00:ff::1/128 \
+		nexthop via fd00:a::1 dev veth0b \
+		nexthop via fd00:b::1 dev veth1b
+
+	for i in 0 1; do
+		sub=${SUBNETS[$i]}
+		ip netns exec "$NS1" \
+			ping -6 -c1 -W5 "fd00:${sub}::2" &>/dev/null
+		ip netns exec "$NS2" \
+			ping -6 -c1 -W5 "fd00:${sub}::1" &>/dev/null
+	done
+
+	if ! ip netns exec "$NS1" ping -6 -c1 -W5 fd00:ff::2 &>/dev/null; then
+		echo "Basic connectivity check failed"
+		return "$ksft_skip"
+	fi
+}
+
+# Block ALL paths, start a connection, wait until SYNs have been dropped
+# on both interfaces (proving rehash steered the SYN to a new path), then
+# unblock so the connection completes.
+test_ecmp_syn_rehash()
+{
+	RET=0
+
+	block_tcp "$NS1" veth0a
+	defer unblock_tcp "$NS1" veth0a
+	block_tcp "$NS1" veth1a
+	defer unblock_tcp "$NS1" veth1a
+
+	ip netns exec "$NS2" socat \
+		"TCP6-LISTEN:$PORT,bind=[fd00:ff::2],reuseaddr,fork" \
+		EXEC:"echo ESTABLISH_OK" &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" "$PORT" tcp
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+
+	# Start the connection in the background; it will retry SYNs at
+	# 1-second intervals until an unblocked path is found.
+	# Use -u (unidirectional) to only receive from the server;
+	# sending data back would risk SIGPIPE if the server's EXEC
+	# child has already exited.
+	local tmpfile
+	tmpfile=$(mktemp)
+	defer rm -f "$tmpfile"
+
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$PORT,bind=[fd00:ff::1],connect-timeout=60" \
+		STDOUT >"$tmpfile" 2>&1 &
+	local client_pid=$!
+	defer kill_process "$client_pid"
+
+	# Wait until both paths have seen at least one dropped SYN.
+	# This proves sk_rethink_txhash() rehashed the connection from
+	# one ECMP path to the other.
+	slowwait 30 both_devs_attempted "$NS1" veth0a veth1a
+	check_err $? "SYNs did not appear on both paths (rehash not working)"
+	if [ "$RET" -ne 0 ]; then
+		log_test "Local ECMP SYN rehash: establish with blocked paths"
+		return
+	fi
+
+	# Unblock both paths and let the next SYN retransmit succeed.
+	unblock_tcp "$NS1" veth0a
+	unblock_tcp "$NS1" veth1a
+
+	local rc=0
+	wait "$client_pid" || rc=$?
+
+	local result
+	result=$(cat "$tmpfile" 2>/dev/null)
+
+	if [[ "$result" != *"ESTABLISH_OK"* ]]; then
+		check_err 1 "connection failed after unblocking (rc=$rc): $result"
+	fi
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	log_test "Local ECMP SYN rehash: establish with blocked paths"
+}
+
+# Block the server's return paths so SYN/ACKs are dropped.  The client
+# retransmits SYNs at 1-second intervals; each duplicate SYN arriving at
+# the server triggers tcp_rtx_synack() which re-rolls txhash, so the
+# retransmitted SYN/ACK selects a different ECMP return path.
+test_ecmp_synack_rehash()
+{
+	RET=0
+	local port=$((PORT + 2))
+
+	block_tcp "$NS2" veth0b
+	defer unblock_tcp "$NS2" veth0b
+	block_tcp "$NS2" veth1b
+	defer unblock_tcp "$NS2" veth1b
+
+	ip netns exec "$NS2" socat \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr,fork" \
+		EXEC:"echo SYNACK_OK" &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" "$port" tcp
+
+	# Start the connection; SYNs reach the server (client egress is
+	# open) but SYN/ACKs are dropped on the server's return path.
+	local tmpfile
+	tmpfile=$(mktemp)
+	defer rm -f "$tmpfile"
+
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1],connect-timeout=60" \
+		STDOUT >"$tmpfile" 2>&1 &
+	local client_pid=$!
+	defer kill_process "$client_pid"
+
+	# Wait until both server-side interfaces have dropped at least
+	# one SYN/ACK, proving the server rehashed its return path.
+	slowwait 30 both_devs_attempted "$NS2" veth0b veth1b
+	check_err $? "SYN/ACKs did not appear on both return paths"
+	if [ "$RET" -ne 0 ]; then
+		log_test "Local ECMP SYN/ACK rehash: blocked return path"
+		return
+	fi
+
+	# Unblock and let the connection complete.
+	unblock_tcp "$NS2" veth0b
+	unblock_tcp "$NS2" veth1b
+
+	local rc=0
+	wait "$client_pid" || rc=$?
+
+	local result
+	result=$(cat "$tmpfile" 2>/dev/null)
+
+	if [[ "$result" != *"SYNACK_OK"* ]]; then
+		check_err 1 "connection failed after unblocking (rc=$rc): $result"
+	fi
+
+	log_test "Local ECMP SYN/ACK rehash: blocked return path"
+}
+
+# Establish a data transfer with both paths open, then block the
+# active path.  Verify that data appears on the previously inactive
+# path (proving RTO triggered a rehash) and that TcpTimeoutRehash
+# incremented.
+#
+# With 2-way ECMP each rehash may pick the same path, so a single
+# attempt can occasionally fail.  Retry once for robustness.
+
+# Single attempt at the midstream rehash check.  Returns 0 on success.
+ecmp_midstream_rehash_attempt()
+{
+	local port=$1; shift
+	local reason=""
+
+	ip netns exec "$NS2" socat -u \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" - >/dev/null &
+	local server_pid=$!
+
+	wait_local_port_listen "$NS2" "$port" tcp
+
+	local base_tx0 base_tx1
+	base_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	base_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	# Continuous data source; timeout caps overall test duration and
+	# must exceed the slowwait below so data keeps flowing.
+	ip netns exec "$NS1" timeout 90 socat -u \
+		OPEN:/dev/zero \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" &>/dev/null &
+	local client_pid=$!
+
+	# Wait for enough packets to identify the active path.
+	if ! busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null; then
+		kill "$client_pid" "$server_pid" 2>/dev/null
+		wait "$client_pid" "$server_pid" 2>/dev/null
+		echo "no TX activity"
+		return 1
+	fi
+
+	# Find the active path and block it.
+	local current_tx0 current_tx1 active_idx inactive_idx
+	current_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	current_tx1=$(link_tx_packets_get "$NS1" veth1a)
+	if [ $((current_tx0 - base_tx0)) -ge $((current_tx1 - base_tx1)) ]; then
+		active_idx=0; inactive_idx=1
+	else
+		active_idx=1; inactive_idx=0
+	fi
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	# Suppress __dst_negative_advice() in tcp_write_timeout() so
+	# that __sk_dst_reset() is the only dst-invalidation mechanism
+	# on the RTO path.
+	local saved_retries1
+	saved_retries1=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_retries1)
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_retries1=255
+
+	block_tcp "$NS1" "veth${active_idx}a"
+
+	# Capture baseline after block_tcp returns.  block_tcp adds a
+	# prio qdisc then a tc filter; between those two steps the
+	# qdisc's CAN_BYPASS fast-path lets packets through unfiltered.
+	local inactive_before
+	inactive_before=$(link_tx_packets_get "$NS1" "veth${inactive_idx}a")
+
+	# Wait for meaningful data on the previously inactive path,
+	# proving RTO triggered a rehash and data actually moved.
+	if ! slowwait 60 dev_tx_packets_above \
+		"$NS1" "veth${inactive_idx}a" "$((inactive_before + 100))"; then
+		reason="no data on alternate path"
+	fi
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		reason="${reason:+$reason; }TcpTimeoutRehash did not increment"
+	fi
+
+	unblock_tcp "$NS1" "veth${active_idx}a"
+	ip netns exec "$NS1" sysctl -qw \
+		net.ipv4.tcp_retries1="$saved_retries1"
+	kill "$client_pid" "$server_pid" 2>/dev/null
+	wait "$client_pid" "$server_pid" 2>/dev/null
+	if [ -n "$reason" ]; then
+		echo "$reason"
+		return 1
+	fi
+	return 0
+}
+
+test_ecmp_midstream_rehash()
+{
+	RET=0
+	local port=$((PORT + 1))
+
+	local fail_reason
+	fail_reason=$(ecmp_midstream_rehash_attempt "$port")
+	if [ $? -ne 0 ]; then
+		fail_reason=$(ecmp_midstream_rehash_attempt "$((port + 1))")
+		check_err $? "$fail_reason"
+	fi
+
+	log_test "Local ECMP midstream rehash: block active path"
+}
+
+# Single attempt at the ACK rehash check.  Returns 0 on success.
+ecmp_ack_rehash_attempt()
+{
+	local port=$1; shift
+	local reason=""
+
+	ip netns exec "$NS2" socat -u \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" - >/dev/null &
+	local server_pid=$!
+
+	wait_local_port_listen "$NS2" "$port" tcp
+
+	local base_total
+	base_total=$(link_tx_packets_total "$NS1")
+
+	# Continuous data source from NS1 to NS2.
+	ip netns exec "$NS1" timeout 120 socat -u \
+		OPEN:/dev/zero \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" &>/dev/null &
+	local client_pid=$!
+
+	# Wait for data to start flowing.
+	if ! busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base_total + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null; then
+		kill "$client_pid" "$server_pid" 2>/dev/null
+		wait "$client_pid" "$server_pid" 2>/dev/null
+		echo "no TX activity"
+		return 1
+	fi
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS2" TcpDuplicateDataRehash)
+
+	# Block both return paths from NS2 so ACKs are dropped.
+	# Data from NS1 still arrives (tc filter is on egress).
+	block_tcp "$NS2" veth0b
+	block_tcp "$NS2" veth1b
+
+	# NS1 will RTO (no ACKs), retransmit with new flowlabel.
+	# NS2 detects the flowlabel change via tcp_rcv_spurious_retrans(),
+	# rehashes, and NS2's ACKs try a different ECMP return path.
+	# Wait until both NS2 interfaces have dropped at least one ACK.
+	if ! slowwait 60 both_devs_attempted "$NS2" veth0b veth1b; then
+		reason="ACKs did not appear on both return paths"
+	fi
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS2" TcpDuplicateDataRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		reason="${reason:+$reason; }TcpDuplicateDataRehash did not increment"
+	fi
+
+	unblock_tcp "$NS2" veth0b
+	unblock_tcp "$NS2" veth1b
+	kill "$client_pid" "$server_pid" 2>/dev/null
+	wait "$client_pid" "$server_pid" 2>/dev/null
+	if [ -n "$reason" ]; then
+		echo "$reason"
+		return 1
+	fi
+	return 0
+}
+
+# Block the receiver's (NS2) ACK return paths while data flows from
+# NS1 to NS2.  The sender (NS1) times out and retransmits with a new
+# flowlabel; the receiver detects the changed flowlabel via
+# tcp_rcv_spurious_retrans() and rehashes its own txhash so that its
+# ACKs try a different ECMP return path.
+#
+# With 2-way ECMP each rehash may pick the same path, so a single
+# attempt can occasionally fail.  Retry once for robustness.
+test_ecmp_midstream_ack_rehash()
+{
+	RET=0
+	local port=$((PORT + 3))
+
+	local fail_reason
+	fail_reason=$(ecmp_ack_rehash_attempt "$port")
+	if [ $? -ne 0 ]; then
+		fail_reason=$(ecmp_ack_rehash_attempt "$((port + 1))")
+		check_err $? "$fail_reason"
+	fi
+
+	log_test "Local ECMP midstream ACK rehash: blocked return path"
+}
+
+# Establish a DCTCP data transfer with PLB enabled, then ECN-mark both
+# paths.  Sustained CE marking triggers PLB to call sk_rethink_txhash()
+# + __sk_dst_reset(), bouncing the connection between ECMP paths.
+# Verify data appears on both paths and that TCPPLBRehash incremented.
+test_ecmp_plb_rehash()
+{
+	RET=0
+	local port=$((PORT + 4))
+
+	# DCTCP is a restricted congestion control algorithm.  Add it to
+	# tcp_allowed_congestion_control to mark it TCP_CONG_NON_RESTRICTED
+	# so test namespaces can set it as their default.  This avoids
+	# changing the host's default congestion control algorithm.
+	# The write must be from the root namespace; writes from child
+	# namespaces do not take effect.
+	local saved_allowed
+	saved_allowed=$(sysctl -n net.ipv4.tcp_allowed_congestion_control)
+	if ! echo "$saved_allowed" | grep -qw dctcp; then
+		local was_loaded
+		was_loaded=$(grep -cw tcp_dctcp /proc/modules 2>/dev/null)
+		modprobe tcp_dctcp 2>/dev/null
+		# Unload only if we loaded it (absent before, present now).
+		# Built-in modules never appear in /proc/modules.
+		if [ "${was_loaded:-0}" -eq 0 ] &&
+		   grep -qw tcp_dctcp /proc/modules 2>/dev/null; then
+			defer modprobe -r tcp_dctcp 2>/dev/null
+		fi
+		if ! sysctl -qw net.ipv4.tcp_allowed_congestion_control="$saved_allowed dctcp"; then
+			log_test_skip "Local ECMP PLB rehash: DCTCP not available"
+			return "$ksft_skip"
+		fi
+		defer sysctl -qw \
+			net.ipv4.tcp_allowed_congestion_control="$saved_allowed"
+	fi
+
+	# Save NS1 sysctls before modifying them.
+	local saved_ecn1 saved_cc1 saved_plb_enabled saved_plb_rounds
+	local saved_plb_thresh saved_plb_suspend
+	saved_ecn1=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_ecn)
+	saved_cc1=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_congestion_control)
+	saved_plb_enabled=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_plb_enabled)
+	saved_plb_rounds=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_plb_rehash_rounds)
+	saved_plb_thresh=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_plb_cong_thresh)
+	saved_plb_suspend=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_plb_suspend_rto_sec)
+
+	# Enable ECN and DCTCP with PLB on the sender.
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_ecn=1
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_congestion_control=dctcp
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_enabled=1
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_rehash_rounds=3
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_cong_thresh=1
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_suspend_rto_sec=0
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_ecn="$saved_ecn1"
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_congestion_control="$saved_cc1"
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_enabled="$saved_plb_enabled"
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_rehash_rounds="$saved_plb_rounds"
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_cong_thresh="$saved_plb_thresh"
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_suspend_rto_sec="$saved_plb_suspend"
+
+	# DCTCP sets ECT on the SYN; the receiver must also use DCTCP
+	# so that tcp_ca_needs_ecn(listen_sk) accepts the ECN
+	# negotiation.
+	local saved_ecn2 saved_cc2
+	saved_ecn2=$(ip netns exec "$NS2" sysctl -n net.ipv4.tcp_ecn)
+	saved_cc2=$(ip netns exec "$NS2" sysctl -n net.ipv4.tcp_congestion_control)
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_ecn=1
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_congestion_control=dctcp
+	defer ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_ecn="$saved_ecn2"
+	defer ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_congestion_control="$saved_cc2"
+
+	ip netns exec "$NS2" socat -u \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" - >/dev/null &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" "$port" tcp
+
+	local base_tx0 base_tx1
+	base_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	base_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	ip netns exec "$NS1" timeout 90 socat -u \
+		OPEN:/dev/zero \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" &>/dev/null &
+	local client_pid=$!
+	defer kill_process "$client_pid"
+
+	# Wait for data to start flowing before applying ECN marking.
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null
+	check_err $? "no TX activity detected"
+	if [ "$RET" -ne 0 ]; then
+		log_test "Local ECMP PLB rehash: ECN-marked path"
+		return
+	fi
+
+	# Snapshot TX counters and rehash stats before ECN marking.
+	local pre_ecn_tx0 pre_ecn_tx1
+	pre_ecn_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	pre_ecn_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	local plb_before rto_before
+	plb_before=$(get_netstat_counter "$NS1" TCPPLBRehash)
+	rto_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+
+	# CE-mark all data on both paths.  PLB detects sustained
+	# congestion and rehashes, bouncing traffic between paths.
+	mark_ecn "$NS1" veth0a
+	defer unblock_tcp "$NS1" veth0a	# removes the marking rule
+	mark_ecn "$NS1" veth1a
+	defer unblock_tcp "$NS1" veth1a	# removes the marking rule
+
+	# Wait for meaningful data on both paths, proving PLB rehashed
+	# the connection and traffic actually moved.  Require at least
+	# 100 packets beyond the baseline to rule out stray control
+	# packets (ND, etc.) satisfying the check.
+	slowwait 60 dev_tx_packets_above \
+		"$NS1" veth0a "$((pre_ecn_tx0 + 100))"
+	check_err $? "no data on veth0a after ECN marking"
+
+	slowwait 60 dev_tx_packets_above \
+		"$NS1" veth1a "$((pre_ecn_tx1 + 100))"
+	check_err $? "no data on veth1a after ECN marking"
+
+	local plb_after rto_after
+	plb_after=$(get_netstat_counter "$NS1" TCPPLBRehash)
+	rto_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$plb_after" -le "$plb_before" ]; then
+		check_err 1 "TCPPLBRehash counter did not increment"
+	fi
+	if [ "$rto_after" -gt "$rto_before" ]; then
+		check_err 1 "TcpTimeoutRehash incremented; rehash was RTO-driven, not PLB"
+	fi
+
+	log_test "Local ECMP PLB rehash: ECN-marked path"
+}
+
+# Verify that hash policy 1 (L3+L4 symmetric) preserves the ECMP path
+# across rehash.  Policy 1 computes a deterministic hash from the
+# 5-tuple, so mp_hash stays 0 and rt6_multipath_hash() always selects
+# the same path regardless of txhash changes.
+test_ecmp_hash_policy1_no_rehash()
+{
+	RET=0
+	local port=$((PORT + 5))
+
+	local saved_policy
+	saved_policy=$(ip netns exec "$NS1" sysctl -n \
+		net.ipv6.fib_multipath_hash_policy)
+	ip netns exec "$NS1" sysctl -qw net.ipv6.fib_multipath_hash_policy=1
+	defer ip netns exec "$NS1" sysctl -qw \
+		net.ipv6.fib_multipath_hash_policy="$saved_policy"
+
+	block_tcp "$NS1" veth0a
+	defer unblock_tcp "$NS1" veth0a
+	block_tcp "$NS1" veth1a
+	defer unblock_tcp "$NS1" veth1a
+
+	ip netns exec "$NS2" socat \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr,fork" \
+		EXEC:"echo POLICY1_OK" &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" "$port" tcp
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+
+	ip netns exec "$NS1" timeout 10 socat -u \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1],connect-timeout=8" \
+		STDOUT >/dev/null 2>&1 &
+	local client_pid=$!
+	defer kill_process "$client_pid"
+
+	# With policy 1, the deterministic 5-tuple hash always selects
+	# the same path.  Wait for multiple SYN retransmits (proving
+	# rehash was attempted), then verify all SYNs landed on the
+	# same interface.
+	local rehash_after
+	slowwait 8 until_counter_is ">= $((rehash_before + 3))" \
+		get_netstat_counter "$NS1" TcpTimeoutRehash > /dev/null
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	local c0 c1
+	c0=$(tc_filter_pkt_count "$NS1" veth0a)
+	c1=$(tc_filter_pkt_count "$NS1" veth1a)
+	if [ "${c0:-0}" -ge 1 ] && [ "${c1:-0}" -ge 1 ]; then
+		check_err 1 "SYNs appeared on both paths despite policy 1"
+	fi
+	if [ "${c0:-0}" -eq 0 ] && [ "${c1:-0}" -eq 0 ]; then
+		check_err 1 "no SYNs observed on either path"
+	fi
+
+	log_test "Local ECMP policy 1: no path change on rehash"
+}
+
+# Verify that mp_hash does not leak into the on-wire flowlabel.
+# With auto_flowlabels=0, the wire flowlabel must be 0.  Install tc
+# filters that pass TCP with flowlabel=0 but drop TCP with nonzero
+# flowlabel, then establish a connection and transfer data.  If
+# mp_hash leaked into fl6->flowlabel, the SYN or data packets would
+# be dropped and the connection would fail.
+test_ecmp_no_flowlabel_leak()
+{
+	RET=0
+	local port=$((PORT + 6))
+
+	local saved_afl
+	saved_afl=$(ip netns exec "$NS1" sysctl -n \
+		net.ipv6.auto_flowlabels)
+	ip netns exec "$NS1" sysctl -qw net.ipv6.auto_flowlabels=0
+	defer ip netns exec "$NS1" sysctl -qw \
+		net.ipv6.auto_flowlabels="$saved_afl"
+
+	# On both egress interfaces: pass TCP with flowlabel=0 (prio 1),
+	# drop any remaining TCP (nonzero flowlabel, prio 2).  ICMPv6
+	# matches neither filter and passes through normally.
+	local dev
+	for dev in veth0a veth1a; do
+		ip netns exec "$NS1" tc qdisc add dev "$dev" \
+			root handle 1: prio
+		ip netns exec "$NS1" tc filter add dev "$dev" parent 1: \
+			protocol ipv6 prio 1 u32 \
+			match u32 0x00000000 0x000FFFFF at 0 \
+			match u8 0x06 0xff at 6 \
+			action ok
+		ip netns exec "$NS1" tc filter add dev "$dev" parent 1: \
+			protocol ipv6 prio 2 u32 \
+			match u8 0x06 0xff at 6 \
+			action drop
+		defer unblock_tcp "$NS1" "$dev"
+	done
+
+	ip netns exec "$NS2" socat \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" \
+		EXEC:"echo FLOWLABEL_OK" &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" "$port" tcp
+
+	local tmpfile
+	tmpfile=$(mktemp)
+	defer rm -f "$tmpfile"
+
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1],connect-timeout=10" \
+		STDOUT >"$tmpfile" 2>&1
+
+	local result
+	result=$(cat "$tmpfile" 2>/dev/null)
+	if [[ "$result" != *"FLOWLABEL_OK"* ]]; then
+		check_err 1 "connection failed: mp_hash may have leaked into wire flowlabel"
+	fi
+
+	log_test "No flowlabel leak with auto_flowlabels=0"
+}
+
+# Helper: stream data, invalidate the cached dst by adding and
+# removing a dummy route (bumps fib6_node sernum), then check that
+# traffic stays on the same ECMP path.  Used by both the normal
+# tcp_v6_connect and syncookie variants.
+ecmp_dst_rebuild_check()
+{
+	local ns_client=$1; shift
+	local port=$1; shift
+	local rc=0
+
+	# Suppress __dst_negative_advice() during the test so that a
+	# real TCP timeout cannot trigger an additional dst
+	# invalidation via a different code path.
+	local saved_retries1
+	saved_retries1=$(ip netns exec "$ns_client" sysctl -n \
+		net.ipv4.tcp_retries1)
+	ip netns exec "$ns_client" sysctl -qw net.ipv4.tcp_retries1=255
+
+	local base0 base1
+	base0=$(link_tx_packets_get "$ns_client" veth0a)
+	base1=$(link_tx_packets_get "$ns_client" veth1a)
+
+	ip netns exec "$ns_client" timeout 15 socat -u \
+		OPEN:/dev/zero \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" \
+		&>/dev/null &
+	local client_pid=$!
+
+	# Wait for enough packets to identify the active path.
+	# Return 2 for setup failure (distinct from 1 = path changed).
+	if ! busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base0 + base1 + 50))" \
+		link_tx_packets_total "$ns_client" > /dev/null; then
+		ip netns exec "$ns_client" sysctl -qw \
+			net.ipv4.tcp_retries1="$saved_retries1"
+		kill "$client_pid" 2>/dev/null
+		wait "$client_pid" 2>/dev/null
+		return 2
+	fi
+
+	local mid0 mid1 active_dev inactive_dev
+	mid0=$(link_tx_packets_get "$ns_client" veth0a)
+	mid1=$(link_tx_packets_get "$ns_client" veth1a)
+	if [ $((mid0 - base0)) -ge $((mid1 - base1)) ]; then
+		active_dev=veth0a; inactive_dev=veth1a
+	else
+		active_dev=veth1a; inactive_dev=veth0a
+	fi
+
+	local active_before inactive_before
+	active_before=$(link_tx_packets_get "$ns_client" "$active_dev")
+	inactive_before=$(link_tx_packets_get "$ns_client" "$inactive_dev")
+
+	# Invalidate the cached dst by bumping the fib6_node sernum.
+	# Adding and removing a high-metric dummy route achieves this
+	# without touching the ECMP nexthops, avoiding a transient
+	# single-nexthop state during multipath route replace.
+	ip -n "$ns_client" -6 route add fd00:ff::2/128 dev lo metric 9999
+	ip -n "$ns_client" -6 route del fd00:ff::2/128 dev lo metric 9999
+
+	# Wait for enough post-rebuild traffic to detect a path change.
+	if ! busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((active_before + inactive_before + 50))" \
+		link_tx_packets_total "$ns_client" > /dev/null; then
+		ip netns exec "$ns_client" sysctl -qw \
+			net.ipv4.tcp_retries1="$saved_retries1"
+		kill "$client_pid" 2>/dev/null
+		wait "$client_pid" 2>/dev/null
+		return 2
+	fi
+
+	local active_after inactive_after
+	active_after=$(link_tx_packets_get "$ns_client" "$active_dev")
+	inactive_after=$(link_tx_packets_get "$ns_client" "$inactive_dev")
+
+	local active_delta=$((active_after - active_before))
+	local inactive_delta=$((inactive_after - inactive_before))
+
+	if [ "$inactive_delta" -gt "$active_delta" ]; then
+		rc=1
+	fi
+
+	ip netns exec "$ns_client" sysctl -qw \
+		net.ipv4.tcp_retries1="$saved_retries1"
+	kill "$client_pid" 2>/dev/null
+	wait "$client_pid" 2>/dev/null
+	return "$rc"
+}
+
+# Run ecmp_dst_rebuild_check for ECMP_REBUILD_ROUNDS rounds, each with
+# a fresh server and connection.  With a correct kernel the path is
+# deterministic (same txhash always selects the same ECMP nexthop),
+# so any path change is a bug.  Multiple rounds catch a buggy kernel
+# that picks a random path: each round has 50% chance of accidentally
+# matching, so 10 rounds gives < 0.1% false-pass probability.
+ecmp_dst_rebuild_loop()
+{
+	local base_port=$1; shift
+	local label=$1; shift
+	local path_changes=0
+	local r
+
+	for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
+		local port=$((base_port + r))
+
+		ip netns exec "$NS2" socat -u \
+			"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" \
+			- >/dev/null &
+		local server_pid=$!
+
+		wait_local_port_listen "$NS2" "$port" tcp
+
+		local check_rc=0
+		ecmp_dst_rebuild_check "$NS1" "$port" || check_rc=$?
+
+		kill "$server_pid" 2>/dev/null
+		wait "$server_pid" 2>/dev/null
+
+		if [ "$check_rc" -eq 2 ]; then
+			check_err 1 "no TX activity in round $r"
+			break
+		elif [ "$check_rc" -eq 1 ]; then
+			path_changes=$((path_changes + 1))
+		fi
+	done
+
+	if [ "$path_changes" -gt 0 ]; then
+		check_err 1 "$path_changes/$ECMP_REBUILD_ROUNDS changed path"
+	fi
+
+	log_test "$label"
+}
+
+# Verify that a dst invalidation does not cause the connection to
+# switch ECMP paths.  With the fix, both the initial route lookup
+# (tcp_v6_connect) and subsequent rebuilds (inet6_csk_route_socket)
+# use sk_txhash >> 1, so the path is stable.
+test_ecmp_dst_rebuild_consistency()
+{
+	RET=0
+
+	ecmp_dst_rebuild_loop "$((PORT + 7))" \
+		"ECMP path stable after dst invalidation"
+}
+
+# Same as above but with syncookies forced (tcp_syncookies=2), so the
+# server creates the full socket via cookie_v6_check() instead of the
+# normal three-way handshake path.
+test_ecmp_dst_rebuild_syncookie_consistency()
+{
+	RET=0
+
+	local saved_syncookies
+	saved_syncookies=$(ip netns exec "$NS2" sysctl -n \
+		net.ipv4.tcp_syncookies)
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_syncookies=2
+	defer ip netns exec "$NS2" sysctl -qw \
+		net.ipv4.tcp_syncookies="$saved_syncookies"
+
+	ecmp_dst_rebuild_loop "$((PORT + 27))" \
+		"ECMP path stable after dst invalidation (syncookies)"
+}
+
+# Verify that the server's SYN-ACK (sent from the request socket) and
+# subsequent ACKs (sent from the full socket created in cookie_v6_check)
+# use the same ECMP path.  With syncookies the request socket is freed
+# after the SYN-ACK and a new one is created during cookie validation;
+# this test catches the case where the two request sockets pick
+# different ECMP paths due to independent txhash values.
+# Count TCP packets on server egress without blocking them.
+# Uses tc filters with "action ok" so packets are counted and passed.
+count_tcp()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc add dev "$dev" root handle 1: prio
+	ip netns exec "$ns" tc filter add dev "$dev" parent 1: \
+		protocol ipv6 prio 1 u32 match u8 0x06 0xff at 6 action ok
+}
+
+test_ecmp_syncookie_path_consistency()
+{
+	RET=0
+
+	local saved_syncookies
+	saved_syncookies=$(ip netns exec "$NS2" sysctl -n \
+		net.ipv4.tcp_syncookies)
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_syncookies=2
+	defer ip netns exec "$NS2" sysctl -qw \
+		net.ipv4.tcp_syncookies="$saved_syncookies"
+
+	count_tcp "$NS2" veth0b
+	defer unblock_tcp "$NS2" veth0b
+	count_tcp "$NS2" veth1b
+	defer unblock_tcp "$NS2" veth1b
+
+	local path_splits=0
+	local r
+
+	for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
+		local port=$((PORT + 47 + r))
+
+		ip netns exec "$NS2" socat -u \
+			"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" \
+			- >/dev/null &
+		local server_pid=$!
+
+		wait_local_port_listen "$NS2" "$port" tcp
+
+		local srv_base0 srv_base1
+		srv_base0=$(tc_filter_pkt_count "$NS2" veth0b)
+		srv_base1=$(tc_filter_pkt_count "$NS2" veth1b)
+
+		ip netns exec "$NS1" timeout 5 socat -u \
+			OPEN:/dev/zero \
+			"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" \
+			&>/dev/null &
+		local client_pid=$!
+
+		local cli_base
+		cli_base=$(link_tx_packets_total "$NS1")
+		if ! busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+				">= $((cli_base + 200))" \
+			link_tx_packets_total "$NS1" > /dev/null; then
+			check_err 1 "no TX activity in round $r"
+			kill "$client_pid" 2>/dev/null
+			wait "$client_pid" 2>/dev/null
+			kill "$server_pid" 2>/dev/null
+			wait "$server_pid" 2>/dev/null
+			break
+		fi
+
+		local srv_tcp0 srv_tcp1
+		srv_tcp0=$(tc_filter_pkt_count "$NS2" veth0b)
+		srv_tcp1=$(tc_filter_pkt_count "$NS2" veth1b)
+		local srv_delta0=$(( ${srv_tcp0:-0} - ${srv_base0:-0} ))
+		local srv_delta1=$(( ${srv_tcp1:-0} - ${srv_base1:-0} ))
+
+		if [ "$srv_delta0" -gt 0 ] && [ "$srv_delta1" -gt 0 ]; then
+			path_splits=$((path_splits + 1))
+		fi
+
+		kill "$client_pid" 2>/dev/null
+		wait "$client_pid" 2>/dev/null
+		kill "$server_pid" 2>/dev/null
+		wait "$server_pid" 2>/dev/null
+	done
+
+	if [ "$path_splits" -gt 0 ]; then
+		check_err 1 "$path_splits/$ECMP_REBUILD_ROUNDS had split server path"
+	fi
+
+	log_test "Syncookie server ECMP path consistent"
+}
+
+require_command socat
+
+trap 'defer_scopes_cleanup; cleanup_all_ns' EXIT
+setup || exit $?
+tests_run
+exit "$EXIT_STATUS"
-- 
2.53.0-Meta


