Return-Path: <netdev+bounces-289251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CYJD+HDC2qWMQUAu9opvQ
	(envelope-from <netdev+bounces-289251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E6576380
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00C453043686
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308B2FFDD5;
	Tue, 19 May 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFtwA/JM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB62FB97B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155933; cv=none; b=B/sGZiZhM4pjw9FYfiyA6MQBhos0FRIypCvVRDSMdI5fuRXie/51G3guSVnB0UTyzmJM6BChThUZQkyvHMgTjy3gLcvuNiIC2z8QVDW/2f1UY9NE2VPrc74eMezNzRa4/OQYCKuptO6FppBLb/e2Hvlc3VZ7wpjTJY8k3R4j0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155933; c=relaxed/simple;
	bh=o9tpwTNBKfUuronh2IiA7Q31eMmatIzAB4cU4aq6YU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIWYg+QUxqXmWvmQyBg0k2QGxwWOa2pz75GSAG0LsNzPkYuMtq46Tn5ppjuBHyXtGkHh9uva3itVFqY3EUV1uX1scd/WOPGpyhSQiTfH1B0pD9/16x9LrxOz6AKTuotM/bF5dQtdamrMtT5sYxFJP41IQvIljB69s7s/Z7VHO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFtwA/JM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so2799998a91.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779155932; x=1779760732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJBOwsmVOS7e0w8Q9mvj/KZhpczr6xeaK0EFoTPkDf4=;
        b=GFtwA/JMJRHL2m89MeRU6sYFKKNU00eqY7jiPwOPGNaBTmqhARmsVHtRRH0o3w0KCr
         VsrhyMx1OxWfgHgSTHurPIUlyYxtu4TKX5pEx5Z0o7a6mZ0hjmAXCQv5GmZBMx5TBdjN
         5yOBH8SubWLi/gzQfpOzUM6PwAlx6YCYwmN5QLMIDSE+LHJY2Nz8EmNOM2b3K4t7MNKJ
         ZwWaEmACh8VyI7dIvC6DWZb74TmZT0UC/Kp8Lbg0/0tUA3qtkShBsrQozX+nNOzf/HZt
         a//YBa/yBVP1FayFjWcvma8GQSlYtuCGUaYDiwXn+CHwmi8wcxDYfq/refyNseze9LxG
         PbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155932; x=1779760732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJBOwsmVOS7e0w8Q9mvj/KZhpczr6xeaK0EFoTPkDf4=;
        b=mNZQDavRN1aaXXn2/yQp4Uzu1ol/TOU8F9vxI4JlwL8PdxC32NICGjipRQrr92kxUI
         +RYBGaVQbJ1BNxZftYhHgxZiAMx2qYpEL3/+jrf0cQDCrFJzBsYlpp9RQB/tl3Xayiht
         OlHVAfFGrLwRBrLk1SnzcSsImsrfqWlFpSZP7t1Af1k3Pd4aGtqBTBSR/1BO5WSQ+hqy
         KGXGWHgPLrm+sDSCg46XITV9cF1rl2JSgStH5eQqQQ6QvUFXRVDA4X9XnHdsm5aIvAdv
         g/5/EWcqpxlTArnlaqWBVaytv0k7TbIm98644d+PUEDwN/smCVu+GkyRO7bBotgEoBpL
         N6xw==
X-Gm-Message-State: AOJu0Yws9TZSo5PzpGl7u2E9MwQEpGz0eNkXaalHoIG52v9feGqp1Y6D
	54g5lGkAhmz3Gso1fTTa8paLPBcPySvH1hu2gI+FaInJTvYdkuNg5cEKm7z0g31L
X-Gm-Gg: Acq92OEV6DqlKbqdAVPbjurxTIbjtuat5T3TeKCuNsMv8XvtHSbygszfOIceHFFfTYa
	X3HcDz8P9VDq0vEvbwQZlIL6vvrYX7LM7vILbQztIGKaxHsguipanWSCJDlcER0WbgVhrlp9IHW
	aEhBRgVy1hJi4D1JZrpqdc5ayHXMxmb+gdgac2y679mphX7yYu7VW8ej+4Pzfu3BgOi2yd+uZd/
	43QjxXmT/r+/urVLCvvGs3Y/M+T/cTN6tisxgizlhom1I8DwukX/GG5jQdfozX71++3gzKvZvyZ
	+XAeudOvt6RBWyjeH5/y3Dwz/nnHh8FpMxPAKc+WpKBc8jN8eyBq1kzgXRILyAu/rMEpNens3Z7
	SwZNCFLcv91GlkXqgqmc1dnQTniGCDzk8kgRcAIVDVnhm+6xZ0iR5Ujvhmy/TbDmGaeGnFoDTDr
	mBbVoULPz7qyjmJOFcs0JIlHQWE1nsEu8XjA4pUyWoxTvkUX7WD7jrMhKObXFxdYSqG8SBwlLUy
	VmKFy9+RwATvf8pLnEPX0Hs+rj4QlLYhwk=
X-Received: by 2002:a17:90b:57c7:b0:365:7e4d:bcb8 with SMTP id 98e67ed59e1d1-369519cdb59mr16915705a91.1.1779155931783;
        Mon, 18 May 2026 18:58:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm12016286a91.0.2026.05.18.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:58:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] lib: objagg: Use flexible arrays for object storage
