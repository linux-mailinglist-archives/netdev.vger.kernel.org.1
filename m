Return-Path: <netdev+bounces-144615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020009C7F04
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4960CB24DF6
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03552192D99;
	Wed, 13 Nov 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="MIxP48Y4"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3647191466;
	Wed, 13 Nov 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542222; cv=none; b=aAOD3fr9+AJ+vqVDi3125PM0mAA0UteL1zLY2TZTzMU278qUWZukToqm7HSqTbPJyIisEC10GbaXH76ly92C7mA18ujLQJX5bFumj12cwpuJ+Hv5ZFWbqFKPAPQJUqMgRL0WDNWumgC38WShR9lvHcmYa/cVjvt+eTLJ8c7Jmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542222; c=relaxed/simple;
	bh=51HgZ51PPJWb3IXVJ68mkV9bh9OMM4AxdY0gpO3hPNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sc1P9p7xeQH6KhtgLyhrQjrN97suC4ANwUQfIgTBaEKdeQGLT/bhRFjVIZ+5Ggk+t0rokF10RWIipD3E7GtOOUXm6edccb822rowjaRPXEJ8Wxe9Dl4OasfwaSK8YjPLy0cQ1DJQYzEhoV+GhJAjAdTYu+Rr4I7DepDjJmTkjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=MIxP48Y4; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4143; q=dns/txt; s=iport;
  t=1731542220; x=1732751820;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=lrKZ3TBoxKRQYQGUg6LTUTzsyeGOVtpLFpggJFh1SfY=;
  b=MIxP48Y4lMRj9sFInzWLXWzLZNZ5IF7Xl3VYRaUPkLEb+yNE+4bO8kew
   mUxct0xWlLmrVnw4rFHA8eWrPiLFQuLH3DbrQNNnOCIYoSXFwG5Tmxbd8
   pS+Yv9tT4nt/7gXxLrTfithL9e85JutmVg5t0lc+88uIkC/ANv6HovYR4
   A=;
X-CSE-ConnectionGUID: MRObatH8TkCeBNlz8sq56A==
X-CSE-MsgGUID: bOpgorpbQIGkShFEYSH01g==
X-IPAS-Result: =?us-ascii?q?A0ATAADHOzVnj5UQJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYQaQkiEVYgdhzCCIYt1kiOBJQNWDwEBAQ9EBAEBhQcCikUCJjQJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFDjuGC?=
 =?us-ascii?q?IZbAgEDIwRSECUCJgICKxsQBgESgwGCZQIBsGZ6fzOBAYR72TiBbYEaLgGIS?=
 =?us-ascii?q?wGBbIN9O4Q8JxuBSUSCUIE+b4gegmkEhmh2hUODeZkpCT+BBRwDWSERAVUTD?=
 =?us-ascii?q?QoLBwVjVzwDIm9qXHorgQ6BFzpDgTuBIi8bIQtcgTeBGhQGFQSBDkY/gkppS?=
 =?us-ascii?q?zoCDQI2giQkWYJPhRqEbYRmglQvHUADCxgNSBEsNQYOGwY9AW4HnmVGgysHg?=
 =?us-ascii?q?Q+CEyxjlliNPqFrhCShXDOEBJQBkkiYdyKkHIRmgWc6gVszGggbFYMiUhkPj?=
 =?us-ascii?q?i0NCZMWAbY/QzU7AgcLAQEDCZBJAQE?=
IronPort-Data: A9a23:LjhLrq0hJBPZIr8iDfbD5UZxkn2cJEfYwER7XKvMYLTBsI5bp2FSm
 GEfC2iCa/qJYjb0coh3aNm/oBgGvJKAztdmGVZr3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 7sen+WFYAX5gmctaTpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGKXsRN4QE2rZLAkpD3
 9ocOmAWd03drrfjqF67YrEEasULJc3vOsYb/3pn1zycVKxgSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEWojx5nYj/7DLo4keqzjX71ehVTqUmeouw85G27IAlZi+izaYGKJ4bSLSlTtky/v
 m3B5XzzOzA1N+ef5xe0yVL03+CayEsXX6pJSeXnraQ16LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JQFPc/8ymOx7DS7gLfAXILJhZCddYvnMw7Xzon0
 hmOhdyBLTVpvKeYVjGb+6uYoC2aPTUTKykJZUcsVQIP7t/iiJs+ghLGUpBoF6vdptn0Hyzgh
 jOHti4zg50NgsMRkaa251bKh3SrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZlCFu
 H5Bn42V6/oDSMjX0ieMW+4KWrqu4p5pLQEwn3ZKJb4r/iiNq0KgVo16xjVsdFxwb5gtLGqBj
 FDohStd45paPX2PZKBxYp6sB8lC8UQGPYq5PhwzRoQTCqWdZDO6EDdSiVl8Nl0BcXTAc4lja
 f93ku71UR727JiLKhLtGI/xNpdwmkgDKZv7H8yT8vhe+eP2iISpYbkEKkCSSesy8bmJpg7Ym
 /4GaJDTlk8FDr2uP3CNmWL2EbzsBSVlbXwRg5EGHtNv3iI/SQnN9teIm+p4IN0/90irvryYp
 yrjMqOn9LYPrSaacVrRMC8LhELHVpdkpnVzJj03IVutwDAiZ43phJrzhLNpFYTLANdLlKYuJ
 9FcIp3oKq0WFlzvpW9HBbGj99MKSfherV7VV8ZTSGRkJ8Y4L+EIk/e4FjbSGN4mVXrr65Bm+
 OL/h2s2g/MrHmxfMSofU9r3p3vZgJTXsLsas5fgSjWLRHjRzQ==
IronPort-HdrOrdr: A9a23:7BTTEKrOfIiymdsWgNNQRBwaV5rmeYIsimQD101hICG9vPbo8P
 xG+8566faUslcssR4b9exoVJPsfZqYz+8R3WBzB9mftXfdyQiVxehZhOOIqQEIWReOlNK1vp
 0OT0ERMqyVMXFKyev3/wW8Fc8t252k/LDAv5an815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 vk2iM+nUvHRZzSBf7LfEXsmIP41qb2qK4=
X-Talos-CUID: 9a23:2CHe7W47NHTS9atlL9ss0XQzEMk5Ui3hz1zdCWm8GzZyUeDLYArF
X-Talos-MUID: 9a23:0noMZAa/rvMYgOBTvRj0izZ4LM1RwoutM0AjvKQ9m5HdOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="386137520"
Received: from alln-l-core-12.cisco.com ([173.36.16.149])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:53 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-12.cisco.com (Postfix) with ESMTPS id 541571800022A;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id D07D4CC1290; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:35 +0000
Subject: [PATCH net-next v4 3/7] enic: Save resource counts we read from HW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-3-a34cf8570c67@cisco.com>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=4213;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=51HgZ51PPJWb3IXVJ68mkV9bh9OMM4AxdY0gpO3hPNs=;
 b=CUxuTb2UJUQSZbaKS5gIF+2TFF7hHLsl+0fviPx8D3m6Wsaf6pnQqY+mYy5kM3s7FoM9j4eMA
 iG97E8jSG0bBko6pDYeQz/0D5T5j+U9eXwSxogVE/5lSIBVPjGBPVTK
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-12.cisco.com

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
index ec83a273d1ca40ae89f3c193207cf26814f6b277..98d6e0b825525a92f12776259c1c9c9730cb8a1e 100644
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
index 72b51e9d8d1a26a2cd18df9c9d702e5b11993b70..1261251998330c8b8363c4dd2db1ccc25847476c 100644
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
2.35.6


