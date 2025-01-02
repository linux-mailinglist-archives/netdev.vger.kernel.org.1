Return-Path: <netdev+bounces-154845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B635A00128
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D067916314B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624801A8F61;
	Thu,  2 Jan 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jpFgAq9m"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868278F7D
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856721; cv=none; b=aHBbmbrTiANsB46XubtSksOowlPEfUtzGangyZC5Dlaidg+jC93IaNr1/jWQt93WnanaVO18D01gQ3wuAKLmwI0opVZD6E1I2ZN7S7zqoqEhBAhWBodvBoqqeE2fRayJCTmP2rD29wBjOjlnUNG6rNE4+Yi1x8hbRRnX4DNMhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856721; c=relaxed/simple;
	bh=NuqZEEZYpyP7CXsdCdrvAvNGYHjuVQ4ARqCZDeRC1V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxfKMgMWuDNWXzS5enI+4QTtRFJ845K0USqzCs1wxzix5LZ0leL8qsb+88Lp0ihytSpEhJgqr7akL2E9RWehXKcCokKJlEo1HERfCLurY70xcPXkPQF9Tv3CKkMtIz9ET3KkiiijO36F3lYs2lDWnGJ1+K1jhiptwfdByPNxFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=jpFgAq9m; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4422; q=dns/txt; s=iport;
  t=1735856719; x=1737066319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwJxi8Cye5/I6LCh20clnomwhtRsYxMDQYpTcQE5Aq4=;
  b=jpFgAq9m8MvQ8876bgIevDVdB98w4kMLd4IE5c6wHuXnPcGOLMSjtztr
   2LK4N2Fx7Zjkf5fCSu5F56H5PvzM4hsYKgH0rMlJAdNkqN4eT920qrOSL
   mN6W11Xz2aKgsxMX61OUNEVZ6kkos+ORJ3HgZpIUzyjNPJsr+I6AwRjFx
   o=;
X-CSE-ConnectionGUID: vmO5cYuZRpO+XsC0y/+FIA==
X-CSE-MsgGUID: uE32TtxDT3O0nxvLyH5j0Q==
X-IPAS-Result: =?us-ascii?q?A0ABAADxEHdnj5AQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBhBlDSIxyX4hynhsUgREDVg8BAQEPRAQBAYUHA?=
 =?us-ascii?q?opvAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBA?=
 =?us-ascii?q?QE5BUmGCIZbAgEDJwsBRhBRKysHEoMBgmUDsxaBeTOBAd4zgW2BSAGFaodfc?=
 =?us-ascii?q?IR3JxuBSUSCUIE+b4Qqhl0EiQidV0iBIQNZLAFVEw0KCwcFgTk6AyILCwwLF?=
 =?us-ascii?q?BwVAoEagQIUBhUEgQtFPYJIaUk3Ag0CNoIgJFiCK4RdhEeEVoJJVYJIghd8g?=
 =?us-ascii?q?RqCKkADCxgNSBEsNwYOGwY+bgebeTyDboEPE4IAMSQCkxUbkhWBNJ9PhCSBY?=
 =?us-ascii?q?59jGjOqUpgDeSKjVFCEZoFnOoFbMxoIGxWDIlIZD4hchVENCRawXCUyPAIHC?=
 =?us-ascii?q?wEBAwmQdmABAQ?=
IronPort-Data: A9a23:3hX0zasQfjQzNoR6dEcQzZExW+fnVLNeMUV32f8akzHdYApBsoF/q
 tZmKT3UOP+NZTekftAkbN639BsG68XQm9ZgHAI9rH89FXsSgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhJs/vb8ks01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw5ONQXGp/6
 M4iMBdOXguo3/Pxg5yaY7w57igjBJGD0II3s3Vky3TdSP0hW52GG/qM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZgt/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9JoTVFJoJxB/Cz
 o7A13nUWUsmKMyz9WGiqnS8mMvevX75ALtHQdVU8dYx3QXMnTZMYPEMbnO3qOe0j2ayUsxSL
 kgT9DZoq6UunGSmQsT4Vg+1vFaLuRkTX9cWGOo/gCmO16DdywWUHG4JSnhGctNOnMYwSSYny
 RyPks/lCCJHtKCTTzSW9t+8tTq4NC4UBXUPaS8NUU0O5NyLiIc+kh7CUP59H6OvyN74Azf9x
 3aNtidWulkIpccP06P++RXMhCih48CWCAU0/Q7QGGmi62uVebJJeaS27H+G5sddHryBaRqxp
 1Ncio/dwsEnWMTleDO2fM0BG7Sg5vCgOTLagEJyE5RJy9hL0yD4FWy3yG8iTHqFIvo5lSnVj
 Fg/UD69BaO/3lP3NMebgKroV6zGKJQM8/y+CZg4ifIVOfBMmPevpn0GWKJp9zmFfLIQua8+I
 4yHVs2nEGwXD69qpBLvGLxAjuJ1nXxllDyJLXwe8/hB+efPDJJyYepUWGZikshjt8toXS2Mq
 Y8GbJrQo/mheLChPnePmWLsEbz6BSNmXc+t8ZM/mh+rKQt9E2ZpEO7K3b4kYMRkma8T/tokD
 VnjMnK0PGHX3CWdQS3TMygLQOq2Df5X8ylhVQRyZgnA5pTWSdr0hEvpX8dsJeF/nAGipNYoJ
 8Q4lzKoW60eGmmeqm1HPfEQbuVKLXyWuO5HBAL9CBBXQnKqb1WhFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:LqhSD6893Sxdc8b/OeBuk+DfI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB11737JYVoqNU3I3OrwWpVoIkmskaKdn7NwAV7KZmCP0wGVxcNZnO7fKlbbdREWmNQw6U
 4ZSdkcNDU1ZmIK9PoTJ2KDYrAd/OU=
