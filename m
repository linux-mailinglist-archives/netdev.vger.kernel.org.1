Return-Path: <netdev+bounces-156877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF92A0825A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151E4168A43
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534A2046A3;
	Thu,  9 Jan 2025 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="tviYwSZI"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92147204F76
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459038; cv=none; b=QsmiA1q1LDu6WvLX3xpnGmYjR4HAUt12r+0hbBtjyzRAEKo1Ek7uQoSdH/9DjEbD1WfjzVQbVTtSCZqunqMA1uYiq1v3gwdeNljs237vOMym28CUSgwzMDHOS0TmQOdHJJyYZhnw6UEyrBw+O3a+4HHFKr1yUQhsyoR60dgYWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459038; c=relaxed/simple;
	bh=PUtS4415at1bVZMOMPuBrjF3Irk089p14E+kYCzEQHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZt7DR/rjNmjp6G21I0p5raTSkED1l2B0bs6NSxj2HD0LI+boA1Oz+O+jis1/gvZqIRUKT1F2uHHlfo0LxmR/2NH6CwoXOA8hRqdHf93qjIJxvGZ/qVCi07mOGbgcxUFUV7dTDy645DAVldmOttCxmngofFGWvmM+4Q1aqdWijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=tviYwSZI; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250109214345bc9c0fe019e8cf1a3c
        for <netdev@vger.kernel.org>;
        Thu, 09 Jan 2025 22:43:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fi4iuQ5f8HPWWG3cDnQw1vo80NGv7cxak5PbTsLHZQY=;
 b=tviYwSZIKiqpBYowf3RnryqGvvNqs2cd/E3KGT7ES83TG9ZvCJnSKXiMrU3Vw8EwKLKkKe
 8I2hG1jZedVe59Wc7InvbXLrHDz4fSKEIvJKCzIxQUxCOiQkLOUtBqmsUsBBYPIbNjxZdmv7
 XiFkjGOprq81oU4WbVHIvw6q2fhwaP+/RZ+aFWfhEUFeFIcbtlrV4kEbuLQM30L4Xw/1TueC
 gAy6wT8HqNf0qcwIM9dOEF3gt7YTJgTcrO891IJPfQfTAIN3SaydLofEPGqxpcT+/HLc/sSO
 TbJ5t90d+NerqfllC64BBXzvS5+127EOtx2Pn24Cz90zgwWzZ7Bf4a3w==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Chintan Vankar <c-vankar@ti.com>,
	Sinthu Raja <sinthu.raja@ti.com>,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: ti: cpsw: fix the comment regarding VLAN-aware ALE
Date: Thu,  9 Jan 2025 22:42:13 +0100
Message-ID: <20250109214219.123767-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

In all 3 cases (cpsw, cpsw-new, am65-cpsw) ALE is being configured in
VLAN-aware mode, while the comment states the opposite. Seems to be a typo
copy-pasted from one driver to another. Fix the commend which has been
puzzling some people (including me) for at least a decade.

Link: https://lore.kernel.org/linux-arm-kernel/4699400.vD3TdgH1nR@localhost/
Link: https://lore.kernel.org/netdev/0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org/
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 drivers/net/ethernet/ti/cpsw.c           | 2 +-
 drivers/net/ethernet/ti/cpsw_new.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734..dcb6662b473d 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -762,7 +762,7 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 			     ALE_DEFAULT_THREAD_ID, 0);
 	cpsw_ale_control_set(common->ale, HOST_PORT_NUM,
 			     ALE_DEFAULT_THREAD_ENABLE, 1);
-	/* switch to vlan unaware mode */
+	/* switch to vlan aware mode */
 	cpsw_ale_control_set(common->ale, HOST_PORT_NUM, ALE_VLAN_AWARE, 1);
 	cpsw_ale_control_set(common->ale, HOST_PORT_NUM,
 			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1e290ee8edfd..0cb6fa6e5b7d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -686,7 +686,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	soft_reset("cpsw", &cpsw->regs->soft_reset);
 	cpsw_ale_start(cpsw->ale);
 
-	/* switch to vlan unaware mode */
+	/* switch to vlan aware mode */
 	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM, ALE_VLAN_AWARE,
 			     CPSW_ALE_VLAN_AWARE);
 	control_reg = readl(&cpsw->regs->control);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index be4d90c1cbe7..cec0a90659d9 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -554,7 +554,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	soft_reset("cpsw", &cpsw->regs->soft_reset);
 	cpsw_ale_start(cpsw->ale);
 
-	/* switch to vlan unaware mode */
+	/* switch to vlan aware mode */
 	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM, ALE_VLAN_AWARE,
 			     CPSW_ALE_VLAN_AWARE);
 	control_reg = readl(&cpsw->regs->control);
-- 
2.47.1


