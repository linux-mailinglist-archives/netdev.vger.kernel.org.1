Return-Path: <netdev+bounces-113801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86493FFDD
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DFC28404A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965018D4AB;
	Mon, 29 Jul 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="f+f0DaZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871918A94A
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286507; cv=none; b=Kcx2gvAznXYLJCCSLAm1hxgTq8b3J3hk3Uqv6zmsRQwNaMZHiUAhrzkJGKsHqoOQI6pIobc0fNBvU59ypwMLDUKB31hNi/+1RPXosa1L3MkC4wd7wcWfKnlAeDKZ+r++Qd+UYleqpWEgpMkndb2BBGRqw9SBN3UxsyfPiseK/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286507; c=relaxed/simple;
	bh=tXrNhEtYj51EG3loVWDEE8cFvUlVg8YXAdF5iRelxyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5YRGnTzI7QVMfyPtjEjtnWjJjGuBygpEqDC/gQEHc8vIe6cr46PQ/RrJsEEZHg5eXsAOTcta8EnuxT8ya8qQSw2rMNzkzhWWWcFGRUJpDYrYijWyWpoxbLCUnham6uduOlw6yw5eEP0vvo2KOdtVPcYU25Iy8NnojXRUx9evmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=f+f0DaZL; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260e5b2dfb5so2612518fac.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722286505; x=1722891305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXxjmz+occooGbVYmoKul8P4v5h5JtRlfw54Rb+UbI4=;
        b=f+f0DaZLvBQtciqUZ/+2hjn/zEIZGTyRVEP0UNxGDAP4LYgER6FDZxLhzfQjdJMoiV
         AR1xyrLeTE0ge3M49kSK9qAsaieAo8RubY0vRwmo11hPWAkMv3iO7wtVRqjyb3E/tFfP
         zEfo6AqDjjlWgRptxvvcWqeRtiwmkDExqTRCcXpEJbXaqPqy12VTWpqegwg0dZ2uRGZv
         rEeMJfbpNqD20wuTfSjTQ1SNGkf38vbkUa7/havKucYf/vYL0SnaS4spnU4TijwRV2VA
         54ZUiqn++TtYQTGhWc7diFfJae9JYtgKPrbq52l3fY8Bg9GhLXxkTZM/9CJXNW/gwR6U
         Sdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286505; x=1722891305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXxjmz+occooGbVYmoKul8P4v5h5JtRlfw54Rb+UbI4=;
        b=bmgms2baEHscXP8I+heX7+QQXvZAoUyLN6GSepD10YuCKAW4HW5RQizl7mKj6Qqi8M
         wrMe6Fu7jUP8E13ozLlNsBCSBjAnreGveRsbHHbXPvlWpKJwA34rLrJAE1DZQd4YGRrv
         wGI+pnLJGjGEZXirliqLpzlucFVXJq6FSuRH2fwmwvSpFCYvUUEqwXplqS10mCqqj9wb
         T9dRz9bJhIRAYVeG2hSYThUaE7MDbNJH94rgXI/XRgfSOATfH6uycGVH1iXhQGiLPF8j
         83DLJkSIt4fZMAjeRl7gnbU3tdK2dCmFO6BPUzOgCNT5aQ08haw1yKrJD03fEsUGAoIt
         DBow==
X-Gm-Message-State: AOJu0YzM6qof4+Ma9MboydaGNzdGNBTWUlhAqPNecsTpgn1NFpkkK1SS
	7kFMZyeSXK5DxzzAabVw6n3SVrvDp/DJWyy0VNx5PzJbbIdDCceQHZjUb91Bj9+DiDGwfPa4irr
	mbXg=
X-Google-Smtp-Source: AGHT+IHmiF+baM2te4vgaKMH2HPtSvdCbgt2zvH/b/usl4GPnXrQJ6ghbKWFk/fuQVLjFj32nZAZ/w==
X-Received: by 2002:a05:6870:1685:b0:260:ffaf:811a with SMTP id 586e51a60fabf-267d4d018cbmr11200952fac.8.1722286505004;
        Mon, 29 Jul 2024 13:55:05 -0700 (PDT)
Received: from localhost (fwdproxy-prn-030.fbsv.net. [2a03:2880:ff:1e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f884afa2sm7682659a12.44.2024.07.29.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:55:04 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v1 3/3] bnxt_en: only set dev->queue_mgmt_ops if BNXT_SUPPORTS_NTUPLE_VNIC
Date: Mon, 29 Jul 2024 13:54:59 -0700
Message-ID: <20240729205459.2583533-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729205459.2583533-1-dw@davidwei.uk>
References: <20240729205459.2583533-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
packets. It can only be called if BNXT_SUPPORTS_NTUPLE_VNIC(), so key
support for it by only setting queue_mgmt_ops if this is true.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ce60c9322fe6..2801ae94d87b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15713,7 +15713,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
-	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
@@ -15892,8 +15891,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
-	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
+	}
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.43.0


