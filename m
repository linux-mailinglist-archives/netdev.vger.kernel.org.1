Return-Path: <netdev+bounces-161722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A8A23925
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 05:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B256167A2A
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 04:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4FD20EB;
	Fri, 31 Jan 2025 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KWOPf2nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB9381B9
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738297360; cv=none; b=h1OBsZ4faz3ffGOKZX43u+GEJVslf57FbF8ub0KArn6SYrZOWIJeAgq/vjq6+IY2ovV39SDdbjH0dWnglH2zOcxrk803PY5rKIMh4ylAAid+VFJLp6AqLkOlnPS7U3rgLQkZsXNAYPQbPa2znym0OUveS+6KSmhlqAxNo5fh60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738297360; c=relaxed/simple;
	bh=ZdJ4Km0576TBOZuxy9asMBIpCThcVSU6cC8jysJ/mDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=s31c3xyt5M8ViiagiFCIossgYtty3GOOi2bWnAwRHTLQiU0+IZJ8dNNK19wo31Sy7AbCapLD3sHTVaLXhS3ggyEcfKho2impbf6YFpEXNA5wiCUSjbaQUX8a+fEiqR+GgQozUUsaI+Nci6JcPxDsN+FumLEvaGBuSRfGdveotNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KWOPf2nn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso27426465ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 20:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738297357; x=1738902157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QXWnIBvEXqN/aWmO5GxG/RH03iGa2Rzw0LcuCh/AV4=;
        b=KWOPf2nnju5fFdmLvLcx+xYLgomvV5vRXe9bI9DR8SCcLfuH4aYTZ2toZOn5sGV61r
         jn8veFgdaNW1ZhIFBl3ABDZMB7G/A2UwzgI04Xf6BzWVub2Ss0JabCmZHiz2G+ziHuUH
         fOkjfqQaRmztdcOjh7O+vM6F9Na156V2Pk6lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738297357; x=1738902157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QXWnIBvEXqN/aWmO5GxG/RH03iGa2Rzw0LcuCh/AV4=;
        b=p00HOP+25UqVjAUCR9/lZfdPixVHlsyl5WPZ+6RtIE9bMMyuG0DmGEGEPPBCpSUPuc
         dZU0SLrhy/Q2HNORpgRJ5q8e7pSP12TrxgDTww9xQeOn04hoaiPKMPEF094t8LBBOiGx
         Ji6uHRyltfZsdcGcW7MAUhFcc/W6VvLJvBqmuE9E1+KhdppURUy6P7xKdAhZs+gWApNZ
         JaQp5b1R2QfMTDTVJ9qvhR9qzl/wnICngBtIGVpIw9qjmRwhA4Pzcg+NWyDmK6TTVdIP
         OAx6XcWZDjR5tSpK88AY7Hbc9tfmIRovOlEr07v/aexUGHioQ0fEdqkoq8IY+3petG+g
         lwvw==
X-Gm-Message-State: AOJu0Yywhy4GIOxyjRFPMrTswGURA0vsiO6OkNkA6SGWgcMLRvSa4jsx
	OGzt5lmG+3jffL7scH1EalIqoPLDaxh39aJwI7bwxLAP1Ml30DEBT7hSWjfF7mwGjP97A+X7SMg
	53iypa+6UwT7Tobbc9fy54E31m1biVzVfpiLNV2CenhhvtMNWk7zgknqDhEWcyL1qpLaQ78ar0Y
	MpXwHStQaNFdEQfgQ4TzMuK6gUfkZDUPbGX6iRjZQ7brsWKJQn8ES6iJrEmu8=
