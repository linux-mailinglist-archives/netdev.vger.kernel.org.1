Return-Path: <netdev+bounces-151144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942669ECFC6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E601E167FBB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CDC1A76D4;
	Wed, 11 Dec 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q56YGE3L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527D1A725C
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931137; cv=none; b=utTnVZwi1OO+MkylQfz5iKmc2BE2QeSSdsFK4c6d6etpMwI32qGvVao0PmN/mt2d5VTHk8yMHZIgF5OMl6DlOvjrBCTbo0owjv/53+swtH09HcLMT27r/NMXoXrm4kruwI6tqZH0y6VVeetsmoy4dQqOk50TLk5QBCXmr8d175Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931137; c=relaxed/simple;
	bh=f6ViX32rvfhUWlEkUt2+RRsqkElTz3AsnKkXcFtL9OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAIS+pg17JpGCRxPx4ahkhnnqtHzk2eqpAtfOU7HQrqa0BSyRdbxaAzBVC1J7s/WXU3PouQlwyiG66KmE5UmouG7oOSBhrcK/ir8i9D+sveY5T4eKvPpb+LfjX1lEf2un4JAfEDy3BOUX0debU7IaDHoEkhlzcxOcEdSYhHhViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q56YGE3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C41C4CED2;
	Wed, 11 Dec 2024 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931137;
	bh=f6ViX32rvfhUWlEkUt2+RRsqkElTz3AsnKkXcFtL9OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q56YGE3LZFRUXUc6zrvDyLDwFw0lT2EtFjGdfBTfcSxQGlJ80IPCWoPXUOQBfNh6j
	 hrbk9CTcPb8DPz1/DOgneCZPGNCkfpl2PEtfRidi4jixu5tvOfk9qlIBdO9fcxMm9K
	 8SBNdPfVzFQAes+Oqg5lG8SDf/6chP5jVwQsOLjW9jsirZmNAE0kpaJGWcjYwyL0hP
	 vdfS5ycQ+ojitQFoaAXhm6dAF4CI1mmlPtNJ4tZcrak1dcaaS2U9wV0GKXocrty7qa
	 m1b2Zb26ibBu8ct6MIYiMSIsquwn5CQUPPgLCHr2o9XXjGH/tozibvz2JumKir3rxx
	 uEy7fBSB2vohg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: [RFC net-next 3/5] net: dsa: Introduce ndo_setup_tc_conduit callback
Date: Wed, 11 Dec 2024 16:31:51 +0100
Message-ID: <8e57ae3c4b064403ca843ffa45a5eb4e4198cf80.1733930558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733930558.git.lorenzo@kernel.org>
References: <cover.1733930558.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DSA hw switches do not support Qdisc offloading or the mac chip
has more fine grained QoS capabilities with respect to the hw switch (e.g.
Airoha EN7581 mac chip has more hw QoS and buffering capabilities with
respect to the mt7530 switch). On the other hand, configuring the switch
cpu port via tc does not allow to address all possible use-cases (e.g.
shape just tcp traffic with dst port 80 transmitted on lan0).
Introduce ndo_setup_tc_conduit callback in order to allow tc to offload
Qdisc policies for the specified user ports configuring the hw switch cpu
port (mac chip).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h | 12 ++++++++++
 net/dsa/user.c            | 47 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d917949bba03..78b63dafad16 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1169,6 +1169,14 @@ struct netdev_net_notifier {
  *	This is always called from the stack with the rtnl lock held and netif
  *	tx queues stopped. This allows the netdevice to perform queue
  *	management safely.
+ * int (*ndo_setup_tc_conduit)(struct net_device *dev, int user_port,
+ *			       enum tc_setup_type type, void *type_data);
+ *	Called to setup any 'tc' scheduler, classifier or action on the user
+ *	port @user_port via the conduit port @dev. This is useful if the hw
+ *	supports improved offloading capability through the conduit port.
+ *	This is always called from the stack with the rtnl lock held and netif
+ *	tx queues stopped. This allows the netdevice to perform queue
+ *	management safely.
  *
  *	Fiber Channel over Ethernet (FCoE) offload functions.
  * int (*ndo_fcoe_enable)(struct net_device *dev);
@@ -1475,6 +1483,10 @@ struct net_device_ops {
 	int			(*ndo_setup_tc)(struct net_device *dev,
 						enum tc_setup_type type,
 						void *type_data);
+	int			(*ndo_setup_tc_conduit)(struct net_device *dev,
+							int user_port,
+							enum tc_setup_type type,
+							void *type_data);
 #if IS_ENABLED(CONFIG_FCOE)
 	int			(*ndo_fcoe_enable)(struct net_device *dev);
 	int			(*ndo_fcoe_disable)(struct net_device *dev);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index c736c019e2af..2d5ed32a1f7c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1725,6 +1725,46 @@ static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
 	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
 }
 
+static int dsa_user_setup_qdisc(struct net_device *dev,
+				enum tc_setup_type type, void *type_data)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	struct net_device *conduit;
+	int ret = -EOPNOTSUPP;
+
+	conduit = dsa_port_to_conduit(dsa_to_port(ds, dp->index));
+	if (conduit->netdev_ops->ndo_setup_tc_conduit) {
+		ret = conduit->netdev_ops->ndo_setup_tc_conduit(conduit,
+								dp->index,
+								type,
+								type_data);
+		if (ret && ret != -EOPNOTSUPP) {
+			netdev_err(dev,
+				   "qdisc offload failed on conduit %s: %d\n",
+				   conduit->name, ret);
+			return ret;
+		}
+	}
+
+	/* Try to offload the requested qdisc via user port. This is necessary
+	 * if the traffic is forwarded by the hw dsa switch.
+	 */
+	if (ds->ops->port_setup_tc) {
+		int err;
+
+		err = ds->ops->port_setup_tc(ds, dp->index, type, type_data);
+		if (err != -EOPNOTSUPP) {
+			if (err)
+				netdev_err(dev, "qdisc offload failed: %d\n",
+					   err);
+			ret = err;
+		}
+	}
+
+	return ret;
+}
+
 static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
 			     void *type_data)
 {
@@ -1737,13 +1777,8 @@ static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	case TC_SETUP_FT:
 		return dsa_user_setup_ft_block(ds, dp->index, type_data);
 	default:
-		break;
+		return dsa_user_setup_qdisc(dev, type, type_data);
 	}
-
-	if (!ds->ops->port_setup_tc)
-		return -EOPNOTSUPP;
-
-	return ds->ops->port_setup_tc(ds, dp->index, type, type_data);
 }
 
 static int dsa_user_get_rxnfc(struct net_device *dev,
-- 
2.47.1


