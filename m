Return-Path: <netdev+bounces-238187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDCFC5582B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86821342845
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB925B2FA;
	Thu, 13 Nov 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh1Ly8+e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791F26AEC
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003826; cv=none; b=HlM7XlkQO6JwwOYBZlumFz7ioUCaapaZbJC1ZogsD/TFVtfKUAel+lMisac62nmKFTbRzdfmei2C7n97qC5TKlfFRB3zwphxAfLkzF7AoykOw3UqeqRmXmYoydG2nhJQcZHukvHRemw0mgluc3p1tWegPketCS0lIzVKv2BSqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003826; c=relaxed/simple;
	bh=M00o+x8bjgUbojbGLJ3V0KamUcECqygC5Tun0RnsuL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lofWpAGmbn4cUWWo0F7joBQzkIX7Gh0HWkWQmaYXNNzBxVMmUzFfaCJJ3Ix/mTLDh3r2cFVh/ibEGhbvCE9boktg+KOHql3UoTCs29J/GnArVvQBWkmtNty3x6GEJ49d4cggmY7vE4V6Qg1u8Q1oVcRKfZLHcWP4bWz2r46VZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh1Ly8+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361B1C113D0;
	Thu, 13 Nov 2025 03:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763003825;
	bh=M00o+x8bjgUbojbGLJ3V0KamUcECqygC5Tun0RnsuL0=;
	h=From:To:Cc:Subject:Date:From;
	b=nh1Ly8+eurywUmqXJ/JkuBaRLfeE68E8CIh+wRfSenmIV7NUZpFYWmv3Z5TNQvxLf
	 DGszg/HbykiIO8ZUqH1UpUphHkQb9tesn2QJ/ERffJS5rDogiZUYv2x2EUhfm4fVJn
	 Z0tTE1KAtEqBQ58sZ6uqKQDr/5w7aL5V7vHM7S0yIqs6RYHz1V49gYViQVPN2zf9ma
	 RID8LnG0uAiBSyKimm2zIewZVXFXyby7k5mnkmIwtIIuuvqfI+cIaqJY222bNNXxKv
	 2uyE0CatQvjHgDg8fy3iMZ8nV+AHZdP95+d9SQU87mZqpAbVbsSL61EBUCRvYX3buC
	 /cz7tAhmXQ8ZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	idosch@nvidia.com,
	dsahern@kernel.org
Subject: [PATCH net-next v2] ipv6: clean up routes when manually removing address with a lifetime
Date: Wed, 12 Nov 2025 19:17:00 -0800
Message-ID: <20251113031700.3736285-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an IPv6 address with a finite lifetime (configured with valid_lft
and preferred_lft) is manually deleted, the kernel does not clean up the
associated prefix route. This results in orphaned routes (marked "proto
kernel") remaining in the routing table even after their corresponding
address has been deleted.

This is particularly problematic on networks using combination of SLAAC
and bridges.

1. Machine comes up and performs RA on eth0.
2. User creates a bridge
   - does an ip -6 addr flush dev eth0;
   - adds the eth0 under the bridge.
3. SLAAC happens on br0.

Even tho the address has "moved" to br0 there will still be a route
pointing to eth0, but eth0 is not usable for IP any more.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Bit of a risky change.. but there's no known reason to intentionally
keep these routes.

v2:
 - fix up the test case
v1: https://lore.kernel.org/20251111221033.3049292-1-kuba@kernel.org

CC: idosch@nvidia.com
CC: dsahern@kernel.org
---
 net/ipv6/addrconf.c                      |  2 +-
 tools/testing/selftests/net/rtnetlink.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40e9c336f6c5..b66217d1b2f8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1324,7 +1324,7 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
 		__in6_ifa_put(ifp);
 	}
 
-	if (ifp->flags & IFA_F_PERMANENT && !(ifp->flags & IFA_F_NOPREFIXROUTE))
+	if (!(ifp->flags & IFA_F_NOPREFIXROUTE))
 		action = check_cleanup_prefix_route(ifp, &expires);
 
 	list_del_rcu(&ifp->if_list);
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 163a084d525d..248c2b91fe42 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -8,6 +8,7 @@ ALL_TESTS="
 	kci_test_polrouting
 	kci_test_route_get
 	kci_test_addrlft
+	kci_test_addrlft_route_cleanup
 	kci_test_promote_secondaries
 	kci_test_tc
 	kci_test_gre
@@ -323,6 +324,25 @@ kci_test_addrlft()
 	end_test "PASS: preferred_lft addresses have expired"
 }
 
+kci_test_addrlft_route_cleanup()
+{
+	local ret=0
+	local test_addr="2001:db8:99::1/64"
+	local test_prefix="2001:db8:99::/64"
+
+	run_cmd ip -6 addr add $test_addr dev "$devdummy" valid_lft 300 preferred_lft 300
+	run_cmd_grep "$test_prefix proto kernel" ip -6 route show dev "$devdummy"
+	run_cmd ip -6 addr del $test_addr dev "$devdummy"
+	run_cmd_grep_fail "$test_prefix" ip -6 route show dev "$devdummy"
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: route not cleaned up when address with valid_lft deleted"
+		return 1
+	fi
+
+	end_test "PASS: route cleaned up when address with valid_lft deleted"
+}
+
 kci_test_promote_secondaries()
 {
 	run_cmd ifconfig "$devdummy"
-- 
2.51.1


