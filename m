Return-Path: <netdev+bounces-116720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D194B78E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA2A1F25BC2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5D1898E4;
	Thu,  8 Aug 2024 07:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0A187864;
	Thu,  8 Aug 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101423; cv=none; b=oLHnfe1b5ZvLITG6xt6jIwa9cIyX3tBanHdv3F38gTqJfS+jIggiBMd27G9rV7e9oKJyTnNP3LtuyXr5LQGpynIi4rcRHTRm4ad1/RMTnpztn9VS7qHfR9dhIKC6hooz6MCUM2JKN8A14L4KWI2EsAJhOPvZhARbzWdLgNtXO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101423; c=relaxed/simple;
	bh=6vHSOVBe1Sa4iBroamdp+dNMEwK1hZVU83XzCsh7OKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tV/qoc6ZujghIXTGpstSzuQccFvWSMquwpBulv5lwgo3ShuCpzZjp81WvlkyMTHq7QWlMir67B75Bitdrc4RynsH0+36DZXAKAk844bhiM8s/xSHcQqfM/Ku5UypchCQuQPgruBNmgBqpzk8l6196GbWuUWAjX4uD66SHApgRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wfddl4Wrmz9sRr;
	Thu,  8 Aug 2024 09:16:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id le_qI80roccu; Thu,  8 Aug 2024 09:16:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wfddl3c6gz9sRk;
	Thu,  8 Aug 2024 09:16:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 657788B76C;
	Thu,  8 Aug 2024 09:16:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id KOxqsiZjrNoM; Thu,  8 Aug 2024 09:16:59 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.168])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E651B8B763;
	Thu,  8 Aug 2024 09:16:58 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net: fs_enet: Fix warning due to wrong type
Date: Thu,  8 Aug 2024 09:16:48 +0200
Message-ID: <ec67ea3a3bef7e58b8dc959f7c17d405af0d27e4.1723101144.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723101409; l=3691; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=6vHSOVBe1Sa4iBroamdp+dNMEwK1hZVU83XzCsh7OKY=; b=+KYHQ8fWDa+wydP+Q2tqZ+3PPXATioHzeQX/H2UaLrcwy1rvD1gEKv8XvdHnrlWkSf3YfbHNM ocANgIU4CQDBVXLuT2HrVA4Zgajrvq+IoFaLYhxH76DOYQZhVXvimUq
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Building fs_enet on powerpc e500 leads to following warning:

    CC      drivers/net/ethernet/freescale/fs_enet/mac-scc.o
  In file included from ./include/linux/build_bug.h:5,
                   from ./include/linux/container_of.h:5,
                   from ./include/linux/list.h:5,
                   from ./include/linux/module.h:12,
                   from drivers/net/ethernet/freescale/fs_enet/mac-scc.c:15:
  drivers/net/ethernet/freescale/fs_enet/mac-scc.c: In function 'allocate_bd':
  ./include/linux/err.h:28:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
        |                                                 ^
  ./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  drivers/net/ethernet/freescale/fs_enet/mac-scc.c:138:13: note: in expansion of macro 'IS_ERR_VALUE'
    138 |         if (IS_ERR_VALUE(fep->ring_mem_addr))
        |             ^~~~~~~~~~~~

This is due to fep->ring_mem_addr not being a pointer but a DMA
address which is 64 bits on that platform while pointers are
32 bits as this is a 32 bits platform with wider physical bus.

However, using fep->ring_mem_addr is just wrong because
cpm_muram_alloc() returns an offset within the muram and not
a physical address directly. So use fpi->dpram_offset instead.

Fixes: 48257c4f168e ("Add fs_enet ethernet network driver, for several embedded platforms.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../net/ethernet/freescale/fs_enet/mac-scc.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index a64cb6270515..9e89ac2b6ce3 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -131,15 +131,14 @@ static int setup_data(struct net_device *dev)
 static int allocate_bd(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	const struct fs_platform_info *fpi = fep->fpi;
+	struct fs_platform_info *fpi = fep->fpi;
 
-	fep->ring_mem_addr = cpm_muram_alloc((fpi->tx_ring + fpi->rx_ring) *
-					     sizeof(cbd_t), 8);
-	if (IS_ERR_VALUE(fep->ring_mem_addr))
+	fpi->dpram_offset = cpm_muram_alloc((fpi->tx_ring + fpi->rx_ring) *
+					    sizeof(cbd_t), 8);
+	if (IS_ERR_VALUE(fpi->dpram_offset))
 		return -ENOMEM;
 
-	fep->ring_base = (void __iomem __force*)
-		cpm_muram_addr(fep->ring_mem_addr);
+	fep->ring_base = cpm_muram_addr(fpi->dpram_offset);
 
 	return 0;
 }
@@ -147,9 +146,10 @@ static int allocate_bd(struct net_device *dev)
 static void free_bd(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
 
 	if (fep->ring_base)
-		cpm_muram_free(fep->ring_mem_addr);
+		cpm_muram_free(fpi->dpram_offset);
 }
 
 static void cleanup_data(struct net_device *dev)
@@ -247,9 +247,9 @@ static void restart(struct net_device *dev)
 		__fs_out8((u8 __iomem *)ep + i, 0);
 
 	/* point to bds */
-	W16(ep, sen_genscc.scc_rbase, fep->ring_mem_addr);
+	W16(ep, sen_genscc.scc_rbase, fpi->dpram_offset);
 	W16(ep, sen_genscc.scc_tbase,
-	    fep->ring_mem_addr + sizeof(cbd_t) * fpi->rx_ring);
+	    fpi->dpram_offset + sizeof(cbd_t) * fpi->rx_ring);
 
 	/* Initialize function code registers for big-endian.
 	 */
-- 
2.44.0


