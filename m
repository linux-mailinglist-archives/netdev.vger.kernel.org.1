Return-Path: <netdev+bounces-306328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GLYTOmHdT2qDpQIAu9opvQ
	(envelope-from <netdev+bounces-306328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E4733E7F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=pTrQOCPb;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306328-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306328-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A553043D0F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4074D9914;
	Thu,  9 Jul 2026 17:38:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF304DA522;
	Thu,  9 Jul 2026 17:38:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618694; cv=none; b=B2dMWP/YElZmI6VDWboRQVL4u5hVz+oar4DyZoVvMMAgE8VMVz3NovXscDoVEMjWNNE8e60ZzyQkZl1DgEX76fbhsP5wHmwi3VUnDf8pWnO6eW7F4MPnPHxEpp0OVuuazeWrKgIFjuG/z44/0GoWgT0JZ3VqO3jEOL7DiNc/P6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618694; c=relaxed/simple;
	bh=BBwaXuTbUqr72md9D0lYeBmdZqs6V4PGYLXFa9iwMug=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uHj1paJVzvqpHzU9S4EUrgUTg/JmY1MjPp/ignB+t4FtSi2MOC/8D4j/38ApfyoVv6TrEJ9osGV/iAf3ajmlaGdsCj2PnVeSFPsy2HR3fWoGysxHxMdVbbc09Tkmqwu5VU6rBviyGGRwPnzGDUmNsTp438Tp1O6bvbDvZXyPeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pTrQOCPb; arc=none smtp.client-ip=162.62.57.210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783618681; bh=aLmgulVhFJTesYluPMVW7+5kgMknZAu7yyhSZL1vjQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pTrQOCPbRZ9astnurdkWihJbcWYaolcqL2nZ5bs7X/pm8FAl4Ej1ki2WpWnp+xfYW
	 QwnoDFg4VsmqIxwQjW6QBKDyOFEpxjZrD9a3mXfCmoL7PezW1iT9mbvp8rz3JZX/6Q
	 6OMOWwrtT8zNQCp/+nRkOZCHT9Jdlv8IHXJqKNIk=
Received: from halo.lan ([240e:379:223b:5900:1e30:bbb9:ee9e:94aa])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 96F942FA; Fri, 10 Jul 2026 01:37:47 +0800
X-QQ-mid: xmsmtpt1783618672tj9ypurz2
Message-ID: <tencent_164779DC8B18AB10B9C636BE23C178ED5907@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5KkFSKv7t7YAGztuEDd46syGPrJJ3nmJvvfOic2Iyx7WZOLJ9Q7
	 M7Gfl+tlykDiTmsYH3OEt19lJ9PcDpeqWIi/gJRWWp/SviDLBjL85gawTrDxfajS7pDhutERTJVp
	 b8tiipT013Ts8+oU0tkJLnjcT8MqKynIf/gw/1k7oa4a9GAKqH1i7yS5ua+D9yNLdO7J+PbXuxwM
	 zXWb5lW3Ln1s8BQ3kiv2PYgLaJlGD0CwcxfplyBtbl5tHVcc9DxEm5EPgOJBB7yYuoQIaWGWacgD
	 pt+yYUapN+RLOC8qpDyVp6kdFlQVigMkUlacgB2CKZ0UEEVv7g2ZHoO/8W1joHZwnxK/TVGNwcjE
	 RCjA7XfmJ+QMihZ5ihXQU6jg55L7rgU5TBYABo8GJTlwV1mHQpiKt+bmUWiAAxMKN49g2fFND0qj
	 KSG6kBKFqsgR5+ANb0VQF5JaiPbhX0VtK9MzxePIC8H4LEvKP0SxlzKu5NYpVJw3ninajY1yZNNS
	 HQTpsQgB3yMus5VzSPw/+c16sQsutozZEWEpMC/XS+5QfX58Fq5ucHmzcFkgtvupwXeB/PaDefdR
	 kmsoywAwKSx93WdDqpbXfnkn9ss8xGyMRJJI2EiFY0UrDVmdrN5jhuGJ4u9X1eqsj5E3wyV3WcQb
	 aXbrjiEHyAbKOs51mh9f+Wyy0WgLC1kaXhII8g6MbKNSOUV0ZaAJdzBgL/sqeQ0j69itaDSIJNpn
	 NH56YUkB/p8stVCujyAFaOOgdpjzBE3mpaH52vUpd3E4224rIjOR1dWcOBz3u4okGI3k92siTWPK
	 M/ue9c79W7NYR9565kfbig7M4iW4Jq0R6bDW1e5JzQlTqKi1V6azMKe82twXixykA6pQ62oRqzcJ
	 AK1cFcx3ApITh9vLhNMccH2pO+bYYXo/bciB8zvMEMBJsNEk/CBSCdU3HLoCwRL4iXOmm3kkXECm
	 QK9NECnR+4syU+OX1sEc4ANxmM93xCGRC9sJrkwnJ/7MXptpzf6fB0bi1PWFDjiQaMeMD1NNjBB/
	 QAtZ/YF+UBlnmCyd2HJPCnTC6nLFqKojDYr9P4Whn20wK1nFjICt5H9H2DWxrRsWdF5yxmIXCygD
	 j5mYaT+eHx5p6pTPwIJN6oZuLt/FZuGXahiRq85WInOfO/HiUIUDAEAoWrUw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next 2/2] net: atlantic: convert RX path to page_pool
