Return-Path: <netdev+bounces-107266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB61B91A750
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859911F2430F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28D18755A;
	Thu, 27 Jun 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TRSbTOd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD5187543
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493676; cv=none; b=M/i0Q+0NsPVWGZHTV6S9sFafWswyvdECbFsl5Binhv8KHJrvV3o8grzykEq14VuKlbpjg8o/gcA4xWBt9QXk+CiOJ0ZRqWWv5XziEwJz+czLS1blW5P9TxCgdaDYFvxJ2E+SWxVhOHhywXZZ6x7yfZemfJGNX5/F7s6vVZBZov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493676; c=relaxed/simple;
	bh=x7T/2Ea9lBwouWS2XWTWObAVukB9hxejD/8eNj2CFeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+1f2LZLdFD8EBpY5x4IVHxKpXkNhFNFKmzE6sTWfGaQG3naij07sdkZ+8Z6XpvUMog9LW8Izv7c3bp/CYJ987AZ3b1LEZo8ry/dEH/9X8oBdCzgVrZy8hsHWSQmNH/96Yet7RHYSiI692BTOSp6LK7waVxce8CN/mNq4SBbtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TRSbTOd7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42562a984d3so9675855e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493673; x=1720098473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjGd8hLpVY3bZaMnXA4A/+92fdGMsR6NbKnRcptQhA0=;
        b=TRSbTOd7itZ15DxZjdX2SOedWH033Wx1bPyy163T57YNBm7Gj9EF8T0sRpcAPQ/jSm
         /sfgEJFYUjgqG7D/ggV66h2KtS9a7jq+uH46RBE8wJ4VFZXHapbSWkWsQFSc67m6JzXx
         R9s1bhS0GmTqJbrIDNDWwcbxETWCWWRAc+WDNcrRB9SQdDeYJmtQe/3eFZE6KceCcNF0
         JhJAmQT/9z4wLB4VzMLl6SI7DnRvvvCjCF+rR/B6EPD7PCtSjSQyFJwrfpZIysPeQLPW
         xlfA6lVgdYqzkS2d6ScZj93vmjvtzZvPXc7pVdpYZyMnSZwWUubLoVT2AnX0DXoVGaAx
         JSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493673; x=1720098473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjGd8hLpVY3bZaMnXA4A/+92fdGMsR6NbKnRcptQhA0=;
        b=ELx1MNe+hFG9MAlieqL5yxuDGIUAACUNy2e+va4YAB9PK/Hwz3zXYPMpxv5IhCohPu
         NBbFFd5g+bAcl04TDnHqh8VI41v9eIxiZlAiXpOa5J6QxLXbST6x0ah8LtyFgdFZ/iFF
         2QhSKbK7Fk9Dsk5l36knfNckPNzZZydb817oP6rBN/21mw+eyuAbRuaCAOCdGVKV27G1
         qjUbyAMBGLxj8KycjyRqlv0a6rH2jWG+tDOKIBlLFCWlYgLGQDkylfA0/jpiY1XPsgEr
         r3+vP2HFpypVoG9IXD1a6WA1SuIO4QMb40bJxcRgN5K4UbnbzuMwN+f3U8kNz6hBan/1
         wISA==
X-Gm-Message-State: AOJu0YxLkKQq9Mb26z6U/YqiZZ+Q43IxBPEHZFjvp5oKrMOkuBJR5n59
	nJSe2IbV5OgqFYcUwg/4omXLpXEGLDtQODHJV9SEZckNVqOY24d7mgJrR9ImSTzt2aLe2y5z2en
	W
X-Google-Smtp-Source: AGHT+IENwkV6CRUd1y7ET9vt7/TUGpqg1ZIgO33NJv8xSSmmiToPgDa976Q2yCL0Zkaku+3X5t7tTw==
X-Received: by 2002:a05:600c:4fc9:b0:422:7c50:18ff with SMTP id 5b1f17b1804b1-4248cc66677mr82407025e9.39.1719493673104;
        Thu, 27 Jun 2024 06:07:53 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:07:52 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 06/25] ovpn: implement interface creation/destruction via netlink
Date: Thu, 27 Jun 2024 15:08:24 +0200
Message-ID: <20240627130843.21042-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 53 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

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
index 3585c7401b22..ecac4721f0c6 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -84,12 +85,60 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 
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


