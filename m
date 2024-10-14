Return-Path: <netdev+bounces-135148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7899C80A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4790DB284D7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DF1AE01E;
	Mon, 14 Oct 2024 11:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF291B4F07;
	Mon, 14 Oct 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903647; cv=none; b=teyhmyAO3kRxvrQ314+QvfF87e7bqNgxd0otHt67FWrPqV5OqtINaKAuCJGZk5IuX3wDXzMhRK/J0tIYbXsd5T7IpHDLuHCaWVFyWdGxiDxtvfN3ZV3UrbjDOf0upWL66BR7Ur2mZwN7HdvfLSo3dzfwvY2Zfrb89m2Q0Py/oJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903647; c=relaxed/simple;
	bh=zoBklO+Lsg/otgSnAT/gVbImhyH5IDeEHk1rRD0akTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWZPkHlpcq93d+5hF/1bo/rIgNrZN6KpbuRTI1/cZT9Z/ATNX/Z2UYH67+WaO2B0L7gH2hc1zwx9uroGo9SHWi3BsK+MZK1PKOGZjZRqs23bRr5Y98AruzvoJk4YibiGcDQGrsZItsB+7ecb2nwqKbUbZUcRGY9CxlwcTu7OzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1911692;
	Mon, 14 Oct 2024 04:01:15 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68E4F3F51B;
	Mon, 14 Oct 2024 04:00:42 -0700 (PDT)
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
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Paolo Abeni <pabeni@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v1 25/57] net: marvell: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:32 +0100
Message-ID: <20241014105912.3207374-25-ryan.roberts@arm.com>
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

Updated sky2 "struct rx_ring_info" member frag_addr[] to contain enough
entries for the smallest supported page size.

Updated mvneta "struct mvneta_tx_queue" members tso_hdrs[] and
tso_hdrs_phys[] to contain enough entries for the smallest supported
page size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/net/ethernet/marvell/mvneta.c | 9 ++++++---
 drivers/net/ethernet/marvell/sky2.h   | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 41894834fb53c..f3ac371d8f3a7 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -346,12 +346,15 @@
 
 /* The size of a TSO header page */
 #define MVNETA_TSO_PAGE_SIZE (2 * PAGE_SIZE)
+#define MVNETA_TSO_PAGE_SIZE_MIN (2 * PAGE_SIZE_MIN)
 
 /* Number of TSO headers per page. This should be a power of 2 */
 #define MVNETA_TSO_PER_PAGE (MVNETA_TSO_PAGE_SIZE / TSO_HEADER_SIZE)
+#define MVNETA_TSO_PER_PAGE_MIN (MVNETA_TSO_PAGE_SIZE_MIN / TSO_HEADER_SIZE)
 
 /* Maximum number of TSO header pages */
 #define MVNETA_MAX_TSO_PAGES (MVNETA_MAX_TXD / MVNETA_TSO_PER_PAGE)
+#define MVNETA_MAX_TSO_PAGES_MAX (MVNETA_MAX_TXD / MVNETA_TSO_PER_PAGE_MIN)
 
 /* descriptor aligned size */
 #define MVNETA_DESC_ALIGNED_SIZE	32
@@ -696,10 +699,10 @@ struct mvneta_tx_queue {
 	int next_desc_to_proc;
 
 	/* DMA buffers for TSO headers */
-	char *tso_hdrs[MVNETA_MAX_TSO_PAGES];
+	char *tso_hdrs[MVNETA_MAX_TSO_PAGES_MAX];
 
 	/* DMA address of TSO headers */
-	dma_addr_t tso_hdrs_phys[MVNETA_MAX_TSO_PAGES];
+	dma_addr_t tso_hdrs_phys[MVNETA_MAX_TSO_PAGES_MAX];
 
 	/* Affinity mask for CPUs*/
 	cpumask_t affinity_mask;
@@ -5895,7 +5898,7 @@ static int __init mvneta_driver_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON_NOT_POWER_OF_2(MVNETA_TSO_PER_PAGE);
+	BUILD_BUG_ON_NOT_POWER_OF_2(MVNETA_TSO_PER_PAGE_MIN);
 
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "net/mvneta:online",
 				      mvneta_cpu_online,
diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index 8d0bacf4e49cc..8ee73ae087dfc 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2195,7 +2195,7 @@ struct rx_ring_info {
 	struct sk_buff	*skb;
 	dma_addr_t	data_addr;
 	DEFINE_DMA_UNMAP_LEN(data_size);
-	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
+	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT_MIN ?: 1];
 };
 
 enum flow_control {
-- 
2.43.0


