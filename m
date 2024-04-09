Return-Path: <netdev+bounces-86297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEF89E53E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9946028368A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7A158D9C;
	Tue,  9 Apr 2024 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TR6ExWam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC84158D69
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699702; cv=none; b=chGqzqjSpiBPz5TV2Lu73wGjkBZHSPivEyykpVoYABQHf7hRkwOu1XMqI9f+eqwTqII1uLr7IXjlsGAkYIC5me0rI7tZFlRYXQQVaRjcok4AaNO34ZyZVQrCSQlD9Ob8EmbP26nLRbg4RN1bINk9g1UJ6Ax57NeBhlqn/jnsn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699702; c=relaxed/simple;
	bh=Ldqkp9BAoit63xZcF6K/kb5w1Db243gn16Mdatw06rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjJnivee/TpdZveCyf5Ph2ODg+3R75Z+oshT24qU2QhIwlVrZNj3h3Uk3lbUARFlxscCKo1QuvSsbOJdgW1BtZpS/E+uDlaLDRP8b5197HvN8ShwfPDXp+isNYP+O/dmpzigVxMm3KTbaa/l7S3mZScNNt+sPj/AfCknRPSx4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TR6ExWam; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so3843898a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712699700; x=1713304500; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLD8rPxiOSZFhJddRAP1lXW3R20XalF+CxnaaZmRqFg=;
        b=TR6ExWamdsgzpV7NIVJXfNqf259xV2bdyDYONchWYE+mbTWbnzlSQOr/7bHLwjwF5g
         ivjOC2P3rKWCWgXgpXMX66KHkjLBgCUfOdgl9BCvFt3Qv6eVNX2N9JaIqjY/hqPVvLk1
         Y8UYtvgerzzQPLGOUHi+vIjJ24PSMKN+eTz6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699700; x=1713304500;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLD8rPxiOSZFhJddRAP1lXW3R20XalF+CxnaaZmRqFg=;
        b=dW2kqV4XDftsD9p/WdlXKzPiNlm7xCMDjueBRysabkQ211frhI5Ar6qgw55mSvjGES
         KPbjPNsL0mmjMkoClGBhw2iLQV4/1X18vuUBzBYfNY+1rg+77DRYC5EDZyXs62LRXifs
         5mJZi8THEajrpq2TwmPRsyW4DwRP7S1isHJOA4SIUlzXHGzATueNJhVf1kGsqGOJcwH+
         TXb8VOwmcfWothwJUjaNMKTPQVHX0ipcutkIh3KLWLxYsQ0yXOvPGVU8RQxEx4nX+mq1
         kuC8NeodRiSjDRjDWz+SjNyPZqONiRsopVIFzqzV7pZz6dg8Xw410pGpTJTo8KRPCtiC
         rUPQ==
X-Gm-Message-State: AOJu0YzzopieiWmx/pIiJPBU/MRs+kqxkOzlkhT8+WD23XPYGQafg7tm
	Ri+GOclX0eLuAo+d87R1xb27LQ2E+xuEvG5nD3fWC5Uwk+tNi6gf+2nsETHEsA==
X-Google-Smtp-Source: AGHT+IH4EeplSWDvaF8sy5Cf/AU2N/iG4Jvvy4pPauBuFZdCiFlw1QNMRtn6rWgv7pyd6eNjq2gg+A==
X-Received: by 2002:a17:903:1c1:b0:1e2:88ec:d456 with SMTP id e1-20020a17090301c100b001e288ecd456mr1138710plh.68.1712699699135;
        Tue, 09 Apr 2024 14:54:59 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e3e081dea1sm6983687plb.0.2024.04.09.14.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:54:58 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 5/7] bnxt_en: Change MSIX/NQs allocation policy
Date: Tue,  9 Apr 2024 14:54:29 -0700
Message-Id: <20240409215431.41424-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240409215431.41424-1-michael.chan@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003ce1010615b0f93c"

--0000000000003ce1010615b0f93c
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

The existing scheme sets aside a number of MSIX/NQs for the RoCE
driver whether the RoCE driver is registered or not.  This scheme
is not flexible and limits the resources available for the L2 rings
if RoCE is never used.

Modify the scheme so that the RoCE MSIX/NQs can be used by the L2
driver if they are not used for RoCE.  The MSIX/NQs are now
represented by 3 fields.  bp->ulp_num_msix_want contains the
desired default value, edev->ulp_num_msix_vec contains the
available value (but not necessarily in use), and
ulp_tbl->msix_requested contains the actual value in use by RoCE.

The L2 driver can dip into edev->ulp_num_msix_vec if necessary.

