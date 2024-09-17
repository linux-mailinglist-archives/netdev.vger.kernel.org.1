Return-Path: <netdev+bounces-128623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10097AA1A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2498D1C25CFA
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F305381D5;
	Tue, 17 Sep 2024 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="crJg12hQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731927442
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535289; cv=none; b=rGszG37XBt/tsuf8bsYbopzV2z2jqNhUmLEIQnpJldNQc1tv+4+QA8soc2phvzLYsxnW1PpWhJ5qwIyesz+a4oZFvjrpfpVkc45wjtJqqC21j6F1ZcdVa+23Dj9qTo25C+yAbKL1YAXO+zXQ3D+YV59F1nK3dJ9BankkcrkrvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535289; c=relaxed/simple;
	bh=dei1P7GLnZZtpXnQBBYiKpEthOHZB0Gl7ZGPElJvJnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azWlvOaJbt183SQlBweCGs0qYXsIVjZes6Vjxk3F12IDPLB8SQRr6iQK6ew2E/tBj37rfLhfwXv5t99lOBM1VPTzVr5tjUCGDcmf77vMdk+KCBO7j0nnGx2yQ/tzpMZG/8IfwJBKxMBUL2Iu3/Xj6uAy2LBhSNafk3kjYEB6Dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=crJg12hQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so50280485e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535285; x=1727140085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwfkecSsU/jVwN2hMJszdrHzhJ/D5WcezQOO8lja558=;
        b=crJg12hQbNNSLaJJljjVRqXT9cTiPktIWccGxPzdBFmMop2Yn+oAmeN/XC0kx9LU9f
         zS1N2q/JIzTqRu5hdFDEtywYSshHprmTqr2c4zLdZUaS2TLoScYRShoUHYBqZJ5mjNQP
         10L7K7rUqPw6TcdWD0VCyxvFaXKkRjuuhUKNr8WZurib6Z4wsr63n9HuvPdUzYHh0QgY
         YR8RnT1M/A49JjxM0ZEjw9GyUIZWncGjOB0QF6qaZp5dtUJZQ1wM0/cdayyKsnahOczB
         dE3tdOlLCYfvlmSOEPeK9kWuA1O4pi1i/TnaPP6/LaBCO2OV0F/vqObOd/hoxY/F91P7
         Moqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535285; x=1727140085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwfkecSsU/jVwN2hMJszdrHzhJ/D5WcezQOO8lja558=;
        b=EIGD+QQGgF7RHErH0GcDO/jSifytEOqMpqxhhBmoWh/Bx4WUlXkl0sr7XSeTP0LGwi
         hSVidvhJbmlZnXCj4NzLdqpuBz/Y7Qufc83szeE7b21ZbYgEAnxCfTiCk146ohayR78c
         Tbdy/OoIMrePHBEM5Vb9xom5hFwOUP/8fZtj6Ju7owjC5+tc7c0JwUEOiHN/F6HDK+HM
         z4BwDGjvx75TOPO256FpLHuAV4s1oiyNz6u8kbCwyGIvyGY6BUAZ0Nbao8t/GK/gyROh
         3gij6PPKvrPDd+qUB35T+IjdWolfHMiicHHcMDoO3kwVQrK16WMpmBBKidvbgE1m9ErL
         DlBw==
X-Gm-Message-State: AOJu0YzBQaFQI+K1DPmiV1WS6dfRkw8X5Mc6R/5+2sJRTLViE/DvRLTM
	4xp1SRrGx2zBXyAqm7JxXuNJ9OnO2Voz0nyHu//PXB6iVgF7cdyq5r030IYfHXIOb3CXsXduAcE
	p
X-Google-Smtp-Source: AGHT+IEl6Ay3t4XEwwTdpHfa3yLtBa+U5xHRwIbFY2OKiP2kdXA0MFGLRl6iNIzHUIxKYSFRFEWqiA==
X-Received: by 2002:a05:600c:1c28:b0:42c:b187:bdeb with SMTP id 5b1f17b1804b1-42cdb590f1cmr131035735e9.29.1726535284868;
        Mon, 16 Sep 2024 18:08:04 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:04 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 06/25] ovpn: implement interface creation/destruction via netlink
Date: Tue, 17 Sep 2024 03:07:15 +0200
Message-ID: <20240917010734.1905-7-antonio@openvpn.net>
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

Allow userspace to create and destroy an interface using netlink
commands.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.h    |  2 ++
 drivers/net/ovpn/netlink.c | 59 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index 4dfcba9deb59..c664d9c65573 100644
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
index b5b53c06d64a..daa2f1ec46dc 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -84,12 +85,66 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 
 int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
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
 
 int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
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
 
 int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
-- 
2.44.2


