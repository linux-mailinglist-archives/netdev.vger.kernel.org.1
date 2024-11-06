Return-Path: <netdev+bounces-142413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E899BEF80
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A401F23B4A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF98200CB4;
	Wed,  6 Nov 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS/Ikwf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E21CC14B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901244; cv=none; b=V4xGt24iJ/x3wwgWyrhacxGj8sVsAzMiw14YUp32SactlRFzljhPQ6eklvlaqzpGBoHM/dOaWjf8vqdIQLDFP5AVRwjgQdMZSZPpj7VUuWxJtGLGAc0Nse1/7nak0mrknh6tjn6LRYCEFsMvV5qAQM4WdV7mZRaXUETjD8WLfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901244; c=relaxed/simple;
	bh=yG84XCByDLU5y+9eyqESMuROkyHyJFxsmGIrkSPUGKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffuM7OY+fshe+oPSh0k2kfy2LqhrRGrTuZ97zaR07NFFy5FpwimdPLPJ0FwaPBLw/q0cyKz9Lm2g8nFGjAc3O9r8ZA0Y3CnovOlj0NxYHsMDlPbpK4JB81HsLUWAt6n1g9GJIyp8AWVaqcEI1w4PSMIyND725C6DeDeoMF2gtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS/Ikwf8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso847690a12.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 05:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730901241; x=1731506041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFVY8ZVpT1TsvYOQpy7UWr10tRW7b5t4yl6MYGNNads=;
        b=ZS/Ikwf8K0D2Lr0XWJBFABa3cEwEadgTMjSHAYy04njEjgoajOpXlPODaW7wqArAhT
         d3lYdquKwfId9CwMN1Jd9Lf8Zb57eX6snH+aiuiQtlKydSuFWINB57erECZKDq7zJgKv
         EWYRd/7d3LIbWISLpjnVAtkPyyGrnAazO915grweIunmJ79SEwMqkdSnUe1m180nzVU3
         QE1EwQl0zhOy3cYuXwd7O9Wep6YztKKbD0k/jwIomHAWu77eakyvtDcRqrLAASaaX2MT
         5ZP8BjbiRVS5TZHqf0lpwNCWdQve67J3U1wR5StbS14xxjhDxppzK7/fPOXjDnzWpYVm
         ReTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730901241; x=1731506041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFVY8ZVpT1TsvYOQpy7UWr10tRW7b5t4yl6MYGNNads=;
        b=gWwRODbXFR0lRqM1Vk4SZIH6AiBT1otc7JMgplwmDi+Og3rqkf/kgCv0aKN6fKzw46
         CAvFE+ui1LbLctpnoiQqzO6Y93TrYOcLWaLZrV9vFEbF76gWnSipHotz6Bd0GWf5GHd/
         CmrUl/aa04+lDFZahlpugWyUJ0beBgdFhQLL1xCmTBdxoDDeQbLD2g+6Z56T/OR57UMK
         n5p/Rw90lWRzUGKzLtmESppDefl9FA9HN3mPBh7c6Bl2PwFxhhIm5I3BAQukBN08D5Ix
         kf8LWnth+aE3jKFbIHd0qrnm4ZVUc9UzVnJtCriPY4hudoaVddNBu4icDHdNgAGPmnsf
         4ZXw==
X-Forwarded-Encrypted: i=1; AJvYcCVbNEgCS3t7YjTo2ZSD/UlZnkw1lgyRM5eFPkwKo7Vxtl3jaysSENHSxDtSLe70Ldo2LT3YuaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBD6UzPFpt7OAgOURh3kbKyYkbZdUmDylrBJgl1Kqyoe0yx0J
	QXSkj/fLx0SLaHpT3CRyyPiFYLDmLOH+rESI7ZWrlJeAsgTCzwf3
X-Google-Smtp-Source: AGHT+IHUfARpSb4TumLGVayNj25wU9TRcry35VE1LyaFNY5FbyVJUzc6WcVGcyUqHUvjZdiWShkUNQ==
X-Received: by 2002:a05:6402:34d1:b0:5c9:6ae4:332e with SMTP id 4fb4d7f45d1cf-5cea967a284mr19175557a12.8.1730901241273;
        Wed, 06 Nov 2024 05:54:01 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6ab1196sm2838745a12.25.2024.11.06.05.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 05:54:00 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2] Fix u32's systematic failure to free IDR entries for hnodes.
Date: Wed,  6 Nov 2024 14:53:57 +0100
Message-Id: <20241106135357.280942-1-alexandre.ferrieux@orange.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
v2: use u32 type in handle encoder/decoder

 net/sched/cls_u32.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 9412d88a99bc..6da94b809926 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -41,6 +41,16 @@
 #include <linux/idr.h>
 #include <net/tc_wrapper.h>
 
+static inline u32 handle2id(u32 h)
+{
+	return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
+}
+
+static inline u32 id2handle(u32 id)
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


