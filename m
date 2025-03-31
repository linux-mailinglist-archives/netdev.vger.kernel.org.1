Return-Path: <netdev+bounces-178357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C32A76BD3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF16F167928
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9731E1A33;
	Mon, 31 Mar 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb0H50iU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76A1DE892
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437875; cv=none; b=Q2TH8TP49TYmtnFxf7nbo0AUZv1GFy5Epya2XjEh3x3yTDCEQHa5WxFKZS41rsXXY7puYEcZ2pIajiTkbh5eEb+kcLrgBEhNpb+XylguBFyYarIEZoRILIK8U+p+Ry3IctWMJUIKnCztYZkDPywfbQhvQV84oU0w6Nqs2AwFI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437875; c=relaxed/simple;
	bh=GLt2qxliARWsWadN44XE6Cw38AjZfFoCaVkAZ79+/cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bxdtLdhL18X6LmQjPHpnSDLS2RgFot0c/kFOPyabrBC0C8gpUtaOmWt9MIPWvh/EIZfXvU4ePoZqPsPdTKjbVs28U5K2VpNudej7p+OHytoKrnkO6iV2AMT41nLX0wpsLp2zZg4kWnP7VlNbgRRBcHrZJGWUJpqc2mwkmVD62Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb0H50iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A343AC4CEE3;
	Mon, 31 Mar 2025 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743437875;
	bh=GLt2qxliARWsWadN44XE6Cw38AjZfFoCaVkAZ79+/cI=;
	h=From:Date:Subject:To:Cc:From;
	b=cb0H50iU2Gu6dsH85BTD+036NEeKyWwrG8lw5jnA3dsFfdgL6vGLXJltqgkrDeSzA
	 aeDEh1Ct8X8cIt2oXr6/pWEIo8khx99q/+cCocoQVZbSHl8/1J5OAKimmOr/uU5Hz7
	 xXi3D3w03j3ziem/oWwdP0g0x2rwarRPa/f8VRM9pm6TrKhElm3fvNQFM334lAc00X
	 JIThzeKgMc8E0cyx3YYhuWY+wdYXbXV0CQNB9Cl375QfLJXAz1DMrXX5w08vVLW42E
	 kdG43wiRV52EdSQnjwmiUaHLdY/7gZDK4BnJ/JGr5ZAZj7cDWe0Wk20JKgOFTf1R+f
	 X9BWisPAEPaHg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 31 Mar 2025 18:17:31 +0200
Subject: [PATCH net] net: airoha: Fix ETS priomap validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>
X-B4-Tracking: v=1; b=H4sIABrA6mcC/x3MzQpAQBAA4FfRnE3tTyKvIofBYAq7zUpK3t3m+
 F2+BxKrcIK2eED5kiThyLBlAeNKx8IoUzY44yrjvUUSDSshnwkv2mSikzGqhJ0iNuPgZ+PqobI
 W8hCVZ7n/vevf9wP9Uww7bQAAAA==
X-Change-ID: 20250331-airoha-ets-validate-priomap-8cb3f027b511
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

ETS Qdisc schedules SP bands in a priority order assigning band-0 the
highest priority (band-0 > band-1 > .. > band-n) while EN7581 arranges
SP bands in a priority order assigning band-7 the highest priority
(band-7 > band-6, .. > band-n).
Fix priomap check in airoha_qdma_set_tx_ets_sched routine in order to
align ETS Qdisc and airoha_eth driver SP priority ordering.

Fixes: b56e4d660a96 ("net: airoha: Enforce ETS Qdisc priomap")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c0a642568ac115ea9df6fbaf7133627a4405a36c..5a1039c95241ad943ce6d42e8aa290f693653471 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2028,7 +2028,7 @@ static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
 	struct tc_ets_qopt_offload_replace_params *p = &opt->replace_params;
 	enum tx_sched_mode mode = TC_SCH_SP;
 	u16 w[AIROHA_NUM_QOS_QUEUES] = {};
-	int i, nstrict = 0, nwrr, qidx;
+	int i, nstrict = 0;
 
 	if (p->bands > AIROHA_NUM_QOS_QUEUES)
 		return -EINVAL;
@@ -2046,17 +2046,17 @@ static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
 	 * lowest priorities with respect to SP ones.
 	 * e.g: WRR0, WRR1, .., WRRm, SP0, SP1, .., SPn
 	 */
-	nwrr = p->bands - nstrict;
-	qidx = nstrict && nwrr ? nstrict : 0;
-	for (i = 1; i <= p->bands; i++) {
-		if (p->priomap[i % AIROHA_NUM_QOS_QUEUES] != qidx)
+	for (i = 0; i < nstrict; i++) {
+		if (p->priomap[p->bands - i - 1] != i)
 			return -EINVAL;
-
-		qidx = i == nwrr ? 0 : qidx + 1;
 	}
 
-	for (i = 0; i < nwrr; i++)
+	for (i = 0; i < p->bands - nstrict; i++) {
+		if (p->priomap[i] != nstrict + i)
+			return -EINVAL;
+
 		w[i] = p->weights[nstrict + i];
+	}
 
 	if (!nstrict)
 		mode = TC_SCH_WRR8;

---
base-commit: 4f1eaabb4b66a1f7473f584e14e15b2ac19dfaf3
change-id: 20250331-airoha-ets-validate-priomap-8cb3f027b511

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


