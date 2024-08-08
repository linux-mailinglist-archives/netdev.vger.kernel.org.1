Return-Path: <netdev+bounces-116699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C3494B624
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687301F224A9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF371465BB;
	Thu,  8 Aug 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="WCCTMrFV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FE145FE5
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094129; cv=none; b=MSao8iiPNgymRaNzYpQvqwaTuoatC59n55lvU8hNc02NGNhpmmgYJeWmvdLztuCBHNSl1PKktjV7eSO/PtduvmaXLKluE6Swn07RCrMutfcBE1vmXh5UiMBs33UMNDp/A5E0elaJUj6JZrVRyiBiBlhqs8i+j0hFH/I4X/0H8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094129; c=relaxed/simple;
	bh=newAh39OcpPc0hRknFImNwp6wIkkLsKXL5TwaQ6ooBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVgSXNLxoqVw7fV/lb42blb0J9evKM92rq9uJ6BNeuJsdXwkaWZ/78IFi539ZtMl9rSD4l1dAoIVx9e+08mePVSoHapw2wjreDiAPQDLnrx6j2aMF+mzNes2JoA4MhQ0akfBINkkRJPSdx4ECa3WOemVCV4fM3dGBwbKwz1Nq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=WCCTMrFV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so489245b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723094128; x=1723698928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwM/EyGTXg8z5hyrFAN1hxOsc7iO7uWxr0OnE4wYEeg=;
        b=WCCTMrFV+LjBoYEX6aBP/6/nqtox/dcD6ZBkIoojJv2oqan/wbtEo58MaUy2tdQlFh
         wH8EzIyjfxxVZGH/lka1xw9OpRt4CZ1CxjWAjnj4dVm8XcKoREjhFS7T0jL8Pg7MZqSS
         o6guFotv+2OX3PwfoKg8wPJmjlG+FujOcysDPFfewscMDEBQs5Wf52LHSFkJhm3yFmNi
         lf/wPQ4l3pN7xLDvkB9BScD2myKGj52/LE0odSC5FSuw+zJoXLaom3kFwzeqprpCjDeK
         avx/4t+TvRBYgGKJJGkqnkgBdN6UcTWuuRuItb+AUVk8RVLjoxiU/WVWg+Qs+EqAJwhj
         oQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094128; x=1723698928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwM/EyGTXg8z5hyrFAN1hxOsc7iO7uWxr0OnE4wYEeg=;
        b=HFQ+RCdMwSWq5Fx+FVYnuDIESqUIJToD4AH3qHtPL93UZb5wbr4+BhL4QWG7cVuN7/
         sxdzLzZae9MY+/Hn4YbzI2+5F+oNdO0BPKN/IIUj1NvHgUiaC1dzvAxmRfVlCHRZw7hm
         y2XXBryRcdgoQTr9ZG9s0uXRsbV35ybsyTGXKN7GbHPn7IXVaVr76GtCI0vPIPEDZdmZ
         3bAGsyttVj8K4sgv4vQxhbcfRmsxV0q06GnDe5PAlfTZ7hnUv3Q1d5WXTqqnSOw8jamP
         sAToFvQ2mgrvYubMMtyJgo8Y2WS5SqssMBlpPIUt2ShoXZW5GQJ4OP++JlDLISEUOEaC
         /iaw==
X-Gm-Message-State: AOJu0YyIfGRimqm1Wqc8bVbo3zEBIG0cLCVEtDGPxNYwjk7aeU96XEEU
	UUnVil+CC9nT331JkaLUq1Wb2q1HTTLBFbL9XSNJUIyuiLWGxoIKNo0zOA/dpNfNLpH/93/vuFM
	p
X-Google-Smtp-Source: AGHT+IFL/H0YBxSRBhzf41aTqaS4Yt6N/0YB6FcjPtaHWLj8u6jfASg+srNVYc+5Zh8jGsdRRg6QeQ==
X-Received: by 2002:a05:6a21:78a6:b0:1c2:8d72:67ce with SMTP id adf61e73a8af0-1c6fcef23a5mr883836637.15.1723094127698;
        Wed, 07 Aug 2024 22:15:27 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5916eaffsm115136005ad.194.2024.08.07.22.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:15:27 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 6/6] bnxt_en: only set dev->queue_mgmt_ops if supported by FW
Date: Wed,  7 Aug 2024 22:15:18 -0700
Message-ID: <20240808051518.3580248-7-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808051518.3580248-1-dw@davidwei.uk>
References: <20240808051518.3580248-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
packets, which can only properly flush the pipeline if FW indicates
support.

Add a macro BNXT_SUPPORTS_QUEUE_API that checks for the required flags
and only set queue_mgmt_ops if true.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7762fa3b646a..85d4fa8c73ae 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15717,7 +15717,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
-	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
@@ -15898,6 +15897,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+	if (BNXT_SUPPORTS_QUEUE_API(bp))
+		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a2233b2d9329..62e637c5be31 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2451,6 +2451,9 @@ struct bnxt {
 #define BNXT_SUPPORTS_MULTI_RSS_CTX(bp)				\
 	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
 	 ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
+#define BNXT_SUPPORTS_QUEUE_API(bp)				\
+	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
+	 ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
-- 
2.43.5


