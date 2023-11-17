Return-Path: <netdev+bounces-48655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BC7EF219
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC0280FAF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C542FE20;
	Fri, 17 Nov 2023 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQDPGvD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8B2E414
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 11:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124ACC433C8;
	Fri, 17 Nov 2023 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700221720;
	bh=3MpaidUztuhrjbf9qeOfLOgAzYrclVMygukdqfl98ew=;
	h=From:To:Cc:Subject:Date:From;
	b=SQDPGvD0DiHsGg+o1RnhnxeTuIDZUKMFlu1J/1KrYuPH4Vk4HlEl8kzKkqal16j59
	 jxK0PZbxmHUERyAmsKFQvGhsmitYublcSBpv1C+1a9CyPm9HxMUgby7k2lF8hez+ue
	 GLHTn0HpvKTCzSW17Q2PThjasaUbGhwWtj2XG1sX0Yev4e9TgMaqlkNwE7Vqx8yj1B
	 KZh33a6h9dK9XmDdWdZCoBKal9tJwQMsW9wnWVqEFc/sM7G/QGOPKnxlx87Psdq7rR
	 UTLXVTwrAYnH4PKO/9Ssv9RdqG2+dxTYTECJ5sL/w7H5lUUbdVr1zn8l3Q2oOCwB59
	 3ACZiPw2VzACw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	liuhangbin@gmail.com,
	ja@ssi.bg
Subject: [PATCH net-next] net: ipv4: replace the right route in case prefsrc is used
Date: Fri, 17 Nov 2023 12:48:36 +0100
Message-ID: <20231117114837.36100-1-atenart@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case similar routes with different prefsrc are installed, any
modification of one of those routes will always modify the first one
found as the prefsrc is not matched. Fix this by updating the entry we
found in case prefsrc was set in the request.

Before the patch:

  $ ip route show
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100
  $ ip route change 172.16.42.0/24 dev eth0 proto kernel scope link \
        src 172.16.42.4 metric 100 mtu 1280
  $ ip route show
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100 mtu 1280
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100

After the patch:

  $ ip route show
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100
  $ ip route change 172.16.42.0/24 dev eth0 proto kernel scope link \
        src 172.16.42.4 metric 100 mtu 1280
  $ ip route show
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
  172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100 mtu 1280

All fib selftest ran and no failure was seen.

Note: a selftest wasn't added as `ip route` use NLM_F_EXCL which
prevents us from constructing the above routes. But this is a valid
example of what NetworkManager can construct for example.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---

Hi, comment/question below,

I'm wondering if we want to fix the above case. I made this patch
because we already filter on prefsrc when deleting a route[1] to deal
with the same configurations as above, and that would make the route
replacement consistent with that.

However even with this (same for [1]) things are not 100% failsafe
(and we can argue on the use case and feasibility). For example
consider,

$ ip route show
172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
172.16.42.0/24 dev eth0 proto kernel scope link metric 100
$ ip route del 172.16.42.0/24 dev eth0 proto kernel scope link metric 100
$ ip route show
172.16.42.0/24 dev eth0 proto kernel scope link metric 100

Also the differing part could be something else that the prefsrc (not
that it would necessarily make sense).

Thoughts?

Thanks!
Antoine

[1] 74cb3c108bc0 ("ipv4: match prefsrc when deleting routes").

---
 net/ipv4/fib_trie.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 9bdfdab906fe..6cf775d4574e 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1263,10 +1263,11 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 
 		nlflags &= ~NLM_F_EXCL;
 
-		/* We have 2 goals:
+		/* We have 3 goals:
 		 * 1. Find exact match for type, scope, fib_info to avoid
 		 * duplicate routes
 		 * 2. Find next 'fa' (or head), NLM_F_APPEND inserts before it
+		 * 3. Find the right 'fa' in case a prefsrc is used
 		 */
 		fa_match = NULL;
 		fa_first = fa;
@@ -1282,6 +1283,9 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 				fa_match = fa;
 				break;
 			}
+			if (cfg->fc_prefsrc &&
+			    cfg->fc_prefsrc == fa->fa_info->fib_prefsrc)
+				fa_first = fa;
 		}
 
 		if (cfg->fc_nlflags & NLM_F_REPLACE) {
-- 
2.41.0


