Return-Path: <netdev+bounces-291218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPmdKi1/E2ppCAcAu9opvQ
	(envelope-from <netdev+bounces-291218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBF5C4A8D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E81BC30045BF
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544937C92A;
	Sun, 24 May 2026 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtIdBsqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06433B6F6
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662633; cv=none; b=A83Db5Ha3tWrkaKwtOlfwvnxQms3pocu8hsJt40U4H8y4IMfQ3Yhlll5QjFLc21KNuhe8PO03tDt1Qt4/kLuShmo2M3Fvk8Piu9AEgT6sCgjDAtmG13RmUZs7kNHDF6kAZAW3u8nv7Hqyq3zNe0sYVP8mX8HS4gvbGuUp3araoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662633; c=relaxed/simple;
	bh=/9KHSrwMadfcWICdaY+M9KNwrMq0JFUQrrZ2RWOYLqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifMV4iKKPMhie++z94xEiHXyCNYpH/KusZZvO89kmjgyJ67VUFW1NSqIgDol0LMhmiTNjyrR+QK6Q/BWJZwGOhoWx6JHk7svCfRy5qyBznHqLvtt94sj2Uqw5TVQyPTWy++HLHJutqdVKkTJEszXQhXfUFTELW9bX1YUdM1ttSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtIdBsqH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b4583f0a1aso63166945ad.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779662632; x=1780267432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQjZaq2V359LxFj/1Py1W2spC//5ryaGbLK3jja2HKs=;
        b=mtIdBsqHrgsqwgQA/wwYRAUIS6E0dCAACP8srTeUKMWWRAv7yZB3IJwfx/L/uzEE4T
         /JTwPzQFBP8W3zISPiuPC8oW061nK3OH23d8uLroGJSk6QT5nrl1TL5i8ZIqz2cLMLXd
         TXsiWMXXf26rBbt2tQdW8TWZtMF2dZf8lbsNeGL7LW+4F6CY1RKkf1v2iHvyXVurR6FC
         LpEyBGqME1Ehw5XVXz5QB8flCSbtMxUiBBwd13d7PDjKz7A+/2O+7+kWx0vJkQ9ey2Wz
         Y9SBeYlS8gabhWRAOzOQrMU7sjAMoFNUC9bST9YSvh0Ra2C76VHc6F5oVh60gZiJoWWL
         X0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779662632; x=1780267432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQjZaq2V359LxFj/1Py1W2spC//5ryaGbLK3jja2HKs=;
        b=NwQKaNfi5Ke8+L+is/3O7pVCHLfvaa20Ls1WENDdeqBwTKPcei0tA1u3YPBZjIc9qk
         v4zzu2D/sXPM9evaUkyH71ZFOdAoHhZYvDDdZcAPxV0I6Fq8UYi3bm4Cs9kH0o0bD4Jv
         eq6+CplU7+4oxz9ROuEFCboWfCrkVpB84uvnuoO26/RjLEndhl6QOsBLObzwc/3lwJf3
         VNQyNiWUJscXz7j2AAUkYpYCA5kLKimGYaD2bTvALhYbTMQ3GhS4yFvFQsHDN2XDznQF
         g9T4p7+hnrSWBaKvnF4Gn6+RhIn1s2e6/FrDOK7/tMYLd1tyjbp6j9oHhzGpWAZByFhs
         LudQ==
X-Gm-Message-State: AOJu0Yy4+pcHPSoELbJdi9Fdq/lMHiJGXpuYlGSJCIridkMXNblc+SN5
	FeLBcjyd+SsB7opT6vm00hn3txCV5eCeoFcbg2MtEnbpz6oFHdBOrjndZADHgOjy
X-Gm-Gg: Acq92OFFM4sHBM/DtNx/52cD/cFpwN8Q9DXQZz6nHBK9jXsG8fxJJcLmC7lkM33MYu6
	JkhBFIvQqZ00589nwZHUAFWeUk9n1IKrs4nkv84EfheC1q/2pXWOUNSfqUXAsdkeF6UY9MJTju2
	NON9zIx40zN7U9ueLqBJoJAdUlB7gtH7nPzHks25BeI+mpq6LEqCUK7BG5+NIJsc78jpXq/QRP/
	6hQnhgfNKoADtlKfSdHDKDd4y8XYC7NQdXVza9KOpyUOw0AxNkHO2FvhYI62UWnou2oE/sARJXF
	yZMJP7pB5Smg0norNMTm9kMjjAdFfve14qQ7Em9BtA9m8rsA++n5QvJWwc7jlZoCfEJ9ohjUn57
	1kNKCt/ipJmB8QXRrxYaCyjw/AbwTYk5jrmlGV/No7nc0EFN012S6U+hdIlOSuz373kpwIuSRsO
	HKjEBA5PA3sc0lWERrFAtZGK5B
X-Received: by 2002:a17:903:2f8d:b0:2b2:be01:5532 with SMTP id d9443c01a7336-2beb0841de5mr126883415ad.35.1779662631489;
        Sun, 24 May 2026 15:43:51 -0700 (PDT)
Received: from mincom1 ([125.149.177.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb569592dsm75643475ad.16.2026.05.24.15.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 15:43:51 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH net-next] net: airoha: bind WLAN-bound flows on PPE driver L2 cache miss
Date: Mon, 25 May 2026 07:43:30 +0900
Message-ID: <20260524224330.3995807-1-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291218-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bridge.data:url]
X-Rspamd-Queue-Id: 1AEBF5C4A8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Linux bridge FDB can resolve a destination station to WDMA even when
the Airoha PPE driver's L2 offload cache has no entry for that MAC pair.
The normal bind path only checks the PPE driver's L2 offload cache, so an
unbound PPE hit for WLAN egress can stay unbound even though the bridge
already knows the right output path, unless a later offload event fills
that PPE driver cache.

This matters for bridge-visible WLAN egress, such as wired-to-WLAN
forwarding or WLAN peer forwarding across another BSS, radio or MLO link.
Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
datapath and is not covered.

Before touching the PPE table, resolve the destination MAC through the
bridge device above the ingress netdev. If the PPE driver's L2 offload
cache lookup misses, bind the hardware flow to the resolved CDM4/WDMA
path.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 138 +++++++++++++++++++----
 1 file changed, 119 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 26da519236bf..ea932e6d87f6 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -803,65 +803,163 @@ static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
 }
 
 static int
-airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
-				    struct airoha_flow_table_entry *e,
-				    u32 hash, bool rx_wlan)
+airoha_ppe_foe_commit_subflow(struct airoha_ppe *ppe,
+			      const struct airoha_foe_entry *bridge,
+			      u32 hash, bool rx_wlan)
 {
 	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
 	struct airoha_foe_entry *hwe_p, hwe;
-	struct airoha_flow_table_entry *f;
 	int type;
 
 	hwe_p = airoha_ppe_foe_get_entry_locked(ppe, hash);
 	if (!hwe_p)
 		return -EINVAL;
 
-	f = kzalloc_obj(*f, GFP_ATOMIC);
-	if (!f)
-		return -ENOMEM;
-
-	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
-	f->type = FLOW_TYPE_L2_SUBFLOW;
-	f->hash = hash;
-
 	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
-	hwe.ib1 = (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
+	hwe.ib1 = (hwe.ib1 & mask) | (bridge->ib1 & ~mask);
 
 	type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
 	if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
-		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
-		hwe.ipv6.ib2 = e->data.bridge.ib2;
+		memcpy(&hwe.ipv6.l2, &bridge->bridge.l2,
+		       sizeof(hwe.ipv6.l2));
+		hwe.ipv6.ib2 = bridge->bridge.ib2;
 		/* setting smac_id to 0xf instruct the hw to keep original
 		 * source mac address
 		 */
 		hwe.ipv6.l2.src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
 						    0xf);
 	} else {
-		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
+		memcpy(&hwe.bridge.l2, &bridge->bridge.l2,
 		       sizeof(hwe.bridge.l2));
-		hwe.bridge.ib2 = e->data.bridge.ib2;
+		hwe.bridge.ib2 = bridge->bridge.ib2;
 		if (type == PPE_PKT_TYPE_IPV4_HNAPT)
 			memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
 			       sizeof(hwe.ipv4.new_tuple));
 	}
 
