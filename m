Return-Path: <netdev+bounces-169238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CFA430C7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32C319C2EEE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B120DD5C;
	Mon, 24 Feb 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBdmB9UN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2D20C488
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439379; cv=none; b=VrIp0yN4N1leIgim/oz2lNShSylfHFtAfRy9vmtVyCoIev2pvX9zZQDSn/VXGUaTZMf/vVprhxYqdrUSMYxsDqZv3Z1f6owRIhTwL/vCFyv0gJsLjxQBiIDpZyQSYIDP/Ez16SXjp5loMRAqqC4o6f/jXEoTTtlG0Crv1Q5RFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439379; c=relaxed/simple;
	bh=px76OAKhgZmmeVDE182uPBGn4Uz+NTY8NrjlGyT0PZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3u+kwCZhjZlZwmnHn6r/w2UYtqxcyMycVyPfUUSGjPfTDSjDKV0YppekzTrXqND4bVC4SgC4Akzv4sGv85+lz8N6FLY/5OVEedbAVYFFBmxJv2wBy06jj21r4c1OdoEFcIUPNK/QikJyYkUraByiZaoTCzBqNrDmgtvxG9zuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBdmB9UN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740439378; x=1771975378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=px76OAKhgZmmeVDE182uPBGn4Uz+NTY8NrjlGyT0PZc=;
  b=DBdmB9UNET3CiO5gi45E27B8+PxQZByY0qZfStLUWxpp9dfm7NSLNepZ
   m/EnvOxj6LYifznEXm23CCU5/0h2P2qLAcx4gdfGnsl+rS06iEfOcoKTx
   fvsk6dn7dVM9CHwpgu9LZ4cwUAojAkQkzTpxSOyC7RniT/o3VWsn8/4bc
   YRanyYwOxD6Os1/5a2dWs1WohddU1LPiaNgDaaK8+H6V5xuJqRWBllY4f
   I7c6y5ifeGwSANJySLsW/GwNis93avMLeNJZsjbP0v8ZRyFJ4AuJNBsOX
   Np8rGKAfI/am8Rh9zz2f/DFLjamH7N0rdfxSQr+4RMkcEwQpF8/+ErFrs
   A==;
X-CSE-ConnectionGUID: bRR/Hb46RUWxdxXYFzRdxw==
X-CSE-MsgGUID: m9sPAuEzTWKi2eao/vPBSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40406665"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40406665"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:58 -0800
X-CSE-ConnectionGUID: ZI7rYxL8RReLWZTVI5gajQ==
X-CSE-MsgGUID: 0x5/LraESpCUouY1ZeNYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115997805"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.244.43])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:52 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v9 3/6] ice: clear NAPI's IRQ numbers in ice_vsi_clear_napi_queues()
Date: Mon, 24 Feb 2025 16:22:24 -0700
Message-ID: <20250224232228.990783-4-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224232228.990783-1-ahmed.zaki@intel.com>
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We set the NAPI's IRQ number in ice_vsi_set_napi_queues(). Clear the
NAPI's IRQ in ice_vsi_clear_napi_queues().

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7f5b229cab05..ce30674abf8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2765,11 +2765,18 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 {
 	struct net_device *netdev = vsi->netdev;
-	int q_idx;
+	int q_idx, v_idx;
 
 	if (!netdev)
 		return;
 
+	/* Clear the NAPI's interrupt number */
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
+
+		netif_napi_set_irq(&q_vector->napi, -1);
+	}
+
 	ice_for_each_txq(vsi, q_idx)
 		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX, NULL);
 
-- 
2.43.0


