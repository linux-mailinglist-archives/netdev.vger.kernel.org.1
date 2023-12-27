Return-Path: <netdev+bounces-60417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21981F20A
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D721F283D18
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2E47F74;
	Wed, 27 Dec 2023 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9HTq1a8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64BA47F79
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703710853; x=1735246853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nKyql3JnxiWRIMFBGYJM4PR+5jR0SLd62DuZrCqpGJk=;
  b=Z9HTq1a8n/L+NuBE78/q2SqVA4BXdwY8DvrPn1QF7o7ROvjnVWeH927n
   ciE3DMscfiDm1u8CLl/qcuVlLNANgrqRQvP44vDII+UJPI9ZT7zbMjDhn
   C9dR/zbSV0505Z/KktYM8DVKWIsTnB/EDSRFJ215uhgW7yR+37bqzmYh+
   LFCT/vO0ywlS/00F1gtxjAgLtrUsyNNPAd2zOmYxW3+8okS4nHjDPyOn/
   F8mbY6WimmswNBif8/0Hmu1camoRFRj9sEy/F1CLVcXswe5YR4MOnrJzi
   mupxvalC9o7A+LMVYI8Y0VRtcVJWDVNwTOMYx7BfAzEXnPNyir/H62fNk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427655624"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="427655624"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 13:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="844258783"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="844258783"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2023 13:00:48 -0800
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
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 1/3] igc: Report VLAN EtherType matching back to user
Date: Wed, 27 Dec 2023 13:00:38 -0800
Message-ID: <20231227210041.3035055-2-anthony.l.nguyen@intel.com>
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

Currently the driver allows to configure matching by VLAN EtherType.
However, the retrieval function does not report it back to the user. Add
it.

Before:
|root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 action 0
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
|        Action: Direct to queue 0

After:
|root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 action 0
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

Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 785eaa8e0ba8..69b2fd006293 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -980,6 +980,12 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 		fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
 	}
 
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
+		fsp->flow_type |= FLOW_EXT;
+		fsp->h_ext.vlan_etype = rule->filter.vlan_etype;
+		fsp->m_ext.vlan_etype = ETHER_TYPE_FULL_MASK;
+	}
+
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
 		fsp->flow_type |= FLOW_EXT;
 		fsp->h_ext.vlan_tci = htons(rule->filter.vlan_tci);
-- 
2.41.0


