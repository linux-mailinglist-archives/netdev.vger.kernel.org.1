Return-Path: <netdev+bounces-122281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FD960999
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6664328721C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C201A2561;
	Tue, 27 Aug 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FOjB579M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA01A2550
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760410; cv=none; b=BDiOn35Z7hA1/ZjYU5RtDocF3KuCiRkw83mCaTwqusZpIF+gu5n2cvBOshOnr+eNITp0STuNRF8uNyP1JZgEIugE3ZXjiy6ba6QgVB6lfG3zFJm9R/DEZ018i96wiv0UNHvMBQZfWdUR0FFss/pxzc8Icz4pvMUgU+fofs6164k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760410; c=relaxed/simple;
	bh=dei1P7GLnZZtpXnQBBYiKpEthOHZB0Gl7ZGPElJvJnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p40gaC7hZ7nVIn4OvXFJp2sC7oT4xj92VVzdgJ1qjTaQEV9fYtBh+QU56kE69O5N3J8BGVYj+8ZypK+vb1ZnVRo29g//HkhlO/eCWjveUv1Qi68TKdjt0j3VaWhUxx2VTxHpkyZzH35ivtAcympx/mFbxRVLX5we4BDTEGFJB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FOjB579M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso46315535e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760406; x=1725365206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwfkecSsU/jVwN2hMJszdrHzhJ/D5WcezQOO8lja558=;
        b=FOjB579MtDqVZbFOvz4VEH+B02GqeeJ83VW3Dg5OaEdZCcqsHrGrgeE5b9GAlwuiLv
         B/kZuyMDzQtx3gRJ5cEXP7z3H3Gq61hjaJeJLMnYL/zPld29kq72GJjp1aM+iHq0HrLh
         8B0FmhNsPIYywb6lwSzQQByL95Kfmr7Q4f2WxG3iRsyg5/+YOefpzZkEnIZhszJ/t1Jc
         YtbDJXU8avi/8W1HRoGEn92NX77P5B6jEYe1MjlglgLUQ/NNIYJGorl4lopDGkZ9sXI1
         o68E8dJpIhTyzP2xhqeSP5hynHe63vzkn3ibMu8zRbxvzm5HleX8Dma73rvhqZkbXlyq
         akBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760406; x=1725365206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwfkecSsU/jVwN2hMJszdrHzhJ/D5WcezQOO8lja558=;
        b=DM0Skf8mwzpd3LhmoiDmdvsC3n/fw32OspCvloD8VS3krpw9CUSUpPUh/NNMKNU+zB
         EhTWFwokfSOgI4rpfByVvq8NLvtzy4Ab7IftNXOSfOw2kZKCh6nsvH4oiiwwpBDcKfRd
         78+WC8c9ybaduFsnAyGmtugY/jIVYrwPZOqJgfy0ElAubnz3haz5UUaqtRmqC9SZ5FTq
         gQSoV4cJydus8+blXc84uAc4YBXNjvrVHUr6CXQTGMzArVeyDKWIP5b7Ykam478BiTLv
         aIWUmDoLofpPwrk6NcGrfPS3PU4xoNzDr+UA2YVR5ppohbdzQ0Ydzm6EJIjxw0+yleT/
         JMag==
X-Gm-Message-State: AOJu0Yz4WK1HRXVTm2kKAEHFbzhb3XHUjIHjPZ/gPpDVmCHq4y1F21Jn
	p27+4CtUFP0Q/dh6RbVc0zpah3jZ65TSx912m6q9WzRHZIH1jFuo2JOuItUwgru0A25KbRrInV3
	D
X-Google-Smtp-Source: AGHT+IH0dr/gJkmGdPsv4g5H9qoQG5owNlh2jqRT82d/pUVMi88CwDP/t826GQuuNJj+dtMvINsrDw==
X-Received: by 2002:a5d:6d51:0:b0:371:8711:4b23 with SMTP id ffacd0b85a97d-37311864645mr7750445f8f.26.1724760405958;
        Tue, 27 Aug 2024 05:06:45 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:45 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 06/25] ovpn: implement interface creation/destruction via netlink
Date: Tue, 27 Aug 2024 14:07:46 +0200
Message-ID: <20240827120805.13681-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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


