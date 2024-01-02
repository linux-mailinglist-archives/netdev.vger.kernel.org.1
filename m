Return-Path: <netdev+bounces-60801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE88218A9
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDA1F21D06
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7897568C;
	Tue,  2 Jan 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvSH82IJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CE5672
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BFEC433C7;
	Tue,  2 Jan 2024 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704186063;
	bh=NJWMRq5VglzJ3fm+TnGGE1cqlsd8Wj9oQetNACFQGXU=;
	h=From:To:Cc:Subject:Date:From;
	b=MvSH82IJOVpZzjG0OYlh3tZlUMOKJNi0e0CHKQNNo5Yh9tPJDkgNVDvtbLkkqCVrH
	 GuRYkOCZBCYThVYNn3ACnXEASBLep1fOqCU8DUV9puqEfP6RP/LZhLalV7EjfZDXEV
	 xv5QjoRLvAm+qgGHH9YUAyoIVqIjUY1lotQ3zzDCbUEo1Hisgpk8zy9DBVFgEESeOC
	 8C1lVXrPzqmBEQkzaqhagxWClNgeEpjvsHYE3wVwMz+apHtI/HU8otJ9mYF56cU+Bm
	 moaV1ZnKeJ7OtBK+ut2XYppVJ2gz7PPtjSGcIYan3X+c6hQqP1qZPfB47L+C03cgSi
	 LhwLK8hgqdP6Q==
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shachar Kagan <skagan@nvidia.com>,
	netdev@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when receiving some ICMP
Date: Tue,  2 Jan 2024 11:00:57 +0200
Message-ID: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shachar Kagan <skagan@nvidia.com>

This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.

Shachar reported that Vagrant (https://www.vagrantup.com/), which is
very popular tool to manage fleet of VMs stopped to work after commit
citied in Fixes line.

The issue appears while using Vagrant to manage nested VMs.
The steps are:
* create vagrant file
* vagrant up
* vagrant halt (VM is created but shut down)
* vagrant up - fail

Vagrant up stdout:
Bringing machine 'player1' up with 'libvirt' provider...
==> player1: Creating shared folders metadata...
==> player1: Starting domain.
==> player1: Domain launching with graphics connection settings...
==> player1:  -- Graphics Port:      5900
==> player1:  -- Graphics IP:        127.0.0.1
==> player1:  -- Graphics Password:  Not defined
==> player1:  -- Graphics Websocket: 5700
==> player1: Waiting for domain to get an IP address...
==> player1: Waiting for machine to boot. This may take a few minutes...
    player1: SSH address: 192.168.123.61:22
    player1: SSH username: vagrant
    player1: SSH auth method: private key
==> player1: Attempting graceful shutdown of VM...
==> player1: Attempting graceful shutdown of VM...
==> player1: Attempting graceful shutdown of VM...
    player1: Guest communication could not be established! This is usually because
    player1: SSH is not running, the authentication information was changed,
    player1: or some other networking issue. Vagrant will force halt, if
    player1: capable.
==> player1: Attempting direct shutdown of domain...

Fixes: 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving some ICMP")
Closes: https://lore.kernel.org/all/MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com
Signed-off-by: Shachar Kagan <skagan@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/ipv4/tcp_ipv4.c | 6 ------
 net/ipv6/tcp_ipv6.c | 9 +++------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4bac6e319aca..0c50c5a32b84 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -482,7 +482,6 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	const int code = icmp_hdr(skb)->code;
 	struct sock *sk;
 	struct request_sock *fastopen;
-	bool harderr = false;
 	u32 seq, snd_una;
 	int err;
 	struct net *net = dev_net(skb->dev);
@@ -556,7 +555,6 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		goto out;
 	case ICMP_PARAMETERPROB:
 		err = EPROTO;
-		harderr = true;
 		break;
 	case ICMP_DEST_UNREACH:
 		if (code > NR_ICMP_UNREACH)
@@ -581,7 +579,6 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		}
 
 		err = icmp_err_convert[code].errno;
-		harderr = icmp_err_convert[code].fatal;
 		/* check if this ICMP message allows revert of backoff.
 		 * (see RFC 6069)
 		 */
@@ -607,9 +604,6 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 
 		ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
 
-		if (!harderr)
-			break;
-
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d1307d77a6f0..57b25b1fc9d9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -381,7 +381,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	struct tcp_sock *tp;
 	__u32 seq, snd_una;
 	struct sock *sk;
-	bool harderr;
+	bool fatal;
 	int err;
 
 	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
@@ -402,9 +402,9 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return 0;
 	}
 	seq = ntohl(th->seq);
-	harderr = icmpv6_err_convert(type, code, &err);
+	fatal = icmpv6_err_convert(type, code, &err);
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
-		tcp_req_err(sk, seq, harderr);
+		tcp_req_err(sk, seq, fatal);
 		return 0;
 	}
 
@@ -489,9 +489,6 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 		ipv6_icmp_error(sk, skb, err, th->dest, ntohl(info), (u8 *)th);
 
-		if (!harderr)
-			break;
-
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
 			sk_error_report(sk);		/* Wake people up to see the error (see connect in sock.c) */
-- 
2.43.0


