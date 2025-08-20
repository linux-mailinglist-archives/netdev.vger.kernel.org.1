Return-Path: <netdev+bounces-215119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B279DB2D223
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BDF1C22789
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270602C21CD;
	Wed, 20 Aug 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KseELUqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006424729C
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658638; cv=none; b=pJF1UcvYLr/fUx95KssPBXzCr6cIY6Edaa6XE5TBZa8tjDLv3CZ0mN+UC1Mq7pMNLIx4zfddzhSW7Dr/lGUD2AxR+lPoTCMgqlcjJ/EG0Znu4bDZx3AhxTH1GSELUy+aOQh2g4H+cgoskxkhHkzm3AwCWpykMBLARWxctHQF3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658638; c=relaxed/simple;
	bh=x3H5pNPT7j3/5oPplHFnOiwG0NL8yd9SsTetSWXOHLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8P6q1ba6XGu0lVSFQusRuHSVrlr7jrGY/1kldisM1PcrcdPr6XUlzaLlD/Swvs2d73jHK80dozmzVHoAr7rBR3GHFX2dFwhSkfXzdnipXz2vJAjAFZRxdGN1C9r2Yp736Q9iCZOaKkVN+I5IXFXMArXlCscgoZB69LoXqUsQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KseELUqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62646C113CF;
	Wed, 20 Aug 2025 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658637;
	bh=x3H5pNPT7j3/5oPplHFnOiwG0NL8yd9SsTetSWXOHLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KseELUqKFcczbIi5RjN4OI1ReZf5prnMTt3Cy2rz4XK931YeSvL5PUPgP0yBKcv1m
	 qdblf1CQVlWzE+smxGDD+kBl70VxDJIUGdMzSLHNLzEUWquMed455c+bFXgcHHE2Iu
	 rRsJyMUYrxU0I5Fk6zzPu7OZwgSiRkoakCLSQZrOsHJ+31TEfJsWzALVfCNVFVZ8vH
	 h2xWd1mFiOBphVdaZ6JYI7TQvgqSI4SXYKnewxmTu3HujDkYxgrbbZn+kBP+fJIM4Y
	 e9IcLTcJlsKfnpDnpeVeuGdReTyNPiN3hwI21etg3FBmrdUgP69pW+6oO1crtqwD1S
	 7d+qCV9pMtuBQ==
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
Subject: [PATCH net-next 10/15] eth: fbnic: split fbnic_fill()
Date: Tue, 19 Aug 2025 19:56:59 -0700
Message-ID: <20250820025704.166248-11-kuba@kernel.org>
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
2.50.1


