Return-Path: <netdev+bounces-291494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECTfD/f9FGp2SAcAu9opvQ
	(envelope-from <netdev+bounces-291494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CC5CF984
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C5FB3041497
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D92DECBA;
	Tue, 26 May 2026 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VakpF9F/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479A2D8DC3
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760317; cv=none; b=M4FqKYhk3k1zkKZw3k0I4n0T7lJRhpiM1neBvloNt+OKtGvsnRU1WMvK1TNiys0dDv8E6nTFpYscbBrw9C7t3z2RSXCbTIP9jgG5YQY1cVdnEas1Y67CS6qF2ghyE2i8BxuaD4RUB5+GYiyXJZKXapM8w11QSRY1vrdJxrpZxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760317; c=relaxed/simple;
	bh=B+VvIJZJ4nB99UrivI8CwAovG0GOeVitrpITcOvmPLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O6cEm23sGBHm/gv0QDGtoftCzyB/ytgSacX8Iot6SSWEiyMFAXfWlI+e6+kXseaACBrdnewySNAt7HlOPgbuaT/dgqxaGdMVIU3JFDcv2rVGT2tu7wEbmD/bJHFjyCrhHxZRpBa19hNIQTJfi4T4m+Yj8cYeXeo3bR+L0Q5HdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VakpF9F/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso111928705ad.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779760315; x=1780365115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uIbVaBLDupHCPLx8MOZhJ3RSQBKAgNYtwLXGzBQOi4=;
        b=VakpF9F/vrtIrpqb+Nds/xHfcJFwUK8HhHQtR99XGPn04KRZqOz2gkc+YU1I4yW6iF
         NS08NhIX8d/Kti83KbomCU6dNYbnM1g3uhFmIl+Z0x3nKQ+v3MLksQzLaeuI7pH6fQry
         jTx3mEBsOd7lhTcjZUHCHMlr7VBpMoZueid4Ta9wki9INJX+W0Nz0u7GziqZsUU1NXqT
         jLFMPNNqVG/uCSpa8xMxDCD7VOB8cMBtUqffJ0rv7b+ktcY9i2tZt5fEobPYanE9NaGx
         FNtxiPRKu2tYD8oxRe4vOPDnt+dECzR6aGaQiDgZj+UOeE0R8t8LACjH7srwytuG2PcP
         frnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760315; x=1780365115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uIbVaBLDupHCPLx8MOZhJ3RSQBKAgNYtwLXGzBQOi4=;
        b=r13LciTzuLrY99s1RgoiXsOUWeD2gBL8sPbjI1vBVdmet8U8nnjARPEXBiln11Axrg
         lOS2AklYOHM47F9U+acnr670kexE6xTxH5f4DevAqVBX5ASZCNor4TWFS426tkkfDDVB
         2/0Uobrj12CAgTnPgqODcrxjnP0F7hXlDF+9JBBLHdcotT332ItFs3GPKBbeHSib5hde
         mhVnUB8RasoHJViaA5Yu+W7PBCuqXe8XdT/nUibTYbyVYAWWgMqCEOydnPwGdLbCLM69
         lJfqhhEM1BurFAUUZ0R1+Yd6I+dCQv23BvAJHqRhR9PKVWyCsgl33J9kNGVt9M8/RKog
         FnEw==
X-Forwarded-Encrypted: i=1; AFNElJ+ovwbgsRjO+jE+ActaMicNotclAWEHOCTMp9pDYUKU3TZwJM//mTFw9MAvH6tWs/QWbZTqMSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6U1wzsxmEr1BXkdPHP52NrVrMnijXHE9C/pmmoTyFqxoRPyM
	m0iDMovvKxmeDzEFeVVGZ42pA4fezvMbNXphFNvoOVcUpPuMulmnRm+6rseFNSZ1bQ1u6srha2P
	mZ/jfWw==
X-Received: from pghc23.prod.google.com ([2002:a63:da17:0:b0:c85:106d:12f8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b8c:b0:3b2:8685:118b
 with SMTP id adf61e73a8af0-3b3291c84a3mr15741419637.20.1779760315095; Mon, 25
 May 2026 18:51:55 -0700 (PDT)
Date: Tue, 26 May 2026 01:51:14 +0000
In-Reply-To: <20260526015152.2409183-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526015152.2409183-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526015152.2409183-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 2/5] geneve: Pass struct geneve_dev to geneve_create_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291494-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 892CC5CF984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a prep patch to make a subsequent patch clean.

We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
in geneve_create_sock() later.

Let's pass down struct geneve_dev from geneve_sock_add() to
geneve_create_sock() instead of individual config fields.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 8413c21fee6f..7e8c3023842e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -760,9 +760,10 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return -EPFNOSUPPORT;
 }
 
-static struct sock *geneve_create_sock(struct net *net, bool ipv6,
-				       __be16 port, bool ipv6_rx_csum)
+static struct sock *geneve_create_sock(struct net *net,
+				       struct geneve_dev *geneve, bool ipv6)
 {
+	struct ip_tunnel_info *info = &geneve->cfg.info;
 	struct udp_port_cfg udp_conf;
 	struct socket *sock;
 	int err;
@@ -772,13 +773,13 @@ static struct sock *geneve_create_sock(struct net *net, bool ipv6,
 	if (ipv6) {
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
-		udp_conf.use_udp6_rx_checksums = ipv6_rx_csum;
+		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
 	} else {
 		udp_conf.family = AF_INET;
 		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
 	}
 
-	udp_conf.local_udp_port = port;
+	udp_conf.local_udp_port = info->key.tp_dst;
 
 	/* Open UDP socket */
 	err = udp_sock_create(net, &udp_conf, &sock);
@@ -970,8 +971,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 }
 
 /* Create new listen socket if needed */
-static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
-						bool ipv6, bool ipv6_rx_csum)
+static struct geneve_sock *geneve_socket_create(struct net *net,
+						struct geneve_dev *geneve, bool ipv6)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct udp_tunnel_sock_cfg tunnel_cfg;
@@ -983,7 +984,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sk = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	sk = geneve_create_sock(net, geneve, ipv6);
 	if (IS_ERR(sk)) {
 		kfree(gs);
 		return ERR_CAST(sk);
@@ -1073,8 +1074,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 		goto out;
 	}
 
-	gs = geneve_socket_create(net, geneve->cfg.info.key.tp_dst, ipv6,
-				  geneve->cfg.use_udp6_rx_checksums);
+	gs = geneve_socket_create(net, geneve, ipv6);
 	if (IS_ERR(gs))
 		return PTR_ERR(gs);
 
-- 
2.54.0.746.g67dd491aae-goog


