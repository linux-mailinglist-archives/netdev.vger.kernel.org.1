Return-Path: <netdev+bounces-231072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4FCBF45BA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 04:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B59402359
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7127381C;
	Tue, 21 Oct 2025 02:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E53635;
	Tue, 21 Oct 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012601; cv=none; b=PIXOnDGIuXR9IId7Yu/CYQGoOj/oh/HKlOcgj9Mw816XhAAy52dTHzdoajgq1wpyifhfDTjW2d5vGAk3I3pMnQhRrbmv1e5AwefFQvCDtZ3PKT6jdnZcFB+q/fejzzO/7cefb3EsTvNwDz1//e5vJtqsOeYLPgPvEwtP3dtWoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012601; c=relaxed/simple;
	bh=BoeG/JuPcCYJoWQP0hUOMGXQzTj50NpqNMsIb9n9ud0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikYYy5w/OxAxx8VJ0dHFZKjT4dPSvlIT3F8Jl5Dc37QJd8PJla763bDDvtXfq0k52U1XTLTfvnOBWCQVLldG8BZ89qMx00M1L+1N8gB0w5EJY4DZiO6eMmgjNHBcGCVbfvP8bI914BxvHsLr1+EYiqb0rd8C8wxYJpkBt5l4Zf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510211009439646;
        Tue, 21 Oct 2025 10:09:43 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 21 Oct 2025 10:09:42 +0800
Received: from inspur.com (10.100.2.111) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Oct 2025 10:09:42 +0800
Received: from localhost.localdomain.com (unknown [10.94.10.57])
	by app7 (Coremail) with SMTP id bwJkCsDwMQJl6_ZogPIGAA--.13805S4;
	Tue, 21 Oct 2025 10:09:42 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <jes@trained-monkey.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.xn--org-o16s>, <pabeni@redhat.com>
CC: <linux-acenic@sunsite.dk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] net: alteon: migrate to dma_map_phys instead of map_page
Date: Tue, 21 Oct 2025 10:09:39 +0800
Message-ID: <20251021020939.1121-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bwJkCsDwMQJl6_ZogPIGAA--.13805S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDZr4rZr1xuw1UXF45GFg_yoW5Gr45pF
	WrGFy5Jw4xXr15u34kJw4kuF15Zan5Ka9a9F4fGas5A3Z8JF10kF48AFWIqrWxKr93Jw47
	Xr47ZFsxu3s0q37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?2BjuVpRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KQ1FwWqLbauvS29IOEm3CnbVQRqdD5cgc/eAwFfIS6HrZ6kb8VPIQZiZW0rQq/7OGs3p
	Ou/q4WdhR3Pe5mpBsww=
Content-Type: text/plain
tUid: 2025102110094332dea3462a6b04a542e64456f98d6424
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/ethernet/alteon/acenic.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 9e6f91df2ba0..090413f1eba7 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -1639,10 +1639,9 @@ static void ace_load_std_rx_ring(struct net_device *dev, int nr_bufs)
 		if (!skb)
 			break;
 
-		mapping = dma_map_page(&ap->pdev->dev,
-				       virt_to_page(skb->data),
-				       offset_in_page(skb->data),
-				       ACE_STD_BUFSIZE, DMA_FROM_DEVICE);
+		mapping = dma_map_phys(&ap->pdev->dev,
+				       virt_to_phys(skb->data),
+				       ACE_STD_BUFSIZE, DMA_FROM_DEVICE, 0);
 		ap->skb->rx_std_skbuff[idx].skb = skb;
 		dma_unmap_addr_set(&ap->skb->rx_std_skbuff[idx],
 				   mapping, mapping);
@@ -1700,10 +1699,9 @@ static void ace_load_mini_rx_ring(struct net_device *dev, int nr_bufs)
 		if (!skb)
 			break;
 
-		mapping = dma_map_page(&ap->pdev->dev,
-				       virt_to_page(skb->data),
-				       offset_in_page(skb->data),
-				       ACE_MINI_BUFSIZE, DMA_FROM_DEVICE);
+		mapping = dma_map_phys(&ap->pdev->dev,
+				       virt_to_phys(skb->data),
+				       ACE_MINI_BUFSIZE, DMA_FROM_DEVICE, 0);
 		ap->skb->rx_mini_skbuff[idx].skb = skb;
 		dma_unmap_addr_set(&ap->skb->rx_mini_skbuff[idx],
 				   mapping, mapping);
@@ -1756,10 +1754,9 @@ static void ace_load_jumbo_rx_ring(struct net_device *dev, int nr_bufs)
 		if (!skb)
 			break;
 
-		mapping = dma_map_page(&ap->pdev->dev,
-				       virt_to_page(skb->data),
-				       offset_in_page(skb->data),
-				       ACE_JUMBO_BUFSIZE, DMA_FROM_DEVICE);
+		mapping = dma_map_phys(&ap->pdev->dev,
+				       virt_to_phys(skb->data),
+				       ACE_JUMBO_BUFSIZE, DMA_FROM_DEVICE, 0);
 		ap->skb->rx_jumbo_skbuff[idx].skb = skb;
 		dma_unmap_addr_set(&ap->skb->rx_jumbo_skbuff[idx],
 				   mapping, mapping);
@@ -2362,9 +2359,8 @@ ace_map_tx_skb(struct ace_private *ap, struct sk_buff *skb,
 	dma_addr_t mapping;
 	struct tx_ring_info *info;
 
-	mapping = dma_map_page(&ap->pdev->dev, virt_to_page(skb->data),
-			       offset_in_page(skb->data), skb->len,
-			       DMA_TO_DEVICE);
+	mapping = dma_map_phys(&ap->pdev->dev, skb->data,
+			       skb->len, DMA_TO_DEVICE, 0);
 
 	info = ap->skb->tx_skbuff + idx;
 	info->skb = tail;
-- 
2.43.7


