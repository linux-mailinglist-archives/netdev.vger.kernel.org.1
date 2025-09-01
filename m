Return-Path: <netdev+bounces-218925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1EB3F062
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162C92C0DCC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC7274B3B;
	Mon,  1 Sep 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+sY1MJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD78279329
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761146; cv=none; b=TLNxGBD22g+qFya2hYwQHAMF1PpSw4VYVM+QqEc2glIhwHu9zlUsB475xTNDCbtY6EbyWFsDDEAMZ7K4naR/JgbAJd42T8duQGJ8+GWOqiJCAVQUcRes9W9d/jB8TDi7iBCcJwBUeL4EJ2+5raLYFtjxu9hIRn35p8G6sIbCR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761146; c=relaxed/simple;
	bh=GIq3dnliWUX7S+QReJFhGpX9UcQehj2iFc2AzOoZJJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwRCwv/5fjN4MTtZQStOemhHQYJ4m0KT09iHXnqM9fiH8d37YRPKcb7UntoIxuO1UL+oxKjSSBG2v+GJw0GcJCckc0zEQoOkn9UOsGzVDu6dGQZqxmDzVbt83QL/dDNq1UEIAQN2M6ABNjzwa6ZaXcWHoncdut/uTcxqhT66wg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+sY1MJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C723C4CEF9;
	Mon,  1 Sep 2025 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761146;
	bh=GIq3dnliWUX7S+QReJFhGpX9UcQehj2iFc2AzOoZJJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+sY1MJzi4k9vEbNuqfLKnE+TaVvxgcSb3I4MrswhzRW0VS7UspDNZHAYUsuqVkD5
	 I4lL4H3j6chnAZNFEsQ+noi9GTPTnjTfxHbinspADVi1cM4X/8TXc3EGljdj89hyPl
	 56xo2pjVbHxUxqhoqVwBncFPqlAB/wc84QsroFrAZsu5ACXq9keEwPp8MLLUaxIlCY
	 smOIVbhluxZT3LpiIHDtSsGHN/e1F/Jndi1u9BaUdNZQGHjC8pytp89iQuJoSQGvLI
	 wt/U9KtwKEbf7D6RJUCyZ5na+xtfqZbuWFMzGC//bAv3B8pEqh4qVxqVeDHGfHiBKk
	 UioJP7SChLGwQ==
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
Subject: [PATCH net-next v3 12/14] eth: fbnic: defer page pool recycling activation to queue start
Date: Mon,  1 Sep 2025 14:12:12 -0700
Message-ID: <20250901211214.1027927-13-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
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


