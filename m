Return-Path: <netdev+bounces-218180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455CB3B6A3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C415618CC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16F2E5B30;
	Fri, 29 Aug 2025 09:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4062E337B;
	Fri, 29 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458292; cv=none; b=caUuhh4UCgqKAYyYYgcCpVdh+5yQkypBi67oPQ0/sJtCX4jUXsIj7O/icolSW/z3+tc2aK+aQZcMPXOrSho/7+RDToWYrvzp8toOVbIK6k3m0IFBFA/VYnkUa8KVTupDaehgXuwfUbkib/4b9akkxcClLoEnnOXHDP/l3CDQhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458292; c=relaxed/simple;
	bh=xlFbFNeGawRnq4xxs78hLclAmH+Lzu/wNhnqs0cOCbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVfXy24q0gPBX1ytNH2jUZSUuIY65RaaKw/RVqo7qKmD7jCG6j8+HU5lEVwFOsXiHrGWxVSo2OrqAYTsCv9M7sgQdemiybQhnnKiAByipT/jxwR1Af1LuV66rkjgJ2cpw19v98Fe9NglYC3Cq7W/yMW9RTfe+8sfEsKvbX7eAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B0AA54F687;
	Fri, 29 Aug 2025 10:57:36 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 3/9] net: bridge: mcast: track active state, IPv6 address availability
Date: Fri, 29 Aug 2025 10:53:44 +0200
Message-ID: <20250829085724.24230-4-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829085724.24230-1-linus.luessing@c0d3.blue>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

If we are the only potential MLD querier but don't have an IPv6
link-local address configured on our bridge interface then we can't
create a valid MLD query and in turn can't reliably receive MLD reports
and can't build a complete MDB. Hence disable the new multicast active
state variable then. Or reenable it if an IPv6 link-local address
became available.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2e5b5281e484..b689e62b9e74 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1112,6 +1112,7 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
  * The multicast active state is set, per protocol family, if:
  *
  * - an IGMP/MLD querier is present
+ * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
  *
  * And is unset otherwise.
  *
@@ -1206,10 +1207,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 			       &ip6h->daddr, 0, &ip6h->saddr)) {
 		kfree_skb(skb);
 		br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, false);
+		br_multicast_update_active(brmctx);
 		return NULL;
 	}
 
 	br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, true);
+	br_multicast_update_active(brmctx);
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
 	hopopt = (u8 *)(ip6h + 1);
-- 
2.50.1


