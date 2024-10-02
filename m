Return-Path: <netdev+bounces-131153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4F98CF80
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D333F1C22496
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58B19A2BD;
	Wed,  2 Oct 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JQ01PDxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6EB1991C3
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859807; cv=none; b=LskOgG3kQbsw91vZrqNzhX0khVPvEN0mL5irAUllPpIloM/t5TW9w5/s5Z0aGO7iNya9vdYNHXiBk411xBnAvFq0LQmOcKsmEGTj1S29rtzNBzjPzHVZmlhlcQGRywbhQFvp2NfEh6l4e60pZE2fbrPaJKL5xpM7cezaX0i5XJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859807; c=relaxed/simple;
	bh=DM3y7oFYQLCwHm8IBgcaXTmAGiOJkdor1LAmtsasBrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bY53Vs8RrKJ9ekIe+EQP933TmfT9MQF3IgkWgbF2o0GvuFKD5RroYSXaB6wB7Z+LLHQNLviSzn6J+o4QtVPOOnVXd5b9FNWcxGoMvJzi8nyLLfeun2C2Dml/jEqzWjp0/XK/psLRZ2Z4ETqfbm9rf13UHICKfDGaGu7QLzqxbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JQ01PDxi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so60260235e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859803; x=1728464603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Hmat1snwy24bYlvJyESXk2i6jOGwhPoWPcr27v2+v8=;
        b=JQ01PDxibAV3680Czi8kml57r8DPeIHaq+Sclt7l/Mm8SNeywFffLPYwxRunuLRxtR
         LgoYCWgOvVrZ36by179yvOY5bIARq1pz2EH9fmRNlcsZWPnGfGmMZ+Q7DQv/rOE/yfK3
         8BK/xQRPyr5WI6yP2W+Lws8CAzLvHxXukNreubkGvFaUNQMFZObfoO5AcQ78qk8rvvVz
         hrDbUZED5yyptQn8JsQDq8a3r8PwADR1Kcw8PMxK+3Zp0Cy6Ha+5rpwL7YqErbmAiIBx
         5DXp0RfP1VAItFZbqrQKYlncTxFGe127nPv3AbG3rA6+vjs9zZWjm5TeAiD0p5+PsJ8F
         /HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859803; x=1728464603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Hmat1snwy24bYlvJyESXk2i6jOGwhPoWPcr27v2+v8=;
        b=jnMvuRUnDu3Vqi/z/VoFXuDwQL0OhlYYlZ3RC6TINOOExTgOtbSR4MjacR1h2IIp2S
         N6JkXeLVtKerSRLOWS55AuUdYKHOaWbmPpRXQAj2rH6C01Bc5adAPGrZJDZoI9jUAQ3M
         mbS3hLacGMFPBPzsEVBNoZfU8p6PMKPj50GegDetxXBK8bUWZPGLQNl1COF2kKTAExN+
         Vrp5/3gBomipB8mRJ99DfeHBBFZETMQW046asxNqgnXSDbq2wj721oDOQ6hLeLTi4Os3
         F+Bg3rghObzQV6ZPnLUQgtxg2V5hJv88tN12ySkvBEmrlalVhmLdpUGYBNCQCpR14ZPI
         /DRQ==
X-Gm-Message-State: AOJu0YzuBLFJCB2yQ0uwC82yNhOJWked/ugXQo/bC8PWzvrShJEoRiu3
	uUEqh4dAMZ4tq/eQg173v6Rgq54eg0IizyZG9sXYN8ZGeAYxdZosBUnxYNO1nO0=
X-Google-Smtp-Source: AGHT+IHGfgHXeajIqz5xpJZ16PbVXjaXdCIAwKIKuj2KQdvb9xIO/VhWAQi5VndxSje2DouimnQQIQ==
X-Received: by 2002:a5d:5e05:0:b0:37d:129:e30 with SMTP id ffacd0b85a97d-37d01291038mr487858f8f.2.1727859803560;
        Wed, 02 Oct 2024 02:03:23 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:23 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:19 +0200
Subject: [PATCH net-next v8 05/24] ovpn: implement interface
 creation/destruction via netlink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-5-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=DM3y7oFYQLCwHm8IBgcaXTmAGiOJkdor1LAmtsasBrQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxRH1VMATSW6B1xqnv/eu9vR9wYEz8Jjrm5R
 qpaluPO51KJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUQAKCRALcOU6oDjV
 h3j3B/0Y6d4sgBenZlLL6ACX9dYwWDNqmoDhw2CTWfpwixqbKb3ytFigN0VahpYrzVHO05Iki3V
 AqZGg/Jrjt6RlBPNheiP7gZN3WL/2RqhoxjwON6ksiUecEfCt8GiMhia9B2Tv/F6aqhZq/o7PlD
 YGOVZuuMkwaV3aA/TEv0jNd620jCszrYx9RfiFsFkYplvFMlnljq0G+/IaFYLt4PHmBltIFOvbI
 0vrtHoy30/DwcxCqWh6qmn5C/QFPwh2i9Msg1Did1xSFqhRx2/qFtmam9gFqL2n1a5sjR/0bZPs
 mQVIwP5ag4DexKaIrzqsGuty8bJdhx4Rr6mV0cav2WCO39CE
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Allow userspace to create and destroy an interface using netlink
commands.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.h    |  2 ++
 drivers/net/ovpn/netlink.c | 59 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index 4dfcba9deb590bbf119f51a40dff1517fe227b22..c664d9c655734263fcf58dd8f2fa5446565a29cf 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_MAIN_H_
 #define _NET_OVPN_MAIN_H_
 
+#define OVPN_DEFAULT_IFNAME "ovpn%d"
+
 struct net_device *ovpn_iface_create(const char *name, enum ovpn_mode mode,
 				     struct net *net);
 void ovpn_iface_destruct(struct ovpn_struct *ovpn);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 7b6b4d03b845eeb8654e37ac3495e8172ac3f291..6e60591d605dde19c6bbd47ef0e90e522776688c 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -84,12 +85,66 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 
 int ovpn_nl_dev_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
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
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "error while creating interface: %ld",
+				       PTR_ERR(dev));
+		return PTR_ERR(dev);
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -ENOBUFS;
+	}
+
+	if (nla_put_string(msg, OVPN_A_IFNAME, dev->name)) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, dev->ifindex)) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
 }
 
 int ovpn_nl_dev_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+
+	rtnl_lock();
+	ovpn_iface_destruct(ovpn);
+	unregister_netdevice(ovpn->dev);
+	netdev_put(ovpn->dev, NULL);
+	rtnl_unlock();
+
+	return 0;
 }
 
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)

-- 
2.45.2


