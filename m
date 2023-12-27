Return-Path: <netdev+bounces-60418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA481F20B
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78819B2271A
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9B481BA;
	Wed, 27 Dec 2023 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="er6UAdYn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC0481A5
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703710854; x=1735246854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkOVBtiHHSFV5B+PzTkEmmm0ZUgXWMJLdMkWHudIaxo=;
  b=er6UAdYnm0Stq5PRmNHpIpXD0yMekANfnRc2CKonkN8Owo8lGMIR0P7q
   9D5+mkmbn6pYKxabnvgdGaLgtYBCHUe19w61Dn3r+j+ESSGmZhX5rXXGt
   yOP16NVJ235+bvmknTGN+FLg78JNQG+LbIHEiL+GUoPCrouqcaFgZsIWr
   t/qa33o3Fpc+91w6bcq7LB1x+5YRMb0GWFPjgiskgkEDsYsh6r1qTWOR2
   ItQAatU1kmYmdICDfXPytYj3Q2eB2Mc6bwXnJEhx8QH43NKMmaPEoo403
   ESdZygV/E1oOuescIVLcPyVut2PcK4CKk4/KZbR1XpSD5yeisxRujd9wT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427655629"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="427655629"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 13:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="844258791"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="844258791"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2023 13:00:50 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	bigeasy@linutronix.de,
	sasha.neftin@intel.com,
	Suman Ghosh <sumang@marvell.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 3/3] igc: Check VLAN EtherType mask
Date: Wed, 27 Dec 2023 13:00:40 -0800
Message-ID: <20231227210041.3035055-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231227210041.3035055-1-anthony.l.nguyen@intel.com>
References: <20231227210041.3035055-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

Currently the driver accepts VLAN EtherType steering rules regardless of
the configured mask. And things might fail silently or with confusing error
messages to the user. The VLAN EtherType can only be matched by full
mask. Therefore, add a check for that.

For instance the following rule is invalid, but the driver accepts it and
ignores the user specified mask:
|root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
|             m 0x00ff action 0
|Added rule with ID 63
|root@host:~# ethtool --show-ntuple enp3s0
|4 RX rings available
|Total 1 rules
|
|Filter: 63
|        Flow Type: Raw Ethernet
|        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
|        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
|        Ethertype: 0x0 mask: 0xFFFF
|        VLAN EtherType: 0x8100 mask: 0x0
|        VLAN: 0x0 mask: 0xffff
|        User-defined: 0x0 mask: 0xffffffffffffffff
|        Action: Direct to queue 0

After:
|root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
|             m 0x00ff action 0
|rmgr: Cannot insert RX class rule: Operation not supported

Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
Suggested-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index b56b4f338bd3..859b2636f3d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1357,6 +1357,14 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
+	/* VLAN EtherType can only be matched by full mask. */
+	if ((fsp->flow_type & FLOW_EXT) &&
+	    fsp->m_ext.vlan_etype &&
+	    fsp->m_ext.vlan_etype != ETHER_TYPE_FULL_MASK) {
+		netdev_dbg(netdev, "VLAN EtherType mask not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (fsp->location >= IGC_MAX_RXNFC_RULES) {
 		netdev_dbg(netdev, "Invalid location\n");
 		return -EINVAL;
-- 
2.41.0


