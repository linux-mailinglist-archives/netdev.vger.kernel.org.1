Return-Path: <netdev+bounces-160748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2BA1B240
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A698116E38B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776A21A447;
	Fri, 24 Jan 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fwz3p/+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB903219A8D
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709243; cv=none; b=QRIrAWqOuiPTZt6pM1PyLRCwArYjL5gxkoIzjIVsz2kmT9cwTaG8sxmCIBuMYNa83lPWhYbtvLKCONG02V4Bvqg0z50Md/51kiUMXUOJ4+aFNiv8W7yWbJPjl2eW7cI1jVycTAlYht3YNgjj4r+w+PZDYYWixk4LNHuieL/juKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709243; c=relaxed/simple;
	bh=pN2nhPEYz3N7Dz9ojqkhd30ByK27NvDsqaYYcV6GM4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sP1qcdStaTiVqgRx61sAcM2CLzD+g5ZQRNm4xuOZ4WOHBP2rmzbO1ACxdow5VE3qrngdWRgwb1r57iE3VxG2OVG3eWSDGOJf8StW6sxUwUfnx3FociYtjQr9a4Ed0VbEsFZNg3h94EkTVTt/royqeiNGD+c3Pj7PoF6k9msq78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fwz3p/+j; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb3c143727so1454133b6e.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 01:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737709240; x=1738314040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1virLRSmku1bo4ra/cTxAuGlA/mh3AGwqi9s+koNZPQ=;
        b=fwz3p/+jVCGjAADbX9fFvnscytjXUxUSHvFo/D8N+v5d+nuUXk+b2W93mJIA79Team
         s1B760dx7Wv00w4Q1tJr/tXXHQ15gOc9HNMWf48u1sVWeYX9m16grufPsViY/ECbZ20j
         Z9jPGY2pBY9SD+R6XsWOUKMZLqz/NtcL8TL7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709240; x=1738314040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1virLRSmku1bo4ra/cTxAuGlA/mh3AGwqi9s+koNZPQ=;
        b=WIx8s/JM7Jh0lVNjV/O0xXDdfXFFqf7B/xpKSDXC9eYAaOz9ceqlVi8EAKvYxoahaR
         dksT77HwZzIKBf/Pp2/A5h/OZ6qyqTf6RS3pCqyTCeONgpMrDgSVuyvBkl12g1nXHXdn
         5GjlQtkwbSEBzigy/vTjkhaG+q0A3qigdOiN4QnmPmMGFKSEu5PqWRYEc9nXklWxYXtT
         HCHdRwPf3mYsJeVqgqg021nfGfNNcrGWQdGx3I1ldt1YNutAVGRIzWYn2fIcG1Rm0nc+
         MToSjk61BEuCWoqVnKUgIwVpbUB+OlB0HeGZE3OoOvSf4+NklLiexw5jyTjPDc83LQS9
         wnQg==
X-Gm-Message-State: AOJu0YxUki8aAAT653UOAs3ITcPkjBReezNYD8ah42mA5oDI6VM/XGN5
	dSGRNeXNqK0sAoM7R9xBnrg9kG013XDYGH2B16eCDCyjnguf0glXYjhj4mn2MMV+bxfFm0cI+sW
	nERkQ20wp9uaA3IXtocftPn5Kl1TViWgq+JKUknd8rCJqxIML07g5odCAWpDVhennUaL6pxoM5f
	5ltFKb1N5ABw/919GlvA9NWFvRrG5CEKHsP7zOSVcoDj+AIDXI+9bJbWk+H00=
X-Gm-Gg: ASbGncsFiu2aAghKCKrbaJznsNv2rmrpuVNODwu1Aruhw19cKjZGA6I10YR4yKu2r58
	kk1x5XcpGOSpIceVm9bpkM84GHE/pELU7aJmJvgo4C03I5A2xDE/LfrIL0a9IVgYKZVGJb5OKRm
	SHWWFunSanbH4ZMFHa42QHpVJzHErMhAq/yl7fNZlqEQx7U4Y4c9O8czvMq9FDMSnsoF7ENgFIn
	9FgngGlw3mVvKv/FJq7LQkbkOYEMRb6K6QbzMkczH3M/BMp5uhn/t24nHAciOmAHBvBfhi20wsa
	Oh1eL6RYivjxM+V4UuEZ2eqa5QCWDictgcPuCs65YIxMmcAG6JtjkFwBpvdM6KqYwpl53T9Yw74
	Xcl8wiAo3kf/X9zFU4Q==
