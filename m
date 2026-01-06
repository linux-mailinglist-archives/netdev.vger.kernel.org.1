Return-Path: <netdev+bounces-247418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E9CF9B42
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B9F30621C9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87FC35503A;
	Tue,  6 Jan 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bh62mNnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517635503F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720270; cv=none; b=C1YS6X6v37W/QhvupJd9kBQeEC9IO36RIzSciduimJSSDs0NZRUFO8izHzVz27o4CyJLaULz1BXVMl/YColdnyZ77RwweD1mLx1v20yqyVlNZhXG0FlN8jz2lnXd+JBxh+xBZ6a1QafotIWOpCTOhHnpXaT5xNohKy8Nbfbio+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720270; c=relaxed/simple;
	bh=PBXmXFFdoiGQ/k66IOSvnkSFvlB00/dqkUW5CoM2QKM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WYrqCsuX3k2wUtmjXI7H1EHP3PJMSdqYIu0af+49oqgoJw3o8neqgM0wbROJtlACOKeZSPmLA0aaXfYBHkUwl31AyYHvWYDvL3KYPdMbyp3Uv1TbnTH7O/0UFBuuYdOsxoHl1BMwuBoG7oKQA6+uSJa0DDWhU8WYJbD0iu3QSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bh62mNnQ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-890805821c0so16732686d6.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767720268; x=1768325068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l/AyzvVVbdSsrVuQYyqeT/KxjzeUSnesD4Ly6QNroPI=;
        b=bh62mNnQydUPXuGyyzo0VCAA18jLOMO8qhByg+dpojh8OoYrhuCUwDn2nUVbTCl888
         m+fGlDhCSlq2t9C4YMMMoTSu/bRM+pmdbpJ6mS4XFr4imSXUifZ3xXu9Ncdx0+xdm0PV
         0JYPpsHSgHDU7jAi7WYvZPOGMfbNLBYoLP1RHW5oCuPubk2zOBVHgcOUs37cOPqFHEIO
         Ge9vId14DgYgV2gR8xp6KVVlVOJ3mYXBX8tp7DRXocKwzQRdTLh1mbTbVVtutcrnYwEH
         qvii4pr79opuVDJ+nSp/qGKDDARZx8G0zgUgO26FbLuNpvZxufoPskR/pL63AGBUTYVb
         xmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720268; x=1768325068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/AyzvVVbdSsrVuQYyqeT/KxjzeUSnesD4Ly6QNroPI=;
        b=HFPO1mS0RpG+LnKDUEkUhmeSq/LWJx/qxLhRkyEJIIkKoYvmGLYxDm/9rCJ/FGPowI
         exRXyb2jWKJmDKfb6kAkU6l6OIrophALlR6z6CqDntWfZTmwdkj0I6dgSdZnebLLliFt
         Ih2nmGrOMFT7SFwCO11ZTZfNBJeEUsTQqWb8YyVbsYAtzDZ/S+3xPNqChWw0LUfaNl77
         vtEw0vuPGC3biCp6xXS8FE6gte/EQZti1KyuUz5znSuvzGaC0QkbPX+k/f5KieU/5JRB
         fcyDC6UPz+zF4sclPCDpPepSWTSTLlEsTR+LzUs4KI0GkqgLAtwpFOvNsB3pmFTT+joW
         y1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7fWtamYtlhwkziNUvXVCYaoWMDETar4VOomCedI6y2NlCgqgE28OcHaASrA0FHselW3Gh/yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR37yE3vB3TUVlH3f2d2DWeJ2NGRkSn0C+z7jfZgtqM6nihfvO
	z8lw/q96iz2TTd2DUc0JsZ2pjRwgr/cE9wFJzHeFi02NKyBgDVShX5E08ft6D7YZe+z4LtcaYhl
	CjVTVdb0D6s8Enw==
X-Google-Smtp-Source: AGHT+IFylB4GuZqZoiyzcivHPgGUq82wrHAtnHVGuXZcQyDEtSqHxfQUZaASjOvv58IyXBqFBvA2v32BvzSJ4A==
X-Received: from qknsq24.prod.google.com ([2002:a05:620a:4ad8:b0:8ba:ae63:9dfa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a92:b0:8a3:1b83:1036 with SMTP id af79cd13be357-8c37eb815abmr475583185a.29.1767720267703;
 Tue, 06 Jan 2026 09:24:27 -0800 (PST)
Date: Tue,  6 Jan 2026 17:24:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260106172426.1760721-1-edumazet@google.com>
Subject: [PATCH net] ipv4: ip_tunnel: spread netdev_lockdep_set_classes()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Inspired by yet another syzbot report.

IPv6 tunnels call netdev_lockdep_set_classes() for each tunnel type,
while IPv4 currently centralizes netdev_lockdep_set_classes() call from
ip_tunnel_init().

Make ip_tunnel_init() a macro, so that we have different lockdep
classes per tunnel type.

Fixes: 0bef512012b1 ("net: add netdev_lockdep_set_classes() to virtual drivers")
Reported-by: syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/695d439f.050a0220.1c677c.0347.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h | 13 ++++++++++++-
 net/ipv4/ip_tunnel.c     |  5 ++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index ecae35512b9b449fa061d96e66eb4533d1816bef..4021e6a73e32b80145d9241e4aca5e7881f04c30 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -19,6 +19,7 @@
 #include <net/rtnetlink.h>
 #include <net/lwtunnel.h>
 #include <net/dst_cache.h>
+#include <net/netdev_lock.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
@@ -372,7 +373,17 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	fl4->flowi4_flags = flow_flags;
 }
 
-int ip_tunnel_init(struct net_device *dev);
+int __ip_tunnel_init(struct net_device *dev);
+#define ip_tunnel_init(DEV)			\
+({						\
+	struct net_device *__dev = (DEV);	\
+	int __res = __ip_tunnel_init(__dev);	\
+						\
+	if (!__res)				\
+		netdev_lockdep_set_classes(__dev);\
+	__res;					\
+})
+
 void ip_tunnel_uninit(struct net_device *dev);
 void  ip_tunnel_dellink(struct net_device *dev, struct list_head *head);
 struct net *ip_tunnel_get_link_net(const struct net_device *dev);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 158a30ae7c5f2f1fa39eea7c3d64e36fb5f7551a..50d0f5fe4e4c6d83ef18cdea3ca25aed582839f0 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1281,7 +1281,7 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_changelink);
 
-int ip_tunnel_init(struct net_device *dev)
+int __ip_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct iphdr *iph = &tunnel->parms.iph;
@@ -1308,10 +1308,9 @@ int ip_tunnel_init(struct net_device *dev)
 
 	if (tunnel->collect_md)
 		netif_keep_dst(dev);
-	netdev_lockdep_set_classes(dev);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ip_tunnel_init);
+EXPORT_SYMBOL_GPL(__ip_tunnel_init);
 
 void ip_tunnel_uninit(struct net_device *dev)
 {
-- 
2.52.0.351.gbe84eed79e-goog


