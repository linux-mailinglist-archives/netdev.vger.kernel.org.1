Return-Path: <netdev+bounces-74636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9DD8620DD
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C8E287FAF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81B14DFD6;
	Fri, 23 Feb 2024 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo6x50kw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B72208E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732751; cv=none; b=mDQ4y6ud4INEHNkErFmng2Gq5bHkEPbY8N6UCTwVbk7sQNLrbLBZsuVhQrUKkrwXzz+bHP3iHrYYvw+ZmtipKjM6eXEru21Z/RnZnYwi60eW3KaSuEJlgCMvLDHLgZYH65tnK29d9U00sKVQ3p+js7AkbddUcFg9O0bPAxGM8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732751; c=relaxed/simple;
	bh=1H19K4cgiITQLNUwjH9ZH/MAgkCfdnFVOkGKSpXALhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXOfiUAgmWJXrvr28J0T4lC5aZ0TmFpO7ZNF03UtwESLOXWuhhSC8dKXVPuGkXO9IAeQZP8QKnU15PCN8evs6DQ2r9rpFAqwi3f8C9kD+8RmFWoiT45QSAzb+F4NbPMXirjWroclqDS1hJpoj8bEjFCBdnYM4UnreKKM/L9ZJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo6x50kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA25C433C7;
	Fri, 23 Feb 2024 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708732751;
	bh=1H19K4cgiITQLNUwjH9ZH/MAgkCfdnFVOkGKSpXALhY=;
	h=From:To:Cc:Subject:Date:From;
	b=oo6x50kwR8vZib8aOMgKc+X0Mrv1tIEUmdjSI+ao4qugGdBdfY/XhvWo2A1NSiAJF
	 VVGEZCgKYEqv/Dqx8UGulN0odjethWmNPI+eXuxDrltqrC1e/+KQHeYAlzuooEZnBA
	 dKGRouKnUn+m+JSmMuKj6FPDn72G0ACvRKMD+Xneq8JLRkhEDfMNjbX0yrhuOqAhWG
	 0L8/suAi2eH2jQe0Kz8xCneaVwOl0LEzwezXHGoxpjaaK02ZKVTUfIXKvPDwpQiAZB
	 qKL0D9akrkeXxSaL7my8m+0PeUiEWO5SW7RygATMiL40PUckoNPKZnmGamWPXbJk/D
	 TPCtG+EHVAj6g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Miao Wang <shankerwangmiao@gmail.com>
Subject: [PATCH net] veth: try harder when allocating queue memory
Date: Fri, 23 Feb 2024 15:59:08 -0800
Message-ID: <20240223235908.693010-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct veth_rq is pretty large, 832B total without debug
options enabled. Since commit under Fixes we try to pre-allocate
enough queues for every possible CPU. Miao Wang reports that
this may lead to order-5 allocations which will fail in production.

Let the allocation fallback to vmalloc() and try harder.
These are the same flags we pass to netdev queue allocation.

Reported-and-tested-by: Miao Wang <shankerwangmiao@gmail.com>
Fixes: 9d3684c24a52 ("veth: create by default nr_possible_cpus queues")
Link: https://lore.kernel.org/all/5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/veth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a786be805709..cd4a6fe458f9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1461,7 +1461,8 @@ static int veth_alloc_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
 
-	priv->rq = kcalloc(dev->num_rx_queues, sizeof(*priv->rq), GFP_KERNEL_ACCOUNT);
+	priv->rq = kvcalloc(dev->num_rx_queues, sizeof(*priv->rq),
+			    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!priv->rq)
 		return -ENOMEM;
 
@@ -1477,7 +1478,7 @@ static void veth_free_queues(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 
-	kfree(priv->rq);
+	kvfree(priv->rq);
 }
 
 static int veth_dev_init(struct net_device *dev)
-- 
2.43.2