We need to add rtnl_lock() back in bnxt_register_dev() and
bnxt_unregister_dev() to synchronize the MSIX usage between L2 and
RoCE.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 77 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  8 +-
 4 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8c24e83ba050..88cf8f47e071 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7549,6 +7549,20 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (!netif_is_rxfh_configured(bp->dev))
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
+	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
+		int resv_msix, resv_ctx, ulp_msix, ulp_ctxs;
+		struct bnxt_hw_resc *hw_resc;
+
+		hw_resc = &bp->hw_resc;
+		resv_msix = hw_resc->resv_irqs - bp->cp_nr_rings;
+		ulp_msix = bnxt_get_ulp_msix_num(bp);
+		ulp_msix = min_t(int, resv_msix, ulp_msix);
+		bnxt_set_ulp_msix_num(bp, ulp_msix);
+		resv_ctx = hw_resc->resv_stat_ctxs  - bp->cp_nr_rings;
+		ulp_ctxs = min(resv_ctx, bnxt_get_ulp_stat_ctxs(bp));
+		bnxt_set_ulp_stat_ctxs(bp, ulp_ctxs);
+	}
+
 	return rc;
 }
 
@@ -14982,6 +14996,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 {
 	int dflt_rings, max_rx_rings, max_tx_rings, rc;
+	int avail_msix;
 
 	if (!bnxt_can_reserve_rings(bp))
 		return 0;
@@ -15009,6 +15024,14 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc;
 
+	avail_msix = bnxt_get_max_func_irqs(bp) - bp->cp_nr_rings;
+	if (avail_msix >= BNXT_MIN_ROCE_CP_RINGS) {
+		int ulp_num_msix = min(avail_msix, bp->ulp_num_msix_want);
+
+		bnxt_set_ulp_msix_num(bp, ulp_num_msix);
+		bnxt_set_dflt_ulp_stat_ctxs(bp);
+	}
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -15358,6 +15381,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
+	bnxt_rdma_aux_device_init(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -15411,7 +15435,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		bnxt_init_multi_rss_ctx(bp);
 
-	bnxt_rdma_aux_device_init(bp);
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0640fcb57ef8..ad57ef051798 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2303,6 +2303,7 @@ struct bnxt {
 
 	struct bnxt_irq	*irq_tbl;
 	int			total_irqs;
+	int			ulp_num_msix_want;
 	u8			mac_addr[ETH_ALEN];
 
 #ifdef CONFIG_BNXT_DCB
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index ae2b367b1226..de2cb1d4cd98 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -48,6 +48,46 @@ static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 	}
 }
 
+int bnxt_get_ulp_msix_num(struct bnxt *bp)
+{
+	if (bp->edev)
+		return bp->edev->ulp_num_msix_vec;
+	return 0;
+}
+
+void bnxt_set_ulp_msix_num(struct bnxt *bp, int num)
+{
+	if (bp->edev)
+		bp->edev->ulp_num_msix_vec = num;
+}
+
+int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
+{
+	if (bp->edev)
+		return bp->edev->ulp_num_ctxs;
+	return 0;
+}
+
+void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ulp_ctx)
+{
+	if (bp->edev)
+		bp->edev->ulp_num_ctxs = num_ulp_ctx;
+}
+
+void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
+{
+	if (bp->edev) {
+		bp->edev->ulp_num_ctxs = BNXT_MIN_ROCE_STAT_CTXS;
+		/* Reserve one additional stat_ctx for PF0 (except
+		 * on 1-port NICs) as it also creates one stat_ctx
+		 * for PF1 in case of RoCE bonding.
+		 */
+		if (BNXT_PF(bp) && !bp->pf.port_id &&
+		    bp->port_count > 1)
+			bp->edev->ulp_num_ctxs++;
+	}
+}
+
 int bnxt_register_dev(struct bnxt_en_dev *edev,
 		      struct bnxt_ulp_ops *ulp_ops,
 		      void *handle)
@@ -56,11 +96,19 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	struct bnxt *bp = netdev_priv(dev);
 	unsigned int max_stat_ctxs;
 	struct bnxt_ulp *ulp;
+	int rc = 0;
 
+	rtnl_lock();
+	if (!bp->irq_tbl) {
+		rc = -ENODEV;
+		goto exit;
+	}
 	max_stat_ctxs = bnxt_get_max_func_stat_ctxs(bp);
 	if (max_stat_ctxs <= BNXT_MIN_ROCE_STAT_CTXS ||
-	    bp->cp_nr_rings == max_stat_ctxs)
-		return -ENOMEM;
+	    bp->cp_nr_rings == max_stat_ctxs) {
+		rc = -ENOMEM;
+		goto exit;
+	}
 
 	ulp = edev->ulp_tbl;
 	ulp->handle = handle;
