Return-Path: <netdev+bounces-109823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77092A07F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F551C20F56
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25536BFA5;
	Mon,  8 Jul 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="2vxJ3Vz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694717721
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435867; cv=none; b=tSX5JEa6tYaT+Wm//9FXwayKoj+tndmanX6UX92DBi4eTyuPl8kkvxRVJ/aLHI0QfNv/szvIoYboA8QY+RTX4gHjANOWVgTM1c3xLVkc4OiOrssGff3koMRqqCWwj77imGBFG9Bg6dQlyGlMs/6NQWGJqMWrbIkK0Q94wdBx0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435867; c=relaxed/simple;
	bh=pTSgzR9DvRckoV8NoG/sy0d9pCkUBQidDY5U3Ug8hLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tmXEs/2BBaLIEmo4D58OlYLu+3cMU1Q+tJIo+Znv3PQTtfPwz9OzbMlsHq3u28gjbNj0JRAX2gcur2OItBEB/Vma4XeEZKyMq9IskZGydMWZUz29MIEXywf97Ay1b8u+JNhgDa7OKX5OExVXJxWtMV9JVY4y0QipVpKdXNdX+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=2vxJ3Vz4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so4615802e87.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1720435863; x=1721040663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kULPnhe5H0eV8p6Bzb2hUA8nz/IDrr4VEwp8cvF3jHc=;
        b=2vxJ3Vz4NceE9iG0XjfPvUV5fbXJtsJ42g0sSd6Wc8B3LeIPnjUfbuPueoD30fdn0z
         D+86xtlLq+pSQbtct0t+EEUUgFENE7wKTxaKn8T0CgPBXOLc6uOU6aB7xFXZV0LGwsjX
         ppzt59fRhvh4KiHus54aEMEja7v/Vu1TL3BrtNKpK49tkWfjSPdrGBRLgHIMn1yjIaTz
         DNeSqDLX3F0vUS+SN8rOW3gbsMZXAkQBzmMiX282cl4uTwkpPOAVvYViJ5TxB3JPtnkS
         GvsKaGS/sCoYvQlGND5sNUmh6DOvCOU78vX2pxwhTUvkrodbZzeMv0yG+vCkECp/B/va
         CRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435863; x=1721040663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kULPnhe5H0eV8p6Bzb2hUA8nz/IDrr4VEwp8cvF3jHc=;
        b=VJf3tF/PMN7aPLe+52rEknOqzw0OoVpdPqggfO0hibSzxi/DxAM3cBRN76VrKXGdE+
         IBCkqxn2AHYJYsOCKRHfg8aPMPCN0fYQIHbVU7pzv1PKF1bBoP4h1dCv4C0Xj+4sqRfz
         EzulZZyili1q23RMpuoqx0P7fH/GShAjO1jkktWHGZTCaoadz44ZZVLvbAg4l3iG4OxP
         UBHtZsGh2zKpqY2weBbUcd/WY66WvllB3zgSAWccFJIRLFbWJ3CS59Jzuo53doFH5Utd
         YKdNqe29zmxiMN1LaLX4Z2EvYXNEWz7vymbjJINYiNlCGmHIf4hEiTTV22JpB1fBsdgR
         DKjg==
X-Gm-Message-State: AOJu0YynhuNWBd/02HXxTZyZWV9YnZDwoNWA+6Pj+yftEydKrw9D9gUm
	PgKNIpxZpohOQW1dZZS+9KGn7JN/U4/9ICK1he55n8iZR8zGkg7jYxYdv/t0ZJktGZK6Cbayj+K
	KEA==
X-Google-Smtp-Source: AGHT+IHzfE9IqOH72vLBFx9zLt05XyVoRPZWtwkeojCC2pfg27d/anjXaIWSUOARea7DyOJQfThYCw==
X-Received: by 2002:a19:8c04:0:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-52ea06a5995mr9250483e87.52.1720435863258;
        Mon, 08 Jul 2024 03:51:03 -0700 (PDT)
Received: from localhost.localdomain ([95.161.223.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea86cfbdfsm732467e87.105.2024.07.08.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:51:03 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Debashis Dutt <ddutt@brocade.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next v2] bna: adjust 'name' buf size of bna_tcb and bna_ccb structures
Date: Mon,  8 Jul 2024 10:50:08 +0000
Message-Id: <20240708105008.12022-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To have enough space to write all possible sprintf() args. Currently
'name' size is 16, but the first '%s' specifier may already need at
least 16 characters, since 'bnad->netdev->name' is used there.

For '%d' specifiers, assume that they require:
 * 1 char for 'tx_id + tx_info->tcb[i]->id' sum, BNAD_MAX_TXQ_PER_TX is 8
 * 2 chars for 'rx_id + rx_info->rx_ctrl[i].ccb->id', BNAD_MAX_RXP_PER_RX
   is 16

And replace sprintf with snprintf.

Detected using the static analysis tool - Svace.

Fixes: 8b230ed8ec96 ("bna: Brocade 10Gb Ethernet device driver")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---

v2: * target at net-next
    * line length fix

 drivers/net/ethernet/brocade/bna/bna_types.h |  2 +-
 drivers/net/ethernet/brocade/bna/bnad.c      | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bna_types.h b/drivers/net/ethernet/brocade/bna/bna_types.h
index a5ebd7110e07..986f43d27711 100644
--- a/drivers/net/ethernet/brocade/bna/bna_types.h
+++ b/drivers/net/ethernet/brocade/bna/bna_types.h
@@ -416,7 +416,7 @@ struct bna_ib {
 /* Tx object */
 
 /* Tx datapath control structure */
-#define BNA_Q_NAME_SIZE		16
+#define BNA_Q_NAME_SIZE		(IFNAMSIZ + 6)
 struct bna_tcb {
 	/* Fast path */
 	void			**sw_qpt;
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index fe121d36112d..ece6f3b48327 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1534,8 +1534,9 @@ bnad_tx_msix_register(struct bnad *bnad, struct bnad_tx_info *tx_info,
 
 	for (i = 0; i < num_txqs; i++) {
 		vector_num = tx_info->tcb[i]->intr_vector;
-		sprintf(tx_info->tcb[i]->name, "%s TXQ %d", bnad->netdev->name,
-				tx_id + tx_info->tcb[i]->id);
+		snprintf(tx_info->tcb[i]->name, BNA_Q_NAME_SIZE, "%s TXQ %d",
+			 bnad->netdev->name,
+			 tx_id + tx_info->tcb[i]->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_tx, 0,
 				  tx_info->tcb[i]->name,
@@ -1585,9 +1586,9 @@ bnad_rx_msix_register(struct bnad *bnad, struct bnad_rx_info *rx_info,
 
 	for (i = 0; i < num_rxps; i++) {
 		vector_num = rx_info->rx_ctrl[i].ccb->intr_vector;
-		sprintf(rx_info->rx_ctrl[i].ccb->name, "%s CQ %d",
-			bnad->netdev->name,
-			rx_id + rx_info->rx_ctrl[i].ccb->id);
+		snprintf(rx_info->rx_ctrl[i].ccb->name, BNA_Q_NAME_SIZE,
+			 "%s CQ %d", bnad->netdev->name,
+			 rx_id + rx_info->rx_ctrl[i].ccb->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_rx, 0,
 				  rx_info->rx_ctrl[i].ccb->name,
-- 
2.25.1


