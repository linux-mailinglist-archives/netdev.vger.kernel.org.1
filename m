Return-Path: <netdev+bounces-255829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDdtMHp8gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:29:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF2CAF08
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44E30301303F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7E2BE7BB;
	Mon,  2 Feb 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywtc8FLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F9286415
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028022; cv=none; b=WYgscJNJ4LcqAyjI4jJnK79ZBqNJtA/YL0Nxz2cuVjZR+C94BPZucXKJ3JPdIIBdTPEGZt/4fnZ6HMAzQg5OQLU7O9w3Z1ahqNYtQWwDmKovnjyyYnIA+9RXqewnLq0yxqjLBgzbOTogQsb9Tvryqi5vWCWxt6Q/5X0cqyP90c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028022; c=relaxed/simple;
	bh=DJFvlBmQk/uC4hW18yJx6/Ln0v4zqv98GRE9PAan2Zo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NbmeDuJqbr/lVGEopVjOq5fmwXrgoB9N/aYSoxxihnT76/Tvn7iz7fd5Qtt+ZhdYqCmBgMPtLYclFIslCO1CJ+RuPS+etGFzetEpjHw0m8bHilOxH3Px780iKKDTR0qvEMzNZlHC96YY1wO5AJChOsIaNY2YKj9mKapgwpYzrC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywtc8FLC; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-89467edcd21so252357906d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770028019; x=1770632819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xh2UQb/DkAQR+V0JTnAuuCiRJpEI+K8O2oxnD6ssDk=;
        b=ywtc8FLCWkofpbCs0tE+vdvQiTjVTnH+x9Gg/BI9iPuLA8aMzivr85p8ua+HA+j3e8
         EDYC6EFpqpaLr7zRprDmr2dqVzZHDoY5TSBuPDQu6SAOus3t8rFcLh260TCTseSzVNSo
         qPSAyuVPqm3j1paZOB6EQ3Jb2ZoiM0XrGv8YVhG5rRu1YDZFyaNJKAuG3vcwgc15PNvL
         C0Y0d5xloJhCiOL/n2pnKOIE3bt1qKOJaf6UnM8QCqr9g8Uhv4BEyVDdP28+M2SZDFaQ
         Goh+HdBZI/0l9Ugu8DCJz2qxveB1NO1hDlrahScKCF6jQNEptKpBvTmE7W/e6rJSn9Qb
         97Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028019; x=1770632819;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xh2UQb/DkAQR+V0JTnAuuCiRJpEI+K8O2oxnD6ssDk=;
        b=P3FIzbpY8Q/i9AEVHjkWXlg0hwNySsM8wWRH22IIKeLA4KWCZWE5eb1m4gzDFApg7c
         sraKv5UUMlAiTXXucXgbRwj7TeCyzfgL3+UbOBWg9MeNoLZOiOgzrRO9daXYdJf7Km5i
         xSyjVp1/v6nh0tXSo2Aw++5Ckhv+GeXlgSe/dKs524wSFFJX9t8+3ZY1YX4A39K0QBOq
         Ltc4gzbAE8gdQ3Vh2Qe64r08u67z3dqEfkICFv/6J5F3B0R7GtCGQtH95Wk0Xh8mlZrh
         hVcTFP6eSo7c25C/pecYMOzkbWM0ba6I+2zhmtO1Qdwm7EfMAnkiRMDSUPY2rH3QlucN
         jrTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Dpb8gPM3qPldMmLKByJGbMq2NrdGKykCH+R6Y4ZU88CXxFZeIa7PbHcFBm3UnQ4tInJfxT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedaD3i0deUfiYKfOeINc9i2c9r+2jqqMzNGdJeRXL2urR/u/q
	d3o5Bknygd36zaqFfE72YIDnwRMrODFI2W5G1BH88cPwZyAdzH/4eVXoIINzXTtyT4dZMR91Dm7
	Yq8YfC7hD7vbkNA==
