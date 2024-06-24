Return-Path: <netdev+bounces-106092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3399148C0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BEB286EA3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66513D289;
	Mon, 24 Jun 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RSQ4udO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACB13CFA8
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228619; cv=none; b=DX3uGkD3Jt++iaUGVuRWEZryLcNkp446NTJJwzmKhwNnhSsjKsMNrXmZn76LLXAhbilC7snkT271IKeq16zYiCwslQcn8aH6Vaef7YQUrflguw1ypOt5IT4cWcQ4W7aOhbtwGX6lBP+TKy7fzKXdxtEAmnWXMsI51tYwhH4NErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228619; c=relaxed/simple;
	bh=u9+OwE83lR69gDEQZAjMxKPOdXywZaGPfN6kBgqrSpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+Pznv9f3Fmgjo2TMds0sQYslw5+aKC4kts2ZRz9Ok4gaufVz+a88zQCOVUS+tXR3N0KBB0FXbuMKpwfaJJEzmj2LWzUIp8pjhOWHnHfiguN8Hjhz3X+w2p83whmkAdqHzIK2+YepulHVclew3P2k+SeseACIOV4hChJ/ii+fK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RSQ4udO4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso46097185e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228615; x=1719833415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z0S950CH7OHmotnqcOEpo26PEoxcUaKr/mm6hzbaD4=;
        b=RSQ4udO4BOFC9IHrh6eNFjhO+5tuXV8sGsBPI8mM5Xw1ROLhoZ67dL6P4VU1o6Onbu
         1CSh1BCWHswrb86ecxl2ff/scOKi8i7wRYRKhPGrSq5VvQUysQKRLA8ysERyUYQqkJKs
         G2uDuunn72s03TtvUmgfIg5j2ikAgGBeT/JVG3IqsBqa163ej/DaX9bU8zgcjB50PobF
         Qw/dvy5oPzpCWU9hvxZrsPBYZUAJZJ/SugVap3HAQMVKv5fofnLh/zQBXyzgrIt8J+YI
         l9/dV8/GdYLJAxQFs6e8a2NvY57rI21LW0QpseZwTgKdimoJ3GzgEnDh2/fPesujNRQf
         L3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228615; x=1719833415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z0S950CH7OHmotnqcOEpo26PEoxcUaKr/mm6hzbaD4=;
        b=fItXG3EZtkyCzCHeGYyrlzI1NDMz4cKkL3qb392aft6lvZcUtVuWia8P+BjsL9VZsP
         60EfVr2hdkr+7tOK+Q+SqocSPFJx768+/SmmHMzDKcycr6sWd5CiA+W9HauNJCIu7KCO
         WdQE2N8TCC/mz92gRDXPbe76CC/BhboL1VW1wztzYswL2OkizzsUrF6VM7MvGrwvtD1K
         1aB519/V7EJ7TfdgsnJE5Y6yt6eK+TroeB7rhje5k3IZzpHVXY2t6oECBGzGssd2MQSq
         m+eD73+qJrt34DWKP7zhNCUWUBDyJ+Qs13BZJ379LJ/TgmVTl//0rDAGSUXs11LJ9q7p
         mv6Q==
X-Gm-Message-State: AOJu0Yz1EHp0ZDdcOjmrfUge5mA4ElAlIHBQSEimnIeVg+b7EZRM4z6T
	Qm45x1dG51uBi1+Pq3NN7qXUJ+OAnYDZ7gX/dlZr5piFpqqhW9qmPXT8zaHN7taNKu7aU/7PEsC
	J
X-Google-Smtp-Source: AGHT+IEXErP+paSRbSHhjtTxfcJu8eQl1/pJTYvnHVycaRFq2aWra5NXtJy5RL7q98iQpemaNOa2mQ==
X-Received: by 2002:a05:600c:304c:b0:421:cbb8:8457 with SMTP id 5b1f17b1804b1-4248cc271a2mr37018325e9.16.1719228615701;
        Mon, 24 Jun 2024 04:30:15 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:15 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 23/25] ovpn: notify userspace when a peer is deleted
Date: Mon, 24 Jun 2024 13:31:20 +0200
Message-ID: <20240624113122.12732-24-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 51 +++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/netlink.h |  8 ++++++
 drivers/net/ovpn/peer.c    |  1 +
 drivers/net/ovpn/peer.h    |  1 +
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 0cee957e6558..dadad402edd2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -846,11 +846,60 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+int ovpn_nl_notify_del_peer(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
+		    peer->id, peer->delete_reason);
+
+	msg = nlmsg_new(100, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_DEL_PEER);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, attr);
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
 {
 	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
 	void *hdr;
-	int ret;
 
 	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
 		    peer->id);
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index c86cd102eeef..8ce58c4ee193 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,14 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+/**
+ * ovpn_nl_notify_del_peer - notify userspace about peer being deleted
+ * @peer: the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_notify_del_peer(struct ovpn_peer *peer);
+
 /**
  * ovpn_nl_notify_swap_keys - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2105bcc981fa..23418204fa8e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -273,6 +273,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 
 	ovpn_peer_release(peer);
 	netdev_put(peer->ovpn->dev, NULL);
+	ovpn_nl_notify_del_peer(peer);
 	kfree_rcu(peer, rcu);
 }
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 8d24a8fdd03e..971603a70090 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -129,6 +129,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 
 void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
+void ovpn_peer_release(struct ovpn_peer *peer);
 
 /**
  * ovpn_peer_put - decrease reference counter
-- 
2.44.2


