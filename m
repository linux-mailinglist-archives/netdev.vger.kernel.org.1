Return-Path: <netdev+bounces-218081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C29B3B068
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F51C84331
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C910221546;
	Fri, 29 Aug 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1t1aw1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB11C3F0C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430599; cv=none; b=VatT7MEaYY8Il93/KEcs765Qe9WH/JZt2OXXB85T9FZYvs+mY7p/UqDd2L4Ib7UGKc8rI34smjL5Nx7XSHw7ZibVp43r84Ao5WO6Yog+U3HRajtwozT2aqWoW6v6v3NZ7oPMoxdDZPskhpzqgxjCecQ/i/h1DjJ8ud8kOymzbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430599; c=relaxed/simple;
	bh=F2+9yFgrCOgv6XZfurnew0Mcm2Ti3r90QGF6C8el4hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGqgpunDzNQlgj8QZvxpjY0XRNbaA8PFOSuiJt4xtBD2ZUzfqpRovB1MTYc3E5ofyj7BE6RiBbgmcbjDLHPXvrG4boeYOXoXyxg9JMqa6miDvAAETjUoorAoMz31wHfSeOuY9BLkhfeTstHjvUZvlThqNT64zDysH9nWN+UzFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1t1aw1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8A0C4CEEB;
	Fri, 29 Aug 2025 01:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430598;
	bh=F2+9yFgrCOgv6XZfurnew0Mcm2Ti3r90QGF6C8el4hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1t1aw1wm0FXXUuoUeJ10CxgeE+YQ15H7IWgndT41OetrMp8z+XkH6f4ZTL7X67zx
	 jpxCcS405bvLJ/x5qfJKlB8kGDUnoM5DLcKJfKtrd46PySBgi1fA/J3bLEA6nEd/Fs
	 y4A+gZ+dE+qM2OeIIqJ/NB7bbcm6JMdeLN61z8P9gHGEv2Z5ZURLGkJ415qESuXLIT
	 fBhy9qpxFHnE5vL6c0mtYAgfAtx9nSajThsInf76UQx7qdhQpsL1JwqLKTXJtsTpuN
	 R4jPVkU8rDMdJqK7sENTPTOBklm0fsWCfIuRVGu6F7WYohvLZ6n8EuA7GPTrPKDmFJ
	 1peEjnzj5cCPw==
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
Subject: [PATCH net-next v2 09/14] eth: fbnic: split fbnic_fill()
Date: Thu, 28 Aug 2025 18:22:59 -0700
Message-ID: <20250829012304.4146195-10-kuba@kernel.org>
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