X-Google-Smtp-Source: AGHT+IHNX4BPMjcpOaIfegmByMvxTEUJw329A78lBJvWcqne+ddXSlvg0OQYlrWkULrFrlv7H7eWYA==
X-Received: by 2002:a05:6808:1b87:b0:3e7:bd4e:5b98 with SMTP id 5614622812f47-3f1e4a77e4cmr4214262b6e.0.1737709239900;
        Fri, 24 Jan 2025 01:00:39 -0800 (PST)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f087d319sm312691b6e.11.2025.01.24.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:38 -0800 (PST)
From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
To: netdev@vger.kernel.org
Cc: sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	u9012063@gmail.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	alexandr.lobakin@intel.com,
	alexanderduyck@fb.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
Date: Fri, 24 Jan 2025 14:32:11 +0530
Message-Id: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>
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
 drivers/net/vmxnet3/vmxnet3_xdp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 1341374a4588..5f177e77cfcb 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Linux driver for VMware's vmxnet3 ethernet NIC.
- * Copyright (C) 2008-2023, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2008-2025, VMware, Inc. All Rights Reserved.
  * Maintained by: pv-drivers@vmware.com
  *
  */
@@ -28,7 +28,7 @@ vmxnet3_xdp_get_tq(struct vmxnet3_adapter *adapter)
 	if (likely(cpu < tq_number))
 		tq = &adapter->tx_queue[cpu];
 	else
-		tq = &adapter->tx_queue[reciprocal_scale(cpu, tq_number)];
+		tq = &adapter->tx_queue[cpu % tq_number];
 
 	return tq;
 }
@@ -123,7 +123,9 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	struct page *page;
 	u32 buf_size;
 	u32 dw2;
+	unsigned long irq_flags;
 
+	spin_lock_irqsave(&tq->tx_lock, irq_flags);
 	dw2 = (tq->tx_ring.gen ^ 0x1) << VMXNET3_TXD_GEN_SHIFT;
 	dw2 |= xdpf->len;
 	ctx.sop_txd = tq->tx_ring.base + tq->tx_ring.next2fill;
@@ -134,6 +136,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 
 	if (vmxnet3_cmd_ring_desc_avail(&tq->tx_ring) == 0) {
 		tq->stats.tx_ring_full++;
+		spin_unlock_irqrestore(&tq->tx_lock, irq_flags);
 		return -ENOSPC;
 	}
 
@@ -142,8 +145,10 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 		tbi->dma_addr = dma_map_single(&adapter->pdev->dev,
 					       xdpf->data, buf_size,
 					       DMA_TO_DEVICE);
-		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr)) {
+			spin_unlock_irqrestore(&tq->tx_lock, irq_flags);
 			return -EFAULT;
+		}
 		tbi->map_type |= VMXNET3_MAP_SINGLE;
 	} else { /* XDP buffer from page pool */
 		page = virt_to_page(xdpf->data);
@@ -182,6 +187,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	dma_wmb();
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
+	spin_unlock_irqrestore(&tq->tx_lock, irq_flags);
 
 	/* No need to handle the case when tx_num_deferred doesn't reach
 	 * threshold. Backend driver at hypervisor side will poll and reset
@@ -226,6 +232,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	struct vmxnet3_adapter *adapter = netdev_priv(dev);
 	struct vmxnet3_tx_queue *tq;
 	int i;
+	struct netdev_queue *nq;
 
 	if (unlikely(test_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state)))
 		return -ENETDOWN;
@@ -236,6 +243,9 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	if (tq->stopped)
 		return -ENETDOWN;
 
+	nq = netdev_get_tx_queue(adapter->netdev, tq->qid);
+
+	__netif_tx_lock(nq, smp_processor_id());
 	for (i = 0; i < n; i++) {
 		if (vmxnet3_xdp_xmit_frame(adapter, frames[i], tq, true)) {
 			tq->stats.xdp_xmit_err++;
@@ -243,6 +253,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 		}
 	}
 	tq->stats.xdp_xmit += i;
+	__netif_tx_unlock(nq);
 
 	return i;
 }
-- 
2.25.1