X-Talos-CUID: 9a23:ZSUTeGzH+DYH8OxUYOHqBgUKH+d4eUzA/k3IBAyIEk0xWfrWZ365rfY=
X-Talos-MUID: 9a23:asN1HwqAtHd9lvxEcowezyxPb51U/7SCNBsqyZMWpe2VFXFyYw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="407974212"
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jan 2025 22:25:12 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-07.cisco.com (Postfix) with ESMTP id 51BF3180001D2;
	Thu,  2 Jan 2025 22:25:12 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 28CD020F2006; Thu,  2 Jan 2025 14:25:12 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v4 3/6] enic: Use function pointers for buf alloc, free and RQ service
Date: Thu,  2 Jan 2025 14:24:24 -0800
Message-Id: <20250102222427.28370-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250102222427.28370-1-johndale@cisco.com>
References: <20250102222427.28370-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com

In order to support more than one packet receive processing scheme, use
pointers for allocate, free and RQ descrptor processing functions.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  5 +++++
 drivers/net/ethernet/cisco/enic/enic_main.c | 14 +++++++++-----
 drivers/net/ethernet/cisco/enic/enic_rq.c   |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 10b7e02ba4d0..51f80378d928 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -226,6 +226,11 @@ struct enic {
 	u32 rx_copybreak;
 	u8 rss_key[ENIC_RSS_LEN];
 	struct vnic_gen_stats gen_stats;
+	void (*rq_buf_service)(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			       struct vnic_rq_buf *buf, int skipped,
+			       void *opaque);
+	int (*rq_alloc_buf)(struct vnic_rq *rq);
+	void (*rq_free_buf)(struct vnic_rq *rq, struct vnic_rq_buf *buf);
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index f8d0011486d7..45ab6b670563 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1519,7 +1519,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[0].vrq, enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[0].vrq, enic->rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling
 	 * mode so we can try to fill the ring again.
@@ -1647,7 +1647,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[rq].vrq, enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[rq].vrq, enic->rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling mode
 	 * so we can try to fill the ring again.
@@ -1882,6 +1882,10 @@ static int enic_open(struct net_device *netdev)
 	unsigned int i;
 	int err, ret;
 
+	enic->rq_buf_service = enic_rq_indicate_buf;
+	enic->rq_alloc_buf = enic_rq_alloc_buf;
+	enic->rq_free_buf = enic_free_rq_buf;
+
 	err = enic_request_intr(enic);
 	if (err) {
 		netdev_err(netdev, "Unable to request irq.\n");
@@ -1900,7 +1904,7 @@ static int enic_open(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++) {
 		/* enable rq before updating rq desc */
 		vnic_rq_enable(&enic->rq[i].vrq);
-		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
+		vnic_rq_fill(&enic->rq[i].vrq, enic->rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
 		if (vnic_rq_desc_used(&enic->rq[i].vrq) == 0) {
 			netdev_err(netdev, "Unable to alloc receive buffers\n");
@@ -1939,7 +1943,7 @@ static int enic_open(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);
 		if (!ret)
-			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+			vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -1998,7 +2002,7 @@ static int enic_stop(struct net_device *netdev)
 	for (i = 0; i < enic->wq_count; i++)
 		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
 	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+		vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index 571af8f31470..ae2ab5af87e9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -114,7 +114,7 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 	struct enic *enic = vnic_dev_priv(vdev);
 
 	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc, completed_index,
-			VNIC_RQ_RETURN_DESC, enic_rq_indicate_buf, opaque);
+			VNIC_RQ_RETURN_DESC, enic->rq_buf_service, opaque);
 
 	return 0;
 }
-- 
2.35.2


