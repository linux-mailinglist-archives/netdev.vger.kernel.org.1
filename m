Return-Path: <netdev+bounces-221347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E9B503D4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143F81623B8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAFA36CDE2;
	Tue,  9 Sep 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vK7kx+GQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AE36CDE7
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437235; cv=none; b=XUyr6b1Fp4INLrcdVEO3aY5jQyWgayQuHon4O4BD4Hn0zT3czXTtrYLarAc9TpCCL3vBBxIDpAHvEnMs0//v1u6Jajycb2Cl5Ebcr1pD9/n3WvZ/t/Z6wk4O9fEadbNa6MO2mGrwS7uaIRUXbwj+cNK7Fo4rtKLh5TZ6fmTWuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437235; c=relaxed/simple;
	bh=egQpDOFrgOXtIaD3L6zocsW40+1jaTMwkNz+QDXAqKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXeupIYrdOZm7JTnKAvZKnSJ/fNSLMPjAUKGZZ5RWWGyP8UGVI2OtLTiZjYo4aJlUwh3obgyn15b4l3+PpimCm0njRmVWQmKCVommoFCa6AllQBaVw4UVjSMz9xZw5Q9HLo95jPXQAe+ms8+pMHPWKbq62qOVF41zMknO/Q7Jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vK7kx+GQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea21430so451590b3a.2
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437233; x=1758042033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Vlt63GbNnkLCVT0dNm886w/eau7RLvkL63YHwxPZpY=;
        b=vK7kx+GQs+QGens4Q+joCfUNdd5IVRgDXj9cCin3WKfqh/+dkPdmqu2bQw7xqOTiXa
         vBSyT33GpSeIJILdh8dF7oWCR+GqYI9U1tufUHCJcg0CgXfL59X1NZKUn8onQxtpx4F9
         7XFU+QYcuUabU1tpup0TWPvtQVyJK3jYklqoJJyvwn9wcA9+Jo/3hdkfIIjnhdXoNc8T
         goTIs7AhWVrJEvxY+azFEsIGBh6S1ngLYQ1QejZs7/YIDNHkhe5s8M2BS5KBaOBfpt/D
         LJaeGxLM7pWbTEMiEfOXUCjcZxXpp4YmvY84SRuuRSR048FVlDvvHv/lc2ASD8YLcgrr
         rcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437233; x=1758042033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Vlt63GbNnkLCVT0dNm886w/eau7RLvkL63YHwxPZpY=;
        b=w3Pm9CSopb1G+fWnSlPVduosUDevjMpkVxeu2MMdX/lCaA5QsgpKXynfecvWRUeeDb
         JdR3PyrU63uUwxYMkIXca9icQb7rCqbJtglIw8jIagqlPROzE2ebqfe48cvUM4r18NTj
         TNoTwP8anQVHC1akd7ph4cxu8hIVVTMHMPBlGn04q6Q0mCka+wRQQjGTFrsn7qK1YU7b
         RkKU3+/TfARRWsf3pFY/mMey83SIrve9kJMDuCoif8qIFgM2Hfrw/cci+rc+5WsT3df7
         Zs3mplQrJKysgcchJkGVS+ie4ot23MBuLequXhbEvyxeHA+TDVEa7RP3MOWcdKSE4wF2
         l0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPf/uiAOItArnGUDGZNKYajfHO2bJVu6UD3QtIAPHHApge2D/XbSeBrIbdZ52ikEYL6pg0Iko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4z+AOwRwAGpmycpYWZKAIVUXBhYzoLdxIx59uRFCORXbfmUuU
	5lEf939RReoILlzSz3VK7cvcEEPFXWzMEj4vBu0GKvOE6BbY4q5eCOGLeLaYLDKAR64=
X-Gm-Gg: ASbGncuKZng7WKZS0VgBbcX9zM73zMpRQWxZro4hYe/BAb6nEX9h/OYVx1n3EFi/Kx7
	ct1kLPTmrwTx0wUI6ej/r/uotFmyecjHKWqgKk5xuW66QSuE9946fuopxnon9jfZTOyfxi9/82h
	g76IeqOhE+g9VDu0AIMmdBxlSc4aB18KFPYVJqW8ufEfDxNZO3ONFp5wNe8oDrlRYTjj1qaGXFE
	T6Dr/s3cXpYVuvw+AbIAb8uEbTh0sMwFI94lh7NYo4svDPrcT3sL2Py7AUnnA4WDVcPEcKnjFZp
	/ZlnsGIpatrjNJ1l1jFR1k3oyyb4yLD1hOsUKKRJstZocXs+IsUPDmQZaqIppp4TXBHB7IDW0b9
	xKfdEEiSFyvEt1IxmSYtSMlSy7uiE062Jo/0=
