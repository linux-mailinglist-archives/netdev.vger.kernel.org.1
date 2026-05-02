Return-Path: <netdev+bounces-283360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGuLJU9s9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C384B0C31
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74BFE302B232
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B82D7DCE;
	Sat,  2 May 2026 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZMlyLjC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA92BE7BE
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691669; cv=none; b=qzp3Wu+QrdHrD5wWXz5hi5ubOXCRdHnqNMFPnpcMQ1M1fCaKW/D2e5OSjClYqDnZciu3A2M1e182HTc+veqYXRU5+UUlcgp/5hkGYP2WEuZShD2LhtCoaJqe4s5VhQcpU+uiS0EX7mmyazPQ/zjH+fKhOKcbRN1nNipEH/yMVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691669; c=relaxed/simple;
	bh=q5qJCi0zt+LetNHU53lUrttCUupM4/+dzGhkX2VxTbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QXSomU5R0ZCezpNFzPvI23zU1b8iu5SU9/iZdECUTdS/F/mnGajXHIvXypuLIsSSRnacDPsgkLbvK+G0AEgtGOXnGNnzCQBU636TIjlPP6PF3gUVUdKT1BxD+0AJX9yVSi2igFF0KOxQQfRq55BqCc6pOVQqo/W70Zhh1MIQbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZMlyLjC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b258636d16so26961195ad.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691667; x=1778296467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcerhljnoUPbmnUag65wkuf+iiDo1CSQYWUdnEyWGRs=;
        b=VZMlyLjChtuNmo50teUfwbmWm1bs1Zz+w7MYXFWC6am60uk+wHoyJIgXDqL0n8Yq+C
         PITO3TJfnUJrRKQJFANt1jJZLVUbws6v9VsqMwa4GLUB6rMiac0/LiBwbgnZNMUbiHOZ
         TLMtrgNh0JTWaluEQl00ovwfwl9/CyH8hA6z+Mhs29PUs8vP4UY7iyMAk55cU1OtFGPG
         3ExounGLj/JGMgRLlhSyDNrw9r7FIrTCr++ac6F3ltJQ0fPFZIyidJ/NBQWRfHfxwBiB
         PAt131RiYnd7DjnRXtTFOJ1TWtDJG1RNGaFBDAdB22lYqGFrqG69ga299izST7TVDLyA
         WjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691667; x=1778296467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcerhljnoUPbmnUag65wkuf+iiDo1CSQYWUdnEyWGRs=;
        b=TkZGk71P7xTebX0iZIg0C/VEoFAcUzzya8mvXcPSWtfkOVa3/Navzm+Eqb53h+JNIG
         lhJ0yv61BjL+8pFIQ2GEoftvSXgo9+8eBgJcQ4OQ7EkHlAmhv6O6vo3Nyfxsq4MzzxL6
         PX613hiVwx7VzvqhqurSMK6WHxuSROgS0rd+PgYLA9hYRy2D3DF/PRzmoazPOfjDdRbC
         H54HK67epPIDulnyanAl6751MJCFANp504jmBaoOamF0XQcBUYW3gJHg+IH3wbNpncn9
         aZKqXEool03WLBR/+XYPp+8vu60bpfr63WquMxw7hwUBapiprZOe002uRHWOLWRFypFg
         aa6A==
X-Forwarded-Encrypted: i=1; AFNElJ/M2ahWr7yUXdnlCA0bFH1I3fr/YH1JSyx1pOxa98YW/X0y9depcHMQe5lW25czxBsly+MtIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDstUVsvxorx8/VMi13QLdgcMw9fnQfWLCIh8h79YiPTk/TT12
	tz1VJZDPPSoG3NZPzJavr3p4PTvPtD1JLWFakKs6E8WDUnEpjQnhj84vZaSllFH/Y/ArIP1HLzL
	JRtqWoQ==
X-Received: from plpj13.prod.google.com ([2002:a17:903:3d8d:b0:2b4:5be2:f5a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:2b7:8a56:7cda
 with SMTP id d9443c01a7336-2b9f252f9b3mr14082885ad.4.1777691667217; Fri, 01
 May 2026 20:14:27 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:06 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/15] pfcp: Store struct sock in struct pfcp_dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F0C384B0C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283360-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

pfcp does not need to access struct socket itself in the fast
path; it only reads struct sock, and struct socket is only used
for tunnel setup and teardown.

Let's store struct sock directly in struct pfcp_dev.

pfcp_del_sock() is called from dev->netdev_ops->ndo_uninit().
The 2nd synchronize_net() in unregister_netdevice_many_notify()
ensures that inflight pfcp RX fast paths finish before pfcp_dev
is freed.

Note that synchronize_rcu() is added in the error path of
pfcp_newlink() since free_netdev() will free pfcp_dev immediately
once we remove synchronize_rcu() in udp_tunnel_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/pfcp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 870137695e8a..5f1c9d2c0b49 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -18,7 +18,7 @@
 struct pfcp_dev {
 	struct list_head	list;
 
-	struct socket		*sock;
+	struct sock		*sk;
 	struct net_device	*dev;
 	struct net		*net;
 
@@ -104,8 +104,8 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 static void pfcp_del_sock(struct pfcp_dev *pfcp)
 {
-	udp_tunnel_sock_release(pfcp->sock->sk);
-	pfcp->sock = NULL;
+	udp_tunnel_sock_release(pfcp->sk);
+	pfcp->sk = NULL;
 }
 
 static void pfcp_dev_uninit(struct net_device *dev)
@@ -151,7 +151,7 @@ static void pfcp_link_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 }
 
-static struct socket *pfcp_create_sock(struct pfcp_dev *pfcp)
+static struct sock *pfcp_create_sock(struct pfcp_dev *pfcp)
 {
 	struct udp_tunnel_sock_cfg tuncfg = {};
 	struct udp_port_cfg udp_conf = {
@@ -174,14 +174,14 @@ static struct socket *pfcp_create_sock(struct pfcp_dev *pfcp)
 
 	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
 
-	return sock;
+	return sock->sk;
 }
 
 static int pfcp_add_sock(struct pfcp_dev *pfcp)
 {
-	pfcp->sock = pfcp_create_sock(pfcp);
+	pfcp->sk = pfcp_create_sock(pfcp);
 
-	return PTR_ERR_OR_ZERO(pfcp->sock);
+	return PTR_ERR_OR_ZERO(pfcp->sk);
 }
 
 static int pfcp_newlink(struct net_device *dev,
@@ -216,6 +216,7 @@ static int pfcp_newlink(struct net_device *dev,
 
 exit_del_pfcp_sock:
 	pfcp_del_sock(pfcp);
+	synchronize_rcu();
 exit_err:
 	pfcp->net = NULL;
 	return err;
-- 
2.54.0.545.g6539524ca2-goog


