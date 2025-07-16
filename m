Return-Path: <netdev+bounces-207424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03912B0722E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF443A1C29
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE22F199B;
	Wed, 16 Jul 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI5yULec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5412BFC9B;
	Wed, 16 Jul 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659397; cv=none; b=EnQA9hQJUPWJ1Q+oUXV275/oXgc+6e9JeLzhx04WyAIJODTUhahhlNHjSs+qViriNtZQUPUsMZeyQGtSoJlTFvahA4DzWmYqpapiE2jQJxNf8RBnWrA++8ijHyUJoDyZQrBQc41YGaQtPFC6WNryC0Zd+xM+oOT0CQALYU+nVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659397; c=relaxed/simple;
	bh=EEdeWg3CLcEY98K4EHAAFMbr4uaieqIt7xKgPk0v/Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwdxAqdwko6mz2J4n1nFBjNJx+yXiqxu9SoLZGOhSzgkPAAqPKHal5BE65iYqJSBBxR0T4zpPG6bGDobAZ1AZ63fQD42Z5grJv4miuA+C2G1rwOLNHMJUfVFbTq6cr76yniFDTyLZrTJYRuLKebwRksY9Mp2WDcCeMP3a9sff90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI5yULec; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso8576005e9.0;
        Wed, 16 Jul 2025 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752659394; x=1753264194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYrQ7+sV7dVTWPVBK1RBCFMdeN88v1wt1t/v9UbOVE8=;
        b=eI5yULecqdgfxcdVMB1XtIiCnP2zs2ypQ5ACP/q6HNFwkRrXUklZksF20S6ZFN5PCC
         GKmQcG+Et00nsFyt/OklXMHmgxAnXfI/RS61ZN8CGID67plBI46xl0zFjMjSOVoLiYkQ
         LD1E7KuBCO4KnyV4vGEHd+f065Xbplq4r0GjPYsevjBKJ3YvYezAo5CPXl/lEtIpQKnO
         zBCLYFjNEX7nMVrWTvIDfiUPM4g6XMIzdvORsqPWoQlDEkztSb9+gkq8ZEfRT2qs7ogI
         EL6UYv8WeEwYYEnJjgHEOWe+FsDFsSr1aGHfUZpjrI4GKuTE3CNm92ftIu5m3dDv2Fup
         ty1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659394; x=1753264194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYrQ7+sV7dVTWPVBK1RBCFMdeN88v1wt1t/v9UbOVE8=;
        b=f9eql9fZ1AXWRW5HIpDRgEryYxgNlq3gd7X9MpwNA5zX0e4mh2IbFJ8/6yi7BKcT+p
         fyo82HJ0282bZ9PFbsZ0LJimrNUd7aOUh0vbcPnkm7pNnjJlOPsDswUgvPCbND4sx0gy
         K8m8dl2HYlakQ1b61GHFgMo3GRoxSD5gY8eqp047CNriVf93XvOxRL8utfSzgPrlrlUY
         60EadxpF6PoYMmoYjoEkzD1V+p7NdKznjhi85j/smDGoGmkXD5szJYELJfxFrw4IVJyf
         SP3EtB62y0UUlDfy1gqintAux/CS+1vQpdKvQ6FbD0xfGISo8mCSCgFvplkj5BiuhiRC
         Abog==
X-Forwarded-Encrypted: i=1; AJvYcCUEexf//dk9VWlut/Ooyl8IPe2aBtthdvXHI5T6cixEj5scFQI9fz7DMWGv35i4lvczcQiuQOKj@vger.kernel.org, AJvYcCXRQ9HIUFhbMDHvDtMJ7KZCxUJLbgDzlTWEqOD1eP94vZpvmAR/i0ktvpSViltYMC7aNfgneMIM8CKndM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7a27w4bakA2VIz8Czc13cg4eSEM2mTJVGBb3ZV8gCjAHL65G
	7s9H/MlRO9YUWm2EQp/ZvLxoB490V/j61R2JbsOjsdSISSK66tD2trkC
X-Gm-Gg: ASbGncsu+Q5p4Mg+28kLK444xxEaqpM7zLIEQyxEb0/cI0mrM400qrY+tJcgWEJvtZT
	j0at0PpI5Cqi2qiynCHF7DtxhJ93l2oOk/3z9tpiWGOPoTNFA1aw5ScqVmY2vewo3jVTZg14ble
	WIy3gQchrbiZvE9rimh115uSoQw7ucfnWxzqnhT2qxRV/DWVma6Gl54RvqVmH+2SoJczbjU/Uoy
	CF594HoUKXNVcQhdLYsr4b4LTwi+Z6CmW5PfycFkljm9I4b5PDsbAZrO5nSgmejgM2h1Q1hIGuO
	V7AmX9qFMhQuCFAEOU+mZaLWtNo13M4ypCQEuEeh0rArYUieBjbxWBZAHj1FDiI5445fnp2uIUD
	i30TD3XN5gC9N2OIvVLQVZZOouvCnwd06YC/jC+KCVDDsHdElJtM=
X-Google-Smtp-Source: AGHT+IF3heKpRm+ABAaNBtuxBVQgq8WAa+ukmgI7ealy/Apb29VlJ59eiNp/mNklVk0xhpZZa6fecA==
X-Received: by 2002:a05:6000:2388:b0:3a5:324a:89b5 with SMTP id ffacd0b85a97d-3b60dd68770mr781461f8f.8.1752659394076;
        Wed, 16 Jul 2025 02:49:54 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:962d:ebf0:4a44:e416])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1f4edsm17150986f8f.83.2025.07.16.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:49:53 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Mark Einon <mark.einon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] et131x: Add missing check after DMA map
Date: Wed, 16 Jul 2025 11:47:30 +0200
Message-ID: <20250716094733.28734-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.
If the mapping fails, unmap and return an error.

Fixes: 38df6492eb51 ("et131x: Add PCIe gigabit ethernet driver et131x to drivers/net")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1 -> v2:
  - Fix subject
  - Fix double decrement of frag
  - Make comment more explicit about why there are two loops

 drivers/net/ethernet/agere/et131x.c | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 678eddb36172..5c8217638dda 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2459,6 +2459,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb->data,
 							  skb_headlen(skb),
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					return -ENOMEM;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2468,6 +2472,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb->data,
 							  skb_headlen(skb) / 2,
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					return -ENOMEM;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2478,6 +2486,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb_headlen(skb) / 2,
 							  skb_headlen(skb) / 2,
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					goto unmap_first_out;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2489,6 +2501,9 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 						    0,
 						    desc[frag].len_vlan,
 						    DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, dma_addr))
+				goto unmap_out;
+
 			desc[frag].addr_lo = lower_32_bits(dma_addr);
 			desc[frag].addr_hi = upper_32_bits(dma_addr);
 			frag++;
@@ -2578,6 +2593,27 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 		       &adapter->regs->global.watchdog_timer);
 	}
 	return 0;
+
+unmap_out:
+	// Unmap the body of the packet with map_page
+	while (--i) {
+		frag--;
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_page(&adapter->pdev->dev, dma_addr,
+			       desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+unmap_first_out:
+	// Unmap the header with map_single
+	while (frag--) {
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_single(&adapter->pdev->dev, dma_addr,
+				 desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+	return -ENOMEM;
 }
 
 static int send_packet(struct sk_buff *skb, struct et131x_adapter *adapter)
-- 
2.43.0


