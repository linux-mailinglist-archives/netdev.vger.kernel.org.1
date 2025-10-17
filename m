Return-Path: <netdev+bounces-230287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D4BE63A2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E131621390
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD12EB850;
	Fri, 17 Oct 2025 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHzyRMiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4182EACE9
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672549; cv=none; b=pW3Q9UefHOs7o0jsY7uv3iu2cgJzgazy04GYVhhb3rxOf1u7Nn6FIuQ7UtKw4KUsmeZHwDZuZYNicrVe98cXh/tXpVjplHdK4zyaERJQ3XTh4l9Oq4lcnd7bQwxFxF49n8Sprgmi/G5ZdIL0m9OiBTHNsCONaU00ChMa+RxEbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672549; c=relaxed/simple;
	bh=MXEju5yO9Px4d76UK4g2o1ywmqDPKrycxs8Kiwy6Tkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+173U7mzqIwgVea/eKUt0bIzynxgMSAuanKmZlcDuYHTA+dbzvveRPt51lq+YVplR/mpsp0kJaX/j1kfQ7fYNgyRSsMIK+LDBnXqzd0VnuuUXMgT9oYlvgzXtmtUWi5EzG7yH/kn2HJhuQhTNYgFXaV2lEl/LqiCa3oPVjculg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHzyRMiD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eceb38eb1so16793645ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672547; x=1761277347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0/0hRcfmTn5ewjNHsITooHR5wHJru0Cnxm8kxCP01g=;
        b=VHzyRMiD+PUxcIRh4Y0ikJnFmLeT1y1WEu8gIt0PgehaA+Hkjrsg6c0aeCk2XaTe83
         Jz6/fZuhMZQWxBL9xo+yDfUfEwG25y5Gidd3ZWhWZuGQe+bvI9z1884jTfryFXv/lJ9Q
         Z0DlvlA+hJQw3+eTbrjravMoZMOJ4Wl+rKOKGtGdPWLMgVXt4cWB0GtcJFv79deILTR4
         rGDmZjvASTFRCkCFE6YabSCaWfwwtyCa4o47KSqbq82dC5IfzpT4y5eT0DzF8+zdFv5G
         vThTXvc8rpICnswVcJoOThWiMsX2rIb/VBY4d+JzyCvbpXYuI4qemVUJEUWEcVsIzi6y
         9pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672547; x=1761277347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0/0hRcfmTn5ewjNHsITooHR5wHJru0Cnxm8kxCP01g=;
        b=QOd1LP8hXDjlJ+Gcrb4PmfNcbNVKi7X9t275o99cLp+1sH3Gk+cLT69VsWe2hdB1ox
         cdBjuGeV/FDsEhZyJOwfGD7V3nq5iGCaAWThdcC/BfP9NTIacSCq4Lohrc/V2u1rDmMM
         rDf/q+vxY8SZ5PpoayeXDnVdlyZpX5RyGnZSrCSqyu/KBnPq1IaTK9VE8XhhSED/2FUY
         BfSkxhP4V814/ygT42E/McHyk0G5E1Xp6wWVBtlgovBM4RLv3MMBgZjUspjBrhL+PdkW
         0sNZ40IaXBno+06Pd4zXzgNmi1wcpGNm92Ie/XcxIh5RB1ZcpsG6J2zWjXr8NGBoK6DE
         JLsA==
X-Gm-Message-State: AOJu0Yx+/xJKiTRdwV7xCxWUrXAfP+ejxkQY3uWNA5c2tJweFjvI4keT
	hO5wwYRJrT9hpZVZecujrtDFf7AN0jNJeBp8KnXZoHAH1w5wfsXVuqFhnVcWoDd64i8=
X-Gm-Gg: ASbGnctOEtnH7ijDnLDluSuh+Ju1WZzUtoF4DJfNsQhBvyMm80r2dGeTpmqhhsNm/ib
	aXSiZlo+r/4bERvnRRJTvdyOIu6rI0zOhy2RtRSBFcaX/Zapu2qCuulCE7lY9uDWDrqlQnhWCBM
	3eXDl+MuXgjpqp/QuJUVbJXjd8YzFU1WRcSXSrH32bm8rCsHev5MzXUbWN93vaMp9eqDdp9wUkA
	wpGHcB3nSWS6Lx70ERhgMxMkGaa167SnOR/PFDOULUDVcTbmn7HX0B8V8pj/QctP5Xsslm6360Y
	7VB/a/Xj0rBSr2oUJhlNQIQ2nZmutCKnrX33bPbCHnok4qXsuz16nObHnXJ7RPYczHGJqRUfaKX
	10abHA/ORFWpmhcbufYEjHqvaJmDPiO9FBUJQPJKRWGuVSyZFS5lzBRV4OVZN3brSlQUbnVNV7h
	2J463w9tzCdItlj1X1RxIIE2iwcA==
