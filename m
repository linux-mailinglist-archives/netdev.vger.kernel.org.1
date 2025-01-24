Return-Path: <netdev+bounces-160844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09505A1BCA7
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08683188D549
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71E1D54D8;
	Fri, 24 Jan 2025 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e/NW9err"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7B2248AC;
	Fri, 24 Jan 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746055; cv=none; b=DX7gXppHdPD92eo3xgmTDXXt2rqa58PWyYPyCoSnS26kl8KpK9r5bdtE0Rmw4gbqZsx+3muFNUx+oPNAdjX8cFHtSUmgT5RiFGewAijiNdWjr030/OfHQpRJWGvWWfUzRH7udwKu6DQ7KkTnsU8wv01rf1OngXoZKwYNIKlI6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746055; c=relaxed/simple;
	bh=ZHjI/+SuAF0L9opSozt5PO2L/MKjPmvkCaVPXIvZ8gE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K2TqqupSsssX3od6kFTGlzgrreprGgeHtsgTEM/gbBp3Oq7+lIddv/sAbYcer5NZFlBjiHzvMYdfxIMacz/RVcVqjojqn1BvBwPdW6BwBhXcelaZoZTsnGtJQio/OqADzibw0MsIOE+xEIi17tDFAf84PamYINDZkTFzdel3VQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e/NW9err; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AAFA1C006836;
	Fri, 24 Jan 2025 11:14:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AAFA1C006836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1737746046;
	bh=ZHjI/+SuAF0L9opSozt5PO2L/MKjPmvkCaVPXIvZ8gE=;
	h=From:To:Cc:Subject:Date:From;
	b=e/NW9errPjDl5LnAIo6FWyr9D1V4JDQjM7AhMi5fiGnPXaRmy+hgg5TNmgRaso5Y9
	 SQmN1gOWUWv/OarQfriD+CpRMyTBjRxDjwtKPE5NnsXCs27T0IKHWd6mvwHhpMXLq9
	 vCOApEEn/L+bA3wgBVyySRUfpu31OT3ds4Fsr830=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 315A018041CAC6;
	Fri, 24 Jan 2025 11:14:06 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Murali Krishna Policharla <murali.policharla@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arun Parameswaran <arun.parameswaran@broadcom.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] bgmac: reduce max frame size to support just MTU 1500
Date: Fri, 24 Jan 2025 11:14:04 -0800
Message-Id: <20250124191404.3721128-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

bgmac allocates new replacement buffer before handling each received
frame. Allocating & DMA-preparing 9724 B each time consumes a lot of CPU
time. Ideally bgmac should just respect currently set MTU but it isn't
the case right now. For now just revert back to the old limited frame
size.

This change bumps NAT masquerade speed by ~95%.

Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
page_frag_alloc_align()"), the bgmac driver fails to open its network
interface successfully and runs out of memory in the following call
stack:

bgmac_open
  -> bgmac_dma_init
    -> bgmac_dma_rx_skb_for_slot
      -> netdev_alloc_frag

BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.

Eventually we land into __page_frag_alloc_align() with the following
parameters across multiple successive calls:

__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=10048
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=20096
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=30144

So in that case we do indeed have offset + fragsz (40192) > size (32768)
and so we would eventually return NULL. Reverting to the older 1500
bytes MTU allows the network driver to be usable again.

Fixes: 8c7da63978f1 ("bgmac: configure MTU and add support for frames beyond 8192 byte size")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
[florian: expand commit message about recent commits]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: Ie70d714cb4f00e45a34e9a015d0eb4bff60fac6e
---
 drivers/net/ethernet/broadcom/bgmac.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index d73ef262991d..6fee9a41839c 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -328,8 +328,7 @@
 #define BGMAC_RX_FRAME_OFFSET			30		/* There are 2 unused bytes between header and real data */
 #define BGMAC_RX_BUF_OFFSET			(NET_SKB_PAD + NET_IP_ALIGN - \
 						 BGMAC_RX_FRAME_OFFSET)
-/* Jumbo frame size with FCS */
-#define BGMAC_RX_MAX_FRAME_SIZE			9724
+#define BGMAC_RX_MAX_FRAME_SIZE			1536
 #define BGMAC_RX_BUF_SIZE			(BGMAC_RX_FRAME_OFFSET + BGMAC_RX_MAX_FRAME_SIZE)
 #define BGMAC_RX_ALLOC_SIZE			(SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) + \
 						 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
-- 
2.34.1


