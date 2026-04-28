Return-Path: <netdev+bounces-281697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFqJIm5m8GkKTAEAu9opvQ
	(envelope-from <netdev+bounces-281697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:49:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102947F3CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25EB8300D555
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D02DAFCC;
	Tue, 28 Apr 2026 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLqvc++F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3932DCC01
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362522; cv=none; b=H5EEL0ThbnZQkr/W3+zF3J78/kEE61hA4VCTciajmiG8NZ4q+vmxVbBNp8uwaWoeJKV/+9Xbmd3lldph4FwtnNmTqmNY+m7sAcRyWgmU40uyGGSBkguizycaUlrn44eKBmWYMz4T5ZCJByxW9IIDhF3PMnaNezL9lmPmGHiEqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362522; c=relaxed/simple;
	bh=89VxZuTuAfq1TCEMT31Kq1wu5QB4YSBR1QkGpSsfP4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poDk+aSgIT3kOv946wRvsKf9vRsRA6JlWNVwT2wWPr6ffG12A9PWlLepaGRdcJva8ao10zbCB6u3XMaJc78GntpiX1jA3NEo/KGmLax56qf/KkxAEedPltu5sgDsjE+HJLSssD4zf4f4+/aeCx4oDmQLtOrY+ofPWnKxoBUG9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLqvc++F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777362522; x=1808898522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=89VxZuTuAfq1TCEMT31Kq1wu5QB4YSBR1QkGpSsfP4Y=;
  b=ZLqvc++FnAsxpdsJBpfD2Y7dtlR9tMDhJblSsLzeiBCpSRJ6PqOWnuKo
   MSG6+GIM9J9QCO98pbjvtwO6Lb3qERF33AY5RGaiorsp6GxUpLF3yMs3p
   Yx2hZ27tjDlWAjuJhWuYwir+IoSlDQFc/QLh44+MxPY1TqMgPn57OU1Uh
   6a9nxkpPpDshqA/W7sJKKmStZ+wpbUHeK0DTLLTjDOaVdEy6PYBCoUyUM
   XZ6z+h4BvZi4J5wy7ofZ7eI92ejK3TprzjohnWvEWDqg3AUk0rLpCwshB
   M1s7hgHBZTI48qVHnk8+7OxWMBitECasFwA9eqbBgBRJaMJgOEiIyr7cD
   g==;
X-CSE-ConnectionGUID: 4VS0FKgWS6CmMzBOQH/tQg==
X-CSE-MsgGUID: TiHOdHWeSHqxgGT+/8i7hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82114976"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82114976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:48:41 -0700
X-CSE-ConnectionGUID: oZxoNrDDT2KD76jnox+vpA==
X-CSE-MsgGUID: RZOxA7l0Sb+HUeBPeYePMQ==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2026 00:48:39 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jramaseu@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1 1/2] ice: always do GCS if hardware supports it
Date: Tue, 28 Apr 2026 09:06:46 +0200
Message-ID: <20260428070647.777141-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9102947F3CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281697-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

There is no need to check for NETIF_HW_CSUM. If the code reach
calculating checksum it means that correct checksum flags are set,
because kernel is checking that when setting ip->summed.

Instead of netdev feature flag use Tx ring flag to check if the hardware
can use special descriptor for checksum calculating.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++++
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 837b71b7b2b7..033fabc22f58 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1415,6 +1415,10 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, ring->flags);
 		else
 			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG1, ring->flags);
+
+		if (ice_is_feature_supported(pf, ICE_F_GCS))
+			set_bit(ICE_TX_RING_FLAGS_GCS, ring->flags);
+
 		WRITE_ONCE(vsi->tx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4ca1a0602307..25b19a5d817e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1743,7 +1743,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	l3_len = l4.hdr - ip.hdr;
 	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;
 
-	if ((tx_ring->netdev->features & NETIF_F_HW_CSUM) &&
+	if (test_bit(ICE_TX_RING_FLAGS_GCS, tx_ring->flags) &&
 	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
 	    !skb_csum_is_sctp(skb)) {
 		/* Set GCS */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5e517f219379..15dbd5100912 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -217,6 +217,7 @@ enum ice_tx_ring_flags {
 	ICE_TX_RING_FLAGS_VLAN_L2TAG1,
 	ICE_TX_RING_FLAGS_VLAN_L2TAG2,
 	ICE_TX_RING_FLAGS_TXTIME,
+	ICE_TX_RING_FLAGS_GCS,
 	ICE_TX_RING_FLAGS_NBITS,
 };
 
-- 
2.49.0