X-Gm-Gg: ASbGncuyAfSVvfCY7J9S4zWlG7yt3y7EIdJtlB82d+r3A+XVlTJnNhXElOx/YU//5dV
	pbFlUxAueHBqegyJ1sVgMUYm/8tBvwBTiHK4GCZxWVMToLoDY3VMPQgsDHcEvrWMI847oyXC1zw
	4jXzRKArW0U4JvESBKnQOD28guwYi7oE3k78zNKFKcgOFU3Wj3rrtphdpxU5M++Iw0A7K6zeCav
	wfeVy1D4o/q0SUo4vQ/ZKoRVHikMGIA7zh2LKbFndGBE77ummBusDX84+G8ydoiK0p6/3EObrwO
	Z1LMHotYKlsYGd9Jzf8yWrUAprUX1IY7hNI5y7g2gZZI010Bs3qajvnjpP4c8yufVmwXpxyOMOW
	wuEqhMAApWdNbeucoI6uC6FASu7QZ
X-Google-Smtp-Source: AGHT+IEAT5FmDX0mXiDSNFz8BLxZXYx0XQCsbuB0N6896r5L/FAO4S12TiJUn4VHsxsYi1HMMil56Q==
X-Received: by 2002:a17:902:d551:b0:216:5556:8b46 with SMTP id d9443c01a7336-21dd7e0728fmr156207705ad.49.1738297357280;
        Thu, 30 Jan 2025 20:22:37 -0800 (PST)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de330084bsm21276035ad.178.2025.01.30.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 20:22:36 -0800 (PST)
From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
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
	pabeni@redhat.com,
	ronak.doshi@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	u9012063@gmail.com
Subject: [PATCH net v3] vmxnet3: Fix tx queue race condition with XDP
Date: Fri, 31 Jan 2025 09:53:41 +0530
Message-Id: <20250131042340.156547-1-sankararaman.jayaraman@broadcom.com>
X-Mailer: git-send-email 2.25.1
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
---
v3:
  - In vmxnet3_xdp_xmit_frame(), use the irq version of spin lock 
  - Fixed the ordering of local variables in vmxnet3_xdp_xmit()
v2: https://lore.kernel.org/netdev/20250129181703.148027-1-sankararaman.jayaraman@broadcom.com/
  - Retained the earlier copyright dates as it is a bug fix
  - Used spin_lock()/spin_unlock() instead of spin_lock_irqsave()
v1: https://lore.kernel.org/netdev/20250124090211.110328-1-sankararaman.jayaraman@broadcom.com/

 drivers/net/vmxnet3/vmxnet3_xdp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 1341374a4588..616ecc38d172 100644
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
 
+	spin_lock_irq(&tq->tx_lock);
 	dw2 = (tq->tx_ring.gen ^ 0x1) << VMXNET3_TXD_GEN_SHIFT;
 	dw2 |= xdpf->len;
 	ctx.sop_txd = tq->tx_ring.base + tq->tx_ring.next2fill;
@@ -134,6 +135,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 
 	if (vmxnet3_cmd_ring_desc_avail(&tq->tx_ring) == 0) {
 		tq->stats.tx_ring_full++;
+		spin_unlock_irq(&tq->tx_lock);
 		return -ENOSPC;
 	}
 
@@ -142,8 +144,10 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 		tbi->dma_addr = dma_map_single(&adapter->pdev->dev,
 					       xdpf->data, buf_size,
 					       DMA_TO_DEVICE);
-		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr)) {
+			spin_unlock_irq(&tq->tx_lock);
 			return -EFAULT;
+		}
 		tbi->map_type |= VMXNET3_MAP_SINGLE;
 	} else { /* XDP buffer from page pool */
 		page = virt_to_page(xdpf->data);
@@ -182,6 +186,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	dma_wmb();
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
+	spin_unlock_irq(&tq->tx_lock);
 
 	/* No need to handle the case when tx_num_deferred doesn't reach
 	 * threshold. Backend driver at hypervisor side will poll and reset
@@ -225,6 +230,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 {
 	struct vmxnet3_adapter *adapter = netdev_priv(dev);
 	struct vmxnet3_tx_queue *tq;
+	struct netdev_queue *nq;
 	int i;
 
 	if (unlikely(test_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state)))
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


