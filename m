Return-Path: <netdev+bounces-135147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB299C808
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADB7288285
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4BB1A00CB;
	Mon, 14 Oct 2024 11:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A81AE01E;
	Mon, 14 Oct 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903645; cv=none; b=nWKd4QpsFkPL4+hgWnVe54zf0qKOcffnPnWKRBqQRiLsVtVVeADzvYouyq5PcNkqwhBjGQX4YjsQM0o0BiW04uvs51GmTV5XoD3o1A0maUkNIqezRQ2yn9M/J4MwAdwtcypo8FikcXz1RbqJxG7s+5xkQFWpQEABLoK6a8Roxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903645; c=relaxed/simple;
	bh=zM+NLSpqdPLBnh5SUSpz7cUaa0KrDgc2rtyolYO84kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKZILsEjUhI3PFw6QtBdV0+MRLlg95f1g7DqqQVu19GpKUP/FlNbxveZ9mojyxpfSh7WAZRCftuXu9d5EHo6N2paSu6tBRWipxYc+Uu+DBVE+c8I9dhEs2CpujUirqyfcLLubrMdjZC0HtSLTMwTAfzqOeSsCJYH0piXzOcb8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B723A168F;
	Mon, 14 Oct 2024 04:01:11 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51813F51B;
	Mon, 14 Oct 2024 04:00:38 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v1 24/57] net: fec: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:31 +0100
Message-ID: <20241014105912.3207374-24-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Refactored "struct fec_enet_priv_rx_q" to use a flexible array member
for "rx_skb_info", since its length depends on PAGE_SIZE.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/net/ethernet/freescale/fec.h      | 3 ++-
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a19cb2a786fd2..afc8b3f360555 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -571,7 +571,6 @@ struct fec_enet_priv_tx_q {
 
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct  fec_enet_priv_txrx_info rx_skb_info[RX_RING_SIZE];
 
 	/* page_pool */
 	struct page_pool *page_pool;
@@ -580,6 +579,8 @@ struct fec_enet_priv_rx_q {
 
 	/* rx queue number, in the range 0-7 */
 	u8 id;
+
+	struct  fec_enet_priv_txrx_info rx_skb_info[];
 };
 
 struct fec_stop_mode_gpr {
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a923cb95cdc62..b9214c12d537e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3339,6 +3339,8 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	int i;
 	int ret = 0;
 	struct fec_enet_priv_tx_q *txq;
+	size_t rxq_sz = struct_size(fep->rx_queue[0], rx_skb_info, RX_RING_SIZE);
+
 
 	for (i = 0; i < fep->num_tx_queues; i++) {
 		txq = kzalloc(sizeof(*txq), GFP_KERNEL);
@@ -3364,8 +3366,7 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	}
 
 	for (i = 0; i < fep->num_rx_queues; i++) {
-		fep->rx_queue[i] = kzalloc(sizeof(*fep->rx_queue[i]),
-					   GFP_KERNEL);
+		fep->rx_queue[i] = kzalloc(rxq_sz, GFP_KERNEL);
 		if (!fep->rx_queue[i]) {
 			ret = -ENOMEM;
 			goto alloc_failed;
-- 
2.43.0


