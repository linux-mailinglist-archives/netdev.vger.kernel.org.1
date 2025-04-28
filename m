Return-Path: <netdev+bounces-186383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF39A9EEA1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDF7AD9EA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB2264627;
	Mon, 28 Apr 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcJlintl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC0263F4C;
	Mon, 28 Apr 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838628; cv=none; b=miMJq+ll6fLfW2zhO/lH8f7Oz1z0KruZ3Ctgfb2M4WL/ZgfCvjiX8hq8DEvxOeAsHBq2/1x4aT1y2FML1DJo5E4Wl/zFUfBoiqn0p8LRBvQwbHdp60EQ2a6+ERsHUiyQ1gOtECpIoA/tIZWAC4FJfu/dCRV+eq4FG9ELoUVkbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838628; c=relaxed/simple;
	bh=bIwFZkm38ynM7HX1Oa10JXlzhPJFAfh/bhhb1iyC5Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzZEaL5Flo+vdJ0j4whr4EMgxve9lfGnbWLuOCM7JQ+ksMhSlWIlXDKTVuNJA2Nq6JngBs7x8X5RF3cVFuZjeWmnFQ6kzDEzb3SMXTcM0kb635UBw5rmF7BECNHrogQD9tNCNldew5YmzNuTGQksH46amuclacCFj2un9/3JhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcJlintl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso7180120a12.1;
        Mon, 28 Apr 2025 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745838624; x=1746443424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEPaEW3F/zxdw0Y59OhNfESRd9ryJ0bqx54YjVSlNEM=;
        b=ZcJlintlA++R/TSYw6ypXpDrXKD6ZJlYhQR/xt/exSEUjJkq+Z1pNsolCHYvKon4HC
         OQaJLdVGGNWBgBeRS2dskk5ssykSjzdTzcxLrL1IEJTVacjR4CH8M2MjmX0NpesNgPqk
         4kegSbGYBX5akiv0RsH0HJyE5apHo7kOaBpmPgmOHjUcakrJLWFZvbvyYaUStqz5PxxI
         jxBdXJkjr67p/8UsZjThzo7zEWi7E2yCeTVp8TW1ouxyOc0Rkqn5Y5TzW6zJRz+FjPpu
         rHZzSw2/V1IiQv4Gq2BvQvxAWttcU5ALMvqlRcAo1ioK6xH5npjhHe+fvnhRnYfTLNf7
         yH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745838624; x=1746443424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEPaEW3F/zxdw0Y59OhNfESRd9ryJ0bqx54YjVSlNEM=;
        b=DmM9hJPw+BUJYF045Uy7ZY6OIv4AxA3dhnZJWWpA573lFS/O84dR2EpVUdOa8xz19L
         u0wW38IYLcRKHDx9bK6AdJt4btnm3n3iMH2AoZU4X9owSx9iFg/RTCVPIyz+rM/q0UAm
         kqSAtJmpwJ/mtTW5RzZRcSNviCsu25P0OQaDpf49nUykOpAEbLT/SvUoE1Ma6KQJZvTr
         MP9w4z2W17YAVE/EZjJzKSP9JK+PwfXAGvSHShEXwQAYwRnkaw6y7g/JUde5zeT6vdJz
         S5b45U3FRkD3c9UnbjFHydGizcPG17eMJ5Z/73RogjbYjxvnD9YUItEz/rmlPTAjQngX
         ZnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfH6/W9egzKn6U4ty6J84L6L68j1YY4ttEOQ8vJOoNAN/r0lEAbetnxAR+4v1rApwvXUwVGS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrw+rsPwDSSG0S3Kih398271Vfj2juZo/RUx73DFKkyZD0qOh
	2CFOJlkd5fVT/EDNrUkDw9PwnH4RukVtlehb3J2iqy6KGvsGlZoG
X-Gm-Gg: ASbGnctjJdAU4R5acg7np+mpCpJKS0fUK9K7WF6db6GPvu89SoQxDewnL/IhYnG0vUT
	iD339dN+axQ5BwD6Gkfauvo4Pm0Gpb8IgdUad5/SoabM0bDS6KcsdIO86ZPX0WetxxLbf99dQDB
	ErhdTBpMrIO0IUeD/drz+59dZt5ps4zBJOIESI8+h1LtZvW6Cd13B4t0pPPIEvLZGc3UzuQsEEr
	fbhOp+R/yoxdMIVzRQLgnL4rflb0LRyLQEbTiOMCi6064x5O4C5po4HNHgYv90MyglcYCBxK5Vb
	kFbFgbOYRP3Tq9iBNhd6ylm9SEkHmsejRhduOzIqO3DAa5PgpvP017s7csldrS0yJ4RHGTylNcw
	tnhF6f/w7GmWJO65oevyeiCo1jL1chdABUCWgYXM=
X-Google-Smtp-Source: AGHT+IGm+R3U2ff1WmMOdGvIBe2V0PqlZpnpHbbBT6HmOy4sjPS3TwTCnqN1mgE4aPVMMPL6rw7qdA==
X-Received: by 2002:a05:6402:524f:b0:5f6:c5e3:fa98 with SMTP id 4fb4d7f45d1cf-5f72343471dmr10240290a12.27.1745838624398;
        Mon, 28 Apr 2025 04:10:24 -0700 (PDT)
Received: from titan.emea.group.atlascopco.com (static-212-247-106-195.cust.tele2.se. [212.247.106.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f5dccsm5686131a12.37.2025.04.28.04.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:10:24 -0700 (PDT)
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
Date: Mon, 28 Apr 2025 13:10:18 +0200
Message-ID: <20250428111018.3048176-1-mattiasbarthel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattias Barthel <mattias.barthel@atlascopco.com>

Activate workaround also in fec_enet_txq_submit_skb() for when TSO is not enbabled.

Errata: ERR007885
Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out

reference commit 37d6017b84f7 ("net: fec: Workaround for imx6sx enet tx hang when enable three queues"),

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


