Return-Path: <netdev+bounces-198773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006AADDBFB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCE6401792
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E61B4F0F;
	Tue, 17 Jun 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqazzS8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6E8F54;
	Tue, 17 Jun 2025 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187002; cv=none; b=H9oNkeW4wLe/tvBH2Ut1V+YuliJZaQJrzP1cFSDJ1BUhAqAa2Unb2ke3mKWLT2LCUMwAJ6dH0nm/0zJkK983Zs8Y7coqMmh3TrmihUZqrxuRO0EfIh88L4YlS7tm9s/wfiNVKzPDkZ1O6BEs+bSwAjG0GRjDqP0iEZkzuWSqcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187002; c=relaxed/simple;
	bh=WQjtsw0NPGqZlrAYykaoA04ih9gqLZRnTR2w8Qkg6OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqfM9OgNbltiH9MjPq81ilWYhHiRmSBKKca/IjMwo+n5lWGdTHhmZGOei256rtd32Eftf0iMcWx50HC+GanO3Gv799DukH4YvlgTfr5g+SFwwLGzQ+H2MGhtHTv+cc+wBW1NNMNiueeQZAwEdEXqH/4J0netvAvKmZpCVEVeQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqazzS8c; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso541627f8f.1;
        Tue, 17 Jun 2025 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750186996; x=1750791796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO3mzn9mneUBLNjzsLrlXivcJJ9LbOVSxL2XTHOAkJs=;
        b=bqazzS8cjw8wVy7rPFpETia1j9JuFPepabBkeuiC0LG1Je02Ngh5/cBq8yNWxd27jv
         h91mkw5djEa+ks8NzhWTgoUe3MQ1mHu121I8QoYyjrMcN9IbZjhMXLiti1uaQpgy29aA
         MKpHb/9XuiPLsOCOlFGVH5msXewhgguitMiXnWg9NF9iXeCdGT2cZYjzWwR+rChEp18l
         uN0Qxga1wWd570ZhTRmohQ8aX6e9gD5uZSIYN3pEA5SOgXucTjLlSaKf+yd+Q9nvZOGW
         7eSiClWKWZQD2fCLiuSjXupZwpXXNKKXpVKabnqgC6UO3xFbfRmwVuZQNamKI+leeSp9
         ae4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750186996; x=1750791796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO3mzn9mneUBLNjzsLrlXivcJJ9LbOVSxL2XTHOAkJs=;
        b=U/hbzVvUY1u+KptM9W/3v+AjfD/C8W9LNwRyhnvsNoHPYNWsVWwfskAcTXr0Ftc6eX
         RGHoXELtwZY8C5phQ5cW0HYdHJXc4WRx2Qp3ijC2XFQ9AszJ03bpKdss37XEfEoz27fr
         rc9qLbkoCviyXcqbSqfD+dFE+v6WRsT324mgfTtoNUn9njckvMkB+q7ChyC6McSTShNN
         sAnuePdzKlUBpFs8KsYjSInkiPivgILY4Rx/NjArHaiRHYUsAHKGN0yKMrHK4CLtUwHk
         0Nv84BAUGU1kqjf2hkNOht9PyENSEvHQGug89UGE8BEqPF1CXw2v2JE7Br30ZvM4XWqK
         2BmA==
X-Forwarded-Encrypted: i=1; AJvYcCVU6KFjsasAU8k75SicccmnwrXoCaiy266s5nQWedsXNaFHPom4jLlPDGHjKy3Qfexwm3GM6WzE@vger.kernel.org, AJvYcCWp0pI83aFjpoKG424DKEaUNoYUe7g/sWfCQaraONgpIgGNfREx/VLXdGb9ZdwjNzYb72k0jn0QWOHLOnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GvlUHyoldkchSBTxBp3H5O+lXCNWeXx3GvhuvfJHBhnNaMvt
	TmzBZBw4IdO377FK/1sM+H3dut4n2b9fdN9mT2QihIR8ZDZvvDy8FHRO
X-Gm-Gg: ASbGncuj3wI57P70AcKM1kSqTA3VHRedA7rJdM0a6Qy8GLgzH7hiyyS1jlQXG1ULnps
	Vh2tF34i6OLQoq4648WHcPzphOCoKE+iQ4F1MQP2KHM1z3HQ6mGFCGZXUUW+rCO8nsgEYszqSMR
	mKbFOZyid7y2VIGGZ4vbxWu04/7XsEiOOycbSKNA/KuUwjhkWrCmrNOSSBydgSSwFHr9Cjy3FJk
	544wnQIpyU1R3cKl3VeZ37bnzjzVvl4HHHqizW80FKZrNmAk7Qt/SEeL0zw8MRbpgknpwOsbpLk
	P855c4gfXztOP0tj73GACQISpOgkG7k106GjGfr9D0Cn0UwINMD96prN6UVakznbkQKHdoIqL5v
	Cz4QaD/re23khCynZrLvPmZum3A+vVk9KzCGYQDfuH4qdrJ1rfm/nDnHNrQPnPzy5WlPANuoVPE
	Y=
X-Google-Smtp-Source: AGHT+IGPYOJx3kioh4/Cp5rmSZs9Wa2Eub6qaVkHJvzcap4KstPmLTQfvBIw1iPfY+vo3y+94HhsEQ==
X-Received: by 2002:a05:6000:188d:b0:3a5:28f9:7175 with SMTP id ffacd0b85a97d-3a572e7a00cmr4222203f8f.9.1750186996274;
        Tue, 17 Jun 2025 12:03:16 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec300200c9c87d117a78e.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:200c:9c87:d117:a78e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e1838e4sm187427735e9.40.2025.06.17.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:03:15 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v2] ethernet: ionic: Fix DMA mapping tests
