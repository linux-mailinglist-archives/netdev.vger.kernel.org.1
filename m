Return-Path: <netdev+bounces-75539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CE86A705
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D675D1F2B685
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D49E1CF99;
	Wed, 28 Feb 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E8icruJB"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12A18E03
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089631; cv=none; b=RHkumMO9KoG/CwZDjWyY9aWt9qxJJTUvRwCXPbQtm1tVpjOJq/CmCMUYnZ+x5qtfPpTRKOBbzAlybAt5IsABpDgIjgp+fAxAa7fOkJ4dV07kpzCMX52l/jmPXHyZfPvC5dAivFKPfWilcKByS9DH++WMx9mCDDcCBYME5FSNuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089631; c=relaxed/simple;
	bh=YWUMJYeEmEi5YgB5UV+YLGCM5hUlw1AkTWki47qWcB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scUSoPErTanT3PCHcnuCqZHVzOmlxP3JQJvYGaWzjYorA1a6Iz9eAgJLOH5g7vxUmn+pAkfB+XReD+ZjEUHeRDR/vbZPwu6By9PEIviGXsilW4HDkr/QuFMlawbhPly3XM7bIiHMHGag08SopIjG937p7tc/5C5I3Dd74rB5DuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E8icruJB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709089627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ady3zvzopzyvN/zEGdRnL4UBfDtyiVeBd052MCFOZo4=;
	b=E8icruJBgqa7JIDdvEE2RoAi5HpWy6SFWGBe3IDyvSn62PHK/cDa4GFh6BCcRGx1eMyzEz
	sWaZ5I4qQQXuWyckPq1c1t2YfHCuZG68FLD9Nu2w9b3ZtsajCzLSarrvvNafQhzDQrI1rz
	hfEi42BKJb50OnoH/wVUwC2sB2TFijg=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] net: remove SLAB_MEM_SPREAD flag usage
Date: Wed, 28 Feb 2024 03:06:58 +0000
Message-Id: <20240228030658.3512782-1-chengming.zhou@linux.dev>
In-Reply-To: <20240227170937.GD277116@kernel.org>
References: <20240227170937.GD277116@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - Update the patch description and include the related link to
   make it clearer that SLAB_MEM_SPREAD flag is now a no-op.
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..7e9c8fc9a5b4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -343,7 +343,7 @@ static void init_inodecache(void)
 					      0,
 					      (SLAB_HWCACHE_ALIGN |
 					       SLAB_RECLAIM_ACCOUNT |
-					       SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+					       SLAB_ACCOUNT),
 					      init_once);
 	BUG_ON(sock_inode_cachep == NULL);
 }
-- 
2.40.1


