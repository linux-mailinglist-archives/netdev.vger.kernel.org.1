Return-Path: <netdev+bounces-237755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51633C4FF32
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328381881F88
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE42EC084;
	Tue, 11 Nov 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBAb54Ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF735CBB6
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899038; cv=none; b=j04nPvDNILN9hGUBfcc+6h9XPaU6oEtZe+Zn0i0UfzYLm07/J2iju5Tu3vAtLHXcsdN88cjDfS5fCMfzdnchYQqXHi1PJI2IwjQkkvZ9UzPgu/l1bMogWg4nMbxmyDo269O13/9EMvo0H2811cROZ2dhQeuc+bIYYkfbLwDy8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899038; c=relaxed/simple;
	bh=TZdtS2HYgkEapsO2je9Jm5hwMVbVx6X6F3BrIx/1TjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RM2HNmCHVyQu7ul/QbjZcouFyAgWkZw0kZoGo0i8O8tu1pxqZdPVjYnsD4gXbggB/U+1Nm1YH/gRZKw5IUXOVKAAY8t0n1yqQFKiD32hpp7DHo4aNlHBo5yRg6zmzlh2oFChQAlCAF3EqSLvDHqxhl4w5p/vxkZOLWt2GKNfdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBAb54Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39228C4CEF5;
	Tue, 11 Nov 2025 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762899037;
	bh=TZdtS2HYgkEapsO2je9Jm5hwMVbVx6X6F3BrIx/1TjE=;
	h=From:To:Cc:Subject:Date:From;
	b=VBAb54NsIz2pWZJY6VNsvRSvJbPMNMTY2NBvsCMQ/eRurmUSwUHbv/D6+WLJ1VbFu
	 lktik0I3byOIioy0QkwLiLiIS8YiESXKrcZen4cBKmK+Q/1xP0lRQ3z1Ud5dYFO+7H
	 EizKRoyWuOXAEh6GYEPXzpeldFvZKfu5HgrRgBpwRmuMp7h0jsvmnUEDjHZeZGNO+e
	 tw7NpN1Xslk8n87ZbGjwMVtbkQJ0N+ehaVzObraTCmY/zcMwa1nSRmsz1dqOSLjuWr
	 2D21TaqcPJB/06nEO6UjCuheYRpm8ZQvgDM3tVA1iZYoqURg+xVdOceajncUL238ls
	 TgrPEdpjZJ2ig==
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
Subject: [PATCH net-next] ipv6: clean up routes when manually removing address with a lifetime
Date: Tue, 11 Nov 2025 14:10:33 -0800
Message-ID: <20251111221033.3049292-1-kuba@kernel.org>
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
Bit of a risky change.. Is there a reason why we're not flushing
the expiring routes or this is just "historic"?

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
index 163a084d525d..a915da19a715 100755
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
+	run_cmd_grep "$test_prefix dev $devdummy proto kernel" ip -6 route show dev "$devdummy"
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


