Return-Path: <netdev+bounces-150094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323969E8E2D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2873188800D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AAF216380;
	Mon,  9 Dec 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OPc+P5gq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41621A927
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734407; cv=none; b=ptdZ2XSDboKSEe4yH6V3f6+4EYMhLyTUnRQUPVMh7mamw5G1VWgjtF/rwAdVqNzv/4rW0Fpdc3YxFBUoHa2pCIYV1qG4sKQmYMbC7RgP1NVgl2m+0xu01fBoTEi5jZ0SXnE66yEMwbpVYjvmEiIvn+ybTSzuAp1pk3zVIBESS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734407; c=relaxed/simple;
	bh=2w03x074C1Ch4YmIvqL1EZXwi46cvkQyIQqVLlfb0iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8onSa9aL5B26YMEBC/UahpmxmDT35cwE6J7iMbBSzUQ2Bay0JUmTEiKH2sQ+2LddApVIdQkPT383eZEx32OndqljhPF0tv2OD7tGTPxUdLZ+rfKUe9To2tXuWlahcCtqBuk3gU6ZuxZd702yQmiJfVUrQkJiZGCGWvgauHYBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OPc+P5gq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso3282169f8f.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 00:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734403; x=1734339203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4bvAlWIlAJT3sFXjrq4CK+OVCRXz5cWRmVw86mNfzs=;
        b=OPc+P5gq6irDuW6pxQVTkkFFaXIcIIfmzJ1s/3J3xNIWnxU/XfN6kz3PTd4YS42RRT
         2Cfg9tBtNgogVG4Q5W4OxWhnPlLgLd08etcRgFfCASr9ApvRr0U0WiPgOPVzm4+Txm3o
         Zow20MwgY9kV6zXEkOruMQyv3JU3IbE977/MZNW7GXnK8Z6+X0t0K7HDuP3D5DzEK3HB
         df99a1/brU5vtgRxEF5j6jh4uhduk4i3DZQxcCWWhwDuXdW66Mdp4s9HtmEgoOvQRozg
         xcIn1N1cC63pzYQ6C+21nCcAv7BtVFwgvaQ8kns+etIBqcIOD4fvD4OBL31FBPRq/n/x
         j4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734403; x=1734339203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4bvAlWIlAJT3sFXjrq4CK+OVCRXz5cWRmVw86mNfzs=;
        b=RF5M+SehEC/q0TrEEv8/MPkkasNXAD15/d2IDb2ev394nXofkcBmRed32uXH+bqcOB
         8jDtFixlC0L2vVIQoHzBTh2FEZok8qQSJpVXiPWZPTXTOtr3tuCcsPUV/AbeBr369vxk
         Tlj42a0R5jFpIepKzDEOx6UPvDDoVjREcPXyD2LbyyamuHkpeN/umKc+FEwrJobFGCH0
         IU2HCZ8b7b1QdkaEE2pZbOlJxr5FYa+ZuCTmhpMafvj4udAYiUELmEU1Wp01/Fp/9vMf
         CobzKr2n2+vBON9JkGa1U10DyVtVFG8YAFmpAb0dbJUtN258c6el5fm+gHkiADZVTiw2
         XyUA==
X-Gm-Message-State: AOJu0YyuOwAV1Fh/8V1A14zn59dWBFUD73WwYiz7jW8BctDJCUncKhuU
	+heSBO7wE9NmGcyLUFq6C+3J2hq/C1BXjQjYIf9F9HrzOYTUffTdCGz82/Sj/YBSDJ87yyp8hkf
	N
X-Gm-Gg: ASbGncv8IUZ3Yba31udPAeMPW0wm+MsuQIe67OtTbCSlj4QTLFuW1qRKfICRhb0+AAM
	PffjFdbP8XaRtZH8zZiuX9nGQDqSUMv3LAmeMny+iecMD2IC/8NCGlQKqZKRWX1MlNCzMmLCmZV
	UnQPXxMuhXOyaILKSBBKjJ/Zm5ibbxE6btptVxN2M/0oF5OzlRtdB41HP/nbtNWFX6FkZijTB5H
	xDG1PNAKYQrkLt+JrqBC/VPIyXwUJlrUwN9oSiYYLN8QyLbo4XFfHFWvocN
X-Google-Smtp-Source: AGHT+IHOm6HGAx1cavZYLbkpD4UuFEb00623Xp1GfEaNpgWOFYLyQZW96BwNSzkcpJU8IyUjfm/Urw==
X-Received: by 2002:a5d:47a5:0:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-3862b34f6e8mr9004307f8f.20.1733734402733;
        Mon, 09 Dec 2024 00:53:22 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:22 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:29 +0100
Subject: [PATCH net-next v14 20/22] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-20-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=2w03x074C1Ch4YmIvqL1EZXwi46cvkQyIQqVLlfb0iE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAU6qIeZlQcbVLy3erqqdL/pTt9cOrOUfotk
 8IUNmCyGROJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awFAAKCRALcOU6oDjV
 hwnRB/44xV3lo+1ixlon03vhr7ZFG5ctnJIJ4F5HGzw9o5gVE3vGbr8gHCHjOap6R89jc05CvrG
 McEgQQz5lcER8qyvYIQvC1i4c/lc3VoTPiBty2k20F0PIM0fcyTi2+WiMptlJw1l/6pesZktMlD
 m4f2+2uU7oGA0c6XG7Ba9TUUmanQNnTqXsF+lmFdxSsGVxVY/YnJ5T0miGheTn21rKQGpPp7f6x
 NOiTJrH6t+PyhVswlaes0CeAJg7+rTYZDgCz04adh7zQT+dnisU9b6bGCM3TxhPMhOze0/7LCEI
 OIu5QldZPG471uGlsbfEQel+/oRwWsuDC+boSyA8ylErnZPT
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
index 355cd3aa4849b518bc794152e6d9d0bce7ed0f6b..20e9d6b5e92c2647b00f8d50f508b5b1bd8d83d2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1044,6 +1044,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 86caac747c6173672e4d3294639f60cd4138ac43..513b738364b9281861ea6b83a6330e78cbea5f4f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -995,6 +995,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 

-- 
2.45.2


