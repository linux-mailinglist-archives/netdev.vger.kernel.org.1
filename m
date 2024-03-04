Return-Path: <netdev+bounces-77148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0AB8704EF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DE9B2628F
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF514DA04;
	Mon,  4 Mar 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XUrAsnch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9A47F73
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564969; cv=none; b=EVBVMvQZ1Pg6jxmMBms6pRlrwWTzIBCmNiPRYJgIDw8BIEkfupYPDJCYeoTe8Z0s3VTa4b/UcTc2dKbKUPo9WQ30RngGB9YuFOCwtrp6+FA9aRXAyzxOegE8ek+1dNhDfC2NBNcvxJPpdDeD8KW1AvaA5yfvkc3zA+mTJXIdmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564969; c=relaxed/simple;
	bh=VDiVOEuCiB76S0Sl0qb6o5tiRDP+35XfsId0Uy+fW/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSUUoYSpagrSrbPk4Gq2wmfNN17QhVKcOV8CBWiNC6hDhpoYBbtA4L6Q/+rcplfELoetZVqEy1F1oOL1QzGDg5X4CurpU4dal1PGdXLv0HY4xIlhQGWWGb4/WeKqGXzWxFqBEWSJbpLHgUjCxngUu5nshWhluarTZwe71fxGFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XUrAsnch; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so292649666b.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564966; x=1710169766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23J1Ackcb6eKpxsQg2sSqPu92fHTPaZsgTtV6xBrEO0=;
        b=XUrAsnchBjAGC+ogTny39BGvJHZgX6/OeGAHNl09rRKiYUN3AITwYcU1P53YRiM8sK
         GwpOxsB20xSKs5BsHXUlb2gozNDp2XBePok6jXBpqT8z+orCNlqsQm25MW7m1qnH3r8e
         xAhtOziWVvPS0cB6GX4EbTlDsJUeChke2m/0htSwsf9n/6UbBhqLFyCZWBJkarwKwOuX
         WvuFAyOY7mtEtQC40Kvglq+N505J/8lWFSynHybBiV8YMHMJPPFJiU6ts6KzrGINE335
         7hdMjYzZhHgv/+el6WsML/oC09e0M3qxw/cGZIvcjnDceP9aA+/wXgG1LEhYW8Df1Xc7
         jWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564966; x=1710169766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23J1Ackcb6eKpxsQg2sSqPu92fHTPaZsgTtV6xBrEO0=;
        b=Yia47B8iKTzwBdF98mWOHxr0prb3ivMXn8sKGFKJppxbGQjCt9XW756BiWI5w6oKK0
         QIqVDm5ijp3SAZMG+m+1FwaJpY/J5iTupurkFoy7iyG48G063juVJX5hCfdN4tncYafK
         OzxvWZAlUw20qra2uKcH0RNXwjzGnxjcEqrkD4MwOgFeze4V3rJVmg0ASA8fYzwvAi8d
         5eX/Qf5p4I6g5HcOYmDT+1JnPlCkQKSn7pLMrC0yiGpTQoHW2LlQOL+nvX0bXlnRWStc
         JNZOLSqRfDrUuWhc2iglAd0XYZFnaNOn518/skG1A5erVuE+0LV32ICUow9pwgX5jIEK
         UVVg==
X-Gm-Message-State: AOJu0Yxu3rOO2ACwjp6aSVkcdkcW0u9a8qhDDNYP7ZAHEe84M9pCvuLL
	la3MAFSbwX2BRS7UmbmxgaK3QSfmEz7Kr5PqqQlErHFirrAwQ1E3uzDQgLlehvAv8V9yt2nva0c
	4
X-Google-Smtp-Source: AGHT+IF6gV+iLkwoahRz9pCGE88lg9F3dMBmoT8jXpNVtJ9A0ba+tewQ+jvoYHH1OOCeN90mJQ5lvQ==
X-Received: by 2002:a17:906:578c:b0:a44:1d7d:fb57 with SMTP id k12-20020a170906578c00b00a441d7dfb57mr6625040ejq.54.1709564966019;
        Mon, 04 Mar 2024 07:09:26 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:25 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 21/22] ovpn: notify userspace when a peer is deleted
Date: Mon,  4 Mar 2024 16:09:12 +0100
Message-ID: <20240304150914.11444-22-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 56 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 58 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index e8b55c0a15e9..78e09707e5b5 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -891,6 +891,62 @@ static struct genl_family ovpn_nl_family __ro_after_init = {
 	.n_mcgrps = ARRAY_SIZE(ovpn_nl_mcgrps),
 };
 
+int ovpn_nl_notify_del_peer(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	void *hdr;
+	int ret;
+
+	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
+		    peer->id, peer->delete_reason);
+
+	msg = nlmsg_new(100, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0,
+			  OVPN_CMD_DEL_PEER);
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
+	attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!attr) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason)) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id)) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	nla_nest_end(msg, attr);
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev),
+				msg, 0, OVPN_MCGRP_PEERS, GFP_KERNEL);
+
+	return 0;
+
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
 {
 	struct sk_buff *msg;
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 17ca69761440..ac8ea60cefc2 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -16,6 +16,7 @@ int ovpn_nl_init(struct ovpn_struct *ovpn);
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_notify_del_peer(struct ovpn_peer *peer);
 int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index ca5cce0a0cda..50eb5839d8ef 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -283,6 +283,7 @@ static void ovpn_peer_delete_work(struct work_struct *work)
 	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
 					      delete_work);
 	ovpn_peer_release(peer);
+	ovpn_nl_notify_del_peer(peer);
 }
 
 /* Use with kref_put calls, when releasing refcount
-- 
2.43.0


