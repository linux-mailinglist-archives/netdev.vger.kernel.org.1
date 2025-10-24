Return-Path: <netdev+bounces-232365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD74C04A0B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3145C3BB91B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12929D289;
	Fri, 24 Oct 2025 07:08:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84EC2BE034;
	Fri, 24 Oct 2025 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289717; cv=none; b=bDADs8A2qQKN3juBJC/HJFncgRKLUkX/uD4Kvpxl9fw9ancJGgX4gigu4at2S53CGSCAaLs+iVEIWq3NpiVeojwFohLCj6WVf5ktsKEroUb8HcLRRFXQPzKdyOXN9CXW4cIDyhjIkmSFtIWn1UDKc2UIAfnlCrDWBEb/RkjbGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289717; c=relaxed/simple;
	bh=AWBdYY8QmvCXTsQFYhDNHTOwnq2bI5KiGw+mXdpaa5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCDq5Aev9p+zqD6SdQ8P27B3yJZykYplB1FS9raiF3+ATDVkWR2IobzHCSF1r7dlfafcT/uq2xa5M1uJh4j3dqbUFznh8bFGtpq3VLq62/PxcEObQYtocGMrxDPMcI0zbtno4qC5yU2B+gXs2PHd920cYwThT5Jpd8SEmxMCSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202510241508235686;
        Fri, 24 Oct 2025 15:08:23 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 15:08:23 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 15:08:23 +0800
Received: from localhost.localdomain.com (unknown [10.94.15.147])
	by app4 (Coremail) with SMTP id bAJkCsDwRLXlJftorCEPAA--.2809S5;
	Fri, 24 Oct 2025 15:08:22 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <cooldavid@cooldavid.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH for-next 1/1] net: jme: migrate to dma_map_phys instead of map_page
Date: Fri, 24 Oct 2025 15:07:34 +0800
Message-ID: <20251024070734.34353-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251024070734.34353-1-chuguangqing@inspur.com>
References: <20251024070734.34353-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwRLXlJftorCEPAA--.2809S5
X-Coremail-Antispam: 1UD129KBjvdXoWrur18GFWxtr4UWw4xKr1kGrg_yoWDArb_uF
	WxZr4fKa1DGF9aqrWUKr47X3409w4DurZ3ZF1SgFWaq34UCwsFkryxuryDG3WDWa18GFy5
	Gr13ArWfA34jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
	0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
	AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
	cxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCF04
	k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?fjtcxZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KTaM3IO6IGCwFqcU+UhQ4BTe7uW544mwODSyhN2tznru15qsZVlQpxqrjDVDjDJSztbq
	pFDcwszmuSDXuRd881I=
Content-Type: text/plain
tUid: 2025102415082398178519985c1340057c0c0535e4b36e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/ethernet/jme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index d8be0e4dcb07..7ceeb706939d 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -735,9 +735,10 @@ jme_make_new_rx_buf(struct jme_adapter *jme, int i)
 	if (unlikely(!skb))
 		return -ENOMEM;
 
-	mapping = dma_map_page(&jme->pdev->dev, virt_to_page(skb->data),
-			       offset_in_page(skb->data), skb_tailroom(skb),
-			       DMA_FROM_DEVICE);
+	mapping = dma_map_phys(&jme->pdev->dev, virt_to_phys(skb->data),
+			       skb_tailroom(skb),
+			       DMA_FROM_DEVICE,
+			       0);
 	if (unlikely(dma_mapping_error(&jme->pdev->dev, mapping))) {
 		dev_kfree_skb(skb);
 		return -ENOMEM;
-- 
2.43.7


