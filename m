Return-Path: <netdev+bounces-246039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4099CDD5BD
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E6230109BB
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 06:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CD6274641;
	Thu, 25 Dec 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lUS/55Ep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A7234984
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766643710; cv=none; b=pdqs4sorgsZT9IPBJ+X9TU8ruoZBatXWLi/r9EFQmDzOQ0rsf3XZRwtsB6lkgss4prBSRJnIN2+cE8ZV99cr1c7UyIh9ndzjVrX0ds9kbzOIyNoC9CP/Ae/rlPb9EpqJqmvL3VD/6GnRrFN7norrZBrHfhscPLgdwOYDkO+VnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766643710; c=relaxed/simple;
	bh=20KWL9YL31PPu0PJpIyTVKycYfQRADE1IeEq1ykjvnc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPUsBQzx6Xr2cBsymDEJzgaiaTnLas1aq5YGvFapG/lBQUCETRi7EO2HPei+98EbSvbOyVqMsLxF3a0PvOHV0NbWuNmA0IyO/sVYieiTsMCzMXcDiZlLvLs5HUSvhL2DIh2zqQ95guGcwCE+cvLSA+n6nxhNLDTMC2ovn7bcVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lUS/55Ep; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3BDB3F881
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 06:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1766643706;
	bh=EPJYonuix71oUm57s5z59HxPVVbLV4aoSyqepsIGEOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=lUS/55Ep2u8MkfimPl/6YpVC8aZjyMeEURqRPevBfJ1Xd6nIJ4VUFwC579PAGiLb9
	 GL8MehwPDh2vX32gH9qOYJTTTP7s8S7+uKn9UQxD6vHaHYw93phtnK7MI8lbkK56br
	 ZDoX8VJcE7cba8OrnAlOGXF3TOlTV75IZpTIRF3aYsZo6MYS8KDo14sSapVVXGz3yw
	 fdbY+fVuDIwkMt7NhMyRusH0N886rmqceAs12V+KjUH4UYSF72kMVEfNaDo874J9HM
	 1bnIudXhBv9or/bzhTwGerFyJuMDhafMForYeX0Jeu+eDB1hdUVeyIlcovGGhDN/UU
	 ZZZSOHnwi76Odj023ScnC7p71GjblCT4NnXvkWvGjUU2CDrPUWVS8i88QxZ/a6bbuD
	 9ImZc8R1gLvXbvTlohfJJGzXyYzT/Wry9Hr1KIyjxafc/QeGhx0MCHXLiDRGp9j2MY
	 0+NLLWcH8jdBydIhSb0Bhn4v35lq4Dza5wxz5kru5lmifwhmP5bjVYf4NRiWYchMta
	 S3a5W7l/RDRfV6KNpf1lDbIphTm1999J/5sdkNM+AwPG0RnwGZcsM+4q/m5xu7JsB4
	 FZxPlDjfwEpZ+PknuZNHcVP2NXTeJBDEBOep2dliMf5TltWEa3YmOrKuttrzBoKL+Z
	 GAsQR4cB0Ck+sbMnfyU9q2Ks=
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64cfbb4c464so4752478a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 22:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766643706; x=1767248506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EPJYonuix71oUm57s5z59HxPVVbLV4aoSyqepsIGEOI=;
        b=rd5svDN3amkflBUJlgj2bSdPpbbCSK187btL2Grc5t4TZFA0526v2xQjNCpVSXNoaN
         Yg6gPTxZjoGb5nfND69nTzhjX+HP6ykQCiRtXvnFAAseN8gadF5MJfu4A//ac8O5y1K5
         ZERCiudf6zaLXleCO6VMTXY252dyDoHcxNWO8Qq4p2vkTA6Qbw2VX2hZA1Rxu4kBI2eH
         R7eZsgbOm9wMeswgqy4ieR320CMXWvotmFnFGLY0XNXXC8HuVVRtXbRdC/0LZKwJzTdT
         TDC6leuCn/QzrO08mLW/UGof+dK/ugATRsa1ufq7+ZVIK9RtCemtfsx98bRxVWjqcfVr
         NGTw==
