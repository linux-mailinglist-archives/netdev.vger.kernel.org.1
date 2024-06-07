Return-Path: <netdev+bounces-101850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470C90045C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64AE1F21B1E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D461940BC;
	Fri,  7 Jun 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="D20CPWSO"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B70193062
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766056; cv=none; b=mRLF1r1e5vpdPhDV4WeBvgOWOIPoE2Iuefuu5gMBQSDDGS7BbKyV3keqrhmvRb49udaPCzh9wX5qVtsWJX0YsJDshx9mWtjmQ60VJbasaYVj0O75tRKlpRkohW/gOI28cmyM2TIeN1LMK5gXSl7S0rPHyYXstmALAmNeXJdwlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766056; c=relaxed/simple;
	bh=Lubo51aFliEiy57U/CSrVnSv9x7BSB7UF3Ec1ulGl4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVpEQ35QEBqDkasaCYmYLXmRl1PoC+8XCjmdcPYayYeUpOLBY4RrBnKTdab1JeOGsj5L4/TQGawynlRuYaHTuroi0ZIIMGqcqLutg31VyRpxBBvHUL9dICrK9zjiXvOiF0BOa1JTeX7to7+X4DSGXwdqSbt+sXZm/KeDO30tp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=D20CPWSO; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240607131412b567753069dd510008
        for <netdev@vger.kernel.org>;
        Fri, 07 Jun 2024 15:14:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xLX7+CQO0TEbMXn1aOXc/7bQGueWhuMmOf9S1qPGGjk=;
 b=D20CPWSO8w869qairY0Y5ea1kXH2yfbUrNqtsM/k5ZxVDQfe5j1K0aJwTnkJgqeIk/YYDi
 XCJy1xFil/yCNVXRyOth/cYdzF+cFX4pQcKfAmRJleatBxmAlz9QBWfp0kqzeGf6rm2bdnsr
 K92FaLURrh1NDc0FkYTGUNraDewMc=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Fri, 07 Jun 2024 14:02:43 +0100
Subject: [PATCH net-next v3 2/4] net: ti: icss-iep: Remove spinlock-based
 synchronization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-iep-v3-2-4824224105bc@siemens.com>
References: <20240607-iep-v3-0-4824224105bc@siemens.com>
In-Reply-To: <20240607-iep-v3-0-4824224105bc@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717766048; l=2559;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=Lubo51aFliEiy57U/CSrVnSv9x7BSB7UF3Ec1ulGl4U=;
 b=Ilvq9R68ZKnCvFAGqplauA7xOO0uEcY3dD+RILon+Vwb7nES3d+1FW+V5FuKziyYgRngL4gjp
 OsIH2tJxAYeD2jvHJ8+PI4+L/As4lC4Ol/AjL/iQKEJ34cUROXSmD1R
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

As all sources of concurrency in hardware register access occur in
non-interrupt context eliminate spinlock-based synchronization and
rely on the mutex-based synchronization that is already present.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 3025e9c18970..1d6ccdf2583f 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -110,7 +110,6 @@ struct icss_iep {
 	struct ptp_clock_info ptp_info;
 	struct ptp_clock *ptp_clock;
 	struct mutex ptp_clk_mutex;	/* PHC access serializer */
-	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
 	u32 def_inc;
 	s16 slow_cmp_inc;
 	u32 slow_cmp_count;
@@ -199,7 +198,6 @@ static void icss_iep_settime(struct icss_iep *iep, u64 ns)
 		return;
 	}
 
-	spin_lock_irqsave(&iep->irq_lock, flags);
 	if (iep->pps_enabled || iep->perout_enabled)
 		writel(0, iep->base + iep->plat_data->reg_offs[ICSS_IEP_SYNC_CTRL_REG]);
 
@@ -210,7 +208,6 @@ static void icss_iep_settime(struct icss_iep *iep, u64 ns)
 		writel(IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN,
 		       iep->base + iep->plat_data->reg_offs[ICSS_IEP_SYNC_CTRL_REG]);
 	}
-	spin_unlock_irqrestore(&iep->irq_lock, flags);
 }
 
 /**
@@ -559,11 +556,9 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	if (iep->perout_enabled == !!on)
 		goto exit;
 
-	spin_lock_irqsave(&iep->irq_lock, flags);
 	ret = icss_iep_perout_enable_hw(iep, req, on);
 	if (!ret)
 		iep->perout_enabled = !!on;
-	spin_unlock_irqrestore(&iep->irq_lock, flags);
 
 exit:
 	mutex_unlock(&iep->ptp_clk_mutex);
@@ -589,8 +584,6 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	if (iep->pps_enabled == !!on)
 		goto exit;
 
-	spin_lock_irqsave(&iep->irq_lock, flags);
-
 	rq.perout.index = 0;
 	if (on) {
 		ns = icss_iep_gettime(iep, NULL);
@@ -607,8 +600,6 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	if (!ret)
 		iep->pps_enabled = !!on;
 
-	spin_unlock_irqrestore(&iep->irq_lock, flags);
-
 exit:
 	mutex_unlock(&iep->ptp_clk_mutex);
 
@@ -853,7 +844,6 @@ static int icss_iep_probe(struct platform_device *pdev)
 
 	iep->ptp_info = icss_iep_ptp_info;
 	mutex_init(&iep->ptp_clk_mutex);
-	spin_lock_init(&iep->irq_lock);
 	dev_set_drvdata(dev, iep);
 	icss_iep_disable(iep);
 

-- 
2.45.2


