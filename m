Return-Path: <netdev+bounces-152684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9A9F5624
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C91D170FFC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F31F8EE4;
	Tue, 17 Dec 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PZHf7nzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E361F8AFE
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460029; cv=none; b=XkPLtEsElaIHBe/Oj6UcLo/9aP78M0Qeq8xrc43Kdotuokoo/xrKK05QA9Sxe2KkqWCvIF08nrJusXidnA2B0kqtrajAru65uooSISjaSiHAER+pc9HWL9NjuIPfvajyGY4DvZ7KDLf10yan+O5ZaCXq+JZZb2dNhTi6OtMPHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460029; c=relaxed/simple;
	bh=zpTK0PNQOhNC5kD2LgIhbrQ1a3eBbCrVDI9javzEoDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPDvaLp1G48B52ofwWFzgsnERdF5GTRBf1VC6e0veA2jmBgs+ieJdaDTo43iXJwd6E85GBLaAH96lTC2p40oL8BdrSTvH1VrKE2YR9vsXc+AF5j6bvOJgLM9iipTtrlHNisAtpdr+i0vwyOZz6OQJVN/HvdpdnCUIqZBN0h2EKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PZHf7nzI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216634dd574so32906195ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460027; x=1735064827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/U74kSzGU82WaF3YwiwK5Dsre8yynJCW2nmO8At+rU=;
        b=PZHf7nzIFyxkD+2bwc0vC2OB8powjSYDfOYb+9oT4exnzFfFok3ZiyTueeZoUoN2am
         n8iqDDtkgK1dKmj2ASFEbI21zBph44iER03XHf4eMQvQ5TmxSQzIImebaLTkbGvSbmGa
         gSd7Lw/fROYbRtlg0Z9Z20sPGypVm/Wbj6QXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460027; x=1735064827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/U74kSzGU82WaF3YwiwK5Dsre8yynJCW2nmO8At+rU=;
        b=kT1NKtkVRPuwL+LVRgcnxMyFFscTLr5CCISnZZ91EXuuNNJz9duz3b2PK2MAOj0QRc
         8sWKiwZ4LJwXYTquVMxRYdv/PqJix9FtYSDL5NDUK6++juOr8Gkiz/Zi2nbZmF8NC5AD
         wFfKTHQ8QLo6MLWl8ruDnejVrXrEXyCiuGAw8nEQyH9CY5doqoyr51qTT3Elw+2OOLVj
         Xtk4WdEYd2GTUJmEKZxEWTbP8NAjnV6xHrBLXVjPsIyCzE/EeHCsA8bntLi2EaVZDNou
         /bjWgwTopJIus2RHuPsMztexOS6yVb/lkXkEMosI5W89UkCdofUyy3wDD8Cf0KLeGTAU
         msiQ==
X-Gm-Message-State: AOJu0YzEfzaXUBM6DcNmb4K/MjRM0YDpvURg6+d3AHG7kjhi6B7gE4Ws
	DXqOPtxd4cTxZwm36tvDm6PZQc66igEOuXcNCdVbwpbQvozMvYK1zEJQnyko2Q==
X-Gm-Gg: ASbGncumrv15Pk7tIiCSSwQzAzsjenhEFjbGCaI+S0ATY2cM1/Zq2TyhGl0/21ozTvq
	VJxcGBar4xETXpwoWHgRP2L3tKPNdoG+53SNd1bU0vsG0nL3w72xva10/q9OCNVjMZljlleQfTa
	/WxOL6WfGcHBizGjrXHCoAa0diT3PCWGXTQmVb7LTLxMCuDoCNSYv2LNUAi70klTX/IhQ/mbWl3
	FfqC2NY24sAoguucwx/xhJQmWFdemp1kU3ZqBR8tdaAW7+e+4uvXsjLT/Qupjf94cEXGTohZ5z1
	p7HcnyEDPei+d44ExvearZV55tyCh8s+
