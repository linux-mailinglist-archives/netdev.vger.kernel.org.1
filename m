Return-Path: <netdev+bounces-201984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483AAEBD7B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409453ADD1E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB681720;
	Fri, 27 Jun 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4MQsEtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030E3398B
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041966; cv=none; b=Q63a7C9WKxsFbWVtK/156TzpDfaY3iEgS0ePkTPGreqG8K6GQCSX9MOMD2CyEJupSR0xJlORwknnJhCASv2cZE64EphTtrROw7li+D9zJrlPfi4cP9Mo9p7ypQBVKklxCCHxAyXuLEHXIf4vifB/Go7XqkdYvH6uJCy0vkRCv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041966; c=relaxed/simple;
	bh=tKFgGQfbwoVWIJvxpZIcQ3YzSxEnIsX5INjinrtoy2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tK/7kYlGXGKAlAmNl4BUTrRaM3wyRzLf4t+5crpE8NuvgbUR+S6Ij9DKFlIfnwiDb+ZWrQ9Lpx+Yh+01vu6aR1xdFekJGMoLXswGuWbjYZy2zv1PKPr6UrELPUzEgGlRm+mR/V3Pk8lxYVrsab5Ut/AeVrXIVK3zhW6UJPomD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4MQsEtc; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d3f0958112so350507585a.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751041964; x=1751646764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zYhAsRXe+anL0FLX7VWRba8Q44pCq6siGtCtJV2eksc=;
        b=i4MQsEtcuLXOzyGFVU/AM99iE3ry74s/bAN8rDhufhwDDJTeeb2d91VCBNHCxzsxBQ
         +YtMxSkrtd5QpO0gwkfJrHfwh+5iqtXsL7NfCEjC/DtYjXMHg2WA3dyX/HBCqtzk/Al8
         JaByowKVkznJI5ZwghxyaENPuBj6b1h1x+0hlZkMIr6BZuExbjAHu6uNyR4e5WBYvMXr
         1rDALux5B67cA2bIge9h4/N+kIileUbLuP5fHuP6mFtOQqP8hnuIKNb9lHP3WvocCQtf
         +jGytrMXezeHB03axuieEI9vp5VikpZP5tP6iQ6AHpj9u8AqJd6x9PP5+Nx6zyzuFdEh
         bruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041964; x=1751646764;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYhAsRXe+anL0FLX7VWRba8Q44pCq6siGtCtJV2eksc=;
        b=nkXcZd0204kyVw5Et/eUzFVXQvEystGdPORm4agjgiILbnRpXAuA7V67Dcy5jq+zQd
         PAV8dywPCrX/JAAHZWBgfbmd2wnilZ8FfNBXyA5eWcNveNxIMmJKhmL7rtEavl+rM4aM
         2ZG8rHk11Jv0eZQ3yR6Uk8Z9DleJF3GyNKmK0ULAD+UvnSunnYLG5ZGphZwTKaKA5DJt
         xnsA7/v5OOmXmPHXO018DZACPGliFjmTZ3hnpKy9K9qd0ePos1ZAvS3OfYt1qyO3Yd4a
         j908OHyVguayi2ctQhKV9Hjl83COVpuVzqIehHed2PWoKBBxy44tsj0S29ZTtM+LqWQq
         XzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUua9gXLgaiocL17kQ6Q/dRGigqbYOHrtxzSQE28HSaROyN76eu7GzsxPBez2XlJVKt7YFCT9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmakIMnrt5zWrPieg6q+iXYhN65mllX9N/gGKeFt5mefMNdiN
	dBXx3xW9nTqVb+MdCA+Db3Wojet1/TRIIBLOvxeqvpoBOTC7xAAakd29t9eVTDS9WWo53Cy/fqF
	CAp0nNELIkRlqEA==
X-Google-Smtp-Source: AGHT+IHi61Vek979v2OG6HUDOnzhOkMzytXT/7jHc9jiW3/agaExxcmIQGt8TWWsbaGiTpZosb/3rDoY5THG2Q==
X-Received: from qtbcj9.prod.google.com ([2002:a05:622a:2589:b0:47c:de02:b269])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:488a:b0:4a7:face:ce10 with SMTP id d75a77b69052e-4a7fcac4585mr73093891cf.31.1751041963995;
 Fri, 27 Jun 2025 09:32:43 -0700 (PDT)
