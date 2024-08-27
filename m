Return-Path: <netdev+bounces-122299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE99609AC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322DEB21CBB
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C141A4F30;
	Tue, 27 Aug 2024 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RDUcjf6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703A1A4F1B
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760426; cv=none; b=YmUidjIctFba17cPHGuG+1sScOu2Klkn/A77HMfGKMtigAzS7kbX/K7RlOGN0FW25LGoySD9Ro+mBDzeHXQu03aAVmIOJJ/5ydQBUEgmLF6lXZ/FN4CearLElGoBQykyTnR1A/MTt3RNH97llpPf+NYlG1udgfJ48qXkoAS7rzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760426; c=relaxed/simple;
	bh=j9HQnhOikuXGAwwq6gN3pBNd5PKht6B0FnT1Ui0HDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghJM1qjEXQwoX33F3tjmiNzGGenbJwf04uQYqZqxBwKH/t2rkoHPxOgzVO6lCrqKBla476Av6nplzIhvofIobYulXdrRGYLQ48Z/+39FO+tgqTexsu2/8DFdP6V2PYKFdUALP7jzAIzca0HoBc5joP+QVe9ky473hsxfygDvjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RDUcjf6c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so44769515e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760422; x=1725365222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIUd8TIptWNFNlv6qCousPbHqfAtofJqv5UkopQ6WcM=;
        b=RDUcjf6cRSj5+pHPmkSxUympasO5wNs5dwK9tAcX71DjTBPbHsdNuZoxYixGc9CY/m
         hz+bGKFs8BzK6g5pBpFrPiYof4vQvHSt33k1wQAdC3hYzwxVwj7D5nYlaQ2IbsbRfg5B
         zD4WVyjNE2rBBvlaFeUMGFZvHCh5w8T7F4Pl/K4b74c7v4IIHGxQcV13aRnCDgNPU0Oh
         +uOa66bus+1fcRWgRrz0zOrd1aayrlZIuog7zph41WuZxyVv3i6wiVJWzetm1XMTO+Bp
         g5hr8/dTg87C8iFWI9gWMXenLbZueeyjGOUVz4RaWNHetOsQ1BgeMyIhIK1yTvDIJmB4
         XoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760422; x=1725365222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIUd8TIptWNFNlv6qCousPbHqfAtofJqv5UkopQ6WcM=;
        b=gPPRiBTvqZWPitEYn6j2s/ZjKKHwzYgSCXcOfRsD+fHhsdKwq0Ag4WBOQDQVzVbEML
         fV/3X0Wl/z/JI64WCPEICvl5bDyqqsCn5pkV6zJIitUpO6KD+cP3ph7wqiWYPfw5vP7t
         CGWxX0700GYWPspSUYwxTMsfVdbfMkCGN90MYvX7afP/Fborye8oIkENqcDz2D4/Uz4A
         fd2ucVteUl2PlJfqk2OYa7oIWWcDeZDXS7gxsdQ/RGS9kkNFuMh85To8bX4YkXQuAkcV
         ZrCrJVW2VFm2OnCtjQITfzwbLHs0ssrsdsbixo2ZBqlF6g+0xEmTvQS2faTaGDKVvWxr
         /EkQ==
X-Gm-Message-State: AOJu0YwVFjtRYUFOBUmWT4VzbbPpKUIHgpd6cHCziSadYE9mRcfmsKxf
	3/ndzQUG8ivmMC1MoDf/IFvE5Yf4zH9nF8zXY8yst08w1oJuH0BlpU74bakuq8FUzmiL2acnAIg
	5
X-Google-Smtp-Source: AGHT+IFx2WFJ6aq42meDTCbilEozoIrlPSqNIYFUbAOqnybeJBvcympeOfB5GcVF5o5HYyH8zFbfjQ==
X-Received: by 2002:a05:600c:4e01:b0:426:654e:16da with SMTP id 5b1f17b1804b1-42acd39e07cmr100922745e9.0.1724760422382;
        Tue, 27 Aug 2024 05:07:02 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:07:02 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 23/25] ovpn: notify userspace when a peer is deleted
Date: Tue, 27 Aug 2024 14:08:03 +0200
Message-ID: <20240827120805.13681-24-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 7cbad5a92b25..1933887ef281 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -911,6 +911,61 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_notify_del_peer - notify userspace about peer being deleted
+ * @peer: the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
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
 /**
  * ovpn_nl_notify_swap_keys - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 972d12fc8f93..5bb53bbd36d1 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_notify_del_peer(struct ovpn_peer *peer);
 int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c460a71dcc29..3fc64af4f22a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -238,6 +238,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 {
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
+	ovpn_nl_notify_del_peer(peer);
 	ovpn_peer_release(peer);
 	kfree_rcu(peer, rcu);
 }
-- 
2.44.2


