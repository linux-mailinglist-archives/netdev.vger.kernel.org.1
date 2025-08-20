Return-Path: <netdev+bounces-215117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F3B2D220
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81E41C228C8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419B2820CB;
	Wed, 20 Aug 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmVQp5F4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB327BF6C
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658636; cv=none; b=m1HQIk5OaMLtxMAd9GF4JD/8AJA80DEcNbM6A7BJSJCUwoBExTF+amppzWHd+cpQpUC1lDblR0OAI6W2wmtiJHq6oLfCTF1kEA09zOHacstTrycUECaFDPf75XABig2PE+wa02MuyUrB1OKVhdA3UbIYmdwgWwAgoMEyYMO9PsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658636; c=relaxed/simple;
	bh=jvYRnIZgYYv1forYV7jKvmmGbtYMY4mPzBPmLoUGj0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBXHeH8f32HcsGC9axbjqHVjgHvuqmtuOyF+4prx709QlDFxFHoIsMCCT6b/MFMqyyRE6RB2FX1gsZZC+j4RUE7N5zxwV1kgBQLPwjXT6vgvvTwsoDH9o6ASVJ4nXx3Q/ZHjI3nIH6iYU9U77yrjLsPTb0bf4hzAY/xRyaOSvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmVQp5F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE36C113D0;
	Wed, 20 Aug 2025 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658635;
	bh=jvYRnIZgYYv1forYV7jKvmmGbtYMY4mPzBPmLoUGj0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmVQp5F4yNrgrDTi6IdCop++SeYiuKI5BvOOWvEjzzN3cZ3JsWsHIqKxQAFpLZAOt
	 JKWH2K7XSnAwovezD0xBg4T0QQe9QRcrUHwKuLE39QHsXBc2E1+slDWZ6ZLFZo7jj8
	 p7Diu1S/PO//pB+L1sMRSBd8nYYKnj6WTPrR8yigbe8Gw2akFDBfM9FttXQvB1pot+
	 DzoVnq7i0x9xjN+A1vq9K6HXDs5AxeocJGpUBGoAFASb7wf4dLKCjYsiZ0ZuZSz6/s
	 gI84zaKfzdtpNxt/x/nMK4Sn9XlR+jD8nezi5+mKFC/6frk9c022QKINc38JYysTpx
	 yB6SYx5FjlH1A==
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
Subject: [PATCH net-next 07/15] eth: fbnic: split fbnic_disable()
Date: Tue, 19 Aug 2025 19:56:56 -0700
Message-ID: <20250820025704.166248-8-kuba@kernel.org>
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
2.50.1


