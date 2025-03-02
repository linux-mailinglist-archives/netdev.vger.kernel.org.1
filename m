Return-Path: <netdev+bounces-171010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E88A4B19D
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 13:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8975116E082
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB21E5213;
	Sun,  2 Mar 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fhvgm0Bo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14371E500C
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919365; cv=none; b=GgySvS2OW7ZNUZ2P0EXR+9ZUsMrE3b3dhfwVUSTuNaSqNK3OxczyNL6pKd8mC9Xb+KZCJyWBfQqgg82BOyJsCGJuRLF3Hmf/rU3wV488u8155rGarkkkr5vEoFvIvQwVGheKkvipL0WJm9X62n7EnyykxooZUvpII41zJFGIHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919365; c=relaxed/simple;
	bh=RT9lXwDB4DAszEcWZmwZYOGTxbyIsDNtILzbHsxNRQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRJrajRZSYS7PmUjrhvdKYE7g6dWxQIYca0S3pZ9uJy9r5S7czmtnRP7X7/QLeFq68UIQqL2sb7rd+P3J0iSdMJ7wP9gKc8XonCntcXK6PXy1Zlfw4a/nhrKgY3dvEc/ssRz+viLAk6cqA8tpdWwt1k1EWiKJ6p+aqEQE47Y5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fhvgm0Bo; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e8b876f694so22547686d6.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 04:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740919363; x=1741524163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DeiUAO4/StKObvmrt6w+tGgiNpuxOkqU3ZU2aa9xmY=;
        b=Fhvgm0BoP2ZrGr5IRafeLcKCa1M6MoC5sZ2TkXws4PmmtdNR0FkqMwWW1mUsDpznvo
         Zq3hXG4BmRlFRgDbXI2EdIqoN+AozlkGLohz8MWyKtv+ga7eBsM6dLy3ixGgHvjM9GcA
         DIrglBoIhTpwHcGDHw9A6g5RigY5EOdBniWcMkhfveZe6TWVxFb/MqZXfYU4E0V3LaGB
         U5fcJvnDNdWTAGPgKX0PF1hj4xIhhKRoOcFEwEwSkzPlLl+Y+UXF1b9mM0CW9GGvwU21
         JGc8zn5qqxIbKD9Yi/Ka171mKxOX+i6Q/Ufrt/RjtBr/wDx65PJKGt0KOhMZae8bkcHO
         +dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740919363; x=1741524163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DeiUAO4/StKObvmrt6w+tGgiNpuxOkqU3ZU2aa9xmY=;
        b=dOda3abGu4SIfcpS4i4B9KX1/SjlLboUrxXyQAu9WGp7Qc397ZzFb7O/5JDstHQMS4
         52KwO2lAj0w9Rf7DnH7kjYZ3bLyNPAVYdOlBW4RUjDn5BhiVumNVkJM8O+nHLNaiBJgS
         9XFyWmN9bcq34Qw3JKK0kmot2q315HS0n3kmxYmSRaAHpXSb2wgfF0x3OiAjK9UX8dn+
         D9pH4ha893CPrRM9vUHz6abQJzWanX7S3Ymj0oig4cTo2kfudNgiWYGoeLEffPCj9UOn
         G3Kc84+6wEXcPSJOoz0EJ0ghuMergcdJO3eFglHByHCCr9g3BgtY2xoVFUvuVwEXkwbb
         U+rw==
X-Forwarded-Encrypted: i=1; AJvYcCW2L3VewzHRTHCndRPJFqSt/H6//N3Csy4KkJ9lAdJYGCzQ2G3bAYNWc1CbDI7uzkyNP2bxlos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNjqLBMyiUzPJsvejlDvnzSvlNsNf5jU8yW+biEJzP7nFaKqS
	I1XeHNplilYwwjdrvbixXh8LFg/Jyln57pe87r+qGbxJ4rGMrc/fcoTIKhmCk2kEf49uDfJ3IoC
	tgAhepoEQ7A==
X-Google-Smtp-Source: AGHT+IGvCxubxk91szR6C96RduoJOAtQ/Ox2mr6DJgXyEzkBpOcJ38cE7b2Aay+KB4miWSdtmVdj3XWRMNjDOw==
X-Received: from qvbmi8.prod.google.com ([2002:a05:6214:5588:b0:6e8:8dcf:4a50])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f28:b0:6d8:af37:ae5b with SMTP id 6a1803df08f44-6e8a0d9de8dmr138341606d6.43.1740919362776;
 Sun, 02 Mar 2025 04:42:42 -0800 (PST)
