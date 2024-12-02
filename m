Return-Path: <netdev+bounces-148134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848639E06F7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35860170646
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F720D4F2;
	Mon,  2 Dec 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Jlsda61+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDF20A5D9
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152137; cv=none; b=hFepoAKX4lWrxGJpU/ISGWZ+EbPpi6gMMVtm4nsTglFqpY67kxNSmhHggsybq2WJ2j15AFhDzss/3nnaWxE+7NMmNBW2Cu7TenuETzfukhlmegnX/AP5G9LvOMDsLahSa5wFNtIhE2wmvvidBomLSNl08Hetx9ZKhAWD0phlTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152137; c=relaxed/simple;
	bh=silTuCsQomSVhrC09ZgVVShik3tIYfu3bVc4ewGCVfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lK0mHLLr9nSwLZYZP64owSwxE5luIrrD3KHRGEYKDQIFxFG90e1dDW36K3ziiQeFHJ8X/dAw/mCQt6RFXCFOSr9yR+ito6Ksb0RSqor0sANuo+4N7REougKTblv9YAwXvcq35U/9uaKyYChqDM3Gw8BwXQoaJPLHGLI5AXbEJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Jlsda61+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e25c5d75so1598373f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152132; x=1733756932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4QULb/zX2A/JzZm2UGTqGndiLfwLMKYm7Yhm20GACk=;
        b=Jlsda61+zYQGj8tx1hB6aS1DAI1IdVv8pjXmXakFbEq+gkUo/62vVZC0dcwzWMEOtC
         Xb/Nn+xNRAUeFbHUbQOcMmOHbysK14ceiWtXXTFZj2HfYsF6um5C87O30WmNbqReXjoq
         XbGu6fEjcXSpGP7qJlwKft9ywMvmxd6UZ1TtontsvBuFZlbXiOWOnbxXEfjPoHv/HAlg
         NBHZD1psM4nJLsOij8yFGIiU8oQTGHZN86z1L7nv0Qk5Rw2CsCPAt4t5RT0ytZBCe5cl
         saWB3vaE1YpoQL0Lj/WzP8oXipXBvcpbfQlNu4ypfipKN2h/QBrCR7z7Xh3guzzdecuo
         QWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152132; x=1733756932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4QULb/zX2A/JzZm2UGTqGndiLfwLMKYm7Yhm20GACk=;
        b=RDEWQnyeuMHEahWGHK1+a2KQHhQs1xeNNcWvWqEMXtu9vGAiW10qyLszSdu2JPm6jy
         hs6+x5guLRI+At6bMwnFVT8LuVbwIBQKjO9RjVCxqToC8R8B5Tx66cmM1fKhkjdZqbbe
         H4uUSlFWJkTDT6roVbNPF464Aatj/D4NxvqXosakRQ3F8Fple2X2RHDz1UjBkJKnguUO
         TFhIt947TuVOKgl5lRLnnrP64LZd42KRACQj711x8wf5sIPthVyYekpYDd3Kdgemhvgc
         eojtbefZUW8eVlsIHY/OpXpL8VfuTQzvLie7ziljPDcry177i/Je9baiOHawrS9aGHvM
         0PFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTwu+FTPY/JtVS7PFpoj+/nJuH5UR87TfhmNQj/YfNIygG87KdAyHzGMLfwlN1OfwI0fi+vKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaAG70tbCpArKMbX6ve1SUFOwaPLY+8j8XTe3MtvAQEJYvAkCE
	KVhm+Osrtlf0K9OkmVtTfDgE2+AYA/O4mFBENvYtdSn1y/lPw/XtZiMWuwFuEDA=
X-Gm-Gg: ASbGncv6oyyLIhTo2v2bZA6rrm0XrhdthHWGfMqg76Hdr+bVeed316bZiwboyg4cHnm
	oJR+AIerM4Q8kHzOn4fuFR8rzBRV5QleMvEO3TzBKaclA2DqVEdVIySfMKVtgziTwiq/f2CIdoH
	vqpwYXoSZ92uYy0WJaP1YVBBxURFFkIOujTsdEl1zedySY+VZ+PD/rFvOShjnPQgjP9lZVQNBT1
	At2FmzZ3Fev0Gb9mqxDYLeVCJTl9wHU9D1yg9ORfW4DeGHmZtxFNnVhORVG
X-Google-Smtp-Source: AGHT+IFxg4cHoPGVky36ZKZUxpd9wzXq36Jgdmrkwm2z2PHlDVLIn+dHxGtReNChwbA76uAlJYD0iQ==
X-Received: by 2002:a05:6000:1f85:b0:385:f114:15bd with SMTP id ffacd0b85a97d-385f1141819mr4679165f8f.37.1733152131775;
        Mon, 02 Dec 2024 07:08:51 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:51 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:38 +0100
Subject: [PATCH net-next v12 20/22] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-20-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=silTuCsQomSVhrC09ZgVVShik3tIYfu3bVc4ewGCVfk=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1n7EZeBZct2cvZQHJDDg3pf8dCvuSbWp/Da
 N4oBi2Z74qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 hxanCACsyAzlub5uYkKgMpDIO0WKMwioHCPioVpoycFqd3w3VPcTBDx7gn+YwibOU5I+q1mSjKw
 aF79M27sYk58Gw9AOaPspT5nZ9l1ukOyfMlanQVSaKV64zeXWgmL0ygjZTPgOZFfot1ZwypOY54
 l9kfi67GNCa12a3fR7A59M2vHt/cbPgppnwV97e0stFUP9FZPbLlP0L64RskKtiGEnIYRViiFy+
 oiU4zbkH7Ck2Wf7j1gMpDWGluNmhrVwuFQilBiQf/wruUHcKEUDk5R06PNTtnzIAPXwoKnZgdB0
 2E/brPnOYT35SkJweAlFxnKBCW+zPadi8JG14H/2sy/HmFLo
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 6a06ed02875156e87637c59339b53f11b7835815..c25ef9fb7f46fad4288504d8f5b15adab84a24ef 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1042,6 +1042,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(peer->sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
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
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 33390b13c8904d40b629662005a9eb92ff617c3b..4ab3abcf23dba11f6b92e3d69e700693adbc671b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index d33beb76ed8ed7b258d9250d29bc49be7fcc35fb..0e4ef1b6972f0c9cba19a01e40c6ab72a6d1f81e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -989,6 +989,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 

-- 
2.45.2


