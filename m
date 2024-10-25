Return-Path: <netdev+bounces-138916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263A9AF69D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36647B20F00
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF892225DA;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSdFUDXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765EBA3D;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819263; cv=none; b=qLm5qjEXXY4FQ1U5+jiWCN7C2UP4c+IHtCAJ7uX2bTotscMf1DkvOKifIVYOQitBm6LcjqS1/E2qDlKerqqBItihCkOgG1Fn5NeVDev1XxfezpaRSR6jWCpckP0/sGxyctp2/XrWBxOSM5nllYKorL6GtwONhBlDp8VJgqRvOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819263; c=relaxed/simple;
	bh=FGrImqPLytR/vSMPJclojbKkKDRGJI4i5F8XMfmPHoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5SPJyGqyw0uPxmY8KG8dIjHNtH/EMOctw1xcnoS8paGagZ8iOhvgxCVNYzXqJ1xickm/bsKgLyoFoXGaeVmJ+ZhUiDaZsHu3XWsUASaId6P8/CSV6XmEeYZRoZf30R6Sgk4gse2mCLHWVKsa143d17KePIR3WwtlkZ68GvU4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSdFUDXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B665C4CEE7;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729819263;
	bh=FGrImqPLytR/vSMPJclojbKkKDRGJI4i5F8XMfmPHoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gSdFUDXB6PipNFxbKQQLOEuOYO71ZH58FPcY3usd74xh0f05G4h0du4vw4UQl2o5l
	 5kz4POdn/W5yOOxJuucePlDWY25Bm35MOcubyALHQUHRwx7w6Jw9WuEpkia8v0BueY
	 tH9ODrFcef1eYfCSY+DImUTWAabMEd2i7AQ8HmZRxR8sJrOxVSFhRCVBt2W4d+PMOh
	 ZH5lT9l0ZFUWTt5EWyXFpsQEckZSniKjpRRIFXwPZlA49KsS9YOPMBDXts3qAaJdgi
	 o6i+k7IxIvq+1NJkE5tFFOYX/xSd5SxMSiTyrEKlBRbJUCoQjsOVKDcnR1hJEHse5Z
	 KHMvIl1/LMDrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E2D1038E;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
From: Nelson Escobar via B4 Relay <devnull+neescoba.cisco.com@kernel.org>
Date: Thu, 24 Oct 2024 18:19:45 -0700
Subject: [PATCH net-next v2 3/5] enic: Save resource counts we read from HW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-remove_vic_resource_limits-v2-3-039b8cae5fdd@cisco.com>
References: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
In-Reply-To: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729819262; l=4213;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=xLHC8wEqUFjN0bkMiGJDjRPC+kG1EB+4ffnh4Hz1IXk=;
 b=Q+8WYR68oHWq3/IeOPfaM03pP1NuQr62jm6ptrKdoBJJE9adzIhP1A0Rz792+bMhlIBPaa/e/
 lPSicyrSJCxDWkLmQ3XkHpPdzb21SM8GHAMNvAHB/yrwXRva13CZh9y
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Endpoint-Received: by B4 Relay for neescoba@cisco.com/20241023 with
 auth_id=255
X-Original-From: Nelson Escobar <neescoba@cisco.com>
Reply-To: neescoba@cisco.com

From: Nelson Escobar <neescoba@cisco.com>

Save the resources counts for wq,rq,cq, and interrupts in *_avail variables
so that we don't lose the information when adjusting the counts we are
actually using.

Report the wq_avail and rq_avail as the channel maximums in 'ethtool -l'
output.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic.h         |  4 ++++
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  4 ++--
 drivers/net/ethernet/cisco/enic/enic_res.c     | 19 ++++++++++++-------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index ac7236f76a51bf32e7060ee0482b41fe82b60b44..1f32413a8f7c690060fe385b50f7447943e72596 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -206,23 +206,27 @@ struct enic {
 
 	/* work queue cache line section */
 	____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
+	unsigned int wq_avail;
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
 	/* receive queue cache line section */
 	____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
+	unsigned int rq_avail;
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
 	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
 
 	/* interrupt resource cache line section */
 	____cacheline_aligned struct vnic_intr intr[ENIC_INTR_MAX];
+	unsigned int intr_avail;
 	unsigned int intr_count;
 	u32 __iomem *legacy_pba;		/* memory-mapped */
 
 	/* completion queue cache line section */
 	____cacheline_aligned struct vnic_cq cq[ENIC_CQ_MAX];
+	unsigned int cq_avail;
 	unsigned int cq_count;
 	struct enic_rfs_flw_tbl rfs_h;
 	u32 rx_copybreak;
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 909d6f7000e160cf2e15de4660c1034cad7d51ba..d607b4f0542ceaef09e9528a591ca27177986143 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -695,8 +695,8 @@ static void enic_get_channels(struct net_device *netdev,
 
 	switch (vnic_dev_get_intr_mode(enic->vdev)) {
 	case VNIC_DEV_INTR_MODE_MSIX:
-		channels->max_rx = ENIC_RQ_MAX;
-		channels->max_tx = ENIC_WQ_MAX;
+		channels->max_rx = min(enic->rq_avail, ENIC_RQ_MAX);
+		channels->max_tx = min(enic->wq_avail, ENIC_WQ_MAX);
 		channels->rx_count = enic->rq_count;
 		channels->tx_count = enic->wq_count;
 		break;
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 6910f83185c44797d769434fbe8af3105215b143..e26e43dbfa9c928f40433e0b731d0afb556a694c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -187,16 +187,21 @@ void enic_free_vnic_resources(struct enic *enic)
 
 void enic_get_res_counts(struct enic *enic)
 {
-	enic->wq_count = vnic_dev_get_res_count(enic->vdev, RES_TYPE_WQ);
-	enic->rq_count = vnic_dev_get_res_count(enic->vdev, RES_TYPE_RQ);
-	enic->cq_count = vnic_dev_get_res_count(enic->vdev, RES_TYPE_CQ);
-	enic->intr_count = vnic_dev_get_res_count(enic->vdev,
-		RES_TYPE_INTR_CTRL);
+	enic->wq_avail = vnic_dev_get_res_count(enic->vdev, RES_TYPE_WQ);
+	enic->rq_avail = vnic_dev_get_res_count(enic->vdev, RES_TYPE_RQ);
+	enic->cq_avail = vnic_dev_get_res_count(enic->vdev, RES_TYPE_CQ);
+	enic->intr_avail = vnic_dev_get_res_count(enic->vdev,
+						  RES_TYPE_INTR_CTRL);
+
+	enic->wq_count = enic->wq_avail;
+	enic->rq_count = enic->rq_avail;
+	enic->cq_count = enic->cq_avail;
+	enic->intr_count = enic->intr_avail;
 
 	dev_info(enic_get_dev(enic),
 		"vNIC resources avail: wq %d rq %d cq %d intr %d\n",
-		enic->wq_count, enic->rq_count,
-		enic->cq_count, enic->intr_count);
+		enic->wq_avail, enic->rq_avail,
+		enic->cq_avail, enic->intr_avail);
 }
 
 void enic_init_vnic_resources(struct enic *enic)

-- 
2.47.0