Date: Fri, 27 Jun 2025 16:32:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627163242.230866-1-edumazet@google.com>
Subject: [PATCH net-next] net: net->nsid_lock does not need BH safety
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Guillaume Nault <gnault@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

At the time of commit bc51dddf98c9 ("netns: avoid disabling irq
for netns id") peernet2id() was not yet using RCU.

Commit 2dce224f469f ("netns: protect netns
ID lookups with RCU") changed peernet2id() to no longer
acquire net->nsid_lock (potentially from BH context).

We do not need to block soft interrupts when acquiring
net->nsid_lock anymore.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Guillaume Nault <gnault@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/core/net_namespace.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d0f607507ee8d0b6d31f11a49421b5f0a985bd3b..419604d9cf32e2e2a9af59dfef1fbcc7fab81e20 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -319,10 +319,10 @@ int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp)
 	if (refcount_read(&net->ns.count) == 0)
 		return NETNSA_NSID_NOT_ASSIGNED;
 
-	spin_lock_bh(&net->nsid_lock);
+	spin_lock(&net->nsid_lock);
 	id = __peernet2id(net, peer);
 	if (id >= 0) {
-		spin_unlock_bh(&net->nsid_lock);
+		spin_unlock(&net->nsid_lock);
 		return id;
 	}
 
@@ -332,12 +332,12 @@ int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp)
 	 * just been idr_remove()'d from there in cleanup_net().
 	 */
 	if (!maybe_get_net(peer)) {
-		spin_unlock_bh(&net->nsid_lock);
+		spin_unlock(&net->nsid_lock);
 		return NETNSA_NSID_NOT_ASSIGNED;
 	}
 
 	id = alloc_netid(net, peer, -1);
-	spin_unlock_bh(&net->nsid_lock);
+	spin_unlock(&net->nsid_lock);
 
 	put_net(peer);
 	if (id < 0)
@@ -628,20 +628,20 @@ static void unhash_nsid(struct net *net, struct net *last)
 	for_each_net(tmp) {
 		int id;
 
-		spin_lock_bh(&tmp->nsid_lock);
+		spin_lock(&tmp->nsid_lock);
 		id = __peernet2id(tmp, net);
 		if (id >= 0)
 			idr_remove(&tmp->netns_ids, id);
-		spin_unlock_bh(&tmp->nsid_lock);
+		spin_unlock(&tmp->nsid_lock);
 		if (id >= 0)
 			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
 					  GFP_KERNEL);
 		if (tmp == last)
 			break;
 	}
-	spin_lock_bh(&net->nsid_lock);
+	spin_lock(&net->nsid_lock);
 	idr_destroy(&net->netns_ids);
-	spin_unlock_bh(&net->nsid_lock);
+	spin_unlock(&net->nsid_lock);
 }
 
 static LLIST_HEAD(cleanup_list);
@@ -880,9 +880,9 @@ static int rtnl_net_newid(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return PTR_ERR(peer);
 	}
 
-	spin_lock_bh(&net->nsid_lock);
+	spin_lock(&net->nsid_lock);
 	if (__peernet2id(net, peer) >= 0) {
-		spin_unlock_bh(&net->nsid_lock);
+		spin_unlock(&net->nsid_lock);
 		err = -EEXIST;
 		NL_SET_BAD_ATTR(extack, nla);
 		NL_SET_ERR_MSG(extack,
@@ -891,7 +891,7 @@ static int rtnl_net_newid(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	err = alloc_netid(net, peer, nsid);
-	spin_unlock_bh(&net->nsid_lock);
+	spin_unlock(&net->nsid_lock);
 	if (err >= 0) {
 		rtnl_net_notifyid(net, RTM_NEWNSID, err, NETLINK_CB(skb).portid,
 				  nlh, GFP_KERNEL);
-- 
2.50.0.727.gbf7dc18ff4-goog


