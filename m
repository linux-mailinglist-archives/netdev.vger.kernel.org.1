Return-Path: <netdev+bounces-184308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E5A948B0
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950AB3AC7B1
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4820D503;
	Sun, 20 Apr 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHl7Iavn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330720C46B
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172347; cv=none; b=Z2qIVbOP9hrnz32vtkHtnujqJMTBnjjIV0OVX9/vig9aU0/LZ+WonlI6RkljY2d2lm91yEXTAuvqPNgWsW/H+8VBSBw8ZrYpOkmyif6SDFQtSUHWDmy3UD8XM5153Ljnlu4YEdXpkBCC+6ZCo0mnNG0Am+QBv3QXQLC1CpV91Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172347; c=relaxed/simple;
	bh=pn0RZdwoJk9knX3blmXvJPrsxAN3rsZznqSFrTi7gRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7ynci7BbPZA7TwmpS/pVf26/v62iaS4J7LzAlD0Jv9wMx3iBiqNulODXsoWOMY1wBGEykvJCMu4Y/mqkfAHQpnOv4yG8d0133X9RR5D/cvZ7/r9KQ3DpFryuans6VMiHJaL6Rl09ZN9EJmYLJgA/F0zk2nyCoQ5W6Y/QsMNBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHl7Iavn; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so46420396d6.1
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172344; x=1745777144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trPo8VmIE5sTvgvRl3iaHtDgHtZSPYz3QOUhTJqMjyo=;
        b=WHl7Iavn+S2ofOIA8rn0bWNMSUfp89GGKijdMQiggmzueK5s3FjlLunUP/zHx/6Ysr
         nfaAFpmvB/uTLzy8excdH5kIRw73FNrplYEPx0Tbf0JNYStNnc0CMdtLsTcNOsZ5CcLQ
         9CqmHYOv3LSi7euCh7T1Qrjqm4u0g4d14g8MekDQ6OFVH2WnF3JSVa2wY4Nurv4eAxg0
         wzg0WiwWRD7DH0y/meCjR5tlYdH5oNLe4RtiMbmNgh86iGAAGQfOfDrXF0dSSHIcYbBh
         dvU7oCX1kvCWNEFMHLNDqcuaC/VwR0uIy41WHw0sQiEhxpW2MCS0vHFSYSDhwkd+cSk9
         7SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172344; x=1745777144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trPo8VmIE5sTvgvRl3iaHtDgHtZSPYz3QOUhTJqMjyo=;
        b=M8TAlWvTTWFADLzRJWVJxN5avsh1b+77jSdV9cFdsgjEAhpoufLsJBDl6dBb5FGvIj
         /LKQQjOxLu0BgaKF2O+1iSJ4B98Q8yz5WrDtwS262xDy9MXc8vaHdxUNoNu2MIWPd+eX
         zYZxVqMw3qvh6Dm1swIR+/LEtM/IIUXl7/nWpZBja0JVqFbr3Xv8IJ8cTVbqxgvciCHF
         4Yn0rvInVOb5AQky7dHZ2A8gJd3of8d53Z6Ywy2UssbsDkpwKeKDjHHwNAqu4xwySjqF
         w5f2zn9e9/et2pzH5ynhLH6822+Yz1qVz9gU14JxIXdupn2FgO0JInbwuxBq8VcFqZ8M
         8QIQ==
X-Gm-Message-State: AOJu0YwiLKBSdlqfPeCCoIxz9X4Z1kYhBXL4xj2xm0DRomxQ3vonU8qy
	P+52CK6WYhh/PmZHHTKp0sLAGYDlBsEi4RtHIups62BDeoyHfTtOq+L3Tw==
X-Gm-Gg: ASbGncvRsn72Yoz00VkM9u1XaXCAlrxEkM+tOG+WBz/iVi/x+c2OP5XI2Fps3fMG/c1
	6EfSkIFw2cgCeDdH7VIxh9/T3GFWV3LDqBkMTcEBz/qS22SZT6j3F3n5Qn3nNcoUGhJetovslup
	g/cB2jpwECYGnhzi5YbBUgO50Ec8k4lOdTGn5wbZXpq7Z347Izer0SOW7A2T116pMEKz29RJzxi
	/WgnGxSD+8FIxAOxmm0ynlTN9i3Y9TBGvz32eDRoT3g0kun8fGiLbnzQWlAjp5hnY+siSJx1OdU
	Mc3npJFcd6h9AcbgBRFPhzmlzADg/qkX/cFycFu4c7CM6Ni/uLQDXxrPLuZNq7wXA/xARxcOXaT
	ijQa1ryMSUEOO/qOzfcSDvd0bec4OX4iXclZNkXeShWwICh4ABQC96g==
X-Google-Smtp-Source: AGHT+IESBWtgr1p8NqGXoPyiESRCeatljRAhwFy7kbDKkLsMKPX9OjgmYWva7QdNzdK5u+C/TmZqSw==
X-Received: by 2002:a05:6214:508b:b0:6e4:3455:eba3 with SMTP id 6a1803df08f44-6f2c4d8d61bmr146834306d6.6.1745172344548;
        Sun, 20 Apr 2025 11:05:44 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21cccsm34333676d6.106.2025.04.20.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:05:43 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] selftests/net: test tcp connection load balancing
