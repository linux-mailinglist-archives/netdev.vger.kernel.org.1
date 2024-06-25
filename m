Return-Path: <netdev+bounces-106636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 792E291710A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFF41C20371
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AFF14A0AA;
	Tue, 25 Jun 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="Wr33fMyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77E4596E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343014; cv=none; b=u+twfoveNXir1GYhqVhTTLz0XuWLCctSti9V4G86d96O4KQrE2GP8beZCr8AdUGXf/ztg7kqo+rOosP+LKsJ9CLpYL9CHayMOkVClcBrfoC4k234jwiT9svYtVua6yLuOB7kobKtTx0DCSJ/l5M6/Js8MYelndTpraSokZLBGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343014; c=relaxed/simple;
	bh=LCeYdcoowJu6PCFmot56R98QtbDVrtA3XvmMpT1u+wM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KB1skM6b/oHz6lK4cwyzRJzycnRamr7pdz7jGyk0WcT36DNawEti2oEkGTPz+krYZtMq6R3ADceydM20XoiMYjumPZxkR85DpY4b6U4oDa2YglnT6OVvlPNHl7wnxMXsgYIZBP0pzeN1Vg4U75rKx0hWEsfq4/ncX1FFRB0Wcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=Wr33fMyS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so65417581fa.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1719343010; x=1719947810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytKiARLH6PepO6tvxEkJWWRKHy3aqauFi8CS6PXwREI=;
        b=Wr33fMySykpA4r5/28vzVmvH9ObrXncYEcKAXtw0wQMoCRi1aQxLMItKJGCHAxR8pI
         MGqVv3JvF3SbL4QOCUnc14RN3wzO3hVNAjzJ0mEU1hgHgc4VhCaYQmhJfR6uU5WTgatk
         FQR+kpQIdYnSWPBxuszZplTequMue9gvyb1LP4gNHyNGlqzuDMZvEb/rg9EhqZhHLH5s
         fEcJ34wN0ewFzBzR69eGp1b4B03pINRYe5rDBGRmslF+iYKJ8TX63aIdr9kPNcSKZ2xN
         BOfoX/Glu+n8zFbyUKRAlDje9cj4ud3tHtmFeYnORP7W+uYVF0lX5G4uV9sJXBeF+bZ+
         pEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343010; x=1719947810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytKiARLH6PepO6tvxEkJWWRKHy3aqauFi8CS6PXwREI=;
        b=iZujFUG9WKhTn7+SbK6kJZmGAqA929psCjUCMBXn/JVoB/ieLqvso7Up48yABejIWc
         wFT0j3qTFm0bM1eE5VhvXsnUy5Z6N8ose1zUhwXl7Wv2rXvdxnaOWMCqriWPA8dQapNi
         79arnPw8VNUERTpvt9dhTgR8mrvXJnkr4JyqYN7HwVn1kYEMQfGDLxzs+J7PfaF2id2P
         C0Ud8uX6SxCWZIOsrDRfANjSS4goqKCMMHFMML/HUvpZsHsLGQbFyMIGN1+1G8JXLT/j
         RCyHrGKX1BqD57PbLNIqRyKp022VtqsyZAVAJPNbd9M2bYmnMM8nEvlvbgLY3VqqEqvU
         61ZA==
X-Gm-Message-State: AOJu0YxACvaaZG6W6yBwnpccniGxinS3V5XeLH0GUHti7igwMZvspgtO
	sg0q2U0H9VsSQ+y1aC8MjChQApH/eJz8kbJ5xFo9HXx+LdlXHQe+ct1PpMh7rmc1+h83hyC+zaF
	xSA==
X-Google-Smtp-Source: AGHT+IEjeugmzqviQVMnFqJY8QIQNfi9vnWwBSJk/SgK10rsUNymQeM+Y4iQITi8IKrNYk2F9QQIgw==
X-Received: by 2002:a2e:9f46:0:b0:2e9:6e43:c897 with SMTP id 38308e7fff4ca-2ec5b39bcb2mr48307361fa.48.1719343009701;
        Tue, 25 Jun 2024 12:16:49 -0700 (PDT)
Received: from belltron.int.bell-sw.com ([91.247.149.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d600b51sm12870201fa.11.2024.06.25.12.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:16:49 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net] bna: adjust 'name' buf size of bna_tcb and bna_ccb structures
Date: Tue, 25 Jun 2024 19:14:33 +0000
Message-Id: <20240625191433.452508-1-aleksei.kodanev@bell-sw.com>
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
index fe121d36112d..3313a0d84466 100644
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
+		snprintf(rx_info->rx_ctrl[i].ccb->name, BNA_Q_NAME_SIZE, "%s CQ %d",
+			 bnad->netdev->name,
+			 rx_id + rx_info->rx_ctrl[i].ccb->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_rx, 0,
 				  rx_info->rx_ctrl[i].ccb->name,
-- 
2.25.1


