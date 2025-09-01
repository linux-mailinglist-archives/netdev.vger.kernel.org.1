Return-Path: <netdev+bounces-218922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F2B3F05F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42224E0540
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97722278161;
	Mon,  1 Sep 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aix9YOST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BE278143
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761144; cv=none; b=jX3FC4L5D2APbXR+KJ3HuLL0HWDTfKV00mTqTmx3mVg9m+jIPC0cakk2+uE9fDN1iIqjn/yHPTr/Hrk4B1yVIZf+UrGZzv77yNEzOk10ESNtc/yiuekMW8u36HzaCthUln2ShIq5MoGe5NHesKINAu2wrUcLTBfA7sB3ZLr2n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761144; c=relaxed/simple;
	bh=F2+9yFgrCOgv6XZfurnew0Mcm2Ti3r90QGF6C8el4hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVkDTpuFND7Hrip6N7lrpVAVr/cwRLot8nfvfPEX+pi63JeSnCCiHFqO8c79N2um12BHtKoU6KRhaSytZ9F1Q2F1lbp8zs045YrhZhRpuR6H7Eg5PQNNyvk6UOnTOwSTF1BnBheitTp3eiDDQ/Ju1mQR7uYuEi00DIhFVeBl/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aix9YOST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA98C4CEF0;
	Mon,  1 Sep 2025 21:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761144;
	bh=F2+9yFgrCOgv6XZfurnew0Mcm2Ti3r90QGF6C8el4hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aix9YOSTX0d5UGXjOXWkStcFQAXpk1jGHLvI1cQ/E64AMWluR9AgkGJRK5yTYjegz
	 YhdQ7Ka5hpqikDJCNNxpN7siI6Eb45mceS7yhjuhIg5w4Ppha8Hzfal20nXUPWIBcm
	 jR7u/R5uBUGBsbcvWJH1pjEKVsyAi8hrc8VG28Nr4nip6LLLHuqsZnwjvaQqCvc5Jo
	 Hz2d1zQb3C24w1jhBF2MYbhgWOWus0rpEu1acgREIhddi33mQlxiogzSzyicfK3Ukb
	 dYHASNwaXthxunnDIrGbJ6GCfBSFEXy22MMUgVkFQ46/xwDYOMmRyx3H+SGGaggg/r
	 AHTBvrpW7uBHw==
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
Subject: [PATCH net-next v3 09/14] eth: fbnic: split fbnic_fill()
Date: Mon,  1 Sep 2025 14:12:09 -0700
Message-ID: <20250901211214.1027927-10-kuba@kernel.org>
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

Factor out handling a single nv from fbnic_fill() to make
it reusable for queue ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 33 +++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 38dd1afb7005..7694b25ef77d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2348,25 +2348,28 @@ void fbnic_flush(struct fbnic_net *fbn)
 		fbnic_nv_flush(fbn->napi[i]);
 }
 
+static void fbnic_nv_fill(struct fbnic_napi_vector *nv)
+{
+	int j, t;
+
+	/* Configure NAPI mapping and populate pages
+	 * in the BDQ rings to use for Rx
+	 */
+	for (j = 0, t = nv->txt_count; j < nv->rxt_count; j++, t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		/* Populate the header and payload BDQs */
+		fbnic_fill_bdq(&qt->sub0);
+		fbnic_fill_bdq(&qt->sub1);
+	}
+}
+
 void fbnic_fill(struct fbnic_net *fbn)
 {
 	int i;
 
-	for (i = 0; i < fbn->num_napi; i++) {
-		struct fbnic_napi_vector *nv = fbn->napi[i];
-		int j, t;
-
-		/* Configure NAPI mapping and populate pages
-		 * in the BDQ rings to use for Rx
-		 */
-		for (j = 0, t = nv->txt_count; j < nv->rxt_count; j++, t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			/* Populate the header and payload BDQs */
-			fbnic_fill_bdq(&qt->sub0);
-			fbnic_fill_bdq(&qt->sub1);
-		}
-	}
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_nv_fill(fbn->napi[i]);
 }
 
 static void fbnic_enable_twq0(struct fbnic_ring *twq)
-- 
2.51.0


