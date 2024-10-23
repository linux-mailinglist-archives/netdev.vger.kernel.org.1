Return-Path: <netdev+bounces-138064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C47DA9ABB96
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C261B23A73
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9E8289A;
	Wed, 23 Oct 2024 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRxKwYib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E1C3F9CC
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650749; cv=none; b=baA+1Zv1KXg0cwiLr1L28BI0YBS4MOnXJgJcy0Jxip7k0VFaNzaSlydzYg51o3TgFO22/+V5zEjs+eGPNke/yzs/mewwwYiR8z/XBCwigW5aSm9pM4pn7XtYbeK83GUJ+Mu5a7B/exNAHYTS7Sd9nZ+GjsttUCxANKpw+Xx0uII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650749; c=relaxed/simple;
	bh=vUMNMxZeLiPPmCS3W4GeXXclEDK3xSpLBVzYEtOvUfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjNK9fyGWQNyRpqngFft7rHCkV5nmtUuQMBv8uEbgOyYHf5IZDejeD8aaPfPIeCm2rOGfFFqqgZlnliSMgsXX0WM6w8QyEKnJiVQuz/+U9MGKz3g51D5R5qyfOqOk6rLsIATL95ywzm2xqrPajMtJ04qCzTBqoavXzDYif0jiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRxKwYib; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e6104701ffso1813436b6e.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650747; x=1730255547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUkTGTHxwSN6/nyZbXQLzBNsHbN79gfD6AzC8ONj3r0=;
        b=jRxKwYibwrMMyPcrYmyTkyHUOHyQqh56H/kdEDQY5ADgZmvFNyLvcewM2LnjggZ8Fw
         TPGDkHGx3TjKj/R1KC9w8QUBrbaP1aJf4OqDDZckWG8mGSG5qyMwWcfQkXORpLmI7Qvj
         va6kgP94WJ2IBg0Ig4DtmUXGxtZ/quCMJcGa1/booyqa6H2HC/O2avJ0mrg1/tJGL6gF
         7IeObdVaGsUZZ7517OBE37esWk6mkh2H7DYbjAMKdQ1YcY4tmNiFeEbmoOq4yWnWO54f
         lrmR9QYXzQJdeVMHhJtuHy+tJFrjdSxoL6LrcoykeaZ0wjeWT7X0ATL3wu6bhnylSohf
         asJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650747; x=1730255547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUkTGTHxwSN6/nyZbXQLzBNsHbN79gfD6AzC8ONj3r0=;
        b=IJtBFMdjEGeQYySV4uncIQMXCDGwt4SgtMzX75wWfmJRKx5d88GmeiZ3HXFHUv6NL9
         WSQ2ceyjIHmRpYZoDu34AdXEl9hY5Mrk3Meat1GI/6PXjJPTYti4nzFBkp34EYjOut4g
         4goDFakFNRtAlTQN4LK0UidTPaHniS01uQhZuUi9G5EfSL6PsT2IuzcAIH5nXkAVrTfb
         sg5zFwAXPqo9RN5FDJVE4KdbIff79W9G8c04aVHfKwplmiOXDZA5oPmp8K56nBEQyG5F
         28cb9wCywepapp6oyoRoXRDv8v8y8XRNuD5+lLzVOlQ/95b4uuFaXCbz6HHoi26g7y1g
         5bPQ==
X-Gm-Message-State: AOJu0YzTFXrOCb4QZSU2efqmncVImGS+t9wS2RVYqmDcoRvhb+BLPfwq
	r72JZ8u7eVcAtxYzyCbVwE+Tz4gg4PUQmB/efSWTyX/9YJeAgoSy7m+Jr4ovKmk=
X-Google-Smtp-Source: AGHT+IEGVuRSKCodWbj0u/pengCPqZPQ10WHWc2Qvm8NCV4PBB39xtgIQGWWN+V7cn8BeOiE4CV4sw==
X-Received: by 2002:a05:6808:23cb:b0:3e6:86d:ec11 with SMTP id 5614622812f47-3e6244e6ccbmr1078910b6e.9.1729650746696;
        Tue, 22 Oct 2024 19:32:26 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaea9386e5sm4972284a12.0.2024.10.22.19.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:32:26 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/5] net: ip_tunnel: Add source netns support for newlink
Date: Wed, 23 Oct 2024 10:31:45 +0800
Message-ID: <20241023023146.372653-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023023146.372653-1-shaw.leon@gmail.com>
References: <20241023023146.372653-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ip_tunnel_newlink_net() that accepts src_net parameter, which is
passed from newlink() of RTNL ops, and use it as tunnel source netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h |  3 +++
 net/ipv4/ip_tunnel.c     | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 4e4f9e24c9c1..67f56440e72a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -408,6 +408,9 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
 int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
+int ip_tunnel_newlink_net(struct net *src_net, struct net_device *dev,
+			  struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+			  __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09ee39e7b617..91d54ebe09c7 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1213,17 +1213,17 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+int ip_tunnel_newlink_net(struct net *src_net, struct net_device *dev,
+			  struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+			  __u32 fwmark)
 {
 	struct ip_tunnel *nt;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	int mtu;
 	int err;
 
 	nt = netdev_priv(dev);
-	itn = net_generic(net, nt->ip_tnl_net_id);
+	itn = net_generic(src_net, nt->ip_tnl_net_id);
 
 	if (nt->collect_md) {
 		if (rtnl_dereference(itn->collect_md_tun))
@@ -1233,7 +1233,7 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 			return -EEXIST;
 	}
 
-	nt->net = net;
+	nt->net = src_net;
 	nt->parms = *p;
 	nt->fwmark = fwmark;
 	err = register_netdevice(dev);
@@ -1265,6 +1265,13 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 err_register_netdevice:
 	return err;
 }
+EXPORT_SYMBOL_GPL(ip_tunnel_newlink_net);
+
+int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
+		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+{
+	return ip_tunnel_newlink_net(dev_net(dev), dev, tb, p, fwmark);
+}
 EXPORT_SYMBOL_GPL(ip_tunnel_newlink);
 
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1326,7 +1333,9 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
+
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
-- 
2.47.0