X-Google-Smtp-Source: AGHT+IEPpk6Urr1+CMvIklP4UBiB/F9Q8tjd6vrHKHA/uvKNQzzjqCoymUkwAOGPBqShreKzxQZEew==
X-Received: by 2002:a17:902:ce85:b0:216:7cbf:951f with SMTP id d9443c01a7336-218929c72b5mr205986485ad.21.1734460026696;
        Tue, 17 Dec 2024 10:27:06 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:05 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v2 4/6] bnxt_en: Skip MAC loopback selftest if it is unsupported by FW
Date: Tue, 17 Dec 2024 10:26:18 -0800
Message-ID: <20241217182620.2454075-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241217182620.2454075-1-michael.chan@broadcom.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call the new HWRM_PORT_MAC_QCAPS to check if mac loopback is
supported.  Skip the MAC loopback ethtool self test if it is
not supported.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Change bnxt_hwrm_mac_qcaps() to void
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 +++++----
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c0728d5ff8bc..46edea75e062 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11551,6 +11551,26 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 	return rc;
 }
 
+static void bnxt_hwrm_mac_qcaps(struct bnxt *bp)
+{
+	struct hwrm_port_mac_qcaps_output *resp;
+	struct hwrm_port_mac_qcaps_input *req;
+	int rc;
+
+	if (bp->hwrm_spec_code < 0x10a03)
+		return;
+
+	rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_QCAPS);
+	if (rc)
+		return;
+
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send_silent(bp, req);
+	if (!rc)
+		bp->mac_flags = resp->flags;
+	hwrm_req_drop(bp, req);
+}
+
 static bool bnxt_support_dropped(u16 advertising, u16 supported)
 {
 	u16 diff = advertising ^ supported;
@@ -15679,6 +15699,10 @@ static int bnxt_probe_phy(struct bnxt *bp, bool fw_dflt)
 		bp->dev->priv_flags |= IFF_SUPP_NOFCS;
 	else
 		bp->dev->priv_flags &= ~IFF_SUPP_NOFCS;
+
+	bp->mac_flags = 0;
+	bnxt_hwrm_mac_qcaps(bp);
+
 	if (!fw_dflt)
 		return 0;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d5e81e008ab5..094c9e95b463 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2668,6 +2668,11 @@ struct bnxt {
 #define BNXT_PHY_FL_BANK_SEL		(PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED << 8)
 #define BNXT_PHY_FL_SPEEDS2		(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
 
+	/* copied from flags in hwrm_port_mac_qcaps_output */
+	u8			mac_flags;
+#define BNXT_MAC_FL_NO_MAC_LPBK		\
+	PORT_MAC_QCAPS_RESP_FLAGS_LOCAL_LPBK_NOT_SUPPORTED
+
 	u8			num_tests;
 	struct bnxt_test_info	*test_info;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 8001849af879..c094abfa1ebc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4899,21 +4899,24 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		bnxt_close_nic(bp, true, false);
 		bnxt_run_fw_tests(bp, test_mask, &test_results);
 
-		buf[BNXT_MACLPBK_TEST_IDX] = 1;
-		bnxt_hwrm_mac_loopback(bp, true);
-		msleep(250);
 		rc = bnxt_half_open_nic(bp);
 		if (rc) {
-			bnxt_hwrm_mac_loopback(bp, false);
 			etest->flags |= ETH_TEST_FL_FAILED;
 			return;
 		}
+		buf[BNXT_MACLPBK_TEST_IDX] = 1;
+		if (bp->mac_flags & BNXT_MAC_FL_NO_MAC_LPBK)
+			goto skip_mac_loopback;
+
+		bnxt_hwrm_mac_loopback(bp, true);
+		msleep(250);
 		if (bnxt_run_loopback(bp))
 			etest->flags |= ETH_TEST_FL_FAILED;
 		else
 			buf[BNXT_MACLPBK_TEST_IDX] = 0;
 
 		bnxt_hwrm_mac_loopback(bp, false);
+skip_mac_loopback:
 		buf[BNXT_PHYLPBK_TEST_IDX] = 1;
 		if (bp->phy_flags & BNXT_PHY_FL_NO_PHY_LPBK)
 			goto skip_phy_loopback;
-- 
2.30.1


