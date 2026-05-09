Return-Path: <netdev+bounces-286119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPdSLRb1/mlv0AAAu9opvQ
	(envelope-from <netdev+bounces-286119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 334684FED37
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F27A300E60D
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1E39182F;
	Sat,  9 May 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjhJVYn4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E293914E0;
	Sat,  9 May 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316550; cv=none; b=YMSTGltNt/w4hXo239HTtHFinNATBo/IHa4GeouxEK1zAxskVNa3r+TmiTthyug6GcoGE7fdtMgDZE5vR/S7jq0yOk8ZJEBrxVQE38m/I3z91ZwqfBn5mSXchvwJ2kW6+Ql/A/wv31ZXxV7fceLu8SwheP4cPuEQ9BsNSkI12LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316550; c=relaxed/simple;
	bh=xpaHKeZfZOfpwPIel7Zuwp6FfoJIriKg+hGHQC+/T3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaPdzkrhASVvi0l44i6NodnVP8cK1w1O/RZnuV5R2nYOAyTkS6uI9OwZHNplnzXNYaZBvMgdKc4H2lsz0lphKF+NsG+piPsZvI2ZC/mrCGRIlKk19FfRwT/xfSnlkaI4qaDOaX6vOIlwxbQbrcDmQS4K+t4jXPBHEPSUDEqcx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjhJVYn4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778316549; x=1809852549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xpaHKeZfZOfpwPIel7Zuwp6FfoJIriKg+hGHQC+/T3A=;
  b=kjhJVYn4SaMmk5Dp0yYWjTtEjhrk9u0RAmK+HFv2R77QIW+jSq5YCIJ2
   vCgIULP0gmG5Ii6Or4RfTj+gKvBPxC+aWKaVkE6MEwd9YBzU+izvrntsR
   qWKaONTXKN74303lkXl/MXrPQRTWq6ksX/IC7YqY0TyfHXbZvqXwPRAu4
   3nmA9RP8PVZzb7ex1ujoOJUris36ofWxSRP/bWeyPDwSkLOwhYfWT1fQt
   NqSLxXTlOzzRm/Grco96AMnTC2XDMKk0RIZusBHmbGDHSytTZUbK04TJ0
   dM37lYF1dFxHKUhJV1LKnxg49eCZUGTId+ilg6DUyxrURfiJPXL+jnFJX
   A==;
X-CSE-ConnectionGUID: HP0pgf9OTE6Wpu7APfgLTA==
X-CSE-MsgGUID: HrXLHkHcRY6r4cGz14R5jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748729"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748729"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:49:08 -0700
X-CSE-ConnectionGUID: oowCH2UhQamFZYCTjM9e8g==
X-CSE-MsgGUID: YO1Rs3HZS/OJ4JDjtljZfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237088151"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2026 01:49:05 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	lorenzo@kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH RFC net-next 1/4] xdp: add mixed page_pool/page_shared memory type
Date: Sat,  9 May 2026 10:48:55 +0200
Message-Id: <20260509084858.773921-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 334684FED37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286119-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Generic XDP runs on skb-backed data. In that mode the skb head remains
owned by the skb, but XDP helpers may still release frags, for example
when a program trims a non-linear packet.

With the generic page_pool CoW path, the frags visible to XDP may be
backed by the generic system page_pool. In the fallback path, or for
other skb-backed memory, the same generic XDP rxq may still describe
page-frag based memory. Selecting MEM_TYPE_PAGE_POOL or
MEM_TYPE_PAGE_SHARED purely from the rxq therefore either lies about
page_pool ownership or misses recycling opportunities.

Add MEM_TYPE_PAGE_POOL_OR_SHARED for skb-backed generic XDP users. The
return path inspects the actual netmem: page_pool-backed netmems are
returned through their page_pool, and everything else falls back to
page_frag_free(). Transition netdev_rx_queue's xdp_rxq_info from
MEM_TYPE_PAGE_SHARED to MEM_TYPE_PAGE_POOL_OR_SHARED.

This keeps rxq identity stable for users which inspect xdp->rxq->dev and
xdp->rxq->queue_index, while avoiding per-packet rxq->mem mutation.

Respect new mem_type in __xdp_build_skb_from_frame() as veth could
redirect xdp_frame onto cpumap.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp.h |  1 +
 net/core/dev.c    |  7 ++++++
 net/core/xdp.c    | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..d60b8857e4eb 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -45,6 +45,7 @@ enum xdp_mem_type {
 	MEM_TYPE_PAGE_ORDER0,     /* Orig XDP full page model */
 	MEM_TYPE_PAGE_POOL,
 	MEM_TYPE_XSK_BUFF_POOL,
+	MEM_TYPE_PAGE_POOL_OR_SHARED,
 	MEM_TYPE_MAX,
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index e59f6025067c..6cc2a5bed20f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11207,6 +11207,13 @@ static int netif_alloc_rx_queues(struct net_device *dev)
 		err = xdp_rxq_info_reg(&rx[i].xdp_rxq, dev, i, 0);
 		if (err < 0)
 			goto err_rxq_info;
+		err = xdp_rxq_info_reg_mem_model(&rx[i].xdp_rxq,
+						 MEM_TYPE_PAGE_POOL_OR_SHARED,
+						 NULL);
+		if (err < 0) {
+			xdp_rxq_info_unreg(&rx[i].xdp_rxq);
+			goto err_rxq_info;
+		}
 	}
 	return 0;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..c57a82620520 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -22,6 +22,7 @@
 #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
 #include <trace/events/xdp.h>
 #include <net/xdp_sock_drv.h>
+#include "netmem_priv.h"
 
 #define REG_STATE_NEW		0x0
 #define REG_STATE_REGISTERED	0x1
@@ -280,6 +281,12 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 	if (!__is_supported_mem_type(type))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/* MEM_TYPE_PAGE_POOL_OR_SHARED is expected to handle pp's allocator
+	 * separately;
+	 */
+	if (type == MEM_TYPE_PAGE_POOL_OR_SHARED && allocator)
+		return ERR_PTR(-EINVAL);
+
 	mem->type = type;
 
 	if (!allocator) {
@@ -424,6 +431,23 @@ void xdp_rxq_info_attach_page_pool(struct xdp_rxq_info *xdp_rxq,
 }
 EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
 
+static bool xdp_netmem_is_pp(netmem_ref netmem)
+{
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	return netmem_is_pp(netmem);
+#else
+	return false;
+#endif
+}
+
+static void __xdp_return_page_pool(netmem_ref netmem, bool napi_direct)
+{
+	if (napi_direct && xdp_return_frame_no_direct())
+		napi_direct = false;
+
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, napi_direct);
+}
+
 /* XDP RX runs under NAPI protection, and in different delivery error
  * scenarios (e.g. queue full), it is possible to return the xdp_frame
  * while still leveraging this protection.  The @napi_direct boolean
@@ -433,20 +457,26 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp)
 {
+	netmem_ref head;
+
 	switch (mem_type) {
 	case MEM_TYPE_PAGE_POOL:
 		netmem = netmem_compound_head(netmem);
-		if (napi_direct && xdp_return_frame_no_direct())
-			napi_direct = false;
 		/* No need to check netmem_is_pp() as mem->type knows this a
 		 * page_pool page
 		 */
-		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
-					  napi_direct);
+		__xdp_return_page_pool(netmem, napi_direct);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
 		page_frag_free(__netmem_address(netmem));
 		break;
