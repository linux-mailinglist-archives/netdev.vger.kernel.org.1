Return-Path: <netdev+bounces-304747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ewgEmDDSWoD6wAAu9opvQ
	(envelope-from <netdev+bounces-304747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AAB708D0B
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ih1ddvtg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304747-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304747-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81E98302A2CC
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 02:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B6239E7E;
	Sun,  5 Jul 2026 02:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F58175A93
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 02:36:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783218996; cv=none; b=A1XwOjq+mkm9hPCEcRcdsk8Vu1WZUMQEETAExbuS8U5OWSI++7XpO10gkQDqTVEv5tv/yre5lsBdRv+K+l311tPh7+2qEnuS0mPXPskWrzCdzsTA78uLuuEMrlGs4uwIGYF096eZoIufSmw7pWrq3doLj/Wx+2ODpjfD/585lOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783218996; c=relaxed/simple;
	bh=C6INMuq8FuV/QzCmdZWMKxJ2Gq/F+3gT/xwMaJT50RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvE+dhwSdkImKyCuyLxdNaRoOeZahqbe0Y8Q7nmZWN15odso7797ZByxXv8CH0ZytDQPGFtKbG2+zOLu6ofkV3RBqjaiJM1zlT+F4F3aze/lI9rsJpaYixWpK+a+l57aKNc78eKtBAyEvie+KnTDpi7kcd1Z6mUn+WUcFBekrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih1ddvtg; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c126b8118afso203298766b.2
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 19:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783218993; x=1783823793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNI0y5zuLguVzkcebZ5tUWaeh5KsfA7kAM+rWUugMtw=;
        b=ih1ddvtgx53Wqj9Pkl+pyJR2D/EU3/K8pD0bAjoIxoRDve288GAnXP5sDyEZQMdP//
         iPnAyLKe0gspmec+JktoDYIRBZzInVOCFEXt3qwIrFW67F2g6GX3GYIMZOyIBLs/ObNj
         c56YuDAnhwt0fmCRlxDTkPZ7bLmnEc+pkZRj1dZWSBfgNGlE2vBP06dhI4KaK4AySMGN
         YMVdpGaPIa9hbGbRURRYzam4kGlrJgjs+FZTw75+4FGaBL6zhU4W+S2GtRla+31zF+Qx
         FOhtYCfvFBHtbAa+LSneL8rvYQO/YX666ZHGqiUNlxP2ubAksHv0axDIAJos8KHu4YCy
         aSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783218993; x=1783823793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNI0y5zuLguVzkcebZ5tUWaeh5KsfA7kAM+rWUugMtw=;
        b=ffHmkAIISuKHsSH+DLisUTtvttJbdBIau/fjzGSnnI2qFqeFTTwq4RO4EpT+EN6y6n
         uXsYby8z7UXMvKdux6yh/yRhJv2SZp8QNgo0uUlFMXXqaPIenNJ7ALqObPfEFaqacoYR
         e8yDTk9TdIuT2Gm5101Mn95ZPaqFRInJmgZO+nUpdLT48v4aCeqDbQdhGED1H+XZ3HW4
         /u50lM9zC5cRfvxAN7Q9+u/Qn2YcP5mpp5YKzQcRxkKGlLZF/XX3JtL6TGBPQtZerBZn
         Uw7vtLxzDuDxH5e+HUrcE0+6iiNQmzrMZOLb2bRxwZksyfnAjfSysGROPMTO/Z36SDDr
         QEnw==
X-Gm-Message-State: AOJu0YzME88DtDgGhoP3g8iv3oR+uxF3ggoxm6G4V1zhy21wQsEdBf6a
	IGsVYiS84gok7VLEJL7g5ZNb2Pn2K4rViA3CBiB4K9taq5v473MbszVEHib+7OZY
X-Gm-Gg: AfdE7cnt4Q+YvClR5ocRIn7gsu+zlP3tDRInRlg9Uw33Yv6917ozQYPNVdbcvBFVHZi
	CurKnT/Lh8J1yq6psmvUToc0v0x2E0We3U4bh4LgQABFPVO7dN8ihkFGRwLBJLMUispmvgyAV8K
	vr5XKEQRkozJ21oAC3D/irCdtr0JBL+x5KbLdgeugB6nvRHdsgNaQkq0X7MWgGUnQ1xhxTToZJi
	EJI9TgAZhyw0dVwUqPU7UKfcSwQRdGT2Q/MO047yrKPLypRKFDSb54aJYHpR2ksemj8IGZLIvxH
	++xza8sdQF5Egd8LqZgeB0Qlx2M1txBgYKxV8MbZq9sJDUhsNxBxFgcVQY52eUxqc9PDhbXx2Kb
	YZ2UgsDkg8N+f/sAExawpCm9JdVXIZhzo68L/ZFBB4D9LZYwbaPe3XSuUlAxlj1o5yXAqsCSc9M
	loCEl1G5kW706O4lHNbA94FeVJXX65hW+j5X0kdhqtL8Ucc3bknW/a/1aP2Q==
X-Received: by 2002:a17:907:25c3:b0:c12:cfa4:3a3f with SMTP id a640c23a62f3a-c12e6c0ddcdmr163074866b.55.1783218993239;
        Sat, 04 Jul 2026 19:36:33 -0700 (PDT)
Received: from dau-home-pc.. ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12bc53e065sm463082166b.46.2026.07.04.19.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 19:36:31 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 2/2] selftests: net: add FOU multicast encapsulation resubmit test
Date: Sun,  5 Jul 2026 05:36:04 +0300
Message-ID: <b66a8b13a33b21a1d0bf620bc51b68d78a2c16e1.1783218197.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783218197.git.littlesmilingcloud@gmail.com>
References: <cover.1783218197.git.littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304747-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url,vger.kernel.org:from_smtp,fou_mcast_encap.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91AAB708D0B

