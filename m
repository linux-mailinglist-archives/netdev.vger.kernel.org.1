Return-Path: <netdev+bounces-156327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B898FA061B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC063A141D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C511FF1B0;
	Wed,  8 Jan 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlI6XCjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB81F3D54
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353381; cv=none; b=nz96HYWV95UFuiVODC/MlLelVOQ5MxWU9T9QHjNg3PUMEL+NSquzMVoe2w5JaLPGhFkmr/slxF7fgoTJbOqY2tfoB0IT5bA63QaIikUZf12wNCpraPZ8MaF4sWzV99AVYvEnTKdLjHXeeNp7f6+fkjrqsx2G12ttv1JasppNldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353381; c=relaxed/simple;
	bh=gO8FZqQuv0MMHUrKJJi/pFY0mGOd+fBug1vcRBxPlBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UQhxcDIiwTi4/ETd0W2RYBzF4bq83H9pUqyO8Tm9Tx1BIq3dvu91Ldkjy7LlklGL1eYHFgbumehLW6wcIU2kYKQ3O/PqV4BvKje+MrRhrBfzQMDHT94JE1Mo0VaQrMLuURnMnCDJXT4bBIMTRCKIvhjpv2Si76EiljODuYCApFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AlI6XCjx; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467b0b0aed4so358198071cf.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353378; x=1736958178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlHLQ3o8A1G5EivvnS/riuO3x8kL0WjN5265qdyloXo=;
        b=AlI6XCjxl4lV3ouh8AYrqp67ta5W8AwRXn4wK6o9xzf5hRq5NDTmVNzuZTQ76hJtiP
         la7YIvezCxZnIuzFCIyLO4PsoxRqBgKtASRrxiclcdHVGadB/IpOmEPwzj7baLXWVjsD
         q2ATbRwGVCzmYITnxMd5GdglX7gwQB7I6vJAAXSTNqcqjMcJVsH73yhQL9udWIWrqudc
         +1sFufxCfLdlEo3JFxs/FoO1/oSqGFWoaMa9Iq1mzHO8mlZj4TRwH+E7WnqxzpjDfkxH
         7aQJQBMYaUWH9msNzA+rTmRqLF6LFEMTqi89tol0eRRHcP2ivVb1B9BeAjX0dEb+oSvc
         T8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353378; x=1736958178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlHLQ3o8A1G5EivvnS/riuO3x8kL0WjN5265qdyloXo=;
        b=pMJ2eZurnSTFk6EnuXrE9ojR3Xgl9Jv6Gz0Pv/Lk3FiQj80L6JfoctiZqMa4/FPTYg
         fiu+bc143FnliYKKL4dGfpDFC5SbymPQhoQR1jz3/XMkieQOaZdA2D01kcQvpiO0Ib5s
         lguzZTXHPlkdQ7Dx9em8FgxbZorZgSdAzGmU803Xbjbtx+l0mSl9gptPIeKkxqGKUDPa
         ivBT1ft6Kp4SqNhixbp+ZZMpC1V0lmof7F/i2wwSfr/SQ5hWuCxU/EgpZ4tbojNJMosC
         cYl8UdNCA0gIPXwoQRYMxI6bUAOYbnkDnLp+VtPs5ON7G/YePnP/ErqcDB8Rn/lcpaNd
         JaMA==
X-Gm-Message-State: AOJu0Yz4iXS9h3AD3hZdJeZ0jEeJ6JRzq77F1rM8DBBDi1E+EHzab+fN
	yZ3/bml4B3kphhZxxyM3f2dgJ2kszACVv5vTtEVbcONITinZvBjzV6PjWrg3Xb6HmkwBZjnb1qq
	C1iuCaarnAg==
X-Google-Smtp-Source: AGHT+IER3D8Lo7We55c5NFeeiOmidG1Z0nHt/Q5a14U3TlcF0Yht6SHL506p55ReHJu6dyaQISHSVENXwbknDg==
X-Received: from qtjf12.prod.google.com ([2002:ac8:134c:0:b0:467:8f83:cafe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:214:b0:467:5eb6:5153 with SMTP id d75a77b69052e-46c70ff77f9mr45828611cf.19.1736353378655;
 Wed, 08 Jan 2025 08:22:58 -0800 (PST)
Date: Wed,  8 Jan 2025 16:22:52 +0000
In-Reply-To: <20250108162255.1306392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108162255.1306392-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108162255.1306392-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net: expedite synchronize_net() for cleanup_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cleanup_net() is the single thread responsible
for netns dismantles, and a serious bottleneck.

Before we can get per-netns RTNL, make sure
all synchronize_net() called from this thread
are using rcu_synchronize_expedited().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/net_namespace.h | 2 ++
 net/core/dev.c              | 7 ++++++-
 net/core/net_namespace.c    | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 5a2a0df8ad91b677b515b392869c6c755be5c868..a3009bdd7efec0a3b665cbf51c159c323458410a 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -565,4 +565,6 @@ void net_ns_init(void);
 static inline void net_ns_init(void) {}
 #endif
 
+extern struct task_struct *cleanup_net_task;
+
 #endif /* __NET_NET_NAMESPACE_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index efbe2c4d94580a2ce9401adb85784c9c1c862df9..76ad68b129eed0407686e8696102aeed9a8b30ec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11415,6 +11415,11 @@ struct net_device *alloc_netdev_dummy(int sizeof_priv)
 }
 EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
 
+static bool from_cleanup_net(void)
+{
+	return current == cleanup_net_task;
+}
+
 /**
  *	synchronize_net -  Synchronize with packet receive processing
  *
@@ -11424,7 +11429,7 @@ EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (from_cleanup_net() || rtnl_is_locked())
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b5cd3ae4f04cf28d43f8401a3dafebac4a297123..cb39a12b2f8295c605f08b5589932932150a1644 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -588,6 +588,8 @@ static void unhash_nsid(struct net *net, struct net *last)
 
 static LLIST_HEAD(cleanup_list);
 
+struct task_struct *cleanup_net_task;
+
 static void cleanup_net(struct work_struct *work)
 {
 	const struct pernet_operations *ops;
@@ -596,6 +598,8 @@ static void cleanup_net(struct work_struct *work)
 	LIST_HEAD(net_exit_list);
 	LIST_HEAD(dev_kill_list);
 
+	cleanup_net_task = current;
+
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
 
@@ -670,6 +674,7 @@ static void cleanup_net(struct work_struct *work)
 		put_user_ns(net->user_ns);
 		net_free(net);
 	}
+	cleanup_net_task = NULL;
 }
 
 /**
-- 
2.47.1.613.gc27f4b7a9f-goog


