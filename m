Return-Path: <netdev+bounces-216575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C344B3498A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573F43B782C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA043093A8;
	Mon, 25 Aug 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QuiRHP+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D42FD1D4
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144805; cv=none; b=jYFyRH0AAYK0bB36/3h/AncCrdouWuZQqlgIzy8ed7mphAd8tpfgNX+mMfTJq0KdU7ARGligVAyOB6dV+MnOSU0/9VKzMFu2q3T+Z2G9ZkVa6AUhkKKV21jGKaSiMsM9mDKBJ2GcapxfYfHUyDKvVe2iy21gMndds+uV9M6YlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144805; c=relaxed/simple;
	bh=Fwxo5GCr6rA4g7TQ5qmq6UaeqHMq/5GGniTlT45a+gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDCH8XQB+aExIbeGXXkgfcdrSE6g8tSm10c86QcF0TCZVMDx4SMyjV2l5DiFrsSyg10euC/dm3EvIP7opTHw0OuTU9cplszXiMThwIyO/uNxevRuNTQC2X27jFGVDYHWN/isqmHEkgsFqzPl6DzBv/m/+oPQ6dFlCm2Fe8dqjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QuiRHP+m; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e96c77b8dc1so954490276.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144803; x=1756749603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGWCcy7oFuOLUVjJfvwJURbjuYnWdSkJ5zLcZBixPfo=;
        b=hlbBarukBCnhBhxxledWKJaSqDEtYjgFg5IQfp47n4Ajig6clBoMrmIYJhwRrd3WO3
         A7DiVG6xoTVSJ77kWDB1kUSxFCV/eBrmsEy88o6/HMHcq7bQqPRjcwO7ksVsm8dsOUQh
         lTcgetv14U8X7M3WixBwCp77SFYqZ2vT88ikwXcM/RzLM0Pi+G29DMr4UWoq0iwRqNc2
         Hc5V72lGOBSJn60zReLzkD/FOHLYImMlvpGrG53764xrhL8j5w+t+bv+G/nSUsOrs260
         FQVHh5LCZIN7DwI6n3529uO+uZjt/JV36LwF/3X0J8EXRGQ+eMMWgl0aw3xlrac0I8BY
         rotQ==
X-Gm-Message-State: AOJu0Yx7Dys/3dFZUyZnOTC6gfu8P4/5UBzNqYaE29hBZwzoUpRcqFo0
	fjfc1LpjFUBrLyYsNoKK6Cytdl2akofRnAbeuCrwgK7eXYCbczFl1Rq5V+k4VhQu4ZPgJS8gmqv
	7wp7YbrZA045/nnMZVc8mZn4UXCaZJ1mcxGp2jm5sjkBPsCmOVW9fZVsgC2P18j3nHmsc8aEYd/
	OeUpmD06kHMU1FSKX9JBQ4u2ADgisTCbSutQlof2m9LhXdR+wrf4xre3Zfu/1U/alOc0BB2+uV4
	Z/RE16GP1s=
X-Gm-Gg: ASbGncuC2M8gt1EBsGj17XW72JbWCA8Z9JWmmRTeBi4CFVMZqFXofGiyyMKLKovoGpn
	ZVXwMysTQcCW5eqMzoKMpe/9mHcF9ulLD4/AP/1YN3gO/KARwWgRojDGYpPYO89iDf9TfvkUnxC
	fLdbO3pkAFYi8nxAyqMr4COTd0JeqW9oFa9I5sRqW2vo1UgopJr3iQf28IbLxLFRjPDV+EBr+jv
	cHXtPpBYWKSh0jnoXCKMEv9/AunY5Xmw/3QxEa8KJ/AHMo3Ugc2F2yQaI/b80/ZnBdrWJGahLB+
	cK18TEI+LLFYsaQEh5CJuCzpiQmbQqsZrJojKdWQBfJVKjM3WdjdR47AXlPd7gseIOv1Mgoh42Y
	Ix97RoAgfDLTgtcRKExQwlNcq/EENYvT76h7s3bq5t6qudJ1MP+Hsi5xrLp7liOKIoZoVOJwvzf
	8Fvg==
