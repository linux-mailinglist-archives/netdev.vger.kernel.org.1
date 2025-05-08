Return-Path: <netdev+bounces-188869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B45AAF1C2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D71635B5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC21FCFEF;
	Thu,  8 May 2025 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OidiCx48"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0A3C17
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675237; cv=none; b=kux+zItAZm5EuBSghrclYI+EmavC7bBYGAwO43Qn3pM5c+GhFcB+TnxlIMRxiizXXIgynuLgaszKNpgyLXiVj9vc1Ub9mCOCxxW/ml69f3gphEooDM1bOLWNwP1yDgiknQu4ljTYLke3zPsds84iM4VMiGZ+wahpW8TQnYo2FZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675237; c=relaxed/simple;
	bh=BhL1JwQyhhSDc/bk8Geq2qyosUjPEu7Gh9M/Bmc6xNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Avrn8O/Kl8E3b04tJpFZvY0OhRsd+oO1e45r+QAooRxD58gchdfqr3e2eTXKa6bLC3L1Jf2umPPVFCW54a20lEd2XY41AGhTG+Ix7VsMPQYB/i5pHV1BgwDjdZKMuqHfGz6RzACUiglGDpt3Ot0f3yGSK2aj9466Ag0N9G1K08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OidiCx48; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22fa414c497so3174995ad.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746675235; x=1747280035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1u3Ux0aEuDRPRfhGSL7KiSmBbe98RsbxmilJJ1kRyE=;
        b=OidiCx488OTXzfS4PwCDPVqCrfV+uDjpjHg6Qls31w+yq3+o3CoLza654AX7WcZuqm
         Yrd1FzCbIOzTCG6YGLYVR45EAU3YRenoOrQAGNfoYMm/Hju7TW66RwkBs99A92wzdC2d
         yJWdN7GutBLfvpaSX0ENnAX5DE7sOrhzu3/TbHQIZfY71UwLgf6Nh9RO61MKMfKdHQk4
         GR8oHPad5X/TKnjIhnM91wMLcGF09yQOuf0tkesAsRhHxBalvVitivnDpzvSBj73v7W7
         rlHsjb6IgLKtojkrL+E61VorWIcG3glwJmpcFBVtfdvxWrW44f9w//fyj1wKPSkSM4qI
         qrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746675235; x=1747280035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1u3Ux0aEuDRPRfhGSL7KiSmBbe98RsbxmilJJ1kRyE=;
        b=jxOH2A0sgeD6CsnOHmEq+/YRPS8HF8RAmh7W9vvtrT1mlkbgf7y0jZJPQa9/hTXWt7
         5Lqpi7aQGTDyTEBNvZICJ0oNtbud/flctjcBQfW+523x8GOoUDEeLAWYCv4SN60Zgnq4
         Ya/ilcc24sMmMrHsYHoCodfhZPWBNe/HAkDAbh7ZTG9KEPGlvGJAClWKE+JtgGk8/wPl
         iNQaMyXcc9aSBx2oV0Uvq6aVYLdTX7cimLDFWaw8jP6c/5mGPFNLiacxvqta42ZKuijE
         hSlENxYk8iDtyLQVN4bzup9Hfb4S8a59nzYs94it0ExPdJ9vRCCiGP2GxFNrCkALfu3q
         F3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV6C35GNoIRAfI5vpfTasjYWMYTCsdhSI7g4fxOihWslZ/upxsEdDjB3HQ/gfINdhmeMjwt9y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNZldqVqD7uUdFlB+Atv/DzJukhLM9LoE9nEheomd+ONXWW2y
	O6rDG3LI7YUoy4DN6iDCPC9cV9g7c5hsn1Y9yHre512Zx3SMb4+x