X-Google-Smtp-Source: AGHT+IGtS4yfeIpw7fIj6eTJkwXSR16RZZAg+fpUBOeLn6J83Zoyd/vuf+HPbQQMeBX1Y+623a5Hdg==
X-Received: by 2002:a17:903:120b:b0:290:cd5f:a876 with SMTP id d9443c01a7336-290cd5fa92emr25623135ad.13.1760672546709;
        Thu, 16 Oct 2025 20:42:26 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:26 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 3/4] team: use common function to compute the features
Date: Fri, 17 Oct 2025 03:41:54 +0000
Message-ID: <20251017034155.61990-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new helper netdev_compute_master_upper_features() to compute the
team device features. This helper performs both the feature computation
and the netdev_change_features() call.

Note that such change replace the lower layer traversing currently done
using team->port_list with netdev_for_each_lower_dev(). Such change is
safe as `port_list` contains exactly the same elements as
`team->dev->adj_list.lower` and the helper is always invoked under the
RTNL lock.

With this change, the explicit netdev_change_features() in team_add_slave()
can be safely removed, as team_port_add() already takes care of the
notification via netdev_compute_master_upper_features(), and same thing for
team_del_slave()

This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
features.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team_core.c | 83 +++---------------------------------
 1 file changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..29dc04c299a3 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -982,63 +982,6 @@ static void team_port_disable(struct team *team,
 	team_lower_state_changed(port);
 }
 
-#define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
-			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
-			    NETIF_F_GSO_ENCAP_ALL)
-
-#define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
-
-static void __team_compute_features(struct team *team)
-{
-	struct team_port *port;
-	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
-	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-
-	rcu_read_lock();
-	if (list_empty(&team->port_list))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	enc_features = netdev_base_features(enc_features);
-
-	list_for_each_entry_rcu(port, &team->port_list, list) {
-		vlan_features = netdev_increment_features(vlan_features,
-					port->dev->vlan_features,
-					TEAM_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  port->dev->hw_enc_features,
-						  TEAM_ENC_FEATURES);
-
-		dst_release_flag &= port->dev->priv_flags;
-		if (port->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = port->dev->hard_header_len;
-	}
-done:
-	rcu_read_unlock();
-
-	team->dev->vlan_features = vlan_features;
-	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				     NETIF_F_HW_VLAN_CTAG_TX |
-				     NETIF_F_HW_VLAN_STAG_TX;
-	team->dev->hard_header_len = max_hard_header_len;
-
-	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		team->dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-}
-
-static void team_compute_features(struct team *team)
-{
-	__team_compute_features(team);
-	netdev_change_features(team->dev);
-}
-
 static int team_port_enter(struct team *team, struct team_port *port)
 {
 	int err = 0;
@@ -1300,7 +1243,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	__team_compute_features(team);
+	netdev_compute_master_upper_features(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_master_upper_features(team->dev, true);
 
 	return 0;
 }
@@ -1970,33 +1913,19 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 			  struct netlink_ext_ack *extack)
 {
 	struct team *team = netdev_priv(dev);
-	int err;
 
 	ASSERT_RTNL();
 
-	err = team_port_add(team, port_dev, extack);
-
-	if (!err)
-		netdev_change_features(dev);
-
-	return err;
+	return team_port_add(team, port_dev, extack);
 }
 
 static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
 	struct team *team = netdev_priv(dev);
-	int err;
 
 	ASSERT_RTNL();
 
-	err = team_port_del(team, port_dev);
-
-	if (err)
-		return err;
-
-	netdev_change_features(dev);
-
-	return err;
+	return team_port_del(team, port_dev);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2190,7 +2119,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2923,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_master_upper_features(port->team->dev, true);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1


