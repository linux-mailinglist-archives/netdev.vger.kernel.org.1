Return-Path: <netdev+bounces-191657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE8ABC8DF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891544A0635
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ECD21B9F0;
	Mon, 19 May 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWhI32jU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCB21A459
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688733; cv=none; b=Ns0lKbMs/UvkSK7RPzasvwhiHiUsqg2/HB85GKJfWkSZiqbNuLyI0YV/O5P2G5xoSr1rcDq0+yrK1aVtIFGw6y9KLvNEfhDY/O06AmdtUHwZO0NZC6mlWGE09akn2ZKKY6IXRKdizZhXJAKXCzUYq6hJs8SwdziMTl3LNyTkYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688733; c=relaxed/simple;
	bh=mLl3nJUjMjEuJb/hRxTOLrz6ylJ4Qzr24NrUUVe0+Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/VQi4rMHTBc0CbfOZMsYAa7CzubIc+JHHf7SCRSgOcaz5Axe9od0iTXmdJR8HrFczYlibRSzEET8aEX0D5XOiHOOG+q0OZiDEbBNhjh4WJoFc3/3LSsGEom2Wd7IChvq3nuQGYvkc8p7DUDEmCdtO/mlw/eiOzVVw8k4n3KL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWhI32jU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747688733; x=1779224733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLl3nJUjMjEuJb/hRxTOLrz6ylJ4Qzr24NrUUVe0+Ec=;
  b=nWhI32jUDSXN3L0aDDYUHwASPnP/U0Hfp9snH41i0mLRtYBAHKKowg2g
   P7mkLwZnmENreVSA8so5rJMsdrDZ7IOCzvL/7NxsOfTyCYzvDetsTfpaF
   uZAzDgyKe67PR+EgrT26DtpvvIQj/zhv2F4vu8xavPxxpWqriiwlPdvTt
   JyuvsLCRFtLw8E/j9CZ9G0evGzGKr3Ey8ZmZfWreG3xN7mSMGoJzeIJRb
   jfCvJxs3lKvu4UEnBvCG1HlrVfutzUucJnWzy04X4fZZxujRUB4lYxGf7
   328rqsvIp+4QkUG8Vp1iEa3OURILhTT11fMPGt8yiTSlAPpYHO1JZc9kR
   Q==;
X-CSE-ConnectionGUID: Fh4b2KhDRPazaUY+IwvX5Q==
X-CSE-MsgGUID: 6HpnqL8nSjeIzqUVOQO96w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49668541"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49668541"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:05:30 -0700
X-CSE-ConnectionGUID: uyVx2PaJT9Gh0zqExo/3OQ==
X-CSE-MsgGUID: bHT6gBLXRwyDpegyeIaNpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="140491857"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2025 14:05:30 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	anthony.l.nguyen@intel.com,
	Madhu Chititm <madhu.chittim@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 3/3] idpf: fix null-ptr-deref in idpf_features_check
Date: Mon, 19 May 2025 14:05:20 -0700
Message-ID: <20250519210523.1866503-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
References: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

idpf_features_check is used to validate the TX packet. skb header
length is compared with the hardware supported value received from
the device control plane. The value is stored in the adapter structure
and to access it, vport pointer is used. During reset all the vports
are released and the vport pointer that the netdev private structure
points to is NULL.

To avoid null-ptr-deref, store the max header length value in netdev
private structure. This also helps to cache the value and avoid
accessing adapter pointer in hot path.

BUG: kernel NULL pointer dereference, address: 0000000000000068
...
RIP: 0010:idpf_features_check+0x6d/0xe0 [idpf]
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x154/0x520
 ? exc_page_fault+0x76/0x190
 ? asm_exc_page_fault+0x26/0x30
 ? idpf_features_check+0x6d/0xe0 [idpf]
 netif_skb_features+0x88/0x310
 validate_xmit_skb+0x2a/0x2b0
 validate_xmit_skb_list+0x4c/0x70
 sch_direct_xmit+0x19d/0x3a0
 __dev_queue_xmit+0xb74/0xe70
 ...

Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Reviewed-by: Madhu Chititm <madhu.chittim@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index aef0e9775a33..70dbf80f3bb7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -143,6 +143,7 @@ enum idpf_vport_state {
  * @vport_id: Vport identifier
  * @link_speed_mbps: Link speed in mbps
  * @vport_idx: Relative vport index
+ * @max_tx_hdr_size: Max header length hardware can support
  * @state: See enum idpf_vport_state
  * @netstats: Packet and byte stats
  * @stats_lock: Lock to protect stats update
@@ -153,6 +154,7 @@ struct idpf_netdev_priv {
 	u32 vport_id;
 	u32 link_speed_mbps;
 	u16 vport_idx;
+	u16 max_tx_hdr_size;
 	enum idpf_vport_state state;
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 82f09b4030bc..3a033ce19cda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -723,6 +723,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 		np->vport = vport;
 		np->vport_idx = vport->idx;
 		np->vport_id = vport->vport_id;
+		np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
 		vport->netdev = netdev;
 
 		return idpf_init_mac_addr(vport, netdev);
@@ -740,6 +741,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	np->adapter = adapter;
 	np->vport_idx = vport->idx;
 	np->vport_id = vport->vport_id;
+	np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
 
 	spin_lock_init(&np->stats_lock);
 
@@ -2203,8 +2205,8 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 					     struct net_device *netdev,
 					     netdev_features_t features)
 {
-	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
-	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	u16 max_tx_hdr_size = np->max_tx_hdr_size;
 	size_t len;
 
 	/* No point in doing any of this if neither checksum nor GSO are
@@ -2227,7 +2229,7 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 		goto unsupported;
 
 	len = skb_network_header_len(skb);
-	if (unlikely(len > idpf_get_max_tx_hdr_size(adapter)))
+	if (unlikely(len > max_tx_hdr_size))
 		goto unsupported;
 
 	if (!skb->encapsulation)
@@ -2240,7 +2242,7 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 
 	/* IPLEN can support at most 127 dwords */
 	len = skb_inner_network_header_len(skb);
-	if (unlikely(len > idpf_get_max_tx_hdr_size(adapter)))
+	if (unlikely(len > max_tx_hdr_size))
 		goto unsupported;
 
 	/* No need to validate L4LEN as TCP is the only protocol with a
-- 
2.47.1


