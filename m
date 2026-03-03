Return-Path: <netdev+bounces-263393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCwRJ1I9p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:58:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4A1F67F8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DFD30A4CFB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858C386551;
	Tue,  3 Mar 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlXFTzEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088A389105
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567758; cv=none; b=D/dQoFDY47RBHqmGHv5kOJyNxPMQjyXamVqsLnInxqohrVy9J9ZDvcbrAqN+S9yk84x18CdTTkFavHhsWIz9nJs7tKQO9V+BWZaC07V68idMzq8pBXj4osCkajFGN1D2MnPB7T2FoT4ui5uzX2HGd/vDqlg5pk9imouofyq9Izw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567758; c=relaxed/simple;
	bh=tBrXfsph2RTre7AKwb6XSwlXm3BvBH5Y/qhSnej/G7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDWk7AdSTab7QAcfiXg9R8BtgjQYMrAsucxeMCA9mgdEowmOqFC5iYoLLWbXe4+giNTCj5tWweX63v9xQUzgJXOMtxXp9Lyu/W9G7dOnmu+PwKnKJxxBwWGkGd2UEtCJ6WfZFnOnlBisC+H2NG8X8/CgsLSl6uoFvzm1JsaIAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlXFTzEk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3594620fe97so29239434a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567756; x=1773172556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=js0eM5dF9ShUt2Ha+FRxZ4vQ9tkmpGaVXJ30nrzMkdw=;
        b=UlXFTzEkVCJVQuffgndGajqk+RBsDHl7WOx2WKUJloiDvuiCHksJxaX5Wvcrpw0Yj2
         BHGZYqKTW7TR1J1rG+raOwVswupYoiV17UmRmiNh5+sZkiWsOKHNqEhDsy+0I4YYqGil
         jTY/jXEy7OT2yXabzc/4PJJte6vte/mu2fDc12+vlfZaqtFvN/ebxRiApqiYq6RgSyc2
         VwLpN/qabwS+CUbCUaJgdYEfaxDdUIdbNEYFRMIX0fJUSSq75JBJkECuYWL+bVFuFyHC
         lbL8/dx0n7KsS+0q96ACn9SbFhDaQonmPCCipdge3p1imsog3Cg87xHE+OGTl95/dbQ4
         lUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567756; x=1773172556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=js0eM5dF9ShUt2Ha+FRxZ4vQ9tkmpGaVXJ30nrzMkdw=;
        b=EqoBtkmXWKN0BKvEFEfDG/jN1/5W4NILHJ+Dw59lLA6773ypvZz1t5eO0wIXPqPstR
         LUp+iKGPRoBUMRxNsdIuCVc4TTbUxqFnYJ7mo9UneQS6/3vvv9/XpIC/eHcH8e8zyBsT
         maXyQT52CoarVK/oct4bkQrx/O9kcHdUhmmFUBjUxMtai14wFdZqgX6uraq/vEhp7n5O
         /Oxq45lTQLWlrnGrBrH3wUqjbjclujVOm1oLLeum3g5e3rwR87WWOJeUlYnUo3krlAMp
         TJMSeQ+6p3ZDuBJqxRrhzdYGJKaZlyduWKp3Ix67wzW3sHKdPVvLB15gKdQFSNck6/Z5
         R79A==
X-Gm-Message-State: AOJu0YyaVP1rSQSqTcC5JWDKfdPeF9RTJtXhjHSk8lCfUVylOJ9ELBmu
	ZI5y0TtYy8vI2SmN+jpXkKu2iynyhgpy3InYT88IFd70TlSHUuM+5+XG91XYwAxQ43qL0atS/X7
	nyOja0FYYfHWLIoPJGfnpDx3rZanqBxwYITDM3kNI8L5Nf//r8F2pjWAlWlkckd4f34/eWkjci+
	N4O13AnbzS5eYJ48aV0Q3UM81WsVLx2da055ylcYJ+o/FTH/A=
X-Received: from pjop12.prod.google.com ([2002:a17:90a:930c:b0:359:79d6:387a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2496:b0:359:8726:3fb0 with SMTP id 98e67ed59e1d1-3598726419dmr4606668a91.22.1772567755368;
 Tue, 03 Mar 2026 11:55:55 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:46 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-2-joshwash@google.com>
Subject: [PATCH net-next 1/4] gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 39B4A1F67F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

The device behind DQO format has always coalesced packets per stricter
hardware GRO spec even though it was being advertised as LRO.

Update advertised capability to match device behavior.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c |  6 +++---
 drivers/net/ethernet/google/gve/gve_main.c   | 15 ++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b72cc0fa..873672f6 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -791,7 +791,7 @@ static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
 		cmd->create_rx_queue.rx_buff_ring_size =
 			cpu_to_be16(priv->rx_desc_cnt);
 		cmd->create_rx_queue.enable_rsc =
-			!!(priv->dev->features & NETIF_F_LRO);
+			!!(priv->dev->features & NETIF_F_GRO_HW);
 		if (priv->header_split_enabled)
 			cmd->create_rx_queue.header_buffer_size =
 				cpu_to_be16(priv->header_buf_size);
@@ -1127,9 +1127,9 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports LRO. */
+	/* DQO supports HW-GRO. */
 	if (!gve_is_gqi(priv))
-		priv->dev->hw_features |= NETIF_F_LRO;
+		priv->dev->hw_features |= NETIF_F_GRO_HW;
 
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 0ee864b0..ee963c98 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1718,9 +1718,9 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
-	if (dev->features & NETIF_F_LRO) {
+	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "XDP is not supported when LRO is on.");
+				   "XDP is not supported when HW-GRO is on.");
 		return -EOPNOTSUPP;
 	}
 
@@ -2137,12 +2137,13 @@ static int gve_set_features(struct net_device *netdev,
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
-	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
-		netdev->features ^= NETIF_F_LRO;
-		if (priv->xdp_prog && (netdev->features & NETIF_F_LRO)) {
+	if ((netdev->features & NETIF_F_GRO_HW) !=
+	    (features & NETIF_F_GRO_HW)) {
+		netdev->features ^= NETIF_F_GRO_HW;
+		if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)) {
 			netdev_warn(netdev,
-				    "XDP is not supported when LRO is on.\n");
-			err =  -EOPNOTSUPP;
+				    "HW-GRO is not supported when XDP is on.");
+			err = -EOPNOTSUPP;
 			goto revert_features;
 		}
 		if (netif_running(netdev)) {
-- 
2.53.0.473.g4a7958ca14-goog


