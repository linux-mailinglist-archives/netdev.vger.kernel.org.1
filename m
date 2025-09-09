Return-Path: <netdev+bounces-221342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C3B503CD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1B3B8996
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463D36CC96;
	Tue,  9 Sep 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="N285UPjI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F71176FB1
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437225; cv=none; b=uIKnSTTQ/f+mxjJD9hHxuY42fs8gh8rL5LYp3k6naOuvJ8WSBYiXzCsAp7nOhcXxT8ISIz8zsll1YAP9UWWL3s1q21K268xR4i8736FwKbHAJIWF4Mp9Yd0G0mYaAdsQJjOQcebA+/jfnMFHqhvW1MFaxJjFMlFTPwRQwhRnz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437225; c=relaxed/simple;
	bh=YOheNea8w4oFvaJYrcoKVJ05SYnlnHJweU0Z+hN4aqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7iJ3lBHcz5TomaRfQjzl0gVCqnu0fl79+wTDXCTY8YR/gA9bZYIaduERRxT+evw9L+IjxZ/Xx40yW6A+pbjQYEeIiioEQqaOd9478KYp67RKgoA44rBneE/47ZQhSH48jJ1ifmww7b3s1m7js0zNmjvz8AclKcssGZTENoXD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=N285UPjI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47174b335bso583630a12.2
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437223; x=1758042023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqze7iwG5Ry+dDBARlSyhuUqRONuSWeSjCIo66sdoYI=;
        b=N285UPjI5uT8wPT9LdT8CKMfrgJTX+vJOqWX1awm+E4mRW68tns5QjLu9TrAIC3D0A
         +UBuhNEHDYl8eW2N7s7JL7ysTNxQTBO87u/Cy00TQwVGPhyLuPpi4MJBM0bn3Icpqq9K
         K/j5wwr8c4KzWstseJRILsmV0dlGgwS954mdtpeYAurjZcAc2Q/n55nNK/cB83qh/Liy
         BGMs3Z3w4UW49yglQyX/LBqOeFfYH4bS5n/gDkWkU9yOSNu+O4hbO2lfrP5NGbX7VWq/
         vi9CAc9FNvqdhVwMq1/27raeeB+f96Fd+T9FdzlQFyKVHEKME7CxRQCZjACD9EaocWd1
         BgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437223; x=1758042023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqze7iwG5Ry+dDBARlSyhuUqRONuSWeSjCIo66sdoYI=;
        b=Q31P3j62ip/KdXBlL4cmi7XjHnGUNwB6NKVDSE14yiJE/1iVASa1cw0VEK1gBaCTDY
         dkyK62QjrP+o7Cj4khPEJKX4DzVaumNn196BQmEdzr+R4MYorqGfqNODBNZ0a07euakg
         hGioevd7bseYRO5KETGGPB8GOQ1gz4/aIFu7oKC34hpYvdH1JTEoZjFZ7TTw5hlxuDkh
         3hSr6AS9m8jbIUFrOFg71fh5a5TcyQCW7Zi7qVT/vYUl39Im23a3lDz/UemF1ep4K0BH
         Dod5lYG2LURmeYdvytpiF8PsbmlPox9geFt+UsW08BbYv8TuksPKkuyrM2m3UMXraRNB
         esmw==
X-Forwarded-Encrypted: i=1; AJvYcCVg57gtmVOQnpfhUeSFV/GGEmm/bF4+TG1PM2GDS9eqJVWjGVQ8388XOPcU+55i+QRUanb2CwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxktpLyiYzr1LxG6ge3n+nHNF7yBsCtlryQmnaVXTtAlO3/kmZh
	sfvKlBsd68i7Thgl/A8KcUKqZCkm3676seUDY0+l74979H7zGYqOioWP38pEqCofwjo=
X-Gm-Gg: ASbGncsQkJeeSNP7U0CM0cr6SY/55fdKp2gccvBfsgKrfUEk+Tk6/0z6L8kjr/E/9py
	ZNSEDraSeBqy1VOqRvE8AV2HGelxu1wyFG52okpwqIK+NyPaEy6YTLJWkXoEUU6gYEtSnGbOcdR
	OXdp6+uhWnJRZ9SJ5zG8UYl+OCJknCR19QbpiAy9M/FXyEftxTO+X+Nk26U1NrBEU8vvKZqk3f4
	rgSI/j99vxIVcoOVRbRa3EjGJ75hh6jMz3ZYcKRke7FxOPZ9ZsuVepyujznvvbmhJz2hB10kXun
	uXoIgtgjQ4i0WgJSHEvd/LDVjvGjv3Tsmb2YDcS1e1l1v4RgafqnE8YoMjx0+JjLNiTksVkP4yG
	1wK4xGVvn0KMOYftI4bPDwJVo
X-Google-Smtp-Source: AGHT+IGgBbvSKHyPB+9E0Dr0eVfimKEokb7a96nOk+yHQ1AsR/F/uGf1DXWJ1JgkdL3C3K+6oI879g==
X-Received: by 2002:a05:6a20:4322:b0:24a:3b34:19cb with SMTP id adf61e73a8af0-2534441f6cdmr11016881637.3.1757437223313;
        Tue, 09 Sep 2025 10:00:23 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:22 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 01/14] bpf: Use reference counting for struct bpf_shtab_elem