Date: Fri, 10 Jul 2026 01:37:42 +0800
X-OQ-MSGID: <20260709173742.63286-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sukhdeeps@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hawk@kernel.org,m:richardcochran@gmail.com,m:LinoSanfilippo@gmx.de,m:cyy@cyyself.name,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[cyyself.name];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cyy@cyyself.name,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306328-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyy@cyyself.name,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,gmx.de,cyyself.name];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyyself.name:from_mime,cyyself.name:email,qq.com:mid,qq.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 421E4733E7F

The driver currently allocates RX buffers with dev_alloc_pages(), maps
them with dma_map_page(), and uses a hand-rolled page-flip scheme to
subdivide high-order pages. Behind an IOMMU, the map/unmap churn is a
major RX cost: on a Thunderbolt-attached QNAP QNA-T310G1S, iperf3 -R
over IPv6 tops out at about 2.2 Gbit/s over MTU 1500.

Convert RX buffers to page_pool fragments. Pages are DMA-mapped once
when entering the pool and recycled through the stack or XDP via the
MEM_TYPE_PAGE_POOL memory model. This removes the custom page-flip
accounting, lets page_pool handle fragment reuse, and ensures every RX
path either keeps the ring's fragment reference for reposting or hands
it to the skb/xdp_buff for later recycling.

Register the PTP RX ring's xdp_rxq as well, since it shares the RX
clean paths. Walk the full RX ring during deinit so consumed but not yet
refilled slots cannot leak page-pool references. Drop the ethtool
PageFlips/PageReuses/PageFrees counters which only described the old
scheme.

On the QNA-T310G1S, MTU 1500, TCP over IPv6, iperf3 -R improves from
2.24 Gbit/s to 9.14 Gbit/s. The module was also smoke-tested with native
XDP PASS, DROP, and ABORTED actions; carrier recovered after each
attach/detach cycle and dmesg showed no page_pool/DMA warnings.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/net/ethernet/aquantia/Kconfig         |   1 +
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |   3 -
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  20 +-
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 238 ++++++++----------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |   6 +-
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  15 +-
 6 files changed, 140 insertions(+), 143 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/Kconfig b/drivers/net/ethernet/aquantia/Kconfig
index cec2018c84a9..c8fb7b33e5b7 100644
--- a/drivers/net/ethernet/aquantia/Kconfig
+++ b/drivers/net/ethernet/aquantia/Kconfig
@@ -20,6 +20,7 @@ config AQTION
 	tristate "aQuantia AQtion(tm) Support"
 	depends on PCI
 	depends on MACSEC || MACSEC=n
