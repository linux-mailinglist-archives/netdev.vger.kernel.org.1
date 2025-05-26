Return-Path: <netdev+bounces-193435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E2AC4026
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220C217093E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066EF1AF0AE;
	Mon, 26 May 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j09FtY8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6734207F
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265549; cv=none; b=WFUK/7yy/qmZF+RsKbsSRYDlADWoW2cFI6R42wJr87SoesShtWtcs7jPoOmUPXs6PVpbZnzGbL0CfQZfZEqQcMwq4haIEsf9YEOvvJVsbvKHXTmUdIrJrsRxZFfw4TnetIrHqrEBdc7loE2Ja/di4r+It9PO93/b3orR6sLd/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265549; c=relaxed/simple;
	bh=W9pTGi+rchz5yfTfYTvmO0B21Xc07N+NEOUVnjKDnl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdOBJXx7oSp+9wyX2pZNtzLtd+mR+nbadGIdfgVSmi6DS2wKS5mDJjWLek9ehWTAV4wQN0IlHNvRy6XmI6/OvhvCQ/zRICMeflZzWi5TQjrn3/9oDV/M/ND0S3qcMhZaRcu/fcXQ2+dMKUd9U7/XOlfVbCwHQAKHw32mIfiLovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j09FtY8f; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4bdee0bf7so1474815f8f.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748265546; x=1748870346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK132D/77WpzMQpD3jVTt6Sft5YMRphrw+FvxeLVbVQ=;
        b=j09FtY8f8l3tufMx+mwcD2dAkJapQOEY2R2/8BRwISEccgycxp9ZFs+sl7z5OnM/hK
         Nzi4TL298Jm1q7Bgud4lsXpCzgsZNovGrPa1rmZ6/ct5VCUGH9MoDyMf72HrFkV5rnYX
         AM3QD/O7/J7ZeGzCeGwwRVJb/6k0cPMaUqBJrR2PmtOhIw9FNmmzflhSMfmUt3Z9/3Ya
         3y5EGSNf6UUCSO7MY2abRCA5oChtm1Dj5dirKNfYwPAUVRv5OXj8Xj9QBdBd9lw8scJU
         7baQ2zQFCpCsQOoZ2KpsI1hobXV89ZZmDaZqRhv2jvV6hH2qTabQ52bby9MyLgFmFabH
         F+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748265546; x=1748870346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK132D/77WpzMQpD3jVTt6Sft5YMRphrw+FvxeLVbVQ=;
        b=TQMqQw0ZlsF7NC1/uqdT9Wke5wZd7SDREm4/x2o3sAwLPqlLtZsc/qmbSlVBlcyWdq
         Og9xAlivx1gzGr/aSgFjQTzBYCFWI1egoyUYk5nixClOg7WBPlTvpnqU+8SNcd598f0H
         ndSPf2emOUq62PUqx/p69n7s+17ZceTWJgyZersM1UCDFGi4/PBwRHA6o5xpGkwyN2tb
         Iu1xBD5e0XA0s9iue09wp295gGaaRJukIyxCCucVu34kuFy+zrRSHx6rRfV197QiY3Fk
         5sgYmuf3TdPmkvfvSrMa+bwDpMoSOmu+V5m9W78nDcVo47ZeqQAsbGgXcwUH2EzPI1B9
         fzMg==
X-Forwarded-Encrypted: i=1; AJvYcCXN91e2lu2dfRJMpScDB403+fSikBJE06VL7iSjecVc9kLrF5qUk08dcx7r9WrdtyGVlJxYQH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKwLfyPZZNmWBVMkWI/7EZBRAalsKgJl9sbxQnrkb+kOqD5+O
	OAQtQgKchCs0ZEXtxuewjE24SyeSjoLxQE66bcPTZpdjbFa6gtxv+3ey
X-Gm-Gg: ASbGncsUyu2lB4s8JvVClhPCLJwGr1oGGS5kKco1WsmI0D8uRIY6S3fAGdW7CICcgd2
	gWz/97PdJkxvb+v43u159zj0P5Wua9AIL9fBhcQAGtekZoo+fs4ewduuABvbD4EUIUwg9g4/e1x
	pU8uei5NWB9OhUutJDSrciyqHm2AFUa4VwQnLzIu0R1LS1rki4VTaUxM4CuZTGNKjPlDh+HtEJF
	zoPC5INwydBuYjgytG0xBab0E20V6y63/Xu/P67iG1t+nC1w93qrAXY1hmKDFf8Va+tKr9pKEo7
	8BPvgHm38NLhlxQ+67T1+0jsL0RL8SbgLFASjTVIZwQ+uos6xb7VBqeCHc2ZfAm1waw3T+ACQng
	LK0ybC22oahAZtHjgh2LLoBEKpU8GKUtkYeW/xw==
X-Google-Smtp-Source: AGHT+IFTtHtiEUCuqsJkroec4mEacMmLH/sRpL1Wjqr9xlODsoORy9xNhiQCeDrSNd7J9WdVWd9o/Q==
X-Received: by 2002:a05:6000:4020:b0:3a4:de01:e5de with SMTP id ffacd0b85a97d-3a4de01e749mr1387003f8f.59.1748265546298;
        Mon, 26 May 2025 06:19:06 -0700 (PDT)
Received: from ThinkStation-P340.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d2a7a317sm5241629f8f.24.2025.05.26.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:19:06 -0700 (PDT)
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
Subject: [PATCH net 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
Date: Mon, 26 May 2025 15:05:19 +0200
Message-Id: <20250526130519.1604225-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a multiplexed netdevice for modems requiring the WDS
custom mux_id value, the mux_id improperly starts from 1, while it
should start from WDS_BIND_MUX_DATA_PORT_MUX_ID + 1.

Fix this by moving the session_id assignment logic to mhi_mbim_newlink.

Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id configurable")
Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
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

base-commit: 5cdb2c77c4c3d36bdee83d9231649941157f8204
-- 
2.37.1


