Return-Path: <netdev+bounces-218921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8511B3F05E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED671A887AC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327C277C9C;
	Mon,  1 Sep 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWeSGy6z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD172773E9
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761143; cv=none; b=IBPMukGqZsAZ/eA7deMYuBS63iZ/H5q6k2k9NXvPFavu/cOzcL3/wsD9S8JyTnFAcAdzwm7B0rwULQCFagrzFQ3yLcbRoDz0QHnv60x2LcXYu2CILC8ksZv8XkbLFbkqu0wEiwl/hQW+/KX7tKxHbjCKlYCe2/qjA1lHjeD0DWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761143; c=relaxed/simple;
	bh=BRRSzC3O/Tk7jbyS7dKuUxta1uIlMmQK8fsURtTT0w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkej1xI4ECdJ4UUMiD2DwwBWDx3eEgUsyLlmVo5h8lOYcGwBrypIZB5GsaSc79pNC3lYagzMtiUPAOqYWXVXcWaXw7Ow2gRzcOw7mD7yAFiuv/z0UVp7Fgd62c05nl+BKPcKJ6AiAYLUQ0urRnt/3iWbHC/6umrs09m8+erh7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWeSGy6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E249BC4CEF5;
	Mon,  1 Sep 2025 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761143;
	bh=BRRSzC3O/Tk7jbyS7dKuUxta1uIlMmQK8fsURtTT0w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWeSGy6zNosetP1aVg0FYRZK3OY33CTCIqFR43N5Dk5dv+cNM6cNKHImPgzbjVAU4
	 XnNfvzT6EqcH0OyWm9y4EWY5AvU+7wGCCE61RpKiYlTD/pzrl9p1LfMOCR3pp4o8+1
	 gZ8pkUSSzuKD1CCx077pcD5fXt5OZGXazBTUnur4QibmZ2wtjjg9CXax9mDmCTInhq
	 RTl+s5Hs6gguRCf3mXtI7fP4KWHSabGw1HX70J+8JNRWhIJHRmkVj1zwYxNOVGfpyg
	 ElcVA8JkL/9DQZzVGIL5LSeEPrBxY1lk60FoYW7iX9xUZF5Xa9QS6OEiSk1G/bDUTa
	 OvWkmOliGE1pg==
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
Subject: [PATCH net-next v3 08/14] eth: fbnic: split fbnic_enable()
Date: Mon,  1 Sep 2025 14:12:08 -0700
Message-ID: <20250901211214.1027927-9-kuba@kernel.org>
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
2.51.0