Date: Sun, 20 Apr 2025 14:04:31 -0400
Message-ID: <20250420180537.2973960-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
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

Use netcat to create the connections. Use tc prio + tc filter to
count routes taken, counting SYN packets across the two egress
devices.

To avoid flaky tests when testing inherently randomized behavior,
set a low bar and pass if even a single SYN is observed on both
devices.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Integrated into fib_nexthops.sh as it covers multipath nexthop
routing and can reuse all of its setup(), but technically the test
does not use nexthop *objects* as is, so I can also move into a
separate file and move common setup code to lib.sh if preferred.
---
 tools/testing/selftests/net/fib_nexthops.sh | 83 +++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index b39f748c2572..93d19e92bd5b 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -31,6 +31,7 @@ IPV4_TESTS="
 	ipv4_compat_mode
 	ipv4_fdb_grp_fcnal
 	ipv4_mpath_select
+	ipv4_mpath_balance
 	ipv4_torture
 	ipv4_res_torture
 "
@@ -45,6 +46,7 @@ IPV6_TESTS="
 	ipv6_compat_mode
 	ipv6_fdb_grp_fcnal
 	ipv6_mpath_select
+	ipv6_mpath_balance
 	ipv6_torture
 	ipv6_res_torture
 "
@@ -2110,6 +2112,87 @@ ipv4_res_torture()
 	log_test 0 0 "IPv4 resilient nexthop group torture test"
 }
 
+# Install a prio qdisc with separate bands counting IPv4 and IPv6 SYNs
+tc_add_syn_counter() {
+	local -r dev=$1
+
+	# qdisc with band 1 for no-match, band 2 for ipv4, band 3 for ipv6
+	ip netns exec $me tc qdisc add dev $dev root handle 1: prio bands 3 \
+		priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+	ip netns exec $me tc qdisc add dev $dev parent 1:1 handle 2: pfifo
+	ip netns exec $me tc qdisc add dev $dev parent 1:2 handle 4: pfifo
+	ip netns exec $me tc qdisc add dev $dev parent 1:3 handle 6: pfifo
+
+	# ipv4 filter on SYN flag set: band 2
+	ip netns exec $me tc filter add dev $dev parent 1: protocol ip u32 \
+		match ip protocol 6 0xff \
+		match ip dport 8000 0xffff \
+		match u8 0x02 0xff at 33 \
+		flowid 1:2
+
+	# ipv6 filter on SYN flag set: band 3
+	ip netns exec $me tc filter add dev $dev parent 1: protocol ipv6 u32 \
+		match ip6 protocol 6 0xff \
+		match ip6 dport 8000 0xffff \
+		match u8 0x02 0xff at 53 \
+		flowid 1:3
+}
+
+tc_get_syn_counter() {
+	ip netns exec $me tc -j -s qdisc show dev $1 handle $2 | jq .[0].packets
+}
+
+ip_mpath_balance() {
+	local -r ipver="-$1"
+	local -r daddr=$2
+	local -r handle="$1:"
+	local -r num_conn=20
+
+	tc_add_syn_counter veth1
+	tc_add_syn_counter veth3
+
+	for i in $(seq 1 $num_conn); do
+		ip netns exec $remote nc $ipver -l -p 8000 >/dev/null &
+		echo -n a | ip netns exec $me nc $ipver -q 0 $daddr 8000
+	done
+
+	local -r syn0="$(tc_get_syn_counter veth1 $handle)"
+	local -r syn1="$(tc_get_syn_counter veth3 $handle)"
+	local -r syns=$((syn0+syn1))
+
+	[ "$VERBOSE" = "1" ] && echo "multipath: syns seen: ($syn0,$syn1)"
+
+	[[ $syns -ge $num_conn ]] && [[ $syn0 -gt 0 ]] && [[ $syn1 -gt 0 ]]
+}
+
+ipv4_mpath_balance()
+{
+	$IP route add 172.16.101.1 \
+		nexthop via 172.16.1.2 \
+		nexthop via 172.16.2.2
+
+	ip netns exec $me \
+		sysctl -q -w net.ipv4.fib_multipath_hash_policy=1
+
+	ip_mpath_balance 4 172.16.101.1
+
+	log_test $? 0 "Multipath loadbalance"
+}
+
+ipv6_mpath_balance()
+{
+	$IP route add 2001:db8:101::1\
+		nexthop via 2001:db8:91::2 \
+		nexthop via 2001:db8:92::2
+
+	ip netns exec $me \
+		sysctl -q -w net.ipv6.fib_multipath_hash_policy=1
+
+	ip_mpath_balance 6 2001:db8:101::1
+
+	log_test $? 0 "Multipath loadbalance"
+}
+
 basic()
 {
 	echo
-- 
2.49.0.805.g082f7c87e0-goog