X-Forwarded-Encrypted: i=1; AJvYcCV708l0nusyDeXdVhuej6ArHUVLmh/roZvbt1U5p14Zgd1Pp5v5xufn1aiFUnpWRaeEYUrsYzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGXdZ4VQpPAYEnXgwwmEi338oi5mDyt0Zpz4DOSY4ZVTYJVfh
	VZdi3m02GlCCyLTVRuIQ3gGfUvRQheuE7Zv2ix1pMEY1sZombej3y13dvTqcl4qAFTXoiWi6b2Q
	AJMYLjSswTLCi0Dhy2R5SeAMBj1RNRMIa0u8p4zEGwEnLCj0cocSAmFyYe+8HUDmHJiCg3ulUXA
	==
X-Gm-Gg: AY/fxX58XTCiCmPZQL0ATLOdWDyLk1HiS0Heiqo2sAaD5nHOkAxj/ss+yykgXcp0gk4
	7kuCrZ/v3c548N9SZtKcAihEd6wZeQvPLRiJRZWYBGBc1ZiTn22BuqNCYWdEOy56Kz1KrYFjvJP
	rgyOQaUsL+ggqBzoMIvM4ukhVJGmD3cc5tb5R/0AsMBA0hp1fEZCaE5X6bVNd2zMwY5htQJsKnn
	zi2h9yjXOvaaNUz9C8qnLHCyNqsVgLr95FtY6ezt3+JUSqBig6TtLMQAcytEQfbO5qvlAT4meGL
	eNqz8yJjpOn5GNLZzWJfioF0rPBpAynJwQ9OfUBO3mCC8uOJ6hYeQywJmXA9XdMjvSqjfxrWIP4
	98OMSuF2IiK0sfjr2ZbP3c6kD
X-Received: by 2002:a17:907:2d0e:b0:b76:bcf5:a38a with SMTP id a640c23a62f3a-b8036a924ffmr2184480266b.0.1766643706188;
        Wed, 24 Dec 2025 22:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC0cEg1z21yzaWoEYG+U6OebSRyp1hetz+m9tmpGkKhV/J46dGAMWMW+VVsjRTQhXfq0zyGQ==
X-Received: by 2002:a17:907:2d0e:b0:b76:bcf5:a38a with SMTP id a640c23a62f3a-b8036a924ffmr2184477666b.0.1766643705750;
        Wed, 24 Dec 2025 22:21:45 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0ecb9sm1948058466b.56.2025.12.24.22.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 22:21:45 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ice: recap the VSI and QoS info after rebuild
Date: Thu, 25 Dec 2025 14:21:22 +0800
Message-ID: <20251225062122.736308-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225062122.736308-1-aaron.ma@canonical.com>
References: <20251225062122.736308-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix IRDMA hardware initialization timeout (-110) after resume by
separating VSI-dependent configuration from RDMA resource allocation,
ensuring VSI is rebuilt before IRDMA accesses it.

After resume from suspend, IRDMA hardware initialization fails:
  ice: IRDMA hardware initialization FAILED init_state=4 status=-110

Separate RDMA initialization into two phases:
1. ice_init_rdma() - Allocate resources only (no VSI/QoS access, no plug)
2. ice_rdma_finalize_setup() - Assign VSI/QoS info and plug device

