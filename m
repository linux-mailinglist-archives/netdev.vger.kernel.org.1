Return-Path: <netdev+bounces-218080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E4B3B067
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21145583D5E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE221C174;
	Fri, 29 Aug 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYgXdtVz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84021A458
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430598; cv=none; b=PDb/TQpSsidA1tHr3tD68XvuAC09yZDDXofkfbTo5TrAHx4JLXbZGIMCY0FeKLTRGNzhd0wW85a0LY2ixXSJIE9AwV05IXBsa54GDCbPb2QkJnOu+pJjYvKlYoXiQYZwZwfHp9eaErfsRebur1IJjB4+eYAAK3/ie7ZApvYkv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430598; c=relaxed/simple;
	bh=BRRSzC3O/Tk7jbyS7dKuUxta1uIlMmQK8fsURtTT0w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqjbL7ZplG+CEbBcA7FugELYf8kteWbdixbm3pLfkdvSNvOnDHR5AYHRdHJyrafs2lJVZ2iSm5ui5vi4+64Syxv95GBK1lFI1YlDw0i/h0sT3yXltwFB60P2LjrPVaIVaW/g/tHKLIWoF/F1c2aZzCujmhoCvg4WdKNC8XZiBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYgXdtVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C57FC4CEFA;
	Fri, 29 Aug 2025 01:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430598;
	bh=BRRSzC3O/Tk7jbyS7dKuUxta1uIlMmQK8fsURtTT0w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYgXdtVzzJ1R3dpblXNl9JuziZeM0TleUtiWmpZJc05eMSQeodKsD5SdznmPJG5h9
	 Egt/uwf5HkamRVBnzQGj6qkf0pwTFGKjO3BuxGTpRmInkptb3ImfH1ZimCaFQV9N7Z
	 WB2oWeJWfLN35cvx1GvRdMXYhIOiUgGdaK+ddAQcQfzCjE7/JDPIH+gYkE30eGEJUe
	 omhTe6RR0G01BMqvY0dXZmgqEsBXrln3lFeEsizByIczEaihT5dPwcIZsi6sLTJ4YO
	 yGIUPHtpJ9k3iKOZFPaF83PDwLGtbzlYkhhtGFMC5J8RFmuEF2s9OglPtkcF/Ki3Ly
	 WCsmRX8OJeUyQ==
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
Subject: [PATCH net-next v2 08/14] eth: fbnic: split fbnic_enable()
Date: Thu, 28 Aug 2025 18:22:58 -0700
Message-ID: <20250829012304.4146195-9-kuba@kernel.org>
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


