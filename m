Return-Path: <netdev+bounces-131170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97AE98CFB5
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F99C1C2295E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4E1E0094;
	Wed,  2 Oct 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GV/d1h4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654011CC881
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859827; cv=none; b=AhbcFV5U5oz+usubOIEhkqHSVAXnxvo3HpAEqRmgd+OGNcP+WZ8761L57enbLMibQxaRaQVoJ6lq6ktaTkMZwc6PB3Xb2uqp+spQGBeVVESfSv1PpX2CqKBSvymH1DMTwWzaMlSccFKS9ibcKMazStQZ8zFP073P9kxejwUhbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859827; c=relaxed/simple;
	bh=poxxnPMFHBlbgk9hT4KAoFDOsyv5Cr0vROL/GXgxBiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEiAxqIxl6FPYI8oFocqMNJLAqDkoH3FfWz5odjyE9iDqmZtwNJdwvuh1M409DcLi6lkle6Av/Qir2WGmYj++hNduWe1BTQYpLy+TSLz2OUoJLpuFfqvBCZQyRUDuBDtb7BF+fYKzo4885hXZI7wY1WsQotSQVM9CesW6E/0xJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GV/d1h4Q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso3301453f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859823; x=1728464623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1g5ErvOWdSDbVBAMFtgccgGsR+CcI40dCMnEOfXG5Q=;
        b=GV/d1h4Qf1LZEGio6mtJXom7t8AFQtKLKO2ICdv2UFXWgRJoPKFsjhULgSWnbSvXzW
         uUCfGPlZGLny8OGyb2OGe9/yD6I9+/APep9vktwOTE5wLkTCBREzn8HTFMqef3xxgSTv
         vO4Sav7dCxIJZYyiCXy2Y3vuWw/QzAv3MhW+AFbxtM2DBUzbKbbtgpHgFkHtkwA6aIoJ
         fgcw3f3w6LFY8jZAxydgLAymUizxLDmkNsygyngKjhjzQMEyIaNYbfnsiHkOY0BNhvZV
         DQhdkL97y/HmdCjxHV6ikwRPaElign7+bKrxsp9ya2L0fJkb214SVxmeBjs8OP0HAs5B
         b2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859823; x=1728464623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1g5ErvOWdSDbVBAMFtgccgGsR+CcI40dCMnEOfXG5Q=;
        b=YHpq8qYNi2fwJDcyFt0q41ofwXNH6bgOQXebM2JGuIkh00WqoRMg42+7Yx1GWFKRPe
         3xSBDbvcioeJeKptf8KMoIYw0Vkg4B2R8AJDijRBbBPJd+OfnutpreNnVRb+LJOjI8ZE
         VXD11Nl4W71mznI3EWLnmO/5Dwjmy/dhYBdfnXPXbxUphbZLC/7uW6cx3AUta/F17GkV
         pObmSJfSsi2V/sKqifJ5wYeZCMi4mUuEm+/tY9w8954rV6HkRi0ByON7Dv972TsztEY6
         O/XsPxUAIzTG6hfj649/QenAP5U5jVBKEj+teQKi1Ue7GUlSIkZtQsh2+jjKVkaNPUDN
         nRCQ==
X-Gm-Message-State: AOJu0YzmoJu64EzVfAEntHaGmZB+VjTf+pSjBYbqMWWX82RjpSVzoJDi
	uEegQS9N5Y24Pi1q7anIjQB+HHRFU79jV1nXcaX7Qhj6gMB64snRKZSlY2T2s28=
X-Google-Smtp-Source: AGHT+IH7fw/E/kQ3V24xzbtq3adS/XElxX31aae+kZFgbO0z9PggBosgYGxEoE3ngXbkU7APgvBgPA==
X-Received: by 2002:a5d:4108:0:b0:37c:cce6:997d with SMTP id ffacd0b85a97d-37cfb8cf38cmr2076166f8f.20.1727859822608;
        Wed, 02 Oct 2024 02:03:42 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:36 +0200
Subject: [PATCH net-next v8 22/24] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-22-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=poxxnPMFHBlbgk9hT4KAoFDOsyv5Cr0vROL/GXgxBiE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxTNGlDMBkkc6iZHWRsImvE3HBTYIXK4k31G
 ZWbXzIQ3rGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUwAKCRALcOU6oDjV
 h1tdCAC0zOmuy1ivCPWZ7NSHAKEAslKsZkAfD2e29GZ9yIJ3/eUZzHReWipsVVB4a60CNoWBDS5
 lNS9lc2ugXq+YF7h3CSnFLYJ+PsnWFx9TwDvAROujAPWLSRT3+pqtges/3bnS00tjE03wAg8vGd
 dyk3/LMDb47yHd4BEvvDBZ5MJNLFFgVLUkfdO1MKkRmJzyXNayw6YkoYf0vkjjYKcHnAnzKYR78
 wLvN1FPK4t/x+R1aMAXzQLq5sZvet7b/C8viwCeXVgyHV1cMi3LAuZcemDcTausTB2zxU/7dbQ0
 AMlxMizMwzwNhbX7+/sUIEDvjHiUJhd8ZeJ4WGDsAOLUrtT4
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
index e9cf847e99026e78eee4d65b62911671e8c2e407..b96c84fcc24921b2cd173ec2b6358b59eec72b39 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -963,6 +963,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	msg = nlmsg_new(100, GFP_ATOMIC);
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
index 1ce31f0317cb3593a8edf95c43d03a0bddb0a58f..f201bcddb2d792e4f6b759d5e1fed42234aa1410 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -249,6 +249,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
+	ovpn_nl_peer_del_notify(peer);
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 

-- 
2.45.2