This allows:
- ice_init_rdma() to stay in ice_resume() (mirrors ice_deinit_rdma()
  in ice_suspend()
- VSI assignment deferred until after ice_vsi_rebuild() completes
- QoS info updated after ice_dcb_rebuild() completes
- Device plugged only when control queues, VSI, and DCB are all ready

Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on ACPI S3 resume")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
V1 -> V2: no changes.
V2 -> V3:
- mirrors init_rdma in resume as Tony Nguyen suggested to fix
the memleak and move ice_plug_aux_dev/ice_unplug_aux_dev out of
init/deinit rdma.
- ensure the correct VSI/QoS info is loaded after rebuild.

 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c  | 41 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c |  7 +++-
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 147aaee192a79..6463c1fea7871 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -989,6 +989,7 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
 int ice_plug_aux_dev(struct ice_pf *pf);
 void ice_unplug_aux_dev(struct ice_pf *pf);
+void ice_rdma_finalize_setup(struct ice_pf *pf);
 int ice_init_rdma(struct ice_pf *pf);
 void ice_deinit_rdma(struct ice_pf *pf);
 bool ice_is_wol_supported(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 420d45c2558b6..b6079a6cb7736 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -360,6 +360,35 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	auxiliary_device_uninit(adev);
 }
 
+/**
+ * ice_rdma_finalize_setup - Complete RDMA setup after VSI is ready
+ * @pf: ptr to ice_pf
+ *
+ * Sets VSI-dependent information and plugs aux device.
+ * Must be called after ice_init_rdma(), ice_vsi_rebuild(), and
+ * ice_dcb_rebuild() complete.
+ */
+void ice_rdma_finalize_setup(struct ice_pf *pf)
+{
+	struct iidc_rdma_priv_dev_info *privd;
+
+	if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
+		return;
+
+	privd = pf->cdev_info->iidc_priv;
+	if (!privd || !pf->vsi[0] || !pf->vsi[0]->netdev)
+		return;
+
+	/* Assign VSI info now that VSI is valid */
+	privd->netdev = pf->vsi[0]->netdev;
+	privd->vport_id = pf->vsi[0]->vsi_num;
+
+	/* Update QoS info after DCB has been rebuilt */
+	ice_setup_dcb_qos_info(pf, &privd->qos_info);
+
+	ice_plug_aux_dev(pf);
+}
+
 /**
  * ice_init_rdma - initializes PF for RDMA use
  * @pf: ptr to ice_pf
@@ -398,23 +427,16 @@ int ice_init_rdma(struct ice_pf *pf)
 	}
 
 	cdev->iidc_priv = privd;
-	privd->netdev = pf->vsi[0]->netdev;
 
 	privd->hw_addr = (u8 __iomem *)pf->hw.hw_addr;
 	cdev->pdev = pf->pdev;
-	privd->vport_id = pf->vsi[0]->vsi_num;
 
 	pf->cdev_info->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
-	ice_setup_dcb_qos_info(pf, &privd->qos_info);
-	ret = ice_plug_aux_dev(pf);
-	if (ret)
-		goto err_plug_aux_dev;
+
 	return 0;
 
-err_plug_aux_dev:
-	pf->cdev_info->adev = NULL;
-	xa_erase(&ice_aux_id, pf->aux_idx);
 err_alloc_xa:
+	xa_erase(&ice_aux_id, pf->aux_idx);
 	kfree(privd);
 err_privd_alloc:
 	kfree(cdev);
@@ -432,7 +454,6 @@ void ice_deinit_rdma(struct ice_pf *pf)
 	if (!ice_is_rdma_ena(pf))
 		return;
 
-	ice_unplug_aux_dev(pf);
 	xa_erase(&ice_aux_id, pf->aux_idx);
 	kfree(pf->cdev_info->iidc_priv);
 	kfree(pf->cdev_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4bb68e7a00f5f..1851e9932cefe 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5135,6 +5135,9 @@ int ice_load(struct ice_pf *pf)
 	if (err)
 		goto err_init_rdma;
 
+	/* Finalize RDMA: VSI already created, assign info and plug device */
+	ice_rdma_finalize_setup(pf);
+
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5166,6 +5169,7 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
+	ice_unplug_aux_dev(pf);
 	ice_deinit_rdma(pf);
 	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
@@ -5594,6 +5598,7 @@ static int ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
+	ice_unplug_aux_dev(pf);
 	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
@@ -7803,7 +7808,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_health_clear(pf);
 
-	ice_plug_aux_dev(pf);
+	ice_rdma_finalize_setup(pf);
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
 
-- 
2.43.0


