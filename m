Return-Path: <netdev+bounces-242844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D33BC9553C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B833A1366
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 22:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E153241665;
	Sun, 30 Nov 2025 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWR3+ccX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292023ABA0
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764540552; cv=none; b=Un1Y+MIt+HdselIT1oN8rXRBRhjJY79Xj+Fjg9/rbVPpWMh7b3Rp166cEaim1L8+vL4BVldTiwVLai9skXgV/ha2C17bjTLq5w6el5HSVxBSg/ztpixTpcATcd7HDTbfpOKd9VRxLDLN2kBMoAqnTzZk+dFrkjWd0D27h9ydWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764540552; c=relaxed/simple;
	bh=7UyXH1OibHihHsfxK+HIDtkjBuSa+kOQpcxSnt5Whf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDn8ugCGX2rMYz2hVxaGHaigzZXf3+9OzdkQpy2/f8ejJstamt9azbkZFPW/Cjn4k2iDC8wbeys0hIqp3K2qmuxG9s12/fnyXQdeEJjLJerQEWd52f5+mLjIvmHMtQLxprLJdaUioqfB5hHvVWuaIISg0TBza03ADosDV8RU1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWR3+ccX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso4118336b3a.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 14:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764540550; x=1765145350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lY+FYjtGW5ykqh5YAGibXlqGGD5x3PdZ9VnTxQxivXE=;
        b=FWR3+ccXoefcBHHr06MnLH+yzgh11awLuSpZj8Fxs2IbfqFSydFsTu1o+M1dYYxTPe
         JKWC+TvGXRvj6NV6zPUeHIzxjeJM0PbAcO6LBAvqOhr4QbbGpjnhNX6uLLJVCMlYSn8E
         DNS2PLVfyc/mIwOK/E4xGId91rnh1WBtKdIiwFT86Qd2FY3I9kU/QLbAoxczYDDmxOJk
         9tcWzzCFa3GN7QpSlCAvxpsbq3bNBwxgR7ot/5mxpusvAqQ6bVQnnvka4uTE/S9dB4VM
         +hIlhJSvJytwy4Rx3+MAH1k+cq/mIffhdnDz+htKWttpivJTtd9se8i8bwVAFmBoGaTb
         rqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764540550; x=1765145350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY+FYjtGW5ykqh5YAGibXlqGGD5x3PdZ9VnTxQxivXE=;
        b=cgYC6hlYQHeLxRg0/lJifBOZPUBRqHMliqqVQDGsPsf+gARzBAvqxZHbVf8m7AmddW
         nb6waltylUy5DwYTD00X5KNKmIDum4mnMaekeaatYsvaRrzaF/tjHEffVKIiHyUFYO9V
         Jfm9FL4zndO2+VLBPtQOmzqmgV4W0Jrq75nBr1fhrF4YeJsaagGxXHeQREU9t/sXWUyk
         qE7g0x1C5BASIiMs4viIN/0jt57vKhqi0Lj9b4l9TMxQwxs0i5IbskrdBswSZVwkRlEX
         Gf/HJb2CtHjSk/7C4sNrFqwc++3XbGBmxK3lO+wWjEdTZVZONVbVUNPL+LRzwaxvlpsQ
         1GyA==
X-Gm-Message-State: AOJu0Yw1uHJUNuO0rBxaCE5tCk6Kb1rCq19SGUDBf6h+gpEJQyw7JtaQ
	wL2TOKyPz3zsWlN6ktqO1iPAz/uFvq/9FIwZHAcXAOFTTmatnVFvmUXS
