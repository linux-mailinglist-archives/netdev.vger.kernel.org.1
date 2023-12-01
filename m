Return-Path: <netdev+bounces-52826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC980050B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206FCB20BAC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E815AD6;
	Fri,  1 Dec 2023 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jk40B8Ee";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9jKeaf/d"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C21735
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:51:01 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701417060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKWXOA9FdxwEjnu4czisx37mFK+YT0WnmFD9/ijwV0o=;
	b=Jk40B8EetmZCz6IdwFfbml+ixgakfpzPNpjZ6ZTG1IZ3qcaMwlGzKpXWzco+fuMfhdVA8J
	1xba9S37IR+S4s7yD9eiqh43I6je/XSrGDBmEryLAYabSl5SE47lHvY/dNMvs1RavT+oOJ
	TU0RgVRcxpdV4LLINObGzL6YOo47XdBAHKdeugb5gnRUF64m/37rXlxkxOL+csrw+g6ZEy
	3d7l/NtMqamqbR3eW2RElxaUxmBNu4lFb6GSnvK48qNZoUFWjz3uGdyHmoRXEWOvmS8cJd
	dME81E4v/1vxKQDzamT0NpI4baMnsKDOWn2CiIKfga2VOUpKVOna8n0x4r2gIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701417060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKWXOA9FdxwEjnu4czisx37mFK+YT0WnmFD9/ijwV0o=;
	b=9jKeaf/doTYMXINMlli3cbK9HZ/wyZ/izyePGwwd1Ga65kv7B/6VHFPfLRFkN85Dqsk6GU
	9bbtgo2QP4Hsu8AA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH iwl-net v2 2/2] igc: Check VLAN TCI mask
Date: Fri,  1 Dec 2023 08:50:43 +0100
Message-Id: <20231201075043.7822-3-kurt@linutronix.de>
In-Reply-To: <20231201075043.7822-1-kurt@linutronix.de>
References: <20231201075043.7822-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the driver accepts VLAN TCI steering rules regardless of the
configured mask. And things might fail silently or with confusing error
messages to the user.

There are two ways to handle the VLAN TCI mask:

 1. Match on the PCP field using a VLAN prio filter
 2. Match on complete TCI field using a flex filter

Therefore, add checks and code for that.

For instance the following rule is invalid and will be converted into a
VLAN prio rule which is not correct:
|root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
|             action 1
|Added rule with ID 61
|root@host:~# ethtool --show-ntuple enp3s0
|4 RX rings available
|Total 1 rules
|
|Filter: 61
|        Flow Type: Raw Ethernet
|        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
|        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
|        Ethertype: 0x0 mask: 0xFFFF
|        VLAN EtherType: 0x0 mask: 0xffff
|        VLAN: 0x1 mask: 0x1fff
|        User-defined: 0x0 mask: 0xffffffffffffffff
|        Action: Direct to queue 1

After:
|root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
|             action 1
|rmgr: Cannot insert RX class rule: Operation not supported

Fixes: 7991487ecb2d ("igc: Allow for Flex Filters to be installed")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 28 +++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index f48f82d5e274..85cc16396506 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -568,6 +568,7 @@ struct igc_nfc_filter {
 	u16 etype;
 	__be16 vlan_etype;
 	u16 vlan_tci;
+	u16 vlan_tci_mask;
 	u8 src_addr[ETH_ALEN];
 	u8 dst_addr[ETH_ALEN];
 	u8 user_data[8];
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 69b2fd006293..b56b4f338bd3 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -958,6 +958,7 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 }
 
 #define ETHER_TYPE_FULL_MASK ((__force __be16)~0)
+#define VLAN_TCI_FULL_MASK ((__force __be16)~0)
 static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 				    struct ethtool_rxnfc *cmd)
 {
@@ -989,7 +990,7 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
 		fsp->flow_type |= FLOW_EXT;
 		fsp->h_ext.vlan_tci = htons(rule->filter.vlan_tci);
-		fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
+		fsp->m_ext.vlan_tci = htons(rule->filter.vlan_tci_mask);
 	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR) {
@@ -1224,6 +1225,7 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		rule->filter.vlan_tci = ntohs(fsp->h_ext.vlan_tci);
+		rule->filter.vlan_tci_mask = ntohs(fsp->m_ext.vlan_tci);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_TCI;
 	}
 
@@ -1261,11 +1263,19 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 		memcpy(rule->filter.user_mask, fsp->m_ext.data, sizeof(fsp->m_ext.data));
 	}
 
-	/* When multiple filter options or user data or vlan etype is set, use a
-	 * flex filter.
+	/* The i225/i226 has various different filters. Flex filters provide a
+	 * way to match up to the first 128 bytes of a packet. Use them for:
+	 *   a) For specific user data
+	 *   b) For VLAN EtherType
+	 *   c) For full TCI match
+	 *   d) Or in case multiple filter criteria are set
+	 *
+	 * Otherwise, use the simple MAC, VLAN PRIO or EtherType filters.
 	 */
 	if ((rule->filter.match_flags & IGC_FILTER_FLAG_USER_DATA) ||
 	    (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) ||
+	    ((rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) &&
+	     rule->filter.vlan_tci_mask == ntohs(VLAN_TCI_FULL_MASK)) ||
 	    (rule->filter.match_flags & (rule->filter.match_flags - 1)))
 		rule->flex = true;
 	else
@@ -1335,6 +1345,18 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 		return -EINVAL;
 	}
 
+	/* There are two ways to match the VLAN TCI:
+	 *  1. Match on PCP field and use vlan prio filter for it
+	 *  2. Match on complete TCI field and use flex filter for it
+	 */
+	if ((fsp->flow_type & FLOW_EXT) &&
+	    fsp->m_ext.vlan_tci &&
+	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK) &&
+	    fsp->m_ext.vlan_tci != VLAN_TCI_FULL_MASK) {
+		netdev_dbg(netdev, "VLAN mask not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (fsp->location >= IGC_MAX_RXNFC_RULES) {
 		netdev_dbg(netdev, "Invalid location\n");
 		return -EINVAL;
-- 
2.39.2


