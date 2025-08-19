Return-Path: <netdev+bounces-215016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA36B2C9DE
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3886F7A39A4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15423283CAF;
	Tue, 19 Aug 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PBnnu5A/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADA239E97
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621605; cv=none; b=bOIXqoUqrRKO3K/LxgEKUGW5myZgMSd8jdtVb12uOcrS2Bx/ez2FLNJy2cqm/tiSdVp42IcZMpntSuHnHZDCr5Xv4selylY8YrCObh0DLDkQ+qj4apPLFmRJmOvRC3IFNUBJQfFT7uTMAEQw9l1gzSab/stqKTqA/YB+PFkOon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621605; c=relaxed/simple;
	bh=yO3YC+S/HSL+5FbXS/9QdjNaIiNMqqs/+ffpA5bR1fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoGLxifd1G0BqQdl04U6bJF5t6R/1EdMWGCsZMwwXE4KDconNDDipwyl3mi+sspFuGkEOlVzcJaDgPOepxW3usSqpzfsjK1gy51ymyjiLyePLXirGZL5TGgzUVrVMzXoA4o6BXy4r8d1Rei+N/stA3LzucoRdncCrj221LrTEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PBnnu5A/; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-24458317464so62320045ad.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621603; x=1756226403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmjVnP7qpPSN2hUz0/Cxl4LBV3THbWeDOm+1Q3QyjaE=;
        b=IkpekNAkfPcR3ZE1gRFnoBu99f4gudclLBkGPelgMJ1uy62+zxSfMvJoRdpy4NwHk2
         NXrLro7LpsD0kNy4dMEQv/+vUmpK+bIcVBhB5Krs43pdK1A1nG+XGwpcqFJeT2sp700/
         j8c+aowO2+gNU5OMkCZRVR2ial250/4c+a82BNEE0ZQWdDuDCfbIYyQ/85QlATnWN4J/
         2ce8xB71xBru0+trKf71z68NWi8raE2/Oq4ohxowkS+FpmgHUeudKVQlKBAkxv+Q71OZ
         mPh+qW4qYm21LHg9TQ0m8oRgbfNUvX4JPpoO/bhKvPn1g2KROm/srW+HbVCrSliRm0Ci
         UEyQ==
X-Gm-Message-State: AOJu0YyKOH4Pa1Acwi2gPSM4lRV85UNqXkKeeBU54/xfHgZ1oW3oYsfS
	LhP7a3Uvb+4X8+ZTgdPcEj+XiriCCrmhVXnV5H42bASpHHKMeWjBPyYTdtLjEN1rjDklEx5Da/j
	eDi/7UdeVvBmEdnBwvx+hUwhV8tFDOkHw/cAOWQCNwHI4P15OFH5FA/lT3zvurXA4KJuxhaPy+O
	NmurA1WWea3EtTCY05H6VXzn5uB4xV/NEX+zuceuyqaRGezJNZle/cWw5V9kZ6nZy0+S8A4mFua
	pxUgx0fb7s=
X-Gm-Gg: ASbGncvo50Z03STZ91FSsv3m1q+8JcC2aGfFlPRiHNxWrAa9ISpWznGWzDO+Ebr18Mu
	sx6W10B9ziG3ZqJOpL0niBVTDPvl2gdfdmBnOvOsks/xXwCi5+Ki02yzxfAvoq8Sj1BpCXWDd/q
	lZmzKn+2BYESPmJElaHfJ1XlG6O26U06H2+SDCYlIsMoz0YWQtFGG1tKe+FhlmYFdUXKOW6phZU
	Hc4d4C6kImNpQy9zBccg45ekbiIYH/nidUuQ4CW7y/xfu/7T0vKUKFw6Vc/nGub26i5Bdi2LTOX
	uBobqjp7ZvRWttXVlFl/QWZo6YB6Yhyi5cfNHLe9V/d5hHuJATkWQOs1gOGiZTi3Y60DE0RuRBI
	kFk6gtO7xOXQjC9Kzh59BCZeF8jGS/bx2HLKs2l9EX/zbnICj2esHobxsQlMZQsDkAUY6mbR3
