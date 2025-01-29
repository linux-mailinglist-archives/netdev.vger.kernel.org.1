Return-Path: <netdev+bounces-161548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91665A223B1
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF321887AAD
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567981ACEC8;
	Wed, 29 Jan 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J8WJTv1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD91DF749
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174521; cv=none; b=Fl+1J7yvwOvJHEzqn5MTenRzni2kT+s6vLWeO8PgcQ++XVKKnQIbdD9eP0Yengc/HfeDURQ1DgRxvK4/x7hj8yN/q1fsZb19UZTIA4Kram3TA0SUAq0Ta+KJ6dwPcRn5Tr/SZZ8C457hzW9Fb5SS7UCuV0Rs6hREc94nQQ+x884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174521; c=relaxed/simple;
	bh=wCFnbIIybuKiwpXxrJcymmC7JymqorEFQQf8dYEqH5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNC+0cKk+JbPSXAsvuYOBpN1mufEq9iL2yqF/xLtqhbHwTqM+err8nEWkou+F+XI+GlBptnldRnFWYQDaQxNbZWsvGpxw4EBSZE/G/y36QoRJzPOOhgKix2GCUoQtHcJizfLzRNYZ/moESd8xvC5rPw6PsuZ3/GggNQQVCe9Qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J8WJTv1l; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb8db8ae9aso2826151b6e.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738174518; x=1738779318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73largg9wahTKmlr8ZZdxSEO4OgWDT1fPbBkex8RVTQ=;
        b=J8WJTv1ljKT6QwrWr5FBslVnBajKXTmKNzBOmjBlbZ4juSX2b3OlF/qNvfy28DC3C2
         GSrUC/oT7XILVyme3xSVxJEqg+Rx/qFAZwds75hQQE74T+IcP7YaEOo3Jw6AMcvbPu5a
         8Fte/vmYo8APJeesvv5Y78aYhSk5aN7o5zDhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174518; x=1738779318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73largg9wahTKmlr8ZZdxSEO4OgWDT1fPbBkex8RVTQ=;
        b=g6kA5G/Y9Xh9ue9HlNgbxYpK3uquIa76a38A98sufjDjMtu1hsWiZelhUwPSgOs4D4
         FGxu3tSaL6hrpq3qJWLbZisEmuUyRzLLiIc1KUDZAVEewQJTp8yFoHx5yqB48WrHilZJ
         /pIWvG6xWNsb8biRT6V+smruUNg6aJzjF8smhrNLpKUawNV48p/7T+whTngP+y0dwu4r
         330TxdqaC5dGVTjySrMWUahzGu/YLeaNailqWIFjxQ9lO2c1ELvOJqwDIEStfELb1L5r
         qVx6KztjJRDcZ/oK/4Xfy1s6IPJZ57mxorEn68PnrQdSSl7X0Mu8pf3VU15kpbm0JFA4
         GDXA==
X-Forwarded-Encrypted: i=1; AJvYcCWWJpXc2Oql1NvTe2aMqW5R9iaTA3LpbSJ7jVutK7IuKJHmtttT67ZCvLMQIFG0u54SYVPH5XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYcAzqCXkA4NrMK2JanWSbCPk0xSU+QbzJZ1qb3sUOYlM0ogn
	0/n66sBtzf1VHU5Q5STDrAegazrGfsGug0tdjjDYBpBQr+b0QRLYQlC5hyUbzQ==
X-Gm-Gg: ASbGncvuA1RkIAO1C10oAcE1Vk+Axrii4LEoChOQDKy+oGNsVH7QRqP6ORzpaK2AAWV
	6QGfYZVL8kNqmiccA8ZgC3PYc95HgLrRjljlCOUgIUVLdR9Rq60IBQO48gjPOLni4iLjSc6huxk
	w6CoFrrlvmdr/Z6ivZIWob+uCw8pXzydhAmQSCp3k2wiofhgC0ew4pAbx6/LxbRZ42J6nlGVl/r
	j9LOear3HMqCFN7Mph2Cjlw4/ge4tb+Olu//nkAX1e3b3OWjlFNMQLDV6zRhA+wupUBVe0WpzWV
	M4eNZcxtNJ7OBaQzatmsizQmw/8WE/hBp/vnlKn5O9LmaRuCHOLprk8cowxcOkaGItEffRe8lEM
	A9Ih6hrbfWQirZ3RsBngD9W+N5f16
