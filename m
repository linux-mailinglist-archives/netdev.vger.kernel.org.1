Return-Path: <netdev+bounces-287724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKE5IePhBGrPQAIAu9opvQ
	(envelope-from <netdev+bounces-287724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019253A956
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F811300460C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654A371CEA;
	Wed, 13 May 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aW+KhmyD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7123955F3
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704860; cv=none; b=lDEHoCTUmN2Jjy1saNcBFt6iFToWSOxy5YKryH59+R/U7Y6BN2pl5RlgK2QkJLdLsUuZYCDpsnlNBzG5mp2S5O7/Gmbh8EFTOBTy1xZg3L1oEHqvNFzlkfC7XMB0dldH36NKsX75lTifw5udDe+yum5FBk0q0PUzStw3SA6GJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704860; c=relaxed/simple;
	bh=g/ihIRvBacSVsZU6q4TSWJyjb72xjGx1jCu8g3ds3xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A91Qwcvf5NM8auuAV4NX1y9SrV+tWo671mkynfOYN/moef0qK2khHztFWJdPmbtajzQEndvXcayYY3BspS4L+SPdHT4Vskk2DrgzcOiABT7TMcVgVmhwsULKOA7ZMflDgWbEzmYRlwUhGEI11ZG43r0974/qJMoiDd3ANUwYLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aW+KhmyD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DKJDa7641748
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=JggqRXt
	TIPUvzYltqnY2A+lqtj1ibf7E6ksYKJWSL18=; b=aW+KhmyDNLGhTy/lKHIpvF3
	dOcACxAzqYstjBFwp0Zsh6xhZyqNB0Enag8xGeznIAU+2R5Vx5VQ9CLxZ9390L8k
	7P3Kai51R3CFBFJN6RZJyS6XJjgsiho7j5ISqzHBstQRpG229ef9wL6wL/gF/pRF
	oG2G8DFXkbeYjc9l46/KSvkQyPbhTZWt8Zy965ap3GUus/cvshELQF79AGutNs0j
	AWNpIZZyfMrhnHeP5+QNb54yTMY53pkytKcNz0fan0cb+2/yku2vmwvvbgWtCmux
	XGrx7KXlHlv4Bk7eeAUC8V0W1fS9LLBKojbYa1bJpntPfnySQq5pqYKvZZ7yjaQ=
	=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvs32r4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:56 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479d900d222so12005228b6e.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704855; x=1779309655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JggqRXtTIPUvzYltqnY2A+lqtj1ibf7E6ksYKJWSL18=;
        b=EUrtrTdYQcYqYO99ZyQb0qoQFalf+bbK4giVoYi8rtXnfVPHD1W9FjJ29sE5zMx9z9
         q4mFTVjGScWoFZjB59K1QNf8m5uaytCSsEjPABFB5YqA8vH85hLkC6Mnh7Tu/dEjR47M
         kxlWUCtP6FQoh1ycBlpUYD9sz1M2BD+O6lvKelkISs5vSdGN8sWifdn0To1wm3MtMsVa
         77yy8rg8W2x9LHBeiTs4wyn+YorAhV4+BLFEH8VYIDSzZQrhUyL6Hr5fIRFL44gQfhsI
         D7c3AUQOm9++HnhRz7OJq/ErdD6L5n8fYlk7UzeneQPIn3w1Rsqe41Q9TX0S6mqI51sc
         tuCw==
X-Gm-Message-State: AOJu0YzIZpe0Vs1UpflDoJbmqsXFqrCfvhU+Rx1lrTGb3DmHSc6ZZpR0
	ZQwGj+9tDFZqPs2Fp1fSPm8SdTVp2NiFsvZPjbXBlhHTpoi7xgeuVg7rpIi/79twlbEuXS99cu+
	B3psIfZVOHNV8t1VQBSUik2WjLSrLgwo9q0eEldaRF5C4EwDDMYsKjMPzcUkGxDDSkYq1aQW1pm
	dmD2Q4hqiily5skivGDtiO+YMGSbHyINlYcKKV
X-Gm-Gg: Acq92OHfkVe8a4SgYPs555afR0sBdAlFvKi05gszIXw5lMTpMtR0okKaWqEQ3lCbVpp
	QXPkBkxS/dOkgydlcQRmZeRIYSD/jxhTcKTR5UjRij2R7UGxdeUVAW+bwwQanGSBpj/r3SVNF56
	BXuDkXrIrtf7GaUwdAP0YYZ/jp+gyjxmOGtZYzkDA+KFJmruWHYfpi7R2HmvS2N2VxkaY2eh08J
	htF0Mx9MEI0Wr9jDvVJVOCaQq5CT/mcPNEe2uCY58ro2u7x+/IVzcYkUJQeTZzJLdOD+uxJb+ci
	ot22JKc+n1s/OyKA4GCS7zwegj3bPrRJmalUCn0RuYbg0pdKTph/t5ZbkUeaxxpSdGn8nK77jcO
	kZzpUL3ckwZ0=
X-Received: by 2002:a05:6808:318f:b0:479:fca7:4663 with SMTP id 5614622812f47-482b29089e5mr3213718b6e.9.1778704854607;
        Wed, 13 May 2026 13:40:54 -0700 (PDT)
X-Received: by 2002:a05:6808:318f:b0:479:fca7:4663 with SMTP id 5614622812f47-482b29089e5mr3213676b6e.9.1778704853611;
        Wed, 13 May 2026 13:40:53 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3f3e8d25csm344424a34.17.2026.05.13.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:40:53 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v5 2/2] selftests: net: add local ECMP rehash test
