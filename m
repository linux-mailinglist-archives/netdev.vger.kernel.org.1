Return-Path: <netdev+bounces-198660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7C1ADCFA9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F8B3A92AD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E082E7167;
	Tue, 17 Jun 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4YUdIju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADB2ED14F
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169636; cv=none; b=qe/L7BkMDdJiYzMY8Y16LcOLABnMNeZ716YlhwjUMlR4aAJktNlbM51o0o4S2BNNL+Yoo+KnQtpzraKbRW65R3WVkvll6IklMeHPf9x0LgAL+vuQ7hNLU/+ZK6TJyBZMJU8S9Pk6mtXc9K+0L/pVN34BebC7Pl/xHVg0MoHEZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169636; c=relaxed/simple;
	bh=9Jr/nh5zsSZ6ZfHN9eMSmD1nuDAFx7H7tNJbmsTCZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3oV7Of+U5OqEEKDlUztSs/5V3Ek3engsUREsOHWDqn+k3VwVZstIZYP/N3mmqttPHNJFqjfIm7aO+g41aA8kt8a6k2DlH8g2Xk6LyZToQInNIU10h8fLGa/YDxlz9witKRU4+HGnjuf72DJEApCPo/aDPi/IT4Ck/KaoY3CNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4YUdIju; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cea01b9cso26970685e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169633; x=1750774433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihNvZAx/taNs+ys12ArC1X8y+CGszG5ocAZrN4df6AA=;
        b=M4YUdIjuDMBngNaL4VsKnzq+gHoffpemvXhYECUPeCsCwe06KjKWcyE20c9+OiqN58
         2Nu3YjqVFOIjD9KLkCT6c6XUs5Uw0oBrqP5uphhBYxJbupDHt/NiOTJrMoIKhS1Txj3t
         D4rrEBByEbjCfTkrkAImqHnVJqR7koe+sc64nUTJYg1rIpjXZlnEwtz1vGhF2ZG1qL0L
         rnWUWmMJpG1qDBcTZSroFdX/vmqicRDG67a0bjBDyFcMFreJZDxJhOzGWTSkTjfYhKxA
         njewD3uOqMREDp3qiNU/lqoT4V4iwA8UqHPJZhG97TZtziaNo6Pk2zUNYnB2KkLw7M2T
         uJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169633; x=1750774433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihNvZAx/taNs+ys12ArC1X8y+CGszG5ocAZrN4df6AA=;
        b=noplIfEeXBUj466k8ULm4/N+dyKlSoHo4UcI7/me2JDTNUCqE1WISoOXv3zYOmTCVa
         23WuPvDCjI/emLv+0YnLhLy2NmShKkoOaeiiSj4MbAiHZigECwFWjpM6X3dhOuroTV2h
         AD3BzjBMKs/2+Z8dE9X7jShVo0DWBXHZ3kBRWnYi2VVpIBOZJv8ijqrdGwR2BTdDBBe3
         UhR1p1ilhI1TyOKxBRKuXeqyQZU821Imi3T4XMqHr3ubdt617m9/TmCbyhTEDDGmaBY1
         fE7/Ik0I8lrEghHDzh/Z0Vq9Dho0merp0BqfU+ssnzLRVyIF+soLYlHsEBI/hyUZ3CqI
         WJEQ==
X-Gm-Message-State: AOJu0Yyc+o+iqzA5KRw+ArfFYIpuicrHQTi6sg1+PAnhTTDzJThVtJ/H
	hfE6mrwe8f7NTLJtn5m0+/vLyuOk3TqpJ9yBGmotPw7wa7PxJzxEmwnw
X-Gm-Gg: ASbGncuSoHg/AoOVVOaxM5GH0Y/bnw264bE+PK5LhqtK8qxG+FoPQvPZwawqztVKH6L
	ZJRenHhFZ+xuScQxcosN3v9rSGkeJUO+ZeSDOZ9AU4Dteg5B87/5btFCJbCisIQje0OWs/LbSaA
	DmNIbNiLqdCgu27xYDQdLWHJmrg3Fiin7KKHJ4cdYSxBZo1TaeD6+jsnKAG4XxUa2AiGMvW5snW
	Kr9vU0i6OcQYIT8DXFkf7Pw1zl0mYMOYa/sWqZ2gojcIsTsfq3IG6RSmNJn9LHx4IuhASlAiiQD
	b7emYbeQ/Y7xcjTSjNxRzT0mkgu9jAQg8hvQHZYBBoDY9j2vsr+WqZ1cXq9mobItJQSzMjDqDcs
	ohmXXLOEpy+Stuj86ZEw=
X-Google-Smtp-Source: AGHT+IHDX8sOKNZo6OEqLotACfIgLKLRmuqZ0u8VePquxSO1bdaxOxSuiz+ju+UCfRqpQWvden+UMg==
X-Received: by 2002:a05:600c:1e1d:b0:453:b44:eb69 with SMTP id 5b1f17b1804b1-4533ca7518dmr145435125e9.13.1750169632508;
        Tue, 17 Jun 2025 07:13:52 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224600sm178837315e9.8.2025.06.17.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:13:52 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	decot+git@google.com,
	kuniyu@google.com,
	gnaaman@drivenets.com,
	Nicolas Escande <nico.escande@gmail.com>
Subject: [PATCH net-next v2] neighbour: add support for NUD_PERMANENT proxy entries
Date: Tue, 17 Jun 2025 16:13:34 +0200
Message-ID: <20250617141334.3724863-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussesd before in [0] proxy entries (which are more configuration
than runtime data) should stay when the link (carrier) goes does down.
This is what happens for regular neighbour entries.

So lets fix this by:
  - storing in proxy entries the fact that it was added as NUD_PERMANENT
  - not removing NUD_PERMANENT proxy entries when the carrier goes down
    (same as how it's done in neigh_flush_dev() for regular neigh entries)

[0]: https://lore.kernel.org/netdev/c584ef7e-6897-01f3-5b80-12b53f7b4bf4@kernel.org/

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 include/net/neighbour.h |  1 +
 net/core/neighbour.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 9a832cab5b1d..c7ce5ec7be23 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -182,6 +182,7 @@ struct pneigh_entry {
 	netdevice_tracker	dev_tracker;
 	u32			flags;
 	u8			protocol;
+	bool			permanent;
 	u32			key[];
 };
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 49dce9a82295..85a5535de8ba 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -54,7 +54,8 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev);
+				    struct net_device *dev,
+				    bool skip_perm);
 
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
@@ -423,7 +424,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
-	pneigh_ifdown_and_unlock(tbl, dev);
+	pneigh_ifdown_and_unlock(tbl, dev, skip_perm);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
@@ -803,7 +804,8 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 }
 
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev)
+				    struct net_device *dev,
+				    bool skip_perm)
 {
 	struct pneigh_entry *n, **np, *freelist = NULL;
 	u32 h;
@@ -811,12 +813,15 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
 		np = &tbl->phash_buckets[h];
 		while ((n = *np) != NULL) {
+			if (skip_perm && n->permanent)
+				goto skip;
 			if (!dev || n->dev == dev) {
 				*np = n->next;
 				n->next = freelist;
 				freelist = n;
 				continue;
 			}
+skip:
 			np = &n->next;
 		}
 	}
@@ -1983,6 +1988,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 1);
 		if (pn) {
 			pn->flags = ndm_flags;
+			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
 			if (protocol)
 				pn->protocol = protocol;
 			err = 0;
-- 
2.49.0


