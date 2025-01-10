Return-Path: <netdev+bounces-157300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B6A09E05
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC30188F7C2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C52288C9;
	Fri, 10 Jan 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ui4eLviN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE422758A
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548004; cv=none; b=usv7dyBMwJTXogQJGwlHo8lxUj7vSLdTBLT74LWG05MJYv72ORajXv02kEUX0n4oH5S2/OT88/+FKd+AkABwRsAXvGCfg3uBLP0ErvmElxGTg7bFrCAWh7+7RXSr3yGYHh6j2UWgNY8BP60sy33E8J4owHXa2VitG1VM+PVAhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548004; c=relaxed/simple;
	bh=RTxhy6pn0gZiFOvpOuRGXZQEY04Ig49yF2u3K4JO+Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/6fvXMW/7PVZ/iiwQgDEBCeyVi/l9ELxiS+vqME2zMm5qzXVkZSDeC9Byw/dG4KQYpEF8DtkLfpWbbEP3mb+KWH5swwaQDiR3BSqrYY8qoW5kvmMufVr24sCIaluB1fAmUpd2TENwAu5EfdLXoXlD/r/UUYbe9AbhEoQYnNmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ui4eLviN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a34e8410bso1384063f8f.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736548000; x=1737152800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g2T9H3zYj+igPES3pI0uiRTkM/qH8v2b9qfmsQE7eI=;
        b=Ui4eLviN2jyvK8VSM+f2OpbkueSKN/6wrW2amrsGb4M5NvaNM5UhjHuTlen9L8cj/U
         PkgR42pNKNZ0YYZe6E7ruENIejFQ1t2arSrzSq0MydFGFUBb7oTfwjVF9CughcK1pKqR
         GvVSSQtPfebDhmrs0fSg25+X9Jp9Zr6pEtNE0Wbe12SqB8RWfteh4v37+ps62XXp+IUZ
         OpbT6N+RhhzGNQqxnUCOKcuI39+nWV1J3RMKCs1tGfh8S84YX0IlaWwMFrFce+AaZbNw
         O10TWicR7zGIGmr7VQV7LqhdwUo0Hmoyn1cGLWFNEcoO6YKPChgnHamqaFqUYzAeH7RO
         Y60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548000; x=1737152800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g2T9H3zYj+igPES3pI0uiRTkM/qH8v2b9qfmsQE7eI=;
        b=amaxgv0zBGtqNBSFKucdquGNurUEYLzw73bTtwRguXILNarZ/BNI0xFEh67GsUBx3L
         ximNEQIjXL2gdFVlyb9IVjbG6F2EhHXB5XYEI6pvMId62aOAtjPZUqGWwlNZ+XmC74+N
         1xifbv2F1ls/4c4HF6Usule6MbQBH2PeD8rlqEzNEMeilcfP8smzvx/eUfL9ZykUJAj5
         lga+czAu9pA87BWW1YCA8Kgt2ljwB+GRlODfryNjyk+OvHWPiVRXfquDyQlwR0HNmWsR
         27E5cuExKQTdNQc0U8q6Zsr18jAoeJxE+LjFFQdJWce312FgXo8ve7gRUDGjSCT1lTJZ
         5fFA==
X-Gm-Message-State: AOJu0YyEZ5nrGz7dvjDN7WwPxgMft9Oii7/q0E5zCpI8JYOMVsGYWpeL
	gQND85SOEmvgstHVNQ0XGYfTb7kFxD+zEhwI2Hq54eVTVPw3v/fW9xS35ve9nEJAv4tNAKZx5O/
	d
X-Gm-Gg: ASbGncsN6zKCpQqOKmjY0d2edeuA+xgrGEHWO6OQAhP3iQBzWF9o1b1eYXrx8uxoV/g
	7pqVGV19VV0EygRxv3nbAOf/Nyhis485tYJ294Qfu7A6Fw35OpG7RRvzLaKVVsKpkwd0+nOOlnn
	Fq+jkSfLQA+SkQR+Wxw2G1nEJs8GwkB+XivkmGu3d0wM7Ak5scNhMCh/l3iIomo0mgCU8uu+PTf
	A4zCxoUiO6A3OxQwK6J84a7OzA1kr05KBoVFShApbHuNsJ6fWwEp6SQlhrUMfsZ9KR5
X-Google-Smtp-Source: AGHT+IGoxUfKSONsje7ScRNr9CPvoVq3A4SLuj2eAAj9dmyZwzqU1PbPqLS+6yOBp4gwa6gEh7aaXw==
X-Received: by 2002:a5d:5f52:0:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38a872deb1amr13165947f8f.21.1736547999924;
        Fri, 10 Jan 2025 14:26:39 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:39 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:39 +0100
Subject: [PATCH net-next v17 23/25] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-23-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RTxhy6pn0gZiFOvpOuRGXZQEY04Ig49yF2u3K4JO+Ro=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6y7DtgvY0GJtHiByPb2iY99Ti0+EsUI676V
 xIk2v1GHKOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesgAKCRALcOU6oDjV
 h/2QCAC07gTXELlxA9C1LGlOxrjqYq0vX8jX32yCHnN0E/594giJ+xyvyk2kddWTUmmoptTJ8mt
 U9Yw1LWjHIG1K0Zpyh2HjdzJgdPRBApt9KTcOhE+0xMZcVGygzvkjWIpX6ulXEgSET5ON/+R8c9
 2jHtEE08xp2jAIUr3R+tXCiBPqxh7l9c3KkmrMMypAijPQfb7KhpsNm7fzTqj0tG8xSbx/+yuLi
 aXUkFtAJfcEXiEYLrCHClRmCxkIYiUJkA8jNxhTDViqZ70suWfBhX8W5V23GISXVnuoN1JmVyC8
 e0Luunwih+jV/tFhUC9inaf/5elBls0r49mbjl6lvmkWLHCD
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
index 6f637ce68b4524c248d4015eec2136d5e4495d8d..11bb17d94fd54c797edf7650cb709f5fecde4e98 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1047,6 +1047,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index f680b778c61cd40ce53cf1e834886d0346520a36..b032390047fec2fd9c70957b911c30ae8a8f12ec 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -675,6 +675,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	INIT_WORK(&peer->remove_work, ovpn_peer_remove_work);
 	schedule_work(&peer->remove_work);

-- 
2.45.2


