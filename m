Return-Path: <netdev+bounces-263463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL/KFv5qp2mYhQAAu9opvQ
	(envelope-from <netdev+bounces-263463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:13:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2A1F84BC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D353073D87
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7183976AF;
	Tue,  3 Mar 2026 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkyU6wwH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A94372663
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579528; cv=none; b=ceWJ8BdvLYuj6V3miZe5ic7OI2PFiTENYwCRS+ArWpzaDZmdk+moYvWYkqezeuPLIk8uMW7nuKSSOFQXUWIZtdW1YtGepBTVjGE7Ryk/qpEQt5oDhBmqrteZNd1vLY7/ShnjVpbacXvTUiq86kqeQx6fCAjP1dLeLikOlbFSY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579528; c=relaxed/simple;
	bh=onhqJX9+a5sXlXSz+wILYCbmCu88Ih2o/fW5SaaKGSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqTXwJlr2pY7ZfsMhjcWDsepNa4nMM6n6WuGUdxoNqrFagzT7SEk6YJa9LVaSBpVLb+lqsU09TG2zWSR6Xf49UshJIGaDeX2YZhn1eO+HEDf0j9VU84gQgSh4FKe/0a+TtWM5DhuCkxgH4BjCLMhLZvoq3gbFpn1Hg/2N0lspnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkyU6wwH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579526; x=1804115526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onhqJX9+a5sXlXSz+wILYCbmCu88Ih2o/fW5SaaKGSs=;
  b=HkyU6wwHmeEFV8r3SKQT+YKYrtOUbQLJzS0TvO6m86Vb7hoLWlngPTbR
   hGzEPkaKOzFfKThZDlaNOWmo4Omh7RGyFt/g/dqZCtnoeNi+l5Ut2AQ6x
   HSF7MhQoL4e3zTK71/hDfMwD3ME6uQp0k66is/LUcGo0Ec6hlRKzJCHs3
   wRm1nvtcvmsdLP+zozUJUIieOkmXLxDm0GczZEJKgNWg0HrdRoCfKdbpt
   WmIC35sflIOLz5Fwi6hAJhlinOD1IT/qrAuc/gESeN5slRT1q8fpIopnt
   b0Q/F6NGzRXV8d6hhcLxN2WraH8PKYUY+eVjw0gb95FBBqbHNuPo0+VJq
   g==;
X-CSE-ConnectionGUID: J7OC6yQrTRyZCiydPeXXVA==
X-CSE-MsgGUID: zZKbB6T3SKOqrvzsjomVPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238826"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238826"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:59 -0800
X-CSE-ConnectionGUID: YSERJsW1QyKltEt9aRvIDw==
X-CSE-MsgGUID: PzwnZdSoTxaWOMKj1sdawQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633813"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:11:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kohei.enju@gmail.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/8] iavf: fix netdev->max_mtu to respect actual hardware limit
Date: Tue,  3 Mar 2026 15:11:52 -0800
Message-ID: <20260303231155.2895065-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12E2A1F84BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[enjuk.jp,intel.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-263463-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Kohei Enju <kohei@enjuk.jp>

iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
from PF [1]. This allows setting an MTU beyond the actual hardware
limit, causing TX queue timeouts [2].

Set correct netdev->max_mtu using vf_res->max_mtu from the PF.

Note that currently PF drivers such as ice/i40e set the frame size in
vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
netdev->max_mtu.

[1]
 # ip -j -d link show $DEV | jq '.[0].max_mtu'
 16356

[2]
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 ...

Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index bceaf4b1b85d..86c1964f42e1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2793,7 +2793,22 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = LIBIE_MAX_MTU;
+
+	/* PF/VF API: vf_res->max_mtu is max frame size (not MTU).
+	 * Convert to MTU.
+	 */
+	if (!adapter->vf_res->max_mtu) {
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else if (adapter->vf_res->max_mtu < LIBETH_RX_LL_LEN + ETH_MIN_MTU ||
+		   adapter->vf_res->max_mtu >
+			   LIBETH_RX_LL_LEN + LIBIE_MAX_MTU) {
+		netdev_warn_once(adapter->netdev,
+				 "invalid max frame size %d from PF, using default MTU %d",
+				 adapter->vf_res->max_mtu, LIBIE_MAX_MTU);
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else {
+		netdev->max_mtu = adapter->vf_res->max_mtu - LIBETH_RX_LL_LEN;
+	}
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
-- 
2.47.1


