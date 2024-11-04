Return-Path: <netdev+bounces-141471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC9B9BB110
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A6A1F22718
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2501B0F09;
	Mon,  4 Nov 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyVmR/wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347D1AF0D7
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715982; cv=none; b=QcjRB2oHqF3lnWQ3x/72T0fnRLqYwjpzOWUb0nE7/w/gSU64ZbPhWy+eNd4ydLeD5w2gGORA4z51WoYA87/win2TpAI5P96u8V5Y0+0rzrWLPqxEpADOjYHgAbLAhSbR9QroJvYUuR2xD1dDk0qg02lvEeN088Kxk5o32Su/QLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715982; c=relaxed/simple;
	bh=ApgZ8Dw+NBMgpybspaCoXYbldyLG/BqFaKei67PFK9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nOHXNKJyLc0x1Xxml2pUMnioBpqnCOjhevLaSXAl58Obaa75SQvpw7eUSBHKhYWPzEoPmoPVmEyhtPkBri4oUQlEfanMIrD3CDSP+RLEjOBmyxwE3rYoRSp3LliAEFnTkZcLyilIKixi14mmzrWDppncQIXtkFPTiS4zyCO3JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyVmR/wM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so327970a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 02:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730715979; x=1731320779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWfTqnWfdVk/DgYNhm2vj3xZ75PSeN33Tkuwkcl85nU=;
        b=DyVmR/wMtvY/QonuARrLgroQgH4x3UbnRelPk2kb7RGXFrGrlcDxo+MRENvOv5gwdX
         sNUmEntYTxrPDtRx85SQR2e59t7I+KboBW65WKIPjHuAPfXX2wPorjIX02R4hD0NP8EK
         jLIkSSf94ImwlG+RKCjAOroF6j6a7Zr8dSEgK59WRV+YGBW7jXhx0a5OQ/BWVMt45eZ/
         ocrqk/EuDDt+TiLaUoPu8TjFpmV7oo9+Wu+dj1WPEg+NKh22+mRSS8ZPR92u3/H+Q0hY
         YdDgM0ZPawysjsGuqtJ2A+PY2F10Orq8QGFuKav5eR38jQAqGMk+NuAD63Fk1WpezuUC
         pCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715979; x=1731320779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWfTqnWfdVk/DgYNhm2vj3xZ75PSeN33Tkuwkcl85nU=;
        b=j9uVeCCY5sF4URgDwFnORV0HLJwHccqKlUTVuX252DP0r/MnjPUOyZEtIwDKX+cYAt
         b1GiDz/TjfD197gDwwTub97gJAi/VNUvHMkPSeTTfhK1g//LTwkLvsYfdAXlZ7r5T+rs
         8rKoAQgYxwGKdsfWRpmRY0umQSlywh6np8tjoCJ6pnNYrwYnU3fHkCByyvRkc6rVdEPC
         HfVyDazsXCkdfp7eIhAiUHXYd3XVu6bBwvHsakRA9nzAab8pYjiciBXBaZlnnSlr92Sn
         AV+nQgA4bN7RpXnyCDahh1NVguZRcrN3gauDT1hO+dF6WYmNH6ZjWsWzpuI5i/7khq+c
         R5xA==
X-Forwarded-Encrypted: i=1; AJvYcCUJVRiF0JROJRts9/7/FT68EshAYyYVPywjuK0oWsFDRxuQ+Hpowm0uWR2mzXDh0EUt1z4S+gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOh+qjZeffsoKoaTYpWIsDLcocZw0tPMLxnskEyGN69dV2QrmS
	+MvVYwlwDIdcgmxcAi+6IGRZJQ2k8MYCTbvxzo1hXElyVr8PgFCu
X-Google-Smtp-Source: AGHT+IGRCZvGh2WBPrwWjKXC+C5lRMHjtbnyLPqDEqhouffTbuGt4/TmhbFQLvWZmO/C6FIY5zZasA==
X-Received: by 2002:a17:907:7284:b0:a9a:5b78:d7d8 with SMTP id a640c23a62f3a-a9e65570662mr1245545666b.17.1730715979157;
        Mon, 04 Nov 2024 02:26:19 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566442easm532450566b.166.2024.11.04.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:26:18 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net] Fix u32's systematic failure to free IDR entries for hnodes.
Date: Mon,  4 Nov 2024 11:26:15 +0100
Message-Id: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
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


