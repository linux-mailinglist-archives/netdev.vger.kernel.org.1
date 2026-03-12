Return-Path: <netdev+bounces-267223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGY+FWlAs2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:38:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA827AFA5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AEA43220099
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315843BD244;
	Thu, 12 Mar 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="WUVjAjC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796713BADAA
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354921; cv=none; b=fjqYyuEDIi8pLoE52Yq8Bu+VesiXSB21j/182bqVBqPwlcsDvXQTfBuDkiEQW262q9gnqEFmFau2k5yV4TFy2VTwSfjyITnExce3egKMydJmAa58W8v04x+epLVLj1wKyKerR/nCB+ZUZHnvrCbDCgbVlI7Hq0Ky1255tDSGsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354921; c=relaxed/simple;
	bh=7Zu0Dz91B8pcyek/pNRIrZNMIcp1uoJ9XU9YtqJIP40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuPtvV1BiQdKNu0mhoss4m+aC7eT5xymkhXP8yCtSwjZQ3gWfcuhiDtDHukC+2LEyzaqTSrIMAzPDO1/t9AGqJ9/PkDD+qLBf8umDdK3d/5yvKc2w9wvTR0mVz1vYyhlHzLd+3Sg8WWZbbsk1ldU/ZI6g8UxsgFfqrGdgXSPnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=WUVjAjC5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827270d50d4so1494568b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354917; x=1773959717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXOL9iubHrTOR9uFk5hJvutezBCpUTAEEHozBYZRA8g=;
        b=WUVjAjC51YCuQPwHHr+wVDiRD0+jdwmT5qoTeRMaPAtZXenJzsZm+xn/PEqPiw7N9a
         X/RS9EquPNeYo+RA4yQE4qFWP9wsY+bN9aAl4C9wqvXrhsVePQBXD0kvg6X1uva6HnOu
         BYGu30rWA23z8MYVoRzarXDFzSBe8OdFiI8Sg/5geeC8N9XXWe8JsxPhzAIVuNczHSFA
         dLpJFFWDS8Lw3CYoU9mqKt2oZI4x8lCe+6nUVeX779ncDyOul39bH3qqpad5BHB5uN4e
         4iNOCU8m1NrvPzWEFlx63515wa/Wxr82rUm3ZOxrQpxIsC8NmdLVWfele3v0KtRONakS
         o3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354917; x=1773959717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXOL9iubHrTOR9uFk5hJvutezBCpUTAEEHozBYZRA8g=;
        b=gaMbxnBVpe9+vOKcCEwROylj57gL+HoM7UW6JMG4M/bxdSLqZsQjCjO3IIkppADE6N
         Z4qHoInNey32j7mCP8CDOXVEKgm1vGmfnxRYg87UCmKgvvZNe+zub6QZqrM/IA1L1TbP
         YLfOd6UTPYFxsydT6q8nqe7UQR1NlypApYMfE3Yxl6rR0XB1Otr/ONcE41l6939ea56L
         pHQFlF+xB9N0LYnQRWWQFLiJFdAAFHi3ry8GRch6jL7LSZ6Sr61oHDuTw2evln6vbKyC
         utYpOFajg0aUhRGpEziMWhA3lAuTJwrRuWAmmmt5pI9ddQKDq4Q6MidnFmAz08bbjj4d
         DR2w==
X-Gm-Message-State: AOJu0YzyJmghUWxRT7wSCvlW8YDZPM7/clM+etLiKGxv30bwtojMMoOY
	mpx4aJFiiweFiDxToj4ZbtTqpIBNOQO0AAaQtvaWnYBvdbOiZwCrTHpuPPN7PfGdtDqZOvna+3n
	ltrRKTHc=
X-Gm-Gg: ATEYQzzyp+WR4QAor/aj5iTtghGiY8Lh4sbxj5qo++NkhINhxmNB8s3n+N8A+Ixolf+
	ldUlYdnxvugGKiqJkduemHxZaB5l3I9ocArSE557NY5MFcgqmHVZz3DC8Hn3wiGlkRg1P14nUPb
	myPkBR5hAXBQhMsvHdCt1CYiTujKZYXphmF9RfwalB6888rlfx69goQjMJsiq0TnjOwg8SGIfUu
	borlH0k/5ovRXKGbkeIqTybBOuWsCq8xws5RqW0xzClhW1YAatCyzGRacBv1anOZopJetyP9D0w
	NuWz3Rqk0zc6FAjfP/rRt9W4FuU0X5RxaycLI807s11GFGytkmeZrBglGYIQGCNn2LyL4pqvx5N
	L1o0C0anM6aWcsS0rqm2JW2X2BZoSaX0UttJKAooIy9LriHVCJ8B0aO2d1PulersXbonJ+tGAdZ
	Mo6qPh
X-Received: by 2002:a05:6a00:9293:b0:824:a01f:6335 with SMTP id d2e1a72fcca58-82a198505f1mr886315b3a.22.1773354917495;
        Thu, 12 Mar 2026 15:35:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073b265bsm4176803b3a.65.2026.03.12.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:17 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 06/12] net: bnxt: Add TX inline buffer infrastructure
Date: Thu, 12 Mar 2026 15:34:43 -0700
Message-ID: <20260312223457.1999489-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267223-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFBA827AFA5
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
Signed-off-by: Joe Damato <joe@dama.to>
---
 rfcv2:
   - Added a producer and consumer to correctly track the in use header slots.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ea8081aeb5ae..8929264a54b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3983,6 +3983,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
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
@@ -4001,6 +4034,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 			txr->tx_push = NULL;
 		}
 
+		bnxt_free_tx_inline_buf(txr, pdev);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a822bbb71146..d9543d6048d8 100644
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