X-Google-Smtp-Source: AGHT+IE5on+Rui3kSrcStUssQ+nd1jKg0v5yp0zNltqvs6+oC9AWTBQM3n8hoIstPGppBa71NAjkog==
X-Received: by 2002:a05:6a20:3c90:b0:250:e770:bcbb with SMTP id adf61e73a8af0-2533e571da7mr9904030637.2.1757437232600;
        Tue, 09 Sep 2025 10:00:32 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:32 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 06/14] bpf: Enable precise bucketing control for socket hashes
Date: Tue,  9 Sep 2025 10:00:00 -0700
Message-ID: <20250909170011.239356-7-jordan@jrife.io>
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

Enable control over which keys are bucketed together in the hash by
allowing users to specify the number of bytes from the key that should
be used to determine the bucket hash. Example:

```
struct ipv4_sockets_tuple {
	union v4addr address;
	__be32 port;
	__sock_cookie cookie;
} __packed;

struct {
	__uint(type, BPF_MAP_TYPE_SOCKHASH);
	__uint(max_entries, 1 << 20); /* ~1 million */
	__uint(map_extra, offsetof(struct ipv4_sockets_tuple, cookie));
	__type(key, struct ipv4_sockets_tuple);
	__type(value, __u64);
} sockets SEC(".maps");
```

This allows you to bucket all keys sharing a common prefix together to,
for example, place all sockets connected to a single backend in the same
bucket. This is complimented by a change later in this series that
allows users to specify a key prefix filter when creating a socket hash
iterator.

Note: struct bpf_shtab_elem currently contains a four byte hole between
      hash and sk, so place bucket_hash there.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 kernel/bpf/syscall.c |  1 +
 net/core/sock_map.c  | 57 ++++++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f178a0f8eb1..f5992e588fc7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1371,6 +1371,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
