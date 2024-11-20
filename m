Return-Path: <netdev+bounces-146392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF19D33C3
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD5B23986
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F3177998;
	Wed, 20 Nov 2024 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nsoYeUbK"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6243516F8E5;
	Wed, 20 Nov 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085306; cv=none; b=M5zD54bPM8G/jAijl3XfoTyQYzx2krR0Pz86hNhZRAB/BM5mC4P24Xc3CEYAQdeOgK2WScnGNcM/ieprTX2hsDg4pwbzA97k9j138UARrYYnvIkUqi0XqiRFunGmiyZ98QdhEvuZipmqGyzKt+kQZ9TKKbUGfcGtZejTSZZtpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085306; c=relaxed/simple;
	bh=gF13eQVa0Ocaq1UGdDe667AyqYd4x7jSGMSKC4l9o1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K01y6B00IA50FlSjJX31YQnLh9QE/1cJo+YQWvg1o3lQfrGSgpi1SIFcmWfOsancBpPu3eVvqhpfSmE7gh8cm2ThQtlcUS3UzCLpOudUT8IbbMdl8GqcFWZbIAVwtBRHJBsslEDADBqSPsskoDWQWqgWbGdvyZSTvhiS+0a9fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nsoYeUbK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6ho3G
	nqgGCt9fsxOHh+xodC+HlFBZfqO/I/iBHnLVCg=; b=nsoYeUbKFSvmbSvLA/Q68
	lK8AQuvwO95fHEoj+QhFjv6DpRUBO6APzClm9J1nlFWnyGY2fAnqcouRAZfLE8v5
	NUE6OEKlGBtiRep6ui6X11Wpd9p57xnQG0ukhOXDVFJxazJSPm4bgc7UaQigBtok
	39+ru3S1RRuuz5Rn0ppXYs=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnD1j4hT1nTO3OIQ--.22522S6;
	Wed, 20 Nov 2024 14:47:26 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	pshelar@ovn.org,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH 2/4] perf/core: convert call_rcu(free_ctx) to kfree_rcu()
Date: Wed, 20 Nov 2024 06:47:14 +0000
Message-Id: <20241120064716.3361211-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120064716.3361211-1-ranxiaokai627@163.com>
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD1j4hT1nTO3OIQ--.22522S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1fXw17AF1rKF17Gw18uFg_yoWkuwb_Xw
	47JF9Fgw4jya9xZryDua13tr10qa9rta1Fyrs7tFZrJFy5Jws0yr1SyrZrZr95XanrZa43
	KwsxXFn0qw48AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1p6zUUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRudTGc9e4T0vgABsN

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

The rcu callback free_ctx() simply calls kfree().
It's better to directly call kfree_rcu().

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/events/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..7f4cc9c41bbe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1210,14 +1210,6 @@ static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
 		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
 }
 
-static void free_ctx(struct rcu_head *head)
-{
-	struct perf_event_context *ctx;
-
-	ctx = container_of(head, struct perf_event_context, rcu_head);
-	kfree(ctx);
-}
-
 static void put_ctx(struct perf_event_context *ctx)
 {
 	if (refcount_dec_and_test(&ctx->refcount)) {
@@ -1225,7 +1217,7 @@ static void put_ctx(struct perf_event_context *ctx)
 			put_ctx(ctx->parent_ctx);
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
 			put_task_struct(ctx->task);
-		call_rcu(&ctx->rcu_head, free_ctx);
+		kfree_rcu(ctx, rcu_head);
 	}
 }
 
-- 
2.17.1



