Return-Path: <netdev+bounces-152016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A639F2625
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073C2164AA2
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC11C3C03;
	Sun, 15 Dec 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WLD+/EmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772C1C3050
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296430; cv=none; b=HWgGzIjJtLfjeVwkCGXNHjIZKXt/QC98GSvIZB6gMapsMy8mbJZk2Yq6L6SfOZiENw6VWU02DoQneDOn7sOv8D4I4303bImvey0JS7nKDsdMoOHWdBRpEGgL/s8GMn1B4fdSg/Iq1VMh3qzIKFcftf+Kcd2qABtWy7bdyPkitok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296430; c=relaxed/simple;
	bh=t7SX4wnq7JCkCqTZPOct26rRT4eo7Lq++xWFC0Zuusc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkyN1PHcismBWvyeExZgZBRWSZggr4Urc3teCGn1rvdjjIwAhtUsobtDxlLNgnSsndrK4YrOmZBNKdftN8ivE8NiFGdssghstTiigv1uW2F1sLAAvHeRqn6ld3x8cEtCRxV2uQGARJumL0tR7je+2FuTgs0wTI4daZaPjFVG33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WLD+/EmX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso2210896a91.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 13:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734296428; x=1734901228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhjMh08UQITu22NxkjogLYvQnzungmcAPuron0gAMz8=;
        b=WLD+/EmXddsV7ZLL+lyFEWSTTNF+h4azse53B9dPfUgL2A0fKN+g8hIU/M9fppO1AG
         RxeMwk7vC5WzrEM1sK7c+rIkWKi9mWi0MAQ6RRYsFya/TGf3enBUUlPwM9SD2da3hVcq
         QqCYdRejP+8nKFBieClk7Iq82Dt7nGSabKO6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296428; x=1734901228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhjMh08UQITu22NxkjogLYvQnzungmcAPuron0gAMz8=;
        b=dwNPpvW55XdOcHLuz3pNL0FucKRU1OhPTJuGpxa9Pe386pV7uluXVrec9WAHMo+vTS
         wi12FZIqzMMYmR9E3YDpFcGAPIeCEK77hVBqWDyRQLLfneaTGzUyDa88DHBPYPmGV21X
         6Aw6BMU6ILKjd1SnK8bAOjl7VUbziuG+czYEZizaE8OWeoh9ID4GDcR+qqw40KYK1CWn
         xNgMivyvPPCvEq9ClLQO0rQ3mJEsgdROjxgZyMlEQ9ByM7XMKZhmUh3uIZWOfHMZsPS4
         CTxQLAP7imhn8sTmozWTNqc+zTYzQfbYBmqhgfSHZsu1SzrdsCxVvYLCJfm50jmpD/2o
         cSSg==
X-Gm-Message-State: AOJu0Yy2mq4IJftNnlNp5D2GhD4v7IaIXK9/au8AiXSkI0iOMtwAST1t
	kI9aYGnErXOBqLYe+4G7BT6KCgmfW5RfCqcADI9/uAJZPqt0cvYuWald4EWGvw==
X-Gm-Gg: ASbGncsAbr7bIxdWS8CFU6udgoj60s1S/coYD1RhWN8ea7VbPN5WMfiVhvdt7IWs2OD
	N4c2Fd+qyIIYEH5QcY/F/cZkqL0ZyJ653hfz3LEjI90g1fYV2PTiP4OLZzy/Oq4Ptakf6uPhaHT
	QOR9Wr6RdknzCuLXOcJlO5823YxLWTQge2GUBCVql7zeKha6BWcAVhOssC+h0Fc64MuIyEuJ3ys
	o8HzwsqJqK8PVZFpqs9nRfPiliPNVxol+Did7t83QYPWPkVwY9NnIM0k7gUdLghf8BEda0kMAvH
	FaGGoowdCc7dI/ejW9prIevSrrPAjf3b
X-Google-Smtp-Source: AGHT+IHJjquEF4y5rRyfU7FITi9KpA/pd3DnRquwaCr2m2++jrMmYq1ng4R2dA4ZH/3XfSZA2jHqBw==
X-Received: by 2002:a17:90b:1646:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f28ffa7e42mr15880093a91.29.1734296428082;
        Sun, 15 Dec 2024 13:00:28 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc308csm6682717a91.50.2024.12.15.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:00:27 -0800 (PST)
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
Subject: [PATCH net-next 3/6] bnxt_en: Skip PHY loopback ethtool selftest if unsupported by FW
Date: Sun, 15 Dec 2024 12:59:40 -0800
Message-ID: <20241215205943.2341612-4-michael.chan@broadcom.com>
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
index 8de488f7cb6b..e5904f2d56df 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4911,20 +4911,26 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
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


