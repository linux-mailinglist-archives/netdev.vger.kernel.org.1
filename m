Return-Path: <netdev+bounces-110952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8192F1B5
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2876B22D35
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DF1A0709;
	Thu, 11 Jul 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk3LSVJU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5E1A0705
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735642; cv=none; b=WY0BX6R0nKFeOPco87Z979kCIlf0gFK6a1lcRaJxk5FF+d0nBqTH8uUNqvYo0o7HbzZF/sQh5Z9bXErHT6fP+dAcQB0w/FssGOcssd7+AmN9T6d9kA88kSjlqVArn+vHZdqbmnlBFJHGKI7p3ZvLjsRuhdDP3kgWIY4Db/zDu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735642; c=relaxed/simple;
	bh=/AklftYlH6FhBGa2+/Pb9Rcw6KCYCSX5u56H2ND8n1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCDwLDitgQv60UVUifyW4u23Fi4zNajKcFfxFs20yENW6T1yhAbUTZwMV0X8wkFKaiH16KugS4lMR6eWqvMU+mkHiB7AZAr75FIPFvxSc2Dx0nJ4p7fSykxYosMdDBBnUrgCKKpiZnDw5seDl5QFE7lPt0R/qmPD7zOnv3eSYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk3LSVJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2B2C4AF14;
	Thu, 11 Jul 2024 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735641;
	bh=/AklftYlH6FhBGa2+/Pb9Rcw6KCYCSX5u56H2ND8n1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk3LSVJUJUdZO6zsjwaUiAdbbfHrYRxcGaXsALtqPJQcQvNME2SDgnrtPMMQGYjd6
	 fCFZFhRzBIAZbDYm+RHFISm2K++HUSy+faJ2lYXwLaXqlUS7nb037YuhzjFkrebEt6
	 9kyXrr8ciWsB1Xpv/8jwu3muYer+ShOM9V8SEUm7zkSOxqtjD1jtaKIk0gx5pSOs8e
	 LkDwbInRMFQbEx8rUrONBH4vSbCTf5y2OG4/KR7U3ZNSAL1tG77iMTppyNnuZUoubj
	 c4r3VIF0tXEvExDLwqQyVO9uQoNRC3JDcr0JPzz50Avkp+iYv0fD/PLstk9HyGuYqi
	 ygjGUjiiv3q3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/11] eth: bnxt: allow deleting RSS contexts when the device is down
Date: Thu, 11 Jul 2024 15:07:05 -0700
Message-ID: <20240711220713.283778-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
References: <20240711220713.283778-1-kuba@kernel.org>
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
index 80fce0aaad66..e8965cf743fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10210,10 +10210,12 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
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
index 4d53ec7adc61..846a19b5f58d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1874,6 +1874,7 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 	struct bnxt_rss_ctx *rss_ctx;
 	struct bnxt_vnic_info *vnic;
 	bool modify = false;
+	bool delete;
 	int bit_id;
 	int rc;
 
@@ -1882,7 +1883,8 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 		return -EOPNOTSUPP;
 	}
 
-	if (!netif_running(bp->dev)) {
+	delete = *rss_context != ETH_RXFH_CONTEXT_ALLOC && rxfh->rss_delete;
+	if (!netif_running(bp->dev) && !delete) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to set RSS contexts when interface is down");
 		return -EAGAIN;
 	}
@@ -1894,7 +1896,7 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
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


