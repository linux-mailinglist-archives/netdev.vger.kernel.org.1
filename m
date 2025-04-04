Return-Path: <netdev+bounces-179376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657CA7C30A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979143B87A3
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02311EF370;
	Fri,  4 Apr 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHfcrMKw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64B166F1A
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789819; cv=none; b=Ya1oypRkoibNB3iCQA8KzCYd41rdTxC/INYgEM56SbgmeOLuGSx05Fe0kLnUP9QrFKuIpD9UOjv51koBEQa0Y4TQgNgf6GevU0+hgkNlAQNKyNZmkras6Ta1bDcSO4fB4Np8+gbcoD1Wvmz79rNNA8R9M58aTyiMEr4Vvb8I530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789819; c=relaxed/simple;
	bh=rcuNmjTWXODGtiSdwJOUAMZnFnJ5jgecFQn66xgVni8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeILfygsq009d9EmPLs5eZvLFnM0hCwVlFXmfI+LsgnzBd55a6R9yz7XKHD8sGghJCHgwfdj41WrAe1h9//QXfZdgOvR4BXNyfDoT2tjTf0cXAJ2DX2/Cpk4GMvUMaX+dxmmd/tnRNG+O3UEBNxulgywV3MMO3qXrnLV+rqUkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHfcrMKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE6FC4CEDD;
	Fri,  4 Apr 2025 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743789819;
	bh=rcuNmjTWXODGtiSdwJOUAMZnFnJ5jgecFQn66xgVni8=;
	h=From:To:Cc:Subject:Date:From;
	b=aHfcrMKw+1udwqJ7lWaqfqHrqnXAsxsU/2PdPs8X8jQl8R5dwp6Er2NOCmFLJLIOi
	 B6kMhDPc4WbQW6+w7xa5RZnzg6wTC7NnDNpCCGzusD3Qmrct7vAH12sXphPtHfyiEU
	 0IQpZX6RoSggL6tu761wbd1+5BTTw2f47q99N1dYLf4zkNjsJ64GUS9aMLdJVXt7/a
	 qd9K3KddvE3TUny7AGJ7mYiNHh5zzCH+Zaxcqg3vleqaLZNTgmn+1gu/mh/shvNjfN
	 vBuRpqNRvQm5obx9k24emAtG475gwpF9YSEG8H2uIrYnlcPK5pMeW4umgUNzNNdbei
	 XrQXCdw3PdNPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: tls: explicitly disallow disconnect
Date: Fri,  4 Apr 2025 11:03:33 -0700
Message-ID: <20250404180334.3224206-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot discovered that it can disconnect a TLS socket and then
run into all sort of unexpected corner cases. I have a vague
recollection of Eric pointing this out to us a long time ago.
Supporting disconnect is really hard, for one thing if offload
is enabled we'd need to wait for all packets to be _acked_.
Disconnect is not commonly used, disallow it.

The immediate problem syzbot run into is the warning in the strp,
but that's just the easiest bug to trigger:

  WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
  RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
  Call Trace:
   <TASK>
   tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
   tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
   inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
   sock_recvmsg_nosec net/socket.c:1023 [inline]
   sock_recvmsg+0x109/0x280 net/socket.c:1045
   __sys_recvfrom+0x202/0x380 net/socket.c:2237

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index cb86b0bf9a53..a3ccb3135e51 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -852,6 +852,11 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static int tls_disconnect(struct sock *sk, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 struct tls_context *tls_ctx_create(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -947,6 +952,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE] = *base;
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE][TLS_BASE].disconnect	= tls_disconnect;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
-- 
2.49.0


