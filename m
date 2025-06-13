Return-Path: <netdev+bounces-197668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF24AD9895
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6100E3B327D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29328ECF5;
	Fri, 13 Jun 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g6tmtOmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760828EA70
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856790; cv=none; b=TuP/+d4+DBTPv0IxZhaOVpDnFrVwJx5O4g7hB5GPUpW5FaRaUPCT6Je6lobRtMBrfFhPlQ8qgqZqPWRlzgeRu2oHBQ1dDM9MX4gQrttVN504GMdNGPp0yBq8bCRfQSTWCsxnZlXLzzQGfFHg0fyJWwMuAF3MVj0mLxDZtKsHYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856790; c=relaxed/simple;
	bh=f97uSdPuIUpH/JHA5+3InRCGD5Y3M66SpKbTRU4aNIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb4Q9DHMAdWaHTFPj/Tf9zOQDDnX27Qt09NqLXoMWGAjW+d7LqJjIc07jB65h87rRvvOLih4P+agscdKhfyKwnevLPofCqEdAKohW0Y5fyv4AtbUvhs+XdIirhFNTRHHYalPQepR6M2xqQ/TZWmxGgBGHIn63M/CRPE8iBFkzI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g6tmtOmB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23602481460so26127125ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749856788; x=1750461588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zawp7laAFSiGVcnf04IiwkuedZ7uaAlNM2L+G0Uod1I=;
        b=g6tmtOmBDZmuR74gyQ53ZLn40aB512mJZ9uqZQprkjY0uLpPJR6hCJIJUCZpu4OYXf
         kxok/lt5S4jiDNqVA2JvIP1JE/Laj9LpM4GwIQ6MHQlQGmovZArpmp/Y/Yw0zx50fwJw
         GscAS6nTKvSGGmHm9g/ccgJncNOdw5JcnSB2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856788; x=1750461588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zawp7laAFSiGVcnf04IiwkuedZ7uaAlNM2L+G0Uod1I=;
        b=kp1rV+qACEn7yYXzN4bFf2qGGzt/n+fOnV+k4Zw3igg482S3VtKIKPM9iofHZGUQmB
         qiJLT6OAyxXIK4zuPyg0cbwfs9K6e+gTvHFKhza/UqMdUad5FKvbnOUudtjrP+uEfyty
         KF9HMctVaJlto6t41XzjJJ3L7fV3+O+u6i0bs0hz98LjPrHB6rONYY9qxTQuKyvXs22u
         Abu+5SOnWWQaDf+JDv1YuNYe5s9Nm4vg3Q7unTmI1us72rwybxREnABnsUP5lKIi05SR
         Pw0J7oJhc+AQVEqJJfijAFbFbfngjcFPG3AInkrtOhw5SWWVMCPOzjrvUifvVob+ENd2
         hnaQ==
X-Gm-Message-State: AOJu0YwUac5eo7u5fAR5TSr5Qpi8BhWQpFVBdyFJ4BWSh3oDIM+AQzmn
	XhkHnF6aiw184pAQNLF9/s9UoaexAG0hTlCloHBaP6y9vdSDJu2FA9vpRCsZpuoZPA==
X-Gm-Gg: ASbGncstfAP2oT56ewLu0eHQOAdXIAo6YhqexXsb9pZSmUa9fOUnsUxTylPOFz2MngP
	dVAhrkvel5qhQHx/1mgb28vbMOSvY7qGo7tBU5SsnIvFJ7GkRb4+Im8RePL4TTRoC9+FeNPo4ti
	TtnlIIwlN+fxy8WNAYuKuVAWEKEe/Xfyx9AZP247Rpqtf9G6+Ejjt5C9lgYJctajGJtBeKlbrQi
	PCnii8cY4spMOCgr+xbEdRV2nzjpVZ0aZTTJ7R+P4E4K5GviLwdjHXMLhVHfD6YZiqWvhJGWNov
	EOmznO4T1Be17ST30qQIAcfy7BQu4VCOOUB5Q9psPb/dgOxPWPZx+ss4ftf8XE64Gs+vDyITzJE
	sSAKN7e3XIdHh+u8QyV42CPcnbueuQza06c8amA==
X-Google-Smtp-Source: AGHT+IGoHBiYVGC12QpDKU7MehRp9GPPcGFWxGMg+1dYExJDyLdkzeFZ28TmXQ28wTssdNHtgW1ZVA==
X-Received: by 2002:a17:902:da85:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-2366afc48f3mr15504215ad.6.1749856788592;
        Fri, 13 Jun 2025 16:19:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7832asm20165105ad.140.2025.06.13.16.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:19:47 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Simon Horman <horms@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net 2/3] bnxt_en: Add a helper function to configure MRU and RSS
Date: Fri, 13 Jun 2025 16:18:40 -0700
Message-ID: <20250613231841.377988-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250613231841.377988-1-michael.chan@broadcom.com>
References: <20250613231841.377988-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add a new helper function that will configure MRU and RSS table
of a VNIC. This will be useful when we configure both on a VNIC
when resetting an RX ring.  This function will be used again in
the next bug fix patch where we have to reconfigure VNICs for RSS
contexts.

Suggested-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v1: https://lore.kernel.org/netdev/20250519204130.3097027-3-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 37 ++++++++++++++++-------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869580b6f70d..dfd2366d4c8c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10780,6 +10780,26 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	bp->num_rss_ctx--;
 }
 
+static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				u16 mru)
+{
+	int rc;
+
+	if (mru) {
+		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
+		if (rc) {
+			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
+				   vnic->vnic_id, rc);
+			return rc;
+		}
+	}
+	vnic->mru = mru;
+	bnxt_hwrm_vnic_update(bp, vnic,
+			      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+
+	return 0;
+}
+
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 {
 	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
@@ -15927,6 +15947,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	struct bnxt_napi *bnapi;
 	int i, rc;
+	u16 mru;
 
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
@@ -15977,18 +15998,13 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
+	mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
-		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
-		if (rc) {
-			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
-				   vnic->vnic_id, rc);
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru);
+		if (rc)
 			return rc;
-		}
-		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
-		bnxt_hwrm_vnic_update(bp, vnic,
-				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
 	}
 
 	return 0;
@@ -16013,9 +16029,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
-		vnic->mru = 0;
-		bnxt_hwrm_vnic_update(bp, vnic,
-				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+
+		bnxt_set_vnic_mru_p5(bp, vnic, 0);
 	}
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
-- 
2.30.1


