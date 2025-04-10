Return-Path: <netdev+bounces-181131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604EA83BF2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BB23A507A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53411E32D3;
	Thu, 10 Apr 2025 07:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43C1E1DE4
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271873; cv=none; b=KopdVyLiNbIwqvz7BjaYI0Kuf7NFIaXZR9p4PAC0NnpKGThnUNH78i0XrSV+r5rIpBpA2bS6QBo1tVigq+6an/Ph5z71EG8NUsicrciTjTnLVzDVIyumq8VOKIS556658XInKzDn07anrQnV2RafUu++htj3gmyfzcfoX/euWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271873; c=relaxed/simple;
	bh=OFuTvLaGjzuQogsFcUndCTKTSWSWkE6Q1DC0VMEZAXI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1lIceyI8/lEA/z3GBvb6IZuF96r/P2k98iwEZ/e/LeyQrv1wGAe1N4zyV+EsNCS8vlCU9pWHSnO1JBrFRUFqfZjfZzgbJhbJMu8NcJFq/2Wr2HRzxt9qrJsDcm7VlCjLZPT9wmUbBddWCNHf7tqmo0ib+1f8FQsN8x2GRR7XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch03.asrmicro.com (exch03.asrmicro.com [10.1.24.118])
	by spam.asrmicro.com with ESMTPS id 53A7vUw7082119
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Thu, 10 Apr 2025 15:57:30 +0800 (GMT-8)
	(envelope-from huajianyang@asrmicro.com)
Received: from localhost (10.26.128.141) by exch03.asrmicro.com (10.1.24.118)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 10 Apr 2025 15:57:32
 +0800
From: Huajian Yang <huajianyang@asrmicro.com>
To: <pablo@netfilter.org>, <fw@strlen.de>
CC: <kadlec@netfilter.org>, <razor@blackwall.org>, <idosch@nvidia.com>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Huajian Yang <huajianyang@asrmicro.com>
Subject: [PATCH] net: Move specific fragmented packet to slow_path instead of dropping it
Date: Thu, 10 Apr 2025 15:57:26 +0800
Message-ID: <20250410075726.8599-1-huajianyang@asrmicro.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch01.asrmicro.com (10.1.24.121) To exch03.asrmicro.com
 (10.1.24.118)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 53A7vUw7082119

The config NF_CONNTRACK_BRIDGE will change the way fragments are processed.

Bridge does not know that it is a fragmented packet and forwards it
directly, after NF_CONNTRACK_BRIDGE is enabled, function nf_br_ip_fragment
and br_ip6_fragment will check and fraglist this packet.

This change makes layer 2 fragmented packet forwarding more similar to
ip_do_fragment, these specific packets previously dropped will go to
slow_path for further processing.

Signed-off-by: Huajian Yang <huajianyang@asrmicro.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 12 ++++--------
 net/ipv6/netfilter.c                       | 13 ++++---------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..beac62c5d257 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -61,18 +61,14 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 		struct sk_buff *frag;
 
 		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < ll_rs)
-			goto blackhole;
-
-		if (skb_cloned(skb))
+		    (skb_headroom(skb) < ll_rs) ||
+		    skb_cloned(skb))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag) {
 			if (frag->len > mtu ||
-			    skb_headroom(frag) < hlen + ll_rs)
-				goto blackhole;
-
-			if (skb_shared(frag))
+			    (skb_headroom(frag) < hlen + ll_rs) ||
+			    skb_shared(frag))
 				goto slow_path;
 		}
 
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 581ce055bf52..29778e014560 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -165,19 +165,14 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		struct sk_buff *frag2;
 
 		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
-			goto blackhole;
-
-		if (skb_cloned(skb))
+		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)) ||
+		    skb_cloned(skb))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag2) {
 			if (frag2->len > mtu ||
-			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
-				goto blackhole;
-
-			/* Partially cloned skb? */
-			if (skb_shared(frag2))
+			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)) ||
+			    skb_shared(frag2))
 				goto slow_path;
 		}
 
-- 
2.48.1


