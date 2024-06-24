Return-Path: <netdev+bounces-106076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4189148AE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9673B26329
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE61713B5B6;
	Mon, 24 Jun 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gYoLiDOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FA13B2B0
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228594; cv=none; b=cBhZaWvYiKvmPLlPWpsMa9tGXWQO914tgbqFJgMEsWwXU2ePi0wuDQ5rrqdALf1RbMG7NRJDWyhFIMAQxzzX1nax9mFp17fEPCOIg5JeJg94GDvrqXNa6iMUy6yyK+zSTZ/8xz4BvuxHR42maqJUeP8ixsEh1XfhiLLBd+bE2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228594; c=relaxed/simple;
	bh=2akHFFM7ElgZC9tfu5Jf6vTosV6RltOIH4B0PYAhj7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU1B2wQy1v3J7WEGorkvshYAp7MNndWaUJm1lekMYWMTRqPERwLH0jc4j/BiDpJgr7N/lVZDUpwk4ms6zQswhqlnlmrQFfHZPo22w543G8N+Q+clmYZsIUdo77o5ShWREboehH6Bt3y4RE0Bu71i20YGhzLR/6/RO05KhsLumMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gYoLiDOb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so31981725e9.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228591; x=1719833391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTpBCvR/LNPTmbz5XTnUH9d14zPddgG3nJ/vbawB1RE=;
        b=gYoLiDOb6vf8ztvJt9+k3E2fjn3jCFsUqmbTAq/nC/S0aAy5fKv2v9RbyeOuhfGdoA
         JmOzPxlot7l06vZ76O8ffViQbI/tgn+1t2CdHLeglzC3BzyciayOwO40kuS3FH76esYf
         vck5L4SClCjRBklJuOVw3IQxOTr9epJGIIeTalt0qxOynwGODEe9ghoi1N4SZBJpB0LC
         XzM5jPzZENUnc+ckBhabF8JtetR6MfWq+w2Mf4ZDDcwJ4CEQgJ32UTlxzf2IqWPGbRFr
         lg9qEdvcFd+J7HJK46ssTbhd7mpT5g7eKR2NGZBENGr1oI4lVJtWG1i1upIfldPeZHtO
         rc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228591; x=1719833391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTpBCvR/LNPTmbz5XTnUH9d14zPddgG3nJ/vbawB1RE=;
        b=B7l2LfbCdwJ/kdHluU+hHL7F2qLeCLHRTtah3+upNRoy4oLxa2X94mAo5VdgX2qxd0
         lUDkq45Pz6iOghzfuqukR/lLzxxQR7z3a70dPUe6LJuZD4GSCpV/lU1QHxSXa1ciz2sF
         QcZeTONM7bXbzGTN2RGCLlbsHeXcnux4KKdImcSLUIrErKOaX2zIwGypmZOI/sbuEYy5
         HbL8r6mRwPrhsqRBb3SqVE42fz/6TOqAesNICJvtd6uyazEAIBiW4+Q3HBeM74g2LdIt
         Exm6cZaijPg5aGrbK86cIFBsb7NseYy9419TrhcoAa5GimrB2p7SZr8+icJnKfF8QZnT
         8ZUQ==
X-Gm-Message-State: AOJu0Yz0lPKaIwwqT0dwf7gKi1gnHK1MgprEYRo6iGVnue+XTZVOt18y
	sQkdH7r/ihw6aIC+WSVyghG4RbuVL4qmO460zce8z93P0yO9Tu3CIs1StiLTWJ43J5/WOg62CDR
	0
X-Google-Smtp-Source: AGHT+IHiUmCuCyRg7Dr6QOi8ZvKh2cnlEviaAZO+ODB02aVnzyafnu/vArDuMlM8cY9vV3oO+0vW4Q==
X-Received: by 2002:a05:6000:460d:b0:366:ed18:85ea with SMTP id ffacd0b85a97d-366ed188620mr3219494f8f.10.1719228590876;
        Mon, 24 Jun 2024 04:29:50 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 06/25] ovpn: implement interface creation/destruction via netlink
Date: Mon, 24 Jun 2024 13:31:03 +0200
Message-ID: <20240624113122.12732-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
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
index 5f2c1eacc463..28f2216214b0 100644
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


