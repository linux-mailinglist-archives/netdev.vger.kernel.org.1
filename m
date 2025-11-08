Return-Path: <netdev+bounces-236960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572AAC4283B
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D086A3B4495
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C92D877A;
	Sat,  8 Nov 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="g6xTdNiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA12DAFA1;
	Sat,  8 Nov 2025 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762583202; cv=none; b=QLQ4fJcnzViXNkYJSCEdTxuEEc6paFHFf21YDEv2v0Y6Nl+/4zNyNmFWq/1r7iu5zYKb0Djjv2xWyvwsuIU58uuZBZf9Kv5kdmjfuuet7zYZAQPtj32BqJvkqbar2UwylX9ICgnP9TllWy/S6YjmSlyklUDCw6I0IJumxafxwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762583202; c=relaxed/simple;
	bh=65teNlTbq6Jevo8Cf4DSX/Qnl0RKO/VMIyVZHQWG5Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pEpm1KcjcfzEcYUIPpIIDvRVTMTXgrmm3WSM8gZ8C9xLGNTLyKw19J3nEVpWpFmBHyQU0N3crXJnVVEYRFsmUlKU1nY1wnxZoVfrnbeUhT9X7bLGH7SW6XcE29US/mVZ+FRN1S3yi6w6f1ME4HlepHQgY0YF8PAJdGYIchFlFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=g6xTdNiT; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28d8d27a7;
	Sat, 8 Nov 2025 13:10:57 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] xfrm: fix memory leak in xfrm_add_acquire()
Date: Sat,  8 Nov 2025 05:10:54 +0000
Message-Id: <20251108051054.1259265-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a61dfeef903a1kunm2bd550c094fc87
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkwfVkxDTElJGkNPSRpJTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=g6xTdNiTOkuSum0lSOnJ+XO+D8ICTqGUbfprLYtZmnjwOuPh4baATXL/TrgzJXwqk+v7Y7eNBZNqbffz8i7n9LBraf3j1AasrP1NaSqytyDYXolL67tC/gpMlD9ciQiggGcXTpbGuiKPXq8r8RomY850Uu1V3G2LfuEXadiTHW0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=mSnBSZgX14bQ00Hppf/u9+1AsIxnmoTIZoBNhjNfJog=;
	h=date:mime-version:subject:message-id:from;

xfrm_add_acquire() constructs an xfrm_policy by calling
xfrm_policy_construct(), which allocates the policy structure via
xfrm_policy_alloc() and initializes its security context.

However, xfrm_add_acquire() currently releases the policy with kfree(),
which skips the proper cleanup and causes a memory leak.

Fix this by calling xfrm_policy_destroy() instead of kfree() to
properly release the policy and its associated resources, consistent
with the cleanup path in xfrm_policy_construct().

Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 010c9e6638c0..23c9bb42bb2a 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3035,7 +3035,7 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	xfrm_state_free(x);
-	kfree(xp);
+	xfrm_policy_destroy(xp);
 
 	return 0;
 
-- 
2.34.1


