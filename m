Return-Path: <netdev+bounces-203721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB07AF6E3C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB391C45527
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC42D4B57;
	Thu,  3 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TFK4sJeF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CE2D0C91
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533931; cv=none; b=QZkptet+2BDtRxiHk+9vJQRxHtO3VfmUXgQwiFbo8rk3BtzytOcjt4YjmT3DSk1jN9oTY1VHD5Gj3wmSd7pmwO5AcGmr74ayVoGzYNXXyiqa7HoPNXVY0rSzz+vxVtHWIutHO49mRokAFMr8YVU5+qzVwfrTj7hsqIMmvlyHXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533931; c=relaxed/simple;
	bh=QBI2iP3QJRZKpK3s8DTjNIe5aPBO/k8JM+unXaTJfiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lig/zB4MZ2imNDV0hJCIr3P0+wlCLjATvPhO+rIRi7hkyjNQwt1ISqIHnrI47j7bfYHzMIZxdxm6/RrV81Znq0nQZDYGjO0m14iD/Rrmh87h/QrLOPokGm000YSxRjViJN4dZmoqyOX7pgDDC6kOzG9fcFH0eMnx/fUZB5jS8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TFK4sJeF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751533922;
	bh=rcyvbBKpVygv1djEzSphZGEwxf2oiL7S2oFdcGgm+9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TFK4sJeFkspr9jRd73lHVqhi/MsInXZkrocQQHZnMm14VxCJSaUJSt+RPNS0dcXhg
	 bRx7kb6+ZVEBJpu33cy2a+gOAkzDOnIIr6erml28ulyVbF+i3oWa+KSKkGmNN/znkv
	 a64BvqqFufbdCHj/tQZTAZvNPCQR0EcVQZaHU3SMnjpfoOk0teDvadZK9WEYb5zBmU
	 33ewFsnnfJaXqVPhw48MgCS3ARAeIDxfxSjAuH59iuGVDXyg6io1YdXq66y7bQgWCj
	 hB+c7dDwHxv7R1LSavYvMmaRJLBOH1hsHXiacVCbK/lnALvPcGT5XcnsM/EVndEm+L
	 ldBLSkRflDgxQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 2CA4F6A8E7; Thu,  3 Jul 2025 17:12:02 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 03 Jul 2025 17:11:49 +0800
Subject: [PATCH net-next 2/7] net: mctp: Treat MCTP_NET_ANY specially in
 bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-mctp-bind-v1-2-bb7e97c24613@codeconstruct.com.au>
References: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
In-Reply-To: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751533920; l=1787;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=QBI2iP3QJRZKpK3s8DTjNIe5aPBO/k8JM+unXaTJfiM=;
 b=JRfQeMKhCIF/3yWatH7rUYIdNJ3e+H2SlUoFMrRthCRx6zE6waMncuJ/mswZIeNSOEssUcq6x
 ilzxhh3XxUbB3PB+eyHKdC+88vOVkhmsS5V35s9aMB2fYETzF4Kbusx
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
 net/mctp/af_mctp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 72ab8449ebfc68f6b7a9954cbf13a7be00543358..4751f5fc082dcab27df77a9c5acbc6abb4e861d5 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -53,6 +53,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
 	struct sock *sk = sock->sk;
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
+	struct net *net = sock_net(&msk->sk);
 	struct sockaddr_mctp *smctp;
 	int rc;
 
@@ -77,8 +78,20 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 		rc = -EADDRINUSE;
 		goto out_release;
 	}
-	msk->bind_net = smctp->smctp_network;
+
 	msk->bind_addr = smctp->smctp_addr.s_addr;
+
+	/* MCTP_NET_ANY with a specific EID is resolved to the default net
+	 * at bind() time.
+	 * For bind_addr=MCTP_ADDR_ANY it is handled specially at route lookup time.
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


