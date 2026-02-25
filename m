Return-Path: <netdev+bounces-261052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB6KCjk9n2kiZgQAu9opvQ
	(envelope-from <netdev+bounces-261052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:19:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B275919C2A8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5F6C30CEAC2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A32F0C48;
	Wed, 25 Feb 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZnWqbyI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480E3D905A;
	Wed, 25 Feb 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043470; cv=none; b=L6HPdTjf5h8wPX2M4zbtGnlJtr2DzHlJxE/svllDRQ0J+Q/mPpXqtLAmshd8pErSP4i2Ej7UwFlHp2+o2qKuT7CUcpGPEQ/7aulZN2+qv26CG6BTYlDLdsxuQ3qoDrCYlfOTietAwXaYun21/e1587hhcaWV6JEMWv2uKpo6yyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043470; c=relaxed/simple;
	bh=2wzvXiUB6GHdMgSixEuavuGnCIhfYzTsdE5DIR4YvLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1VahPON1lbgyuRMMVNGxN3gIok+TcLRJ2yqYrrR5iJuCaK+nOyzTjSr/b4twtuR+5BubrqgKYhN834yMdTLyMAUve9mChk+U/Esor6NTzawBZ3YcF5KckgeTgbZn5zd0i1k5a7708Q7AnngKEHmoN7nobG3fDKOc88eW9UfUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZnWqbyI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772043464; x=1803579464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2wzvXiUB6GHdMgSixEuavuGnCIhfYzTsdE5DIR4YvLk=;
  b=VZnWqbyIewtIDGMZ55MjwmZa8BUmBzLhwBsOi6dg6DGjACObbUPsxf8r
   Wcy4jFe+KcnupQWad3FVdET0KRMK2UYAyoJ+EkRcBrvox8c9TeCz1CXD6
   qYiGrnZbyCeYgSVQdfYEOcYHOb/zMU/g+P+Z7ydBzQ2+Qi+Sf7NgRM50/
   27GWvrCY6dlqWfL13oQVxtVaeBC7raMdcG6yI9k5FY+E95cPLuR7/c7zd
   E2VyoIl0H/xPRU2lxlOWesZBQ6jTADHbaR/ONjD4cv6umorEpcOHA8xWa
   WvAY51Pd5b9cyWKotQXym8kIDoX32RU7h+eobqjCnHM+rKfN+8lH13MZK
   g==;
X-CSE-ConnectionGUID: 4y37YwtIQCuN2ojGoEZpOw==
X-CSE-MsgGUID: ZoJsnIFySJev9BS3bDV0Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76928013"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="76928013"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 10:17:42 -0800
X-CSE-ConnectionGUID: pCow/N1CRd+XulMm3wlecg==
X-CSE-MsgGUID: UJLpy17/T0Culv0nZQa+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="216337830"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 25 Feb 2026 10:17:39 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7DD5D32C86;
	Wed, 25 Feb 2026 18:17:37 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 09/10] ixgbevf: reconfigure page pool when reallocating buffers
Date: Wed, 25 Feb 2026 18:46:43 +0100
Message-ID: <20260225174646.3514556-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225174646.3514556-1-larysa.zaremba@intel.com>
References: <20260225174646.3514556-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-261052-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B275919C2A8
X-Rspamd-Action: no action

Currently, when MTU is changed, page pool is not reconfigured, which leads
to usage of suboptimal buffer sizes.

Always destroy page pool when cleaning the ring up and create it anew when
we first allocate Rx buffers.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 67 +++++++++----------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index b9a9607d1314..606c6123d7eb 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1660,6 +1660,12 @@ static void ixgbevf_rx_destroy_pp(struct ixgbevf_ring *rx_ring)
 		.fqes	= rx_ring->rx_fqes,
 	};
 
+	if (!fq.pp)
+		return;
+
+	xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+
 	libeth_rx_fq_destroy(&fq);
 	rx_ring->rx_fqes = NULL;
 	rx_ring->pp = NULL;