+	select PAGE_POOL
 	help
 	  This enables the support for the aQuantia AQtion(tm) Ethernet card.
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 420af958d486..0f5125bd2315 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -100,9 +100,6 @@ static const char * const aq_ethtool_queue_rx_stat_names[] = {
 	"%sQueue[%d] AllocFails",
 	"%sQueue[%d] SkbAllocFails",
 	"%sQueue[%d] Polls",
-	"%sQueue[%d] PageFlips",
-	"%sQueue[%d] PageReuses",
-	"%sQueue[%d] PageFrees",
 	"%sQueue[%d] XdpAbort",
 	"%sQueue[%d] XdpDrop",
 	"%sQueue[%d] XdpPass",
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 558ac9237f75..5b8a4d0d1cff 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -13,6 +13,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
+#include <net/xdp.h>
 
 #include "aq_nic.h"
 #include "aq_ptp.h"
@@ -1192,12 +1193,25 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	if (err)
 		goto err_exit_ptp_tx;
 
+	err = xdp_rxq_info_reg(&aq_ptp->ptp_rx.xdp_rxq, aq_nic->ndev,
+			       rx_ring_idx, aq_ptp->napi.napi_id);
+	if (err < 0)
+		goto err_exit_ptp_rx;
+
+	err = xdp_rxq_info_reg_mem_model(&aq_ptp->ptp_rx.xdp_rxq,
+					 MEM_TYPE_PAGE_POOL,
+					 aq_ptp->ptp_rx.pg_pool);
+	if (err < 0) {
+		xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
+		goto err_exit_ptp_rx;
+	}
+
 	if (aq_ptp->a1_ptp) {
 		err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
 					    aq_nic->aq_nic_cfg.rxds,
 					    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
 		if (err)
-			goto err_exit_ptp_rx;
+			goto err_exit_xdp_rxq;
 	}
 
 	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
@@ -1217,6 +1231,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 err_exit_hwts_rx:
 	if (aq_ptp->a1_ptp)
 		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+err_exit_xdp_rxq:
+	xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1233,6 +1249,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 		return;
 
 	aq_ring_free(&aq_ptp->ptp_tx);
+	if (xdp_rxq_info_is_reg(&aq_ptp->ptp_rx.xdp_rxq))
+		xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
 	aq_ring_free(&aq_ptp->ptp_rx);
 	if (aq_ptp->a1_ptp)
 		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index c59b6c0b37f1..e06c502b59f9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -14,120 +14,37 @@
 #include "aq_vec.h"
 #include "aq_main.h"
 
+#include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 #include <linux/filter.h>
 #include <linux/bpf_trace.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 
-static void aq_get_rxpages_xdp(struct aq_ring_buff_s *buff,
-			       struct xdp_buff *xdp)
-{
-	struct skb_shared_info *sinfo;
-	int i;
-
-	if (xdp_buff_has_frags(xdp)) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-
-		for (i = 0; i < sinfo->nr_frags; i++) {
-			skb_frag_t *frag = &sinfo->frags[i];
-
-			page_ref_inc(skb_frag_page(frag));
-		}
-	}
-	page_ref_inc(buff->rxdata.page);
-}
-
-static inline void aq_free_rxpage(struct aq_rxpage *rxpage, struct device *dev)
-{
-	unsigned int len = PAGE_SIZE << rxpage->order;
-
-	dma_unmap_page(dev, rxpage->daddr, len, DMA_FROM_DEVICE);
-
-	/* Drop the ref for being in the ring. */
-	__free_pages(rxpage->page, rxpage->order);
-	rxpage->page = NULL;
-}
-
-static int aq_alloc_rxpages(struct aq_rxpage *rxpage, struct aq_ring_s *rx_ring)
+static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *rxbuf)
 {
-	struct device *dev = aq_nic_get_dev(rx_ring->aq_nic);
-	unsigned int order = rx_ring->page_order;
+	unsigned int size = self->page_offset + self->frame_max +
+			    self->tail_size;
+	unsigned int pg_off;
 	struct page *page;
-	int ret = -ENOMEM;
-	dma_addr_t daddr;
-
-	page = dev_alloc_pages(order);
-	if (unlikely(!page))
-		goto err_exit;
 
-	daddr = dma_map_page(dev, page, 0, PAGE_SIZE << order,
-			     DMA_FROM_DEVICE);
+	/* Buffers whose page was not passed up the stack are reposted
+	 * with the data they already carry discarded.
+	 */
+	if (rxbuf->rxdata.page)
+		return 0;
 
-	if (unlikely(dma_mapping_error(dev, daddr)))
-		goto free_page;
-
-	rxpage->page = page;
-	rxpage->daddr = daddr;
-	rxpage->order = order;
-	rxpage->pg_off = rx_ring->page_offset;
-
-	return 0;
-
-free_page:
-	__free_pages(page, order);
-
-err_exit:
-	return ret;
-}
-
-static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *rxbuf)
-{
-	unsigned int order = self->page_order;
-	u16 page_offset = self->page_offset;
-	u16 frame_max = self->frame_max;
-	u16 tail_size = self->tail_size;
-	int ret;
-
-	if (rxbuf->rxdata.page) {
-		/* One means ring is the only user and can reuse */
-		if (page_ref_count(rxbuf->rxdata.page) > 1) {
-			/* Try reuse buffer */
-			rxbuf->rxdata.pg_off += frame_max + page_offset +
-						tail_size;
-			if (rxbuf->rxdata.pg_off + frame_max + tail_size <=
-			    (PAGE_SIZE << order)) {
-				u64_stats_update_begin(&self->stats.rx.syncp);
-				self->stats.rx.pg_flips++;
-				u64_stats_update_end(&self->stats.rx.syncp);
-
-			} else {
-				/* Buffer exhausted. We have other users and
-				 * should release this page and realloc
-				 */
-				aq_free_rxpage(&rxbuf->rxdata,
-					       aq_nic_get_dev(self->aq_nic));
-				u64_stats_update_begin(&self->stats.rx.syncp);
-				self->stats.rx.pg_losts++;
-				u64_stats_update_end(&self->stats.rx.syncp);
-			}
-		} else {
-			rxbuf->rxdata.pg_off = page_offset;
-			u64_stats_update_begin(&self->stats.rx.syncp);
-			self->stats.rx.pg_reuses++;
-			u64_stats_update_end(&self->stats.rx.syncp);
-		}
+	page = page_pool_dev_alloc_frag(self->pg_pool, &pg_off, size);
+	if (unlikely(!page)) {
+		u64_stats_update_begin(&self->stats.rx.syncp);
+		self->stats.rx.alloc_fails++;
+		u64_stats_update_end(&self->stats.rx.syncp);
+		return -ENOMEM;
 	}
 
-	if (!rxbuf->rxdata.page) {
-		ret = aq_alloc_rxpages(&rxbuf->rxdata, self);
-		if (ret) {
-			u64_stats_update_begin(&self->stats.rx.syncp);
-			self->stats.rx.alloc_fails++;
-			u64_stats_update_end(&self->stats.rx.syncp);
-		}
-		return ret;
-	}
+	rxbuf->rxdata.page = page;
+	rxbuf->rxdata.daddr = page_pool_get_dma_addr(page);
+	rxbuf->rxdata.pg_off = pg_off + self->page_offset;
 
 	return 0;
 }
@@ -179,6 +96,15 @@ int aq_ring_rx_alloc(struct aq_ring_s *self,
 		     unsigned int idx,
 		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = aq_nic_cfg->rxds,
+		.nid = NUMA_NO_NODE,
+		.dev = aq_nic_get_dev(aq_nic),
+		.dma_dir = DMA_FROM_DEVICE,
+	};
+	struct page_pool *pool;
+
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->rxds;
@@ -200,6 +126,18 @@ int aq_ring_rx_alloc(struct aq_ring_s *self,
 		self->tail_size = 0;
 	}
 
+	pp_params.order = self->page_order;
+	pp_params.max_len = PAGE_SIZE << self->page_order;
+
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	self->pg_pool = pool;
+
+	/* On failure aq_ring_alloc() calls aq_ring_free(), which also
+	 * destroys the page pool.
+	 */
 	return aq_ring_alloc(self, aq_nic);
 }
 
