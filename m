Return-Path: <netdev+bounces-263092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L9kBm+ppmmuSgAAu9opvQ
	(envelope-from <netdev+bounces-263092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E031EBD3A
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD3A30E66DE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1738C415;
	Tue,  3 Mar 2026 09:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57638C40E;
	Tue,  3 Mar 2026 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529902; cv=none; b=nudFwk7nrnoFdEHOu7pOd/MzywkhZzyoyJ6ErwKU8FgO/SxSjIQTXWQ3E6tluzgVaS7ybcI/l96GF/LB3AB6eZ+l26C9VuzM5EbN7PpGl8SidhmtRTp9ROz1GWvBC+l8vL/uicdLN1WNxy6iCZZugV/CeRiH3ZYlXBfDE1B70R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529902; c=relaxed/simple;
	bh=mFemJ5MhTC3Evj5G1qJK0FtddN++smwPzX8fsw54PuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmuQdUogziLrBynQhgEs7ftUapLZrPqiOZK/J86we8EiHEIqhw2PpMlZjg2btxpPJ12uwUehPIUIIrNjJOG7BD7VbATmXVRh7aOa2Ypnej3MbTo1vw0rPZubnI0l1aZDoXjBtKP2Y+99idF6plUJteeRshxCGMeV2R9BjyfNvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAA34WzPqKZpyU4sCQ--.6573S6;
	Tue, 03 Mar 2026 17:24:33 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 03 Mar 2026 17:24:21 +0800
Subject: [PATCH net-next 4/4] net: spacemit: Free rings of memory after
 unmapping DMA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-k1-ethernet-more-fixes-v1-4-0ab0122fdd14@iscas.ac.cn>
References: <20260303-k1-ethernet-more-fixes-v1-0-0ab0122fdd14@iscas.ac.cn>
In-Reply-To: <20260303-k1-ethernet-more-fixes-v1-0-0ab0122fdd14@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-CM-TRANSID:qwCowAA34WzPqKZpyU4sCQ--.6573S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AryrZF4Uury7tr48XryUAwb_yoW8XrykpF
	W7ZasrGryUtF45JrsrAF4Iy3W8AayrtFWj93yYvws3XF9IyrZrKFyFyry7Gr1DArWkKryY
	vrWqyw13JF1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj89NPUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Queue-Id: 73E031EBD3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263092-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.967];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Action: no action

In emac_free_{tx,rx}_resources, call dma_free_coherent() to unmap DMA
before calling kfree() to deallocate the memory, instead of the other
way around.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index f7f16397a2c2..02a009afc921 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -446,12 +446,12 @@ static void emac_free_tx_resources(struct emac_priv *priv)
 
 	emac_clean_tx_desc_ring(priv);
 
-	kfree(tr->tx_desc_buf);
-	tr->tx_desc_buf = NULL;
-
 	dma_free_coherent(dev, tr->total_size, tr->desc_addr,
 			  tr->desc_dma_addr);
 	tr->desc_addr = NULL;
+
+	kfree(tr->tx_desc_buf);
+	tr->tx_desc_buf = NULL;
 }
 
 static void emac_free_rx_resources(struct emac_priv *priv)
@@ -461,12 +461,12 @@ static void emac_free_rx_resources(struct emac_priv *priv)
 
 	emac_clean_rx_desc_ring(priv);
 
-	kfree(rr->rx_desc_buf);
-	rr->rx_desc_buf = NULL;
-
 	dma_free_coherent(dev, rr->total_size, rr->desc_addr,
 			  rr->desc_dma_addr);
 	rr->desc_addr = NULL;
+
+	kfree(rr->rx_desc_buf);
+	rr->rx_desc_buf = NULL;
 }
 
 static int emac_tx_clean_desc(struct emac_priv *priv)

-- 
2.53.0


