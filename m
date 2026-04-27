Return-Path: <netdev+bounces-281523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMtwIJDm72lPHgEAu9opvQ
	(envelope-from <netdev+bounces-281523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168A47B947
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37748300DEFE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB03ACEF9;
	Mon, 27 Apr 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvLygrDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D433ACF13
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329802; cv=none; b=fxpFNcVgZjFa5vXXHDZWhImCzH+z48WzgyUXItWd36ujGWEs52i9VMVm7fQpzSzXqlhtNJGOV1UfIqSv3r8ZePW8DJM4pGdJL2p09K7l9P2J+huBp27LEs2/wLo8lg7Ik8LzC1wvT/rZGmRUVZl2iHb20z0bYEa5is+MLPO4JWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329802; c=relaxed/simple;
	bh=kqmc8mutZhVPL0g0yhueYVg9Bp3rQcwZ+kTbpSu4xNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=REvltrE12eXDcRPXDBpyFr9ncm0INg6TGqZmAkBDvCGqsew9bpW12kAitE0JGsNy9hFIdu0KoRLre8tNNMT5YWXJZzb9MsXmWtpz5WkAIMQxy1uL1Ln9s8EscCjoal9jOmJRznXN5YeQkTcwvmC8ZWNE1SYcJFOzNB3hfIqyqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvLygrDM; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eb52a22e85so1974731285a.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777329800; x=1777934600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u98KK5H868BOVi1FEwd/gnua8NTHfXkj+waNRa1neWw=;
        b=qvLygrDMCXQS/p9a4qeH8zzO+Ps8GduU67CbDlnfoswqmehBdHCym0iQwrou0akxXQ
         PsohNlvaRBEamRRdzj8P2phdBt+bBpMxpN3qVljSYEe2aBNq6dtkISrOKmUbygip+q8R
         AZWOewGKx4NgwdOosMX9lv5Qy9fc0kNXI7k0SWsLHZtOX63fS0nPWGi6I8Y3VwbPumx9
         8zYk9MMrSgU8QPEB/t7YJqGZ27QRIrBLI+Z7wq6SXl6Nc0T7HbymRHIcu1cNhr8aN6s7
         Baj5WXJqhpZy4kmbpf9ikKA7/t9MJRAP/W/JwmUEUBuLxfiPGUwvPkUGAbIdm2CWJrSc
         G4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777329800; x=1777934600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u98KK5H868BOVi1FEwd/gnua8NTHfXkj+waNRa1neWw=;
        b=M1EcTt6cCwTGO0x2SR60N3CFGeYFfWFmwwKtiAix73pRrcbzIQtTOVry7Ta+qbB0wK
         topQyIn7M3wi6PtmW5j4qnmV1n6W1ICveoyQII60ZDQ0i7qlFnhN/atUOK6591h3m9S1
         z/xJJZUnwLLyJlVeYJNW3P0WVgQFnYgvMG5rL7LwyLXfC1KYVmCCL7Ku51Z34pOLeAro
         SSFcBvKN9bRhIrBTkmWroRcG1wywJ6ahvnLlt4AcvyjhLJvs1PrjeDA1Z1jpWBlRTK6H
         Lp4BVOpbiriBYZi2E4T5ksVoNsLjnDX5VJAIIjoCNKqN0mELAraKnEh4SXeLP/P8jOi+
         n7JA==
X-Forwarded-Encrypted: i=1; AFNElJ9NIv6q4cDsTPgjR1ymQRZuH6/tKE5nsAaOQ9s0dZCueCYfEO0eoJRmsIApW6CwIpqJfccVIPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHn6bq81x2Pb8gEAfcxVWdeGjSDkurUwhhzb/sRVSOfh+591Q
	DvE3g8o2EDzUXPbza1oMVoNJs55ck1+Y32cyZbkUGOnLlZd7dphgXlU7Z8KgrG2K2EMteThHHeH
	dSeSTAcbVw6VSE9wc61V9vUkul1Gy1lwGYKWaAw==
X-Received: from qkkh6.prod.google.com ([2002:a05:620a:10a6:b0:8d4:b5d7:384d])
 (user=sharmasagarika job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4049:b0:8ee:4901:70c9 with SMTP id af79cd13be357-8f7d9901400mr87616885a.44.1777329800095;
 Mon, 27 Apr 2026 15:43:20 -0700 (PDT)
Date: Mon, 27 Apr 2026 22:42:23 +0000
In-Reply-To: <20260427224243.3499162-1-sharmasagarika@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427224243.3499162-1-sharmasagarika@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427224243.3499162-3-sharmasagarika@google.com>
Subject: [PATCH net v1 2/2] selftest: net: Add test for TCP flow failover with
 ECMP routes.
From: Sagarika Sharma <sharmasagarika@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sagarika Sharma <sharmasagarika@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5168A47B947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281523-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sharmasagarika@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tcp_ecmp_failover.sh:url]

From: Kuniyuki Iwashima <kuniyu@google.com>

Without the previous commit, TCP failed to switch to alternative
IPv6 routes immediately upon carrier loss.

It would persist with the dead route until reaching the threshold
net.ipv4.tcp_retries1, leading to unnecessary delays in failover.

Let's add a selftest for this scenario to ensure TCP fails over
immediately upon a carrier loss event.

Before:
  TEST: TCP IPv4 failover                                             [ OK ]
  TEST: TCP IPv6 failover                                             [FAIL]

After:
  TEST: TCP IPv4 failover                                             [ OK ]
  TEST: TCP IPv6 failover                                             [ OK ]

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Sagarika Sharma <sharmasagarika@google.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/tcp_ecmp_failover.sh        | 209 ++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100755 tools/testing/selftests/net/tcp_ecmp_failover.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..f3da38c54d27 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -96,6 +96,7 @@ TEST_PROGS := \
 	srv6_hl2encap_red_l2vpn_test.sh \
 	srv6_iptunnel_cache.sh \
 	stress_reuseport_listen.sh \
+	tcp_ecmp_failover.sh \
 	tcp_fastopen_backup_key.sh \
 	test_bpf.sh \
 	test_bridge_backup_port.sh \
diff --git a/tools/testing/selftests/net/tcp_ecmp_failover.sh b/tools/testing/selftests/net/tcp_ecmp_failover.sh
new file mode 100755
index 000000000000..f857d5db84d8
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ecmp_failover.sh
@@ -0,0 +1,209 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2026 Google LLC.
+#
+# This test verifies TCP flow failover between ECMP routes
+# upon carrier loss on the active device.
+#
+#   socat  ----------------------------->  socat
+#                        |
+#           .-- veth-c1 -|- veth-s1 --.
+#   dummy0 -|            |            |-- dummy0
+#           '-- veth-c2 -|- veth-s2 --'
+#                        |
+#
+
+REQUIRE_JQ=no
+REQUIRE_MZ=no
+NUM_NETIFS=0
+
+source forwarding/lib.sh
+
+CLIENT_IP="10.0.59.1"
+SERVER_IP="10.0.92.1"
+CLIENT_IP6="2001:db8:5a9a::1"
+SERVER_IP6="2001:db8:9292::1"
+
+setup_server()
+{
+	IP="ip -n $server"
+	NS_EXEC="ip netns exec $server"
+
+	$IP link add dummy0 type dummy
+	$IP link set dummy0 up
+
+	$IP -4 addr add $SERVER_IP/32 dev dummy0
+	$IP -6 addr add $SERVER_IP6/128 dev dummy0 nodad
+
+	$IP link set veth-s1 up
+	$IP link set veth-s2 up
+
+	$IP -4 addr add 192.168.1.2/24 dev veth-s1
+	$IP -4 addr add 192.168.2.2/24 dev veth-s2
+
+	$IP -4 route add $CLIENT_IP/32 \
+		nexthop via 192.168.1.1 dev veth-s1 weight 1 \
+		nexthop via 192.168.2.1 dev veth-s2 weight 1
+
+	$IP -6 addr add 2001:db8:1::2/64 dev veth-s1 nodad
+	$IP -6 addr add 2001:db8:2::2/64 dev veth-s2 nodad
+
+	$IP -6 route add $CLIENT_IP6/128 \
+		nexthop via 2001:db8:1::1 dev veth-s1 weight 1 \
+		nexthop via 2001:db8:2::1 dev veth-s2 weight 1
+}
+
+setup_client()
+{
+	IP="ip -n $client"
+	NS_EXEC="ip netns exec $client"
+
+	$IP link add dummy0 type dummy
+	$IP link set dummy0 up
+
+	$IP -4 addr add $CLIENT_IP/32 dev dummy0
+	$IP -6 addr add $CLIENT_IP6/128 dev dummy0 nodad
+
+	$IP link set veth-c1 up
+	$IP link set veth-c2 up
+
+	$IP -4 addr add 192.168.1.1/24 dev veth-c1
+	$IP -4 addr add 192.168.2.1/24 dev veth-c2
+
+	$IP -4 route add $SERVER_IP/32 \
+		nexthop via 192.168.1.2 dev veth-c1 weight 1 \
+		nexthop via 192.168.2.2 dev veth-c2 weight 1
+
+	$IP -6 addr add 2001:db8:1::1/64 dev veth-c1 nodad
+	$IP -6 addr add 2001:db8:2::1/64 dev veth-c2 nodad
+
+	$IP -6 route add $SERVER_IP6/128 \
+		nexthop via 2001:db8:1::2 dev veth-c1 weight 1 \
+		nexthop via 2001:db8:2::2 dev veth-c2 weight 1
+
+	# By default, tcp_retries1=3 triggers a route refresh
+	# after 3 retransmits (~5s).  Ensure this never occurs
+	# for test stability.
+	$NS_EXEC sysctl -qw net.ipv4.tcp_retries1=100
+
+	# When NETDEV_CHANGE is issued for a dev tied to an ECMP
+	# route, RTNH_F_LINKDOWN is flagged and the sernum is
+	# bumped to invalidate the route via sk_dst_check().
+	#
+	# Without ignore_routes_with_linkdown=1, subsequent
+	# lookups may still select the same RTNH_F_LINKDOWN route.
+	$NS_EXEC sysctl -qw net.ipv4.conf.veth-c1.ignore_routes_with_linkdown=1
+	$NS_EXEC sysctl -qw net.ipv4.conf.veth-c2.ignore_routes_with_linkdown=1
+
+	$NS_EXEC sysctl -qw net.ipv6.conf.veth-c1.ignore_routes_with_linkdown=1
+	$NS_EXEC sysctl -qw net.ipv6.conf.veth-c2.ignore_routes_with_linkdown=1
+}
+
+setup()
+{
+	setup_ns client server
+
+	ip -n $client link add veth-c1 type veth peer veth-s1 netns $server
+	ip -n $client link add veth-c2 type veth peer veth-s2 netns $server
+
+	setup_server
+	setup_client
+}
+
+cleanup()
+{
+	cleanup_all_ns
+}
+
+tcp_ecmp_failover()
+{
+	local pf=$1; shift
+	local server_ip=$1; shift
+	local client_ip=$1; shift
+
+	RET=0
+
+	tcpdump_start veth-s1 $server
+	tcpdump_start veth-s2 $server
+
+	ip netns exec $server \
+		socat -u TCP-LISTEN:8080,pf=$pf,bind=$server_ip,reuseaddr /dev/null &
+	server_pid=$!
+
+	# Wait for server to start listening.
+	# Sometimes client fails without this sleep.
+	sleep 1
+
+	ip netns exec $client \
+		socat -u /dev/zero TCP:$server_ip:8080,pf=$pf,bind=$client_ip &
+	client_pid=$!
+
+	# To capture enough packets.
+	sleep 3
+
+	tcpdump_stop veth-s1
+	tcpdump_stop veth-s2
+
+	pkts_s1=$(tcpdump_show veth-s1 | wc -l)
+	pkts_s2=$(tcpdump_show veth-s2 | wc -l)
+
+	tcpdump_cleanup veth-s1
+	tcpdump_cleanup veth-s2
+
+	# Detect the device chosen by the client
+	if [ $pkts_s1 -gt $pkts_s2 ]; then
+		veth_down=veth-s1
+		veth_up=veth-s2
+	else
+		veth_down=veth-s2
+		veth_up=veth-s1
+	fi
+
+	# Taking down $veth_down causes its peer to lose carrier,
+	# triggering NETDEV_CHANGE.  This flags RTNH_F_LINKDOWN
+	# and bumps the sernum for the route associated with that
+	# peer, invalidating the cached dst in the TCP socket.
+	#
+	# Consequently, sk_dst_check() fails, forcing the subsequent
+	# lookup to select the remaining healthy route via $veth_up.
+	ip -n $server link set $veth_down down
+
+	tcpdump_start $veth_up $server
+
+	# To capture enough packets.
+	sleep  3
+
+	tcpdump_stop $veth_up
+
+	kill -9 $client_pid 2>&1 > /dev/null
+	kill -9 $server_pid 2>&1 > /dev/null
+	wait 2> /dev/null
+
+	pkts=$(tcpdump_show $veth_up | wc -l)
+
+	tcpdump_cleanup $veth_up
+
+	if [ $pkts -lt 10000 ]; then
+		RET=$ksft_fail
+	fi
+}
+
+test_ipv4()
+{
+	setup
+	tcp_ecmp_failover IPv4 $SERVER_IP $CLIENT_IP
+	log_test "TCP IPv4 failover"
+	cleanup
+}
+
+test_ipv6()
+{
+	setup
+	tcp_ecmp_failover IPv6 "[$SERVER_IP6]" "[$CLIENT_IP6]"
+	log_test "TCP IPv6 failover"
+	cleanup
+}
+
+test_ipv4
+test_ipv6
-- 
2.54.0.545.g6539524ca2-goog


