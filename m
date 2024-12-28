Return-Path: <netdev+bounces-154400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA29FD85E
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E742218857E1
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9F635;
	Sat, 28 Dec 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZuOugYD/"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDF6FB9
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344663; cv=none; b=LPs1Se6RU+6wPWf37hLtmKTrvu0R1S2T1TlJzBEjBqMx3UVZ6OmVGprzQMP/TWjX7XHmVcogVg8eH+J7HT/K3uVvQFGsErrDKBj5MHAiCPAG5eKI6+qkI9zY1V0QEn2aqnYF4UZsYjxeVDCvY1cav9Fn8iNgk+VNf7OF/BF3IyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344663; c=relaxed/simple;
	bh=NuqZEEZYpyP7CXsdCdrvAvNGYHjuVQ4ARqCZDeRC1V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fT4F1C9Y/VfR95k1FoREK8yknmLD/jOPToPhmtsunKRTDctza4xjQCPsH7Q6aPkoy9M7+32R8RsauXhMloj8kHCgYvCRuw9OspBb3oCq23mNH2vP6Xr/JCJGFjvzMZiF6DvaA+CS1mTjwmQaBiDtSb1R7dloHfGt9nMoPHC7N4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ZuOugYD/; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4422; q=dns/txt; s=iport;
  t=1735344662; x=1736554262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwJxi8Cye5/I6LCh20clnomwhtRsYxMDQYpTcQE5Aq4=;
  b=ZuOugYD/5HkB8JzY4zx0iPVGslXqRE8Ke+r5f/CYAvVGN85p5frql5M0
   qkteX4NKvYZ+wK0X6xRmZlnnMnzp6mWuQWHTuyuhjXgL+mvyBvDDVFZk6
   h9wvQ9z2qPeoXE+93bdTnNK/AOuh8S08NowytUqoSiUGfMXZlxUuHZcfH
   o=;
X-CSE-ConnectionGUID: 2n+Mj1FiSQKs2MoUs+QySQ==
X-CSE-MsgGUID: imZCIIoKRMCQRvzLQ4Np8w==
X-IPAS-Result: =?us-ascii?q?A0AeAAC9QW9nj4//Ja1aHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?QUBAQsBhBlDSI1RiHKeGxSBEQNWDwEBAQ9EBAEBhQcCim4CJjYHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhlsCAQMnC?=
 =?us-ascii?q?wFGEFErKwcSgwGCZQOxPIF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT5vh?=
 =?us-ascii?q?CqGXQSJFZ5ySIEhA1ksAVUTDQoLBwWBOToDIgwLDAsUHBUCgR6BAhQGFQSBC?=
 =?us-ascii?q?0U9gkppSTcCDQI2giAkWIJNhReEXoRWgklVgnuCF3yBGoIlQAMLGA1IESw3B?=
 =?us-ascii?q?g4bBj5uB5xfRoNzgQ8TggAxJAKTFRuSFYE0n0+EJIFjn2MaM6pSmAN5IqNUU?=
 =?us-ascii?q?IRmgW4GLYFbMxoIGxWDIlIZD4hchVENCRa1DCUyPAIHCwEBAwmQU2ABAQ?=
IronPort-Data: A9a23:hq+G+aCKd8BmGRVW/87jw5YqxClBgxIJ4kV8jS/XYbTApD8j02cPy
 2ZOWD/VOfeLYzT0etkkPd6yoRgO65DRyIQ1OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQX/hGYoWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEmfMtKUNvE4wjw8VsW0RJy
 OdbESE2V0XW7w626OrTpuhEnM8vKozveYgYoHwllW+fBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY0BPjDS0Un1lM/CpU+muuhgnTXeDxDo1XTrq0yi4TW5FApjOmzaoKLJrRmQ+1Um3Szh
 0PB3F7cKSggKs678Gaj6iKz07qncSTTA99KS+biqZaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDjoxbMgimnod7CSQtdChjrsnyNtAU6QYz8SY2T0HvAt9NHEZ3ad0i6h
 S1R8ySB19wmAZaInS2LZewCGrC1+vqIWAEwZ3YxRPHNEBzzpxaekZBs3d1oGKt+3i85ld7Vj
 K375Fk5CHx7ZSfCgUpLj2SZV55CIU/IToiNaxwsRoASCqWdjSfelM2UWWae3nr2jG8nmrwlN
 JGQfK6EVClBVP48k2rnHLZAidfHIxzSI0uNHPgXKDz6gdKjiIK9E+xt3KamN7pgtfjV+m05D
 f4CaJfVl32zr9ESkgGMrNZMdgpVRZTKLZv3sMdQPvWSORZrHXppCvnah9scl39NwcxoehPz1
 ijlACdwkQOn7VWecFXiQi44MtvHA80gxU/XyARwZj5ELVB/Ot73tM/ytvIfIdEayQCU5ackF
 adYIpvZW6snp/au0211UKQRZbdKLHyD7T9i9QL5PVDTo7YIq9T1x+LZ
IronPort-HdrOrdr: A9a23:ndw7u668V48GJRXQQQPXwM/XdLJyesId70hD6qm+c3Nom6uj5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcK2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPN
 9bAstD4BmaNykCsS48izPIdeod/A==
X-Talos-CUID: 9a23:Y+uf/GA9b92LHhX6E3Nht2sWQ+4kSUT+1y31JHKjSl94c4TAHA==
X-Talos-MUID: 9a23:01T43QZsRNk1+eBTtjrerxBDM+RSxo+XMl4ftaxandHUKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,269,1728950400"; 
   d="scan'208";a="404962064"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Dec 2024 00:10:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTP id A080418000254;
	Sat, 28 Dec 2024 00:10:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 82A5A20F2006; Fri, 27 Dec 2024 16:10:57 -0800 (PST)
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
Subject: [PATCH net-next v3 3/6] enic: Use function pointers for buf alloc, free and RQ service
Date: Fri, 27 Dec 2024 16:10:52 -0800
Message-Id: <20241228001055.12707-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241228001055.12707-1-johndale@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

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


