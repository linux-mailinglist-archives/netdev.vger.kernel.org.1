Return-Path: <netdev+bounces-185599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D1A9B11E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990C34A7526
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9469199931;
	Thu, 24 Apr 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZD2IPud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF817A2FB
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505358; cv=none; b=G1g8RrBB8zNiPBhBcbN5HkZ52bGhGVjgxDYdLAesREEGC+nj747moX83Z94ZWfvkjU2A1AlYzSpW0DJuaLSR60CLGnsrklu0uiml0I3bx1FENRZI3Q4tsbl5/DuidiAyZso1FzpY80G6fIKRhR4W7ogicV6hvvYGPE8SqTWaA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505358; c=relaxed/simple;
	bh=jq/7R37yUQdRX9lUJMr7jmYFYoF6+Jw44zlM0KdyHJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3PKK79oX85jdyDdObC1l+ffAwsHJBZd8BJuP8SnoooQOzbNu8+lx8W6WGGhH76iPtlK4XahGqrLOqOg3lG6PLxiXRjAzZxXdQacDIL0J/d9TAfuVgiu999nvMIwt2KqGVBhbyyzQsySx6XMwsZAtaJV3HqdG9QZgQwPpJSJ5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZD2IPud; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c9376c4dbaso122123685a.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505356; x=1746110156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20LD1z2sc/F9inUOU0yQ3QkUOGfPbN8R9VxadbMPGtc=;
        b=nZD2IPudIc7CifQZPSpfiCVi89yRWJycWt0zxx/Fwyhj3dJh1ngqNE3Igwj3t9MGpi
         Ei4EE11fQM73fSvhP3Jd/T8RI5hLdDoXPITiMma9J+2fuu3OzBwfSmBlBFfhY9WIc5Nd
         O7Fe1JY/UYX0dOz46488QTlDPw913PCp9XqhASDlUbUdlNU7xbawXbv62+9RJoeM2a5A
         2vscMR58ppyQzI76xDVLWghVUaTPGwBJulTwwGXrFQmBMx68DaL7HYrvDeYaNDbzOhz8
         EIcd8K0vZi5jSCduPQaBBMvpDYjDiWTHv3UaJwaJRbAZb+t+QpdP1BToeZ8IG4acP+Hd
         LF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505356; x=1746110156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20LD1z2sc/F9inUOU0yQ3QkUOGfPbN8R9VxadbMPGtc=;
        b=rq3UmdFuajavyz9CI2rn3oJJcvT8DFcShCQihs3LPHJ4WO4zHgno8uJQEtJOEr5L1f
         drcIqFbyUCFJl3I6/RziD/25j8P4LmxICsLRyxYl+cQy9MEikqSqENfVCcOoKtO6EPYS
         +sbk5qL6EwXqZkK1MMP1mp5aRRrAO5of1CKK7jPV5mAdTJTTc8F2pk7gZrAHy7DFp9AZ
         xUkoXph08Ur+AXjgpV69BbFUqQbmLqOzx7vuMuf3/d+WMNEqeSeIBmqFSbfiyCtYYFM2
         FDfD7XkdLjdcMbhPlPpnUBNwsn7ipPwTQkc/NHO7Wld0awSOJYSUw4hd3VUs5W7J9/QW
         MiGQ==
X-Gm-Message-State: AOJu0YzfiMBCRSDe+jGUAW2XOS2Y8QRQXErLlHGY1CFZajrSuzS9IOTR
	8zVKF0HL7pQ/dbRrCtjWshVLYfLMC/hQdYutykSWkF3Q4Zp59A/pisxSnw==
