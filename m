Return-Path: <netdev+bounces-303891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJeuBJCeRWoXDAsAu9opvQ
	(envelope-from <netdev+bounces-303891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:11:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD296F2399
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:11:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Dtw9qJwM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303891-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303891-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55287300C3B5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6793C4B86;
	Wed,  1 Jul 2026 23:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8939A7F6
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947465; cv=none; b=bvQHQh7Y0pHlu20S1sb+hhIxlIgbk6sMB+PVzoR3GdcRR7gQdGWqPmJ6CZ6Lon28y/9h4thZhPHW2rrCliXcHhiwtMeqVGB+RxTe/CTOs1m73fk8TwDLu5noTJkQEt02fjhT5gmTdP7hMXg1DgbiK88+866j0k9bxyhVR7HZ7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947465; c=relaxed/simple;
	bh=aXRM6rleMtmqAGpHOgyjB5R1SPGt0HQzOmTZSePQYyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxoJU4rCozjmiFkkCwvz/o+z6+cGmqjKnt5fsi8NyklbqtSH+gIO/r7L4s99ctlzrHmE46KNTMo5KjT0fvDc0tziCIynsHK28IWYUJaIXz72lUjaAq1oYJtDHRyCsBxk9+JTwEwiSBxvNsrSqf4UQe4+bcGaaO+yI129HfYTO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtw9qJwM; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c126b8118afso178893666b.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947463; x=1783552263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vd217j9BX8Lq/p1KnSze+ojMBVOwOcfGoPl0hFkSxs=;
        b=Dtw9qJwM77WF3+YZvu9pq1f46h+8kdE0rrD8is4mFTaMzSzFaO6SHfe2XKAAfQau+u
         UPidPhXCkwfr96GcRvbK6sHAHo3Vx5QX0rH4KnbpNcMmxBhLJpW8wUlJOgkcaM5Uxvl/
         OGE+V1wc3V3oB4Ns6nPHKWtq986rFYEPl5Y9VQNISt9gpvjGU4RlM2MORP5Dgl1SIi7/
         r6kpaLwfo2QI7np/9bgN/D6ZBnftc2Cn4ozcEaQ2tDofkvqHS8UQSk5weRtqhXRNzsN6
         c2BCu5pYqNMgf14rQAhvS7m/makxy4/cslB7VSKPbA3Nw6NrZDC0G6whoUdsdI6E54kl
         /CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947463; x=1783552263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Vd217j9BX8Lq/p1KnSze+ojMBVOwOcfGoPl0hFkSxs=;
        b=mmvRBpuxVhbB8SP5JuAFVSsDN4qjSXeZ0XzuOGxoigDiDCspgnS/hYt5mQtlz1Jyjm
         iZQd5dCgwarpPtQ2rTJucs5Q6o89ots7uscHO+Bq6dMyPinRblBQs1dJsmi29WXzHRjf
         YrsW/Dr18XQ0emkfZ0EJ7DvV7ZGEOXaU2ijR+xOVmhI5g7z/nN5zd6eQ1AjHmNbuDwa2
         JZCL4yxXnV6D6tdCrGoLTsY8c5TPb45OqbJAdBBjgKOb2WNOejNrhiLnJsSpPNVvvZQ3
         Qk+VZIMjWoQfQyc+JXwyFU9gPJeA90XZaXbWVKzMTkJHu6p6Mld9MSho2eYkOMUOsxVq
         RkMA==
X-Gm-Message-State: AOJu0Yxsat8UpQYFVaclsPL7fmdTWv3FqdgaKAKjFhYqcfQrBxjIPXjH
	jfXTDFC8FFo96TZNIOYiyPz5vRJCgl55lOnSrqfeScHRR9NU8j8jO5Ask7/ZVhov1mQ=
X-Gm-Gg: AfdE7clNbyNGCq+linajrj9fqtSBB/EldbnGD9IJJUnZMKGjcHGvd5hQkJkxm8zBpAd
	5QEZ0yowzYDKWUL51vuoFVrS7NRs/m0vwQ6ll4ZxG3le0tX7gB8bKNuNRb3b/qPAH8mwQQANp0I
	oGPLETtJlZN+OoPGKHqQNMzxbLolmts5r+9NgXivUG1GSvJSUhKg6pij5QRasjS0BVW+VLPhFbJ
	D4Yq5kfJI+a36k81/6OFm3gUPKOchXqOATqu/YeqKlWDCrAWQO3+hRDbgZo0sRUrRBJZWR9tgZd
	x/5sN6qtva9fsVjcG1iVXjRq1B6/q3+sgiJ5PbPLf60CIkMCyecYj8BWSWe/LWGfFrCIV3oHYkC
	qFyy+1Imd6aji/qEsteuIgGqq5KuRBRf6uWvc1QEv79Zs68c+wDXwhdg/fHfH93i8O4viUxHHSS
	lfm4Q/ufO7fIxoyZW769i83sj17BlBLoNUj/YJADAjdbWw2s3JYJCbR9ksBQHPzEtwrh/VOrHfS
	5dWkg==
X-Received: by 2002:a17:906:515:b0:c12:acd3:bde9 with SMTP id a640c23a62f3a-c12ae7e94demr109519266b.45.1782947462673;
        Wed, 01 Jul 2026 16:11:02 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b629a1d4sm30663466b.39.2026.07.01.16.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:11:02 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/2] selftests: net: add FOU multicast encapsulation resubmit test