+	    attr->map_type != BPF_MAP_TYPE_SOCKHASH &&
 	    attr->map_extra != 0)
 		return -EINVAL;
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 20b0627b1eb1..51930f24d2f9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -860,6 +860,7 @@ const struct bpf_map_ops sock_map_ops = {
 struct bpf_shtab_elem {
 	struct rcu_head rcu;
 	u32 hash;
+	u32 bucket_hash;
 	struct sock *sk;
 	struct hlist_node node;
 	refcount_t ref;
@@ -878,11 +879,14 @@ struct bpf_shtab {
 	u32 elem_size;
 	struct sk_psock_progs progs;
 	atomic_t count;
+	u32 hash_len;
 };
 
-static inline u32 sock_hash_bucket_hash(const void *key, u32 len)
+static inline void sock_hash_elem_hash(const void *key, u32 *bucket_hash,
+				       u32 *hash, u32 hash_len, u32 key_size)
 {
-	return jhash(key, len, 0);
+	*bucket_hash = jhash(key, hash_len, 0);
+	*hash = hash_len == key_size ? *bucket_hash : jhash(key, key_size, 0);
 }
 
 static struct bpf_shtab_bucket *sock_hash_select_bucket(struct bpf_shtab *htab,
@@ -909,14 +913,15 @@ sock_hash_lookup_elem_raw(struct hlist_head *head, u32 hash, void *key,
 static struct sock *__sock_hash_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
-	u32 key_size = map->key_size, hash;
+	u32 key_size = map->key_size, bucket_hash, hash;
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	hash = sock_hash_bucket_hash(key, key_size);
-	bucket = sock_hash_select_bucket(htab, hash);
+	sock_hash_elem_hash(key, &bucket_hash, &hash, htab->hash_len,
+			    map->key_size);
+	bucket = sock_hash_select_bucket(htab, bucket_hash);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 
 	return elem ? elem->sk : NULL;
@@ -972,7 +977,7 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	struct bpf_shtab_bucket *bucket;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	bucket = sock_hash_select_bucket(htab, elem->hash);
+	bucket = sock_hash_select_bucket(htab, elem->bucket_hash);
 
 	/* elem may be deleted in parallel from the map, but access here
 	 * is okay since it's going away only after RCU grace period.
@@ -989,13 +994,14 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
-	u32 hash, key_size = map->key_size;
+	u32 bucket_hash, hash, key_size = map->key_size;
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
-	hash = sock_hash_bucket_hash(key, key_size);
-	bucket = sock_hash_select_bucket(htab, hash);
+	sock_hash_elem_hash(key, &bucket_hash, &hash, htab->hash_len,
+			    map->key_size);
+	bucket = sock_hash_select_bucket(htab, bucket_hash);
 
 	spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
@@ -1009,7 +1015,8 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 
 static struct bpf_shtab_elem *sock_hash_alloc_elem(struct bpf_shtab *htab,
 						   void *key, u32 key_size,
-						   u32 hash, struct sock *sk,
+						   u32 bucket_hash, u32 hash,
+						   struct sock *sk,
 						   struct bpf_shtab_elem *old)
 {
 	struct bpf_shtab_elem *new;
@@ -1031,6 +1038,7 @@ static struct bpf_shtab_elem *sock_hash_alloc_elem(struct bpf_shtab *htab,
 	memcpy(new->key, key, key_size);
 	new->sk = sk;
 	new->hash = hash;
+	new->bucket_hash = bucket_hash;
 	refcount_set(&new->ref, 1);
 	/* Matches sock_put() in sock_hash_free_elem(). Ensure that sk is not
 	 * freed until elem is.
@@ -1043,7 +1051,7 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 				   struct sock *sk, u64 flags)
 {
 	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
-	u32 key_size = map->key_size, hash;
+	u32 key_size = map->key_size, bucket_hash, hash;
 	struct bpf_shtab_elem *elem, *elem_new;
 	struct bpf_shtab_bucket *bucket;
 	struct sk_psock_link *link;
@@ -1065,8 +1073,9 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	psock = sk_psock(sk);
 	WARN_ON_ONCE(!psock);
 
-	hash = sock_hash_bucket_hash(key, key_size);
-	bucket = sock_hash_select_bucket(htab, hash);
+	sock_hash_elem_hash(key, &bucket_hash, &hash, htab->hash_len,
+			    map->key_size);
+	bucket = sock_hash_select_bucket(htab, bucket_hash);
 
 	spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
@@ -1078,7 +1087,8 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 		goto out_unlock;
 	}
 
-	elem_new = sock_hash_alloc_elem(htab, key, key_size, hash, sk, elem);
+	elem_new = sock_hash_alloc_elem(htab, key, key_size, bucket_hash, hash,
+					sk, elem);
 	if (IS_ERR(elem_new)) {
 		ret = PTR_ERR(elem_new);
 		goto out_unlock;
@@ -1105,15 +1115,16 @@ static int sock_hash_get_next_key(struct bpf_map *map, void *key,
 				  void *key_next)
 {
 	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
+	u32 bucket_hash, hash, key_size = map->key_size;
 	struct bpf_shtab_elem *elem, *elem_next;
-	u32 hash, key_size = map->key_size;
 	struct hlist_head *head;
 	int i = 0;
 
 	if (!key)
 		goto find_first_elem;
-	hash = sock_hash_bucket_hash(key, key_size);
-	head = &sock_hash_select_bucket(htab, hash)->head;
+	sock_hash_elem_hash(key, &bucket_hash, &hash, htab->hash_len,
+			    map->key_size);
+	head = &sock_hash_select_bucket(htab, bucket_hash)->head;
 	elem = sock_hash_lookup_elem_raw(head, hash, key, key_size);
 	if (!elem)
 		goto find_first_elem;
@@ -1125,7 +1136,7 @@ static int sock_hash_get_next_key(struct bpf_map *map, void *key,
 		return 0;
 	}
 
-	i = hash & (htab->buckets_num - 1);
+	i = bucket_hash & (htab->buckets_num - 1);
 	i++;
 find_first_elem:
 	for (; i < htab->buckets_num; i++) {
@@ -1150,7 +1161,11 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 	    attr->key_size    == 0 ||
 	    (attr->value_size != sizeof(u32) &&
 	     attr->value_size != sizeof(u64)) ||
-	    attr->map_flags & ~SOCK_CREATE_FLAG_MASK)
+	    attr->map_flags & ~SOCK_CREATE_FLAG_MASK ||
+	    /* The lower 32 bits of map_extra specify the number of bytes in
+	     * the key to hash.
+	     */
+	    attr->map_extra & ~U32_MAX)
 		return ERR_PTR(-EINVAL);
 	if (attr->key_size > MAX_BPF_STACK)
 		return ERR_PTR(-E2BIG);
@@ -1164,8 +1179,10 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 	htab->buckets_num = roundup_pow_of_two(htab->map.max_entries);
 	htab->elem_size = sizeof(struct bpf_shtab_elem) +
 			  round_up(htab->map.key_size, 8);
+	htab->hash_len = attr->map_extra ?: attr->key_size;
 	if (htab->buckets_num == 0 ||
-	    htab->buckets_num > U32_MAX / sizeof(struct bpf_shtab_bucket)) {
+	    htab->buckets_num > U32_MAX / sizeof(struct bpf_shtab_bucket) ||
+	    htab->hash_len > attr->key_size) {
 		err = -EINVAL;
 		goto free_htab;
 	}
-- 
2.43.0