@@ -346,7 +284,11 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 			++self->stats.tx.packets;
 			self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
 			u64_stats_update_end(&self->stats.tx.syncp);
-			xdp_return_frame_rx_napi(buff->xdpf);
+			/* Frames queued via ndo_xdp_xmit() may come from a
+			 * page pool owned by another NAPI context: no direct
+			 * recycling.
+			 */
+			xdp_return_frame(buff->xdpf);
 		}
 
 out:
@@ -438,22 +380,15 @@ int aq_xdp_xmit(struct net_device *dev, int num_frames,
 }
 
 static struct sk_buff *aq_xdp_build_skb(struct xdp_buff *xdp,
-					struct net_device *dev,
-					struct aq_ring_buff_s *buff)
+					struct net_device *dev)
 {
 	struct xdp_frame *xdpf;
-	struct sk_buff *skb;
 
 	xdpf = xdp_convert_buff_to_frame(xdp);
 	if (unlikely(!xdpf))
 		return NULL;
 
-	skb = xdp_build_skb_from_frame(xdpf, dev);
-	if (!skb)
-		return NULL;
-
-	aq_get_rxpages_xdp(buff, xdp);
-	return skb;
+	return xdp_build_skb_from_frame(xdpf, dev);
 }
 
 static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
@@ -474,8 +409,16 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 	u64_stats_update_end(&rx_ring->stats.rx.syncp);
 
 	prog = READ_ONCE(rx_ring->xdp_prog);
