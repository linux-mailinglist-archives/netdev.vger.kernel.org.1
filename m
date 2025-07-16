Return-Path: <netdev+bounces-207426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D878B07276
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2657D3B3558
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8A292B5D;
	Wed, 16 Jul 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIityDdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A6256C6D;
	Wed, 16 Jul 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660172; cv=none; b=VUOod25eHy0vAPNQU4q35eb3qaEp6kQS6FGIn9/5Eh4CNX0ScyV4NEL663cAREvcaJhHsNR/vawiCiQkAHKUj9tqmsvN5pmvNUAlG1yteUh3uVj07yjukwVP2qe0w182fTafE7DWn96cK2T/ElwMHXli41sOMaBF57J7dIY82Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660172; c=relaxed/simple;
	bh=Q6W7KX29Jk928R1qVVNWD5JXLZbZXkTQ9C5nRhOJYqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWbQQOkielLjPFr7y1is07ovq8FUJrLnWiFZvT5kXexB8R+y/4VjfMBnIdruQioVPk6isnKRAm4KAU9j70kTmAqExVjvOFq5Sxhaq7juYhG5y/tjfyfvNtbPScgMgWL+434+OscpnxJPTb9JcXU97TQIdNk/FXqhtjotShGwTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIityDdL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a524caf77eso665600f8f.3;
        Wed, 16 Jul 2025 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752660169; x=1753264969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8wz/ZahP4wIDUhx29OUaHi7Qy3IKMSy66Iy4Sl+Bos=;
        b=FIityDdL+61H9jCYQ7ThP70f1E0D3BzCRREMio/Z/FZmqrBBP0YqJ65I+948poN77O
         MJWYPpss2JWg+E1vywI7Wpj1PoCOXI/hLq/Pbfw572e8TJSu5/8GkOlbusejvQmkL7cO
         zyCqRID5pt8z9AprDfnnnBEJQhv1NRTkFN5zgmZFOjSw81bsW+JibQLVkzOE9xlRZCQv
         aQb7ZXIclo7zq7nw+ZNvJLgofy0sid/thoH3ucS9QCCvBHgnVWqari13g84QJMvwnT35
         wt2skpAY1aF/lVThxssYEgQx13bnP/jR6noBgZ9OuTmLiQ5JfMkQFzQMPH+U+8pGKgJN
         BQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660169; x=1753264969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8wz/ZahP4wIDUhx29OUaHi7Qy3IKMSy66Iy4Sl+Bos=;
        b=G848GgfIfmL78wDlFcjkG/+dHKE/V88jLPneOHaqr8NVxXK9diZl2lRvr6mTn5fZKX
         e0TrAttzMerss1HLpwAYMwz3Mzwg2VFNIVkTecsGDF/kxaUI2zSpyeXji/hfPBOphfef
         5EYDq39qBW+5332Ev5yccMwL1sPRlDTlFR6VmTOLkn5MrvxQHQqvAPiMaPIsHvW27V/Q
         KTclNvToW5XOvRcJpC4+lcKQp0ZkvL5cRIG9It8qbTH728eESTitLuUI6TzCXpx6Ooty
         H02FUH70ZfYk1bGIrd5NyVOVY+mfC8NafDT4ASoeZvADT6LkD85v0PpakS1xWb0RmwIi
         PlzA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3Gc59fwHG6jTYRklZAwbnR6MnVLemoP7zsGe+OC8cVOEHHcesdwWOvaLorYsqPsgb7G9cv16tE8VTCw=@vger.kernel.org, AJvYcCWUDpVy2aiZRRnPMwgBcx3hzhX58Kv8c55Ffmttw/DeCD3Xa0qC3sZKEa1WTdQpWVdcYPlx9Hus@vger.kernel.org
X-Gm-Message-State: AOJu0YzaN4LEObMwNg+BN5VYPk7cN3Q9zagZIm7wh5vAqMd53E6NQ1sL
	5wFyvYcZG3N/k2HNNaQ5nt1+I8tiE1DQhTYzFiYyJFE/kYiZUCNoXWOL
X-Gm-Gg: ASbGncuR+Axi/vcw/Tp6HN/68k7NAJ+8+YubkM4E24V7QEZ/hXiZKhSCdtneCfoH7RD
	BQiNvmI+Kgtt0KlRm+TcPgDplpxZuxt9dL0NdPiJrSGqohVRM9tZu925xGowhOTvrxyEQqEW0og
	ArVQP7jhabxSLHsq7hc9mnkMMAfsbNv4oWO3I1BG6Ljg8/e8kb4bztpVNrXB7B2Fm/TpCBt5EpV
	WTkDJi59FzbvtA+aT7if4QwFoCxEXn8e4lf95RKKGDQwEhWlQ1jhsmWb1eDiRXQLMn7Ki7Kgshl
	sLTxscbnAUFbiJtkSIOlsFxO3q+DlXJv+XuorS9B27NlXR7z8ckas+PuWPo2S/arhXB7OWtYhwT
	iRDFHxZNCY+y/E8hlLQvvXRmtS0IlzxTQUO4j+9plfiphQznddcU=
X-Google-Smtp-Source: AGHT+IGRmALVudWUgbbTD+N67O8rohnNgtorDH43lpCcRFVuNAi5vwWQyweV7/kSPGRdbZpl5fWZ+A==
X-Received: by 2002:adf:b601:0:b0:3a4:eb46:7258 with SMTP id ffacd0b85a97d-3b60dd892c5mr658102f8f.15.1752660168913;
        Wed, 16 Jul 2025 03:02:48 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:962d:ebf0:4a44:e416])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1776sm17609677f8f.12.2025.07.16.03.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:02:48 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ag71xx: Add missing check after DMA map
Date: Wed, 16 Jul 2025 11:57:25 +0200
Message-ID: <20250716095733.37452-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1 -> v2:
  - do not pass free function to ag71xx_fill_rx_buf()

 drivers/net/ethernet/atheros/ag71xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index d8e6f23e1432..cbc730c7cff2 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1213,6 +1213,11 @@ static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf,
 	buf->rx.rx_buf = data;
 	buf->rx.dma_addr = dma_map_single(&ag->pdev->dev, data, ag->rx_buf_size,
 					  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, buf->rx.dma_addr)) {
+		skb_free_frag(data);
+		buf->rx.rx_buf = NULL;
+		return false;
+	}
 	desc->data = (u32)buf->rx.dma_addr + offset;
 	return true;
 }
@@ -1511,6 +1516,10 @@ static netdev_tx_t ag71xx_hard_start_xmit(struct sk_buff *skb,
 
 	dma_addr = dma_map_single(&ag->pdev->dev, skb->data, skb->len,
 				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, dma_addr)) {
+		netif_dbg(ag, tx_err, ndev, "DMA mapping error\n");
+		goto err_drop;
+	}
 
 	i = ring->curr & ring_mask;
 	desc = ag71xx_ring_desc(ring, i);
-- 
2.43.0