+	case MEM_TYPE_PAGE_POOL_OR_SHARED:
+		head = netmem_compound_head(netmem);
+		if (xdp_netmem_is_pp(head))
+			__xdp_return_page_pool(head, napi_direct);
+		else
+			page_frag_free(__netmem_address(netmem));
+		break;
 	case MEM_TYPE_PAGE_ORDER0:
 		put_page(__netmem_to_page(netmem));
 		break;
@@ -791,6 +821,19 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
 
+static bool xdp_mem_is_page_pool_backed(enum xdp_mem_type mem_type,
+					netmem_ref netmem)
+{
+	switch (mem_type) {
+	case MEM_TYPE_PAGE_POOL:
+		return true;
+	case MEM_TYPE_PAGE_POOL_OR_SHARED:
+		return xdp_netmem_is_pp(netmem_compound_head(netmem));
+	default:
+		return false;
+	}
+}
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
@@ -836,7 +879,8 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 
-	if (xdpf->mem_type == MEM_TYPE_PAGE_POOL)
+	if (xdp_mem_is_page_pool_backed(xdpf->mem_type,
+					virt_to_netmem(xdpf->data)))
 		skb_mark_for_recycle(skb);
 
 	/* Allow SKB to reuse area used by xdp_frame */
-- 
2.43.0


