Return-Path: <netdev+bounces-137920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A29AB189
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E777E284C30
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387D126F0A;
	Tue, 22 Oct 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+Ms9EPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CF381AF
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609263; cv=none; b=TBJ5U7d8Xlf2pdvkOTkNK4lmxbFC1n+7FdG4M8XrrBbxKYUcO6ZLc+MDfB22KuaMyp2T/xo2ONps6DM7iyMTcsuqCBGeCGyuZY/V7VTYT1A+szWi+Ky1svdYQg82gydnPnNpGBBR6AZ0UQDoW5C849Lnq1KTxbBDLpxy7jsJZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609263; c=relaxed/simple;
	bh=Jn3bP0F6o5AkCK14WIqEtUKPfP04Z02fuvlQuVfzOqo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HUIDLNPJzbSfu1kg9a/FMpFXiWt8JZoisTaqKsWzSt78k8WFhASWz2jKWO8z+Npp+3U8xKme0Sb3HXKhqixxCHV1t0rq9H3A20zjwUVpzEe2UKO8Lkxzp9hNhisIxirBxE/W+CUMfmlm26s+PePR6HfX/RCO1/ByiEdiXjlWAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+Ms9EPR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so744240276.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729609261; x=1730214061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SAAjeRLi7MznIPI8jN5/0+xnN9Pl5mE/Ln2wtUD6554=;
        b=E+Ms9EPRPieD8+Vk2wGXBKEN/5b4aobMObydSg5oLnjWJDxF5No4qBrW+85wlzgtEi
         OTzk4gTc9IFzdto/TAMisJJtA1YJDBkkVFNJ4ca/1vHewP6pLpq6Et8pw+lOJ20jQDA9
         oeX2lubAtoA2A60dAzQb0Q4FmSQNr+od7yvZQUvbhihcPzrkavBb9+Ma2rxsd5S0xZfn
         V5/Rp6UNhMF0chnyuWrAQofPc8lwV9C+yRyrJ+PTzlnrJ7/d61zfj00KZ0TuEldBaWRo
         7RGS9hL2/n4lHMVFSlVHPLXwOHyqISvRonmxHOmVA6DevBBs+eVmuJHwwCIqZ6SeRXhs
         61yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609261; x=1730214061;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAAjeRLi7MznIPI8jN5/0+xnN9Pl5mE/Ln2wtUD6554=;
        b=B3Q7TsjfK4tlyoCCaD7InCIPntsE1h/zvzA0DcHwFnJsdrldc31finK1UxQV1WbB7Q
         B5FYhtKT+h0eckVa0ZlXTtmhUjW3BjiqnCmDyCGbfRs/r5IATpzHVvqGEFmZKboc449Y
         uZllV5aFyE5ekoa/6SlVZW4iur/xavP9VVLHwCU7iPpzQMRo8R0cVnUCco+tOXgjVB3u
         NwiJgjz4u4ZoerzV5Wb1vAGFVsrIqloyPSKssGKGQxXk63J0NGb5eOeXYsCOSkmOR0De
         dITPy3DY3fcGPN3+emzYw+Q6Jvlp5t6miK27DNdD2cL7bSCAk29fQXLO4b5aJdWBe8fU
         aRGQ==
X-Gm-Message-State: AOJu0YweJ19ey0Bz8mruNGNlDAABHTUvlQrMIJO+iNHA+hHMCbJ2MnDR
	atH21qxdF+PN2WD4oxcasjuBiy9E2WaNF2I1Qd+8WlXdQTK/MAgWvVfEmeYzNqzDXA0sbbwRvVu
	lNeUhmLsFRA==
X-Google-Smtp-Source: AGHT+IF7IOGuKPeSdgITYJ7QAw1nPI2GD5YzwgH2N01ewrR/6q5qQ7DNPPSLP0Gui7CSDYuMigT7PqwMnLePiQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:5f46:0:b0:e2b:d389:b35c with SMTP id
 3f1490d57ef6-e2bd389b637mr6460276.8.1729609260695; Tue, 22 Oct 2024 08:01:00
 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:00:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022150059.1345406-1-edumazet@google.com>
Subject: [PATCH net-next] neighbour: use kvzalloc()/kvfree()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Gilad Naaman <gnaaman@drivenets.com>
Content-Type: text/plain; charset="UTF-8"

mm layer is providing convenient functions, we do not have
to work around old limitations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
---
 net/core/neighbour.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 395ae1626eef2f22f5b81051671371ed67eb5943..4b871cecd2cee9ccc88e5d29d090c49978cbae9f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -14,7 +14,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/slab.h>
-#include <linux/kmemleak.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -538,14 +537,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
-	if (size <= PAGE_SIZE) {
-		buckets = kzalloc(size, GFP_ATOMIC);
-	} else {
-		buckets = (struct neighbour __rcu **)
-			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-					   get_order(size));
-		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
-	}
+	buckets = kvzalloc(size, GFP_ATOMIC);
 	if (!buckets) {
 		kfree(ret);
 		return NULL;
@@ -562,15 +554,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
 
-	if (size <= PAGE_SIZE) {
-		kfree(buckets);
-	} else {
-		kmemleak_free(buckets);
-		free_pages((unsigned long)buckets, get_order(size));
-	}
+	kvfree(nht->hash_buckets);
 	kfree(nht);
 }
 
-- 
2.47.0.105.g07ac214952-goog


