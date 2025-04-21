Return-Path: <netdev+bounces-184456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799BA9595F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170A11890141
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909E226556;
	Mon, 21 Apr 2025 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPzVB1cW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590522617F
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274519; cv=none; b=Br4TJxrf1ceXv9DoktoG3s7i5QbO1hOxe2VYt6cny3xgEQi8ku9AZDKJfcpwyDnnCAYrjK2ijL1MsuN6K9i1RdIREdgkAeuSzIfqr8eEreOKmI85Kc62ouJ5qRwazTTVJk0WcwvIC4myfA3ZbfgAeGWr3Gnrwdhmx+jb4mYiHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274519; c=relaxed/simple;
	bh=631Dh+L2nD7vYry0BG18l+gWoo/Y4BvMCYUrG6zJ7pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV27fmTUKvorO3bMf6zI/zBWkzh7IU7UTjxtct3h7B98gJvXSlmbmArMw0Enhw8XglwnDDsPbRZJuSAZxmzrDuSBpzm996s0SLAYuJAdGMgC31X3Tot37vfkXhrIxopCrv8S8LK/ttge48qKG6gSiN4NZLiI/Zuj/j3PJqZsjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPzVB1cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F6C4CEED;
	Mon, 21 Apr 2025 22:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274518;
	bh=631Dh+L2nD7vYry0BG18l+gWoo/Y4BvMCYUrG6zJ7pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPzVB1cWQnsoboWpFJrbz6KeHZHQJ7W7SCDvEckNT1AeRLovcwcRkwEa9Y+Af1CZ2
	 ZMFW6ZwwubeJ7R7Q2q2Sf0aI/4eI3K6tr3fHIa/8iluQkkKSDRJuAuzVrhP6KDrcRk
	 ViUrDAws+S//sSYuVHl13BI25Dh8mKtM0jOXZrWItVVvE7O2gVxUnl9wAfyfhLwenU
	 ScSn6TOf8eYRimBaNjkXj/cjNt8y4jyDrOsR0vEevcUgKRYvdm0NN5HbySImA8Y58j
	 s7zlhhUllKo0Xd8uu42UQxHR2L1+DL7hvkT0cMTyvzUZ9LCjdkeoA/6+/kRxsGLlqg
	 An+9ImeSoG6NQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 07/22] eth: bnxt: set page pool page order based on rx_page_size
Date: Mon, 21 Apr 2025 15:28:12 -0700
Message-ID: <20250421222827.283737-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If user decides to increase the buffer size for agg ring
we need to ask the page pool for higher order pages.
There is no need to use larger pages for header frags,
if user increase the size of agg ring buffers switch
to separate header page automatically.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b611a5ff6d3c..a86bb2ba5adb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3802,6 +3802,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size;
+	pp.order = get_order(bp->rx_page_size);
 	pp.nid = numa_node;
 	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
@@ -3818,7 +3819,9 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	rxr->page_pool = pool;
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	rxr->need_head_pool |= !!pp.order;
 	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
 		pp.pool_size = max(bp->rx_ring_size, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
-- 
2.49.0


