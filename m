Return-Path: <netdev+bounces-43921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706A7D5741
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20423281AF1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12AA3995A;
	Tue, 24 Oct 2023 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGD7MGHU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5139952
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AB5C433CA;
	Tue, 24 Oct 2023 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163363;
	bh=TDbn+MdB1+dGBMDLPR3vPub/geFxrl+2RiGL4blNUXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGD7MGHUOV3B9xuXTn7VimvoLawlz/uAMgLea+y1x3jIsCMCcfAvTzeg6dCcip0iD
	 31Hpku6LoNqOCTA0iOPf+9nAVNGIArSLKaegIf1DPTPbCdy+d6yROA7RNtsfJRq+Cl
	 KRNG/QAdGpyoibL/sUQdsXskAk4KYg4A8Mw7ifw8vfr2us3YC7SWPUNMNSQa6BCxR2
	 FtS1pvcOhMQLwMoT94qBShDGf9KevChyAy/eClbyjDdS5vhTHL6HEF+CKYO1FZ0+MA
	 e8pDMX9aqL/N4HxUJ3OAGMFrUEiRki1U7VuJoISo6WVcoCLJBaKAMjSal5afE1HC4c
	 9AVIB1VXYTo5A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/15] net: page_pool: stash the NAPI ID for easier access
Date: Tue, 24 Oct 2023 09:02:11 -0700
Message-ID: <20231024160220.3973311-7-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid any issues with race conditions on accessing napi
and having to think about the lifetime of NAPI objects
in netlink GET - stash the napi_id to which page pool
was linked at creation time.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h | 1 +
 net/core/page_pool_user.c     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index b258a571201e..7e47d7bb2c1e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -193,6 +193,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u32 napi_id;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 7cd6f416b87a..5d8b1bc2474b 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -37,9 +37,11 @@ int page_pool_list(struct page_pool *pool)
 	if (err < 0)
 		goto err_unlock;
 
-	if (pool->slow.netdev)
+	if (pool->slow.netdev) {
 		hlist_add_head(&pool->user.list,
 			       &pool->slow.netdev->page_pools);
+		pool->user.napi_id = pool->p.napi ? pool->p.napi->napi_id : 0;
+	}
 
 	mutex_unlock(&page_pools_lock);
 	return 0;
-- 
2.41.0


