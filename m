Return-Path: <netdev+bounces-204510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5336AFAF40
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069643A5BE6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625728C2D2;
	Mon,  7 Jul 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga8MPKPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CB1D5150;
	Mon,  7 Jul 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879423; cv=none; b=DJHrFVlB+JtZo6qlGln6y1yT4TKuX1ujatc9CqyJEg0nzWX8wzi1J1ff1U7aRoiItrS86ZhnaB0Roxzp0GDmqayDKqGFz1Ject/hW7qREf7A3pPEgJk+TFMIYN9CShGUemllVe5Vz1AO9sKVo3trfva2B5wrq7XWoNW8ZzLij/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879423; c=relaxed/simple;
	bh=1reYjJf5V0RxPsran44wFqB4/Ic92wmjl1koBdZ0fvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7i9SEAJ789wFj3BysW8giHqr4ejFbLYA+fTwMnJAQPZTL20yScz/2CYYrt/ISHWFfzk/HfU+suSlVvSe6WqSp50HUAzrqlfiNY4Tg0hqLUO5ZDSlEHcDKu6Shv9wyAgnrWzA25+IA8x3cTDotCHxp1HGaVmwwJolIynHHvtUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga8MPKPD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso3578595e9.0;
        Mon, 07 Jul 2025 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751879418; x=1752484218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJWtxT21l7c4nts93SF3UAZIecgeSHAqf7LSVji6R4A=;
        b=ga8MPKPDHqt3nudGNCOYits4xdVjaU/tixbBSxTuNPJQVPmUp1krHBaP5C9oWOlMcH
         szT8/lV2t2Q9737BBlKWsNiHFiQfG1rC7kjeClz3ywOrxp4qVTPzzi2bVPR5w2BVSKPv
         Ql1Gu87E/ZH6keHCoNW1la8naonmUwPlLFbUxFAVQcTlRHylkmcueNXeYPsH5c8kvDZ6
         xDeHLekg+IOHW9F5shIrCGObEMjqJbYJZJ+3AWEl5PoJRhaKP4zKHIzRbdnOY0Pv9qah
         7iAXO5qogl3eo0KnnZsPSjeJdJdpJuQneyYcVYMRvHBHa/m+gjB8qZJiyhUhNeKP38XC
         8F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751879418; x=1752484218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJWtxT21l7c4nts93SF3UAZIecgeSHAqf7LSVji6R4A=;
        b=AeBpJbR+RJZgoD4AJfRIRcFsrzhO2TEXxlxzZas5hsGUXTyn/fQiHncYxpwW58dqFS
         kfwe28oyqnylTKuOY+dgJQhnsZh20uN+2YB4Vzb1C5JxdcjCLhyMsL9UX+H7IJ8q3/49
         I2IZy6phvSv1XE21WUCU8FD99sl2VSiJJFQfRtMuJEG4ZF8OdrJKI1dmoh1IxqbW1VOQ
         hkOHkc3ISC2ZfKV6fXSPHpGWAxx3NMWnxSQHPVjGMutHiRIttWUv+eC9psQcahT44g2S
         rmjZh6g4VIXvgC8VrN7OXJaG/u1H3HOLUSG5ramqdV3SRYUWV6a6hGgmiAOiV++h/iWv
         dGGA==
X-Forwarded-Encrypted: i=1; AJvYcCWjmD36L/U1EX/eophszYhd7RQs3yMeXcLIi0+qoAhGMjiNHCnG+Bo2ovdz+//5EH7ZGtfXMudh@vger.kernel.org, AJvYcCXt9POXNZCkOyhvLTYwLMMhwApYt568O8B96WWGP63/oNicbnwUNMrvncwPbUw36EkCJo9o9/CvBUqgyB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNl4mqWBVHqg0FkKM7uRPgbnzHKUJrPARn+GVsoILUTqlyg06r
	yL65JL6g2oqLqCQeCWmeMFz1b5E1YjtSXGxGL5AgVb+CD28aKamVxISm
X-Gm-Gg: ASbGncsIWwCKKpFpaTfXX0rEgl/YuqfQik6/5zkYTqMLNdb9+NYg8HtAvomAy3AEXWo
	aMFjbjGfDgkVAometoCAMs+nEbFnGFuFxtFJAuJKb2WfAwFYQ+EgqTZnkyfclzfwaP7/atH90Lx
	rmWPTnkVQDaQ1T1SjQLbD4oujhitTENxAqlq/baD3363qPsyG/CF/aDTz59nBBswheG5QVBekS7
	KEuYArxW0xFXgzM+yNacl01OF0/NKwabkb+Z7Fw612RVfk6/DCE6J0SnPIMsUFTG4PmGQQzIxfx
	DbCV1JZeOUxhucB+ZnsgQJjkkzLVvslLHMd9/rqSTDRPiNMbV7Npojma5JqVpithvH+VwOcK8C+
	nAVDienyNV42bB3Gn1HAWXVLbmw==
X-Google-Smtp-Source: AGHT+IG9qIcOORwlYLKL9hcbiQ/aV0Di5Lic/7gBgpHcgMVUALPO7xKmi5h6QOAydykVrTGwt2lNZA==
X-Received: by 2002:a05:600c:a21c:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-454b3a7d3d7mr21356575e9.5.1751879418252;
        Mon, 07 Jul 2025 02:10:18 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:ef01:c9dd:1349:ddcf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454b161fb78sm106004905e9.1.2025.07.07.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:10:17 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Mark Einon <mark.einon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ethernet: et131x:  Add missing check after DMA map
Date: Mon,  7 Jul 2025 11:09:49 +0200
Message-ID: <20250707090955.69915-1-fourier.thomas@gmail.com>
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
 drivers/net/ethernet/agere/et131x.c | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 678eddb36172..b32e2a5af779 100644
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
@@ -2578,6 +2593,28 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 		       &adapter->regs->global.watchdog_timer);
 	}
 	return 0;
+
+unmap_out:
+	// Unmap everything from i-1 to 1
+	while (--i) {
+		frag--;
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_page(&adapter->pdev->dev, dma_addr,
+			       desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+unmap_first_out:
+	// unmap header
+	while (frag--) {
+		frag--;
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


