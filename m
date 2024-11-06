Return-Path: <netdev+bounces-142421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4329BF065
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E9DB21ADC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB41DFE38;
	Wed,  6 Nov 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX4GnGCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258FD1DD871
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903526; cv=none; b=AXRdyaqTHuhSFIsoHKprZ+OV+UPRtAA4INGTybJL33BfrmJykjptvCPkvysE0Pk5zrEqZU0VgaHRG6TeSuNajbS6C66c9Dbb5LgnbNDAR5uiyX/MBGLAaPM6H9wicy+6t1gMco28TsZc+Ce1fFxJBQPc1dryVmAMU7ZXIePgAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903526; c=relaxed/simple;
	bh=lEn6q293PmWCygu2hkjMC7ZLwW+CV7lLkRNckv1tDFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwPAKef2++vO71TzfOUgzB9Xwta+jLMWjIPmmArjLhV0v01rO2k3oKkNC8zGB/pq5ZtZdfUvWSvXtNBFmrykGGLzzEvs0zT6hH5bdVIVHdIGKJaP7SMY38GjRvYu2xoXhytYnKuYLL7/N/I1ioxQ9Z2xHXEv30wzfIPQumT5pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX4GnGCa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso1061614066b.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730903523; x=1731508323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/kojHXY3Ebruk3mlegVR/jOLPLR7b9RJlssI4OX1Fg=;
        b=JX4GnGCaTyi4pwt2SG6Da8Ie38KTanVViaeywhQpwUVPJMsjt4VoNFWDayBObQOr8V
         /3MfxmueQSK7ZAxNM08t6zjRwB+uDP5n3+qHMXo7K32IIgiT+cQbuqZK4Mvn+HMoTdPV
         C+IE2yon79SrdMQSqtW+7XMqarF8uRpvjvcZrnm1PYqOAMFoNqCa9b1kMiBypVFE9XWg
         1MUvILa9e7lnPfMBhEQcacOcEWrgJMlO8knjK16RihAzt+uDr7MtuNXWrS+M/JBDNNA/
         gvrV6umipVevP28iIW7vKsuz+im77TIo84Eo9QnaFxmH1N9iHb+5vlCUQcpNcvZW11ao
         /UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730903523; x=1731508323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/kojHXY3Ebruk3mlegVR/jOLPLR7b9RJlssI4OX1Fg=;
        b=cQeTmKWC1JD3fD44pkMZGggwvabg5fokAoP3LrsIryqfRg2qnIxNNQRDEnm1QxBz0U
         ejS9L6hHlHKwz3sT43gwAbTPTlpBwPsh9HR59Iix+RJVRn+8UqYCi0Uafj0FbFOFlmy2
         2m7FLhQ2R7tK4Vf1P2TD55Od+KdIzOJmblhUa10/ri6XTDdNb8Z0PqMRdESKFYhBcGsv
         zJt2F6a+tpaXLQbqhIxXdAbDS56jXn/2iV53usOWhpCqaqdCspqUvVkyhyizhVgFu3lU
         YMycN8oUV7RvbmpTkCz83WT4qExuT4aydsNKsvJksw3W0lPBMI743LoHanm9bz23PxwY
         Vr3A==
X-Forwarded-Encrypted: i=1; AJvYcCXX5EbzuyBWW9FCammbl8mdZ7+Su2+qWZXLSPyHvGp/9iYF+g0+qVAXa+QX55vFW87Qo+O6Sew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeTrmDFjliVB8ZQWmM3lKri+D+IjViVvX9gQ6OQpFR6XvbFCL
	BRBq4GKPpYUVxaXnsz2lv/zatazOa16wUDg3oxU2CzBUpG4P9Kwo
X-Google-Smtp-Source: AGHT+IGYSOubBJVWjZvxpLFa9vM6vT92sfCAHdRsUyeAPq56XLjYsrcStP3eJeNgdWiyvkj/gtS0LA==
X-Received: by 2002:a17:907:608a:b0:a9a:ea4:2834 with SMTP id a640c23a62f3a-a9e655ab355mr1939471466b.33.1730903523097;
        Wed, 06 Nov 2024 06:32:03 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17d7318sm284361266b.131.2024.11.06.06.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:32:02 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
Date: Wed,  6 Nov 2024 15:32:00 +0100
Message-Id: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
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
v3: prepend title with subsystem ident
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


