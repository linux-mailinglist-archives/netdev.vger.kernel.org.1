Return-Path: <netdev+bounces-143094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CC9C120C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3911F228F4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE212178F8;
	Thu,  7 Nov 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRITKHxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA51DF989
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019996; cv=none; b=ai6JTqLO/bu4Jz+SEeFmO2bJds8UJ+FnE3Uf+7Rg8nBQpJlt+hIAc6JdILXmm4CvJbzNHt68Nwgpmvx0UHRW7to1T4uReCLvsC+1DoKh0MtWrQyO84O7vRajhPCkOT4fzs9Lm/JXLXxzeUS0ew/O7rtDf54Qe0vKnGeFpRfUZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019996; c=relaxed/simple;
	bh=00uhnqlMT8KhMPkAZCW/rN70ahxGWy8Gzwaw8ciNM3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ONrjhc9Tv1Agcb42uwWlCDXbcayHvSpA2IyINK4FSNs2hm7a51EtjmQiSp3wGrsDo2cdyMdWIkpM0bcW4Uwia235U+xd8ByExKxCnKeUvqMmb/AnMR+j0PUkGcRH64OBtvLfdRWJP+VfJ39qrLCkGdigCC+l6hzVWr3VgGUEh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRITKHxf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99eb8b607aso207193866b.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 14:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731019993; x=1731624793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmjHDcbW9JR98jEfrSJPOtlII5RDrQkf2HBmHzzBOvY=;
        b=XRITKHxfb5XzxeRNBrH3i8luBqNALwwC5JthSBXeI+0Pors1n4bdaiskJfQHPGvLNG
         FmUbHmeOI8rEpia3rDKAPR9D6Hn1r+ZBAFHrDGfKYPwW+MbbLAPssVzZ6FzBSsVSG27+
         U+/bw7GQTjKhQmcYkk6fxEmSvHh4xlwucailmLDw25wdIAEte0D1AiJ6A3rI/+iq7EmS
         /S5CJ/G7sHDy0kyXPXRogzpd1SSZDHD4uL7GwFua1a+U8t2SUlv0hlIMw/lKLjUnWXrd
         DLDfngancCaWYdOm/eZfJmWj/neBHYVtnL/hCYQcx4Pskxb8PphOddnHWTkYdf2OKwEN
         JiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731019993; x=1731624793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmjHDcbW9JR98jEfrSJPOtlII5RDrQkf2HBmHzzBOvY=;
        b=PHcOPJr/i3mRrNkojvWTvGae6Kqvcri60EU9LihafVgtSmtYDRvSRYvad3iURaSm85
         qkP7wELccz+K80HgHLhrCkhQfAQIp9qa2Tpscn2+SnaV5MQV22kF4gVJUEIkoS3NuqDo
         oKTy0SQJwv9R/88hKN7y+4Mn6gc7+cnl3EJsGjtU2oz0CHp+znmwiWH7D8GTwIOBf655
         uR6oO2H6plnW7T51e7lRIrmjPwLHJTlTOxSg8eQ+KlRCAqAVHNLJcPE5q6O0Hrmvy18H
         eLipfyMBeyajhkmXSVsjevjs2Bf81sCwl91kWfmnXhQlvdtBGFC6mV3eXQtBbOrXFIZM
         AwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiXA2eRh23YvctdQ9mWcTmMNy8c6scR7cFrjXtU6BYIbNpCigRKVmQdOgTCMOYf92kUkmE9U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwTlL4Fwsf+VGCk0OUm7vMzdLz9nf6l125QQsj1Qv+BKdRrs7
	tajrXTAG4XIBjL5Xuf77ZLHd2Ae1+kfZJ9vJjJD2l7RBrg1nQjEpoX+l50xY
X-Google-Smtp-Source: AGHT+IGnp/AbDQepGzx3u1KoyVAFplsBq1GEE9XzqXlIsUEkC9EukWBsgi1HAzTtHjck+tNpgg6VKg==
X-Received: by 2002:a17:907:3f9b:b0:a9a:c57f:9634 with SMTP id a640c23a62f3a-a9eefff1204mr45545566b.42.1731019993040;
        Thu, 07 Nov 2024 14:53:13 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a48b1fsm154064666b.58.2024.11.07.14.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:53:12 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net v4] Fix u32's systematic failure to free IDR entries for hnodes.
Date: Thu,  7 Nov 2024 23:53:09 +0100
Message-Id: <20241107225309.297721-1-alexandre.ferrieux@orange.com>
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
Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
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
index 24bd0c2a3014..2095baa19c6a 100644
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
+        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do $TC filter delete dev $DEV1 pref 3;$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop || exit 1;i=`expr $i + 1`;done'",
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


