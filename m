Return-Path: <netdev+bounces-264545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HNLIYnxqWlGIQEAu9opvQ
	(envelope-from <netdev+bounces-264545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:11:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A272186DB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6FF3015C96
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF5351C16;
	Thu,  5 Mar 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DLsavV2R"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672BA352C35;
	Thu,  5 Mar 2026 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745032; cv=none; b=OPSBSPj8/7Q/daaPBmyFFDZ0wbvoXYzeqv1zb1hT4vbp3GFxc6Wz1z9kFwwd1dARsw/4wXEvB5S9BVoD0amTfDwO99+0XXz15qi1JHl3SQzWfYfFBPpAYb/3+wuaTAmuinGCXAP18eBMQX1uJZwWrO7xSjKGkzgY0dhvoFUCExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745032; c=relaxed/simple;
	bh=mWnlCBPFy8iSy+Jncr+afNPVQGlHEW/rXWuCWK74e2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSbnHEb+m9Wt+wyBxo/ODcfhdA83yClTjkWOlkhPGOSUtNhhTIpRKV9xMpYlD9gAi4keJ+3r29jUz5q/ohymTt8qfuBuxwoVPCx+eRKG80mmvGHdSY2BRz8GJK0h/6ul+tunKsTu7GwuszrK249zw7od4tNjQxjfZ6Bc+Mzmw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=DLsavV2R; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=5iY5tkbgE71f/1yLuiO8l9s0HnuaGaMfjmHUKuv+0Vk=; b=DLsavV2RjjJS
	ixmqd/byHBFy5qQLEK60SqMLz7aUmYeNujmN4mbBhwPT5hMlVksKk9OtHk4UYaTWgC/Okr4pSW2VR
	6loSTS8InFaCjZSLmQkKLQxZKwkyBBNaJ+ifDrXnqLChy2dyqdeth0hsehfT7slgbXjUhmbB7K2vw
	3Ch/AW/VZc2CxHlgQ9+Ih04fzmdA/8NpicpGv/9X0Z9YRtjIG4MMLFu/yd0xZfK4abL7aif/GUM3o
	c5c0x2EltLjeKUQefdFEWXxv03NeOq7yNx8KJf6iqaV0wgxWmXbdkZOvbhiBBYi10wkXtS8q5V+WR
	odhRKH+zAll9iPER/N8N1A==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vyFvx-001doX-0z;
	Thu, 05 Mar 2026 22:10:08 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 625LA9Bc515326
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 5 Mar 2026 21:10:09 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 625LA1Xj515311;
	Thu, 5 Mar 2026 21:10:01 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Nir Dotan <nird@mellanox.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH v2] selftests: net: forwarding: fix IPv6 address leak in cleanup
Date: Thu,  5 Mar 2026 21:10:00 +0000
Message-ID: <20260305211000.515301-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8A272186DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264545-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,min_max_mtu.sh:url,ipip_lib.sh:url,gre_multipath.sh:url]
X-Rspamd-Action: no action

Several forwarding tests (e.g., gre_multipath.sh) initialize both IPv4
and IPv6 addresses using simple_if_init, but only clean up IPv4
in simple_if_fini. This leaves stale IPv6 addresses on the interfaces,
which causes subsequent tests to fail when they encounter unexpected
address configuration.

The issue can be reproduced by running tests in sequence:
  # run_kselftest.sh -t net/forwarding:ipip_hier_gre.sh
  # run_kselftest.sh -t net/forwarding:min_max_mtu.sh
  TAP version 13
  1..1
  # timeout set to 0
  # selftests: net/forwarding: min_max_mtu.sh
  # TEST: ping                                                          [ OK ]
  # TEST: ping6                                                         [ OK ]
  # TEST: Test maximum MTU configuration                                [ OK ]
  # TEST: Test traffic, packet size is maximum MTU                      [FAIL]
  #       Ping6, packet size: 65487 succeeded, but should have failed
  # TEST: Test minimum MTU configuration                                [ OK ]
  # TEST: Test traffic, packet size is minimum MTU                      [ OK ]
  not ok 1 selftests: net/forwarding: min_max_mtu.sh # exit=1

Fix this by removing the unused IPv6 argument from simple_if_init in
tests that don't use IPv6 (gre_multipath.sh, ipip_lib.sh), and by
adding the missing IPv6 argument to simple_if_fini in tests that
use IPv6 (gre_multipath_nh.sh, gre_multipath_nh_res.sh).

Fixes: fed926d4f64c ("selftests: forwarding: Add IP tunneling lib")
Fixes: 902280cacc03 ("selftests: forwarding: Add resilient multipath tunneling nexthop test")
Fixes: 54818c4c4b93 ("selftests: forwarding: Test multipath tunneling")
Fixes: e035146d6560 ("selftests: forwarding: Add multipath tunneling nexthop test")
Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
Changes in v2:
- In gre_multipath.sh and ipip_lib.sh, remove the unused IPv6 address
  from simple_if_init instead of adding it to simple_if_fini, since
  these tests don't use IPv6
- Link to v1: https://lore.kernel.org/linux-kselftest/20260301124052.GA713428@shredder/T/
---
 tools/testing/selftests/net/forwarding/gre_multipath.sh        | 2 +-
 tools/testing/selftests/net/forwarding/gre_multipath_nh.sh     | 2 +-
 tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh | 2 +-
 tools/testing/selftests/net/forwarding/ipip_lib.sh             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index 57531c1d884d..ce4ae74843d9 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -65,7 +65,7 @@ source lib.sh
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+	simple_if_init $h1 192.0.2.1/28
 	ip route add vrf v$h1 192.0.2.16/28 via 192.0.2.2
 }
 
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
index 7d5b2b9cc133..c667b81da37f 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
@@ -80,7 +80,7 @@ h1_destroy()
 {
 	ip route del vrf v$h1 2001:db8:2::/64 via 2001:db8:1::2
 	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
-	simple_if_fini $h1 192.0.2.1/28
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
 }
 
 sw1_create()
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
index 370f9925302d..d04bad58a96a 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
@@ -80,7 +80,7 @@ h1_destroy()
 {
 	ip route del vrf v$h1 2001:db8:2::/64 via 2001:db8:1::2
 	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
-	simple_if_fini $h1 192.0.2.1/28
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
 }
 
 sw1_create()
diff --git a/tools/testing/selftests/net/forwarding/ipip_lib.sh b/tools/testing/selftests/net/forwarding/ipip_lib.sh
index 01e62c4ac94d..b255646b737a 100644
--- a/tools/testing/selftests/net/forwarding/ipip_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ipip_lib.sh
@@ -144,7 +144,7 @@
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+	simple_if_init $h1 192.0.2.1/28
 	ip route add vrf v$h1 192.0.2.16/28 via 192.0.2.2
 }
 
-- 
2.43.0


