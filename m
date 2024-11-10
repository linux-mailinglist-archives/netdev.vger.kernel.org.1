Return-Path: <netdev+bounces-143603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BB9C33FA
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985031F21165
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0891384BF;
	Sun, 10 Nov 2024 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1udrw6H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90A4D8D1
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731259723; cv=none; b=fASGu6YI/o1m87qP6I3QOLwgvSmgo9b47Voi2kTwaOwsSsSJRsmh4zGT8f4Tdi/Ver3OyINK/MIjI8Cw6kAwi8JLFOciUq79xQxbxlDIJzeiKvRnvQq4oxqOB6kgvJlLyQbr6Y+V4N1p2Mr9wl2UGuwvB+KXoOinsxsPauBAKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731259723; c=relaxed/simple;
	bh=2rFuvzb5vmN3xgvJnxyrF+6Lo4pY9hHknWZbwOdkyx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNtZm+2UHOgk7EAi4lVEtQcqARs83ylpt309tRawwYbhNj71GdBMch0uN5pmPlzeis7UpjR/CpM0eAZKDx3jG8VBxus2VV0Qes2y5lsQsam+0ZM09r2U68sx0pdnkMbpLkm6d7sCVVtSTCsZrB8TCKnNdG7SJKvpJ3xo9jRfPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1udrw6H; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so589175666b.0
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731259720; x=1731864520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CP+37kwVXfIbjAASaQHRA++6vSRyJdSc2qhpzRnMMqU=;
        b=Q1udrw6HbGAtxSdyev8ISQld0Va8j2iwUQwMv2giLePJYWX07iJH6tyl089Gp8tMpD
         WRW3xmGdz0R5tNtaPYu9R/GF57ZJx2u27sK08GdTOxfUTAF64tk3jXz0elM101fuIbw0
         sNUAhSugr55T/udeslioNqqpa8bfqauvEJ2kpfbkJ5beOhMyV1LxLxp+ehKrg2FOUg1F
         x+Bh1Q8ZjJZxaaxAV00gETOmYB3qqp3Um83laz44Cu4JLuJLRE//PYjiipkd2gGzQlHd
         S5FoE9guPhCvP/nDeGjW3fMmBLwOdut68HPYEsXFhRxFmUu+ZQGbEFb7yefaZC+3DHxR
         60mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731259720; x=1731864520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CP+37kwVXfIbjAASaQHRA++6vSRyJdSc2qhpzRnMMqU=;
        b=Zx+2P4aQluLqI7Wnn74MYfaVpQHjVsgGywuq8ArSBiaJ4d/sNQHJ5+uFr5fn90qPNy
         kX41fz7RlX08wr8563FXTJyQ4E6YN+Iumf/3LnHbvZj8Mgf16qKRno5QXAJyuOAjW3PG
         N8tbs7TpCMP/vIsuVXrliLR9NQvPPn//OGtbF0KL7AXx42+99SnTEq4kp6oIvqwgNnVh
         uXVi/04YQPwzu4nV7qIQBykmRL1i9KAjiEUkSFz4AUzGgMSAtlyR5SYPn73k1NtSZVTB
         3r/hSM4TNQ2SgaENJnBqCzNPf2a0XeWJKwaqvAHriMCrUpKcpkL7abpFpAAYmSVomtSi
         kjUA==
X-Forwarded-Encrypted: i=1; AJvYcCXcZEDho8rGPz+fjTRAyHCG5oEL/EG5BGWtLA8Kvsk23AUmB54UHxm9tlNAMzFVeuO6YaYv7v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkQsOvzgv0TjOe2aaWaJZYFfqVcA56iLwPReUedJ125LmDkWd
	BlcMzAEaaBmWNLfkksp1NUARPDmea3+EUTLKnjaNHALOMqZUvGKl
X-Google-Smtp-Source: AGHT+IEGyNLxbATs2m3YVB43y0iA9NSF3S+2XAw8B4M3hzmnG7V4fbRrmynCO3sm6evKTNNXLpzyYg==
X-Received: by 2002:a17:907:3e0a:b0:a9a:eca:f7c4 with SMTP id a640c23a62f3a-a9ef001fceamr937441066b.54.1731259719882;
        Sun, 10 Nov 2024 09:28:39 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0deee8asm493687966b.134.2024.11.10.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 09:28:39 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	horms@kernel.org,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net v7] net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
Date: Sun, 10 Nov 2024 18:28:36 +0100
Message-Id: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To generate hnode handles (in gen_new_htid()), u32 uses IDR and
encodes the returned small integer into a structured 32-bit
word. Unfortunately, at disposal time, the needed decoding
is not done. As a result, idr_remove() fails, and the IDR
fills up. Since its size is 2048, the following script ends up
with "Filter already exists":

  tc filter add dev myve $FILTER1
  tc filter add dev myve $FILTER2
  for i in {1..2048}
  do
    echo $i
    tc filter del dev myve $FILTER2
    tc filter add dev myve $FILTER2
  done

This patch adds the missing decoding logic for handles that
deserve it.

Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter handles")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
v7: static inline -> static
v6: big speedup of the tdc test with batch tc
v5: fix title - again
v4: add tdc test
v3: prepend title with subsystem ident
v2: use u32 type in handle encoder/decoder

 net/sched/cls_u32.c                           | 18 ++++++++++----
 .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 9412d88a99bc..d3a03c57545b 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -92,6 +92,16 @@ struct tc_u_common {
 	long			knodes;
 };
 
+static u32 handle2id(u32 h)
+{
+	return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
+}
+
+static u32 id2handle(u32 id)
+{
+	return (id | 0x800U) << 20;
+}
+
 static inline unsigned int u32_hash_fold(__be32 key,
 					 const struct tc_u32_sel *sel,
 					 u8 fshift)
@@ -310,7 +320,7 @@ static u32 gen_new_htid(struct tc_u_common *tp_c, struct tc_u_hnode *ptr)
 	int id = idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP_KERNEL);
 	if (id < 0)
 		return 0;
-	return (id | 0x800U) << 20;
+	return id2handle(id);
 }
 
 static struct hlist_head *tc_u_common_hash;
@@ -360,7 +370,7 @@ static int u32_init(struct tcf_proto *tp)
 		return -ENOBUFS;
 
 	refcount_set(&root_ht->refcnt, 1);
-	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : 0x80000000;
+	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : id2handle(0);
 	root_ht->prio = tp->prio;
 	root_ht->is_root = true;
 	idr_init(&root_ht->handle_idr);
@@ -612,7 +622,7 @@ static int u32_destroy_hnode(struct tcf_proto *tp, struct tc_u_hnode *ht,
 		if (phn == ht) {
 			u32_clear_hw_hnode(tp, ht, extack);
 			idr_destroy(&ht->handle_idr);
-			idr_remove(&tp_c->handle_idr, ht->handle);
+			idr_remove(&tp_c->handle_idr, handle2id(ht->handle));
 			RCU_INIT_POINTER(*hn, ht->next);
 			kfree_rcu(ht, rcu);
 			return 0;
@@ -989,7 +999,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		err = u32_replace_hw_hnode(tp, ht, userflags, extack);
 		if (err) {
-			idr_remove(&tp_c->handle_idr, handle);
+			idr_remove(&tp_c->handle_idr, handle2id(handle));
 			kfree(ht);
 			return err;
 		}
-- 
2.30.2