Add a selftest to verify that FOU-encapsulated packets addressed to a
multicast destination are correctly resubmitted to the inner protocol
handler (GRE) via the UDP multicast delivery path.  Both IPv4 and IPv6
paths are tested.

The test creates two network namespaces connected by a veth pair with
a FOU/GRETAP (IPv4) and FOU/ip6gretap (IPv6) tunnel using multicast
remote addresses (239.0.0.1 and ff0e::1).  Ping is sent through each
tunnel and received packets are counted on the receiver's tunnel
interface.

The veth pair is created directly inside the namespaces to avoid
possible name collisions with devices in the root namespace.

Static neighbor entries are configured on the sender because ARP/ND
replies from the receiver cannot traverse the unidirectional multicast
tunnel back to the sender.

The early demux optimization (net.ipv4.ip_early_demux, which controls
both IPv4 and IPv6) is disabled on the receiver to force packets
through __udp4_lib_mcast_deliver() / __udp6_lib_mcast_deliver(), which
is the code path being tested.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 177 ++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..7e9ae937cffa 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -39,6 +39,7 @@ TEST_PROGS := \
 	fib_rule_tests.sh \
 	fib_tests.sh \
 	fin_ack_lat.sh \
+	fou_mcast_encap.sh \
 	fq_band_pktlimit.sh \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
