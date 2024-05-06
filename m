Return-Path: <netdev+bounces-93578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E78BC55E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDA1C211C1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26E4D9EC;
	Mon,  6 May 2024 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WcZN5SyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CE4CB23
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958164; cv=none; b=T7cIBBXNy74CqrI2owiY2K1EXLuPRLfGrrRiOm/35COTxT9KqkJM/V4XrK83EnB2iZRkSyJGt9FjPsavXwwCPI9+nHAdyvkDTr7GNvFCRG0tS6JYxiCIox0NPEIP+BrMH98cI7tesmd+S87gcKU/fOgjJdvZdZyTFoR4Vz6qTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958164; c=relaxed/simple;
	bh=G171d6AiMeinGzagqD3NB/FB0aXqjgMhsDrwpDi1+FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq/sw48OLxEkOMGGp9zDNBX2euJk7qsrFZ5F8gsgMXv9ks2ph95a18xixLN3wU4HUb6sBenpmiVNZmxK4dNvlNYryPVjormJrTvmruRBMIqPxkN5Vpsf37CbpIHbc/MtfhZohW1lO2+fatGrdn9f4LPVKpOhLHqJR3mZiTFIFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WcZN5SyZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso10243895e9.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958161; x=1715562961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JVvnhyiEzM2fyP0hqdOr6+hRM9AaFv1yRUmUYuiJ+s=;
        b=WcZN5SyZmUQRXAZjrbygPSFSewBU9q9p93pRK5m5faA/wmJPseDcGiro8ri6lk6hH8
         NSsqvmkGEIUdln7ZEnsAeuuA3A7H6uoRu9cgqxQcDMEW6gTcgFMulYmDZ7cpnthfwpbN
         gS4SUOvlFXRFkgho21T5gWqjiRxLfqNhM8TB2wU3MUacJJmeKlDZ+d7yl4JSxdUPvyjV
         Mjq255dt2OI9IetOjyQgQF1Un7hEkH4QJgGUyt0rz8Z8jriwMlz+X2QDPaPmNIK5dmu1
         8jWLFJVjQ5W53aucFNjBuxFSY0viBhETs/tTnzcTBRNp+YleF9G+c2MtgWd3Fxlxernq
         IzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958161; x=1715562961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JVvnhyiEzM2fyP0hqdOr6+hRM9AaFv1yRUmUYuiJ+s=;
        b=dWzcsDQZRL/Y5XWRwpfqMmf2vTGaSBlrJy/6TTGYyo0IIk65KVicRGDsc3tqp24S0b
         H8VIAUMsAFnSRtOMQhK48BYZ6qsrHw2fWdJ6Dg3UyZ3TzCnlrvHHii44OO9h88ZEIKs5
         0U0SALoVuVfmuh91T3se4cpCxal9S1Mq5SqEABMc762+or13yBmpWaDpYt9Yh1ulRtZo
         Ow8kodIY51n0JKg+gf85FpY5pSTfdNQ9UhUy680iHBlPSv6ALPPA5to3xaIZEZOImK4T
         LLykn930PZ2dtAtvc5WA/T1MDD14gUkskHw791DaLqoIVCq4HnJ396yh0oshhZFLNhOX
         ESpA==
X-Gm-Message-State: AOJu0Yz3yFXbhI37wgqc3UZUKrAtT+MmfoeLkJE1E2KwJx7lHj+WjxCA
	oCd+kGcsha5rqMGFbq3F9CHF0a6Pss+OrTMZn4sSH/t3xMX4OCT0aP9+/fRJul43D8ilTAXMq91
	t
X-Google-Smtp-Source: AGHT+IF6wM3UsYMnIloRp4vhG1cUW1MzLcG3vgUyppTCD5GWhy+gOyAauQmVO4IVvADRD9Lw8w0/lQ==
X-Received: by 2002:a5d:5485:0:b0:34a:ed29:8d1d with SMTP id h5-20020a5d5485000000b0034aed298d1dmr5474696wrv.64.1714958161052;
        Sun, 05 May 2024 18:16:01 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:16:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 22/24] ovpn: notify userspace when a peer is deleted
Date: Mon,  6 May 2024 03:16:35 +0200
Message-ID: <20240506011637.27272-23-antonio@openvpn.net>
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

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 56 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  8 ++++++
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index dc80004eadbb..98c4e389b4f5 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -862,6 +862,62 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
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
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
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
index ccc49130a150..d2720fb67257 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -27,6 +27,14 @@ int ovpn_nl_register(void);
  */
 void ovpn_nl_unregister(void);
 
+/**
+ * ovpn_nl_notify_del_peer - notify userspace about peer being deleted
+ * @peer the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_notify_del_peer(struct ovpn_peer *peer);
+
 /**
  * ovpn_nl_notify_swap_keys - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 07daa359b3a2..fb94ace6c9cf 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -315,6 +315,7 @@ static void ovpn_peer_delete_work(struct work_struct *work)
 	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
 					      delete_work);
 	ovpn_peer_release(peer);
+	ovpn_nl_notify_del_peer(peer);
 }
 
 void ovpn_peer_release_kref(struct kref *kref)
-- 
2.43.2


