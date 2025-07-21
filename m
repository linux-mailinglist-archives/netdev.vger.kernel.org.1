Return-Path: <netdev+bounces-208662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E250DB0C9C9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E096C14E6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04F2E175E;
	Mon, 21 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqacwGSX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B32E11C9
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119464; cv=none; b=Z2aPETcPR9Eeq8Pj1gYHJRjUp3yy2cNMD7LPy1RCPv/tzJFFglW+F1yVVKvPVSI9zpOvLELrCj57GVSIfu1L4S/v4eSpzcRig6aZ6578C/L4CuQiaYKSZ/XxO3OSJXxPaQiubgFogY3vL+ITwD4sC+7CkdYE8ZT+RE0Mz0cFf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119464; c=relaxed/simple;
	bh=BOR1dQj5NGE9DCwLfxqJ0//1stXhs135nL4odxX6UHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHcQu1nKYTf7Kb8MdEEfk24HAYZtYNtC5cMvnSqfDFBFmVktgbhuVaImFVjexkW8FGTtv5HjtejP1BDzNWSYWnM74Ojmf1iHJqzbt2gmmIXu6q+ZVgkuIFJWznEKTzAfnFNXpkrLWFHPiFJK8I/hlTv1sSslAX5tBhLxlwI86rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqacwGSX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119463; x=1784655463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOR1dQj5NGE9DCwLfxqJ0//1stXhs135nL4odxX6UHU=;
  b=gqacwGSXtXcXCwLuuhXxMw3403r7Or+rXgIqa64hN0qzOS9N5k554VX/
   K3e3ZqWqMHvaWRpJW/ROrAL5rU3SWO1AOnhwVVvmwe2RGRi+sJIANTh6Z
   UGog3fmawiAECDik1OS8o2FFBtTPMGXYLxTxmB/dBg34yiqanoeBF1//V
   GJcXOpxe8WbjsTgAaCbabhPcLuFTAJiVdxti0DO2GKX+lHO5r8YkUYEj/
   wJlXV9nhUMdZriqpstNNcO4FS0kx9tO0RkSu851oHgKyeFPQr+CQ/RRtU
   dN71zKF9mSfJXCleCUoPWHMHc/PY1+51vTJWWX3epeSQyfWHdBgaRtG9I
   A==;
X-CSE-ConnectionGUID: YYORtrI4QiGZWE0nNQWITA==
X-CSE-MsgGUID: C1ANxLpnQB6Pv2KvborX9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55193176"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55193176"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:37:41 -0700
X-CSE-ConnectionGUID: LzexD5yKSjiSTPvavm2syA==
X-CSE-MsgGUID: WDLl7788Sd6hUxL0p88buQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158231560"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 10:37:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dennis Chen <dechen@redhat.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/5] i40e: report VF tx_dropped with tx_errors instead of tx_discards
Date: Mon, 21 Jul 2025 10:37:22 -0700
Message-ID: <20250721173733.2248057-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
References: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dennis Chen <dechen@redhat.com>

Currently the tx_dropped field in VF stats is not updated correctly
when reading stats from the PF. This is because it reads from
i40e_eth_stats.tx_discards which seems to be unused for per VSI stats,
as it is not updated by i40e_update_eth_stats() and the corresponding
register, GLV_TDPC, is not implemented[1].

Use i40e_eth_stats.tx_errors instead, which is actually updated by
i40e_update_eth_stats() by reading from GLV_TEPC.

To test, create a VF and try to send bad packets through it:

$ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
$ cat test.py
from scapy.all import *

vlan_pkt = Ether(dst="ff:ff:ff:ff:ff:ff") / Dot1Q(vlan=999) / IP(dst="192.168.0.1") / ICMP()
ttl_pkt = IP(dst="8.8.8.8", ttl=0) / ICMP()

print("Send packet with bad VLAN tag")
sendp(vlan_pkt, iface="enp2s0f0v0")
print("Send packet with TTL=0")
sendp(ttl_pkt, iface="enp2s0f0v0")
$ ip -s link show dev enp2s0f0
16: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
    vf 0     link/ether e2:c6:fd:c1:1e:92 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
    RX: bytes  packets  mcast   bcast   dropped
             0        0       0       0        0
    TX: bytes  packets   dropped
             0        0        0
$ python test.py
Send packet with bad VLAN tag
.
Sent 1 packets.
Send packet with TTL=0
.
Sent 1 packets.
$ ip -s link show dev enp2s0f0
16: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
    vf 0     link/ether e2:c6:fd:c1:1e:92 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
    RX: bytes  packets  mcast   bcast   dropped
             0        0       0       0        0
    TX: bytes  packets   dropped
             0        0        0

A packet with non-existent VLAN tag and a packet with TTL = 0 are sent,
but tx_dropped is not incremented.

After patch:

$ ip -s link show dev enp2s0f0
19: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
    vf 0     link/ether 4a:b7:3d:37:f7:56 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
    RX: bytes  packets  mcast   bcast   dropped
             0        0       0       0        0
    TX: bytes  packets   dropped
             0        0        2

Fixes: dc645daef9af5bcbd9c ("i40e: implement VF stats NDO")
Signed-off-by: Dennis Chen <dechen@redhat.com>
Link: https://www.intel.com/content/www/us/en/content-details/596333/intel-ethernet-controller-x710-tm4-at2-carlsville-datasheet.html
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 88e6bef69342..2dbe38eb9494 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -5006,7 +5006,7 @@ int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
 	vf_stats->rx_dropped = stats->rx_discards + stats->rx_discards_other;
-	vf_stats->tx_dropped = stats->tx_discards;
+	vf_stats->tx_dropped = stats->tx_errors;
 
 	return 0;
 }
-- 
2.47.1


