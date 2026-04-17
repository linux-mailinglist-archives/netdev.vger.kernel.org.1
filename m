Return-Path: <netdev+bounces-279241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE+TMonT4Wl+ygAAu9opvQ
	(envelope-from <netdev+bounces-279241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B84176EE
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E6ED3030AC6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930736E48B;
	Fri, 17 Apr 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwrdpX4K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756B2E173B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407404; cv=none; b=fhECn3/5dHbqPAjLhKeJQc6AKHgERw2HFcCXz90yUzQQsy9GTozYLf5mNXzQe2xn6KJmzxjmsh8rlDRD9NvmkHbuYnnNOyVnkg2kqXBdWHnkWGyWB8sGAFAAOJM7cmB0q2ufysiFMf5uxDeZgHj6U4m4J9KI5pDASQC1ohN1+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407404; c=relaxed/simple;
	bh=NtB753eXsLk4+qxyJOoMbmx22XzwyHTBNlffDqorEjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5XUU4Uvub2Mt9mBnerKevLaCoSFQBTBM883lLCgQ3Z8ChpeFrvDW2JXh4MwnZ5EVg7yLHOjG5W2HMXwl6FcFqSBWsLJlbGjSjSpiZNF48wNDSxtadFb8io60nhiCvzuxdsLBM92Rxkpp+NT7jH0NrbNiA4eg59k51s/PLKfU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UwrdpX4K; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776407403; x=1807943403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NtB753eXsLk4+qxyJOoMbmx22XzwyHTBNlffDqorEjs=;
  b=UwrdpX4KMQSJle34+8SCLsGP/UFn7N0Z8vKyHqdu2/x3FySiAKlO4q96
   eyaZfwLOOIdTl25oq3mqjTHDFahHFej5zU2cHcQIaFZVr7r6OEC1jDpYr
   gsy6MPnbepEQ67ASfuxr6pAYucK0ZdSHTFvi1P6InAWy7COeg+6VOI1CT
   QtiZ3wIxl2iznC64aFsusa+D+jpqluiO4n8Kyjp0d8ZkTAqR0W0QtDjsR
   uZTY6yPO1Po0GeSA0REG4kJpRquNuh06fVe+l2ZgUHpkSgPELglD9BzPF
   gfnNizlbKhRjv1y9iZLCfAsEdRLeR/rYmQNFb2wxyoQTQcjcwu5Ntn3TA
   A==;
X-CSE-ConnectionGUID: TC071SBQRqC6aUSEbmRiDQ==
X-CSE-MsgGUID: tR0tPNRrTT6rSbHYRXDXiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94987412"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="94987412"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 23:30:03 -0700
X-CSE-ConnectionGUID: 5YymVZ47SJy22yljnjz78w==
X-CSE-MsgGUID: kbhWPzO0R0CEJgxzkM5zIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235329594"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 23:30:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>
Subject: [PATCH iwl-net 4/4] ice: report EIPE checksum errors to the OS on E830
Date: Fri, 17 Apr 2026 08:29:54 +0200
Message-ID: <20260417062954.1241900-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279241-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 085B84176EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jan Glaza <jan.glaza@intel.com>

For E830 adapters the hardware-reported EIPE (Ethernet Inline IPsec
Engine) error is a reliable indication that a received packet failed
decryption and has a bad checksum. Route EIPE errors through the
generic checksum error path on E830 so the error is visible via
standard ethtool statistics (rx_csum_bad).

On previous devices (E810, E82X) the EIPE flag can be spuriously set
on encapsulated packets with inner L2 padding, so those adapters only
increment the driver-private hw_rx_eipe_error counter without routing
through the checksum error path.

Fixes: 0ca6755f3cc2 ("ice: Add a new counter for Rx EIPE errors")
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a66..82d9d2c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -140,6 +140,8 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,

 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S)))) {
 		ring->vsi->back->hw_rx_eipe_error++;
+		if (ring->vsi->back->hw.mac_type == ICE_MAC_E830)
+			goto checksum_fail;
 		return;
 	}

--
2.52.0


