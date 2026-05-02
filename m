Return-Path: <netdev+bounces-283351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQZEERs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17844B0C2A
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705AE302A6A9
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C72C15A9;
	Sat,  2 May 2026 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuNrbiJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13E2C11E6
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691654; cv=none; b=SB5oz9JVlLODxZrwdB8b8Op6sJQnrM4nRZmOMUUgI5aKrqOj6/YXFLZxxeeYZLrg0KKVNOkqv8hsjZ0WCiFUuXd/nFG7Ss9YzcehEdWc7NJAHU+1y+Dv1d2Oesz2flJzlqL2wrN/G4E32nagGs6P4dlGj1rNvyxXDGvIFsVZY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691654; c=relaxed/simple;
	bh=B1M0IkmpkxSBXONIXgmk12z00f+cvSIusxZotbDWivw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u5ELktjS9ZUuEYdk80+L7AFy2ylsYcw0pJAzlR4sRwghfXCM6rPHl4HTqkc3g5A4fDnA+zsIrFZ15/IjcB9d9hjWKCyXAnCKyoouBBV6h8F764t59mjSRqWfF0kvaxWLyQZDFGO2Nhq0B0vCUvfa6Ht7Icu9KkUcvYzW8emZ7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuNrbiJT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f07078eaaso1880302b3a.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691652; x=1778296452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=egvH+yTzr9bkPexnD132ipkTlBtdqhGUNyNeBvMOJ8M=;
        b=EuNrbiJTetZmaqiCdCtM7OWw2uCX96mUeyBDxCq3JOQA1DKNiO+X+pSnxoXYlUaKmX
         Qtizsxs+STAf4QiC7voTKUS5bKrhAbp1UyesRJ74unmhc5CRapkNk3bj8ndd690lPZXV
         c2xNSoviYIMTJ6/ftHxctoPJryh0rCVq/4OiPnICSMkev2gjVxwgW5UApoIXcczUpjHs
         eJ62boeODMhftI8MPYnFMYIAuGuyd3dkmRu9m7/QUsgqHZn7unTsjBpyaMQu7588SvV4
         BzLpArq4eZKodNiXnKI/M2uvOpoYbiXrDfPeq4gO3N8tRlsU8ruYN1cSpR5yNtBs81lu
         i3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691652; x=1778296452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egvH+yTzr9bkPexnD132ipkTlBtdqhGUNyNeBvMOJ8M=;
        b=TG/g73WFY6rxwulRhuai3rDqru/Q06jyRD01c0o0BgZ6Cs+EJsXpmZOg5yw+ZCPnnX
         q5T5VO64Urbght/Telw69R5D3R0uvW708vEQ2M8J2Q8rxVSPsIAO2yvNBHkq2ZfruzHA
         NXM/bhypugBKOF46LQwfzXwX/D+uOvxcQ1XGRyvo2v6dF5zG3os/B7Z2ZH742PzeDqe7
         tZJlnUC15hJt74h36EiFl8JeW+ZdSLJ6WLam/pE2EhInacFcJ4VrP6Q+ttceD/PZekuL
         gC/gDl2MjPyuI8TqVz9zmL7JyYvL5NT4bKfnIWexVL6wHPxXPOVssFVn5OZAJZP+6DtP
         bFTA==
X-Forwarded-Encrypted: i=1; AFNElJ/iUbZFYegUDxy5h0tHXIYngiAF41gxZLhReF85gTEHFytflOjdE9SK3aw5m+du9KfKJMxdq0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuApDhWA4VOo+QmEzlvSxyKXL1IAYVYfwhjF7KvIKT+ojPMdl
	LegGVK9ag4DnWACyWpWNXN83pjX1MarvGtP4inuzTvHn4aqa2An7KtPqq8Bnem4PJk4Gkrmg2V6
	oBRouIw==
X-Received: from pfne23.prod.google.com ([2002:aa7:8257:0:b0:82f:71fd:3094])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd0c:b0:834:df57:9d36
 with SMTP id d2e1a72fcca58-8352d228b5bmr1512868b3a.25.1777691651956; Fri, 01
 May 2026 20:14:11 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:57 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/15] udp_tunnel: Pass struct sock to udp_tunnel_{push,drop}_rx_port().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A17844B0C2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

None of the udp_tunnel users need struct socket in their
fast paths; it is only used for tunnel setup / teardown.

Even udp_tunnel_{push,drop}_rx_port() do not need struct socket.

Let's change udp_tunnel_{push,drop}_rx_port() to take struct
sock instead of struct socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c           | 4 ++--
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 include/net/udp_tunnel.h       | 4 ++--
 net/ipv4/udp_tunnel_core.c     | 6 ++----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 4b7081b97015..16df8d5c42c9 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1654,10 +1654,10 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
 		if (push) {
-			udp_tunnel_push_rx_port(dev, gs->sock,
+			udp_tunnel_push_rx_port(dev, gs->sock->sk,
 						UDP_TUNNEL_TYPE_GENEVE);
 		} else {
-			udp_tunnel_drop_rx_port(dev, gs->sock,
+			udp_tunnel_drop_rx_port(dev, gs->sock->sk,
 						UDP_TUNNEL_TYPE_GENEVE);
 		}
 	}
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a19f951e05f1..184df57bc705 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3332,9 +3332,9 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 				type = UDP_TUNNEL_TYPE_VXLAN;
 
 			if (push)
-				udp_tunnel_push_rx_port(dev, vs->sock, type);
+				udp_tunnel_push_rx_port(dev, vs->sock->sk, type);
 			else
-				udp_tunnel_drop_rx_port(dev, vs->sock, type);
+				udp_tunnel_drop_rx_port(dev, vs->sock->sk, type);
 		}
 	}
 }
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 14a9c5155608..29ead6a38ef6 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -127,9 +127,9 @@ struct udp_tunnel_info {
 };
 
 /* Notify network devices of offloadable types */
-void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
+void udp_tunnel_push_rx_port(struct net_device *dev, struct sock *sk,
 			     unsigned short type);
-void udp_tunnel_drop_rx_port(struct net_device *dev, struct socket *sock,
+void udp_tunnel_drop_rx_port(struct net_device *dev, struct sock *sk,
 			     unsigned short type);
 void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type);
 void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type);
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 3090b4745d47..857b51d62ce1 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -97,10 +97,9 @@ void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
-void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
+void udp_tunnel_push_rx_port(struct net_device *dev, struct sock *sk,
 			     unsigned short type)
 {
-	struct sock *sk = sock->sk;
 	struct udp_tunnel_info ti;
 
 	ti.type = type;
@@ -111,10 +110,9 @@ void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_push_rx_port);
 
-void udp_tunnel_drop_rx_port(struct net_device *dev, struct socket *sock,
+void udp_tunnel_drop_rx_port(struct net_device *dev, struct sock *sk,
 			     unsigned short type)
 {
-	struct sock *sk = sock->sk;
 	struct udp_tunnel_info ti;
 
 	ti.type = type;
-- 
2.54.0.545.g6539524ca2-goog


