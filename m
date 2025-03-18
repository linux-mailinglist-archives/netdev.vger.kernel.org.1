Return-Path: <netdev+bounces-175555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F37A66593
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF0A188E70C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A053E202971;
	Tue, 18 Mar 2025 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BtqHeRFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37141EB5CC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262094; cv=none; b=cPKKf0Cn+nnX9kdUHC3BtGb3cUVyJy8vxoWnnD1QwZMCJ6idr9I1ZOER9SjaSixsph+6VVY9UINEd4KSuUFSDPJJIrWReBCjlBf3ONMnwid2UyurCfosHdZBbWP4YlFBY7L6LTix0l2qGUtdNfjRXudRzcwI4HdyGJBv45LV9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262094; c=relaxed/simple;
	bh=Wp5o+vkPxbqe4bUAkAYAYxmd9f29cPkdavwxtEN36zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3wpnjlLZQQzcVQpsBt9VphmjcO/hgogrxJyMlgB2I1Dr2rMFP2AEzbcuqSyuCPh5iiQ3ylPU1BNmslUH0angfbafPqRxYb/l9/yCa8VRfou0nSdHKqiVFRStgIXw8bsYUT0Sq+DTcs9Nq7KeWnF94HFPvzUAOYEiCTnNVZzfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BtqHeRFa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4366914f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262088; x=1742866888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW1HvxU13zVoefK9Rc4SS+Z+mUMZC5jeVdu8mBJXAdk=;
        b=BtqHeRFaaIGg1KgLw3fJQIremwW6bBiWM9L+GwNwtauAivrFOnR5ZGj/H92OnGi0D6
         1ViYe14F5UfSr8Pxap19SMvLEGim9tw1W3tzay5bNPz4QEYdD+gn0wrk0kpjK6ELqpgA
         QHid3fjE4/I/bfM2TRWM2+4+h+3zub5yXbXgvn1RVQNwO+VWt6KchNl5++lHTusUrM+v
         niwoC8nCXtCXcWQFpNTXDvtxPOGa9KoEVWYQU4PZvqws9VYD4HJ2TbrM8l0Qo46fB0kR
         ydgBo/AIF+WVOjt8Kk1j7eX+yBlvV1eT1XTpFydxamrYSCMuAeQFqDOKmX3+6Pm0Se41
         wH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262088; x=1742866888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW1HvxU13zVoefK9Rc4SS+Z+mUMZC5jeVdu8mBJXAdk=;
        b=XqfbdERyFiDa2r/E7scSbLtWdkFrL/EHkOIENB1f2SyU66zFOntxdDcwPNONQnkynl
         2V6h94oyvPX3QkG2RdSlLnCwm8u5pgbvyCSo1oVhqgyaObI4ieAbfYf/JMYy28FiqJDv
         5qFReZj11mKqUrslPHFKsd+30b9EDpJXeT+w9yEXPSo6K+mHOwg6a9Eka3O603lSZhdi
         EB8frelXsKoxUZnrom0L6qy+PZsT7qGDsWAiOINiOInrnMaGrMvZ5tbOxdNc1Vx6gjtY
         dt/bxZnvQ3TKxHcdg1jsHDiM2w4vxb9H7q2jVtR8/vY1DdvqZ+G3c4Lp+pQ+sU+WSBvG
         ou+g==
X-Gm-Message-State: AOJu0YxR5TdCWPFaqmHWbXwCyH57wXhCbrnInmM0GVwkYkiLPdOyBY8i
	NE24oGBreCozxTV8mA2qXVa3h6FlU/SUNUVxDBnWlpE69jwHcB1SCLvp1ThJd1JYJjtYl3N4BZG
	Ai2Lg+n2TRoMnrIksqNlTgGHxL/gj4k6L8/uy199+tBdorJQ=
X-Gm-Gg: ASbGncv6rDCoyrn34x2Qp9nTJMBwPBqzVBRCfvCqpCA/XCBnR0CWcUsoIo2UtHT7jrz
	w9dlVuv4cHDFC9IxCgonjGYki/MuSWiwW0fBiD1b3eieNxALS/XB88FowtcLsvEWx5QaPAX5IZJ
	dq1/hzsKSysPJDZGBYGiAOfrqWgJG3X12Y4t+SoGrKsQL5/WMGXZmz+HrqJN1oRPc34T2+rfBSn
	E59nYDL4Iesp3mFUs0bpOM27qfWmMlYi4mk8k4a0CyNfm+HP6FKlWXNFApCRjyk2zXes9fmdfvk
	wO9KJfjp/7hLzgI9TfD0JjgUaPlDtGOPHu34Mw7qEw==
X-Google-Smtp-Source: AGHT+IHaDLceHKOmjaD5f5AzpdADouKlNjyuWg8fEKZhWiQIWyn+2sF8zUUncumDSE9QTD1Rk5RXnA==
X-Received: by 2002:a5d:5f81:0:b0:390:de33:b0ef with SMTP id ffacd0b85a97d-3971ee443edmr12258911f8f.30.1742262087957;
        Mon, 17 Mar 2025 18:41:27 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:56 +0100
Subject: [PATCH net-next v24 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-21-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=Wp5o+vkPxbqe4bUAkAYAYxmd9f29cPkdavwxtEN36zQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8ryu2OgiCbGdZ6SWjknGoGxOnNj7bYHKPl9
 OJ+9PnHweOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKwAKCRALcOU6oDjV
 h3RrCACPXevMoksTwYexu/Oe1eKz8zdoXJhyjUwMvC7Q0KDrYwhsSXJnHku2qiqSwCkoSWdFTll
 MSO2r+mTY2lcgSoGuNeJcQhc/Jlh+6wqztoV7LHOr4ovdFAnbf9vW1DWG27S4G+xHTR5J/XfO7+
 KOeP97LFz7YnfLfy8UnVyhoUnycDpIgyu0Iaqzp+kHiervZrSodsiMlpDG+USnXrQwhYLCjRE/P
 i4hWY3BVmqFNpix5WKTJoLdcU10ag77dIpStC5ceeXn6RwPH3uj++boNGn0KkEDd/qFuZqP8Nm8
 kMGcXDpqzqQLRVaF+BvBoTlOM5ormwfT1/rOjFyDHBTvDTMp
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
index 93152734098948b58ec1ba8a2ed05f8bb40c91eb..30f2a7896edd3c12d3741278d350661b2bfa0f64 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1095,6 +1095,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
2.48.1


