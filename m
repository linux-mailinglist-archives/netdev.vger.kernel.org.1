Return-Path: <netdev+bounces-141095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2049B97D6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4471F2161C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A411CCEE3;
	Fri,  1 Nov 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haIaeKMt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0ED1CEE94
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486596; cv=none; b=U/SLxJRR9JoP5m6slnLbTXK9wLF+mjTwuEQcRzgOkAKhT8T+GAMy8CUf3il7j23NbvbPEi4BGUviv4tQ4xUsJlg9L+MRen9FT9LXJ8eb9bmLgzitARamcIiZ9RhjqiAb714wpqouwq2ZnaOjEArnkXU7atkZytzj9niC/yuby+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486596; c=relaxed/simple;
	bh=egNgkPbJAsQz9TcIxWXOgef8FdjGAJbaz9sIc16danQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ek7xHCvDTzL8eEWS8wlMN85qh3x38ZglA9yQGrep2s3B6+h2cKsqHf55XgkzrI4qdNhMR5n0/idtCtL6j/Zs9x/zrJyk90/wVZMEa+yLEjKSnVGZcGlkQTfQc9VluhvE/KRETBDwNA9psEu8oQdXXdyKnBeJ1GUL7rZdmqKo8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haIaeKMt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so250178866b.2
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486593; x=1731091393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugW5h59LvlQHqREri10wBczeOdks7BhClmZJSzQ9Hv4=;
        b=haIaeKMtyW1/EQ3gEAS/mSro1QhgIOxjaU+ZMTpwx3l7z5eCs4BLRKRh9FWTex1o2Y
         U/7iQJe9HjCD+j3gs2Kwz/IPJ/UMqpGWkU78A1PRLK8ssIYLAraSHG2XvmFj5jPrPhrn
         vym54lVNmccBBeZ3BGaNEE/iN6LrKjhieUowmnkkWsLDEbtSMslys7EZd/MPz+9ueuwC
         SBoawzLC9dm9LLdECenyPTgE7cNiYGZ9nXLDwrpCqs4NcHvjtfqlIKm0gNqlHFXjieJi
         ExkJn/gQnBUBnnLZDvKfImCpgGVGH3YQfbHAYWsDnc16N1z03K7nvhyE4D0D4RMr80Wb
         1FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486593; x=1731091393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugW5h59LvlQHqREri10wBczeOdks7BhClmZJSzQ9Hv4=;
        b=hDTBNLjNsdiwY+l1J6PjeWfKCOO1uyVGzlMEnN3mj0Wc8FVTTccCOtzrFrwbbmNuZ7
         3rgEaezw2h68TYtURXa2O/0PXmxnO/X+lBZS+qiTMi6+snDUaqyE9x2Il4zZL7yWNaLA
         4p5CAde+ZCkl9bvpS0bdXOCs2P9HzsU3rejnhoBJyB+BuEhr9CtGpXRrlx3RyXP1XVgL
         bODNrdj2kI6dQ+zWjzt2zI19oqU0j229L5aEqKHJMrX7jFPm2wK7/xPqoL9vP2aMS5ge
         6UFbxfjgxkntckdZRJDzf7YSSuWNtufCsfrAzI8moWVM13QNcVjwCMAqvsd97p/0PfIR
         iROw==
X-Forwarded-Encrypted: i=1; AJvYcCXsgUaqzi0qw0dcDGsgljogR0sXiHLs9r9IdYYWap6UyAcSPdgnCqqsxuGJDHwmXmoc0rsr7EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL6u0AQe11jLTueRea/WGvkJeOkTO2gKvoDqkTeRku+bT+pZOA
	ryedRLFwjvhXV3laPel37x3Ds03i+UrfrV/uz3/2PnYugn74xMRu
X-Google-Smtp-Source: AGHT+IGcFC+R5HUqx/8gJT/SX2Sgp2G24xmbzuRDV69Vm2vRLqc51CC2hjc0HbqSw5RvPMHEHpxCfw==
X-Received: by 2002:a17:907:3da0:b0:a99:ebbb:1307 with SMTP id a640c23a62f3a-a9e658be1cfmr346917766b.59.1730486592877;
        Fri, 01 Nov 2024 11:43:12 -0700 (PDT)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566437c9sm215105666b.160.2024.11.01.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:43:12 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net] Fix u32's systematic failure to free IDR entries for hnodes.
Date: Fri,  1 Nov 2024 19:43:09 +0100
Message-Id: <20241101184309.231941-1-alexandre.ferrieux@orange.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To generate hnode handles (in gen_new_htid()), u32 uses IDR and
encodes the returned small integer into a strucured 32-bit
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

Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
 net/sched/cls_u32.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 9412d88a99bc..54b5fca623da 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -41,6 +41,16 @@
 #include <linux/idr.h>
 #include <net/tc_wrapper.h>
 
+static inline unsigned int handle2id(unsigned int h)
+{
+	return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
+}
+
+static inline unsigned int id2handle(unsigned int id)
+{
+	return (id | 0x800U) << 20;
+}
+
 struct tc_u_knode {
 	struct tc_u_knode __rcu	*next;
 	u32			handle;
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


