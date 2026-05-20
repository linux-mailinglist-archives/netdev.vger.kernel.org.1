Return-Path: <netdev+bounces-290044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFWxDzQADmp+5QUAu9opvQ
	(envelope-from <netdev+bounces-290044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD28596FA8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 223773005EAD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE93E277C;
	Wed, 20 May 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr+uSAXv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F34369D7A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302110; cv=none; b=UPXxVN6kXMDnCf1WU8j/nFjoXOP/myY01JbyZdU6PryeliiPxosuKzbnKAl7WN3E/MWP5TuqWfEVEySuZOl10bXFK2vDVZPfYCbvmkQTF5sus522jWT7Qv89N0OKHJiiUfuM/MRciS+768vNiiLj+Bm3m8xJQ26pbQYwivV6a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302110; c=relaxed/simple;
	bh=8EkVcqiKRLSZfQR1zgd34BN14GMqI2CIreENkWJU7nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPESBaeFB3rfGSvcQMtWhFKrvL2Ispfr9SA6+hfHFTFuSCMIrsBltHgNduwlnrFQf5wzhN49AbKiHp3DUxS/mfQBfKTm/CkMLQZQcrSxG09gUzSAq5qUonYmccj/ILz2F8oRYWuyq/Lg8DVnB1LJGB5Jw7Kq9PLfDg1NhX4Xies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr+uSAXv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302109; x=1810838109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8EkVcqiKRLSZfQR1zgd34BN14GMqI2CIreENkWJU7nc=;
  b=kr+uSAXvcLgbUONTPIfenaW0ZJYgeK9PhMpiYr7SA5jAVm/KnsL+XxXZ
   kYPOwnwhxQT5ttRZb9x7X/CwU4PHxNYBU2+4SEvxa8dMHQmitDRo4A3B6
   ruP4DfQYziij84x8TdhaevGj0e3oxm8hHB0PELTIkRLh5U1rszfioeN05
   PzVnlaZdt5nIm25jPLMasllc8S2M0pSfcVCaEY3Wdia62yRcwYVYi2A8l
   m59VkbR8cqGDlsxgwh9rLa31WRbiqm6buJ0Qj24awwl5bDvXvEOANaoUy
   hlqWvkdogEgZ0RJaakz4ZlEhkGWg2FmdPLZlG8Vyn3gT3/0JzH7RgqLLl
   Q==;
X-CSE-ConnectionGUID: eGePQhJpSKOsy2OQ4NQDVA==
X-CSE-MsgGUID: mbmAullKQSSq5rRPM52Qng==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391744"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391744"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:07 -0700
X-CSE-ConnectionGUID: SQxaITn0T2KaYRDEc5N+qw==
X-CSE-MsgGUID: GoLJxfYyQkqxPgO4y5YI3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423886"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	Simon Horman <horms@kernel.org>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
Date: Wed, 20 May 2026 11:34:49 -0700
Message-ID: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-290044-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: AAD28596FA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kohei Enju <kohei@enjuk.jp>

ice_xdp_setup_prog() unconditionally hot-swaps xdp_prog when
ICE_VSI_REBUILD_PENDING is set. In the attach path, this can publish a
new rx_ring->xdp_prog before rx_ring->xdp_ring becomes valid while the
rebuild is pending. As a result, ice_clean_rx_irq() may dereference
rx_ring->xdp_ring too early.

With high-volume RX packets, running these commands in parallel
triggered a KASAN splat [1].
 # ethtool --reset $DEV irq dma filter offload
 # ip link set dev $DEV xdp {obj $OBJ sec xdp,off}

Fix this by rejecting XDP attach while rebuild is pending.
Keep XDP detach allowed in this window. Detach clears rx_ring->xdp_prog,
so the RX path will not attempt to access rx_ring->xdp_ring.

[1]
BUG: KASAN: slab-use-after-free in ice_napi_poll+0x3921/0x41a0
Read of size 2 at addr ffff88812475b880 by task ksoftirqd/1/23
[...]
Call Trace:
 <TASK>
 ice_napi_poll+0x3921/0x41a0
 __napi_poll+0x98/0x520
 net_rx_action+0x8f2/0xfa0
 handle_softirqs+0x1cb/0x7f0
[...]
 </TASK>

Allocated by task 7246:
 ice_prepare_xdp_rings+0x3de/0x12d0
 ice_xdp+0x61c/0xef0
 dev_xdp_install+0x3c4/0x840
 dev_xdp_attach+0x50a/0x10a0
 dev_change_xdp_fd+0x175/0x210
[...]

Freed by task 7251:
 __rcu_free_sheaf_prepare+0x5f/0x230
 rcu_free_sheaf+0x1a/0xf0
 rcu_core+0x567/0x1d80
 handle_softirqs+0x1cb/0x7f0

Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fbe111f849..f5aa31886e37 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 	}
 
 	/* hot swap progs and avoid toggling link */
-	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
-	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
+	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
 		ice_vsi_assign_bpf_prog(vsi, prog);
 		return 0;
 	}
 
+	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
+		if (prog) {
+			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
+			return -EAGAIN;
+		}
+
+		ice_vsi_assign_bpf_prog(vsi, NULL);
+		return 0;
+	}
+
 	if_running = netif_running(vsi->netdev) &&
 		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
 
-- 
2.47.1


