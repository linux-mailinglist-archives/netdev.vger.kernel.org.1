Return-Path: <netdev+bounces-138065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CA9ABB97
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A1D283FBD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE05A7B8;
	Wed, 23 Oct 2024 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj4RARWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7377111
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650754; cv=none; b=MnyVmlACv/jUuz7WzDVczbBoHkzVQxPHmAhKm7zHGOwCQf/Q3QfasNqFiztwZ/sgRCM04YWOA9bjAHADQ9upMo415eUAdJC507dBMhifui5IbH9R+bIhRkFd/0CgCOZLgHeptRIpR5NqhYAYoLGHSAjyjOq+N+R0S2gOrSuMIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650754; c=relaxed/simple;
	bh=DP+FtCvuMIZd6/BnGy3YHcmGQRT1aA22G7G7QoSQE1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNewyHCVoA6psLa7IU4k7Ze6IWuPhDk/VxXM5vGAGpoCVeLfSNJS1eNWGluZDSfqFvJBkwJj9ZQ9dDzxyo4bmPjkhv/O6P+0x8pfaxrm3GNkBxyTfuD8doJXl65BG95nGmImLZiXzHg4NO9aMYBANQaBu8jIFV3uh9P7GnrLuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj4RARWE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5fb8a4e53so2782010b6e.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650751; x=1730255551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gClAoFe1h5U+0NiA7Nj6o2YtRc1W3/sr4TmNeojvSXo=;
        b=Jj4RARWEYR3eiI8IGHOGUvyM4Dq3yJmsCu3/8qlaGcyXoTtWVBszx2YRXOz0qwSUEN
         nhWkCRTnzGLZjBiloBn/JfN4mjOqg3LvHyj56QLT0w+otNbaKRScul66RR99CHhjFQrX
         V7Itro/7wvnjronHp2U9cb7PjD+O77urKQpsJEKS0IDI7doa7/ej4RFX7i63UNesFbPJ
         0jzvZwCjeFmpfr6dbUfb8eMcx0M5s8Yd3V5vPYwXS+zX1Z6zb52MD8lKQ7463E5CgFRo
         FkSFoDuIVgvh9+iW1GaeExpchDVAtY9nJOgTyAY+hNtwoa03sEVzBOf3U17dzftg/I7l
         ZZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650751; x=1730255551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gClAoFe1h5U+0NiA7Nj6o2YtRc1W3/sr4TmNeojvSXo=;
        b=DvHDzr+gFSQNvLvhDCVEmA89Yw9dIa8QeDQWO3GvXdITUJE0J0eLNMs+zc8Ow8FPUT
         oYYyD6DNcBNk6qGZPaFcSuRp7Fy4fux6z30v7OyIYFtAnF8b/MK77RAZzcrYNmhkajX2
         2Sv/W5ZHA+CATtVazChFI4ciLky6bzq2HM4Ax1EG0l/JEMjrs0mb1iTCpgvVbk96VLfn
         HHQGqS9meQrIYwLFM83tZXuVs+7F9NXo/u76DyBN57Yfb+U9XnTAWrwh3Aba2+ftE8rs
         ckADiDDHVow7pfgp/vrFZ36lGM3aeGeg9SyMScKEzeOT96dqQ/Oj/3lgnnXqQn5ETUQX
         NZaA==
X-Gm-Message-State: AOJu0YxTp+ZQ/gjMgGuW9hh2O1GFRpglNhM/nymhPZaiBzLdEcaX1za0
	Xx4fp0GMoDWgNW1y4QhkWvWkFm1lVco+PwueQa4JP4bk6I7jhJYXUQQCMzwYWgQ=
X-Google-Smtp-Source: AGHT+IEDXGuR/QEPREdt6ljh433KApel17rJl+AQJ4xZnzLcKZC+KIqP7n3RCpZgE0bkrw4FTqIZ2w==
X-Received: by 2002:a05:6808:2395:b0:3e6:77d:2ea1 with SMTP id 5614622812f47-3e6245d4c65mr922602b6e.45.1729650751239;
        Tue, 22 Oct 2024 19:32:31 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaea9386e5sm4972284a12.0.2024.10.22.19.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:32:29 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/5] net: ip_gre: Add netns_atomic module parameter
Date: Wed, 23 Oct 2024 10:31:46 +0800
Message-ID: <20241023023146.372653-6-shaw.leon@gmail.com>
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

If set to true, create device in target netns (when different from
link-netns) without netns change, and use current netns as link-netns
if not specified explicitly.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_gre.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc793..6ef7e98e4620 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -107,6 +107,11 @@ static bool log_ecn_error = true;
 module_param(log_ecn_error, bool, 0644);
 MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 
+static bool netns_atomic;
+module_param(netns_atomic, bool, 0444);
+MODULE_PARM_DESC(netns_atomic,
+		 "Create tunnel in target net namespace directly and use current net namespace as link-netns by default");
+
 static struct rtnl_link_ops ipgre_link_ops __read_mostly;
 static const struct header_ops ipgre_header_ops;
 
@@ -1393,6 +1398,7 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
+	struct net *link_net = netns_atomic ? src_net : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1404,13 +1410,14 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink_net(link_net, dev, tb, &p, fwmark);
 }
 
 static int erspan_newlink(struct net *src_net, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = netns_atomic ? src_net : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1422,7 +1429,7 @@ static int erspan_newlink(struct net *src_net, struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink_net(link_net, dev, tb, &p, fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1777,6 +1784,10 @@ static int __init ipgre_init(void)
 
 	pr_info("GRE over IPv4 tunneling driver\n");
 
+	ipgre_link_ops.netns_atomic = netns_atomic;
+	ipgre_tap_ops.netns_atomic = netns_atomic;
+	erspan_link_ops.netns_atomic = netns_atomic;
+
 	err = register_pernet_device(&ipgre_net_ops);
 	if (err < 0)
 		return err;
-- 
2.47.0