X-Google-Smtp-Source: AGHT+IFLzbcoWgPNwZJl0CuSTff1mfAr+dZUGer8TzrH7BrSgO+ryImJmyGifYzUi0BE3Xm41l0q9M6UAm3w
X-Received: by 2002:a17:903:1a24:b0:242:ffca:acd6 with SMTP id d9443c01a7336-245e0509c9bmr38866285ad.35.1755621602866;
        Tue, 19 Aug 2025 09:40:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-6.dlp.protect.broadcom.com. [144.49.247.6])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed491effsm158005ad.56.2025.08.19.09.40.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:40:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870676ac0so1491270885a.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755621601; x=1756226401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmjVnP7qpPSN2hUz0/Cxl4LBV3THbWeDOm+1Q3QyjaE=;
        b=PBnnu5A/cOdCGab4E+qNjgPediOJ98FTMzYnqK2aAvN2tbuJcunpk7sJ/w03UUNQCl
         tPu69fdglhplmwg0RDvv3hsEfgdFhPsu7ngawqhXPqR9MVYsM76m9OVZVYp0OP8LD9K5
         BWplKqamiP6rzl84csyohB6pm/5kxrTUaCqJc=
X-Received: by 2002:a05:620a:4706:b0:7e6:99e5:f54b with SMTP id af79cd13be357-7e9f3363a93mr418609385a.19.1755621601178;
        Tue, 19 Aug 2025 09:40:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4706:b0:7e6:99e5:f54b with SMTP id af79cd13be357-7e9f3363a93mr418606585a.19.1755621600741;
        Tue, 19 Aug 2025 09:40:00 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e19b14dsm791908085a.39.2025.08.19.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:40:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 4/5] bnxt_en: Add pcie_ctx_v2 support for ethtool -d
Date: Tue, 19 Aug 2025 09:39:18 -0700
Message-ID: <20250819163919.104075-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250819163919.104075-1-michael.chan@broadcom.com>
References: <20250819163919.104075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shruti Parab <shruti.parab@broadcom.com>

Add support to dump the expanded v2 struct that contains PCIE read/write
latency and credit histogram data.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index abb895fb1a9c..2830a2b17a27 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2088,14 +2088,16 @@ __bnxt_hwrm_pcie_qstats(struct bnxt *bp, struct hwrm_pcie_qstats_input *req)
 }
 
 #define BNXT_PCIE_32B_ENTRY(start, end)			\
-	 { offsetof(struct pcie_ctx_hw_stats, start),	\
-	   offsetof(struct pcie_ctx_hw_stats, end) }
+	 { offsetof(struct pcie_ctx_hw_stats_v2, start),\
+	   offsetof(struct pcie_ctx_hw_stats_v2, end) }
 
 static const struct {
 	u16 start;
 	u16 end;
 } bnxt_pcie_32b_entries[] = {
 	BNXT_PCIE_32B_ENTRY(pcie_ltssm_histogram[0], pcie_ltssm_histogram[3]),
+	BNXT_PCIE_32B_ENTRY(pcie_tl_credit_nph_histogram[0], unused_1),
+	BNXT_PCIE_32B_ENTRY(pcie_rd_latency_histogram[0], unused_2),
 };
 
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
@@ -2123,7 +2125,13 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 		int i, j, len;
 
 		len = min(bp->pcie_stat_len, le16_to_cpu(resp->pcie_stat_size));
-		regs->version = 1;
+		if (len <= sizeof(struct pcie_ctx_hw_stats))
+			regs->version = 1;
+		else if (len < sizeof(struct pcie_ctx_hw_stats_v2))
+			regs->version = 2;
+		else
+			regs->version = 3;
+
 		for (i = 0, j = 0; i < len; ) {
 			if (i >= bnxt_pcie_32b_entries[j].start &&
 			    i <= bnxt_pcie_32b_entries[j].end) {
-- 
2.30.1