@@ -69,9 +117,13 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_hwrm_vnic_cfg(bp, &bp->vnic_info[BNXT_VNIC_DEFAULT]);
 
+	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
+
 	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
-	return 0;
+exit:
+	rtnl_unlock();
+	return rc;
 }
 EXPORT_SYMBOL(bnxt_register_dev);
 
@@ -83,8 +135,10 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	int i = 0;
 
 	ulp = edev->ulp_tbl;
+	rtnl_lock();
 	if (ulp->msix_requested)
 		edev->flags &= ~BNXT_EN_FLAG_MSIX_REQUESTED;
+	edev->ulp_tbl->msix_requested = 0;
 
 	if (ulp->max_async_event_id)
 		bnxt_hwrm_func_drv_rgtr(bp, NULL, 0, true);
@@ -97,11 +151,12 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 		msleep(100);
 		i++;
 	}
+	rtnl_unlock();
 	return;
 }
 EXPORT_SYMBOL(bnxt_unregister_dev);
 
-int bnxt_get_ulp_msix_num(struct bnxt *bp)
+static int bnxt_set_dflt_ulp_msix(struct bnxt *bp)
 {
 	u32 roce_msix = BNXT_VF(bp) ?
 			BNXT_MAX_VF_ROCE_MSIX : BNXT_MAX_ROCE_MSIX;
@@ -110,18 +165,6 @@ int bnxt_get_ulp_msix_num(struct bnxt *bp)
 		min_t(u32, roce_msix, num_online_cpus()) : 0);
 }
 
-int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
-{
-	if (bnxt_ulp_registered(bp->edev)) {
-		struct bnxt_en_dev *edev = bp->edev;
-
-		if (edev->ulp_tbl->msix_requested)
-			return BNXT_MIN_ROCE_STAT_CTXS;
-	}
-
-	return 0;
-}
-
 int bnxt_send_msg(struct bnxt_en_dev *edev,
 			 struct bnxt_fw_msg *fw_msg)
 {
@@ -336,7 +379,6 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->pf_port_id = bp->pf.port_id;
 	edev->en_state = bp->state;
 	edev->bar0 = bp->bar0;
-	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 }
 
 void bnxt_rdma_aux_device_add(struct bnxt *bp)
@@ -409,6 +451,7 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 	aux_priv->edev = edev;
 	bp->edev = edev;
 	bnxt_set_edev_info(edev, bp);
+	bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
 
 	return;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index ae7266ddf167..04ce3328e66f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -85,17 +85,23 @@ struct bnxt_en_dev {
 							 * updated in resume.
 							 */
 	void __iomem                    *bar0;
+
+	u16				ulp_num_msix_vec;
+	u16				ulp_num_ctxs;
 };
 
 static inline bool bnxt_ulp_registered(struct bnxt_en_dev *edev)
 {
-	if (edev && edev->ulp_tbl)
+	if (edev && rcu_access_pointer(edev->ulp_tbl->ulp_ops))
 		return true;
 	return false;
 }
 
 int bnxt_get_ulp_msix_num(struct bnxt *bp);
+void bnxt_set_ulp_msix_num(struct bnxt *bp, int num);
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp);
+void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ctxs);
+void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp);
 void bnxt_ulp_stop(struct bnxt *bp);
 void bnxt_ulp_start(struct bnxt *bp, int err);
 void bnxt_ulp_sriov_cfg(struct bnxt *bp, int num_vfs);
-- 
2.30.1


--0000000000003ce1010615b0f93c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOOwFmV6C9NukEmLYmf+oT6Zh55lN0se
vXPA2ZxeOiEaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
OTIxNTUwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQC2yBrTnhO7IoqNs2RsKsXlXKOf29xkcRp4jvOKyZzXRf3rlX8R
dR99T/LTTjKRS3nmg24RMCJjshXobladeMg/zM6z1pRYBgkt/rs6FdoWa+yZ2Y7uNvrXsRRhgZdV
HbYnaaMMYh5cgnbXx47FVGncLPPDf0zcLnxtTy3XXHG+J3hwhGjWwvrC1620HKq7HLVe8A3r6x67
zyop/DF+asYO3vKM3vgukqIkCfOMOBPd8tLTunkoCZIodcpZVMQPzUQNLm9JPutpNksR2FwL5orG
T8BfmvUnZrIu1oJ51O3cmfFtz5XtlfeEFkum1GAfuc8iBigdcEPruq7Zkn9csj/K
--0000000000003ce1010615b0f93c--

