Return-Path: <netdev+bounces-126690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4819723A4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B0B214A0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD0118A6BA;
	Mon,  9 Sep 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WLksWkfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBE18A6C2
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913676; cv=none; b=qp7AKxeqIeDWgJf/e57WrgiUz835Z9DSlGHkq59mQ9he4uhb3W+m51gzhxA6VXoz2jl8uwpKmU/r4HGXuBMXgJYZ+tW2z31cdzZ9621ndhMX0v47dggoe9Y9tyrFO9M0zMZkVB8ZPlLia5NVtJvQE12Vsyhq2h4/mzYK6Dn5nGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913676; c=relaxed/simple;
	bh=QJQh+h/Pqn6NlvbAgKbgMGBsbq0wJfw1xIwzHg7WAQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4QtO2Ekjao8ukbI03W+0WrV7s17OMqm39ecsnM5ammc0daE1I66gLSK4lNdcc2pYW7tJgIWIiiWhJ4jz5y41roO61DGWpNvRa1rZBYOOmCuW4mE8QFJ/rSVa4uvH+ybYq2mErjsZMd/qGG65wI+aXmeVWMaunjlQkjY6yfMvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WLksWkfa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3057542a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725913674; x=1726518474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uxF6Cg0CSkbEeMgc2zVaa3upbCVBR7QxQBGiN3DuhY=;
        b=WLksWkfa4kS57b1hMqxgDn1WCCKlWnckRjp9K3z5XwQUxZNcjgpaRbWDyHuSSTbOgc
         Uq6WxnTyjIA3dtCMZ1i/AkBbN3yFWNmAztKFQBdweIGFdJ3ZnkjYfXYrHN+VtwfHrI5U
         hI/wS9hFks0sMoqDAz1tJfCjjUkyhKsPdNigQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913674; x=1726518474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uxF6Cg0CSkbEeMgc2zVaa3upbCVBR7QxQBGiN3DuhY=;
        b=dmbFR5bjbws8sQE9/o1l6qM8Qm6EEwMwk5tkMkIQ61Y+grKV1JQzbpHHtHOy+8tbBa
         ZC6zRtymsFcIr/DawlzRMlgS9+nSuL5ei+vgy2e4rahcDptBIxXE64L+GYAlXyC4T457
         hA5AbJjuYVRXbxBbEsC3JVhSNEqnlmFvg4U3DLXoXVDUfSma/pDh2Qa2Z1mllfM7WZ0t
         XhWbr4rvCL4QZs/bQCBvSMS6Iq+YaJXziAxmuJKE/Hu2HcZdrWaLgQc4zL+IoRDrTxjZ
         cOjOll7rQFF1gbDbasvknuO7jokBNzu5jaaBY7rDDC+JbpLCOWm0SladMMMbVtSautXP
         8Rvg==
X-Gm-Message-State: AOJu0Yz5k68e7P5hm0eHg2edSM3EF4APWYVEF2Us4DdXwYCxaSqKoSUy
	DzNDjsAZyL3uGl52tUx4Dol41s1z/MYSsoZ1VPdQxrSw80vGx1v79qzsLpcVvg==
X-Google-Smtp-Source: AGHT+IGMUZiuNYM3EOufhM0F2JTPu1W9wIaU4ea9Cy9THFJNhG+VwiqwYvwDqMRClnitp3lvcNMjgw==
X-Received: by 2002:a05:6a20:2d14:b0:1c6:ba9c:5d7b with SMTP id adf61e73a8af0-1cf1d0f98b5mr11113235637.23.1725913674352;
        Mon, 09 Sep 2024 13:27:54 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8259bccbcsm4427640a12.79.2024.09.09.13.27.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 13:27:53 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	selvin.xavier@broadcom.com,
	pavan.chebbi@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 2/3] bnxt_en: Add MSIX check in bnxt_check_rings()
Date: Mon,  9 Sep 2024 13:27:36 -0700
Message-ID: <20240909202737.93852-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240909202737.93852-1-michael.chan@broadcom.com>
References: <20240909202737.93852-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_check_rings() is called to ensure that we have the hardware ring
resources before committing to reinitialize with the new number of
rings.  MSIX vectors are never checked at this point, because up
until recently we must first disable MSIX before we can allocate the
new set of MSIX vectors.

Now that we support dynamic MSIX allocation, check to make sure we
can dynamically allocate the new MSIX vectors as the last step in
bnxt_check_rings() if dynamic MSIX is supported.

For example, the IOMMU group may limit the number of MSIX vectors
for the device.  With this patch, the ring change will fail more
gracefully when there is not enough MSIX vectors.

It is also better to move bnxt_check_rings() to be called as the last
step when changing ethtool rings.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c9248ed9330c..6e422e24750a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13803,6 +13803,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 	int max_rx, max_tx, max_cp, tx_sets = 1, tx_cp;
 	struct bnxt_hw_rings hwr = {0};
 	int rx_rings = rx;
+	int rc;
 
 	if (tcs)
 		tx_sets = tcs;
@@ -13835,7 +13836,23 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 	}
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		hwr.cp_p5 = hwr.tx + rx;
-	return bnxt_hwrm_check_rings(bp, &hwr);
+	rc = bnxt_hwrm_check_rings(bp, &hwr);
+	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
+		if (!bnxt_ulp_registered(bp->edev)) {
+			hwr.cp += bnxt_get_ulp_msix_num(bp);
+			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
+		}
+		if (hwr.cp > bp->total_irqs) {
+			int total_msix = bnxt_change_msix(bp, hwr.cp);
+
+			if (total_msix < hwr.cp) {
+				netdev_warn(bp->dev, "Unable to allocate %d MSIX vectors, maximum available %d\n",
+					    hwr.cp, total_msix);
+				rc = -ENOSPC;
+			}
+		}
+	}
+	return rc;
 }
 
 static void bnxt_unmap_bars(struct bnxt *bp, struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7392a716f28d..4aecc40be6eb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -955,11 +955,6 @@ static int bnxt_set_channels(struct net_device *dev,
 		}
 		tx_xdp = req_rx_rings;
 	}
-	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
-	if (rc) {
-		netdev_warn(dev, "Unable to allocate the requested rings\n");
-		return rc;
-	}
 
 	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
 	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
@@ -968,6 +963,12 @@ static int bnxt_set_channels(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
+	if (rc) {
+		netdev_warn(dev, "Unable to allocate the requested rings\n");
+		return rc;
+	}
+
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
-- 
2.30.1