Date: Sun,  2 Mar 2025 12:42:36 +0000
In-Reply-To: <20250302124237.3913746-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250302124237.3913746-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] tcp: add RCU management to inet_bind_bucket
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add RCU protection to inet_bind_bucket structure.

- Add rcu_head field to the structure definition.

- Use kfree_rcu() at destroy time, and remove inet_bind_bucket_destroy()
  first argument.

- Use hlist_del_rcu() and hlist_add_head_rcu() methods.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_hashtables.h   |  4 ++--
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/inet_hashtables.c      | 14 +++++++-------
 net/ipv4/inet_timewait_sock.c   |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a421ce8275d4cd83c5771b3f448e5c..73c0e4087fd1a6d0d2a40ab0394165e07b08ed6d 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -89,6 +89,7 @@ struct inet_bind_bucket {
 	bool			fast_ipv6_only;
 	struct hlist_node	node;
 	struct hlist_head	bhash2;
+	struct rcu_head		rcu;
 };
 
 struct inet_bind2_bucket {
@@ -226,8 +227,7 @@ struct inet_bind_bucket *
 inet_bind_bucket_create(struct kmem_cache *cachep, struct net *net,
 			struct inet_bind_hashbucket *head,
 			const unsigned short snum, int l3mdev);
-void inet_bind_bucket_destroy(struct kmem_cache *cachep,
-			      struct inet_bind_bucket *tb);
+void inet_bind_bucket_destroy(struct inet_bind_bucket *tb);
 
 bool inet_bind_bucket_match(const struct inet_bind_bucket *tb,
 			    const struct net *net, unsigned short port,
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index b4e514da22b64f02cbd9f6c10698db359055e0cc..e93c660340770a76446f97617ba23af32dc136fb 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -598,7 +598,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 		if (bhash2_created)
 			inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, tb2);
 		if (bhash_created)
-			inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
+			inet_bind_bucket_destroy(tb);
 	}
 	if (head2_lock_acquired)
 		spin_unlock(&head2->lock);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 46d39aa2199ec3a405b50e8e85130e990d2c26b7..b737e13f8459c53428980221355344327c4bc8dd 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -76,7 +76,7 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
 		tb->fastreuse = 0;
 		tb->fastreuseport = 0;
 		INIT_HLIST_HEAD(&tb->bhash2);
-		hlist_add_head(&tb->node, &head->chain);
+		hlist_add_head_rcu(&tb->node, &head->chain);
 	}
 	return tb;
 }
@@ -84,11 +84,11 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
 /*
  * Caller must hold hashbucket lock for this tb with local BH disabled
  */
-void inet_bind_bucket_destroy(struct kmem_cache *cachep, struct inet_bind_bucket *tb)
+void inet_bind_bucket_destroy(struct inet_bind_bucket *tb)
 {
 	if (hlist_empty(&tb->bhash2)) {
-		__hlist_del(&tb->node);
-		kmem_cache_free(cachep, tb);
+		hlist_del_rcu(&tb->node);
+		kfree_rcu(tb, rcu);
 	}
 }
 
@@ -201,7 +201,7 @@ static void __inet_put_port(struct sock *sk)
 	}
 	spin_unlock(&head2->lock);
 
-	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
+	inet_bind_bucket_destroy(tb);
 	spin_unlock(&head->lock);
 }
 
@@ -285,7 +285,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 
 error:
 	if (created_inet_bind_bucket)
-		inet_bind_bucket_destroy(table->bind_bucket_cachep, tb);
+		inet_bind_bucket_destroy(tb);
 	spin_unlock(&head2->lock);
 	spin_unlock(&head->lock);
 	return -ENOMEM;
@@ -1162,7 +1162,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	spin_unlock(&head2->lock);
 	if (tb_created)
-		inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
+		inet_bind_bucket_destroy(tb);
 	spin_unlock(&head->lock);
 
 	if (tw)
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 337390ba85b4082701f78f1a0913ba47c1741378..aded4bf1bc16d9f1d9fd80d60f41027dd53f38eb 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -39,7 +39,7 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	tw->tw_tb = NULL;
 	tw->tw_tb2 = NULL;
 	inet_bind2_bucket_destroy(hashinfo->bind2_bucket_cachep, tb2);
-	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
+	inet_bind_bucket_destroy(tb);
 
 	__sock_put((struct sock *)tw);
 }
-- 
2.48.1.711.g2feabab25a-goog


