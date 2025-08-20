Return-Path: <netdev+bounces-215123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B64B2D233
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3922768273E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0322C21E4;
	Wed, 20 Aug 2025 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9gAV3L8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2E2D23A8
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658640; cv=none; b=gCEaCT1vWzVTYI/RvZPyymRdQ+016UWGecafgI6pOVIiY0CRrWx0dn5M2aGckCnrOmczsH7au2idi37GITcE9Nefy49AnqXaIdR6uArULKHsYY+GSMCpwZg0u4ZBRWSWqtNxwmV0ilvxautEMdEB7ARmWu/U1iuCmb70K7X+Euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658640; c=relaxed/simple;
	bh=D0EIFBVqJD/LPLuZtpl42QEtfaE54rYfGBa0Yh9OV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzrcMjwoXD6yZqmTfQDwz70L6OdqCRshemaLy+7mi+S4xoPqWdDVQuDJpq3maq25EUFCenilNxgBXZJwhSRpVydpaKoo3WmdFNGV3oohwfygry2jLL9v19e1lP1TPDI+SdJpT7VKJ+hFV+j0IfjFBLbYaMzzXWOJTs4eNXyhgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9gAV3L8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBE4C19423;
	Wed, 20 Aug 2025 02:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658639;
	bh=D0EIFBVqJD/LPLuZtpl42QEtfaE54rYfGBa0Yh9OV0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9gAV3L8YCSRCRDPrdIxIhlAJ/HX+2XUk4BBysjokU2W5PM02SirWr8FLyEqr41mQ
	 ic9zG90KNrLviujhQiwkm/k7teuNkNE1oY7mSOVJHmSycKdZPSxYypYV8amMjbUAuM
	 crwPOkua1h31nqBUnXjvQdmurGyB428VMCsj23wwdnCBlvuKbBGegt1cPk29lOC7oz
	 CGD7OvQSwM5JJmxbK2bDLsD4Bxheuxt/yGxi1k3JT2YJcGeyUG4XLZDzYaT6s2RbsC
	 sBESN1i0YQx8r6dzcAeKibQU0gF12FoWE25Avjta9gc3a/vB3F9d9T7Cqb8LdsOaez
	 xb88xJR3/uCAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 13/15] eth: fbnic: defer page pool recycling activation to queue start
Date: Tue, 19 Aug 2025 19:57:02 -0700
Message-ID: <20250820025704.166248-14-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
References: <20250820025704.166248-1-kuba@kernel.org>
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
index 44d9f1598820..958793be21a1 100644
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
2.50.1