X-Gm-Gg: ASbGnctfmhy9PDN7CMINqLt5gY910qQigvHzmQ8MH5krPJ8lTbiV8+ShYwI67q9QqWD
	RZEp3Pt1IRhnlf1ipkPFKj0DRK8BoIwbw4+e74zMsQ/oxvLBPaa/wDW0y9bCRWbVR/ObdidzRKI
	UrYxQLt7G1kgL1jHzI4C+r0AKOjPjTfFH66yLsmn8hbPSRJ4qTXwY9bjdc+P0dvqhw57xCBEGi5
	fQkVTcWt80HdL92BDqg+cH6RZkof8c4P+UtuFc0l46faR0/ISXDAs2XdsdOyUWMY1l5maBwEt3G
	yqxWAYrA77dVHwdn6oEuIPCixDzzjS1sDqBU5pzG1TASFV3+6NLc70gq7LQjLSGBW47AkaqFJbt
	Kvh7V3uvQFBNUHSkp3um+IJJHipU52tRGIfwaJ4WKtkChEkv9gsFoySNte0BM/ZE+YMSURkXYhA
	nFmm0lvfBTUA==
X-Google-Smtp-Source: AGHT+IG9XV6p7fvzODxQnAeD/YIp/e5YYdbUr0GokoWU5aY6Eq553IU6lpwWLkcue1f4C2T7QngAgg==
X-Received: by 2002:a05:6a00:2e9c:b0:7a1:68b2:5341 with SMTP id d2e1a72fcca58-7c58c7a71ddmr32821344b3a.11.1764540549731;
        Sun, 30 Nov 2025 14:09:09 -0800 (PST)
Received: from mythos-cloud ([220.85.157.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm11063183b3a.42.2025.11.30.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 14:09:08 -0800 (PST)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net-next] net: dlink: fix several spelling mistakes in comments
Date: Mon,  1 Dec 2025 07:06:53 +0900
Message-ID: <20251130220652.5425-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes multiple spelling mistakes in dl2k driver comments:

- "deivices" -> "devices"
- "Ttransmit" -> "Transmit"
- "catastronphic" -> "catastrophic"
- "Extened" -> "Extended"

Also fix incorrect unit description: `rx_timeout` uses 640ns increments,
not 64ns.
- "64ns" -> "640ns"

These are comment-only changes and do not affect runtime behavior.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 8 ++++----
 drivers/net/ethernet/dlink/dl2k.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6e4f17142519..846d58c769ea 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -41,7 +41,7 @@ module_param(tx_flow, int, 0);
 module_param(rx_flow, int, 0);
 module_param(copy_thresh, int, 0);
 module_param(rx_coalesce, int, 0);	/* Rx frame count each interrupt */
-module_param(rx_timeout, int, 0);	/* Rx DMA wait time in 64ns increments */
+module_param(rx_timeout, int, 0);  /* Rx DMA wait time in 640ns increments */
 module_param(tx_coalesce, int, 0); /* HW xmit count each TxDMAComplete */
 
 
@@ -262,7 +262,7 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	np->link_status = 0;
 	/* Set media and reset PHY */
 	if (np->phy_media) {
-		/* default Auto-Negotiation for fiber deivices */
+		/* default Auto-Negotiation for fiber devices */
 	 	if (np->an_enable == 2) {
 			np->an_enable = 1;
 		}
@@ -887,7 +887,7 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	/* Ttransmit Underrun */
+	/* Transmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
 		dw16(TxStartThresh, dr16(TxStartThresh) + 0x10);
@@ -1083,7 +1083,7 @@ rio_error (struct net_device *dev, int int_status)
 		get_stats (dev);
 	}
 
-	/* PCI Error, a catastronphic error related to the bus interface
+	/* PCI Error, a catastrophic error related to the bus interface
 	   occurs, set GlobalReset and HostReset to reset. */
 	if (int_status & HostError) {
 		printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 4788cc94639d..9ebf7a6db93e 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -270,7 +270,7 @@ enum _pcs_reg {
 	PCS_ESR = 15,
 };
 
-/* IEEE Extened Status Register */
+/* IEEE Extended Status Register */
 enum _mii_esr {
 	MII_ESR_1000BX_FD = 0x8000,
 	MII_ESR_1000BX_HD = 0x4000,
-- 
2.52.0