X-Gm-Gg: ASbGncvEx2ev0Nent1OFO6Sn1h2JmdaWcppLSPxqKdtJzmeK+ozzstT48Iyf6ARXcnz
	enacQyMffnabsaJp3Ru+tAQ1Nluwk2psDrEtWJL/AfbBnlOirHI/i+151CCW7NRQHLD6pk3EvoQ
	PQ0A6wt8AxuB3elW+M3WMTs6uLvKZ52WKlo8C20nYyxcOjMAx2Ca42w1pyTgdijtXP2B2yMpnzN
	Qn6GoEPocNgnHMiNBHaVLWHqzLEcu75cT7HH6goNzeyyjfcG0kxTieghrj8jt0gtYxhWS05+Tuf
	r4y3Iila8xoaAnHTiJtJB+VcU9VK6lB9lXuJgezaZ5cSvEdLr9NKpPgJM9T71mXsnMN0ghHnJzA
	QdZ88aZmd7I2O
X-Google-Smtp-Source: AGHT+IFm+mP1uGj09z6Vf18f5gYApeZ0IE75maU9iP8Ml38OuYBrOos4wiBaafguyI66pVfIF9OMTQ==
X-Received: by 2002:a17:902:c94c:b0:224:de2:7fd6 with SMTP id d9443c01a7336-22e5ecc39demr85915235ad.25.1746675235094;
        Wed, 07 May 2025 20:33:55 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ffdsm101685265ad.179.2025.05.07.20.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:33:54 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: irusskikh@marvell.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sgoutham@marvell.com,
	willemb@google.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v1 2/4] net: cxgb4: generate software timestamp just before the doorbell
Date: Thu,  8 May 2025 11:33:26 +0800
Message-Id: <20250508033328.12507-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250508033328.12507-1-kerneljasonxing@gmail.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp as close to the doorbell.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c                     | 5 ++---
 .../net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c   | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index f991a28a71c3..ee5075b252fd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1533,7 +1533,6 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		q = &adap->sge.ethtxq[qidx + pi->first_qset];
 	}
-	skb_tx_timestamp(skb);
 
 	reclaim_completed_tx(adap, &q->q, -1, true);
 	cntrl = TXPKT_L4CSUM_DIS_F | TXPKT_IPCSUM_DIS_F;
@@ -1717,7 +1716,7 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	txq_advance(&q->q, ndesc);
-
+	skb_tx_timestamp(skb);
 	cxgb4_ring_tx_db(adap, &q->q, ndesc);
 	return NETDEV_TX_OK;
 
@@ -2268,7 +2267,6 @@ static int ethofld_hard_xmit(struct net_device *dev,
 
 	d = &eosw_txq->desc[eosw_txq->last_pidx];
 	skb = d->skb;
-	skb_tx_timestamp(skb);
 
 	wr = (struct fw_eth_tx_eo_wr *)&eohw_txq->q.desc[eohw_txq->q.pidx];
 	if (unlikely(eosw_txq->state != CXGB4_EO_STATE_ACTIVE &&
@@ -2373,6 +2371,7 @@ static int ethofld_hard_xmit(struct net_device *dev,
 		eohw_txq->vlan_ins++;
 
 	txq_advance(&eohw_txq->q, ndesc);
+	skb_tx_timestamp(skb);
 	cxgb4_ring_tx_db(adap, &eohw_txq->q, ndesc);
 	eosw_txq_advance_index(&eosw_txq->last_pidx, 1, eosw_txq->ndesc);
 
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index e8e460a92e0e..4e2096e49684 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1640,6 +1640,7 @@ static int chcr_ktls_tunnel_pkt(struct chcr_ktls_info *tx_info,
 	cxgb4_write_sgl(skb, &q->q, pos, end, 0, sgl_sdesc->addr);
 	sgl_sdesc->skb = skb;
 	chcr_txq_advance(&q->q, ndesc);
+	skb_tx_timestamp(skb);
 	cxgb4_ring_tx_db(tx_info->adap, &q->q, ndesc);
 	return 0;
 }
@@ -1903,7 +1904,6 @@ static int chcr_ktls_sw_fallback(struct sk_buff *skb,
 	th = tcp_hdr(nskb);
 	skb_offset = skb_tcp_all_headers(nskb);
 	data_len = nskb->len - skb_offset;
-	skb_tx_timestamp(nskb);
 
 	if (chcr_ktls_tunnel_pkt(tx_info, nskb, q))
 		goto out;
-- 
2.43.5