Date: Thu,  2 Jul 2026 02:10:37 +0300
Message-ID: <a196b53a2829da66c982f88e82805afc498ea13b.1782945956.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782945956.git.littlesmilingcloud@gmail.com>
References: <cover.1782945956.git.littlesmilingcloud@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303891-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fou_mcast_encap.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FD296F2399

Add a selftest to verify that FOU-encapsulated packets addressed to a
multicast destination are correctly resubmitted to the inner protocol
handler (GRE) via the UDP multicast delivery path.

The test creates two network namespaces connected by a veth pair with
a FOU/GRETAP tunnel using a multicast remote address (239.0.0.1).
Ping is sent through the tunnel and received packets are counted on
the receiver's tunnel interface.

A static neighbor entry is configured on the sender because ARP
replies from the receiver cannot traverse the unidirectional multicast
tunnel back to the sender.

The early demux optimization (net.ipv4.ip_early_demux) is disabled on
the receiver to force packets through __udp4_lib_mcast_deliver(),
which is the code path being tested.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
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
index 000000000000..8db9633f4c28
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that UDP encapsulation (FOU) correctly handles packet resubmit
+# when packets are delivered via the multicast UDP delivery path.
+#
+# When a FOU-encapsulated packet arrives with a multicast destination IP,
+# __udp4_lib_mcast_deliver() must resubmit it to the inner protocol
+# handler (e.g., GRE) rather than consuming it. This test verifies that
+# by creating a FOU/GRETAP tunnel with a multicast remote address and
+# sending ping through it.
+#
+# The early demux optimization can mask this issue by routing packets via
+# the unicast path (udp_unicast_rcv_skb), so we disable it to force
+# packets through __udp4_lib_mcast_deliver().
+
+source lib.sh
+
+NSENDER=""
+NRECV=""
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup() {
+	setup_ns NSENDER NRECV
+
+	ip link add veth_s type veth peer name veth_r
+	ip link set veth_s netns "$NSENDER"
+	ip link set veth_r netns "$NRECV"
+
+	ip -n "$NSENDER" addr add 10.0.0.1/24 dev veth_s
+	ip -n "$NSENDER" link set veth_s up
+
+	ip -n "$NRECV" addr add 10.0.0.2/24 dev veth_r
+	ip -n "$NRECV" link set veth_r up
+
+	# Disable early demux to force multicast delivery path
+	ip netns exec "$NRECV" sysctl -wq net.ipv4.ip_early_demux=0
+
+	# Join multicast group on receiver
+	ip -n "$NRECV" addr add 239.0.0.1/32 dev veth_r autojoin
+
+	# Multicast routes
+	ip -n "$NRECV" route add 239.0.0.0/8 dev veth_r
+	ip -n "$NSENDER" route add 239.0.0.0/8 dev veth_s
+
+	# Sender: GRETAP with FOU encap (no FOU listener needed on TX side)
+	ip -n "$NSENDER" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.1 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NSENDER" link set eoudp0 up
+	ip -n "$NSENDER" addr add 192.168.99.1/24 dev eoudp0
+
+	# Receiver: FOU listener + GRETAP
+	ip netns exec "$NRECV" ip fou add port 4797 ipproto 47
+	ip -n "$NRECV" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.2 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NRECV" link set eoudp0 up
+	ip -n "$NRECV" addr add 192.168.99.2/24 dev eoudp0
+
+	# Static neigh entry on sender: ARP replies cannot traverse the
+	# multicast tunnel back, so pre-populate the neighbor cache.
+	local recv_mac
+	recv_mac=$(ip -n "$NRECV" link show eoudp0 | awk '/ether/{print $2}')
+	ip -n "$NSENDER" neigh add 192.168.99.2 lladdr "$recv_mac" dev eoudp0
+}
+
+get_rx_packets() {
+	ip -n "$NRECV" -s link show eoudp0 | awk '/RX:/{getline; print $2}'
+}
+
+test_fou_mcast_encap() {
+	local count=100
+	local rx_before
+	local rx_after
+	local rx_delta
+
+	# Warmup: let any initial broadcast/ARP traffic settle
+	ip netns exec "$NSENDER" ping -c 1 -W 1 192.168.99.2 >/dev/null 2>&1
+	sleep 1
+
+	rx_before=$(get_rx_packets)
+	ip netns exec "$NSENDER" ping -c $count -W 1 192.168.99.2 >/dev/null 2>&1
+	sleep 1
+	rx_after=$(get_rx_packets)
+
+	rx_delta=$((rx_after - rx_before))
+
+	if [ "$rx_delta" -ge "$count" ]; then
+		echo "PASS: received $rx_delta/$count packets via multicast FOU/GRETAP"
+		return "$ksft_pass"
+	elif [ "$rx_delta" -gt 0 ]; then
+		echo "FAIL: only $rx_delta/$count packets received (partial delivery)"
+		return "$ksft_fail"
+	else
+		echo "FAIL: 0/$count packets received (multicast encap resubmit broken)"
+		return "$ksft_fail"
+	fi
+}
+
+echo "TEST: FOU/GRETAP multicast encapsulation resubmit"
+
+setup
+test_fou_mcast_encap
+exit $?
-- 
2.47.3


