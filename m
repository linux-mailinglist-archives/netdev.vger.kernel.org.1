Return-Path: <netdev+bounces-272288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFAUMi/IxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:58:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176133D4F6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B281A30E08A9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A93C2761;
	Thu, 26 Mar 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="DPbnA4nG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE33C1402
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569183; cv=none; b=K37cTAyyUQK6mXDFuKq5rlzSwPMElYBqfC049SIYZlYA5P6X2uOzqCjDdVFmWrJqIfK6l29HCibpSKRTakO1xp493pERG5xS9z74nIEF4Ho5jKGeKB3O6p8l/fs3dnZPUjlfnAznaNa1wM8S2N/Mj27cSGjlHtBCtpAcoM0LBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569183; c=relaxed/simple;
	bh=hZH6BRv9phkP1JRWpsTKzeYmMPqR853fS5rg7u/t5mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5xL7lxpFbxhDsISIl4vmRSeptlATeTpnpzbZfp2qSm8HvHNoxgrOjBIeOVjxCuL0DxcYPMCaITX1nvkBGJZAGf2acK9X8Pv39rCEVhHJpef+75ueSGpY7Qd6s/A+tpvO1KV3pWzscLMlYr0II/nKvf9aCUm7x/4mrN6N4JRUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=DPbnA4nG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82bae83318bso706596b3a.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569181; x=1775173981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q551GxgjDFWgjkscq/5BEfqm5PgzdOZlRNDDRwdsFnE=;
        b=DPbnA4nGv8JQWPZ5Cz19IWRjWW6XKFVM3Upvg4Yrz4AmGiePPfYiWxcsqQP59X8w1s
         vB98avSHvvgGKmGWie7xhWoeGVBQywpCPEOutdzukYNudggtRbhnUjqaaLX7kdCSQyG7
         tlCxnOaYN8buGKZXTFCkjZy/257v1lLehkDX56vqtf6tru4hXNFwUGCmcsS2Sv41/TcP
         FqBZGIGD8bCXM40WS/pddlZ7Y/OkRmxxACOywoQJpHi8LveTSADiD7pF+eYQvUZCXE2W
         oXOf1t12Ia4V/uP14RmLByScxp+gEmyuFmUdxc59Q3zIBQrdhhqKcU6xzoAxZ5Kv+GZM
         G32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569181; x=1775173981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q551GxgjDFWgjkscq/5BEfqm5PgzdOZlRNDDRwdsFnE=;
        b=kGcWzixqxSs1cfqDHes5sqKEWB6g8hyJbLzO+xujLWDHryqFpvyW5HkOd9D7zthsXb
         N/kuSonI3rR9FLy7gTL6bCBzy6fUtkBk1f/mLz3JpA++alLGN4AE0jPX2WN7wN3vqQIX
         MhkZcafGaWDUkYOXkSWzPCa+LAC/lhPmvzkMMGbRU7Su75mSbzlk7UK4F1ZJ9+daeSJl
         INHduvtdzV1/m2T1+fun2RtKMqMOq6nKKY3IdFD/YZa8iEgQ6d3klL52KiO1FT72yhmN
         UOEfrdiwv3GyG17qOnlMtg3wI4/ECy1fXWO80ybYAhnvKBgz+DXMa3QoVUSVuxUGCniB
         7zmw==
X-Gm-Message-State: AOJu0YxVRo6/B+RdXOJSkVlCqrF8vX+L1PcqO7UBCSVTPC/AyV64mqZe
	gPFBKXSWMlnKwSwR8xQVt4hbi/tlDo5dyFDRsU5kOjHaPe53l299cnzQa+ubC7zN7t6HOTrjd7w
	BE4Zi
