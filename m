Return-Path: <netdev+bounces-128640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBA97AA2C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075A11F28D9D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E3149C42;
	Tue, 17 Sep 2024 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LT+el99u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89313E3F5
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535307; cv=none; b=Vme7X/q/yg/IqVlT7Wvp0+fbzUM7GGFJhQ90n+3MVKrgMEAG+e2DqrhTBrIRSs6UhYSyZFklhDZfdfLI6knAjABYxod1FKMG7tGcfREeZCk+CUaW6YCNFRELwEhq/Np8LbrYfyk1oza8BA+YEEtbMpNbQA3B6AsIa2fJraW07Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535307; c=relaxed/simple;
	bh=gmQ9PR67VTTkKG+vwu3DbIIFcMOCAT6eWx0qDfe3mIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2P3E0fvpqa5BIvRa1ZmzYpcoXWmG1cVqOyfYG6ZYQpaQmj507pRoWc18jqyAK4SEWUPQaBYWYtnPxhChHUi0fW7yvCq2l52RaLcEddh0IkjtGFerMjYHOAZToyms+ObeGKf69rGcvDY37PzlqgIQhVw3vGCSWh0hUA8a8cJP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LT+el99u; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so3609201f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535303; x=1727140103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AP6lQb79V4cqAragug3Cmco1c6XoSJIPGGFKU7bfGM=;
        b=LT+el99u3btrtUbwW5zAHtE7yddU+wmxvjqhyjdVJqU5ovXlVDmnxJ55fbOOOIjtdf
         Rl/0Ngy+JtvNugEwZ5sS22rj0Ogaf+ikN8lSHXW1pJtM/CVjpqwtjIS8SVBxmoEty4uz
         P520xYvj+SIjpa25GAnRWuaIKH5Sk2kX2PrQnDo64pBhvG+1vsGxubZN3kfdR/NsTGaT
         5I/06r54ZJCt5hzFY1aUObHY/mRuL1CM9CbcfA9A/c7fPGUzQFc0jNy54BAVANfiXsD/
         zShMwUXx5pVyy4WTxeB6bzCNkQgJGvc/68ni08ELzolCMyhUqZW22Awf7NORw/RGnupe
         di2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535303; x=1727140103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AP6lQb79V4cqAragug3Cmco1c6XoSJIPGGFKU7bfGM=;
        b=Uadg/2ANXlpuBSU9Ow61cRgggprcdaaikQT8bEunP1FBeN/zIRegyHV2WC4mtUCDGl
         xB2CT09wPIrPdxxIOsyl4cyxv7sVfHQlfc76SF++m4S5p912AyAHIWlo1TsFTrrUV+6L
         kPbm7l8i6tY2zRM0rAr9fF9auUjJp5gBzj2TWaziSslRKkIKQH+/L2t4FgO/TyVmq+xZ
         s9Xj+FWlZTDe0CtStw8L1EnIzFWde+dvYz4tiI5bqojB5tTfEVMHMrt5yBZncLeBR2NT
         l3/MFO8WKlRdEDiFiQUjl1fIGVM39AFD0R8AL+AS+PSG0ckJTs2sp4mDGtxvEzciIAbc
         IswQ==
X-Gm-Message-State: AOJu0YwHEpqRYIcG17FCFLLKDpM3879A+Pdhla82dfT35ZScLrEqDaIf
	gqlp8nS8uT9kn0DCmAxZ5YWDbgvmIqPge4W8m8kA/J8IqcfiD2A2km3uCGOOTnvcmJN+QgkMPP0
	U
X-Google-Smtp-Source: AGHT+IGCaoCpLGjzi3dOBOHrDmybhC7fbWxGFl/eoVOVMdX0Am3KwxQV44pn3l6DpkL89JYt/qjotA==
X-Received: by 2002:a05:6000:1e49:b0:374:c948:f4db with SMTP id ffacd0b85a97d-378d61f0fffmr10364932f8f.26.1726535303365;
        Mon, 16 Sep 2024 18:08:23 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 23/25] ovpn: notify userspace when a peer is deleted
Date: Tue, 17 Sep 2024 03:07:32 +0200
Message-ID: <20240917010734.1905-24-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
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
index e1b3cee4db77..368040962557 100644
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
index 83237ace4579..ef2b41e4d5e7 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -249,6 +249,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
+	ovpn_nl_notify_del_peer(peer);
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 
-- 
2.44.2


