Return-Path: <netdev+bounces-143443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF419C2730
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1639D1C21521
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082081F26DC;
	Fri,  8 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="iBmrHDM9"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E81E47CB;
	Fri,  8 Nov 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102622; cv=none; b=ZzFBWAkj/jskDkm2ri4ldt4XrW3P0v5/cqfhhsDnCIwhpA0EY7vYzfF0DYV64d4xq+RZ8bVlIgIHcKbbENFpApeSkyM/+oVMP6BCdWnhUTAuPfs2uB2YEoyZFC/JsWJKfxUufkE9ecJN+Numkq8yjHoSNpfjvwGoRpMblD1Xj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102622; c=relaxed/simple;
	bh=iwLqBIaYDt+zF0jzy60eoatbh4XPWQr7YNCqVTD0bdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AdgjexRf+BW+Hg8TW97ziSYKtc6Afr8wy9yVaIo7EWJxXAql2fdu4vfP7MTQLjDGmWzF/WX2LDHVgH901Kv1d7Xpp36ZjWEZP4e0uQxdNahARbuKWOfd1wg3lIVhFxoGcUg5ef+XJRYhhIpedjAzqrzNcHaar8x8ieJ692W/V7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=iBmrHDM9; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4143; q=dns/txt; s=iport;
  t=1731102621; x=1732312221;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Dl7oapZht/FmgDjgm74J9jb0/gMpPf4+RKRAlR78OqA=;
  b=iBmrHDM9NVM8UTitKNXE7/72xsRsSgrk50y6uPYmF/C/sFUcxWBa3+lP
   q2ua2YC1zfoAA4wv6ZP/E74bJfrhuGsRjkbm9/XiLk32fxtD9QEDEPCca
   6DmL7OI7EpXjKnVnmj5EDH+TUminKTVVsi4dxU9IjHbag/tOZFmYKnfpt
   I=;
X-CSE-ConnectionGUID: 9Yu1TuSsQeGZohNrjEzaBA==
X-CSE-MsgGUID: C9RQHqr2SSuHHrrYmanyRw==
X-IPAS-Result: =?us-ascii?q?A0AUAAA5hi5nj4z/Ja1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYQaQkiEVYgdhzCCIYt1kiOBJQNWDwEBAQ9EBAEBhQcCijoCJjQJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIh?=
 =?us-ascii?q?lsCAQMjBFIQJQImAgIrGxAGARKDAYJlAgGwWnp/M4EBhHvZOIFtgRouAYhLA?=
 =?us-ascii?q?YFsg307hDwnG4FJRIJQgT5viB6CaQSGbHaJOphSCT+BBRwDWSERAVUTDQoLB?=
 =?us-ascii?q?wVjWD4DIm9pXHorgQ6BFzpDgTuBIi8bIQtcgTiBGhQGFQSBDkE/gkppSzcCD?=
 =?us-ascii?q?QI2giQkWYJPhR2Eb4RoghIdQAMLGA1IESw1Bg4bBj0BbgeeKUaDJgeBD4ITL?=
 =?us-ascii?q?GOWVI09oWuEJKFZM4QElAGSSJh3IqQbhGaBZzqBWzMaCBsVgyJSGQ+OLQ0Jk?=
 =?us-ascii?q?xYBtTpDNTsCBwsBAQMJkhkBAQ?=
IronPort-Data: A9a23:NP4Y8KDXqCkx3RVW/73jw5YqxClBgxIJ4kV8jS/XYbTApDMggjIAn
 WMeCGiBb/3cNzTxKognOY+yoE8CvJ+AzYA2OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQb9i2YoWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEksRzVX0rBpYh98lFBmFo7
 /41OjknR0XW7w626OrTpuhEnM8vKozveYgYoHwllWqfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY3BPjDS0Un1lM/Dp8zh+yvjHDXeDxDo1XTrq0yi4TW5FcujumyboOMK7RmQ+1+z3yhh
 nvcpV/CHzE6LsauzDOD40iz07qncSTTA99KS+biqZaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0W91KFvYS6wyXzKfQpQGDCQAsTSNLYfQludUwSDhs0
 UWG9/vgAzB1vaLWT3+B+rqKhTevPy5TJm9qTTcNRwYD4vH5rY0zhw6JRdFmeIaxj9voCXTzz
 iqMoSwWmboel4gI2r+98FSBhCijzrDPQxI56xv/QG2o9EV6aZSjaoju7kLUhcusN66DRVWH+
 XxBkM+E4aVWVteGlTeGR6MGG7TBC+u53CP00G9yRqU8zC+U9lGReoB2+jNTNk5DG5NREdP2W
 3P7tQRU7Z5VGXKla65rfo68Y/jGK4C+SLwJsdiKMrJzjohNSeORwM15iaetM4HRfKoEzfBX1
 XSzKJrE4ZMm5UJPl2XeqwA1iuFD+8zG7TmPLa0XNjz+uVZkWFabSK0eLHyFZf0j4aWPrW39q
 okEbpPSl08OCL2mP0E7FLL/y3hUdRDX4rir+6RqmhKre1cO9JwJUqWImOhwIeSJYYwPy72So
 xlRpXO0OHKk2CWYcl/VApySQLjuRp145WkqJjAhOE3g2n4oJ+6SAFQ3KfMKkU0c3LU7l5ZcF
 qBdE+3ZW6QnYmqcoVw1M8KixLGOgTz33mpiyQL5O2BnJ/aNhmXhprfZQ+cY3HJeVHPr7JBm8
 +PIO8GyacNrejmOxf3+MJqHp25dd1BE8A6udyMk+uVuRXg=
IronPort-HdrOrdr: A9a23:OxE5i6m4Ga/mgFKAEUJ/pfW4FVrpDfId3DAbv31ZSRFFG/Fw9v
 rCoB1/73SftN9/YgBEpTn+AtjlfZq+z/JICOsqTNWftWDd0QOVxYhZnOzf6jfrchefygb6uJ
 0PT4FkBMT0HRxmi6/BkWqFOsw9y9qK+r3Av4jj5mpqJDsKV51d
X-Talos-CUID: 9a23:rc3nZmE0q2lgnd5MqmI2xVNNJt0eaUTQ40XXI2miC0t7QZe8HAo=
X-Talos-MUID: 9a23:zAh7bQUNmWGaCl3q/BS9vghCLd0y2J+zKGAXi6QDss+VDzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="376976119"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 8445C180001EF;
	Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 0A6A7CC1290; Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:49 +0000
Subject: [PATCH net-next v3 3/7] enic: Save resource counts we read from HW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-3-3ba8123bcffc@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=4213;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=iwLqBIaYDt+zF0jzy60eoatbh4XPWQr7YNCqVTD0bdY=;
 b=AgPz3O7EytTb8uH92kySJ21e+kkNE0RqwJ6lnirKH9lDMrzeSU8L2Y75GHmphSldJa1u43/bw
 90Ehdc3/qCpCAF8D5FjsX6iFYkRT0NENN6Qf/ePFnRBHCAd+1m3IYrK
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

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