X-Gm-Gg: ASbGncsvHZ+D5NWxxhINCVVQ8LBnINiAgAXifg8q6RfLraR5VfkfVcHwrE2Op/9KZO0
	/WEqYqX4i5Sne38C2wObGAfnQG9ZgyrenrPo/AVlsJ3v9qTC+/NqrLt0iiPO8r6nIDLLUWsmwII
	JPozAha4PiqB62SSzIFi+6o6bxKyWPSXcl+FmD1fBwjoGkm+SmXDjbA5+uBGu1uSBuHJEaefaSl
	5JT6h+4eD/WfshyfeuHkN1vilI+AUNrWYDhVF7d2+OWnSzFrXD4cS9DyZfLho5ZwOnLJ6CnAKKW
	kPn/Ep9boCbJ85c35rpRD3jyIwbd3OV454CJfLenhqW8gIyz6xW0+5TP717xa1sjBstt8cAjAoY
	Qzodos+zpNznDzR1yXmJCXIEk3wlXEiHLJ3+3ie7AxxHrj4C5vlHDaA==
X-Google-Smtp-Source: AGHT+IGd3tUst4DxvOTTeEI56y4yk9aizlO/s+pHrKzqnyYxA5sfE9gmqY9JXuEPl9ECjJOuUoCzZw==
X-Received: by 2002:a05:620a:8192:b0:7c5:95b6:b40a with SMTP id af79cd13be357-7c95862c737mr323127185a.27.1745505355561;
        Thu, 24 Apr 2025 07:35:55 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c91a8dsm94743985a.1.2025.04.24.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:35:54 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/3] selftests/net: test tcp connection load balancing
Date: Thu, 24 Apr 2025 10:35:20 -0400
Message-ID: <20250424143549.669426-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Verify that TCP connections use both routes when connecting multiple
times to a remote service over a two nexthop multipath route.

Use socat to create the connections. Use tc prio + tc filter to
count routes taken, counting SYN packets across the two egress
devices. Also verify that the saddr matches that of the device.

To avoid flaky tests when testing inherently randomized behavior,
set a low bar and pass if even a single SYN is observed on each
device.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - match also on saddr, not only SYN
  - move from fib_nexthops.sh to fib_tests.sh
      - move generic "count packets on dev" to lib.sh
  - switch from netcat to socat, as different netcats go around
---
 tools/testing/selftests/net/fib_tests.sh | 120 ++++++++++++++++++++++-
 tools/testing/selftests/net/lib.sh       |  24 +++++
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 3ea6f886a210..c58dc4ac2810 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -11,7 +11,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
-       ipv4_mpath_list ipv6_mpath_list"
+       ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1085,6 +1085,35 @@ route_setup()
 	set +e
 }
 
+forwarding_cleanup()
+{
+	cleanup_ns $ns3
+
+	route_cleanup
+}
+
+# extend route_setup with an ns3 reachable through ns2 over both devices
+forwarding_setup()
+{
+	forwarding_cleanup
+
+	route_setup
+
+	setup_ns ns3
+
+	ip link add veth5 netns $ns3 type veth peer name veth6 netns $ns2
+	ip -netns $ns3 link set veth5 up
+	ip -netns $ns2 link set veth6 up
+
+	ip -netns $ns3 -4 addr add dev veth5 172.16.105.1/24
+	ip -netns $ns2 -4 addr add dev veth6 172.16.105.2/24
+	ip -netns $ns3 -4 route add 172.16.100.0/22 via 172.16.105.2
+
+	ip -netns $ns3 -6 addr add dev veth5 2001:db8:105::1/64 nodad
+	ip -netns $ns2 -6 addr add dev veth6 2001:db8:105::2/64 nodad
+	ip -netns $ns3 -6 route add 2001:db8:101::/33 via 2001:db8:105::2
+}
+
 # assumption is that basic add of a single path route works
 # otherwise just adding an address on an interface is broken
 ipv6_rt_add()
@@ -2600,6 +2629,93 @@ ipv6_mpath_list_test()
 	route_cleanup
 }
 
