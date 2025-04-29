Return-Path: <netdev+bounces-186695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB29AA06A8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6423F7A2814
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550229DB7C;
	Tue, 29 Apr 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTWyLcur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E31F416A;
	Tue, 29 Apr 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917711; cv=none; b=ME0QZeHD0WTFkyKnRot5SGv4+jKOfn5P6LRtt39e0lDKpFctm4gkk5yZldK1K/BM90Bq9hkvjfjnkCSIdPPG54z3g1yg64Y5IxkX4+5w4vnbJ96TNQH+UZMPUp0t3CipH0IF7NRyWJxT0p4cz9HOceD4pGALrPlg25qP0Z4iG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917711; c=relaxed/simple;
	bh=7tKkj3J8Tt+kCDm7+jBhWB+A/hvph8GxctRTX3yGEII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lA91r8headcg24nVpoAbIEWXdnZbQB21rMCdf0l3rozU6xUOiwub0D4Kk5SYGTjAJ+f/cxHg825/x2amaUE1U571FYDY52nq386rd3UzzKwBLeKTeesaAlUxmOV4ibx5fNEwMOdDvLn5xaVL3XQpiDr4DfP57FQd/WgmF9haPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTWyLcur; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so7514657a12.1;
        Tue, 29 Apr 2025 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745917708; x=1746522508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUz53Saw6cMVXBIDBX+3gyUruKRB/Beug22u3wURK4s=;
        b=FTWyLcurHOP0O94CkNppG0JiPqhZ0v6aN4pNlhOilbSit622gB9fOA4dVVew6xJQxb
         19zWN5M05LoC0poJJn2APp6X0a0NrtcsppMTw3FAZofWEiVAtnE3d3y8TTVBsXsr2DqY
         ZEglgronFFOezWdp273Coe3HH5IFIbb/hiisCz26zObjzaDxHvssimnjSllQDQjEAOMp
         KqJYMHHtq+CaG6+gkFq1VrkRrqjYLstYbBbNhpIiJ3YQ3BxyYpV8jgLOp3pp/t3++2oX
         QuG6saBcObAgP+pYPwfvdJj17y/D8Pq1rDE7F7yEf6pL6BjCiTdfSUpN0EmB52ufNPon
         TtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917708; x=1746522508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUz53Saw6cMVXBIDBX+3gyUruKRB/Beug22u3wURK4s=;
        b=rfEU0mAi2Eioiq4hSAyRIEIuWLaFMKuIlNU8eOD/gOlzFNxLnxy92mpYQYZo+P14tW
         ROTO5fTylwrJM/HPYYsogve3nq+5aHX6E0H3SvOP49TM3j1C0pahoBtGjt9MuniaqK68
         1fjDDZLRKBb+PRKLf6ysolLvmCkrddAVeV+7ICKOV2P0P3ouFLUR1zr8fMYEAWWNx/I+
         Cv/jQfmHbTbtl1oE7DICNDfLD7paT8ZuJ1Ewz+j4uzUUayghgHIMF+1WgihJZFO3R9rn
         cdolAhruRNajLZFSDzTkKgRjvd3OWw+iuMY//s7AwsWFFSSDXQS0r0be8UBtXXk5j+tE
         bmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH6OxIdEUUglC1JrQPzPyFR6bHG8CN8L/SrEnyy35Z4p86nAQ5KTzmjHZe4ug4YNMGyttNjjFd@vger.kernel.org, AJvYcCXsYMWp0Dnq4PJu6vYKfwACP8CTmOVrcOjZ7kV9KVySU0pbjzEsqtGSsAJif3nA/M1Ee6Lx41rcAd2Dqxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GnhFaX8cts8LsKq3sHY9A412bDrxWjbtzincYC2L9hinv1M1
	PB1kkE6QsnvsC/GsxNzZTaqecv1fLxH+RcsTwbuLNsJA9j78rAV5
X-Gm-Gg: ASbGncv/9+OK5Letn2U5HSXm7mkBxb52mJkKIS3mcm2mm3YRcE6tW+I/PARV0cVMpY1
	pULPBf/fE/AIds5GuAb3HNMfqAjzv3HaijPioeYjEJgPKqvef3MSKKtbiETHKbew/gU0/WuauND
	0RHdoe2KXQ+hAB29P8bHKP0/PCoYahi+uemE1tU/fd4IgRkHA6wAjg0FSMFPoSP7IGO0P9zxYkW
	VvyWik2K8Ojv86uXRkdF66E73hirUIQqaY538Kx7XMbFBZFrY7Cu0p6Wl07TyL8TOOk9IWhJJNE
	Z0hG/+r44G7D4Fs7RxftS3WTXpfN0sutrMQLqfIuRPwUmogftNIHHLurVfj3/gXoAZOt0Gecek6
	nIHu7U4NIU8gI+Z+4qwBfORQrVnSAmjvSC0dC/tk=
X-Google-Smtp-Source: AGHT+IH0x6YL+2cpf45cN/k9GbVeXNWiPGIKjy2ZeOFTUUYtd3wRJNwtsQ+bN+GZ2H91QNv6Y+XNNA==
X-Received: by 2002:a05:6402:e86:b0:5f6:c4ed:e266 with SMTP id 4fb4d7f45d1cf-5f83884b6c1mr1945283a12.8.1745917708122;
        Tue, 29 Apr 2025 02:08:28 -0700 (PDT)
Received: from titan.emea.group.atlascopco.com (static-212-247-106-195.cust.tele2.se. [212.247.106.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f5dccsm7144159a12.37.2025.04.29.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:08:27 -0700 (PDT)
From: mattiasbarthel@gmail.com
To: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	troy.kisky@boundarydevices.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: [PATCH net v1] net: fec: ERR007885 Workaround for conventional TX
Date: Tue, 29 Apr 2025 11:08:26 +0200
Message-ID: <20250429090826.3101258-1-mattiasbarthel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattias Barthel <mattias.barthel@atlascopco.com>

Activate TX hang workaround also in
fec_enet_txq_submit_skb() when TSO is not enabled.

Errata: ERR007885

Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out

commit 37d6017b84f7 ("net: fec: Workaround for imx6sx enet tx hang when enable three queues")
There is a TDAR race condition for mutliQ when the software sets TDAR
and the UDMA clears TDAR simultaneously or in a small window (2-4 cycles).
This will cause the udma_tx and udma_tx_arbiter state machines to hang.

So, the Workaround is checking TDAR status four time, if TDAR cleared by
    hardware and then write TDAR, otherwise don't set TDAR.

Fixes: 53bb20d1faba ("net: fec: add variable reg_desc_active to speed things up")
Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a86cfebedaa8..17e9bddb9ddd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -714,7 +714,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	writel(0, txq->bd.reg_desc_active);
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
 
 	return 0;
 }
-- 
2.43.0


