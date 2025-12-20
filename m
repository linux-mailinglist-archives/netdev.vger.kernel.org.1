Return-Path: <netdev+bounces-245569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E9CD2613
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 04:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06CF63013734
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DB28689A;
	Sat, 20 Dec 2025 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RMZ2plC0"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DD27FD52
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201064; cv=none; b=CuvEmYj+ZBlAL6/i3V21jaFb9UqylY6rYGngzNUP53bl2/FucyopXjdZv2/LjpXoMFm0zGxJHMveUqIznU20xyVpekd13AX57OuRVZXxwgAukNd9t7xnwLaguOVtPdUVUBAxJr9XMyFBkItjytEM/izZiKIk94FMHJOt465PwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201064; c=relaxed/simple;
	bh=BDmzBi34YgSMLxtX/mJnlT5HIxWSMC9jfEwMm8eNteE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBkorehASSdoMwPGpb+Lt/k3vcNAT4o0oX+hZmAgjqCR2AZcEW56ngiDoo9G24SgDRi2Qr3yFoPMpyL1u1b/6OihPrEah3YfRNjg1F4DL/7aVNT9Z9phLZrSTxrk4SCi2CU76tuVxX9aUgfY2HOXjMGNNmaizKxT8RV99QWkzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RMZ2plC0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766201055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boWDZ+yoMzCU4diu4Mb0x037RQ2Z/8cwIFP5dd0PJn8=;
	b=RMZ2plC0JJOQx43WajYJ9Q7Yxioex9JbFGVvdGZ2/A1aNozMyTfBasaC4KnObeN68O6zrp
	zt079FNBeDH9lV+KCrmwIorKU8H/HB+yxltMtd9P8nAG7bEpzKuJy6dpBSkOVPp9dy9rcJ
	WsoC3nXFgjfeTN5sthkQ1NAivtLvtm0=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net v2 2/2] selftests: fib_test: Add test case for ipv4 multi nexthops
Date: Sat, 20 Dec 2025 03:23:35 +0000
Message-ID: <20251220032335.3517241-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
References: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The test checks that with multi nexthops route the preferred route is the
one which matches source ip. In case when source ip is on dummy
interface, it checks that the routes are balanced.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:
- move tests to fib_tests.sh
---
 tools/testing/selftests/net/fib_tests.sh | 70 +++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index a88f797c549a..c5694cc4ddd2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
-       fib6_ra_to_static"
+       ipv4_mpath_balance_preferred fib6_ra_to_static"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2751,6 +2751,73 @@ ipv4_mpath_balance_test()
 	forwarding_cleanup
 }
 
+get_route_dev_src()
+{
+	local pfx="$1"
+	local src="$2"
+	local out
+
+	if out=$($IP -j route get "$pfx" from "$src" | jq -re ".[0].dev"); then
+		echo "$out"
+	fi
+}
+
+ipv4_mpath_preferred()
+{
+	local src_ip=$1
+	local pref_dev=$2
+	local dev routes
+	local route0=0
+	local route1=0
+	local pref_route=0
+	num_routes=254
+
+	for i in $(seq 1 $num_routes) ; do
+		dev=$(get_route_dev_src 172.16.105.$i $src_ip)
+		if [ "$dev" = "$pref_dev" ]; then
+			pref_route=$((pref_route+1))
+		elif [ "$dev" = "veth1" ]; then
+			route0=$((route0+1))
+		elif [ "$dev" = "veth3" ]; then
+			route1=$((route1+1))
+		fi
+	done
+
+	routes=$((route0+route1))
+
+	[ "$VERBOSE" = "1" ] && echo "multipath: routes seen: ($route0,$route1,$pref_route)"
+
+	if [ x"$pref_dev" = x"" ]; then
+		[[ $routes -ge $num_routes ]] && [[ $route0 -gt 0 ]] && [[ $route1 -gt 0 ]]
+	else
+		[[ $pref_route -ge $num_routes ]]
+	fi
+
+}
+
+ipv4_mpath_balance_preferred_test()
+{
+	echo
+	echo "IPv4 multipath load balance preferred route"
+
+	forwarding_setup
+
+	$IP route add 172.16.105.0/24 \
+		nexthop via 172.16.101.2 \
+		nexthop via 172.16.103.2
+
+	ipv4_mpath_preferred 172.16.101.1 veth1
+	log_test $? 0 "IPv4 multipath loadbalance from veth1"
+
+	ipv4_mpath_preferred 172.16.103.1 veth3
+	log_test $? 0 "IPv4 multipath loadbalance from veth3"
+
+	ipv4_mpath_preferred 198.51.100.1
+	log_test $? 0 "IPv4 multipath loadbalance from dummy"
+
+	forwarding_cleanup
+}
+
 ipv6_mpath_balance_test()
 {
 	echo
@@ -2861,6 +2928,7 @@ do
 	ipv6_mpath_list)		ipv6_mpath_list_test;;
 	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
+	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
-- 
2.47.3