X-Gm-Gg: ATEYQzxLyo8JxkZ++pFkAUgl+K1cAGpQJTEyktwcZw3/maxCxPNFkt6Yh3jFkevjdT0
	duqYwmEf2Egu5PGWrCypJL4gcvvgYpxXZyXGKxG28rkUfVeouVh4ILvk7gR8X1Ni2M3Oy4si1FO
	5I/GKrbLm3sr1Iy9DM+ZpGsuLuzaJUOVP9gRkofUCPXtbu1qaxdn4tu+zRjXETNKeFVCzyLQb0a
	stUm+34c9R3uGNnj/Xpi/Si7yx9nyTvQhJt+RKkNqoEtVsbv8Q7KNym3dGYLO7ldg2rOiCt8nQA
	lgn1gJt1gDtQ2TtS8fcukclfp50PnLl10rgwlSUdktufnoZ6NfQhYmuAs2FsvNgrNlZ9iXLJy3b
	DLLLwhz8TNs4cUHQBIXp7fsd+5oL1sPsTBd/4C5xzy6BOEnC9jTk5Sjx3xOadwPlQXdj8lU7VHs
	62Ik0OEcdN2Bf7BzM=
X-Received: by 2002:a05:6a00:3cc9:b0:7e8:4471:ae6d with SMTP id d2e1a72fcca58-82c960ccf21mr300792b3a.57.1774569180790;
        Thu, 26 Mar 2026 16:53:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3d5e81sm3609131b3a.51.2026.03.26.16.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:53:00 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 06/12] net: bnxt: Add TX inline buffer infrastructure
Date: Thu, 26 Mar 2026 16:52:25 -0700
Message-ID: <20260326235238.2940471-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272288-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5176133D4F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add per-ring pre-allocated inline buffer fields (tx_inline_buf,
tx_inline_dma, tx_inline_size) to bnxt_tx_ring_info and helpers to
allocate and free them. A producer and consumer (tx_inline_prod,
tx_inline_cons) are added to track which slot(s) of the inline buffer
are in-use.

The inline buffer will be used by the SW USO path for pre-allocated,
pre-DMA-mapped per-segment header copies. In the future, this
could be extended to support TX copybreak.

Allocation helper is marked __maybe_unused in this commit because it
will be wired in later.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 rfcv2:
   - Added a producer and consumer to correctly track the in use header slots.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2ab588f8de84..9e3a74ce5b75 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3985,6 +3985,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 	return rc;
 }
 
+static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
+				    struct pci_dev *pdev)
+{
+	if (!txr->tx_inline_buf)
+		return;
+
+	dma_unmap_single(&pdev->dev, txr->tx_inline_dma,
+			 txr->tx_inline_size, DMA_TO_DEVICE);
+	kfree(txr->tx_inline_buf);
+	txr->tx_inline_buf = NULL;
+	txr->tx_inline_size = 0;
+}
+
+static int __maybe_unused bnxt_alloc_tx_inline_buf(struct bnxt_tx_ring_info *txr,
+						   struct pci_dev *pdev,
+						   unsigned int size)
+{
+	txr->tx_inline_buf = kmalloc(size, GFP_KERNEL);
+	if (!txr->tx_inline_buf)
+		return -ENOMEM;
+
+	txr->tx_inline_dma = dma_map_single(&pdev->dev, txr->tx_inline_buf,
+					    size, DMA_TO_DEVICE);
+	if (dma_mapping_error(&pdev->dev, txr->tx_inline_dma)) {
+		kfree(txr->tx_inline_buf);
+		txr->tx_inline_buf = NULL;
+		return -ENOMEM;
+	}
+	txr->tx_inline_size = size;
+
+	return 0;
+}
+
 static void bnxt_free_tx_rings(struct bnxt *bp)
 {
 	int i;
@@ -4003,6 +4036,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 			txr->tx_push = NULL;
 		}
 
+		bnxt_free_tx_inline_buf(txr, pdev);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a6b04652600e..751dbc055fdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -994,6 +994,12 @@ struct bnxt_tx_ring_info {
 	dma_addr_t		tx_push_mapping;
 	__le64			data_mapping;
 
+	void			*tx_inline_buf;
+	dma_addr_t		tx_inline_dma;
+	unsigned int		tx_inline_size;
+	u16			tx_inline_prod;
+	u16			tx_inline_cons;
+
 #define BNXT_DEV_STATE_CLOSING	0x1
 	u32			dev_state;
 
-- 
2.52.0


