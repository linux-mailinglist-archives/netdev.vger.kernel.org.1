Return-Path: <netdev+bounces-222262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E7B53C58
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281CD5A7374
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A230725E451;
	Thu, 11 Sep 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emibbQwN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7722D0612
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619328; cv=none; b=O2tmh2unCUNGQvZgENB0RiIZedGf5S8wVMlNY9nCRnnYwfcQpglynwFtEtUVvkE1/U4N5yBI1eGKUzHP+EEqJ3ai67ViSzHC59z55oWivR2sihFJ4D0PVs1komp/G3T1jOZAGaxUwX+XE5FYd2O++G5K6RX5Ys2j/MrCgrO4YJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619328; c=relaxed/simple;
	bh=G1NiFDz8oZhTB5nWROQ4ml+rvTNq7sXuFIg0das2/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPTi2B7BoboYIdGy9eiF/vnhrx+pA/wgetSfVrDT8Tec9WD7zZr0ehJkxkyyTAwOpmCsDKJ8rTlyx9r0fdUkoYwUUhsGHuvVKrKhWCxLpuUhjpkkmUH2KzOjXT3+RDEnM53YWqlVlX+TLJXBwg30nlxY/HQK6Mr0AfcA2LSePMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emibbQwN; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88432e1af6dso82975139f.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619326; x=1758224126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=ujYtpvwvZ4YS40Z1FTl6fIPkAWIUZKBFAHbS16l7rEwHIkZv/Gny8fMEpofWA46s9p
         Hu4tFmvkvyyAzU8jmN92cY/ZHqjulA0N+T0jS8PhDvH4XCYKOPdBqACjYv1fdMJ50SIf
         NZvYQMeu7QZAd1KIYt8MNbVE86puQv9Qoohnotjkg8SHAlMFwoxG7Myf5pfM3bxHNss2
         IrOkn+EHAwnzU6jALZiM9Ljgjsm1lMZyvSRz7Hc920YInMTpRRfWF2/X55lrVPy/MPbR
         k/+MTN4p97i88SgzHfUpAfuME4ZLF45jB3RW1m9L630wsntM/l4BtRMUtBYMTT6lBHwl
         omxA==
X-Gm-Message-State: AOJu0Yy3Byqf5NQcRIfVXfjHYhWvCWOTM6VNnm0jsyI1O1RT58TKF7hf
	lGP0jA9DcSjvqTOQxWOa+IUb7KYduA9wm5x6snQv5EsJviwNVuCb6TFrXJL1n1mQr2vmvdevkB+
	BGWjVp1/iWoTBfnJmsPSJZVA6PSbUnTTlsrh6lteRl4nIe+1zErV485R/dd3gd/7YAdxsuR/9Eq
	HrS1QMPY8+8TFzcbwsP0+GlWKckR0HOAEbLFcUaJvv3vCIkr0O4vUEn9dIbEGaX9eWK1rMZb3Dp
	hlGNy0NZk+/rj2/8c5B
X-Gm-Gg: ASbGncsm5AOwrCAAMXWLoQ3Soi+7QODoNhDLLSh/qrgq9i0A8j1liOu9YyZmPpSiYW4
	749C3XKeCel8Jma4Tl9Rjx2SWc21IZQgHoOyafXSKlPJDQLMu9H+DZnRjK9+p43E4Cab1muLvoG
	Mkj6R63cs7STSRh7NGi4oJHLGWahlKsoXTYINpnoPg4Damo5E/hTpKq87OsDDXQfCMvxrOV4z08
	sXwzr3pROGKhd6GsWmR8rNMttDC1HIC9Wuh7TKHDShFdf940AKJUfPdgdfIeep+DuQYXtREFNRM
	2kleQtGZs5lhOy7Zcv6P86gemQ/0iXBTVd9zNSOwqNDDMg06Bo5/X/K716zlMItu1r7xp+eg85J
	JFDIINs2nstiBYzTj2vLyy0ZD17pQyv76xj8X+XOqD1HDofGGeOQMYBjwte4IxFk9Ua6ZTVJbRO
	GdEXcoq+i9
X-Google-Smtp-Source: AGHT+IHWryrZOYEM2i3OGXaXojT5JYs3exHuPVsLnekgLut8P6nJhDsgFgikotJevMscLcqff6qWELWuDkqn
X-Received: by 2002:a05:6e02:1986:b0:410:f09a:28a6 with SMTP id e9e14a558f8ab-4209e64b594mr14778065ab.13.1757619326249;
        Thu, 11 Sep 2025 12:35:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-511f308ab0bsm180328173.44.2025.09.11.12.35.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-25d449089e8so1395265ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619324; x=1758224124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=emibbQwNR5ANtylk/Fg7nozSRC3LmbE+jNFooTV5nQ5qATD1j92iuaOAI3XZsgmfpH
         3N1lDOaAzYTQ/pKOSjvTE0DBnevyMp4BUbUhqxRuUfRTcqYmWdti8BL5gokx4t5yIVqY
         KYUmXAoAqFEGUjVWbaOit21gr0EaKKNawdCJA=
X-Received: by 2002:a17:902:ea0d:b0:24c:f15c:a692 with SMTP id d9443c01a7336-25d27c21b85mr5780675ad.42.1757619324073;
        Thu, 11 Sep 2025 12:35:24 -0700 (PDT)
X-Received: by 2002:a17:902:ea0d:b0:24c:f15c:a692 with SMTP id d9443c01a7336-25d27c21b85mr5780335ad.42.1757619323656;
        Thu, 11 Sep 2025 12:35:23 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:22 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v7, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
Date: Fri, 12 Sep 2025 01:04:56 +0530
Message-ID: <20250911193505.24068-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Ensure bnge_alloc_ring() frees any intermediate allocations
when it fails. This enables later patches to rely on this
self-unwinding behavior.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 52ada65943a..98b4e9f55bc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -95,7 +95,7 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 						     &rmem->dma_arr[i],
 						     GFP_KERNEL);
 		if (!rmem->pg_arr[i])
-			return -ENOMEM;
+			goto err_free_ring;
 
 		if (rmem->ctx_mem)
 			bnge_init_ctx_mem(rmem->ctx_mem, rmem->pg_arr[i],
@@ -116,10 +116,13 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 	if (rmem->vmem_size) {
 		*rmem->vmem = vzalloc(rmem->vmem_size);
 		if (!(*rmem->vmem))
-			return -ENOMEM;
+			goto err_free_ring;
 	}
-
 	return 0;
+
+err_free_ring:
+	bnge_free_ring(bd, rmem);
+	return -ENOMEM;
 }
 
 static int bnge_alloc_ctx_one_lvl(struct bnge_dev *bd,
-- 
2.47.3


