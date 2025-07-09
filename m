Return-Path: <netdev+bounces-205304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08016AFE2A7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9345821A0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB4276022;
	Wed,  9 Jul 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I9ToArK6"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5E274FD1
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049890; cv=none; b=QnCftJLPNBWNeUXbA9yXuiLehAwjSNMT7ZjQyOIHjVXmhQsZNFtnAcDU4rF+/JVIhmoftHu9j6VTtvzU5JniOXzEo5P8J9/DxZX3nxKwIV7XRJPiTIjiv9JcDzurbkY39furhEdhuQppyN6vjMsurkaaVxpFd1pQSNG4c7gyc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049890; c=relaxed/simple;
	bh=KMcNS7CJHO4AwRQ80vFOSA3Y0XRaHZZ9Qfc/28fKiPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbhOX9CfHwRwy9Ivn7zeB8js0ytVTkKogWGyXOnVmp44HXr6v8BKb7vKdNm98m5/jAJTrCI3Gl7ra3yaSE7yfGj+jbZ0b/voOzPOxdESNUdaQ5WAgA9mwJbO4K9boeohUse/ZklsLgeghJouhTGjiipLyawGZO7osGwQYKuAjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I9ToArK6; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049880;
	bh=51/6kCJDW/9Pwh6ELpqSSSf8JtzRdT4alycO7cdblXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I9ToArK6D5/vd+OC5FZ0MYnyD9htXH/2DejPy16Df2CGHhXKbALL++B1TNIR1uagU
	 F/UncnjX1ywQjRKljRPRk9cjF6APa4D4W/49Mjk8BLEx878EtASiDbtAFCvhsDM78c
	 +K+qfa1k2kTbhfYxqEI+BNlb3OaidoEsWdl6ysTGxzeLlujVbG1p6BpAfTKbcCNASl
	 hmZZgkZDDK9FZYxqHzEJUGC2VzDKN/M3AeXFGeaOad7etyUCBrDAjMn7g1MWxwlJEA
	 memxFUuQU0PF4ML98L5wyZTd2a8t6/fxbAo+9KgaQeFHTM/OcqpkDTcuqYthR4mqCw
	 Np4Trun2VZUDw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 85BD36B162; Wed,  9 Jul 2025 16:31:20 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 09 Jul 2025 16:31:04 +0800
Subject: [PATCH net-next v3 3/8] net: mctp: Treat MCTP_NET_ANY specially in
 bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mctp-bind-v3-3-eac98bbf5e95@codeconstruct.com.au>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
In-Reply-To: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=1794;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=KMcNS7CJHO4AwRQ80vFOSA3Y0XRaHZZ9Qfc/28fKiPg=;
 b=ofdHZ5jLdD3cwxkmf2mHsyvHJv5Yyrk4UbluJ4IwOyBTui+Jlzk/pBmRk/3WKE1/L7RlycJ87
 NnetyZLpSWxDq/5bkx2/w5SH90aYhiTMi9G5AvuV8iRqms+iMrvMkVA
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

When a specific EID is passed as a bind address, it only makes sense to
interpret with an actual network ID, so resolve that to the default
network at bind time.

For bind address of MCTP_ADDR_ANY, we want to be able to capture traffic
to any network and address, so keep the current behaviour of matching
traffic from any network interface (don't interpret MCTP_NET_ANY as
the default network ID).

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/af_mctp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 0d073bc32ec17905ac0118d1aa653a46d829b150..20edaf840a607700c04b740708763fbd02a2df47 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -53,6 +53,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
 	struct sock *sk = sock->sk;
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
+	struct net *net = sock_net(&msk->sk);
 	struct sockaddr_mctp *smctp;
 	int rc;
 
@@ -77,8 +78,21 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 		rc = -EADDRINUSE;
 		goto out_release;
 	}
-	msk->bind_net = smctp->smctp_network;
+
 	msk->bind_addr = smctp->smctp_addr.s_addr;
+
+	/* MCTP_NET_ANY with a specific EID is resolved to the default net
+	 * at bind() time.
+	 * For bind_addr=MCTP_ADDR_ANY it is handled specially at route
+	 * lookup time.
+	 */
+	if (smctp->smctp_network == MCTP_NET_ANY &&
+	    msk->bind_addr != MCTP_ADDR_ANY) {
+		msk->bind_net = mctp_default_net(net);
+	} else {
+		msk->bind_net = smctp->smctp_network;
+	}
+
 	msk->bind_type = smctp->smctp_type & 0x7f; /* ignore the IC bit */
 
 	rc = sk->sk_prot->hash(sk);

-- 
2.43.0


