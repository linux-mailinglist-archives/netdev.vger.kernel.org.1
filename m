Return-Path: <netdev+bounces-152018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1D9F2627
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D3F1885CCD
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E61C4A2D;
	Sun, 15 Dec 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YJrvskZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B01C4616
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296434; cv=none; b=lbX7c/Bf6UYtEpv1MGHP2aV415cmvrCf4JztWlQYt/Nf9iwe6ILR+7ku+POr4FPAvkRVmKLAIp6sCQ9Xv+SEdooNz4D1C1bMzYmNtO9UfU2vWmJZ3U1nwtMF+PV24Nwfek3NOOKcImdN8J8YYUqOZWyvsUwNVRDoMq25DUCsEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296434; c=relaxed/simple;
	bh=kEnY6dl7UnqB42mgRNavKxIZ0Mw3i0G/mlceYLzA5Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiOKJLXSb64sTYUSpi0fjOQVFESvfd5krvpLA5+7JMOOYSxEOBFWkjTqyRIK1bHbHKBymQ/sIZSnhkqvPi5aQ0bN9OrKXyBoscssps/gQB0dogHs45naq74NS0aqnBwjsvvLo9zpaNDI3X4ycCc8A0afcU7Xtd3RzkJk2ELg7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YJrvskZl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fcfb7db9bfso2390150a12.1
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734296432; x=1734901232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyCOghL5TxS4EZ/q+qaZJyJUn/ooAr4fRuYyPIMXqqw=;
        b=YJrvskZledvgaFcsNNNxoesdi7Z2Z+7vWpsfWQ7+eqs/mUlF/WCIH66IQExDEya3+J
         zs0DvvBCOY6YIn416DtTeFRg+MyxiMomg+dOUkRtJAY8x11LtzzcEBCTFJ3TVL3xNwnG
         /QjRq7n+fqsx48Qa1pJJPB140JVeqkSJ513xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296432; x=1734901232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyCOghL5TxS4EZ/q+qaZJyJUn/ooAr4fRuYyPIMXqqw=;
        b=C3/CxgC3kAv6mJEiGrrmt2wiSXvKXvJcpQ29kz0DUXGmcI6ttIooOTiKxeo2VnWMY/
         xnMtb1O2WwIr/uPCIV+WvmZw96rBHISMai9TgBb//hcyMujNksrGtU1Jek6Bkwo+UP5o
         HEqAHIsSKXSY6kwrG1Zw/ejajfbXKzCNSSEUPyelMFDwan3CIjIJ/+IZofs8V58vfyVC
         PzZHjLYYbCofbIdUcSLCgLrLtnYrmKNbvMWO1mv4+cQNcHD/aaIEv6L4vvJK11yJzBxJ
         O2swHIKSVLy7eeHrNmlXxFIEohhB9iEBJ5CyVLGdYpPifmxMbfRqUaiXLcyvm8YdT9J9
         APUw==
X-Gm-Message-State: AOJu0YxIEJEsxqwWsD5Ya+SX3JfQByigh5s9sGmIHphZDfXlsWV/RnC5
	xkZVhO2uj8jRvaTp3RrqvWPul5N2pJexuMNGcwBGIQsWpV4Guh4rIYcDeSJxZCf4IDQZCoegzi0
	=
X-Gm-Gg: ASbGncvkHcedUkHNGQVtRC3zDGatY0RvOjSmvoLniV+vPlknlj09pnlK1K5LCPjQmz/
	qzEhNg0p6RdNVXNK1p3cWFpb6sl4yO8O4sXvG03QnWLFvcLQj/43Xexo6MUE4V5TQ1PCwuMVpCs
	EV3xz6+BB6tIY4xiYeOWMb4MoTelPYuDWS3h/vgIP1FIf9Ooa86WlOBYkf3ELfyhLofMDMPqYn3
	hhXf99eMHE3TwScgkr8r1LehyrtZOJLMm+sXq2EztuotLirlQHDacmNn4vzBMvgBRq7uq4yx8Vu
	j1qy9fY91HY42fJ5UAXeIA2N1otlD9BN
X-Google-Smtp-Source: AGHT+IGSbRCdzCDTWWsb3oRDfYNeK+SLrSJN8YUYB+q7JEcGVOWqBJf0ySKlsD5xXwDjMwlw2wYjqA==
X-Received: by 2002:a17:90b:54c7:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-2f28fb666fbmr14389675a91.11.1734296432415;
        Sun, 15 Dec 2024 13:00:32 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc308csm6682717a91.50.2024.12.15.13.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:00:32 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 5/6] bnxt_en: Skip reading PXP registers during ethtool -d if unsupported
Date: Sun, 15 Dec 2024 12:59:42 -0800
Message-ID: <20241215205943.2341612-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241215205943.2341612-1-michael.chan@broadcom.com>
References: <20241215205943.2341612-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer firmware does not allow reading the PXP registers during
ethtool -d, so skip the firmware call in that case.  Userspace
(bnxt.c) always expects the register block to be populated so
zeroes will be returned instead.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 3bc2bd732021..4c7ef1a67bcf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2050,7 +2050,8 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	int rc;
 
 	regs->version = 0;
-	bnxt_dbg_hwrm_rd_reg(bp, 0, BNXT_PXP_REG_LEN / 4, _p);
+	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED))
+		bnxt_dbg_hwrm_rd_reg(bp, 0, BNXT_PXP_REG_LEN / 4, _p);
 
 	if (!(bp->fw_cap & BNXT_FW_CAP_PCIE_STATS_SUPPORTED))
 		return;
-- 
2.30.1


