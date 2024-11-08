Return-Path: <netdev+bounces-143308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22E9C1EEA
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AED284795
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63C1EF083;
	Fri,  8 Nov 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp5cUFal"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8D1E1C18
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075126; cv=none; b=AOGX6cDXRxSXr35c05B2w1/ZAoBo+8ThvqwPEEjeyE5t3fplObgxhLpAsggSoaU3i3QA6bRsiaWiFl+/jnFOf5SkcuDgs6U+l2PVUDlyIBkzfLxh9FxYcwGccVHJEI6pxAmQTG2gYBT2aAINS6EwbTsFq2mJlWsKYCouQ+NFfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075126; c=relaxed/simple;
	bh=E4jgzYTqM1M6df51gZQzH0RJ7emnfOGZrFkq2n/BbRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7lE78o/zvjbiSXPzS1+aE45izyJ9BZzlgxQa4CytEi59eJA6rMAp9TZuwzUsbNDHFNBy6/p6kqnV7m67rLbFiw3q7+MeciTk9UKD009Jhb6N6NGtgelrERVQsio/LUQSZi/1EcRkKk7RZmaL7oxr3V0lWENsZVkcUcGXuXpe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp5cUFal; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso342781766b.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 06:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731075123; x=1731679923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk0jjWDC7uCsz3xlw4gQeMe1o7bAw/A1X2x0DSI5ZBE=;
        b=jp5cUFalruTPR5r9R3rzwOUHOaP60kt0dnlG+nDS1ZdZp7wub5Z9Mh0S5w/v9R5eHr
         m5rbbwwQDrnxMpRhN66CIYQilDbEjAotLFrMK+y7c1R0IIffKN5AnXqviHiAGfVnH8ge
         kXP6R4EbBkxmTh5O0gfni75g52mxgYvu0ZfwIVxQaBdOWqNfR8pxyWKjt6ZG7PR6BbEs
         3Cxf+7Fv67xA3F9Ads3s+UQ8eR02oNrIvJUSZM+i0sG8lFhXCvivJM8FSV2sKh2rURgh
         QFoUEjkCPbyplybFRy2ZrkiS0AMREBRnPtkTT0Et5BoAf4oBA01OLSElcBAr1QXyRNGX
         4iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075123; x=1731679923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gk0jjWDC7uCsz3xlw4gQeMe1o7bAw/A1X2x0DSI5ZBE=;
        b=FOsS/R2zwocKh8bP8YWubrMld4x/PmgmfIZuFx3uEbQsSRlzRm5t8sez6Fju6B45XU
         3MLl75n3m5Z8dfPFXOwK/qdQrnOCd80OnFgVQUZ8rflJDZdebKzgg6/uqU5TUJcTdqhQ
         W3J7r/G8zSEfG6KOdZ79WVoN92LLMqypx/1gLOTDCwOdpCi/n0swQjl/t4MKtvWx2R1d
         MnZsMpvVzk4Yh1PGACxx0vrp6JtugekKBSIbXEmmpRJzr9D88nn0a3Q04t8i7CJWjma3
         pC2gKRVSpgZc3tE0rtrx28hUgOGOM8j/OgwTNPXAvexU72bcLI5fEhJ9mMnEBdPBC5Oa
         DB/g==
X-Forwarded-Encrypted: i=1; AJvYcCVeqNXgUyBQRaFy2ePFrbdA2eV24D0+pshySMeJ5jcnqhIHlZAETr5OU5oXU1OmD79hGDzoxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKILULMKI/wStlOdbEvO5H98c2gZYMKmQQ20Vk94Lp8gh9bPNW
	1tQOGsV8HwAmY5CCH7QohOcrPokZsKXMt2DtFKI9T5LwHl4EJX/O
X-Google-Smtp-Source: AGHT+IEn9M3HUSUyDIHoeUngXKHH1Fkx403/6lg6V3xhmnK7cGtxprgVssSTkrjWrROU9J7dm/r4Tw==
X-Received: by 2002:a17:907:1b21:b0:a99:ff70:3abd with SMTP id a640c23a62f3a-a9eeff25d17mr269907466b.31.1731075122567;
        Fri, 08 Nov 2024 06:12:02 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2fac9sm236169966b.198.2024.11.08.06.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:12:02 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
Date: Fri,  8 Nov 2024 15:11:59 +0100
Message-Id: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
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
deserve it, along with a corresponding tdc test.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
v6: big speedup of the tdc test with batch tc
v5: fix title - again
v4: add tdc test
v3: prepend title with subsystem ident
v2: use u32 type in handle encoder/decoder

 net/sched/cls_u32.c                           | 18 ++++++++++----
 .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

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
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index 24bd0c2a3014..b2ca9d4e991b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -329,5 +329,29 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "1234",
+        "name": "Exercise IDR leaks by creating/deleting a filter many (2048) times",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 match ip src 0.0.0.2/32 action drop",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop"
+        ],
+        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do echo filter delete dev $DEV1 pref 3;echo filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop;done | $TC -b -'",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1",
+        "matchPattern": "protocol ip pref 3 u32",
+        "matchCount": "3",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
     }
 ]
-- 
2.30.2