@@ -1710,6 +1716,14 @@ static int ixgbevf_rx_create_pp(struct ixgbevf_ring *rx_ring)
 	rx_ring->truesize = fq.truesize;
 	rx_ring->rx_buf_len = fq.buf_len;
 
+	/* XDP RX-queue info */
+	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
+				 rx_ring->queue_index, 0, rx_ring->truesize);
+	if (ret)
+		goto err;
+
+	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, rx_ring->pp);
+
 	if (!fq.hsplit)
 		return 0;
 
@@ -1779,6 +1793,8 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
+	ixgbevf_rx_create_pp(ring);
+
 	/* RXDCTL.RLPML does not work on 82599 */
 	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
 		u32 pkt_len =
@@ -2271,8 +2287,10 @@ static void ixgbevf_clean_all_rx_rings(struct ixgbevf_adapter *adapter)
 {
 	int i;
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < adapter->num_rx_queues; i++) {
 		ixgbevf_clean_rx_ring(adapter->rx_ring[i]);
+		ixgbevf_rx_destroy_pp(adapter->rx_ring[i]);
+	}
 }
 
 /**
@@ -3293,6 +3311,11 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 	return err;
 }
 
+static struct device *ixgbevf_dma_dev_from_ring(struct ixgbevf_ring *ring)
+{
+	return &ring->q_vector->adapter->pdev->dev;
+}
+
 /**
  * ixgbevf_setup_rx_resources - allocate Rx resources
  * @adapter: board private structure
@@ -3303,43 +3326,25 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 			       struct ixgbevf_ring *rx_ring)
 {
-	int ret;
-
-	ret = ixgbevf_rx_create_pp(rx_ring);
-	if (ret)
-		return ret;
-
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
 	rx_ring->dma_size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
 	rx_ring->dma_size = ALIGN(rx_ring->dma_size, 4096);
 
-	rx_ring->desc = dma_alloc_coherent(rx_ring->pp->p.dev,
+	rx_ring->desc = dma_alloc_coherent(ixgbevf_dma_dev_from_ring(rx_ring),
 					   rx_ring->dma_size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc) {
-		ret = -ENOMEM;
-		goto err;
+		dev_err(rx_ring->dev,
+			"Unable to allocate memory for the Rx descriptor ring\n");
+		return -ENOMEM;
 	}
 
-	/* XDP RX-queue info */
-	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
-				 rx_ring->queue_index, 0, rx_ring->truesize);
-	if (ret)
-		goto err;
-
-	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, rx_ring->pp);
-
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
-err:
-	ixgbevf_rx_destroy_pp(rx_ring);
-	dev_err(rx_ring->dev, "Unable to allocate memory for the Rx descriptor ring\n");
-
-	return ret;
 }
 
 /**
@@ -3380,24 +3385,14 @@ static int ixgbevf_setup_all_rx_resources(struct ixgbevf_adapter *adapter)
  **/
 void ixgbevf_free_rx_resources(struct ixgbevf_ring *rx_ring)
 {
-	struct libeth_fq fq = {
-		.fqes	= rx_ring->rx_fqes,
-		.pp	= rx_ring->pp,
-	};
-
 	ixgbevf_clean_rx_ring(rx_ring);
-
+	ixgbevf_rx_destroy_pp(rx_ring);
 	rx_ring->xdp_prog = NULL;
-	xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
-	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 
-	dma_free_coherent(fq.pp->p.dev, rx_ring->dma_size, rx_ring->desc,
+	dma_free_coherent(ixgbevf_dma_dev_from_ring(rx_ring),
+			  rx_ring->dma_size, rx_ring->desc,
 			  rx_ring->dma);
 	rx_ring->desc = NULL;
-
-	libeth_rx_fq_destroy(&fq);
-	rx_ring->rx_fqes = NULL;
-	rx_ring->pp = NULL;
 }
 
 /**
-- 
2.52.0