X-Google-Smtp-Source: AGHT+IHP3/qOhhMPBOFZAjk+2oHo8/Wdv9U9RQ3phvQekxuOjvAA0q8p/sGBWqtGI+atxjtqN53LTw==
X-Received: by 2002:a05:6870:2183:b0:29e:3d40:ab48 with SMTP id 586e51a60fabf-2b32f2d94d7mr2505453fac.34.1738174518629;
        Wed, 29 Jan 2025 10:15:18 -0800 (PST)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f0f325dsm4487810fac.6.2025.01.29.10.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:15:18 -0800 (PST)
From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
To: kuba@kernel.org
Cc: alexanderduyck@fb.com,
	alexandr.lobakin@intel.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ronak.doshi@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	u9012063@gmail.com
Subject: [PATCH net v2] vmxnet3: Fix tx queue race condition with XDP
Date: Wed, 29 Jan 2025 23:47:03 +0530
Message-Id: <20250129181703.148027-1-sankararaman.jayaraman@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127143635.623dc3b0@kernel.org>
References: <20250127143635.623dc3b0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If XDP traffic runs on a CPU which is greater than or equal to
the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
always picks up queue 0 for transmission as it uses reciprocal scale
instead of simple modulo operation.

vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
returned queue without any locking which can lead to race conditions
when multiple XDP xmits run in parallel on different CPU's.

This patch uses a simple module scheme when the current CPU equals or
exceeds the number of Tx queues on the NIC. It also adds locking in
vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Changes v1-> v2:
Retained the copyright dates as it is.
Used spin_lock()/spin_unlock() instead of spin_lock_irqsave(). 
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 1341374a4588..e3f94b3374f9 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -28,7 +28,7 @@ vmxnet3_xdp_get_tq(struct vmxnet3_adapter *adapter)
 	if (likely(cpu < tq_number))
 		tq = &adapter->tx_queue[cpu];
 	else
-		tq = &adapter->tx_queue[reciprocal_scale(cpu, tq_number)];
+		tq = &adapter->tx_queue[cpu % tq_number];
 
 	return tq;
 }
@@ -124,6 +124,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	u32 buf_size;
 	u32 dw2;
 
+	spin_lock(&tq->tx_lock);
 	dw2 = (tq->tx_ring.gen ^ 0x1) << VMXNET3_TXD_GEN_SHIFT;
 	dw2 |= xdpf->len;
 	ctx.sop_txd = tq->tx_ring.base + tq->tx_ring.next2fill;
@@ -134,6 +135,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 
 	if (vmxnet3_cmd_ring_desc_avail(&tq->tx_ring) == 0) {
 		tq->stats.tx_ring_full++;
+		spin_unlock(&tq->tx_lock);
 		return -ENOSPC;
 	}
 
@@ -142,8 +144,10 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 		tbi->dma_addr = dma_map_single(&adapter->pdev->dev,
 					       xdpf->data, buf_size,
 					       DMA_TO_DEVICE);
-		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr)) {
+			spin_unlock(&tq->tx_lock);
 			return -EFAULT;
+		}
 		tbi->map_type |= VMXNET3_MAP_SINGLE;
 	} else { /* XDP buffer from page pool */
 		page = virt_to_page(xdpf->data);
@@ -182,6 +186,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	dma_wmb();
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
+	spin_unlock(&tq->tx_lock);
 
 	/* No need to handle the case when tx_num_deferred doesn't reach
 	 * threshold. Backend driver at hypervisor side will poll and reset
@@ -226,6 +231,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	struct vmxnet3_adapter *adapter = netdev_priv(dev);
 	struct vmxnet3_tx_queue *tq;
 	int i;
+	struct netdev_queue *nq;
 
 	if (unlikely(test_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state)))
 		return -ENETDOWN;
@@ -236,6 +242,9 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	if (tq->stopped)
 		return -ENETDOWN;
 
+	nq = netdev_get_tx_queue(adapter->netdev, tq->qid);
+
+	__netif_tx_lock(nq, smp_processor_id());
 	for (i = 0; i < n; i++) {
 		if (vmxnet3_xdp_xmit_frame(adapter, frames[i], tq, true)) {
 			tq->stats.xdp_xmit_err++;
@@ -243,6 +252,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 		}
 	}
 	tq->stats.xdp_xmit += i;
+	__netif_tx_unlock(nq);
 
 	return i;
 }
-- 
2.25.1