-	hwe.bridge.data = e->data.bridge.data;
-	airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
+	hwe.bridge.data = bridge->bridge.data;
+
+	return airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
+}
+
+static int
+airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
+				    struct airoha_flow_table_entry *e,
+				    u32 hash, bool rx_wlan)
+{
+	struct airoha_flow_table_entry *f;
+	int err;
+
+	f = kzalloc_obj(*f, GFP_ATOMIC);
+	if (!f)
+		return -ENOMEM;
+
+	err = airoha_ppe_foe_commit_subflow(ppe, &e->data, hash, rx_wlan);
+	if (err) {
+		kfree(f);
+		return err;
+	}
+
+	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
+	f->type = FLOW_TYPE_L2_SUBFLOW;
+	f->hash = hash;
 
 	return 0;
 }
 
+static bool
+airoha_ppe_foe_prepare_wdma_subflow_dev(struct airoha_ppe *ppe,
+					struct net_device *dev,
+					struct airoha_flow_data *data,
+					struct airoha_foe_entry *hwe)
+{
+	u32 pse_port;
+	int err;
+
+	err = airoha_ppe_foe_entry_prepare(ppe->eth, hwe, dev,
+					   PPE_PKT_TYPE_BRIDGE, data, 0);
+	if (err)
+		return false;
+
+	pse_port = FIELD_GET(AIROHA_FOE_IB2_PSE_PORT, hwe->bridge.ib2);
+	if (pse_port != FE_PSE_PORT_CDM4)
+		return false;
+
+	return true;
+}
+
+static struct net_device *
+airoha_ppe_foe_get_bridge_master(struct net_device *dev)
+{
+	struct net_device *master = NULL;
+
+	rcu_read_lock();
+	master = netdev_master_upper_dev_get_rcu(dev);
+	if (master && netif_is_bridge_master(master))
+		dev_hold(master);
+	else
+		master = NULL;
+	rcu_read_unlock();
+
+	return master;
+}
+
+static bool
+airoha_ppe_foe_prepare_wdma_subflow(struct airoha_ppe *ppe,
+				    struct sk_buff *skb,
+				    struct airoha_foe_entry *hwe)
+{
+	struct ethhdr *eh = eth_hdr(skb);
+	struct airoha_flow_data data = {};
+	struct net_device *master;
+
+	if (!is_valid_ether_addr(eh->h_source) ||
+	    !is_valid_ether_addr(eh->h_dest))
+		return false;
+
+	ether_addr_copy(data.eth.h_dest, eh->h_dest);
+	ether_addr_copy(data.eth.h_source, eh->h_source);
+
+	if (!skb->dev)
+		return false;
+
+	/* WLAN egress unbound hits can arrive before flowtable creates the
+	 * L2 master flow normally used for subflow binding. Resolve only
+	 * through the bridge master so dev_fill_forward_path() must use the
+	 * bridge FDB for the destination MAC. Calling the ingress AP netdev
+	 * directly can describe the source station's WDMA path and would
+	 * corrupt Wi-Fi-to-wired flows whose real egress is not WDMA.
+	 */
+	master = airoha_ppe_foe_get_bridge_master(skb->dev);
+	if (!master)
+		return false;
+
+	if (airoha_ppe_foe_prepare_wdma_subflow_dev(ppe, master, &data,
+						    hwe)) {
+		dev_put(master);
+		return true;
+	}
+
+	dev_put(master);
+	return false;
+}
+
 static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 					struct sk_buff *skb,
 					u32 hash, bool rx_wlan)
 {
+	struct airoha_foe_entry wdma_hwe = {};
 	struct airoha_flow_table_entry *e;
 	struct airoha_foe_bridge br = {};
 	struct airoha_foe_entry *hwe;
 	bool commit_done = false;
+	bool wdma_ready = false;
 	struct hlist_node *n;
 	u32 index, state;
 
+	wdma_ready = airoha_ppe_foe_prepare_wdma_subflow(ppe, skb,
+							 &wdma_hwe);
+
 	spin_lock_bh(&ppe_lock);
 
 	hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
@@ -899,6 +997,8 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 				   airoha_l2_flow_table_params);
 	if (e)
 		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash, rx_wlan);
+	else if (wdma_ready)
+		airoha_ppe_foe_commit_subflow(ppe, &wdma_hwe, hash, rx_wlan);
 unlock:
 	spin_unlock_bh(&ppe_lock);
 }
-- 
2.53.0