-	if (!prog)
-		return aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
+	if (!prog) {
+		skb = aq_xdp_build_skb(xdp, aq_nic->ndev);
+		/* The ring has already handed its page pool reference to the
+		 * xdp_buff, so if the skb could not be built the buffer must
+		 * be returned to the pool here or its fragments would leak.
+		 */
+		if (!skb)
+			xdp_return_buff(xdp);
+		return skb;
+	}
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
@@ -486,7 +429,7 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
-		skb = aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
+		skb = aq_xdp_build_skb(xdp, aq_nic->ndev);
 		if (!skb)
 			goto out_aborted;
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
@@ -504,7 +447,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
 		++rx_ring->stats.rx.xdp_tx;
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
-		aq_get_rxpages_xdp(buff, xdp);
 		break;
 	case XDP_REDIRECT:
 		if (xdp_do_redirect(aq_nic->ndev, xdp, prog) < 0)
@@ -513,7 +455,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
 		++rx_ring->stats.rx.xdp_redirect;
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
-		aq_get_rxpages_xdp(buff, xdp);
 		break;
 	default:
 		fallthrough;
@@ -524,11 +465,13 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
 		trace_xdp_exception(aq_nic->ndev, prog, act);
 		bpf_warn_invalid_xdp_action(aq_nic->ndev, prog, act);
+		xdp_return_buff(xdp);
 		break;
 	case XDP_DROP:
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
 		++rx_ring->stats.rx.xdp_drop;
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
+		xdp_return_buff(xdp);
 		break;
 	}
 
@@ -547,8 +490,11 @@ static bool aq_add_rx_fragment(struct device *dev,
 	do {
 		skb_frag_t *frag;
 
-		if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS))
+		if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
+			/* Attached frags must reach xdp_return_buff() */
+			xdp_buff_set_frags_flag(xdp);
 			return true;
+		}
 
 		frag = &sinfo->frags[sinfo->nr_frags++];
 		buff_ = &ring->buff_ring[buff_->next];
@@ -572,6 +518,11 @@ static bool aq_add_rx_fragment(struct device *dev,
 		if (page_is_pfmemalloc(buff_->rxdata.page))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
+		/* The frag's page pool reference is owned by the xdp_buff
+		 * from now on.
+		 */
+		buff_->rxdata.page = NULL;
+
 	} while (!buff_->is_eop);
 
 	xdp_buff_set_frags_flag(xdp);
@@ -675,6 +626,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 			err = -ENOMEM;
 			goto err_exit;
 		}
+		skb_mark_for_recycle(skb);
 		if (is_ptp_ring)
 			buff->len -=
 				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),
@@ -695,7 +647,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 					buff->rxdata.pg_off + hdr_len,
 					buff->len - hdr_len,
 					self->frame_max);
-			page_ref_inc(buff->rxdata.page);
+			buff->rxdata.page = NULL;
 		}
 
 		if (!buff->is_eop) {
@@ -714,7 +666,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 						buff_->rxdata.pg_off,
 						buff_->len,
 						self->frame_max);
-				page_ref_inc(buff_->rxdata.page);
+				buff_->rxdata.page = NULL;
 				buff_->is_cleaned = 1;
 
 				buff->is_ip_cso &= buff_->is_ip_cso;
@@ -852,6 +804,11 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
 				 buff->len, false);
+		/* The xdp_buff owns the buffer's page pool reference from
+		 * here on; it comes back through the MEM_TYPE_PAGE_POOL
+		 * memory model on every XDP verdict.
+		 */
+		buff->rxdata.page = NULL;
 		if (!buff->is_eop) {
 			if (aq_add_rx_fragment(dev, rx_ring, buff, &xdp)) {
 				u64_stats_update_begin(&rx_ring->stats.rx.syncp);
@@ -859,6 +816,7 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 				rx_ring->stats.rx.bytes += xdp_get_buff_len(&xdp);
 				++rx_ring->stats.rx.xdp_aborted;
 				u64_stats_update_end(&rx_ring->stats.rx.syncp);
+				xdp_return_buff(&xdp);
 				continue;
 			}
 		}