Date: Tue, 17 Jun 2025 20:57:52 +0200
Message-ID: <20250617185949.80565-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3b19f145-8318-4f92-aa92-3ab160667c79@amd.com>
References: <3b19f145-8318-4f92-aa92-3ab160667c79@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing wrappers around `dma_map_XXX()` to prevent collision between
0 as a valid address and 0 as an error code.

Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
Another solution is to remove the wrappers altogether so that it doesn't
call multiple times the `dma_mapping_error()`.  This also makes the code 
more similar to other calls of the DMA mapping API (even if wrappers
around the DMA API are quite common, checking the return code of mapping
in the wrapper does not seem to be common).

Thomas

 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 70 ++++++-------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2ac59564ded1..1905790d0c4d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -12,12 +12,7 @@
 #include "ionic_lif.h"
 #include "ionic_txrx.h"
 
-static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
-				      void *data, size_t len);
 
-static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
-				    const skb_frag_t *frag,
-				    size_t offset, size_t len);
 
 static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 				     struct ionic_tx_desc_info *desc_info);
@@ -320,9 +315,9 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 		dma_sync_single_for_device(q->dev, dma_addr,
 					   len, DMA_TO_DEVICE);
 	} else /* XDP_REDIRECT */ {
-		dma_addr = ionic_tx_map_single(q, frame->data, len);
-		if (!dma_addr)
-			return -EIO;
+		dma_addr = dma_map_single(q->dev, frame->data, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(q->dev, dma_addr))
+			goto dma_err;
 	}
 
 	buf_info->dma_addr = dma_addr;
@@ -355,11 +350,12 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 							   skb_frag_size(frag),
 							   DMA_TO_DEVICE);
 			} else {
-				dma_addr = ionic_tx_map_frag(q, frag, 0,
-							     skb_frag_size(frag));
+				dma_addr = skb_frag_dma_map(q->dev, frag, 0,
+							    skb_frag_size(frag),
+							    DMA_TO_DEVICE);
 				if (dma_mapping_error(q->dev, dma_addr)) {
 					ionic_tx_desc_unmap_bufs(q, desc_info);
-					return -EIO;
+					goto dma_err;
 				}
 			}
 			bi->dma_addr = dma_addr;
@@ -388,6 +384,12 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	ionic_txq_post(q, ring_doorbell);
 
 	return 0;
+
+dma_err:
+	net_warn_ratelimited("%s: DMA map failed on %s!\n",
+			     dev_name(q->dev), q->name);
+	q_to_tx_stats(q)->dma_map_err++;
+	return -EIO;
 }
 
 int ionic_xdp_xmit(struct net_device *netdev, int n,
@@ -1072,38 +1074,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	return rx_work_done;
 }
 
-static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
-				      void *data, size_t len)
-{
-	struct device *dev = q->dev;
-	dma_addr_t dma_addr;
-
-	dma_addr = dma_map_single(dev, data, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, dma_addr))) {
-		net_warn_ratelimited("%s: DMA single map failed on %s!\n",
-				     dev_name(dev), q->name);
-		q_to_tx_stats(q)->dma_map_err++;
-		return 0;
-	}
-	return dma_addr;
-}
-
-static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
-				    const skb_frag_t *frag,
-				    size_t offset, size_t len)
-{
-	struct device *dev = q->dev;
-	dma_addr_t dma_addr;
-
-	dma_addr = skb_frag_dma_map(dev, frag, offset, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, dma_addr))) {
-		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
-				     dev_name(dev), q->name);
-		q_to_tx_stats(q)->dma_map_err++;
-		return 0;
-	}
-	return dma_addr;
-}
 
 static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 			    struct ionic_tx_desc_info *desc_info)
@@ -1115,9 +1085,9 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	skb_frag_t *frag;
 	int frag_idx;
 
-	dma_addr = ionic_tx_map_single(q, skb->data, skb_headlen(skb));
-	if (!dma_addr)
-		return -EIO;
+	dma_addr = dma_map_single(q->dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
+	if (dma_mapping_error(q->dev, dma_addr))
+		goto dma_early_fail;
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = skb_headlen(skb);
 	buf_info++;
@@ -1125,8 +1095,8 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	frag = skb_shinfo(skb)->frags;
 	nfrags = skb_shinfo(skb)->nr_frags;
 	for (frag_idx = 0; frag_idx < nfrags; frag_idx++, frag++) {
-		dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-		if (!dma_addr)
+		dma_addr = skb_frag_dma_map(q->dev, frag, 0, skb_frag_size(frag), DMA_TO_DEVICE);
+		if (dma_mapping_error(q->dev, dma_addr))
 			goto dma_fail;
 		buf_info->dma_addr = dma_addr;
 		buf_info->len = skb_frag_size(frag);
@@ -1147,6 +1117,10 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	}
 	dma_unmap_single(dev, desc_info->bufs[0].dma_addr,
 			 desc_info->bufs[0].len, DMA_TO_DEVICE);
+dma_early_fail:
+	net_warn_ratelimited("%s: DMA map failed on %s!\n",
+			     dev_name(dev), q->name);
+	q_to_tx_stats(q)->dma_map_err++;
 	return -EIO;
 }
 
-- 
2.43.0


