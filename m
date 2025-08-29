Return-Path: <netdev+bounces-218084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE9B3B06D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D15C58477C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810182356C9;
	Fri, 29 Aug 2025 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5h9d3lD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D9233735
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430601; cv=none; b=kfEgzONGV+7F+TOx5UFQ6hqeBRhk0ffrFnHdEA5kIilUE17c6A1wwbGzjRoGVN2SAqR7OTSaHsSorDjiOTf8OS1lahAyDRCJ3UVXFPGHR4KOmwsmPj+/U7S0DCdk9bPHPqyXgFt98Q/YPmqmrmcLrV/IASrtyWpasaYwTUHOPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430601; c=relaxed/simple;
	bh=gkKfkycP5e3uoUJG2GLTfmvIJ1s+52Si619K98/bfd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I31tg6j2QphMGxMUElMzw+5szSTS9OMZcRAmyRFymj+IbqzsBy7L99r3Q1KcM6POzEVZJNvwcQH/dlWa7KCC0LiHFMcWRZCx1C4fpyM0WJe/Cavq8ADsc0D6XqSGtePXYr3eB2cq5TUcWHgxmvs7OXxh8kPwuKXOYufduW44GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5h9d3lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910EBC4CEEB;
	Fri, 29 Aug 2025 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430601;
	bh=gkKfkycP5e3uoUJG2GLTfmvIJ1s+52Si619K98/bfd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5h9d3lDvRWJ7KloQBYeL/mhYrfKS1XX0ZO2FeI6aJXUX244c67vjRBLdhTsRf612
	 j+pYH+oHO+SOUh6JNBIbCgOPzg5Bo80E/BTHF+oA79FoFwHguxLO9pq+P94LE9iYBB
	 a/VAg0334NA0Yc4MLk4JQTQ36keK8aA/3+KosqN5eYxmQxQ8xEX8zxiaqy2Dr1rxXY
	 oF/nHDTq37esoFJowDLUIj+o24I9cb1aS/nmYM0FEW4l4vPcatDoHF4DCEdchl8MND
	 2DivlIKGkqzByEL5RlboqAvolC6iI574DgDqgJWwpy460SPlDhEbMJSBkm6mBB5vpZ
	 5nOGJ57pvjOjg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 12/14] eth: fbnic: defer page pool recycling activation to queue start
Date: Thu, 28 Aug 2025 18:23:02 -0700
Message-ID: <20250829012304.4146195-13-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to be more careful about when direct page pool recycling
is enabled in preparation for queue ops support. Don't set the
NAPI pointer, call page_pool_enable_direct_recycling() from
the function that activates the queue (once the config can
no longer fail).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 2727cc037663..f5b83b6e1cc3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1528,7 +1528,6 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
 		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = 0,
 		.max_len = PAGE_SIZE,
-		.napi	= &nv->napi,
 		.netdev	= fbn->netdev,
 		.queue_idx = rxq_idx,
 	};
@@ -2615,6 +2614,11 @@ static void __fbnic_nv_enable(struct fbnic_napi_vector *nv)
 	for (j = 0; j < nv->rxt_count; j++, t++) {
 		struct fbnic_q_triad *qt = &nv->qt[t];
 
+		page_pool_enable_direct_recycling(qt->sub0.page_pool,
+						  &nv->napi);
+		page_pool_enable_direct_recycling(qt->sub1.page_pool,
+						  &nv->napi);
+
 		fbnic_enable_bdq(&qt->sub0, &qt->sub1);
 		fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
 		fbnic_enable_rcq(nv, &qt->cmpl);
-- 
2.51.0