X-Received: from qva23.prod.google.com ([2002:a05:6214:8017:b0:894:9e65:3ff7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:55c6:b0:895:c06:8cbe with SMTP id 6a1803df08f44-8950c069444mr37939676d6.69.1770028019401;
 Mon, 02 Feb 2026 02:26:59 -0800 (PST)
Date: Mon,  2 Feb 2026 10:26:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202102658.858769-1-edumazet@google.com>
Subject: [PATCH v2 net] net: add RCU protection to (struct packet_type)->dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, Dong Chenchen <dongchenchen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255829-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AEF2CAF08
X-Rspamd-Action: no action

Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a patch.

Real issue is that (struct packet_type)->dev needs RCU protection:

ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
to get device name without any barrier.

At the same time, concurrent writer can remove a packet_type structure
(which is correctly freed after an RCU grace period) _and_ clear pt->dev
without an RCU grace period.

Fix this issue by using proper RCU on pt->dev pointer.

Then, we need to record this dev pointer in ptype_iter_state
so that ptype_seq_next() can properly detect the end of dev->ptype_all.

We also need to add full RCU protection in ptype_seq_next().
(Missing READ_ONCE() when reading .next values)

Many thanks to Dong Chenchen for providing a repro.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
Fixes: c353e8983e0d ("net: introduce per netns packet chains")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c |  2 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |  2 +-
 .../stmicro/stmmac/stmmac_selftests.c         | 12 ++---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |  4 +-
 drivers/scsi/fcoe/fcoe.c                      |  6 +--
 include/linux/netdevice.h                     |  2 +-
 net/batman-adv/hard-interface.c               |  2 +-
 net/core/dev.c                                | 30 ++++++-----
 net/core/net-procfs.c                         | 51 +++++++++++++------
 net/core/selftests.c                          |  2 +-
 net/ncsi/ncsi-manage.c                        |  2 +-
 net/packet/af_packet.c                        | 24 +++++----
 net/tipc/bearer.c                             |  6 +--
 13 files changed, 85 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 55e5e467facd7f546ba208361ec9fdcfd7a627d9..006d80a387431cb7d4acdd35f4f1990c8c1f3366 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -121,7 +121,7 @@ static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
 
 	tdata->pt.type = htons(ETH_P_IP);
 	tdata->pt.func = xgbe_test_loopback_validate;
-	tdata->pt.dev = pdata->netdev;
+	RCU_INIT_POINTER(tdata->pt.dev, pdata->netdev);
 	tdata->pt.af_packet_priv = tdata;
 	tdata->packet = attr;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index fcad464bc4d58af1a7f76cee4cf2088b8889dd0b..d5be21a4c5a3a2635ef69ec60defcb2f665fe205 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -223,7 +223,7 @@ static int mlx5e_test_loopback_setup(struct mlx5e_priv *priv,
 
 	lbtp->pt.type = htons(ETH_P_IP);
 	lbtp->pt.func = mlx5e_test_loopback_validate;
-	lbtp->pt.dev = priv->netdev;
+	RCU_INIT_POINTER(lbtp->pt.dev, priv->netdev);
 	lbtp->pt.af_packet_priv = lbtp;
 	dev_add_pack(&lbtp->pt);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index e90a2c469b9a6f576c1b6f99954af08bae69007c..218ff198625e44063e85b717b75b15b1b565ca7b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -333,7 +333,7 @@ static int __stmmac_test_loopback(struct stmmac_priv *priv,
 
 	tpriv->pt.type = htons(ETH_P_IP);
 	tpriv->pt.func = stmmac_test_loopback_validate;
-	tpriv->pt.dev = priv->dev;
+	RCU_INIT_POINTER(tpriv->pt.dev, priv->dev);
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = attr;
 
@@ -752,7 +752,7 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 	init_completion(&tpriv->comp);
 	tpriv->pt.type = htons(ETH_P_PAUSE);
 	tpriv->pt.func = stmmac_test_flowctrl_validate;
-	tpriv->pt.dev = priv->dev;
+	RCU_INIT_POINTER(tpriv->pt.dev, priv->dev);
 	tpriv->pt.af_packet_priv = tpriv;
 	dev_add_pack(&tpriv->pt);
 
@@ -907,7 +907,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 
 	tpriv->pt.type = htons(ETH_P_IP);
 	tpriv->pt.func = stmmac_test_vlan_validate;
-	tpriv->pt.dev = priv->dev;
+	RCU_INIT_POINTER(tpriv->pt.dev, priv->dev);
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 
@@ -1001,7 +1001,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 
 	tpriv->pt.type = htons(ETH_P_8021Q);
 	tpriv->pt.func = stmmac_test_vlan_validate;
-	tpriv->pt.dev = priv->dev;
+	RCU_INIT_POINTER(tpriv->pt.dev, priv->dev);
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 
@@ -1278,7 +1278,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 
 	tpriv->pt.type = svlan ? htons(ETH_P_8021Q) : htons(ETH_P_IP);
 	tpriv->pt.func = stmmac_test_vlan_validate;
-	tpriv->pt.dev = priv->dev;
+	RCU_INIT_POINTER(tpriv->pt.dev, priv->dev);
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
@@ -1637,7 +1637,7 @@ static int stmmac_test_arpoffload(struct stmmac_priv *priv)
 
 	tpriv->pt.type = htons(ETH_P_ARP);
 	tpriv->pt.func = stmmac_test_arp_validate;
-	tpriv->pt.dev = priv->dev;
+	RCU_INIT_POINTER(tpriv->pt.dev, priv->dev);
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	dev_add_pack(&tpriv->pt);
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 0f68739d380a0ae67f18aadb1f0b3c6c5f3ee6e5..22ba17b624626edf1e1631d6f1e2a3ef9898e539 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1257,12 +1257,12 @@ static int bnx2fc_interface_setup(struct bnx2fc_interface *interface)
 
 	interface->fip_packet_type.func = bnx2fc_fip_recv;
 	interface->fip_packet_type.type = htons(ETH_P_FIP);
-	interface->fip_packet_type.dev = netdev;
+	RCU_INIT_POINTER(interface->fip_packet_type.dev, netdev);
 	dev_add_pack(&interface->fip_packet_type);
 
 	interface->fcoe_packet_type.func = bnx2fc_rcv;
 	interface->fcoe_packet_type.type = __constant_htons(ETH_P_FCOE);
-	interface->fcoe_packet_type.dev = netdev;
+	RCU_INIT_POINTER(interface->fcoe_packet_type.dev, netdev);
 	dev_add_pack(&interface->fcoe_packet_type);
 
 	return 0;
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index c8c5dfb3ba9a124439f83afabb8d10e1abe4cf58..ea6617b378a5a051a492d5810ee0abc157261cc5 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -352,18 +352,18 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
 	 */
 	fcoe->fcoe_packet_type.func = fcoe_rcv;
 	fcoe->fcoe_packet_type.type = htons(ETH_P_FCOE);
-	fcoe->fcoe_packet_type.dev = netdev;
+	RCU_INIT_POINTER(fcoe->fcoe_packet_type.dev, netdev);
 	dev_add_pack(&fcoe->fcoe_packet_type);
 
 	fcoe->fip_packet_type.func = fcoe_fip_recv;
 	fcoe->fip_packet_type.type = htons(ETH_P_FIP);
-	fcoe->fip_packet_type.dev = netdev;
+	RCU_INIT_POINTER(fcoe->fip_packet_type.dev, netdev);
 	dev_add_pack(&fcoe->fip_packet_type);
 
 	if (netdev != real_dev) {
 		fcoe->fip_vlan_packet_type.func = fcoe_fip_vlan_recv;
 		fcoe->fip_vlan_packet_type.type = htons(ETH_P_FIP);
-		fcoe->fip_vlan_packet_type.dev = real_dev;
+		RCU_INIT_POINTER(fcoe->fip_vlan_packet_type.dev, real_dev);
 		dev_add_pack(&fcoe->fip_vlan_packet_type);
 	}
 	return 0;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942ad1dbbd372cfb9e809e413251f15..c92889d7c0d51bc218c622f4f3b7019534a38dd6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2931,7 +2931,7 @@ void netif_set_affinity_auto(struct net_device *dev);
 struct packet_type {
 	__be16			type;	/* This is really htons(ether_type). */
 	bool			ignore_outgoing;
-	struct net_device	*dev;	/* NULL is wildcarded here	     */
+	struct net_device __rcu	*dev;	/* NULL is wildcarded here	     */
 	netdevice_tracker	dev_tracker;
 	int			(*func) (struct sk_buff *,
 					 struct net_device *,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5113f879736b54f0231d0a030dd4bef5a320e9ae..36ce70463ba5ef5dc3549ce9f2a8814b865fc678 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -740,7 +740,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	kref_get(&hard_iface->refcount);
 	hard_iface->batman_adv_ptype.type = ethertype;
 	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
-	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
+	RCU_INIT_POINTER(hard_iface->batman_adv_ptype.dev, hard_iface->net_dev);
 	dev_add_pack(&hard_iface->batman_adv_ptype);
 
 	batadv_info(hard_iface->mesh_iface, "Adding interface: %s\n",
diff --git a/net/core/dev.c b/net/core/dev.c
index ccef685023c299dbd9fc1ccb7a914a282219a327..11d0c598f7d28e824bbd23a670ba75f4561fe810 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -587,16 +587,19 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 
 static inline struct list_head *ptype_head(const struct packet_type *pt)
 {
+	struct net_device *dev;
+
+	dev = rcu_dereference_protected(pt->dev, lockdep_is_held(&ptype_lock));
+
 	if (pt->type == htons(ETH_P_ALL)) {
-		if (!pt->af_packet_net && !pt->dev)
+		if (!pt->af_packet_net && !dev)
 			return NULL;
 
-		return pt->dev ? &pt->dev->ptype_all :
-				 &pt->af_packet_net->ptype_all;
+		return dev ? &dev->ptype_all : &pt->af_packet_net->ptype_all;
 	}
 
-	if (pt->dev)
-		return &pt->dev->ptype_specific;
+	if (dev)
+		return &dev->ptype_specific;
 
 	return pt->af_packet_net ? &pt->af_packet_net->ptype_specific :
 				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
@@ -617,13 +620,12 @@ static inline struct list_head *ptype_head(const struct packet_type *pt)
 
 void dev_add_pack(struct packet_type *pt)
 {
-	struct list_head *head = ptype_head(pt);
-
-	if (WARN_ON_ONCE(!head))
-		return;
+	struct list_head *head;
 
 	spin_lock(&ptype_lock);
-	list_add_rcu(&pt->list, head);
+	head = ptype_head(pt);
+	if (!WARN_ON_ONCE(!head))
+		list_add_rcu(&pt->list, head);
 	spin_unlock(&ptype_lock);
 }
 EXPORT_SYMBOL(dev_add_pack);
@@ -643,13 +645,15 @@ EXPORT_SYMBOL(dev_add_pack);
  */
 void __dev_remove_pack(struct packet_type *pt)
 {
-	struct list_head *head = ptype_head(pt);
 	struct packet_type *pt1;
+	struct list_head *head;
 
+	spin_lock(&ptype_lock);
+
+	head = ptype_head(pt);
 	if (!head)
-		return;
+		goto out;
 
-	spin_lock(&ptype_lock);
 
 	list_for_each_entry(pt1, head, list) {
 		if (pt == pt1) {
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 70e0e9a3b650c0753f0b865642aa372a956a4bf5..ad63556c9e0abd15cbfac7777c31894d2eef037b 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -170,8 +170,15 @@ static const struct seq_operations softnet_seq_ops = {
 	.show  = softnet_seq_show,
 };
 
+
+struct ptype_iter_state {
+	struct seq_net_private	p;
+	struct net_device	*dev;
+};
+
 static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct list_head *ptype_list = NULL;
 	struct packet_type *pt = NULL;
 	struct net_device *dev;
@@ -181,12 +188,16 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 	for_each_netdev_rcu(seq_file_net(seq), dev) {
 		ptype_list = &dev->ptype_all;
 		list_for_each_entry_rcu(pt, ptype_list, list) {
-			if (i == pos)
+			if (i == pos) {
+				iter->dev = dev;
 				return pt;
+			}
 			++i;
 		}
 	}
 
+	iter->dev = NULL;
+
 	list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
 		if (i == pos)
 			return pt;
@@ -218,6 +229,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct net *net = seq_file_net(seq);
 	struct net_device *dev;
 	struct packet_type *pt;
@@ -229,19 +241,21 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return ptype_get_idx(seq, 0);
 
 	pt = v;
-	nxt = pt->list.next;
-	if (pt->dev) {
-		if (nxt != &pt->dev->ptype_all)
+	nxt = READ_ONCE(pt->list.next);
+	dev = iter->dev;
+	if (dev) {
+		if (nxt != &dev->ptype_all)
 			goto found;
 
-		dev = pt->dev;
 		for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
-			if (!list_empty(&dev->ptype_all)) {
-				nxt = dev->ptype_all.next;
+			nxt = READ_ONCE(dev->ptype_all.next);
+			if (nxt != &dev->ptype_all) {
+				iter->dev = NULL;
 				goto found;
 			}
 		}
-		nxt = net->ptype_all.next;
+		iter->dev = NULL;
+		nxt = READ_ONCE(net->ptype_all.next);
 		goto net_ptype_all;
 	}
 
@@ -252,20 +266,20 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 		if (nxt == &net->ptype_all) {
 			/* continue with ->ptype_specific if it's not empty */
-			nxt = net->ptype_specific.next;
+			nxt = READ_ONCE(net->ptype_specific.next);
 			if (nxt != &net->ptype_specific)
 				goto found;
 		}
 
 		hash = 0;
-		nxt = ptype_base[0].next;
+		nxt = READ_ONCE(ptype_base[0].next);
 	} else
 		hash = ntohs(pt->type) & PTYPE_HASH_MASK;
 
 	while (nxt == &ptype_base[hash]) {
 		if (++hash >= PTYPE_HASH_SIZE)
 			return NULL;
-		nxt = ptype_base[hash].next;
+		nxt = READ_ONCE(ptype_base[hash].next);
 	}
 found:
 	return list_entry(nxt, struct packet_type, list);
@@ -279,19 +293,24 @@ static void ptype_seq_stop(struct seq_file *seq, void *v)
 
 static int ptype_seq_show(struct seq_file *seq, void *v)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct packet_type *pt = v;
+	struct net_device *dev;
 
-	if (v == SEQ_START_TOKEN)
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Type Device      Function\n");
-	else if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
-		 (!pt->dev || net_eq(dev_net(pt->dev), seq_file_net(seq)))) {
+		return 0;
+	}
+	dev = iter->dev;
+	if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
+		 (!dev || net_eq(dev_net(dev), seq_file_net(seq)))) {
 		if (pt->type == htons(ETH_P_ALL))
 			seq_puts(seq, "ALL ");
 		else
 			seq_printf(seq, "%04x", ntohs(pt->type));
 
 		seq_printf(seq, " %-8s %ps\n",
-			   pt->dev ? pt->dev->name : "", pt->func);
+			   dev ? dev->name : "", pt->func);
 	}
 
 	return 0;
@@ -315,7 +334,7 @@ static int __net_init dev_proc_net_init(struct net *net)
 			 &softnet_seq_ops))
 		goto out_dev;
 	if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
-			sizeof(struct seq_net_private)))
+			sizeof(struct ptype_iter_state)))
 		goto out_softnet;
 
 	if (wext_proc_init(net))
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 8b81feb82c4ae719b770a5b5480dd07aaae5a54b..e536d998023bb3fb7dc3a8107bc0777fd5ef4eef 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -246,7 +246,7 @@ static int __net_test_loopback(struct net_device *ndev,
 
 	tpriv->pt.type = htons(ETH_P_IP);
 	tpriv->pt.func = net_test_loopback_validate;
-	tpriv->pt.dev = ndev;
+	rcu_assign_pointer(tpriv->pt.dev, ndev);
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = attr;
 	dev_add_pack(&tpriv->pt);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553a0aea936801f545ebc8ca9cdb736..bf1272f33dc18f3731127e7de727001d587ffc7a 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1799,7 +1799,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	/* Register NCSI packet Rx handler */
 	ndp->ptype.type = cpu_to_be16(ETH_P_NCSI);
 	ndp->ptype.func = ncsi_rcv_rsp;
-	ndp->ptype.dev = dev;
+	RCU_INIT_POINTER(ndp->ptype.dev, dev);
 	dev_add_pack(&ndp->ptype);
 
 	pdev = to_platform_device(dev->dev.parent);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 494d628d10a5105a6a32788b4673993f218ec881..a3130c790d9cf898fe4070fd9bfcd4fe07817b76 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3118,6 +3118,7 @@ static int packet_release(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct packet_sock *po;
 	struct packet_fanout *f;
+	struct net_device *dev;
 	struct net *net;
 	union tpacket_req_u req_u;
 
@@ -3137,9 +3138,10 @@ static int packet_release(struct socket *sock)
 	unregister_prot_hook(sk, false);
 	packet_cached_dev_reset(po);
 
-	if (po->prot_hook.dev) {
-		netdev_put(po->prot_hook.dev, &po->prot_hook.dev_tracker);
-		po->prot_hook.dev = NULL;
+	dev = rcu_dereference_protected(po->prot_hook.dev, 1);
+	if (dev) {
+		netdev_put(dev, &po->prot_hook.dev_tracker);
+		rcu_assign_pointer(po->prot_hook.dev, NULL);
 	}
 	spin_unlock(&po->bind_lock);
 
@@ -3188,8 +3190,8 @@ static int packet_release(struct socket *sock)
 static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 			  __be16 proto)
 {
+	struct net_device *odev, *dev = NULL;
 	struct packet_sock *po = pkt_sk(sk);
-	struct net_device *dev = NULL;
 	bool unlisted = false;
 	bool need_rehook;
 	int ret = 0;
@@ -3220,7 +3222,8 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 		}
 	}
 
-	need_rehook = po->prot_hook.type != proto || po->prot_hook.dev != dev;
+	odev = rcu_dereference_protected(po->prot_hook.dev, 1);
+	need_rehook = po->prot_hook.type != proto || odev != dev;
 
 	if (need_rehook) {
 		dev_hold(dev);
@@ -3241,16 +3244,16 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 		WRITE_ONCE(po->num, proto);
 		po->prot_hook.type = proto;
 
-		netdev_put(po->prot_hook.dev, &po->prot_hook.dev_tracker);
+		netdev_put(odev, &po->prot_hook.dev_tracker);
 
 		if (unlikely(unlisted)) {
-			po->prot_hook.dev = NULL;
+			RCU_INIT_POINTER(po->prot_hook.dev, NULL);
 			WRITE_ONCE(po->ifindex, -1);
 			packet_cached_dev_reset(po);
 		} else {
 			netdev_hold(dev, &po->prot_hook.dev_tracker,
 				    GFP_ATOMIC);
-			po->prot_hook.dev = dev;
+			rcu_assign_pointer(po->prot_hook.dev, dev);
 			WRITE_ONCE(po->ifindex, dev ? dev->ifindex : 0);
 			packet_cached_dev_assign(po, dev);
 		}
@@ -4209,9 +4212,8 @@ static int packet_notifier(struct notifier_block *this,
 				if (msg == NETDEV_UNREGISTER) {
 					packet_cached_dev_reset(po);
 					WRITE_ONCE(po->ifindex, -1);
-					netdev_put(po->prot_hook.dev,
-						   &po->prot_hook.dev_tracker);
-					po->prot_hook.dev = NULL;
+					netdev_put(dev, &po->prot_hook.dev_tracker);
+					rcu_assign_pointer(po->prot_hook.dev, NULL);
 				}
 				spin_unlock(&po->bind_lock);
 			}
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index ae1ddbf71853924cb01c56bf75e40190f48dec45..c8a7ab9ee437f3361f60557e0c7da0639d5beb0f 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -456,7 +456,7 @@ int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
 
 	/* Associate TIPC bearer with L2 bearer */
 	rcu_assign_pointer(b->media_ptr, dev);
-	b->pt.dev = dev;
+	RCU_INIT_POINTER(b->pt.dev, dev);
 	b->pt.type = htons(ETH_P_TIPC);
 	b->pt.func = tipc_l2_rcv_msg;
 	dev_add_pack(&b->pt);
@@ -665,7 +665,7 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struct net_device *dev,
 		   (skb->pkt_type <= PACKET_MULTICAST))) {
 		skb_mark_not_on_list(skb);
 		TIPC_SKB_CB(skb)->flags = 0;
-		tipc_rcv(dev_net(b->pt.dev), skb, b);
+		tipc_rcv(dev_net(rcu_dereference(b->pt.dev)), skb, b);
 		rcu_read_unlock();
 		return NET_RX_SUCCESS;
 	}
@@ -804,7 +804,7 @@ int tipc_attach_loopback(struct net *net)
 		return -ENODEV;
 
 	netdev_hold(dev, &tn->loopback_pt.dev_tracker, GFP_KERNEL);
-	tn->loopback_pt.dev = dev;
+	RCU_INIT_POINTER(tn->loopback_pt.dev, dev);
 	tn->loopback_pt.type = htons(ETH_P_TIPC);
 	tn->loopback_pt.func = tipc_loopback_rcv_pkt;
 	dev_add_pack(&tn->loopback_pt);
-- 
2.53.0.rc1.225.gd81095ad13-goog


