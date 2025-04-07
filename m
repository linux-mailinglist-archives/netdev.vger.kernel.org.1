Return-Path: <netdev+bounces-179916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47464A7EE2B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077FA42077E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88890255E46;
	Mon,  7 Apr 2025 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="f4lzmTFB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556D2561DA
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055262; cv=none; b=K/MwSUQG4zv1iNKb7insEVKBxqf9RfVFfrqtyzRNGgJ0k8mTD9Xuls5vx0gRXd5CifBzXBtxcK2gl5CgXZADve+emLZ1GYHqIyZZya9hv+Haq2Yrnm5IFPYtDnnX3J/lP0UPGe2UwMgdqSNpzggUq6nLjX6+iBZZ0tTZiKn5n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055262; c=relaxed/simple;
	bh=ZQYu879WO+NIz61Z7yObmSLo8jpfxM0UyV7xflJWlks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcC5dmlLc4cnOP8SxwS6q95fzR9MIdZLLD5ZShwNACEpj4VC3Y29b9a7hdo8myVutTcJ0IfDbGyEMtnwpqpiAENri3OSBUI8fjaJqS5HCkmbRWEWJYkCpWy+pfPCbXhMmb5pNEUFPmJc230GjuRz5Yix07D4FNxfpaz1pVRjLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=f4lzmTFB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0782d787so32864935e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055258; x=1744660058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uqi8dT52Nr0iihZGpZYl0EVkX5G84ray88mrvqRMo9k=;
        b=f4lzmTFBJXoximr9OXePtKBmCg9tdF1zbCmG6kHEx4eiVVmbT++WCtX/ZcSNyQ+uWt
         dGtmXp8iU+SQUbrFDD124sXXqx91mCiW0w3zYJYgtVYhBG3mOBp1A5HolHABdTt5Zwc5
         FmOGMKGzk6WjhPZKFf4PRmNEeHbV+9hWPzH2w1a8p64t8FuO5wcfWYh4orm5IJD99s+A
         Ppdp/38WoqF7ZtvAKBAUhkDvV3Rh/v6JKDjSET1np7FRPrhYnWDXL0nuMOvNHlR3H9zI
         BqmL83UPZrGiMs0JrBj+RyEKtEbFBPhHzmR+SCcAcXloG3+mbLdB2I96fFtz3L9OeRfK
         ZZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055258; x=1744660058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uqi8dT52Nr0iihZGpZYl0EVkX5G84ray88mrvqRMo9k=;
        b=kz1nh2lTJ/Pq3KG7Lev+gqHSM8o6RTc7lAUywRPUNJJiZVdys0j9X+sN7pHmooyStJ
         g8iBjjRgGUxbsVmVenYMQQDTrqAukIU2LGXzxLfXXIhAHhKjhQtD5Jc5kwTTVPdTVG7v
         OUex+zngf+jz2NiEtNdj/UM34vETAZG3iCMR6urqM3ADdy0TLLqGKb4KZuFLPuLSrAJ3
         SioiBPQhE5taj2T60QWT3q045VML/MWOQIE38+wDcwVcCax45++G+NCvLWNh9iWn/4fG
         05NMcq61vpryQ018/KmH1UUdsywVI2MZFUaow/2D/ytjH40kWc2E0Y/pOEycXy439UZx
         2nHA==
X-Gm-Message-State: AOJu0YyEnLmBycWVMRf3gkc4Pe23+4Y3XBIwoTxuS90Rfxws0GUkM3qA
	6LI5CcZaGqPQEi2rDpBwkVCaZE3HaQmWfTVuHCBfN/nxoHBWO52H/mRTBb+Yf/xT2tPa2aLYMK9
	nziKSyl6HOFf6Rv+MkQ/t6WJ3C6k8wo+m8RDRq73oMHFyesE=
X-Gm-Gg: ASbGnctA+hcskvoWQPZzuKJC8GyJ0BehoCsdNyM6nOdlcdSwErIYV/2W0HEx8BzpSqA
	yQdRaFZLHEIhKwzBZ7UHrgVHED0vX/mo2BQP41u78CMNQpEFBlc0Gzti46ilGKH/aXEtmqenC5W
	9S9rCazkZr21dUe/n99tfLWCTvW1YbC88PmTfpttxxo258sQyzSZ/xZt5BfLaziAqEUBV9YciMI
	WXFzrkM2eEJysDWXw5fGHuVsHNEHq5drjVcZBqW41gLTOpFOCUDEWjdB1uVSN6e3akWx2oCxSTy
	TP0Rg+PgQ2XWjODziJPV/36Goihz6U73i/sThUv5eDGI+v97ZOFX
X-Google-Smtp-Source: AGHT+IEbuvkeT5qQI2D/X6PuJDb5HMNoj7XFo49s1qk5T29ATRMj993+tpYHi66h5f2C2X0e5qe3Qw==
X-Received: by 2002:a05:600c:1e28:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-43ed0d9b49bmr118657365e9.23.1744055257760;
        Mon, 07 Apr 2025 12:47:37 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:29 +0200
Subject: [PATCH net-next v25 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-21-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ZQYu879WO+NIz61Z7yObmSLo8jpfxM0UyV7xflJWlks=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu2aIylLx6bEooWHW209UlrkaptRBv3fSHOa
 5oxZHyOqpuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtgAKCRALcOU6oDjV
 h9itB/90dXAL1MVBxRe3nboUiRdeRQd8SS9QFFInVssRBH2Brb3an1cQyVHsjgSyGUT1gX9gm7T
 vtqzo/BrK1wcb3l1KTPvciPvHbT5oRjg7Zp8Pfpb4j7A/s3lg1YQ6+IZLhr+RW7+xTMQnhr9M9j
 VoGFSPi2a678QLweMsyzRMJkxx0AQn3lslN9/FjULS9nZ7CE8nae0WigT9jWZhwmDb4PhjPZPrg
 NnX8fUZb8c/7jzvYWT3dAP4mVWQV8wEkJDtoJYlIpjG0cb1HT7MD5rIuqW9weGtn1hC8/dpyHQI
 twa3cvlAFXXjwCk0HvLPTHSKLr1DUs3zsaf6JKiDPTshyWtm
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index f0b5716059364a1deee1c7d4da1d5341b53dffca..bea03913bfb1e1948d57bd613d2bc6241c76fc06 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1103,6 +1103,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_peer_del_notify - notify userspace about peer being deleted
+ * @peer: the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
+		    peer->id, peer->delete_reason);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_PEER_DEL_NTF);
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
+	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, attr);
+
+	genlmsg_end(msg, hdr);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+
+err_unlock:
+	rcu_read_unlock();
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 5dc84c8e5e803014053faa0d892fc3a7259d40e5..8615dfc3c4720a2a550b5cd1a8454ccc58a3c6ba 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 3af4531393f66a4c9e0fe64dc333f89b98efff6f..0b1d26388dba9b7129922287e43a226f9a2346c2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -706,6 +706,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);

-- 
2.49.0


