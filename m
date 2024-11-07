Return-Path: <netdev+bounces-143099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B99C123F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF31C2137B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D02185BE;
	Thu,  7 Nov 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPjkm496"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72D2178FC
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021090; cv=none; b=b84jJcRJf236ylvwt6KfVwnsuSAOsgLFVBSgNQD8216BM+sroHzXk8uaUQ/pjt83tewpKEvVBL4abSckbe/qcCdCrsyF6v65oHOexjXmjdjb/M8lxJ1jM4uSOlEwBjNrVwLZOSKM4WdvCXPz9m9KXVzRVvy2+bDttrpB1ruP6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021090; c=relaxed/simple;
	bh=8C6vyWOYcgiE9RruRLgQDHDBZfJjrsTKwZT73zknrzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jZGDKAtprAlzrco4kudG9UCwMLBO3MEr4wrf6AJlwXoqMsjErvzF6s8xKPq4fsiljHg4w9XRwLpB78KicmErX/SS6csQx4zrf10ai1dfqqrs6oD//Mwn5T96bOnVXEFxGA8LsZQvZcBkYljdXRMnK1fo/ePqxJXAQfm/9chWKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPjkm496; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9aa8895facso269498466b.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 15:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731021087; x=1731625887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh1nj3q16SjAJPEM7S+l5jum3bYi5R42P7sSt3yF+b8=;
        b=gPjkm4965Vjaimn7GtcpHZcTfLvRGJh4O+lPvUbxvFoa53tjVI7tr4rc6ltErGt/Mm
         S4xFWHm6v9tgUW12vp4ldGcBBS6fiN/+0de+o9VrtPHCpwa9NH+xn9LbLbpkKF3/m+IA
         UlFSL6xsPFj4G5VTGfaNtXk5Cgd3saWRjdus3ynG4qmIkmo6eO8ctLl+WmQa0N/BlpMG
         lW2oN94vzcsSC7MMQ476BZ3gtL8gIthAE+U1McaNIyRQgX+faKnekHBYYxePYihBRuqj
         f/7pN4zuZF4Z6JYE09ueNbufnShZCGOaw8m4+aqygDH0H7x8zNqOB0daFcO1ExmICKnp
         zcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021087; x=1731625887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fh1nj3q16SjAJPEM7S+l5jum3bYi5R42P7sSt3yF+b8=;
        b=D05afH5DPKUYK5h5pleOkfHo76gjLFgmSz2s5/2G7VNbrtjGPV/Uv0ep8/bwkW2cKT
         ge9tucuLb/ozFK8M63Pqj/oQHyhh0ruICFASRBz2iIhf2dYX8n7COhwZDWakJmpv7N0d
         q37vVC0Ax/K4ijVd6lmPziaWi3MeDfVZ0iqMeyCKFdLT/9Sj9llAhkTBeFRdFoQ0KaZD
         qz5qc3J8Do/QMqLtSpBC4AUHJpNykFy3E7m63zQzfPDZ8qBxuLntWPHtVGdmlr6wA5V5
         tXy8ram9ysWRs2efA3gFxqSrGBDIZFxXByMXW6dplUO16sZzPqvCL+LftYe62nWIZZve
         gzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ZWZPC40Akg8VnoEi6uiOEU0w8o/UcOwD9FrxyCwE7UOkKCx1sA88hOwxfdQ/jz8fOK9PtNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfNEMk7qBPTuqP3WIqe6UpX0jfFWZl0VO02vCnrZ+LbG3JSsl
	NTHMWdJJFK6EvetdVQ3ZA8IgEWJUlgMoJvZpAEXzdKtO1RE/DKvA
X-Google-Smtp-Source: AGHT+IGG1DYqwEG8zekd8ObAeTHaFMRdYpKOvahLsqVLP/QnEVDeR0d23FrlV54VHPkxXEERIrxh1A==
X-Received: by 2002:a17:907:1c85:b0:a99:ffdb:6fef with SMTP id a640c23a62f3a-a9eeffda4dfmr48276866b.46.1731021086857;
        Thu, 07 Nov 2024 15:11:26 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a7d3sm155086666b.70.2024.11.07.15.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:11:26 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net v5] net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
Date: Fri,  8 Nov 2024 00:11:23 +0100
Message-Id: <20241107231123.298299-1-alexandre.ferrieux@orange.com>
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


