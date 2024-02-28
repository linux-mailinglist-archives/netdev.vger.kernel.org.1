Return-Path: <netdev+bounces-75751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4686B0F6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D21C21548
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC61552EA;
	Wed, 28 Feb 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTqeh6Ap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B1158D66
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128504; cv=none; b=FA2ZvXopJMObm9LDghGcQYpj+vvyT+CVhxGc6V6N+ri3maX81b14d005Ftsu6lqFR85gXW4Bz99geZ1EMbal4SJe/SKSU7N5FS6TodYjTfHc9ku4X7/OPOTR6q6iM2NiCraXeOV0GChGK0ULCanvZJva0IRDvQuz+pU2siT0ZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128504; c=relaxed/simple;
	bh=Avi97JMj+FX+r0ctgFZtnz6JEj8JCuE0CB279mVyCyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nVGXvDnq06aWbJ4lF5FkFHC6z8FagpWRkYzsnsvUtgUA4/DSsX219gP3Z4yo9YirID6nA0kFf/jvupo6Av6+S5N2esrv+xM/19KL16WsZGFzM8gY3fA/xqdO6TLKjl/5EWGd3wUQgQh/6BZLe+8seEXqUguuKWdKLl9MIH7Lf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTqeh6Ap; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso13444887b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128502; x=1709733302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk2C3ivOITUuGaOou7Ec/yRMlCsy5fQgerbe/Ye8Ii8=;
        b=yTqeh6ApDLWeCcecNDggGpALSYwrT477PQ3kQIo7WbzeWsbqBOMY42JBajLoHs30U6
         /FGDTBqMxOaLpBR/eLsNBpkWWwXlffn1udwcn9ec/DPSRn+ymzrkTSvp+p/YL+xbjpEc
         PVip0RXquNnJ8/19AohYuOcMQgnBLTDl+BVxUT37rLbFsVeFROUJBt9G7z0d4J6EXvMy
         QzlKmqtFD/H1w9pCgCLT5L2LuLSXDJZAxRH1feBO+YF3oR5M1RIXwZW5mdP+xj0IbSRT
         7u+3olJ7tJUNZ25F1yNN6/sCIaKCs0z3vmdti/4+UF4eNXWe85X4DezSwmcsWTomAvI0
         Xamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128502; x=1709733302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tk2C3ivOITUuGaOou7Ec/yRMlCsy5fQgerbe/Ye8Ii8=;
        b=MZQmy/v30JGEFP/+06JT/E1f7Cbrs+GhtBy4RTgMYg1laYGbPTgc53AYuoy/3uVHM7
         oZWjsWMHmpbU0GwlIjLciJ0/NIfMqo+q9e1SwFaTSq224k+D+ubP7+ImfEfii+LwDJSY
         JS+L0z7xFbJKJot0sN/0UKJd/ZoCG/XJhkEpyOwrVDfK2x084IHlpU6U8vTM66iajOI6
         lyGvSEysWDUiDKQJhta892o2eyvmJLfcvXPgjVwKVoL11kkjO36r1Q05oRDGiNK2r3/l
         9BanPU68Dsu53MspQzCPfWggCtGvrqESWA9uMqHMudvF3BmfJllPBCE6rMpEsO+k3MVW
         zjUA==
X-Gm-Message-State: AOJu0YzjOzPrK/4hm4bqS6kZGuEKOJ/4wMlTUn0D8mYhe5KQviJMzi2j
	M3D+QdjC/AiVbd/g/U7Mh+Bs0BZ89yd7UjHpYyJBdEut9Lihx/Og8OwYG+gNssoX5Jw3/sMZJ8v
	xsel4jZkW1A==
X-Google-Smtp-Source: AGHT+IGz40cy3krJGgRG4YR5gYwQUW+D+9a623RfqW8WQDglK+SYYRDWl4yctJYjwng7r3vzeMv4VCJ13eVQsw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:db8b:0:b0:607:8f65:5433 with SMTP id
 d133-20020a0ddb8b000000b006078f655433mr509353ywe.4.1709128502138; Wed, 28 Feb
 2024 05:55:02 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:35 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-12-edumazet@google.com>
Subject: [PATCH v3 net-next 11/15] ipv6: annotate data-races around devconf->disable_policy
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.disable_policy and net->ipv6.devconf_all->disable_policy
can be read locklessly. Add appropriate annotations on reads
and writes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c   | 2 +-
 net/ipv6/ip6_output.c | 4 ++--
 net/ipv6/route.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 18b1e79c1ebf8de17f813ef697be69e3d9c209a2..865fb55d0a2c7084cb80a704ad4fb2d97938bab4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6698,7 +6698,7 @@ int addrconf_disable_policy(struct ctl_table *ctl, int *valp, int val)
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	*valp = val;
+	WRITE_ONCE(*valp, val);
 
 	net = (struct net *)ctl->extra2;
 	if (valp == &net->ipv6.devconf_dflt->disable_policy) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f08af3f4e54f5dcb0b8b5fb8f60463e41bd1f578..b9dd3a66e4236fbf67af75c5f98c921b38c18bf6 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -513,8 +513,8 @@ int ip6_forward(struct sk_buff *skb)
 	if (skb_warn_if_lro(skb))
 		goto drop;
 
-	if (!net->ipv6.devconf_all->disable_policy &&
-	    (!idev || !idev->cnf.disable_policy) &&
+	if (!READ_ONCE(net->ipv6.devconf_all->disable_policy) &&
+	    (!idev || !READ_ONCE(idev->cnf.disable_policy)) &&
 	    !xfrm6_policy_check(NULL, XFRM_POLICY_FWD, skb)) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
 		goto drop;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1b897c57c55fe22eff71a22b51ad25269db622f5..a92fcac902aea9307e0c83d150e9d1c41435887f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4584,8 +4584,8 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 		f6i->dst_nocount = true;
 
 		if (!anycast &&
-		    (net->ipv6.devconf_all->disable_policy ||
-		     idev->cnf.disable_policy))
+		    (READ_ONCE(net->ipv6.devconf_all->disable_policy) ||
+		     READ_ONCE(idev->cnf.disable_policy)))
 			f6i->dst_nopolicy = true;
 	}
 
-- 
2.44.0.rc1.240.g4c46232300-goog