X-Google-Smtp-Source: AGHT+IHRNUWpb+a9oiogGXLLMKjBhAPqLF1eJb1lSmnvp9Q97zNZD0la5Uq5dzCFHXini8rU7JGDkVKX+zN5
X-Received: by 2002:a05:6902:2d03:b0:e94:e1e4:581a with SMTP id 3f1490d57ef6-e951c2d049amr14421233276.51.1756144802781;
        Mon, 25 Aug 2025 11:00:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e952c273a35sm628114276.1.2025.08.25.11.00.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:00:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870614b86so1636883385a.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756144801; x=1756749601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGWCcy7oFuOLUVjJfvwJURbjuYnWdSkJ5zLcZBixPfo=;
        b=QuiRHP+mqmMUrzCnactbT65V36UfMhPeAZAPWKuxT16jdt/knVVcTTY8Fbb/MtuIX8
         m2xWQ7gnzGTOSBUY4BLD8FIJBdQWDmB1BnO7j8laCDkhboXctENj0NdYB6zvmAgjqV0B
         hc25f93jH1gynBW9DaMoshi+ijJwVpLDu7eoM=
X-Received: by 2002:a05:620a:d88:b0:7d5:ca37:79a0 with SMTP id af79cd13be357-7ea10fae57cmr1403041185a.18.1756144801133;
        Mon, 25 Aug 2025 11:00:01 -0700 (PDT)
X-Received: by 2002:a05:620a:d88:b0:7d5:ca37:79a0 with SMTP id af79cd13be357-7ea10fae57cmr1403037085a.18.1756144800425;
        Mon, 25 Aug 2025 11:00:00 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf36e7640sm527498585a.59.2025.08.25.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:00:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/3] bnxt_en: Fix memory corruption when FW resources change during ifdown
Date: Mon, 25 Aug 2025 10:59:25 -0700
Message-ID: <20250825175927.459987-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250825175927.459987-1-michael.chan@broadcom.com>
References: <20250825175927.459987-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

bnxt_set_dflt_rings() assumes that it is always called before any TC has
been created.  So it doesn't take bp->num_tc into account and assumes
that it is always 0 or 1.

In the FW resource or capability change scenario, the FW will return
flags in bnxt_hwrm_if_change() that will cause the driver to
reinitialize and call bnxt_cancel_reservations().  This will lead to
bnxt_init_dflt_ring_mode() calling bnxt_set_dflt_rings() and bp->num_tc
may be greater than 1.  This will cause bp->tx_ring[] to be sized too
small and cause memory corruption in bnxt_alloc_cp_rings().

Fix it by properly scaling the TX rings by bp->num_tc in the code
paths mentioned above.  Add 2 helper functions to determine
bp->tx_nr_rings and bp->tx_nr_rings_per_tc.

Fixes: ec5d31e3c15d ("bnxt_en: Handle firmware reset status during IF_UP.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 207a8bb36ae5..1f5c06f1296b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12851,6 +12851,17 @@ static int bnxt_set_xps_mapping(struct bnxt *bp)
 	return rc;
 }
 
+static int bnxt_tx_nr_rings(struct bnxt *bp)
+{
+	return bp->num_tc ? bp->tx_nr_rings_per_tc * bp->num_tc :
+			    bp->tx_nr_rings_per_tc;
+}
+
+static int bnxt_tx_nr_rings_per_tc(struct bnxt *bp)
+{
+	return bp->num_tc ? bp->tx_nr_rings / bp->num_tc : bp->tx_nr_rings;
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -16325,7 +16336,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->cp_nr_rings = min_t(int, bp->tx_nr_rings_per_tc, bp->rx_nr_rings);
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
-	bp->tx_nr_rings = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 }
 
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
@@ -16357,7 +16368,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_trim_dflt_sh_rings(bp);
 	else
 		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
-	bp->tx_nr_rings = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 
 	avail_msix = bnxt_get_max_func_irqs(bp) - bp->cp_nr_rings;
 	if (avail_msix >= BNXT_MIN_ROCE_CP_RINGS) {
@@ -16370,7 +16381,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
-	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
 	if (sh)
 		bnxt_trim_dflt_sh_rings(bp);
 
@@ -16379,7 +16390,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		rc = __bnxt_reserve_rings(bp);
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
-		bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16413,7 +16424,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	if (rc)
 		goto init_dflt_ring_err;
 
-	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
-- 
2.30.1


