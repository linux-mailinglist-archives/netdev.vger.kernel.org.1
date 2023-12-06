Return-Path: <netdev+bounces-54453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C901A8071C3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09E52814C4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A93A8FA;
	Wed,  6 Dec 2023 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GcqNaTUt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYpP6LAQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3CD1
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:07:28 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701871646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q2jnrPRUFhsAeYH7XvPmL7PATOC17eZj15WDzaage5s=;
	b=GcqNaTUtG7eqsXFf8V1NftoLAINABIzn+tQ31uAH/P88GOKa8CKwbW+vBPEG1UA7NCJbgP
	+i0QAW7aWRRgoVO7BiixoE/9ILw1TlRwLR7aDyCaCsAOjWEK6XsHsYo4txHZqXTdpbl6MB
	c/uP/S10AMfuPLG9xJ5zOJvC0f92wRNuJb3EvQw4tz4YSTee/4NodbOUh/xpPXtyCoK8me
	IfG4Fz15mDM/b4BOpbcVTBE5AcwQg9MYoOEXZ3YpTvN5V8HeBsCE9vzelVLjuVFtRAT2rS
	A3UZhmAMb4P/TJNkZU02ywNBdNfm3+QGtLlVY0H2pIujWUIDLhqo3BAIWRs9Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701871646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q2jnrPRUFhsAeYH7XvPmL7PATOC17eZj15WDzaage5s=;
	b=FYpP6LAQqvbdBWga33Jedl/SR6do2iIzUIzTzxt/JZ7IOo5C28C1BNxhkUIoPyGU02l3hx
	8ygKcpCz1adEznDA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Suman Ghosh <sumang@marvell.com>
Subject: [PATCH iwl-net] igc: Check VLAN EtherType mask
Date: Wed,  6 Dec 2023 15:07:18 +0100
Message-Id: <20231206140718.57433-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

Note: This is a follow up of

 https://lore.kernel.org/netdev/20231201075043.7822-1-kurt@linutronix.de/

and should apply to net-queue tree.

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
2.39.2


