Return-Path: <netdev+bounces-93577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1C8BC55D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F3E281399
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D354AEE7;
	Mon,  6 May 2024 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TJsuf2tT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25474AEF8
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958163; cv=none; b=Wbcpis5fWZZPu+ghGp/qHhImCWZmTxpU7MkguT9+2gtiK54Ac0U++DfYThJ85vM7hTVzbJzI6HSemAX6i2hmRvlgzfZ1RyzDhbrIntGlGDCrHbxGGAVCl2kI/+bJze9h4emXLEgH/DK/1Q0pBpcJY0avquh49XTtWnhCazj8Mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958163; c=relaxed/simple;
	bh=MHOPIgvetgx4o4LpFGM4AVVmJQYd0EJ7jM2TXN2N6AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+1xZq+TB/FQtskV/lbs14AAtBD0hNHQ4KX8lJrDYxUAR2/4ncCCJ4rYfn0STGy5olFQ2IKDDxgDwKtjqUYufUybGFaBWkW78xprquHndXBXG4Yop9JomtCHAxOJQJrEe2HpV7cbfKciqqiqRO+B7mZ/5Js8ZMarTzqcO0Npxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TJsuf2tT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34d8f6cfe5bso1027517f8f.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958159; x=1715562959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcO5J6F4upxHr6iTRiyUxZ+7ngc75atA0lKf8pSWIC4=;
        b=TJsuf2tTY7A8c5egfUU1roHtDkAzfbJbQIGMhLzZXzwMfOUdTGBa5bCQMVBKickjoj
         NfGj13vLHa/qNLCoxl71/hJn0c0WQdsExSl6i7TNL8gbjQUI392Hb9yg04QRY+zXBLYn
         yQdR5IclUwI03V+1q2GdyhYUcOGDogk7rzSLhB8wTE3XdrOBemhenFvX1PF7mV6xhiym
         95hbc78FkhvOnrg3x9s2v2q/vgn+G90ASpjK8gw6eH5dYI/yls+rUKtJOnSIxETueX9H
         mwD3u4Qw/S+KCpyci79qIf1cI8cP76QLbftzxVxcPbHQk8V/e6GSmnO/UF770yP9Fv8Z
         Q2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958159; x=1715562959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcO5J6F4upxHr6iTRiyUxZ+7ngc75atA0lKf8pSWIC4=;
        b=IGcAD+5n6aFg8m4+lBJE3hhwJoa+l32ORf02eJTRKl5Rm7s4q5cjcjBI/vgtpvBTwh
         r7tIgTqC9YLOwMcslXIpwcw7JhZb3eMcbeTZuvCZ3AzUa42nLtcLXRcNRyQgCtM6Qz3s
         u3Y9vTZWZF6quMeMasMkO0Zwpe+gAlRAhySDkcE7kxXgMzGEZD4MUImyuBlYSMjiZp9l
         C9UDez9qoqv6xsVRdcfbUnt3+993xEafaD3My0vPoTNgrCyfQFhsXqAZo4J/pkF9DG9E
         fOZd9vVQid/nbHLyyBF/aoSkGd/HdRO7O5+6+h9ZWbiTAJ+1WNhe2dwJVdfRfOY8mpBo
         3/sQ==
X-Gm-Message-State: AOJu0YwcApmq364SRDzBOhKc9Pdrxe7Vgazeb5Tqz3MtSXs8a8HtbueX
	i8dm+9+pZxmBC56ijCfWVvPsXu6M2KIcEu/XM2YkScfk8+ldf98NP/2f9GsWNJZ9/4F3fp0kHkf
	g
X-Google-Smtp-Source: AGHT+IE6kyU1DXn+z5L5bPhdVE9lMHnnhCSHaSc1fl2TZd3RaaChrriexDQljewtuc90PykSRE6Ybg==
X-Received: by 2002:a5d:498b:0:b0:34e:3efb:27cd with SMTP id r11-20020a5d498b000000b0034e3efb27cdmr7184062wrq.34.1714958159598;
        Sun, 05 May 2024 18:15:59 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 21/24] ovpn: kill key and notify userspace in case of IV exhaustion
Date: Mon,  6 May 2024 03:16:34 +0200
Message-ID: <20240506011637.27272-22-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IV wrap-around is cryptographically dangerous for a number of ciphers,
therefore kill the key and inform userspace (via netlink) should the
IV space go exhausted.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c      | 16 +++++++++++++++
 drivers/net/ovpn/netlink.c | 42 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  8 ++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 19ebc0fbe2be..8806479ccae5 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -336,6 +336,22 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* encrypt */
 	ret = ovpn_aead_encrypt(ks, skb, peer->id);
 	if (unlikely(ret < 0)) {
+		/* if we ran out of IVs we must kill the key as it can't be used
+		 * anymore
+		 */
+		if (ret == -ERANGE) {
+			netdev_warn(peer->ovpn->dev,
+				    "killing primary key as we ran out of IVs for peer %u\n",
+				    peer->id);
+			ovpn_crypto_kill_primary(&peer->crypto);
+			ret = ovpn_nl_notify_swap_keys(peer);
+			if (ret < 0)
+				netdev_warn(peer->ovpn->dev,
+					    "couldn't send key killing notification to userspace for peer %u\n",
+					    peer->id);
+			goto err;
+		}
+
 		net_err_ratelimited("%s: error during encryption for peer %u, key-id %u: %d\n",
 				    peer->ovpn->dev->name, peer->id, ks->key_id,
 				    ret);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index df14988c1f43..dc80004eadbb 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -862,6 +862,48 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(100, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0,
+			  OVPN_CMD_SWAP_KEYS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex)) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id)) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
+
+	return 0;
+
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_init - perform any ovpn specific netlink initialization
  * @ovpn: the openvpn instance object
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index d79f3ca604b0..ccc49130a150 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -27,4 +27,12 @@ int ovpn_nl_register(void);
  */
 void ovpn_nl_unregister(void);
 
+/**
+ * ovpn_nl_notify_swap_keys - notify userspace peer's key must be renewed
+ * @peer: the peer whose key needs to be renewed
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer);
+
 #endif /* _NET_OVPN_NETLINK_H_ */
-- 
2.43.2