Date: Wed, 13 May 2026 13:40:48 -0700
Message-ID: <20260513204048.2721843-3-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513204048.2721843-1-ntspring@meta.com>
References: <20260513204048.2721843-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BMKDalQG c=1 sm=1 tr=0 ts=6a04e1d8 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=jY7UBUToRik5gmD1XvsA:9
 a=pF_qn-MSjDawc0seGVz6:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 9PlYyZfNS0FueYvux6UrTWdWC2Zqyjjy
X-Proofpoint-ORIG-GUID: 9PlYyZfNS0FueYvux6UrTWdWC2Zqyjjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwMyBTYWx0ZWRfX0p/MVByoqAYL
 N24WQ62NU2r99CHoJAu+/C6kcpLvIjvjzEfJOBt6xrcUJoohQimxPYJv5etREtVmnunfz+DiQax
 kzkeCpcu+wpGx/DkG922EvMijXa/vTr309fXJl2CqCen5+NNx2V9JUosUDAL6zFKOzS9G5JAdoJ
 W8hCcqV/r8sBVmbqGqiQ6OMVZp53oY0FF4oTp9pADVzmAliMK1WpeYuHxvQ91KroIS7ObotHt4H
 iKIfnNNq1ka+s9Gw6iNsv5IQVQfBsMEfgupUhvTeezANOm22PIqCDFABU5w4bL7n1HXbL/FkujL
 sg/CSU5H4sUXeGqoAtBH5toF41tOoLF9TplrJFU9DEQ4aIQTSdAcEXFOtz4i+FejQNeiUqzzXLJ
 ClZmZ9XzF8+gZICY1OGIZvb3lMe3rH0wZDOlQnPqouQlMCXLv0iGhX7XNT9ogdC3y6PMGbduxMp
 Z50QwcwWAr84HEI0H4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 2019253A956
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287724-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ecmp_rehash.sh:url];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add ecmp_rehash.sh with nine scenarios verifying that TCP rehash
selects a different local ECMP path for IPv6:

  - SYN retransmission (forward path blocked during setup)
  - SYN/ACK retransmission (reverse path blocked during setup)
  - Midstream RTO (forward path blocked on established connection)
  - Midstream ACK rehash (reverse path blocked on established connection)
  - PLB rehash (ECN-driven congestion on established connection)
  - Hash policy 1 negative test (rehash attempted but path unchanged)
  - No flowlabel leak (mp_hash does not alter on-wire flowlabel)
  - Dst rebuild consistency (route replace does not change path)
  - Dst rebuild consistency with syncookies (same via cookie_v6_check)

The policy 1 test verifies that fib_multipath_hash_policy=1 computes
a deterministic 5-tuple hash, so txhash re-rolls do not change the
ECMP path while TcpTimeoutRehash still increments.

The flowlabel leak test sets auto_flowlabels=0 and installs tc
filters that drop TCP packets with nonzero flowlabel, confirming
that fl6->mp_hash does not leak into the on-wire IPv6 flow label.

