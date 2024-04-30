Return-Path: <netdev+bounces-92283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0AF8B672B
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17741C2235F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152E1870;
	Tue, 30 Apr 2024 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="QGUI53s3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F11FAA
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439262; cv=none; b=mIUJUghlFvUCG3A0hhzo9Vis7Xp0oPMOnKTdaW9dX4f7+XF5ZQPid1DEVm94TLgxoKTEoTysOmBFPkC0OKY7eH46yUv0NMXwz/KDqQSl40vd0d76TElmlcaOwPesjjT/BmKXZKXhPVv/6WuUtJ9qC4aH+43J1nlMLmw8oD8QDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439262; c=relaxed/simple;
	bh=ulnp01jdTxgIRCr18Tn2JZfsVZNTyq1zlColj8gCddE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4/wMin1+acucUi4yRyFEloEXHYextePvHk/fbTEA86zldNLCbJW91Qwj0WD9FPFXBBfHVKZJwoN+19soI8vdYE5ANrAW6B0Kgw2h26s1O3jnxaWN6pO2AgI71stM4nJiRruqg4l6TNPcDbNLrUJ3SwaNsb4nK4gJYIl0dSbOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=QGUI53s3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4998899b3a.2
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714439260; x=1715044060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3TV5L/JsIHMDJfGRMClntZErKHDDCQVMuxFiLMd8sM=;
        b=QGUI53s3iuDuZDuFAqzXoh7qO1JkNq0ksY/Wy2Y7FGSXYq60w1li537UCAxDFaZxD5
         FJ5XOM7pu6HIdT4n1hCJI+cXnY8s4agJ5OfvCD+tDHFfKLXHINvz0S9YFqox1KXSaFCl
         C3F6Bc+MyedpeXpMExL4yF4hltkCMoWv23G4bgplpI3syHuvhnvoG5L3T0UciSWn/83t
         BsrcgA17Ka3h/B44gdgAUWUADda1tw2uYPx9VMzV3+2Whwe5Kc2lGGyAcZGAv/ms/uKd
         h+eeNphQ1nIxDQ8+w2VvS0NGeL9IGRxhOeZcqiX8/F/0MMNJyeUcvuAzIR9UCZWPiVXg
         Oz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439260; x=1715044060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3TV5L/JsIHMDJfGRMClntZErKHDDCQVMuxFiLMd8sM=;
        b=mF0py57reEAib3igrQ40VNfnrjCgy52L5pndCUVMbtrrsrFOASGTppCVOjrmwWXOdM
         uVyJtwXpWNKnytqHCsGDT6BuOIvPmcepYPrLI/KUnJ/cI0ayVYSIKozPb04vxKDDGbwa
         whm2gB2vjawV8beYY5SqRzI22UD/GtqUpfAzh0rzhunoQJyxjafYfx2segi2oXy25Jfw
         5CyEP0jmd6C/tQpDyMfEWpjxNPoTYSN1YCXoumCDLF6Nlz3psWy6y2j8x6OC9/V/JP+I
         CF2Jb3oAJbs5nYBB3PeipodvF3tZr4FQkqcNp9f/tvq9xNWe5x7lVxtWLt1XrfpYjGoY
         8IQw==
X-Gm-Message-State: AOJu0Yw2B6Z5ntXUhz6MZ2c0L9d5OR499dhKpnPfrIZcBbjIs0/GxMro
	E5VdAry8Gw21gKndUWB3lcB8y40WDQu5CPDN3BQnS03Qh8eJ2pZSiQLk8kTcAXHeeE6HqNpx88Z
	m
X-Google-Smtp-Source: AGHT+IGV53ciGSViOUP6TXIPWOoxRe6UZqfsvpl/aSKVCuU5nD9vG7Kd71rZHqmJO9tNbVt4uC3Tig==
X-Received: by 2002:a05:6300:8082:b0:1ad:3d93:b71e with SMTP id ap2-20020a056300808200b001ad3d93b71emr8648287pzc.59.1714439259963;
        Mon, 29 Apr 2024 18:07:39 -0700 (PDT)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001e86e5dcb81sm20946346plb.283.2024.04.29.18.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:07:39 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v1 2/3] bnxt: implement queue api
Date: Mon, 29 Apr 2024 18:07:31 -0700
Message-ID: <20240430010732.666512-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430010732.666512-1-dw@davidwei.uk>
References: <20240430010732.666512-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the bare minimum queue API for bnxt. I'm essentially breaking
up the existing bnxt_rx_ring_reset() into two steps:

1. bnxt_queue_stop()
2. bnxt_queue_start()

The other two ndos are left as no-ops for now, so the queue mem is
allocated after the queue has been stopped. Doing this before stopping
the queue is a lot more work, so I'm looking for some feedback first.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 62 +++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 06b7a963bbbd..788c87271eb1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14810,6 +14810,67 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static void *bnxt_queue_mem_alloc(struct net_device *dev, int idx)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	return &bp->rx_ring[idx];
+}
+
+static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
+{
+}
+
+static int bnxt_queue_start(struct net_device *dev, int idx, void *qmem)
+{
+	struct bnxt_rx_ring_info *rxr = qmem;
+	struct bnxt *bp = netdev_priv(dev);
+
+	bnxt_alloc_one_rx_ring(bp, idx);
+
+	if (bp->flags & BNXT_FLAG_AGG_RINGS)
+		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
+
+	if (bp->flags & BNXT_FLAG_TPA)
+		bnxt_set_tpa(bp, true);
+
+	return 0;
+}
+
+static int bnxt_queue_stop(struct net_device *dev, int idx, void **out_qmem)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_cp_ring_info *cpr;
+	int rc;
+
+	rc = bnxt_hwrm_rx_ring_reset(bp, idx);
+	if (rc)
+		return rc;
+
+	bnxt_free_one_rx_ring_skbs(bp, idx);
+	rxr = &bp->rx_ring[idx];
+	rxr->rx_prod = 0;
+	rxr->rx_agg_prod = 0;
+	rxr->rx_sw_agg_prod = 0;
+	rxr->rx_next_cons = 0;
+
+	cpr = &rxr->bnapi->cp_ring;
+	cpr->sw_stats.rx.rx_resets++;
+
+	*out_qmem = rxr;
+
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
+	.ndo_queue_mem_alloc	= bnxt_queue_mem_alloc,
+	.ndo_queue_mem_free	= bnxt_queue_mem_free,
+	.ndo_queue_start	= bnxt_queue_start,
+	.ndo_queue_stop		= bnxt_queue_stop,
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -15275,6 +15336,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
-- 
2.43.0


