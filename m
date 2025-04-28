Return-Path: <netdev+bounces-186407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA1A9EFA2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7037A7DBA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101225D531;
	Mon, 28 Apr 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+mRwypd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BE1D5159;
	Mon, 28 Apr 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840965; cv=none; b=MSuY19ops33eDNjwGjkLnyG2AlB/x2D3FVU/docU7bHuLYMkQfDk5jdHofgd2GoSFRs3m4emDNC3T1z1wcS6Xu4z+QIOpHthlXJ0QHtz1YU2Ubm+i1dfT8rUmB5nVyvZHXhhlgYmsft1F3/rt3S4/7iMeTEIieYyuVXbibQg3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840965; c=relaxed/simple;
	bh=jeflkGq0qH8lOe08zXAdTH5Cb0fn+LVq1YaHKvNXQdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZ4PdxzmT7T3OPGVBulaaFVA+Y9SQk+M2/zqyK/Pm556Daa+SboduDfPFjI8QRM+w+jDpYDUqpvRDBjv4hKQmj/1TlZCiNkm+0aD9EV1pdq4YP1O2FTomY5E1ILP0AWYSOSM5PnfFhqNjEg4PfTd9Whp9AvLra8sAzBBxNz5Fk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+mRwypd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25520a289so729590166b.3;
        Mon, 28 Apr 2025 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745840962; x=1746445762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fw4xjFZAdBbyC0mRULT4rScVCberjFeCCRxE4Hm2z8=;
        b=F+mRwypd3Pt+tPP/Ez0p8osnZd7wNHBoGHHkJGOf5zm/9t3x0M49OeTZiYwmDy57RV
         bW+P2/kzpOioFCL2a7lPigt0Nw1obxCs7xmigfQJv49VH04Xuzao197zgcyL0pQv81EU
         /9b0TCiDWMmBrL1sU8W6kfZ0ZKDJWh9jdh0ZmM1E6o/b4vikzz6YOCNAv+6yJu7Ih0kR
         H71XUuYZRZYGuuvq3cySdJLLy90ZRKV9B2t5QYoxs0HSculYTYviI1SOCzYXaLpTJteG
         i63CS2Bz6T+VHaBRmxqhyDkm/txO9tdGl44CIsIeB8eqpiSTbO56TIGVHL+cfdRw+WwF
         EdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840962; x=1746445762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Fw4xjFZAdBbyC0mRULT4rScVCberjFeCCRxE4Hm2z8=;
        b=InAEl+9ftA/NemBfL4tpJSLr+p9LJD0Myenl3iYumenkssc5+Z8FI3806j3xtdZ0Qf
         Okoh31U+D53Z6TSNF5e9q2wE5anIXHyey2LNOoSwhFt7SC/l+/wutJSFsNLm34sTmtSW
         FRQBbHpKwcjs4GceXDMD7OHQP8tR1QIX/5oJkuQ7ml12UhfoGJiPG6gnNsvBA7k6IfOw
         Nl8boMXWbDbQNIwR/E3VLtvih1tyDllheRHblDS8uIuHDsZWNE06ekM75ecQHwBSh7HE
         rCA8zhgI/gWKchtHjt6tkc/Il9s7ytQjKaHlMQ0yVFZvPXAMAk8hgZimeWUMzFKY/KfV
         JEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOwPEDPj7glEwm3HWEQ9BnUju9i16nGxpXtmnlNGJGQPsTE3L4bEwRMuosJ9A3Jj78VsP0N4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMJLRyTszWd1JLfCRmP1u0fWoSYxs8SDi1TRk0GkCGcqrbO14
	GurFj6Gi6M0UXvE8ASOI3WN1ldyqKykzNOLYAm9QJ0riottG906D
X-Gm-Gg: ASbGncthEVDZntqKbNE2FnBwOrGh4fXAIS9wv4HmDRuZBztJ7Eu4fAoBFV1Rf4kuHvi
	1daZVmA17QNEcSysIQZzDCsGFMlpK4CAGu7DKmItUENxE+r30moJl2pt7l/LWReha3l8TcbFo7h
	yCD9JWYD6wGpE476ZfkAejAdJD3xUw6BIlJfSOste2F270r6QViRiHFC/7OYkBGwHX0D8k2PYHD
	EQcpZBvHFUPN4OPb2zzqZklq5br852iy4aI5bOxbvLscj6OLoMgGUm45zSpHstDNAMJSmiZJZvB
	MWLT4R/fEOyBOwhBeYvSGD+VOaE12O6T9Cyuvr8wkXABJBc3isOQpRtHrCxufOz1MOttlbczZz7
	Mwynlp2RQybWZ21OssDq02T8u+BY6aRbs/ln6j9TZa8C7mcNt3w==
X-Google-Smtp-Source: AGHT+IGMkMZhPQEUL9Bm1+pzKjElvCTygn+009wgdo/10aysQGZ/UaVVKIIE8lqbt2SFzt2k7sxy7w==
X-Received: by 2002:a17:907:3cc3:b0:acb:34b1:4442 with SMTP id a640c23a62f3a-ace7139ce4emr1158741866b.48.1745840962184;
        Mon, 28 Apr 2025 04:49:22 -0700 (PDT)
Received: from titan.emea.group.atlascopco.com (static-212-247-106-195.cust.tele2.se. [212.247.106.195])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbb6sm607951966b.28.2025.04.28.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:49:21 -0700 (PDT)
From: mattiasbarthel@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wei.fang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: [PATCH net] fec: Workaround for ERR007885 on fec_enet_txq_submit_skb()
Date: Mon, 28 Apr 2025 13:49:20 +0200
Message-ID: <20250428114920.3051153-1-mattiasbarthel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattias Barthel <mattias.barthel@atlascopco.com>

Activate workaround also in fec_enet_txq_submit_skb()
when TSO is not enbabled.

Errata: ERR007885
Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out

related 37d6017b84f7:
("net: fec: Workaround for imx6sx enet tx hang when enable three queues")

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


