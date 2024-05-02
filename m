Return-Path: <netdev+bounces-92892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554138B93F9
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFF71F21DB4
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC11F959;
	Thu,  2 May 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gG4R3hbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E51CAB3
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625660; cv=none; b=OFQOjMqq590kJybgb4+DoHQ+DeaHBYHO5Mcx3cLIejocY3Qxk+sfMbTM4L2dzNaUPbHjYfdaJbnTDUZLlVVsgrKMX/bQQk/xgebmbQGgf/BxvoG2GPxsNHhkPP31ZBObIqhCRUhSEbkCLNvI7oOI0YVwmNcCviIyhf60YDUMDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625660; c=relaxed/simple;
	bh=ulnp01jdTxgIRCr18Tn2JZfsVZNTyq1zlColj8gCddE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQJJQ5gWMCsnKoYVSdL9RcDvy4Uc63qnGnDC7hgg08DuLQX0LOKCI/sIPNygzSrGwruG0pc/wtdgOgEUYLZktI/+LVkOJHprlnXwsuMVw4VknNxqA1dOiO9Kp29IYlOfSZykvvPYDiA2HzDQfHfP8f1CsnQmjqwFuW3cPa5cuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gG4R3hbj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c6f6c5bc37so3741348b6e.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625658; x=1715230458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3TV5L/JsIHMDJfGRMClntZErKHDDCQVMuxFiLMd8sM=;
        b=gG4R3hbju0xCAHkyP3aYpxq/b7XtpJYg94GwI6PQnEeBRySVsli1BU6o/US8wVH4XB
         lB5Ee9ml3etj3xD9nruApCYsX24Av0P4J1W1fwmdsE3wdUhZHk2I0dcZvy/GbC5RLY5o
         XwrHJdCUTzyRiU0WddVyFGDC95pqBJlT93QtpsuzpNrRy0FvnP+KLJrB2ia8CJ8l/rGF
         74TErpg0RfWUA0l2/99QQW3g0j5C2NthwSydMVrt5s3yNfYsA+3e05Pa4qboMY2d3d4V
         K6FS36d/70sCoP9RhZGZ/mTYt2RXGhJk73eOS9WGB9Le1umAa2vVx9B2OqOke4o4QDGZ
         47dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625658; x=1715230458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3TV5L/JsIHMDJfGRMClntZErKHDDCQVMuxFiLMd8sM=;
        b=fuNOTrIhza/FR7uIN4E411kubLlIxfJxLnG3azwvRdDlqRYBGfpJQu+ifr41v8bE2L
         lRr5H2FiKaoJiBlhXP1nxs0p94Xf1N5yyHQgxTttkwuARagnlsyM2xLEAH6yvodZ1EPj
         pyTm1vRNWx9x4w7eNWqg5o46DLk6xtbJQoUDhGzlhm0fSD16xKfGkLX1gmjLeRzUoWgq
         rfhsmvb0QcrxTeFi9xBm3U8IvVhDl0tMDArQBPYf5J2BbeAF+Hbk/5Yu/kH/svJ/5TYt
         u49YWMB36Vuj4Okg/7SB8BhpKlp9swQB6yxAiaD6VGND2Q+VO2N9sjgPULVuU9drNbsK
         0kPw==
X-Gm-Message-State: AOJu0YyuyaBR/QIe5bZ/uklmxernna8x1LWmj+1Ajmdci8Gnp5FQdiwj
	lfFeW59w4ZBGoDprzVClyFW79HmBTvicjkpc8rjYZ4PsgwOQD0lz3Aew8pOIkEOXRmX+HEsF7Aq
	j
X-Google-Smtp-Source: AGHT+IEvCeEbgqLTRLowRumhGOsWHRrx57Trlg/djFD+IqTr68v83s/RuCuSKv9ehirZTergCFAOYg==
X-Received: by 2002:a05:6808:9a5:b0:3c8:47a3:3d06 with SMTP id e5-20020a05680809a500b003c847a33d06mr4907774oig.33.1714625658226;
        Wed, 01 May 2024 21:54:18 -0700 (PDT)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id f9-20020a056a001ac900b006f09d5807ebsm269541pfv.82.2024.05.01.21.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:17 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 2/9] bnxt: implement queue api
Date: Wed,  1 May 2024 21:54:03 -0700
Message-ID: <20240502045410.3524155-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502045410.3524155-1-dw@davidwei.uk>
References: <20240502045410.3524155-1-dw@davidwei.uk>
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


