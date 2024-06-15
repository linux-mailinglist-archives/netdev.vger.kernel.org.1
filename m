Return-Path: <netdev+bounces-103817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E2909A0B
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 23:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB42281916
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B04964E;
	Sat, 15 Jun 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCTEqJeq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBF1D53F
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718488054; cv=none; b=AW04oBZTm21wbFR6CeNVS/mysj/NcF+rbx8gv+XBXEd7zJSwRaYC0gepJQ7g210s4s4A/RNwdFqteN3cUyRYvxk1Wuc82Av7zyjwIq7l2JnO6opYS3GsOX/RvV6SQ0B3hxe2Sn5/VBJgllXpg4rISmr6zapuWdPC7Rsb40quSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718488054; c=relaxed/simple;
	bh=G5dTdWAWhOfeMQQleLTCJ1vNe5GtEE8ajP48RYjrXWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmZSAHAVzmZp9fYAZAMg9NJY6nXZVV7m9RBZijoB/auu0N6JKO5yW8TWn+OVdFX+w//AzkUoEbcAB7Uw19AjDn0DzLDSxRi/6Lnu4VYUgZ+4i5s0BeUD3XODADzOhprT9lU5/ZbMCGXLpfQH/NINawYAUlxkm+A8jzxXsUw8Qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCTEqJeq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4405c2263eeso16958621cf.0
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718488051; x=1719092851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9jzv1SMlWSVyfXjNSF6E2bsDuOzPP27ZQ0/cjQRYBA=;
        b=BCTEqJeqFQPsx2OzIJojwreX8K3V2K4ZSKjkDy1lH/pD7DNbKp39/I16Alm5FgQGPX
         IhEn6Fbl5DdxGJg1G3HzG9OrklrWExFoJ4MRSBWcy8LtNQKnl2iL8Ty2l4G3WARm8NOF
         xhBu96JUFJrUc4bGd/c1YK/QfTZHm73P3dghMEFIjw0/3VtTz8nSrDvNRRcdNAalQhZ+
         eKk7yLN6Mp05q+f7m3SUGwaJYVoPDtVUKwK9ct/pU88WBSntcFFQ8bHgo0tPYFfs+NAJ
         RptPsGqkWavlejB+jX2ZrGY0ylJqCYj4X0V68IcxAjKFz70is1QNGw4VKkU66/7s6Jbn
         x41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718488051; x=1719092851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9jzv1SMlWSVyfXjNSF6E2bsDuOzPP27ZQ0/cjQRYBA=;
        b=uaisEV4HY6EKUVDlG3FffHjthIlbj9Ij3fSW6X2N29UrXIbsgau39oWNJjnEBQG4OG
         q/pJ/3dSeLd6vkAYW1t3z9BkbbxhI4p5i/B0ayqAjJize6l/nqD0Zl+rMmUE0ogUiMcb
         LB+Wge9Rl5oJhtyWuUxxZ6YDFsEqXErhbT/Ty/4s4HSjwvSos6nqFMv3zPWyDQLlySk0
         dEyn82vJo6mpQKToI0TmxfeoPl3eGPKOZt1AOkdbwGlolCrBfNLvGYIi5shtN+RnG7ne
         0jhdH1V8UsOaAmrdUD4vIlGuyNBtlgOLThBXnMIe5hO+JS/ujV0ziflOae/OY6R/WXj9
         2tsg==
X-Gm-Message-State: AOJu0Yyd/qH/ys/f3fykHXkL6pF2pCaSlMqqwOlTLgiISnAUz3YSVX3c
	o4tl/aiU7ajkIkdBZUtKn6M2qU1Jwz5NF1TwvKdgxi4ZTQreLBGVa+P/Efsd
X-Google-Smtp-Source: AGHT+IFHP9HcuH+sEy5gXvMP5H8uFzw7NADXkjjk4L7sg7gttDqfCXSl/7x7VTBe0mGBNQmeZKgiJw==
X-Received: by 2002:ac8:5a8c:0:b0:440:60f3:733b with SMTP id d75a77b69052e-4421685caa4mr66735761cf.14.1718488051063;
        Sat, 15 Jun 2024 14:47:31 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-442198f6160sm21222751cf.45.2024.06.15.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 14:47:30 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Blakey <paulb@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sched: act_ct: add netns into the key of tcf_ct_flow_table
Date: Sat, 15 Jun 2024 17:47:30 -0400
Message-ID: <1db5b6cc6902c5fc6f8c6cbd85494a2008087be5.1718488050.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zones_ht is a global hashtable for flow_table with zone as key. However,
it does not consider netns when getting a flow_table from zones_ht in
tcf_ct_init(), and it means an act_ct action in netns A may get a
flow_table that belongs to netns B if it has the same zone value.

In Shuang's test with the TOPO:

  tcf2_c <---> tcf2_sw1 <---> tcf2_sw2 <---> tcf2_s

tcf2_sw1 and tcf2_sw2 saw the same flow and used the same flow table,
which caused their ct entries entering unexpected states and the
TCP connection not able to end normally.

This patch fixes the issue simply by adding netns into the key of
tcf_ct_flow_table so that an act_ct action gets a flow_table that
belongs to its own netns in tcf_ct_init().

Note that for easy coding we don't use tcf_ct_flow_table.nf_ft.net,
as the ct_ft is initialized after inserting it to the hashtable in
tcf_ct_flow_table_get() and also it requires to implement several
functions in rhashtable_params including hashfn, obj_hashfn and
obj_cmpfn.

Fixes: 64ff70b80fd4 ("net/sched: act_ct: Offload established connections to flow table")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sched/act_ct.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index baac083fd8f1..2a96d9c1db65 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -41,21 +41,26 @@ static struct workqueue_struct *act_ct_wq;
 static struct rhashtable zones_ht;
 static DEFINE_MUTEX(zones_mutex);
 
+struct zones_ht_key {
+	struct net *net;
+	u16 zone;
+};
+
 struct tcf_ct_flow_table {
 	struct rhash_head node; /* In zones tables */
 
 	struct rcu_work rwork;
 	struct nf_flowtable nf_ft;
 	refcount_t ref;
-	u16 zone;
+	struct zones_ht_key key;
 
 	bool dying;
 };
 
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
-	.key_offset = offsetof(struct tcf_ct_flow_table, zone),
-	.key_len = sizeof_field(struct tcf_ct_flow_table, zone),
+	.key_offset = offsetof(struct tcf_ct_flow_table, key),
+	.key_len = sizeof_field(struct tcf_ct_flow_table, key),
 	.automatic_shrinking = true,
 };
 
@@ -316,11 +321,12 @@ static struct nf_flowtable_type flowtable_ct = {
 
 static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)
 {
+	struct zones_ht_key key = { .net = net, .zone = params->zone };
 	struct tcf_ct_flow_table *ct_ft;
 	int err = -ENOMEM;
 
 	mutex_lock(&zones_mutex);
-	ct_ft = rhashtable_lookup_fast(&zones_ht, &params->zone, zones_params);
+	ct_ft = rhashtable_lookup_fast(&zones_ht, &key, zones_params);
 	if (ct_ft && refcount_inc_not_zero(&ct_ft->ref))
 		goto out_unlock;
 
@@ -329,7 +335,7 @@ static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)
 		goto err_alloc;
 	refcount_set(&ct_ft->ref, 1);
 
-	ct_ft->zone = params->zone;
+	ct_ft->key = key;
 	err = rhashtable_insert_fast(&zones_ht, &ct_ft->node, zones_params);
 	if (err)
 		goto err_insert;
-- 
2.43.0


