Return-Path: <netdev+bounces-233411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E85C12C82
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB35E217B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B492853F8;
	Tue, 28 Oct 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRysW0EQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E227F4E7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622720; cv=none; b=ozJpwa7j0NiW6rHO9PxTQw1MEnmgr5cy2JaTez6p9AJ00+t3nMWBTMn4nnKFiSckaicUrsU5jHUr+YXsfeXJ+Br/J6KWcZItfl4zf+ta4NYQCPZBWBBb3SHiKG5jFQybNqcLES1HeRzwKj6PTNICRKUixhapwQRG8Qlysx4vdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622720; c=relaxed/simple;
	bh=HNuVwQ7PTZTeguJUB7hITAxWe6vznEriGrKxDOnCV8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TJ9MDCEuhIGePCQNzZ1LrpwoOIrUTQ3mKdymj33Du/FvUXtCmGzwNPX1Z/IDaiu5GR7hvv5o96kpu+AkCO/vwuYdiA7sMS9LQGX79WccnOsj4PK0dRlnKsyxoVd6Q8ZISKzyQbokRFEendvOoVRApmQ0eCGhcgTgO17JKppfonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRysW0EQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so4362270a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622718; x=1762227518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IaJlTeEYy9ZEKivBVSnh1X0D7j/72yaCwG7Ujuaf/c=;
        b=DRysW0EQhLS/o2rwxufeYDNFn21uOqv1Gt/5JpLC15ED4F/emPe8haR6568xZUoyho
         a7zsTTW4QMH/VsBKcb1vr4v2AHrI/xbLuMrQVGkkbUlCCnH7264Ojge6PsmxzlzCFe+n
         adApUfnUVcCG6SX1ENa7kQJ47b7reeQbgOh34aOTw8tzSBH8442Yr2S8elHXvFKoXeHo
         KH/wCkvN1pxgj7P7/e3Ke9csWClpy70XTAH1b2G9/FUVYXND2Ha+zUkQYPfD/29O/cb4
         Z49zpHudlStlRInxHxGHV/tsb/vrPW+GiYBFQra7GqneFy95UeSbn3RSgTcMSmzumxNw
         GA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622718; x=1762227518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IaJlTeEYy9ZEKivBVSnh1X0D7j/72yaCwG7Ujuaf/c=;
        b=A+LjVkMyCV1aG4zIPD60LHD78GbowwwiUgJWFBSfxbduSbYoPe7yKoSlfi92VNug3T
         Hx070KOdUJNKksW7wX8LIU6rHuJ+4kL5pZkFvzScEGsXywE4HbK8A3OdfEo7HXY15Lcc
         B5j+vMuzJuIeRWxNSfUSWXhST2KnKfhKMzk3kjf/Ht6Da5x77bTGfjhRTcG4hCrMLq0Z
         QJ9XCxeOaZtGFmkQER9f8BFKBt8peQYak8aindCjMcKXadWu58SngZjTivkpcMlJyCYa
         vywlTOtZF9MQMUYgMJgem5hDch9dVoCGxVdT25PzU3dt9WEdhZU+/CIBy0RMPQbCGTkL
         6isg==
X-Forwarded-Encrypted: i=1; AJvYcCXAtVqGitt7UgjmZ1YXnS/bPjukUhNfnxjh1bUqWAvxpAbjVMwTlH3tgDrCn8YzgtCKVdOEy9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJTSfFj2pevbMQirqiASFVnV5Jc16Kok0WrP2L/PVpNJ7npmZ
	ubB2avohrbPFWq7vGntmZT+z1SU0cD5rcktKHdWqeul6ZwR/pupeZ+8lg9wq3rC9TFIwWnxTT5C
	QTKViug==
X-Google-Smtp-Source: AGHT+IH4cmlM345lwrLFxTyf5BRQL7abBZSn6R6RM+Uj7sx53ZY7o3UWkblqqf0QHii9BXTqShpB4rH9PNA=
X-Received: from pjbmd3.prod.google.com ([2002:a17:90b:23c3:b0:32b:35fb:187f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b41:b0:32e:ddbc:9bd6
 with SMTP id 98e67ed59e1d1-34027aac10fmr2237424a91.27.1761622718550; Mon, 27
 Oct 2025 20:38:38 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:03 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/13] mpls: Add mpls_route_input().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_route_input_rcu() is called from mpls_forward() and
mpls_getroute().

The former is under RCU, and the latter is under RTNL, so
mpls_route_input_rcu() uses rcu_dereference_rtnl().

Let's use rcu_dereference() in mpls_route_input_rcu() and
add an RTNL variant for mpls_getroute().

Later, we will remove rtnl_dereference() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index a715b12860e9..530f7e6f7b3c 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -75,16 +75,23 @@ static void rtmsg_lfib(int event, u32 label, struct mpls_route *rt,
 		       struct nlmsghdr *nlh, struct net *net, u32 portid,
 		       unsigned int nlm_flags);
 
-static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
+static struct mpls_route *mpls_route_input(struct net *net, unsigned int index)
 {
-	struct mpls_route *rt = NULL;
+	struct mpls_route __rcu **platform_label;
 
-	if (index < net->mpls.platform_labels) {
-		struct mpls_route __rcu **platform_label =
-			rcu_dereference_rtnl(net->mpls.platform_label);
-		rt = rcu_dereference_rtnl(platform_label[index]);
-	}
-	return rt;
+	platform_label = rtnl_dereference(net->mpls.platform_label);
+	return rtnl_dereference(platform_label[index]);
+}
+
+static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned int index)
+{
+	struct mpls_route __rcu **platform_label;
+
+	if (index >= net->mpls.platform_labels)
+		return NULL;
+
+	platform_label = rcu_dereference(net->mpls.platform_label);
+	return rcu_dereference(platform_label[index]);
 }
 
 bool mpls_output_possible(const struct net_device *dev)
@@ -2373,12 +2380,12 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	u32 portid = NETLINK_CB(in_skb).portid;
 	u32 in_label = LABEL_NOT_SPECIFIED;
 	struct nlattr *tb[RTA_MAX + 1];
+	struct mpls_route *rt = NULL;
 	u32 labels[MAX_NEW_LABELS];
 	struct mpls_shim_hdr *hdr;
 	unsigned int hdr_size = 0;
 	const struct mpls_nh *nh;
 	struct net_device *dev;
-	struct mpls_route *rt;
 	struct rtmsg *rtm, *r;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
@@ -2406,7 +2413,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 		}
 	}
 
-	rt = mpls_route_input_rcu(net, in_label);
+	if (in_label < net->mpls.platform_labels)
+		rt = mpls_route_input(net, in_label);
 	if (!rt) {
 		err = -ENETUNREACH;
 		goto errout;
-- 
2.51.1.838.g19442a804e-goog


