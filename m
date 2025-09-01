Return-Path: <netdev+bounces-218919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CFB3F05C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789402C0DF1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1632773F3;
	Mon,  1 Sep 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWE8PePt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB202773E9
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761142; cv=none; b=ZUsvsy78Aot/ns/llq4gFdg2KzxpKm71ywEMbcF75sgWzIa8o94nC/rINu4hyEsp3QA/RTTnUS3c6NJyNO8vEDh6/9saime5s3AYZ48KtWxKxvKuJHcM/hmHYh2O7JuDSL06o75+7fwIJXZ5CSAtttssQTtUD1Qlp+Ma/SKPCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761142; c=relaxed/simple;
	bh=99MljO3wALEyR1+PuxKTzvSi/oPtgMqQvzBUaERC0Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNKfGIsaeLclSS7PcgxkT3Lo0APxgpE5vhmun/iFyg4JtLrK7EEYJHSTIqgQiq8pvDFoc2lz/i0Rrk3tgIyxvxrZmtNWBvdg/rWKy/nY93493wzS4FnSRs2IdR9eZ23lQCg0+6fCMYFFu7Q06I01utbg2t5Pn6wswQtSAIZpLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWE8PePt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58935C4CEF5;
	Mon,  1 Sep 2025 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761142;
	bh=99MljO3wALEyR1+PuxKTzvSi/oPtgMqQvzBUaERC0Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWE8PePtUfDssvXB7IJI+8IEK2Zh9yGfU8o+ZPjTli/8Bp8b0Ve2qPw2pxMYb/vPu
	 7OjqNDHKPWMfxgz6aKd3c/t4ZY6tN4bjx8M1X3/PBieDnA9uAXEs1Wug+Uh4HeQPEm
	 Tp2yTF3rpTagtdohSSLcn72fXsa/c49/rXSpbqdbQP380HXmJwvxlukPebvYISl43K
	 XPEtF8pcwXrQCvwdWYz1XNaJjKopQmDNvIS2r8mz2g+C4p6UGTUdwa5E+/festVoPU
	 j0DBdG+yHoz7rQ7atqlE2hlRy7opTTIZQwZt0GRKBwJij5QfBTs1yQI4BFdkK/jdl4
	 R4HMkpuMM/6JQ==
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
Subject: [PATCH net-next v3 06/14] eth: fbnic: split fbnic_disable()
Date: Mon,  1 Sep 2025 14:12:06 -0700
Message-ID: <20250901211214.1027927-7-kuba@kernel.org>
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

Factor out handling a single nv from fbnic_disable() to make
it reusable for queue ops. Use a __ prefix for the factored
out code. The real fbnic_nv_disable() which will include
fbnic_wrfl() will be added with the qops, to avoid unused
function warnings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 46 +++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index dc0735b20739..7d6bf35acfd4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2180,31 +2180,35 @@ void fbnic_napi_disable(struct fbnic_net *fbn)
 	}
 }
 
+static void __fbnic_nv_disable(struct fbnic_napi_vector *nv)
+{
+	int i, t;
+
+	/* Disable Tx queue triads */
+	for (t = 0; t < nv->txt_count; t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		fbnic_disable_twq0(&qt->sub0);
+		fbnic_disable_twq1(&qt->sub1);
+		fbnic_disable_tcq(&qt->cmpl);
+	}
+
+	/* Disable Rx queue triads */
+	for (i = 0; i < nv->rxt_count; i++, t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		fbnic_disable_bdq(&qt->sub0, &qt->sub1);
+		fbnic_disable_rcq(&qt->cmpl);
+	}
+}
+
 void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
-	int i, j, t;
+	int i;
 
-	for (i = 0; i < fbn->num_napi; i++) {
-		struct fbnic_napi_vector *nv = fbn->napi[i];
-
-		/* Disable Tx queue triads */
-		for (t = 0; t < nv->txt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			fbnic_disable_twq0(&qt->sub0);
-			fbnic_disable_twq1(&qt->sub1);
-			fbnic_disable_tcq(&qt->cmpl);
-		}
-
-		/* Disable Rx queue triads */
-		for (j = 0; j < nv->rxt_count; j++, t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			fbnic_disable_bdq(&qt->sub0, &qt->sub1);
-			fbnic_disable_rcq(&qt->cmpl);
-		}
-	}
+	for (i = 0; i < fbn->num_napi; i++)
+		__fbnic_nv_disable(fbn->napi[i]);
 
 	fbnic_wrfl(fbd);
 }
-- 
2.51.0


