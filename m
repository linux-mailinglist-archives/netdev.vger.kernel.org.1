Return-Path: <netdev+bounces-75750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AD86B0F5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C91F2699A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3594158D6F;
	Wed, 28 Feb 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4S2cS1Tu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14181158D66
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128501; cv=none; b=rT2SR+y/DOsDKJihHbq/UnqbrjkDnbICsSnmlpCXelS9wA8qcfe70zDlMTKnO3+7mqXNGB1bHS+QHE+dPWP02O3n+k+H1kqAs5rR0vDEu3yrhTSS1Gy4ExvDc+jW5wzNg23W2fpCbOJK1hokpwRCiFW9bgxMvL6wu5YAUdGX/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128501; c=relaxed/simple;
	bh=2XX9xA71+RP1Xg97iPh2TN80vTiKjQjIJwbi9JFH4E0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXKaYJ0boEtYgT0rWsoFbxpGezRSgOVMQnKZV/bRHqFbmxQ+6Moy/B7pQS1H/uXuXATT0PlY8mvx6oplLVMHDE4LXC+oD9RobjlAHIX/kgiqzQfdl21eSF9bqQMjQmktZtWX3HdgDlfXb/cEKpa4aZzuHKsb6Etw8td1loChHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4S2cS1Tu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso8652070276.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128499; x=1709733299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBSkGlpnzKLh2ctZVNRMrN7zMfI7gCScvcV6bolxLsE=;
        b=4S2cS1TuH8hjTh0n59fPZYLI3ZsI58dSqo9SGTp8lK2XGUthTZ338I9jjILZgKWaPe
         5zrG6sxOcxK+db8upPJQXzSVY2bWiT1ThJqd/saDfEiP+eawK0ai/ws7cFDqDWuEuhfi
         8RhROObSL9pVl5WJ7Mp/VjlVGOULC1DStmXcHJ9IEZ1qaMPMom9FXDfa7xDJMyLiYRZh
         IFE+K9PxNbW5Hr0M7sdNfW8WDv7MdVekPn8Fler2Cym+JrDdYb4AinUHBIZYN6TSRi+T
         yR8B145tcWnIJCE0h67urrqAmTr2HV23LHMgSYkozzEa1LoJsDDgBKEBZdHM/9fO4WkN
         hppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128499; x=1709733299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBSkGlpnzKLh2ctZVNRMrN7zMfI7gCScvcV6bolxLsE=;
        b=bOzMdNONKQD214m6paHqiE/cQutb2LLCDDHcjC08+FqB/O3SLagfL0pCWgWsLfrrbH
         0O3/g3gutNBh2ksh3V3iu1SaEPj73/ToDzlzTe91LUkOYQLBq/7JsXfcNb83X3QGgRww
         r3jx9+8lSLN33AQQ8p5mYsHbGQt4jkJoBEQzjqOZOV0LPMw+FTirJNkQybTE8jvxsBNy
         HQP01mGf4LKtfEUR5NGikdtPN66inKVoC+k5nLn9XS34wyrkxL/4J5kW2fwWI9GICipF
         SMOB/L9vjajsBrSZdpZHp3o+Ifk6fuX+89522rh47nn5nhU/1dMP0qov5MZKC5LFRiou
         xzyA==
X-Gm-Message-State: AOJu0Yyns5OUTOwS6o1xI1KVwAo1lte7RS+hTXnTLUN2iW90RnuIHGIR
	f6mM0R/NNsOOmFNLlMixAeFxMSXzt3fH+9Ai/exGADrYrud2cXVDOyEw6OOU9DKm0QEY4ha2Z3L
	LNY7OpbA/ZA==
X-Google-Smtp-Source: AGHT+IGv53usKs3rdAdUyvs1ndEVXHfD6GqkcwiX2Le3x4vPLdp3zXqYnEGZ3sBPThlVMiGTYXJBEKNmH1xRcQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1105:b0:dce:5218:c89b with SMTP
 id o5-20020a056902110500b00dce5218c89bmr117412ybu.5.1709128499150; Wed, 28
 Feb 2024 05:54:59 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:34 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/15] ipv6: annotate data-races around devconf->proxy_ndp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

devconf->proxy_ndp can be read and written locklessly,
add appropriate annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c   | 3 ++-
 net/ipv6/ip6_output.c | 2 +-
 net/ipv6/ndisc.c      | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 31a8225a5abe6f315f110d83568773504aa97e08..18b1e79c1ebf8de17f813ef697be69e3d9c209a2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -561,7 +561,8 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 		goto nla_put_failure;
 #endif
 	if ((all || type == NETCONFA_PROXY_NEIGH) &&
-	    nla_put_s32(skb, NETCONFA_PROXY_NEIGH, devconf->proxy_ndp) < 0)
+	    nla_put_s32(skb, NETCONFA_PROXY_NEIGH,
+			READ_ONCE(devconf->proxy_ndp)) < 0)
 		goto nla_put_failure;
 
 	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 444be8c84cc579bf32b2950e0261ffe7c1d265a8..f08af3f4e54f5dcb0b8b5fb8f60463e41bd1f578 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -552,7 +552,7 @@ int ip6_forward(struct sk_buff *skb)
 	}
 
 	/* XXX: idev->cnf.proxy_ndp? */
-	if (net->ipv6.devconf_all->proxy_ndp &&
+	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
 		int proxied = ip6_forward_proxy_check(skb);
 		if (proxied > 0) {
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6430db249401b12debc0b174027af966fa71ccb..4114918f12c88f2b74e53d6d726018994feaf213 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -904,7 +904,8 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 
 		if (ipv6_chk_acast_addr(net, dev, &msg->target) ||
 		    (READ_ONCE(idev->cnf.forwarding) &&
-		     (net->ipv6.devconf_all->proxy_ndp || idev->cnf.proxy_ndp) &&
+		     (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+		      READ_ONCE(idev->cnf.proxy_ndp)) &&
 		     (is_router = pndisc_is_router(&msg->target, dev)) >= 0)) {
 			if (!(NEIGH_CB(skb)->flags & LOCALLY_ENQUEUED) &&
 			    skb->pkt_type != PACKET_HOST &&
@@ -1101,7 +1102,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		 */
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
-		    net->ipv6.devconf_all->proxy_ndp &&
+		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
 		    pneigh_lookup(&nd_tbl, net, &msg->target, dev, 0)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
-- 
2.44.0.rc1.240.g4c46232300-goog