Date: Mon, 18 May 2026 18:58:33 -0700
Message-ID: <20260519015833.634602-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289251-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B22E6576380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store object payloads and temporary graph nodes in their parent
allocations instead of open-coding trailing storage or allocating the
node array separately.

Use byte-sized flexible arrays for object payloads so kzalloc_flex() is
passed the same byte count as the previous allocation sizes.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 lib/objagg.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/lib/objagg.c b/lib/objagg.c
index 23c7105a3f9f..995ec67fbc2f 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -28,7 +28,7 @@ struct objagg_hints_node {
 	struct objagg_hints_node *parent;
 	unsigned int root_id;
 	struct objagg_obj_stats_info stats_info;
-	unsigned long obj[];
+	u8 obj[];
 };
 
 static struct objagg_hints_node *
@@ -66,7 +66,7 @@ struct objagg_obj {
 				* including nested objects
 				*/
 	struct objagg_obj_stats stats;
-	unsigned long obj[];
+	u8 obj[];
 };
 
 static unsigned int objagg_obj_ref_inc(struct objagg_obj *objagg_obj)
@@ -369,8 +369,7 @@ static struct objagg_obj *objagg_obj_create(struct objagg *objagg, void *obj)
 	struct objagg_obj *objagg_obj;
 	int err;
 
-	objagg_obj = kzalloc(sizeof(*objagg_obj) + objagg->ops->obj_size,
-			     GFP_KERNEL);
+	objagg_obj = kzalloc_flex(*objagg_obj, obj, objagg->ops->obj_size);
 	if (!objagg_obj)
 		return ERR_PTR(-ENOMEM);
 	objagg_obj_ref_inc(objagg_obj);
@@ -657,7 +656,7 @@ objagg_hints_node_create(struct objagg_hints *objagg_hints,
 	struct objagg_hints_node *hnode;
 	int err;
 
-	hnode = kzalloc(sizeof(*hnode) + obj_size, GFP_KERNEL);
+	hnode = kzalloc_flex(*hnode, obj, obj_size);
 	if (!hnode)
 		return ERR_PTR(-ENOMEM);
 	memcpy(hnode->obj, &objagg_obj->obj, obj_size);
@@ -705,9 +704,9 @@ struct objagg_tmp_node {
 };
 
 struct objagg_tmp_graph {
-	struct objagg_tmp_node *nodes;
 	unsigned long nodes_count;
 	unsigned long *edges;
+	struct objagg_tmp_node nodes[] __counted_by(nodes_count);
 };
 
 static int objagg_tmp_graph_edge_index(struct objagg_tmp_graph *graph,
@@ -786,13 +785,10 @@ static struct objagg_tmp_graph *objagg_tmp_graph_create(struct objagg *objagg)
 	struct objagg_obj *objagg_obj;
 	int i, j;
 
-	graph = kzalloc_obj(*graph);
+	graph = kzalloc_flex(*graph, nodes, nodes_count);
 	if (!graph)
 		return NULL;
 
-	graph->nodes = kzalloc_objs(*graph->nodes, nodes_count);
-	if (!graph->nodes)
-		goto err_nodes_alloc;
 	graph->nodes_count = nodes_count;
 
 	graph->edges = bitmap_zalloc(nodes_count * nodes_count, GFP_KERNEL);
@@ -825,8 +821,6 @@ static struct objagg_tmp_graph *objagg_tmp_graph_create(struct objagg *objagg)
 	return graph;
 
 err_edges_alloc:
-	kfree(graph->nodes);
-err_nodes_alloc:
 	kfree(graph);
 	return NULL;
 }
@@ -834,7 +828,6 @@ static struct objagg_tmp_graph *objagg_tmp_graph_create(struct objagg *objagg)
 static void objagg_tmp_graph_destroy(struct objagg_tmp_graph *graph)
 {
 	bitmap_free(graph->edges);
-	kfree(graph->nodes);
 	kfree(graph);
 }
 
-- 
2.54.0


