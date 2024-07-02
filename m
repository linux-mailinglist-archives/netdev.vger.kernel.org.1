Return-Path: <netdev+bounces-108631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7149924C56
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D27282BED
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DE17DA2D;
	Tue,  2 Jul 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cniuQWPw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4017DA26
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964102; cv=none; b=mk8M437HHj/wCOd3quBmAsQoMOb9zLrUb7Ecnn/ipjkzwtvmSJ+LHB4UPbb0mf/E7yIhCm0rM3LHoTEZdDXpAkTSd7bu8Ns1SPyT9qWBLoi+i0wvKTvWg/Mo//6YvSeMFFaXX8glRrt5AQWg2kb+MjszNB2XZr5MBaYAPXQGtLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964102; c=relaxed/simple;
	bh=I9WLTcGDxloeo47YZ9Gpyq4KZ8IGKIFFj0eYQUdcm8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeueJpRo7GpASHDLObo82qRVLF3awOMW+uJFiTH4sP3NTBOKMQ8w3S9MZ0X5XECK89ff1iNg/EUoU4dWFvKVfpkKFZoTX10rLa7Fqp0XJIkk3kQMxwHRfT6jI0PJNhpX3cknZxH9d+2sdAKst3DO8JBkrw9aWRrKesD1oxklQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cniuQWPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6561C4AF0E;
	Tue,  2 Jul 2024 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964102;
	bh=I9WLTcGDxloeo47YZ9Gpyq4KZ8IGKIFFj0eYQUdcm8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cniuQWPwZK7Z/zRmkoq4j8URtRCm4oXzQqF9G2bbTUta7ODoUaKn0FQPypLdOnYbd
	 wjmkTkyS66bZRsdrpXU6lJUuznEIg831fSGD59ZUZkrrzKMDsAnEd4A9tYgKXAMoEp
	 7hwL7YVH+kr+KF5RrYY6N+AgASw+E6qcnaNmUDQX0ZDV2pxbiXo6PYff4GbC5AWIJr
	 2tZLR1pnKPsWfyisEO6TUexeygQuQJPpU9Y/MkBnGNslfttFikmV8m9ik5y2XnguiP
	 t2vI6QzROl8aWFcQmIiudTYh6ReEotwMCF9Q7jy+Nd056Chzry9OrrLhYzahZ1sVuI
	 zS9olHj7Y+z0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/11] eth: bnxt: allow deleting RSS contexts when the device is down
Date: Tue,  2 Jul 2024 16:47:49 -0700
Message-ID: <20240702234757.4188344-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702234757.4188344-1-kuba@kernel.org>
References: <20240702234757.4188344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Contexts get deleted from FW when the device is down, but they
are kept in SW and re-added back on open. bnxt_set_rxfh_context()
apparently does not want to deal with complexity of dealing with
both the device down and device up cases. This is perhaps acceptable
for creating new contexts, but not being able to delete contexts
makes core-driven cleanups messy. Specifically with the new RSS
API core will try to delete contexts automatically after bringing
the device down.

Support the delete-while-down case. Skip the FW logic and delete
just the driver state.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 10 ++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6fc34ccb86e3..ab6dae416532 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10195,10 +10195,12 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	struct bnxt_ntuple_filter *ntp_fltr;
 	int i;
 
-	bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
-	for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
-		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
-			bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
+	if (netif_running(bp->dev)) {
+		bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
+		for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
+			if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
+				bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
+		}
 	}
 	if (!all)
 		return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index bf157f6cc042..0a7524cba5c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1868,6 +1868,7 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 	struct bnxt_rss_ctx *rss_ctx;
 	struct bnxt_vnic_info *vnic;
 	bool modify = false;
+	bool delete;
 	int bit_id;
 	int rc;
 
@@ -1876,7 +1877,8 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 		return -EOPNOTSUPP;
 	}
 
-	if (!netif_running(bp->dev)) {
+	delete = *rss_context != ETH_RXFH_CONTEXT_ALLOC && rxfh->rss_delete;
+	if (!netif_running(bp->dev) && !delete) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to set RSS contexts when interface is down");
 		return -EAGAIN;
 	}
@@ -1888,7 +1890,7 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 					       *rss_context);
 			return -EINVAL;
 		}
-		if (*rss_context && rxfh->rss_delete) {
+		if (delete) {
 			bnxt_del_one_rss_ctx(bp, rss_ctx, true);
 			return 0;
 		}
-- 
2.45.2