+tc_set_flower_counter__saddr_syn() {
+	tc_set_flower_counter $1 $2 $3 "src_ip $4 ip_proto tcp tcp_flags 0x2"
+}
+
+ip_mpath_balance_dep_check()
+{
+	if [ ! -x "$(command -v socat)" ]; then
+		echo "socat command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v jq)" ]; then
+		echo "jq command not found. Skipping test"
+		return 1
+	fi
+}
+
+ip_mpath_balance() {
+	local -r ipver=$1
+	local -r daddr=$2
+	local -r num_conn=20
+
+	for i in $(seq 1 $num_conn); do
+		ip netns exec $ns3 socat $ipver TCP-LISTEN:8000 STDIO >/dev/null &
+		sleep 0.02
+		echo -n a | ip netns exec $ns1 socat $ipver STDIO TCP:$daddr:8000
+	done
+
+	local -r syn0="$(tc_get_flower_counter $ns1 veth1)"
+	local -r syn1="$(tc_get_flower_counter $ns1 veth3)"
+	local -r syns=$((syn0+syn1))
+
+	[ "$VERBOSE" = "1" ] && echo "multipath: syns seen: ($syn0,$syn1)"
+
+	[[ $syns -ge $num_conn ]] && [[ $syn0 -gt 0 ]] && [[ $syn1 -gt 0 ]]
+}
+
+ipv4_mpath_balance_test()
+{
+	echo
+	echo "IPv4 multipath load balance test"
+
+	ip_mpath_balance_dep_check || return 1
+	forwarding_setup
+
+	$IP route add 172.16.105.1 \
+		nexthop via 172.16.101.2 \
+		nexthop via 172.16.103.2
+
+	ip netns exec $ns1 \
+		sysctl -q -w net.ipv4.fib_multipath_hash_policy=1
+
+	tc_set_flower_counter__saddr_syn $ns1 4 veth1 172.16.101.1
+	tc_set_flower_counter__saddr_syn $ns1 4 veth3 172.16.103.1
+
+	ip_mpath_balance -4 172.16.105.1
+
+	log_test $? 0 "IPv4 multipath loadbalance"
+
+	forwarding_cleanup
+}
+
+ipv6_mpath_balance_test()
+{
+	echo
+	echo "IPv6 multipath load balance test"
+
+	ip_mpath_balance_dep_check || return 1
+	forwarding_setup
+
+	$IP route add 2001:db8:105::1\
+		nexthop via 2001:db8:101::2 \
+		nexthop via 2001:db8:103::2
+
+	ip netns exec $ns1 \
+		sysctl -q -w net.ipv6.fib_multipath_hash_policy=1
+
+	tc_set_flower_counter__saddr_syn $ns1 6 veth1 2001:db8:101::1
+	tc_set_flower_counter__saddr_syn $ns1 6 veth3 2001:db8:103::1
+
+	ip_mpath_balance -6 "[2001:db8:105::1]"
+
+	log_test $? 0 "IPv6 multipath loadbalance"
+
+	forwarding_cleanup
+}
+
 ################################################################################
 # usage
 
@@ -2683,6 +2799,8 @@ do
 	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
 	ipv4_mpath_list)		ipv4_mpath_list_test;;
 	ipv6_mpath_list)		ipv6_mpath_list_test;;
+	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
+	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 701905eeff66..7e1e56318625 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -270,6 +270,30 @@ tc_rule_handle_stats_get()
 		  .options.actions[0].stats$selector"
 }
 
+# attach a qdisc with two children match/no-match and a flower filter to match
+tc_set_flower_counter() {
+	local -r ns=$1
+	local -r ipver=$2
+	local -r dev=$3
+	local -r flower_expr=$4
+
+	tc -n $ns qdisc add dev $dev root handle 1: prio bands 2 \
+			priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+
+	tc -n $ns qdisc add dev $dev parent 1:1 handle 11: pfifo
+	tc -n $ns qdisc add dev $dev parent 1:2 handle 12: pfifo
+
+	tc -n $ns filter add dev $dev parent 1: protocol ipv$ipver \
+			flower $flower_expr classid 1:2
+}
+
+tc_get_flower_counter() {
+	local -r ns=$1
+	local -r dev=$2
+
+	tc -n $ns -j -s qdisc show dev $dev handle 12: | jq .[0].packets
+}
+
 ret_set_ksft_status()
 {
 	local ksft_status=$1; shift
-- 
2.49.0.805.g082f7c87e0-goog