The dst rebuild tests stream data, replace the ECMP route with
identical nexthops (invalidating the cached dst), and verify that
traffic stays on the same path.  This confirms that the initial
route lookup in tcp_v6_connect() and cookie_v6_check() uses the
same hash as subsequent rebuilds via inet6_csk_route_socket().
Set ECMP_REBUILD_ROUNDS=N for statistical confidence.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 861 +++++++++++++++++++++
 3 files changed, 863 insertions(+)
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
index 000000000000..01841623392a
--- /dev/null
+++ b/tools/testing/selftests/net/ecmp_rehash.sh
@@ -0,0 +1,861 @@
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
+
+source lib.sh
+
+SUBNETS=(a b)
+PORT=9900
+: "${ECMP_REBUILD_ROUNDS:=1}"
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
+		exit "$ksft_skip"
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
+test_ecmp_midstream_rehash()
+{
+	RET=0
+	local port=$((PORT + 1))
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
+	# Continuous data source; timeout caps overall test duration and
+	# must exceed the slowwait below so data keeps flowing.
+	ip netns exec "$NS1" timeout 90 socat -u \
+		OPEN:/dev/zero \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" &>/dev/null &
+	local client_pid=$!
+	defer kill_process "$client_pid"
+
+	# Wait for enough packets to identify the active path.
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null
+	check_err $? "no TX activity detected"
+	if [ "$RET" -ne 0 ]; then
+		log_test "Local ECMP midstream rehash: block active path"
+		return
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
+	local inactive_before
+	inactive_before=$(link_tx_packets_get "$NS1" "veth${inactive_idx}a")
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	# Suppress __dst_negative_advice() in tcp_write_timeout() so
+	# that __sk_dst_reset() is the only dst-invalidation mechanism
+	# on the RTO path.
+	local saved_retries1
+	saved_retries1=$(ip netns exec "$NS1" sysctl -n net.ipv4.tcp_retries1)
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_retries1=255
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_retries1="$saved_retries1"
+
+	block_tcp "$NS1" "veth${active_idx}a"
+	defer unblock_tcp "$NS1" "veth${active_idx}a"
+
+	# Wait for meaningful data on the previously inactive path,
+	# proving RTO triggered a rehash and data actually moved.
+	# Require 100 packets beyond baseline to rule out stray
+	# control packets (ND, etc.).  Allow 60s for multiple RTO
+	# cycles with exponential backoff.
+	slowwait 60 dev_tx_packets_above \
+		"$NS1" "veth${inactive_idx}a" "$((inactive_before + 100))"
+	check_err $? "data did not appear on alternate path after blocking"
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	log_test "Local ECMP midstream rehash: block active path"
+}
+
+# Block the receiver's (NS2) ACK return paths while data flows from
+# NS1 to NS2.  The sender (NS1) times out and retransmits with a new
+# flowlabel; the receiver detects the changed flowlabel via
+# tcp_rcv_spurious_retrans() and rehashes its own txhash so that its
+# ACKs try a different ECMP return path.
+test_ecmp_midstream_ack_rehash()
+{
+	RET=0
+	local port=$((PORT + 3))
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
+	# Continuous data source from NS1 to NS2.
+	ip netns exec "$NS1" timeout 120 socat -u \
+		OPEN:/dev/zero \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]" &>/dev/null &
+	defer kill_process $!
+
+	# Wait for data to start flowing.
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null
+	check_err $? "no TX activity detected"
+	if [ "$RET" -ne 0 ]; then
+		log_test "Local ECMP midstream ACK rehash: blocked return path"
+		return
+	fi
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS2" TcpDuplicateDataRehash)
+
+	# Block both return paths from NS2 so ACKs are dropped.
+	# Data from NS1 still arrives (tc filter is on egress).
+	block_tcp "$NS2" veth0b
+	defer unblock_tcp "$NS2" veth0b
+	block_tcp "$NS2" veth1b
+	defer unblock_tcp "$NS2" veth1b
+
+	# NS1 will RTO (no ACKs), retransmit with new flowlabel.
+	# NS2 detects the flowlabel change via tcp_rcv_spurious_retrans(),
+	# rehashes, and NS2's ACKs try a different ECMP return path.
+	# Wait until both NS2 interfaces have dropped at least one ACK.
+	slowwait 60 both_devs_attempted "$NS2" veth0b veth1b
+	check_err $? "ACKs did not appear on both return paths"
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS2" TcpDuplicateDataRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpDuplicateDataRehash counter did not increment"
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
+	# DCTCP is a restricted congestion control algorithm.  Setting it
+	# as the default in the init namespace makes it globally
+	# non-restricted (TCP_CONG_NON_RESTRICTED), allowing child
+	# namespaces to use it.
+	local saved_cc
+	saved_cc=$(sysctl -n net.ipv4.tcp_congestion_control)
+	if [ "$saved_cc" != "dctcp" ]; then
+		local was_loaded
+		was_loaded=$(grep -cw tcp_dctcp /proc/modules 2>/dev/null)
+		modprobe tcp_dctcp 2>/dev/null
+		# Unload only if we loaded it (absent before, present now).
+		# Built-in modules never appear in /proc/modules.
+		if [ "${was_loaded:-0}" -eq 0 ] &&
+		   grep -qw tcp_dctcp /proc/modules 2>/dev/null; then
+			defer modprobe -r tcp_dctcp 2>/dev/null
+		fi
+		defer sysctl -qw net.ipv4.tcp_congestion_control="$saved_cc"
+		if ! sysctl -qw net.ipv4.tcp_congestion_control=dctcp; then
+			log_test_skip "Local ECMP PLB rehash: DCTCP not available"
+			return "$ksft_skip"
+		fi
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
+	# the same path.  Wait long enough for several SYN retransmits,
+	# then verify SYNs did NOT appear on both paths.
+	if slowwait 8 both_devs_attempted "$NS1" veth0a veth1a; then
+		check_err 1 "SYNs appeared on both paths despite policy 1"
+	fi
+
+	# Confirm rehash was still attempted (txhash re-rolled) even
+	# though the ECMP path did not change.
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
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
+# Helper: stream data, replace the ECMP route with identical nexthops
+# (creating a new fib6_info and invalidating the cached dst), then
+# check that traffic stays on the same path.  Used by both the normal
+# tcp_v6_connect and syncookie variants.
+ecmp_dst_rebuild_check()
+{
+	local ns_client=$1; shift
+	local ns_server=$1; shift
+	local port=$1; shift
+	local rc=0
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
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
+			">= $((base0 + base1 + 50))" \
+		link_tx_packets_total "$ns_client" > /dev/null
+	if [ $? -ne 0 ]; then
+		kill "$client_pid" 2>/dev/null
+		wait "$client_pid" 2>/dev/null
+		return 1
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
+	# Replace the ECMP route with identical nexthops.
+	# This creates a new fib6_info, invalidating the
+	# socket's cached dst on the next ip6_dst_check().
+	ip -n "$ns_client" -6 route replace fd00:ff::2/128 \
+		nexthop via fd00:a::2 dev veth0a \
+		nexthop via fd00:b::2 dev veth1a
+
+	sleep 1
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
+	kill "$client_pid" 2>/dev/null
+	wait "$client_pid" 2>/dev/null
+	return "$rc"
+}
+
+# Run ecmp_dst_rebuild_check for ECMP_REBUILD_ROUNDS rounds, each with
+# a fresh server and connection.  Defaults to 1 round; set
+# ECMP_REBUILD_ROUNDS=N for statistical confidence with 2-way ECMP
+# (probability of zero path changes without the fix is (1/2)^N).
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
+		if ! ecmp_dst_rebuild_check "$NS1" "$NS2" "$port"; then
+			path_changes=$((path_changes + 1))
+		fi
+
+		kill "$server_pid" 2>/dev/null
+		wait "$server_pid" 2>/dev/null
+	done
+
+	if [ "$path_changes" -gt 0 ]; then
+		check_err 1 "$path_changes/$ECMP_REBUILD_ROUNDS changed path"
+	fi
+
+	log_test "$label"
+}
+
+# Verify that a natural dst invalidation (route table change) does not
+# cause the connection to switch ECMP paths.  With the fix, both the
+# initial route lookup (tcp_v6_connect) and subsequent rebuilds
+# (inet6_csk_route_socket) use sk_txhash >> 1, so the path is stable.
+test_ecmp_dst_rebuild_consistency()
+{
+	RET=0
+
+	ecmp_dst_rebuild_loop "$((PORT + 7))" \
+		"ECMP path stable after route replace"
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
+		"ECMP path stable after route replace (syncookies)"
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


