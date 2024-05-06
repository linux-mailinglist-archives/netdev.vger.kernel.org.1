Return-Path: <netdev+bounces-93561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F38BC546
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9D01F21C4E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08FB40867;
	Mon,  6 May 2024 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Xl2pJSJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A43BBEC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958138; cv=none; b=t1lTcBjUeda8SG+p5VheK9I08SPexpjtx9cwBSzTvXS3Q95L4aRFSqPr7WIOv26yHPtHRS0mUmBkGjhOCGf9+0+j0NQxhWdhvyjF0b/UIupXuohqsFuGQVCNLHHm3UwNxGFJqgeqH5yQLz+ZNlzSSkJqYppDsn9Y5gRyUIVsaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958138; c=relaxed/simple;
	bh=tER6JLhza7zFRdNMju5nroBN1iA+NKkGkGc7hpu6GM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtcCMPd5jqyBLGPVoOsmz64UTd+vfs75kwizyr5FCIJzPlOq+JXgidbW1GqlFu6kn3/A4ydUGV2eqEW9LFwIBtbThiY6WIO8Us14WNzCk8fx8TwWeXkzDAMsfdH1JTL6cljHdBxg+88PyGBlgr3AP65gqVjiQskfgQ1iNtbdUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Xl2pJSJ7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34b64b7728cso1245151f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958135; x=1715562935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwVn14yfEEetHJkvNIxbMt+laMZlz2IeI52A2PK/vWE=;
        b=Xl2pJSJ7P1DfOjY4UfdNZfCYW/FC+jEJ8hNaRi+8DTbvRRbG2U9Jq+DxxFsrtUHziy
         TEOolVUuQNP6qdeDukozLVjTi9FgZApIZ+OVRqXEhlj5wnspDasdlIpzOHyssxubjjkH
         5gFkQ+Syid7u0pda1Q5D0E9LQx31gJHkLrLZvyP5CsgvmahVSh9YqjcSu0vjoZO1OCn3
         k+fsPG2xPr+ZNcQ/OfQJzX2lIXd6rYq1jV1ANpA6+kxU1Z+nz2TsKwMQiC3in6sJAaBs
         IUv0AoMdLXOlQWDnxAVRxV5m3MlG2jp738P0ewFhJLOCq2Qf0ZzRfk4kHK9kvyf1nVHR
         VDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958135; x=1715562935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwVn14yfEEetHJkvNIxbMt+laMZlz2IeI52A2PK/vWE=;
        b=iVWbTYrQ0Haxt9hY8pWGxq7tqexzRHLEIOxsi85KkD4bacpkWgH0E6pVJHowkazeJ6
         c5k2pOcwa1FnZokRy9f1QuKA1Cu0LDJ7XmzERAj2sXS0V5BvUyzjY3FIOCVyXhgWqpPO
         7o8TMwiCHu4mViAgnoUg6zxA4OSgz8/B69q80ebfVqBLG3sSD/PZVPSalQwJojJZnDhW
         ldKQJQPBkjZNMSw9Tm+zTUGeX5+6KiRnuyAsIqqGcvDK2SNl6VJ23phi+MlFTRIl9M9g
         MHrn2QB7MoYF17yM6XMCzagy/3nCvTxssqDdkuQiOdJNGvpuOcQf+d9MssIm+d+aP/5k
         k7pg==
X-Gm-Message-State: AOJu0Yz9f7lFMw/uV6aRDywL087MKnR7y8QAXkNCFd3zYdLDMUDAJNdX
	rfqLbDGWJUXrvK0s6y7AERvAKQAfTXInU3/XqfyKfo7gv5YJF93Npk8qvDiTGUoOI7mrm7LCMrI
	V
X-Google-Smtp-Source: AGHT+IHs4ESAS+v/C30T9NQiYPhtLaKwxg64Ddj+pLUBENEGMepmMfUuBNcnYrQ/tftbLvKWvEnQIQ==
X-Received: by 2002:a5d:544e:0:b0:34c:f34e:68a9 with SMTP id w14-20020a5d544e000000b0034cf34e68a9mr5883218wrv.11.1714958135295;
        Sun, 05 May 2024 18:15:35 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:34 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 05/24] ovpn: implement interface creation/destruction via netlink
Date: Mon,  6 May 2024 03:16:18 +0200
Message-ID: <20240506011637.27272-6-antonio@openvpn.net>
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

Allow userspace to create and destroy an interface using netlink
commands.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.h    |  2 ++
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index 21d6bfb27d67..12b8d7e4a0fe 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_MAIN_H_
 #define _NET_OVPN_MAIN_H_
 
+#define OVPN_DEFAULT_IFNAME "ovpn%d"
+
 /**
  * ovpn_iface_create - create and initialize a new 'ovpn' netdevice
  * @name: the name of the new device
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c0a9f58e0e87..66f5c6fbe8e4 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -78,12 +79,62 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 
 int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
+	const char *ifname = OVPN_DEFAULT_IFNAME;
+	enum ovpn_mode mode = OVPN_MODE_P2P;
+	struct net_device *dev;
+	struct sk_buff *msg;
+	void *hdr;
+
+	if (info->attrs[OVPN_A_IFNAME])
+		ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
+
+	if (info->attrs[OVPN_A_MODE]) {
+		mode = nla_get_u32(info->attrs[OVPN_A_MODE]);
+		pr_debug("ovpn: setting device (%s) mode: %u\n", ifname, mode);
+	}
+
+	dev = ovpn_iface_create(ifname, mode, genl_info_net(info));
+	if (IS_ERR(dev)) {
+		pr_err("ovpn: error while creating interface %s: %ld\n", ifname,
+		       PTR_ERR(dev));
+		return PTR_ERR(dev);
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq, &ovpn_nl_family,
+			  0, OVPN_CMD_NEW_IFACE);
+	if (!hdr) {
+		netdev_err(dev, "%s: cannot create message header\n", __func__);
+		return -EMSGSIZE;
+	}
+
+	if (nla_put(msg, OVPN_A_IFNAME, strlen(dev->name) + 1, dev->name)) {
+		netdev_err(dev, "%s: cannot add ifname to reply\n", __func__);
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
 }
 
 int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+
+	rtnl_lock();
+	ovpn_iface_destruct(ovpn);
+	dev_put(ovpn->dev);
+	rtnl_unlock();
+
+	synchronize_net();
+
+	return 0;
 }
 
 int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
-- 
2.43.2


