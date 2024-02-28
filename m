Return-Path: <netdev+bounces-75537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42586A6FE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A019E28AAB6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246A1CD24;
	Wed, 28 Feb 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSBHnx5a"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15E1F94D
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089270; cv=none; b=nIcCRYgYLc0VJcARqedv4v6uzll8yDKu78+NOd6IBLqo1Q+B5m9OWd0vIw5BqGcr3ZGFB3m5spm1XkKks3elcW7YgMDi3BWfs6TU6bBk7MpNFJ4Q4f/bylIhH7sAXjkwblLt3GrRu+aVD9PlFZJlQPMuCoqN0vvR4HW8Xf7AKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089270; c=relaxed/simple;
	bh=44eAExaoKOEQk5ukoxdoPzBdzKOtulgFE/DZyWWVxyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LObL/rt9Ux+yFHmW+39vLvrLVAbnsJWfignbqOdY1kZ/oVzXFTppaOP0W6+jdqP1LOHzukHZLOgWTEScT7gDI8WRKYJSEZ5PYcNFd6MCj+2StxxrnBSSkAFw1pZJ6StlBeyWwNgDD98a2yb1VSiybpNk/2e+It0U5BJl6bFoal8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSBHnx5a; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709089264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDnxe9eYF1JUw/9RztFqz6tXSi5tLcRZZ8MijsZ8vGA=;
	b=dSBHnx5aGRslGVllUhh6L5OD9GMByeheHeRALJRSwWpb388kXtzYqneq5UoEstdfF8llZk
	FBtkQT+wdPJX8X40mHM2CtlKJfPZKxlpAK8tBOm6MlbFbgMOTwbIZqJZT2NuLaFAhArTBN
	d2hbUoWJ9KbhONl1gytxC6qAn3EB8IY=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: horms@kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] sunrpc: remove SLAB_MEM_SPREAD flag usage
Date: Wed, 28 Feb 2024 03:00:51 +0000
Message-Id: <20240228030051.3512521-1-chengming.zhou@linux.dev>
In-Reply-To: <20240227171353.GE277116@kernel.org>
References: <20240227171353.GE277116@kernel.org>
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
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index dcc2b4f49e77..910a5d850d04 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1490,7 +1490,7 @@ int register_rpc_pipefs(void)
 	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
 				sizeof(struct rpc_inode),
 				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 				init_once);
 	if (!rpc_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


