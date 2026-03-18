Return-Path: <netdev+bounces-269116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJYAOs3YumkycgIAu9opvQ
	(envelope-from <netdev+bounces-269116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:54:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B472BFB20
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EECD31283B7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D39309EF2;
	Wed, 18 Mar 2026 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtWjBE0V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61463EB7FF;
	Wed, 18 Mar 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851793; cv=none; b=knnu2be7jJRKny21t18Y4thli4B+0LI/GnFg3hc3JynFzl2z9BfmVKRJBoND1hEl3gQKbW6GrA/jofZzGKUZTL8cgOPTjqi5gIrgBT22DuqpjuJOxbtDdg+xgT0x4y4gnBsMxugfSZBneKD5OxvdOS+TXpTu1D4Pzp5DcF0D9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851793; c=relaxed/simple;
	bh=dbnQ/MMu1E+QSK5rCsf9tW1qv5XIaaGwExNh2lKHdx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu/MpF5B9Is0ATCVNRGDRUXBV4jH8m7IdDuTb/p1lVokSN6ei+6csmeEbozVxjEr0mJlyZ2vmGOmFjDFDrh8hW3WByjAQXWNWsdccCG18JUooZSyfePOw0GiOXMunZefxaysCKDzhhvxEqFfUKMDvcGciUd0GyCgBvVg6JcdDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtWjBE0V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773851790; x=1805387790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbnQ/MMu1E+QSK5rCsf9tW1qv5XIaaGwExNh2lKHdx4=;
  b=DtWjBE0VWmcR28k7eVbnpuKAUmjAVirpB3AYd4vuTYxQeS1KX1zV7bGZ
   RY1z4lV/g/Zf+VKMs6M30TbqLTe/w6d4RZZvAU/tBsDwx44Qcpj+g7JVA
   4EQG1boytuc+sfusqqZR+Pd0rHisIopOUHP9693xtmO0z0varLBvLgCJM
   jxvG0GZll5KBQnnwkpLMm3JIAR99vXY62z6WgpPO+OPjsCypFLtxZ7llz
   iXRxdxodAG5gh5RfULDJQKH/5xAmkdaxDAulLgnd0IvOgrKVMGAUdJRRa
   N0P4wuwfc/ZRazabKalsu4Hp+VYA682X1BkG4UsvBCThAaMUpwTk97tUw
   Q==;
X-CSE-ConnectionGUID: dN/Lhr1YTI+8uPktZIVR2Q==
X-CSE-MsgGUID: bY7c1TIlSpesj7KwUtVbzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="62479392"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="62479392"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:36:29 -0700
X-CSE-ConnectionGUID: JbaXq9VsReu+4V0r1YipzA==
X-CSE-MsgGUID: lQ4EQzCYToqmocSB6nSDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="218687686"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2026 09:36:26 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v4 2/5] libeth: handle creating pools with unreadable buffers
Date: Wed, 18 Mar 2026 17:35:02 +0100
Message-ID: <20260318163505.31765-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318163505.31765-1-aleksander.lobakin@intel.com>
References: <20260318163505.31765-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269116-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.972];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 63B472BFB20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

libeth uses netmems for quite some time already, so in order to
support unreadable frags / memory providers, it only needs to set
PP_FLAG_ALLOW_UNREADABLE_NETMEM when needed.
Also add a couple sanity checks to make sure the driver didn't mess
up the configuration options and, in case when an MP is installed,
return the truesize always equal to PAGE_SIZE, so that
libeth_rx_alloc() will never try to allocate frags. Memory providers
manage buffers on their own and expect 1:1 buffer / HW Rx descriptor
association.

Bonus: mention in the libeth_sqe_type description that
LIBETH_SQE_EMPTY should also be used for netmem Tx SQEs -- they
don't need DMA unmapping.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/tx.h                |  2 +-
 drivers/net/ethernet/intel/libeth/rx.c | 42 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index c3db5c6f1641..a66fc2b3a114 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -12,7 +12,7 @@
 
 /**
  * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
- * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX/XSk frame, no action required
+ * @LIBETH_SQE_EMPTY: empty OR netmem/XDP_TX/XSk frame, no action required
  * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
  * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
  * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 8874b714cdcc..11e6e8f353ef 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 
 #include <net/libeth/rx.h>
+#include <net/netdev_queues.h>
 
 /* Rx buffer management */
 
@@ -139,9 +140,47 @@ static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
 	fq->buf_len = clamp(mtu, LIBETH_RX_BUF_STRIDE, max);
 	fq->truesize = fq->buf_len;
 
+	/*
+	 * Allow frags only for kernel pages. `fq->truesize == pp->max_len`
+	 * will always fall back to regular page_pool_alloc_netmems()
+	 * regardless of the MTU / FQ buffer size.
+	 */
+	if (pp->flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM)
+		fq->truesize = pp->max_len;
+
 	return true;
 }
 
+/**
+ * libeth_rx_page_pool_check_unread - check input params for unreadable MPs
+ * @fq: buffer queue to check
+ * @pp: &page_pool_params for the queue
+ *
+ * Make sure we don't create an invalid pool with full-frame unreadable
+ * buffers, bidirectional unreadable buffers or so, and configure the
+ * ZC payload pool accordingly.
+ *
+ * Return: true on success, false on invalid input params.
+ */
+static bool libeth_rx_page_pool_check_unread(const struct libeth_fq *fq,
+					     struct page_pool_params *pp)
+{
+	if (!netif_rxq_has_unreadable_mp(pp->netdev, pp->queue_idx))
+		return true;
+
+	/* For now, the core stack doesn't allow XDP with unreadable frags */
+	if (fq->xdp)
+		return false;
+
+	/* It should be either a header pool or a ZC payload pool */
+	if (fq->type == LIBETH_FQE_HDR)
+		return !fq->hsplit;
+
+	pp->flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+
+	return fq->hsplit;
+}
+
 /**
  * libeth_rx_fq_create - create a PP with the default libeth settings
  * @fq: buffer queue struct to fill
@@ -165,6 +204,9 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 	struct page_pool *pool;
 	int ret;
 
+	if (!libeth_rx_page_pool_check_unread(fq, &pp))
+		return -EINVAL;
+
 	pp.dma_dir = fq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!fq->hsplit)
-- 
2.53.0


