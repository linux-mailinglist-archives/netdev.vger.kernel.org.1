Return-Path: <netdev+bounces-151277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB19EDDEF
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612DB1887A29
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCC75BAF0;
	Thu, 12 Dec 2024 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1ktdYGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FF33FE;
	Thu, 12 Dec 2024 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733974440; cv=none; b=baQDE3TnMbM6okGBMdNTwAOdUCBXC3NV6pOtZLvGmVKidfFAj6SnHB+N8N1+E5Xfr/nAO1INT7XPlqjc5t7mhr+16gFpOhvCiWJN4UTwHuVHEjQmuMrMfPAErverBrAx/zImJUM1XE1yX2JaxX6y1aY7V1TQZ6MDSQqzLGfl+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733974440; c=relaxed/simple;
	bh=rmaljj3CVMsjgDpn8DnNrL7kt+LtW4QxuED6cOgCiLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEDEgi3VCSrplvt5+T1WaOqXfIu/K81C8XRwgyOjTnJoq5GEB5qE9i1tIp9yEJiQFHOLYaRwQUmtnw1zQEnbxr3EKr69auz7TblGTfijiGyX4nZvlbehkWbi7SXOaizLO2QN9ciSEPE/uqAK6iWGUpd1V58rlKH1w1SAqM5MSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1ktdYGP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso189231b3a.0;
        Wed, 11 Dec 2024 19:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733974437; x=1734579237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pzYjRDOZjwQLGfG7tztY2fF9MD2eQ633kRSm3R85gQ=;
        b=i1ktdYGPONA3Jq1vGh9UdkTKXqBRmkWjMyhibZQTJxo4T1MqNavrXeICbVtPfZ9Io4
         Bti628zuRfapm3NW27yY8gm2N4ci3d7wkIGpieQWp5UUKyy6e3q66euJ5XyDX7tccSjS
         NR73qQQAT7ARjfoeG5FEMCmQH1k8v+pL3KyTT4/Zt5HyLIUaD2aw6/L9CedJC7EfffxU
         IlH+NY1E7zEVWfUDcIWMhOng7FtbVdcH7TvO/Roxq4GxqcAt3e3AzIkncV4XdU98H3uS
         lrAattCErgYmiQMrkeq2NNX8HTCo0LOaMHgSqGSIVJ9B+ad71YVE7hCYB/rp97+R0y0V
         y+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733974437; x=1734579237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pzYjRDOZjwQLGfG7tztY2fF9MD2eQ633kRSm3R85gQ=;
        b=CZ4AxT/t0Ie109516GcDoStzf0uZ/ngoT9qVmrMk30oHJIS+qRgjxLhlX/gshdGHX4
         0SqyvwR4tNtuOQxlUW8MwiEyr6WJsGRlepUKbk+0KQ2kwEbdAC7U8oppMT52nzatz4ck
         CB7MGBMEPPtGq+Bz/9nTQMVJw1NYfYs/RBhddM85tyFn8uvKzPRYRfaguGLIh/EE/ERO
         KkeeZt1ABgR/9LXCDBxuBBdzWNMPR1Y4DRayX1gcke581o2UzR39Kgs2KSbc4oLqFBnV
         xYUiCx77jq18f3FT2AWqRP6qU8l3jn+F6xqxlKwEnsdfj/bmd3ztmQoab+7BfwgT0Yol
         7f3w==
X-Forwarded-Encrypted: i=1; AJvYcCXrb/17VOXAmDrWWUKh/Sg2v7P2aGD4GH6Z0y4zMSi4aqx682r8OyuLViGRP7bHkZIVj5oVoydgfl8Vwx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjt/IK0x3w6pA/ZosxeRSUdfkSUA66JwjPujJwf+4hgi3vzovQ
	TlVguN7W7eMtuZ5BNcY39tfKZjWSE4gReFxaUas8Cs8tcELy55yk6bCHUA==
X-Gm-Gg: ASbGncs23/YgHznPqM+QcHR5d9PFy2jwvSMzZIluA/i20r1RLdRnUOeFrzm5CwmcfPZ
	L6cslr9bUMszOkh3gG22UdFdKbZFgohuia1YPgshMMwlqtO1pCX+wwNc/ptjbJRpbHKpASKbnvV
	tPlcQcF1+2XUbRn1VtSxumtbEIVaVBP8eOMVJOXAsXOKKN6UXANEbAyuhDuwu0W7VdhCasNz3gE
	nYRBHitOJAwSRI587Nh+9fnxO7sBDcppA20gmeIgP0eZhjZlY60AVlZU2B0L0fKy3iKsQ==
X-Google-Smtp-Source: AGHT+IF2HUGVgJTHXHp2yZPxjGH98+Grs5GenuoQqTTyxoTeHaymmzl37DBT8/NhlfehPqg/7Ou6EQ==
X-Received: by 2002:a05:6a00:17a7:b0:725:df1a:27c with SMTP id d2e1a72fcca58-728faa2e5a2mr2417893b3a.14.1733974437292;
        Wed, 11 Dec 2024 19:33:57 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725f03a0ca4sm5879236b3a.113.2024.12.11.19.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 19:33:56 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: Drop redundant dwxgmac_tc_ops variable
Date: Thu, 12 Dec 2024 11:33:25 +0800
Message-Id: <20241212033325.282817-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwmac510_tc_ops and dwxgmac_tc_ops are completely identical,
keep dwmac510_tc_ops to provide better backward compatibility.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c      |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 11 -----------
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 4bd79de2e222..31bdbab9a46c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -267,7 +267,7 @@ static const struct stmmac_hwif_entry {
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
-		.tc = &dwxgmac_tc_ops,
+		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxgmac2_setup,
@@ -290,7 +290,7 @@ static const struct stmmac_hwif_entry {
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
-		.tc = &dwxgmac_tc_ops,
+		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e428c82b7d31..2f7295b6c1c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -685,7 +685,6 @@ extern const struct stmmac_dma_ops dwmac410_dma_ops;
 extern const struct stmmac_ops dwmac510_ops;
 extern const struct stmmac_tc_ops dwmac4_tc_ops;
 extern const struct stmmac_tc_ops dwmac510_tc_ops;
-extern const struct stmmac_tc_ops dwxgmac_tc_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 6a79e6a111ed..694d6ee14381 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1284,14 +1284,3 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_dwmac510_mqprio,
 };
-
-const struct stmmac_tc_ops dwxgmac_tc_ops = {
-	.init = tc_init,
-	.setup_cls_u32 = tc_setup_cls_u32,
-	.setup_cbs = tc_setup_cbs,
-	.setup_cls = tc_setup_cls,
-	.setup_taprio = tc_setup_taprio,
-	.setup_etf = tc_setup_etf,
-	.query_caps = tc_query_caps,
-	.setup_mqprio = tc_setup_dwmac510_mqprio,
-};
-- 
2.34.1


