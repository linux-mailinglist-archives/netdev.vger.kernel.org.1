Return-Path: <netdev+bounces-186587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D16A9FD58
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7132F173998
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15E213E97;
	Mon, 28 Apr 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RJV98jna"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061412139B5
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881184; cv=none; b=il79zSghv1baSCIwVhqmzeoTlR94wx2RillGRX/RigRRlEleAIicz/daxcqjjZzsr/BKKIzIQuV3RdD68JQ9EMwfCFr1h4LClk5Lef3qtZYmEDfOvB+IHuLvca1zY5e35oRxhggFDqDL8o69eIXRP6U4sAhaD8Xuvr2NDikFc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881184; c=relaxed/simple;
	bh=84hdRISUrScMUTSVg7dqkxMj9y1P8NK+MmF4jeahLFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcPMXednisgGS+YR0vjTt5zQrzQcfiEOdzAacRakuuf740xUdJUHoPHJxqyE11V3T8v3Mkhgjo9Q6uh0e9S5AY8APf6OQGNU0STGK6lFp7ZjLdYbiXfghdeAaMVhdFvCiXnjNRbFW8ycFkANDqQqFuB0c9VtsOxGYuFkccFAoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RJV98jna; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bb647eb23so4465311b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881181; x=1746485981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRDMivPWqMs4F4Yxq3ncEeO1sTWOCi4jEB3Cacnc5Qk=;
        b=RJV98jnaiOAPyfgLpvTZuYG143GN8QaQ28iRKWeULgj32C/WDpeZK8HS2LW8dHDeeT
         zBS/iGSAWkVeYJIR6Tux3KmWXCDXg3elHK8bfYmMB8d71JTMpqmgMt4Wyw6JtemsGuGk
         ZjAKYmozujNnr36pGHNBJ2/OekCr9SK9di240=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881181; x=1746485981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRDMivPWqMs4F4Yxq3ncEeO1sTWOCi4jEB3Cacnc5Qk=;
        b=LuJavRP6xOnLW2m2Vb5vxK1Lj3BUVqRp/4FgDWgS4oekNTAyNrlb9QwV1Dr01qz5K9
         ar71DkKPb9r3eO6CqRQExpszZErY9C7inp2JaT+iBIe36HC0J8qe2pZi9kGA+T1pXTC+
         P/Pc5evXIUwZ9TGP4bfCyu9MYJJpuL9JNv4Pe5DTKCYuVIEp/40y+Lksp5PQ3l5aUoZj
         xsUUqb/BisgWosDXjWmhsH6W+pX6hu30LOtjuPsdNyU1v/Q+KWRcNqUF3Ew2BLzgqJYT
         e4Ym24EcvpFlK8DhnW/Zs9fp3uDVbqi6qd0GBC1A3R7++6l8Yb8owCZ/7xJk4p8Jo4uE
         plog==
X-Gm-Message-State: AOJu0YxMCH+Va+epraK5zefutSR2FMhPAjCyxX1i9jAx48k+9H77m5DV
	oDjdfOPs7slf0hqpnmXaoJiYGLuhK1j2241DZxzZiZJr3IG1yfDRGpzT0WfuMg==
X-Gm-Gg: ASbGnct3/detqzzlMPb2gChXeHKGI848HMMbQtFk9uyT8M7+Z31wSti6U+QBbBe95UD
	XLtpqnLkUAKZyAUpZvT8qtJU8Zog/mbqXlCTxbXlhiAQyQJn7OtPzXa+rBGhLt8iiEYkVgHCtjg
	n8agPKZalsBczAQVigRt4U39wsk0XOPLFG1m43V3M5dx+QQKfzr+X5w5upcCAodE95ZFD9y8SzT
	vXxDxLemfiEg9i+/GAMB1DK8JgI0l2uxFoljNCjJpi6xSABQupD9D7kNB04ANotBsgfk5/TVE7J
	agajkxlvHXjQ1hdXrxGjQkB2mio12Tg+dpTMpc+GTkWEoUQzffy8v3Mpgj2ptWftrBb1/JF1cnN
	xUIRFydkJbvpmyzRJ4qPC3PAYE2A=
X-Google-Smtp-Source: AGHT+IGdKyJbq1x4dX5Zz+0IhB1eTFyLs7qz5fG170y7hKDv2uOL+aD+W5EMizWEtF6A4H4wvb99OQ==
X-Received: by 2002:a05:6a21:1515:b0:1f5:8153:93fb with SMTP id adf61e73a8af0-2046a465dd6mr15082540637.10.1745881181301;
        Mon, 28 Apr 2025 15:59:41 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:40 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 2/8] bnxt_en: Fix ethtool selftest output in one of the failure cases
Date: Mon, 28 Apr 2025 15:58:57 -0700
Message-ID: <20250428225903.1867675-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

When RDMA driver is loaded, running offline self test is not
supported and driver returns failure early. But it is not clearing
the input buffer and hence the application prints some junk
characters for individual test results.

Fix it by clearing the buffer before returning.

Fixes: 895621f1c816 ("bnxt_en: Don't support offline self test when RoCE driver is loaded")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 48dd5922e4dd..7be37976f3e4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4991,6 +4991,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 	if (!bp->num_tests || !BNXT_PF(bp))
 		return;
 
+	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (etest->flags & ETH_TEST_FL_OFFLINE &&
 	    bnxt_ulp_registered(bp->edev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
@@ -4998,7 +4999,6 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		return;
 	}
 
-	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (!netif_running(dev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
 		return;
-- 
2.30.1


