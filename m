Return-Path: <netdev+bounces-96711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E68C73FF
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E483E1F2463A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931E143757;
	Thu, 16 May 2024 09:43:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3344206C;
	Thu, 16 May 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852587; cv=none; b=sGJneFMTOTs+Qu/5MWLAvW6a7Z+xtcJApDU1yUuQgrfjarJ2JCaVu7QtSJG+dv73P6JLNlRzl5j39+mnL6CK/lzgdDr0mA1OQvg7LGI3nhZKuZtqf4/qJCf1QeQ2RfSgeW78y/fLGxBUPwdd7dfW44qFL/qIiQRABWnuqj7llCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852587; c=relaxed/simple;
	bh=neiYi9rz56JelB8LT1Vt63mxobtiMVPaYMXphegGdds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHRRSLaSAX1cEs6q0rNYcm+51NEGL//zzZprVaCaiDfKpVpQQGONUJp71UBf9Es1Zf1kZyL3BnOaq4SbdJ9eEe4VyJXtKOTorfkNjJz2y+RkTQVCDGJJnJpl8pHRwlZp7AhHoG8qW5ARK9UF0XSVsmgpJg1U1o//WZFBiDPfPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXX5uo0kVm5IRaCw--.4321S2;
	Thu, 16 May 2024 17:32:25 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: add missing check for rhashtable_init
Date: Thu, 16 May 2024 17:24:27 +0800
Message-Id: <20240516092427.3897322-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXX5uo0kVm5IRaCw--.4321S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr48Aw13Wr4xGFyDuw1xKrg_yoWkAFcEgr
	Z2v3W3G3yUKryFka12kF4j9rWFkF4kJw18ZFZ3tFZIqry7GF1UAry09r9xWFZ7Ww1kAasr
	JrnIqa4xC34UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of rhashtable_init() and return the error
if it fails in order to catch the error.

Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 0acee405a749..f7e5e6e52cdf 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -884,12 +884,15 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, int index)
 	struct mtk_ppe *ppe;
 	u32 foe_flow_size;
 	void *foe;
+	int ret;
 
 	ppe = devm_kzalloc(dev, sizeof(*ppe), GFP_KERNEL);
 	if (!ppe)
 		return NULL;
 
-	rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
+	ret = rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
+	if (ret)
+		return NULL;
 
 	/* need to allocate a separate device, since it PPE DMA access is
 	 * not coherent.
-- 
2.25.1


