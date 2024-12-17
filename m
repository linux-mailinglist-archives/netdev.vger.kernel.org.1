Return-Path: <netdev+bounces-152683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556349F5621
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AAD7A3D7B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746151F8AF0;
	Tue, 17 Dec 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UY8vUV32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92701F8AD6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460027; cv=none; b=BB2n54X4vVTetDU9MlALMENa9tpxEMdfS0QwFgJEboI80OY1u2Y1LR62aUIazVPjjWtpTKSyxfCf/VyAQ81ylU7GyiInT4M70DMZHZ0+/j0b3Lr8EJt14Q3EP0zq6dEFqpbUzHICCWrqoEFxaFQWYUZwJZMAagMQxFThZScPOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460027; c=relaxed/simple;
	bh=/SbxjZE0CWBdnUK4Eh/KtWKwbEFu2G0/SWFxFkbgbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI6Ta6MREJd0JKcx5hCJCOBB1xCilBqzE5BSbSL0L+VlX+ZV9YzyojtpM525Cld8IWbc7VaL9+fi5i9P2WGgqwx6Owgwlpbd2qBV2BttWnTP1gjxwIQLiyoR7mm+O5H9RrZ35zX7Q5O+DyYfMdVDwrcEtZdDuwuqxODpj8TWDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UY8vUV32; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216401de828so45395015ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460025; x=1735064825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izj0krEbHBgNpHKjiv2l6E2w5v2uO+MXE0kMsqnNseQ=;
        b=UY8vUV32Go3M4lXujP88PC8N8Gg9Rvn2e+h6IOT7xRi09iOJjiEPAhbleKIQ4/eJB6
         9I8UNSQ4/TT4eUqjA9NGdEbJ/N/aLuNcHi0qU75DEaV+mblSorrcqy0AvqOBcn7fmwP2
         0KR0kTaeYwnI47I9kTOuArbVsXTXUGmhZriyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460025; x=1735064825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Izj0krEbHBgNpHKjiv2l6E2w5v2uO+MXE0kMsqnNseQ=;
        b=G3w6Nc9odfHQ/26yp74MmDiyzEM92RsHHCYeCnwQkJa4D+O3BZebnJkm8Cznwln3qo
         ErOJRkc6pDz1HJFKFaa6ikNrXejo2dspkhqHg81HM6zdL0L0kxnII2OXQMyKFgfTcpKb
         wGfox8L6Ucq5lBz1VTQDeSFFHLHqCkSM015v6wBEDbpucppDAxjEIQ3OCwIq/jmFoqXb
         Qb34xSjOVC1YfAFxrXLlgYCDXBtzaDg62Rrar3ATyT6e7K4y8TgpypyrpF5yVBNiwKFU
         FYinpvKBNeqftnnTOt8ipz4FiudSCC2hqEpia7W0SbCT3O03NKYKibq17flPvgFg7eP0
         MDLQ==
X-Gm-Message-State: AOJu0YxyUoYvoNfCuwHWt0SxZGSGAVNvY9RAj4qtfngDPtEHHALXzRAe
	3VgsmBxUPgkyhy2ojksqevKEh/bNfuxX6Iu9sHkvUM8UAte+HuyVb7JEQX+ZyA==
X-Gm-Gg: ASbGnct7xs5ZEhk0Lb8p6bqmz2RgyqSjGbc+N2H+DYTBs5oACKwH2DznW3mGcAiVmA1
	QtoAKZlC0538M7bqGNqTnjIkjZebBi7FNbqOaCzOTDvryEPZMIHhX2L9UmfgS0RGf3rZoLQpTXK
	llQO02e56wfhK46RBXuZH03auXAHiH7yTGtSck3Zu3gNGs3mDsBweSh49mi4/t1Ds++0EETXgt/
	VEsBCIpoLS6SicbxJIFQt62wluY3kB2j2xGBxRjODfN+C5scGksAkF9AeRmyJRNfcWeHA05InvH
	5K2QSelfu3Y/WtT1fxsNhaaleYdKppZr
X-Google-Smtp-Source: AGHT+IFoEjqZZW9tC8sonBMG+kLXKB0pvo6SQ4YyPRAgubZy6S82t1D9mnoaVXnqAPSMb5y/5EZ+tw==
X-Received: by 2002:a17:902:e545:b0:216:30f9:93d4 with SMTP id d9443c01a7336-2189298bbf7mr257125165ad.8.1734460025155;
        Tue, 17 Dec 2024 10:27:05 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:04 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 3/6] bnxt_en: Skip PHY loopback ethtool selftest if unsupported by FW
Date: Tue, 17 Dec 2024 10:26:17 -0800
Message-ID: <20241217182620.2454075-4-michael.chan@broadcom.com>
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

Skip PHY loopback selftest if firmware advertises that it is unsupported
in the HWRM_PORT_PHY_QCAPS call.  Only show PHY loopback test result to
be 0 if the test has run and passes.  Do the same for external loopback
to be consistent.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 28f2c471652c..8001849af879 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4914,20 +4914,26 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 			buf[BNXT_MACLPBK_TEST_IDX] = 0;
 
 		bnxt_hwrm_mac_loopback(bp, false);
+		buf[BNXT_PHYLPBK_TEST_IDX] = 1;
+		if (bp->phy_flags & BNXT_PHY_FL_NO_PHY_LPBK)
+			goto skip_phy_loopback;
+
 		bnxt_hwrm_phy_loopback(bp, true, false);
 		msleep(1000);
-		if (bnxt_run_loopback(bp)) {
-			buf[BNXT_PHYLPBK_TEST_IDX] = 1;
+		if (bnxt_run_loopback(bp))
 			etest->flags |= ETH_TEST_FL_FAILED;
-		}
+		else
+			buf[BNXT_PHYLPBK_TEST_IDX] = 0;
+skip_phy_loopback:
+		buf[BNXT_EXTLPBK_TEST_IDX] = 1;
 		if (do_ext_lpbk) {
 			etest->flags |= ETH_TEST_FL_EXTERNAL_LB_DONE;
 			bnxt_hwrm_phy_loopback(bp, true, true);
 			msleep(1000);
-			if (bnxt_run_loopback(bp)) {
-				buf[BNXT_EXTLPBK_TEST_IDX] = 1;
+			if (bnxt_run_loopback(bp))
 				etest->flags |= ETH_TEST_FL_FAILED;
-			}
+			else
+				buf[BNXT_EXTLPBK_TEST_IDX] = 0;
 		}
 		bnxt_hwrm_phy_loopback(bp, false, false);
 		bnxt_half_close_nic(bp);
-- 
2.30.1