Date: Tue,  9 Sep 2025 09:59:55 -0700
Message-ID: <20250909170011.239356-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use reference counting to decide when to free socket hash elements
instead of freeing them immediately after they are unlinked from a
bucket's list. In the next patch this is essential, allowing socket
hash iterators to hold a reference to a `struct bpf_shtab_elem` outside
of an RCU read-side critical section.

sock_hash_put_elem() follows the list, scheduling elements to be freed
until it hits an element where the reference count is two or greater.
This does nothing yet; in this patch the loop will never iterate more
than once, since we always take a reference to the next element in
sock_hash_unlink_elem() before calling sock_hash_put_elem(), and in
general, the reference count to any element is always one except during
these transitions. However, in the next patch it's possible for an
iterator to hold a reference to an element that has been unlinked from
a bucket's list. In this context, sock_hash_put_elem() may free
several unlinked elements up until the point where it finds an element
that is still in the bucket's list.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 67 +++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 5947b38e4f8b..005112ba19fd 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -847,6 +847,7 @@ struct bpf_shtab_elem {
 	u32 hash;
 	struct sock *sk;
 	struct hlist_node node;
+	refcount_t ref;
 	u8 key[];
 };
 
@@ -906,11 +907,46 @@ static struct sock *__sock_hash_lookup_elem(struct bpf_map *map, void *key)
 	return elem ? elem->sk : NULL;
 }
 
-static void sock_hash_free_elem(struct bpf_shtab *htab,
-				struct bpf_shtab_elem *elem)
+static void sock_hash_free_elem(struct rcu_head *rcu_head)
 {
+	struct bpf_shtab_elem *elem = container_of(rcu_head,
+						   struct bpf_shtab_elem, rcu);
+
+	/* Matches sock_hold() in sock_hash_alloc_elem(). */
+	sock_put(elem->sk);
+	kfree(elem);
+}
+
+static void sock_hash_put_elem(struct bpf_shtab_elem *elem)
+{
+	while (elem && refcount_dec_and_test(&elem->ref)) {
+		call_rcu(&elem->rcu, sock_hash_free_elem);
+		elem = hlist_entry_safe(rcu_dereference(hlist_next_rcu(&elem->node)),
+					struct bpf_shtab_elem, node);
+	}
+}
+
+static bool sock_hash_hold_elem(struct bpf_shtab_elem *elem)
+{
+	return refcount_inc_not_zero(&elem->ref);
+}
+
+static void sock_hash_unlink_elem(struct bpf_shtab *htab,
+				  struct bpf_shtab_elem *elem)
+{
+	struct bpf_shtab_elem *elem_next;
+
+	elem_next = hlist_entry_safe(rcu_dereference(hlist_next_rcu(&elem->node)),
+				     struct bpf_shtab_elem, node);
+	hlist_del_rcu(&elem->node);
+	sock_map_unref(elem->sk, elem);
+	/* Take a reference to the next element first to make sure it's not
+	 * freed by the call to sock_hash_put_elem().
+	 */
+	if (elem_next)
+		sock_hash_hold_elem(elem_next);
+	sock_hash_put_elem(elem);
 	atomic_dec(&htab->count);
-	kfree_rcu(elem, rcu);
 }
 
 static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
@@ -930,11 +966,8 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	spin_lock_bh(&bucket->lock);
 	elem_probe = sock_hash_lookup_elem_raw(&bucket->head, elem->hash,
 					       elem->key, map->key_size);
-	if (elem_probe && elem_probe == elem) {
-		hlist_del_rcu(&elem->node);
-		sock_map_unref(elem->sk, elem);
-		sock_hash_free_elem(htab, elem);
-	}
+	if (elem_probe && elem_probe == elem)
+		sock_hash_unlink_elem(htab, elem);
 	spin_unlock_bh(&bucket->lock);
 }
 
@@ -952,9 +985,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
-		hlist_del_rcu(&elem->node);
-		sock_map_unref(elem->sk, elem);
-		sock_hash_free_elem(htab, elem);
+		sock_hash_unlink_elem(htab, elem);
 		ret = 0;
 	}
 	spin_unlock_bh(&bucket->lock);
@@ -985,6 +1016,11 @@ static struct bpf_shtab_elem *sock_hash_alloc_elem(struct bpf_shtab *htab,
 	memcpy(new->key, key, key_size);
 	new->sk = sk;
 	new->hash = hash;
+	refcount_set(&new->ref, 1);
+	/* Matches sock_put() in sock_hash_free_elem(). Ensure that sk is not
+	 * freed until elem is.
+	 */
+	sock_hold(sk);
 	return new;
 }
 
@@ -1038,11 +1074,8 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	 * concurrent search will find it before old elem.
 	 */
 	hlist_add_head_rcu(&elem_new->node, &bucket->head);
-	if (elem) {
-		hlist_del_rcu(&elem->node);
-		sock_map_unref(elem->sk, elem);
-		sock_hash_free_elem(htab, elem);
-	}
+	if (elem)
+		sock_hash_unlink_elem(htab, elem);
 	spin_unlock_bh(&bucket->lock);
 	return 0;
 out_unlock:
@@ -1182,7 +1215,7 @@ static void sock_hash_free(struct bpf_map *map)
 			rcu_read_unlock();
 			release_sock(elem->sk);
 			sock_put(elem->sk);
-			sock_hash_free_elem(htab, elem);
+			call_rcu(&elem->rcu, sock_hash_free_elem);
 		}
 		cond_resched();
 	}
-- 
2.43.0


