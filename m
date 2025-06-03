Return-Path: <netdev+bounces-194734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08247ACC2F1
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9032162249
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4B21128D;
	Tue,  3 Jun 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGecfaFY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5F2253B0
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942690; cv=none; b=N24/dMqGO5OiHKq3pBT4RIUKb3zpL21P50v0tel7foNcQnaTPxmoUM2FTgGU+DHMQiJkNVfwf8hKu96OQgAh7MJt0KPzbbKrcRlnCGhoydl2ieCCVfX/pnhVtRpSBeN8WG0Ps9Sr7kB5NjlRn/5/P05e5TsMOVCPdAt/8eevASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942690; c=relaxed/simple;
	bh=owSM7F8vHXZLXocx+EaiBSsNt86oRlcEG5nloYNv234=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZZvhGcWSqrNCkwwdHgNeqIHwFNT+q8MtUNEtdiMmxf3+gMKZqTJxUdT8JKZ8J4OYygFxParDIDBCgp33RxFwdQ2nRN3hqPgl5CyOHp10kt5OdBsbGVlAUETyWvY+QxqZ013qHRcif+nt3/OR+vu8IEC4WtGDKg6anfrWrmqUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGecfaFY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso3263748f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748942687; x=1749547487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/tZIo6xGTOuIe6y1DJ3/MaO2CyACKyhJK1kVHjOarg=;
        b=lGecfaFYWHOGLNppFxyzZkMSZ1k+xXy5YUy5/YP/n7IdS+bzj6OnIZWsphMyaeamVt
         b5WrjHNru3h95SnxnL9HXDeDxEr81WBUI/GbwCPYqN7bfdO1zWLCnFDNgMZbmzYOvIvK
         sKDe7SwW1TVnmQfdTPkvm5vgnF2BDBqWGfIl4MTU5mzWw52ldjwuOwbsFLsqlWtRm8lG
         Fk0AB9qRCodXNlH2awRU8JypZqONDCWC1W2jlpscNo150LHkYq95GgrloGa0RXZMDjLv
         /oHOEGDur/87svXrUUqaTBG53dke237+QBK/8mC7Fcul1wY9y1LgZ7tOCF71RcZc9GAR
         Mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942687; x=1749547487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/tZIo6xGTOuIe6y1DJ3/MaO2CyACKyhJK1kVHjOarg=;
        b=T0PD7oE3raBXZ98oEplDekwxEY/woIqJcYVhLgY/OJMhYbfwcY4QaULrY8ULQYMh8a
         s0CNcXYqSEXSI83VVqly4VYjQ1evgfHj7qLXwsTjDrJ7d3leYr3FNZ4S2rsnEo1EutFk
         I/t1ZXT6S1ZSAvYQphNNHUZiOyVj1+vbbGbIUnnxUd90oF8xyFGCJ1ZapBo94q1hNlB0
         I9t6UtbO2qH12JvnbTCFw6Apkq4aIUcad34AHmRiofg8fCA0mir+WSNfywnoe7bqEy4V
         LV3cCMjozGjGVmo8kN8Im+IH652DdPr1WSQDRGxUa8fKjdLk87WLm6fgR9y4CNapAblP
         IweA==
X-Forwarded-Encrypted: i=1; AJvYcCX/xVpoFAKFdEf/gfyjUOs/jAZ5VPYZMHK+8P765Cevw38dTyeRHOYCQC4r3gYTJWfo8xfxDyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5N2aIsRg1U1qsAuCRUDHTfWHG/sLMlWS7BqdFOE+9qcgenD8J
	BsUFrg9F4aEQTmCVcC2/lLHhFpg8uIhGS6b+litZVho+zEZupa9Yd1zf
X-Gm-Gg: ASbGnctw9XqW4uJe3jjejqYTy/UPY1NZUGPB+tgio1eiUTM7AznGcsNlcypTf6nnjlz
	zLVbturELYbqrH9S+hhIoPC0TFW5FrKJo2nfP+d0188YIIJl1LpxHnevboFupn/eSByiUPtR+TJ
	49FTCFZKovDtuh0cdEsU5wy1JKwFy5pe8Zf6XwzZcCNHHWwQDwRHZWSYesjrVN/b7c0xG9UIOEs
	Z4YlBcplYkgTcK8bw/q7VsShDWr570LmtPGfsgK/BmlfQoTy7c4PumOg9+iR+bs7BL2gwqVWKtZ
	RMBfFbyYkVcMItJ5mS01rySgmkQmV8b64hu9HiZ5qFfrRywNClos/WE5xEXpDDQHpOj1WWGqSSX
	wZI+LWL2jodb325BNKQvWHZyP8StZvDcyJndO5Q==
X-Google-Smtp-Source: AGHT+IGX8k63cPteZizvsUm+C6NovcLNNoamgH3uAig+bA4PoJK9oHl3eKzfePN+J9J91HxKemVCMA==
X-Received: by 2002:a5d:650d:0:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3a4fbaf755emr9360237f8f.49.1748942686820;
        Tue, 03 Jun 2025 02:24:46 -0700 (PDT)
Received: from ThinkStation-P340.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7facf9dsm150184285e9.17.2025.06.03.02.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:24:46 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Slark Xiao <slark_xiao@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net v2 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
Date: Tue,  3 Jun 2025 11:12:04 +0200
Message-Id: <20250603091204.2802840-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent Qualcomm chipsets like SDX72/75 require MBIM sessionId mapping
to muxId in the range (0x70-0x8F) for the PCIe tethered use.

This has been partially addressed by the referenced commit, mapping
the default data call to muxId = 112, but the multiplexed data calls
scenario was not properly considered, mapping sessionId = 1 to muxId
1, while it should have been 113.

Fix this by moving the session_id assignment logic to mhi_mbim_newlink,
in order to map sessionId = n to muxId = n + WDS_BIND_MUX_DATA_PORT_MUX_ID.

Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id configurable")
Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
v2: change commit description including information from QC case according to
Loic's feedback

@Loic, I've left out the mux-id macro/function renaming, since I'm not sure
that it can really be considered a fix for net. Maybe we can think about it
when net-next opens again.

 drivers/net/wwan/mhi_wwan_mbim.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 8755c5e6a65b..c814fbd756a1 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -550,8 +550,8 @@ static int mhi_mbim_newlink(void *ctxt, struct net_device *ndev, u32 if_id,
 	struct mhi_mbim_link *link = wwan_netdev_drvpriv(ndev);
 	struct mhi_mbim_context *mbim = ctxt;
 
-	link->session = if_id;
 	link->mbim = mbim;
+	link->session = mhi_mbim_get_link_mux_id(link->mbim->mdev->mhi_cntrl) + if_id;
 	link->ndev = ndev;
 	u64_stats_init(&link->rx_syncp);
 	u64_stats_init(&link->tx_syncp);
@@ -607,7 +607,7 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 {
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_mbim_context *mbim;
-	int err, link_id;
+	int err;
 
 	mbim = devm_kzalloc(&mhi_dev->dev, sizeof(*mbim), GFP_KERNEL);
 	if (!mbim)
@@ -628,11 +628,8 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 	/* Number of transfer descriptors determines size of the queue */
 	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 
-	/* Get the corresponding mux_id from mhi */
-	link_id = mhi_mbim_get_link_mux_id(cntrl);
-
 	/* Register wwan link ops with MHI controller representing WWAN instance */
-	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, link_id);
+	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, 0);
 }
 
 static void mhi_mbim_remove(struct mhi_device *mhi_dev)

base-commit: 408da3a0f89d581421ca9bd6ff39c7dd05bc4b2f
-- 
2.37.1


