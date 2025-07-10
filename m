Return-Path: <netdev+bounces-205709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB9AFFCFD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E2A3A4990
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8128FFE2;
	Thu, 10 Jul 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KrFVKyce"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CD28D8D2
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137772; cv=none; b=N5REO8fzAsGVT6t+udugPfj/y5lI31NJFlqeq5Tgrw/VEq4sMZ3GQ/Y11cActLVJI16mUIqD5CHMALaefmmYrEKP8TEuN3BB/fdyPvO+A/Zgd9H4iFMKpeD6U5dWwM98qPpUgewQWw/KNeRzgBV4AngiPbRkDlHZ9ougnewMIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137772; c=relaxed/simple;
	bh=KMcNS7CJHO4AwRQ80vFOSA3Y0XRaHZZ9Qfc/28fKiPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjCIBUWB4jAs5jHKpyW7zWvzsBXJYrg9MOWJH9bj8i3HKzdiNYKCOyCcgKNOP/muNCXj0ALDyQ2NeoPpOEiEYQXMpqxzloU+KYTVPBEwkm5YRbRtAGwMB4hJK3IuJTKPNISaDqA5J4aRUoX8eSmzIArlnAq8t+lzdiQe2qAhPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KrFVKyce; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137763;
	bh=51/6kCJDW/9Pwh6ELpqSSSf8JtzRdT4alycO7cdblXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KrFVKycez7qMpg3FqCsO7YAh7ZamFxYasG5j3mz7J/CrUlHh0cqNpwRKovkD6Miyw
	 AyPAnwsav5ph6Hp0ebxpoCJNG20Bax2hRQ+4/05gWuHH4pO7UUaY4du2nTAsKyx7VB
	 R4wRJXLySwcSdfW6Z4eZNr7ZXslvALSft9zXOH3RRJ38rNa0qk6CGlXii6z9N1CCPS
	 6wgMkQ5mh+hBjXzPRCi1Q5ZOSUuRzqC4l20UzAZJ4zudB42mBFvDfis1Z4/fpB3Zzb
	 Jk1DO9El0QWrHFSuXw54s6pqVcSiaelKowJzUdEaETM+JYpM6zH1gHO+fPI/dXGPeS
	 bZJddKYf2Zw4A==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 35CED6B23A; Thu, 10 Jul 2025 16:56:03 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:55:56 +0800
Subject: [PATCH net-next v4 3/8] net: mctp: Treat MCTP_NET_ANY specially in
 bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-3-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=1794;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=KMcNS7CJHO4AwRQ80vFOSA3Y0XRaHZZ9Qfc/28fKiPg=;
 b=sGHj5kSKXzWn45bDvq6P6uZgC+VIC0CgzGWqX+qMfxC52QV88j5Ub5nFlmmh+mdZp350Nf/th
 RMgKD9piszJCSBOzFptEsbB+BkVw2H5kqJ+8zZK6KNCQf5PuNXiM1vC
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


