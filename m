Return-Path: <netdev+bounces-215121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AC5B2D230
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A34627722
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F62C21F0;
	Wed, 20 Aug 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5LxKmvw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0562C21E4
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658638; cv=none; b=RCAxfpsXL8l+zNkVW/0WfPAFZUB630JvvGceRjAzFd5/zSBtYVjMnGnZM2BEGgHgoqSWb10ieb7hRIpBCafHyT5xpKEEePuiFU1rQLNaLYOE+O4mFPt9iP7VzLEjhDO6bk/VW5AqVzs9qHXCrwfym57rCcihpuSDINh/T1E92Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658638; c=relaxed/simple;
	bh=B7WyUodqeHbUxJdP9CeacP2SkliVnkY85JHx4haQ8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TERFl0dXROr7CPZI0atewZw8jcaIcdh+qyCYHmgpkLpxYwjCEvveFniyeFXw4EmkHyii8fBfUDgwlO32FfnqmIBuJHWNLag4mn4zZZKnn5BMgNI+gqKPw7TtpiCTyh9JGP75KIx3KpXw+bMT9foCkxTcKtRjwu4rlX8tR70F2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5LxKmvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEB6C4CEF1;
	Wed, 20 Aug 2025 02:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658637;
	bh=B7WyUodqeHbUxJdP9CeacP2SkliVnkY85JHx4haQ8n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5LxKmvwrAgKY2MzygXY3YGvSjYVMz6O7qsAeyJaJXkZYpjFbZYDVyDm3Ty7Gblr8
	 K4DQGE5y6zMuzZDZoBLjZPDvCuIaHGN6K9s6JzKDP5bWPe9sRj4LyYCKhC4mYxiB1p
	 fZpb4ffJS43Mf4E6911a12rPgZWQYUdOGfjgcDJFxRvtneJvOem1Ujim1ne+If/dik
	 LNlFYUGN/nIyuaomgw0Y/ylJPBL+D8xJtG0ghvThERRgbasNNQWnQP/h3SZPThqkLv
	 zYz6QgI/qVsQxOxn2M703awBglnojPbzl+w/JO/ACjz3TJ/ctlRqgUIpeCxwDkOhKo
	 K6GbPFVLSBo+A==
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
Subject: [PATCH net-next 09/15] eth: fbnic: split fbnic_enable()
Date: Tue, 19 Aug 2025 19:56:58 -0700
Message-ID: <20250820025704.166248-10-kuba@kernel.org>
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

Factor out handling a single nv from fbnic_enable() to make
it reusable for queue ops. Use a __ prefix for the factored
out code. The real fbnic_nv_enable() which will include
fbnic_wrfl() will be added with the qops, to avoid unused
function warnings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 47 +++++++++++---------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 8384e73b4492..38dd1afb7005 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2584,33 +2584,36 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_CTL, FBNIC_QUEUE_RCQ_CTL_ENABLE);
 }
 
+static void __fbnic_nv_enable(struct fbnic_napi_vector *nv)
+{
+	int j, t;
+
+	/* Setup Tx Queue Triads */
+	for (t = 0; t < nv->txt_count; t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		fbnic_enable_twq0(&qt->sub0);
+		fbnic_enable_twq1(&qt->sub1);
+		fbnic_enable_tcq(nv, &qt->cmpl);
+	}
+
+	/* Setup Rx Queue Triads */
+	for (j = 0; j < nv->rxt_count; j++, t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		fbnic_enable_bdq(&qt->sub0, &qt->sub1);
+		fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
+		fbnic_enable_rcq(nv, &qt->cmpl);
+	}
+}
+
 void fbnic_enable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	int i;
 
-	for (i = 0; i < fbn->num_napi; i++) {
-		struct fbnic_napi_vector *nv = fbn->napi[i];
-		int j, t;
-
-		/* Setup Tx Queue Triads */
-		for (t = 0; t < nv->txt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			fbnic_enable_twq0(&qt->sub0);
-			fbnic_enable_twq1(&qt->sub1);
-			fbnic_enable_tcq(nv, &qt->cmpl);
-		}
-
-		/* Setup Rx Queue Triads */
-		for (j = 0; j < nv->rxt_count; j++, t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			fbnic_enable_bdq(&qt->sub0, &qt->sub1);
-			fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
-			fbnic_enable_rcq(nv, &qt->cmpl);
-		}
-	}
+	for (i = 0; i < fbn->num_napi; i++)
+		__fbnic_nv_enable(fbn->napi[i]);
 
 	fbnic_wrfl(fbd);
 }
-- 
2.50.1


