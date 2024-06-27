Return-Path: <netdev+bounces-107283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BFB91A761
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C652821D8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D518EFD3;
	Thu, 27 Jun 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XbxgM/5/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B218C346
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493704; cv=none; b=E/TdeAp0DIgbC+acONFYcgSG+UAs4xdXopgsxZm6ATC6O3P9nw+JnpjGC6IOS0gKBrXKALxJ5SgLL5I3tyoKZ8+crYym8+P+3lhmg0d2K5bc8ADmpGMl/brgiFR3VRUYA8kCSZiJ50+kAFH1f2EaPCXi9/U6f/uo8MCO6VzS15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493704; c=relaxed/simple;
	bh=2evLzJD4UFd97A+7BqLB1Gr4gXAeFIyBMHLXiKD3xtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjqdpia1mc7slfa/0ZHhtkYVojMPq6amPJbeGUyi/u5gaNnLqNDEgvXbSNAjy+Hh4hBbD0MdcnRkR70JOSrNx0cKmL27ChKe5bBlSkmcQMkbso15nnMkOi8JUMGHbf8J0GxU2PVzWv3cfBc2zt5NCx7KymGXZImLWQ2X1GkDv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XbxgM/5/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-425624255f3so8027945e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493701; x=1720098501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETiL8v8q2qxjSjEvFAdWpStx6lRqun0N/wjMD9DyKsQ=;
        b=XbxgM/5/DXdRNq7OC7v+T/wjjM6ipU6tDJkfrP2a3OBYFb1lx5B78+KOyFnHmMDXiJ
         24Y4m64AljUX26v0AgaFft78lipAYhzLp0Z5Ltxmqg41iRc26tnQF4YIm8mcR7NaZh+x
         5JPiR3StR+XwC52yum7whbAOkKT+V67d7LOi+ABCCQ+FF9JldejeSxOG15vy2RI+Mpr1
         xkWmX52QAwezo43aob7B+afutno5h/b6/UOqoHUFfpNWOiReBNNdn2zkBV7AgaJQbj22
         rVwbpqaD+KD3nX2Z/xz11Q0eyGeisKrbShFN057s9Bss0ml8W5R+h+yoxCEWAVVTCYLU
         dmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493701; x=1720098501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETiL8v8q2qxjSjEvFAdWpStx6lRqun0N/wjMD9DyKsQ=;
        b=i4kCiOaYKb5qhyxmpnZMzP7LpbUazoZzk9HP1a5EnKh5U0ocVvs0U103ujkeS6xq16
         iZsJT/Ac1SE5bnWQX2S3O5g7SWzCaxOpv7Qf01YQ75GlzttjgWGaAER2wDxzEqRb2lmX
         +ZvKJPlMu/czpvrp/4SohHkL8zAQZqtwx1T6BQwMEAuGdrRHP3PWRMjtwq+TFU6u5jrX
         +weuCb8d8uwxoxydYHhNfb2INUqVskwp6VaOEblQV7nYUhyylMDtoKfqTCYg/+4ZBver
         Kz97d2k18veSK8C+BldqLO05jKlnYd52iDhFe0h/H0GgQNFOFbGqE2HhF9NYjI/Phc4/
         jJCw==
X-Gm-Message-State: AOJu0YzgbYq9cBkauLEvdL+eCl4kGUvYPIPSeU+0xxrGdk9iUots9BzS
	q7wKXbYlVx9ZoHcONCcdcvZelEjpLWFSImGYJAby5DNMX5DsnnXsDwbML+sIzXH0QxONWRBhPXT
	E
X-Google-Smtp-Source: AGHT+IERj89t1npwluw4uKOSjfuxrTrOj7gGI3A4SMx70lYWkPNcOP8gEqdyBNPe/nRbAyhHqBJCog==
X-Received: by 2002:a05:600c:241:b0:424:aa83:ef27 with SMTP id 5b1f17b1804b1-425642f9ae5mr19720425e9.1.1719493700722;
        Thu, 27 Jun 2024 06:08:20 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:20 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 23/25] ovpn: notify userspace when a peer is deleted
Date: Thu, 27 Jun 2024 15:08:41 +0200
Message-ID: <20240627130843.21042-24-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 49 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  8 +++++++
 drivers/net/ovpn/peer.c    |  1 +
 drivers/net/ovpn/peer.h    |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index e43bbc9ad5d2..e920bb071750 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -846,6 +846,55 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
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


