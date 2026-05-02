Return-Path: <netdev+bounces-283352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BA8OlFs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C54B0C38
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B63302DB7A
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA22D23A4;
	Sat,  2 May 2026 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkvmfKk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B992C3257
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691655; cv=none; b=kyXzS2dUorEPUmn5IGKP+n/EQrzBHLeuNABCegGjlpUFfffmUx7akdt4CGNHEVkYIu4cSmE5ipzI71GnLkXSEAXv9AXFWFnwosQccnPyL18yhlfsww7AMgrknlmSLvWtQdQwkvkRHUvSKsmNJrie/sDpFeVlwp65cPyBK/++mjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691655; c=relaxed/simple;
	bh=KqgxrcqWrR3VoLAoGU0Kt4yA83Dm3beUyrG6jLhpFqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7iKNpf/wYL4wyMFJZ6MKxluhze1TRmVrljxIstcUJBZC1nDfilP4dRlWGqtPGj5OWtw0ijbp1tzcCEfE2WURDkpwCxGrZx084AHyp66/0EubywZacIP4qBs5fZP/rmw8QvTuDhfBDpWj67RBkPC6w0LEb0Jg5dipIGUy127c1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkvmfKk7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da86144daso3036252a91.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691654; x=1778296454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YBlGuE6BrwOxz9C1ksWER8yXuaCi7+GhO7MNj37RJI=;
        b=wkvmfKk752n8Xpa32/dr0Celtqmedvb/Hs5mvydyb0+2T/XG/XCWEXmR58VrgkgSWU
         NErx5xfGa0Vnhz0hxOzFhJIHYY2TrdQRVr3SUHQR4Je2vzEd6aOX+LyrLnFfA3gFtpCp
         6HUQVcPYOAocHMT1nE8e3dxEkPGhvIKxx8sCW90HpNvYKDckKyz/ShmQorulL57TIwQm
         IfgM7aQ8l0K1Zcw3w0rdNxWZmSUg6/RoP9ZiHyAsfLliIPOse6JdPneGS5vAHHh/Kbda
         7JT7Bm3ik8W3eyt40YBLCA3/Y5kmBr1rEtLolnlpXWqvzViOHt66g8IW9O8/fT2vlXpt
         rVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691654; x=1778296454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YBlGuE6BrwOxz9C1ksWER8yXuaCi7+GhO7MNj37RJI=;
        b=Z+VDqAHlkcE8No2KCeTXV5JzcCfxp0SFZ8NvDSLSbs2tsoUHoys7jwSej4kgCy8m3X
         mbA1brEKnPqLTToYWSf9stUc+F8ecrrp+4hZhzMhKbkEGFt9xAhyScKu+KA0qoWYdqdT
         tFubhYrWWztIljqBw0FJjgewzLOWn/hg0W/zeST7hUKaqD2523BcWakEardhUUywSoH8
         mqz8y8JMzlMTdJh6xjksanEjU2YkLxQHPpOKggn6jPFJKQknvxHA+s5Uxpxk8F8QPPU3
         jpID7Sj4dGv1+g3Y82E5mXdMYYUYaThl+h2KbfJ4rNOQw2SEEe5tsT7lLYU0BeKZ/IXR
         Aicg==
X-Forwarded-Encrypted: i=1; AFNElJ8aJ9yOnefafsuySmE4Uhzq6xZ1sO+8SirLypmn3jpydg9OSnSQOXbBNctoPZIP002IklhKx3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAjaY5KKpf193c6l5o/sZzXtSapMw1hedufoxUJ+Ta1Y4AVJ7
	zRPgYvS1hZzo7Q/yQ6yT6bKeVwq6zKZJHfHSjZZ8L4P14R0sqbAghNvT+ey70Kq6Qjkewncj37U
	Ol5QFlg==
X-Received: from pfbef12.prod.google.com ([2002:a05:6a00:2c8c:b0:82f:6a88:310b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:3a2:d68d:9e7e
 with SMTP id adf61e73a8af0-3a7f1cacffemr1610260637.41.1777691653565; Fri, 01
 May 2026 20:14:13 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:58 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/15] udp_tunnel: Pass struct sock to udp_tunnel_notify_{add,del}_rx_port().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4F3C54B0C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283352-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

None of the udp_tunnel users need struct socket in their
fast paths; it is only used for tunnel setup / teardown.

Even udp_tunnel_notify_{add,del}_rx_port() do not need
struct socket.

Let's change udp_tunnel_notify_{add,del}_rx_port() to take
struct sock instead of struct socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c           | 4 ++--
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 include/net/udp_tunnel.h       | 4 ++--
 net/ipv4/udp_tunnel_core.c     | 6 ++----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 16df8d5c42c9..9cf62d3ee471 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -995,7 +995,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 		INIT_HLIST_HEAD(&gs->vni_list[h]);
 
 	/* Initialize the geneve udp offloads structure */
-	udp_tunnel_notify_add_rx_port(gs->sock, UDP_TUNNEL_TYPE_GENEVE);
+	udp_tunnel_notify_add_rx_port(gs->sock->sk, UDP_TUNNEL_TYPE_GENEVE);
 
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
@@ -1017,7 +1017,7 @@ static void __geneve_sock_release(struct geneve_sock *gs)
 		return;
 
 	list_del(&gs->list);
-	udp_tunnel_notify_del_rx_port(gs->sock, UDP_TUNNEL_TYPE_GENEVE);
+	udp_tunnel_notify_del_rx_port(gs->sock->sk, UDP_TUNNEL_TYPE_GENEVE);
 	udp_tunnel_sock_release(gs->sock->sk);
 	kfree_rcu(gs, rcu);
 }
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 184df57bc705..0ea88232b985 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1493,7 +1493,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 		return false;
 
 	hlist_del_rcu(&vs->hlist);
-	udp_tunnel_notify_del_rx_port(vs->sock,
+	udp_tunnel_notify_del_rx_port(vs->sock->sk,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
@@ -3600,7 +3600,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
 
 	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
-	udp_tunnel_notify_add_rx_port(sock,
+	udp_tunnel_notify_add_rx_port(sock->sk,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 29ead6a38ef6..498b7b262fa9 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -131,8 +131,8 @@ void udp_tunnel_push_rx_port(struct net_device *dev, struct sock *sk,
 			     unsigned short type);
 void udp_tunnel_drop_rx_port(struct net_device *dev, struct sock *sk,
 			     unsigned short type);
-void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type);
-void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type);
+void udp_tunnel_notify_add_rx_port(struct sock *sk, unsigned short type);
+void udp_tunnel_notify_del_rx_port(struct sock *sk, unsigned short type);
 
 /* Transmit the skb using UDP encapsulation. */
 void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 857b51d62ce1..44788b95c823 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -124,9 +124,8 @@ void udp_tunnel_drop_rx_port(struct net_device *dev, struct sock *sk,
 EXPORT_SYMBOL_GPL(udp_tunnel_drop_rx_port);
 
 /* Notify netdevs that UDP port started listening */
-void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type)
+void udp_tunnel_notify_add_rx_port(struct sock *sk, unsigned short type)
 {
-	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
 	struct udp_tunnel_info ti;
 	struct net_device *dev;
@@ -146,9 +145,8 @@ void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type)
 EXPORT_SYMBOL_GPL(udp_tunnel_notify_add_rx_port);
 
 /* Notify netdevs that UDP port is no more listening */
-void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type)
+void udp_tunnel_notify_del_rx_port(struct sock *sk, unsigned short type)
 {
-	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
 	struct udp_tunnel_info ti;
 	struct net_device *dev;
-- 
2.54.0.545.g6539524ca2-goog