@@ -951,15 +909,37 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
 
 void aq_ring_rx_deinit(struct aq_ring_s *self)
 {
-	if (!self)
+	unsigned int i;
+
+	/* The ring may already be gone: on a partial aq_ptp_ring_alloc()
+	 * failure the unwind frees it but leaves aq_nic set, so the
+	 * deinit paths still get here.
+	 */
+	if (!self || !self->buff_ring)
 		return;
 
-	for (; self->sw_head != self->sw_tail;
-		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
-		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+	/* Release every fragment still owned by the ring, or
+	 * page_pool_destroy() will stall on the outstanding references.
+	 *
+	 * Walking [sw_head, sw_tail) is not enough: refill is batched
+	 * (aq_ring_rx_fill() waits for AQ_CFG_RX_REFILL_THRES free slots),
+	 * so slots that were cleaned but not yet reposted accumulate in the
+	 * [sw_tail, sw_head) gap. Frames kept for in-place repost (RX
+	 * errors, XDP_DROP and header-only packets) still hold a fragment
+	 * there, so walk the whole ring and release whatever is left.
+	 */
+	for (i = 0; i < self->size; i++) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[i];
+
+		if (!buff->rxdata.page)
+			continue;
 
-		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
+		page_pool_put_full_page(self->pg_pool, buff->rxdata.page,
+					false);
+		buff->rxdata.page = NULL;
 	}
+
+	self->sw_head = self->sw_tail;
 }
 
 void aq_ring_free(struct aq_ring_s *self)
@@ -970,6 +950,11 @@ void aq_ring_free(struct aq_ring_s *self)
 	kfree(self->buff_ring);
 	self->buff_ring = NULL;
 
+	if (self->pg_pool) {
+		page_pool_destroy(self->pg_pool);
+		self->pg_pool = NULL;
+	}
+
 	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
@@ -1008,9 +993,6 @@ unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
 			data[++count] = self->stats.rx.alloc_fails;
 			data[++count] = self->stats.rx.skb_alloc_fails;
 			data[++count] = self->stats.rx.polls;
-			data[++count] = self->stats.rx.pg_flips;
-			data[++count] = self->stats.rx.pg_reuses;
-			data[++count] = self->stats.rx.pg_losts;
 			data[++count] = self->stats.rx.xdp_aborted;
 			data[++count] = self->stats.rx.xdp_drop;
 			data[++count] = self->stats.rx.xdp_pass;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 6431cc62962f..58bcadb3e3cc 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -17,12 +17,12 @@
 #define AQ_XDP_TAILROOM		SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
 
 struct page;
+struct page_pool;
 struct aq_nic_cfg_s;
 
 struct aq_rxpage {
 	struct page *page;
 	dma_addr_t daddr;
-	unsigned int order;
 	unsigned int pg_off;
 };
 
@@ -105,9 +105,6 @@ struct aq_ring_stats_rx_s {
 	u64 alloc_fails;
 	u64 skb_alloc_fails;
 	u64 polls;
-	u64 pg_losts;
-	u64 pg_flips;
-	u64 pg_reuses;
 	u64 xdp_aborted;
 	u64 xdp_drop;
 	u64 xdp_pass;
@@ -151,6 +148,7 @@ struct aq_ring_s {
 	u16 tail_size;
 	union aq_ring_stats_s stats;
 	dma_addr_t dx_ring_pa;
+	struct page_pool *pg_pool;
 	struct bpf_prog *xdp_prog;
 	enum atl_ring_type ring_type;
 	struct xdp_rxq_info xdp_rxq;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 05814fea0f5f..023a80f4614e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -146,25 +146,26 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
 		aq_nic_set_tx_ring(aq_nic, idx_ring, ring);
 
 		ring = &self->ring[i][AQ_VEC_RX_ID];
+		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err)
+			goto err_exit;
+
 		if (xdp_rxq_info_reg(&ring->xdp_rxq,
 				     aq_nic->ndev, idx,
 				     self->napi.napi_id) < 0) {
+			aq_ring_free(ring);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 		if (xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					       MEM_TYPE_PAGE_SHARED, NULL) < 0) {
+					       MEM_TYPE_PAGE_POOL,
+					       ring->pg_pool) < 0) {
 			xdp_rxq_info_unreg(&ring->xdp_rxq);
+			aq_ring_free(ring);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 
-		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
-		if (err) {
-			xdp_rxq_info_unreg(&ring->xdp_rxq);
-			goto err_exit;
-		}
-
 		++self->rx_rings;
 	}
 
-- 
2.47.3


