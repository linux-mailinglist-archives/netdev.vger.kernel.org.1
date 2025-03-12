Return-Path: <netdev+bounces-174370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50049A5E5E7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0169C1888CF2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF0210F59;
	Wed, 12 Mar 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="T1cVhAWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835220E30C
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812897; cv=none; b=qHp1l7qp6zvOlZEBlEP7poX6vj8du5C5F07G4MJa2dg51cJEk4xVfnwYPLJrkepsCAs4u2FO5xF0cHtTniXc3OC492W0B7Cx8uqHv1hacUDc5AYJ5AexULCASV3w3vTkMI73kV4Dmkrpraii6TzcwkBJbZP3g8WBX4CkxMCEyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812897; c=relaxed/simple;
	bh=RhUUdlwiC4BQcBlibtMMd8O+kRfJ/EojdYIjhAycAvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGnNOrJndO3qFDa8hzWKLWJSTXhSRsDEB2S1MPK4luuHcmA2x6RrBKsoIRkZuNwJJGnv+AK7RuLjPm2naiaMlhbiO9VtBMrGWYoeQ95vCEeJT82TijX4B43b+EcpiWN1eZZrG90K2mdOgS+D5eiLK3NON9NqcJL0QNuRWr3sQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=T1cVhAWM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so1544025e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812893; x=1742417693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EIRLWzA5R4meMp00lsQZIoIdkQMDg2vUQPqZYQGdm0=;
        b=T1cVhAWMV97WtlNcqFq8ZkCHYpHYsPGYDGQwSygk6Qnd0O3aVNDKjXfyH+rDkmlkaQ
         ofBzMAkgwQUlbbkP6IWVwPYo1/J7jiTnyLNZlNxS5imfgc5D3Z6RTRNSUdwm1Eogf8qS
         wvhiwr/zhLrzql80ubJzLzpJO1MvUdffUeQ/1jByEqKFKMcA20ks9cmwEQt6COF/hZEi
         zGAwHYziCzk3dNQgsJFU1W0yK+FgjYLdRL3pLdyrxWJlXB/zrTFhy66CLpkJf9G7pgjC
         HBG6lw1KgpJrwXSaE7S2EPaUBvspUurKgNFsZTPFcY//cZLElC57pGFBKLhiitaFjw3h
         f9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812893; x=1742417693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EIRLWzA5R4meMp00lsQZIoIdkQMDg2vUQPqZYQGdm0=;
        b=aTwiSdAFqgWy/ZPmOnppbUB3Ty2YWub1a1ZgYgRRPJAApJLOTAvHujhueGqHlliWlz
         qo0V8nmoJ+5lMxIstxy+KLPOqg90+2wEwUypPKllPa95Nu23jF5+iTwWKW5+si4zKao7
         MoB4s/p1H9/l0q8XzhiR8B8A7RtQ+oydfJr2NqlFb2/y12fMNBpaTQj7SiJNGpV+U2IT
         CzeJ9tr6y31nkd13A8YS4xy+0BsLq4ddiQ3QBf/9vJQCCRHMq9w4sV3oyjyYlQqodEAq
         B4I8bg3ffPWKB68engSiJp/bsVVaHUTd1VhpniDThIqZ+PrvEP0PTxBLj33LHzAmbrSA
         04Jw==
X-Gm-Message-State: AOJu0YwYWFh3EYFHWfJj8cFYuH2Mic2NTFnXoT7BZb8SjKslRUD+aHOy
	4tjDgWWrWFeurEY476VqgaJHcE4ly5oGRbBxtRtiypkYD3rdg+GadyLbmQ3d4I8=
X-Gm-Gg: ASbGncsaMSdCFtd2gP4Rrw2EypDDy9qE94SJaa30JTUEKEJPUrmErvG2zI6Bn2tCEbS
	sN3uZ8B/nETQ8mCrAcO4gM4V9rtsUaOfYHameUSc/Ok7hJ8IFruJiaCSsIdyoH54PuiLdH1s9gO
	R7sk7tJb9mwO40dJJsx98DgrPhWhn7rhQacYmSK8KVIopBWgId0Vc+5eAMh2P49ipuqv/dnnsSC
	Wo9xBgz68yKHaa1g+4/d2VXoIjKRacbFG/q4qjUNeobgkQkNMry0ymV4QU8r06C8E4pL23JOcUG
	1j4P8ZqQAhetIR4l0LqpfUG++l8Q21S2DtI5nPFZ/g==
X-Google-Smtp-Source: AGHT+IFr6m0JsmVvbpuUtjiHA+jeqSxa1L8YZD5j2a8Sz1011fGkHTQNjEl3aTczTWjL8I3GNo8c8g==
X-Received: by 2002:a05:600c:3591:b0:43c:f16a:641e with SMTP id 5b1f17b1804b1-43cf16a6b0cmr127564405e9.6.1741812893628;
        Wed, 12 Mar 2025 13:54:53 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:30 +0100
Subject: [PATCH net-next v23 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-21-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
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
 h=from:subject:message-id; bh=RhUUdlwiC4BQcBlibtMMd8O+kRfJ/EojdYIjhAycAvQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR8ZPL1pk2QQixze3YTWupk6dN3cTNEWtOTf
 3wI4BT+bxeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 hymFCAC2N/juNFEWaJ1kdhAYjzm/UYKDJMh2c11xW9YJyUBB7hOq2AMoIIfQAaPaXuksHghL4MS
 CLwQxiSZQaLoSmzCOiv9diZQN2wf4E5ptXJmXxLpS4BPqPbxMpMsvGJDMnvmTixkoxMPPRsrAH+
 XREArKELug8VyharCPT71nJk54UyYYV2EsVuwkzucJXkkrg1iKhelYP9V1Gj/zLCxKHGyWmCHXr
 CCznuYqNE6qrmA5hZ2BztEK/jpeJ+xW/o0CRTi+f2ziXFxpaWjmkyZ0tSmHYpI0XKO+oKP3fqy1
 gynW43liu9QMNQixIeukKY1bmEv+afrGqJbBp3G6z00IP97e
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
index 46500e4223d7619a342f803c67aa760166fa6f2b..be3484068cbcb1a8e00e5018c6852e645de37dc2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1094,6 +1094,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index aead1d75400a604a320c886aed5308fb20475da3..d9ca62447738416c5c2f89ab36254e4c00e48033 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -706,6 +706,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);

-- 
2.48.1