new file mode 100755
index 000000000000..728513d55db4
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.sh
@@ -0,0 +1,177 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that UDP encapsulation (FOU) correctly handles packet resubmit
+# when packets are delivered via the multicast UDP delivery path.
+#
+# When a FOU-encapsulated packet arrives with a multicast destination IP,
+# __udp4_lib_mcast_deliver() / __udp6_lib_mcast_deliver() must resubmit
+# it to the inner protocol handler (e.g., GRE) rather than consuming it.
+# This test verifies both IPv4 and IPv6 paths by creating a FOU/GRETAP
+# tunnel with a multicast remote address and sending ping through it.
+#
+# The early demux optimization can mask this issue by routing packets via
+# the unicast path (udp[6]_unicast_rcv_skb), so we disable it to force
+# packets through the multicast delivery function.
+
+source lib.sh
+
+NSENDER=""
+NRECV=""
+
+FOU_PORT4=4797
+FOU_PORT6=4798
+MCAST4=239.0.0.1
+MCAST6=ff0e::1
+
+TUN4_S=192.168.99.1
+TUN4_R=192.168.99.2
+TUN6_S=2001:db8:99::1
+TUN6_R=2001:db8:99::2
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup_common() {
+	setup_ns NSENDER NRECV
+
+	# Create veth pair directly inside namespaces to avoid name
+	# collisions with devices in the root namespace.
+	ip link add veth_s netns "$NSENDER" type veth \
+		peer name veth_r netns "$NRECV"
+
+	ip -n "$NSENDER" link set veth_s up
+	ip -n "$NRECV" link set veth_r up
+
+	# Same sysctl controls early demux for both IPv4 and IPv6.
+	ip netns exec "$NRECV" sysctl -wq net.ipv4.ip_early_demux=0
+}
+
+setup_ipv4() {
+	ip -n "$NSENDER" addr add 10.0.0.1/24 dev veth_s
+	ip -n "$NRECV" addr add 10.0.0.2/24 dev veth_r
+
+	# Join multicast group on receiver
+	ip -n "$NRECV" addr add "$MCAST4/32" dev veth_r autojoin
+
+	ip -n "$NSENDER" route add 239.0.0.0/8 dev veth_s
+	ip -n "$NRECV" route add 239.0.0.0/8 dev veth_r
+
+	# Sender: GRETAP with FOU encap (no FOU listener needed on TX side)
+	ip -n "$NSENDER" link add eoudp4 type gretap \
+		remote "$MCAST4" local 10.0.0.1 \
+		encap fou encap-sport "$FOU_PORT4" encap-dport "$FOU_PORT4" \
+		key "$MCAST4"
+	ip -n "$NSENDER" link set eoudp4 up
+	ip -n "$NSENDER" addr add "$TUN4_S/24" dev eoudp4
+
+	# Receiver: FOU listener + GRETAP
+	ip netns exec "$NRECV" ip fou add port "$FOU_PORT4" ipproto 47
+	ip -n "$NRECV" link add eoudp4 type gretap \
+		remote "$MCAST4" local 10.0.0.2 \
+		encap fou encap-sport "$FOU_PORT4" encap-dport "$FOU_PORT4" \
+		key "$MCAST4"
+	ip -n "$NRECV" link set eoudp4 up
+	ip -n "$NRECV" addr add "$TUN4_R/24" dev eoudp4
+
+	# Static neigh on sender: ARP replies cannot traverse the
+	# unidirectional multicast tunnel.
+	local recv_mac
+	recv_mac=$(ip -n "$NRECV" link show eoudp4 | awk '/ether/{print $2}')
+	ip -n "$NSENDER" neigh add "$TUN4_R" lladdr "$recv_mac" dev eoudp4
+}
+
+setup_ipv6() {
+	# Skip cleanly if IPv6 is not available in the running kernel.
+	[ -e /proc/sys/net/ipv6 ] || return "$ksft_skip"
+	modprobe -q fou6 || return "$ksft_skip"
+
+	ip -n "$NSENDER" addr add 2001:db8::1/64 dev veth_s nodad
+	ip -n "$NRECV" addr add 2001:db8::2/64 dev veth_r nodad
+
+	# Join multicast group on receiver
+	ip -n "$NRECV" addr add "$MCAST6/128" dev veth_r autojoin
+
+	ip -n "$NSENDER" -6 route add ff00::/8 dev veth_s
+	ip -n "$NRECV" -6 route add ff00::/8 dev veth_r
+
+	# Sender: ip6gretap with FOU encap
+	ip -n "$NSENDER" link add eoudp6 type ip6gretap \
+		remote "$MCAST6" local 2001:db8::1 \
+		encap fou encap-sport "$FOU_PORT6" encap-dport "$FOU_PORT6" \
+		key 42
+	ip -n "$NSENDER" link set eoudp6 up
+	ip -n "$NSENDER" addr add "$TUN6_S/64" dev eoudp6 nodad
+
+	# Receiver: FOU listener (IPv6) + ip6gretap
+	ip netns exec "$NRECV" ip fou add port "$FOU_PORT6" ipproto 47 -6
+	ip -n "$NRECV" link add eoudp6 type ip6gretap \
+		remote "$MCAST6" local 2001:db8::2 \
+		encap fou encap-sport "$FOU_PORT6" encap-dport "$FOU_PORT6" \
+		key 42
+	ip -n "$NRECV" link set eoudp6 up
+	ip -n "$NRECV" addr add "$TUN6_R/64" dev eoudp6 nodad
+
+	# Static neigh on sender: neighbor discovery cannot traverse the
+	# unidirectional multicast tunnel.
+	local recv_mac
+	recv_mac=$(ip -n "$NRECV" link show eoudp6 | awk '/ether/{print $2}')
+	ip -n "$NSENDER" neigh add "$TUN6_R" lladdr "$recv_mac" dev eoudp6
+}
+
+get_rx_packets() {
+	local dev="$1"
+
+	ip -n "$NRECV" -s link show "$dev" | awk '/RX:/{getline; print $2}'
+}
+
+run_ping_test() {
+	local family="$1"
+	local dev="$2"
+	local dst="$3"
+	local count=100
+	local rx_before rx_after rx_delta
+
+	# Warmup: let any initial broadcast/ND traffic settle
+	ip netns exec "$NSENDER" ping "$family" -c 1 -W 1 "$dst" \
+		>/dev/null 2>&1
+	sleep 1
+
+	rx_before=$(get_rx_packets "$dev")
+	ip netns exec "$NSENDER" ping "$family" -c $count -W 1 "$dst" \
+		>/dev/null 2>&1
+	sleep 1
+	rx_after=$(get_rx_packets "$dev")
+
+	rx_delta=$((rx_after - rx_before))
+
+	if [ "$rx_delta" -ge "$count" ]; then
+		echo "PASS: received $rx_delta/$count packets"
+		return "$ksft_pass"
+	elif [ "$rx_delta" -gt 0 ]; then
+		echo "FAIL: only $rx_delta/$count packets received"
+		return "$ksft_fail"
+	else
+		echo "FAIL: 0/$count packets received"
+		return "$ksft_fail"
+	fi
+}
+
+ret=0
+
+echo "TEST: FOU/GRETAP IPv4 multicast encapsulation resubmit"
+setup_common
+setup_ipv4
+run_ping_test -4 eoudp4 "$TUN4_R" || ret=$?
+
+echo "TEST: FOU/GRETAP IPv6 multicast encapsulation resubmit"
+if setup_ipv6; then
+	run_ping_test -6 eoudp6 "$TUN6_R" || ret=$?
+else
+	echo "SKIP: IPv6 unavailable"
+fi
+
+exit $ret
-- 
2.47.3


