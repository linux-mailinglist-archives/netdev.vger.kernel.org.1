Return-Path: <netdev+bounces-143262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D189C1BC5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037EAB2543E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345ED1E3DF8;
	Fri,  8 Nov 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVJNzxv1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C51E3DF5
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063543; cv=none; b=ZIOtD1G5UTCrgaJgNMVmJur3OpK3EVLIKUzy/8PPA5r8KL5wAcP/x7AYTupZwLGpPI72fWBER33+tWE1W4vMmqZ6DutALXvj57gQrYqfdECuCw2Ym4BDGIvl7J9Qha38/bYcn0Ettue9DzoXGXFzU4+m+Ei75zmG3ZtULHmq5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063543; c=relaxed/simple;
	bh=6VS9VnfuAk+K1Eyqmm/TKciO4GfKZaTxogfw7UAMIbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7Fw+IMiq+RjDvXz8iYlgcAAGl0YFGTQNNU7nIMg9L3RyQX1oTLg4yE00pWKNkZiz6nYipQTe0GZq5mIwab/qz6A7Ag/+fZ/4LXN0mrEKnz3Znwzb4Gcwm7Hpl1SQsR76cwtRIHWioQm+ThC2AKXJCUMadZUPpmgxt9DzCFgXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVJNzxv1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731063539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+LpEpuygvE4o5DXZ4E6E2ItXbhagPjPDPiUxWLNwM4=;
	b=hVJNzxv1WMnLEnHo8d+A30pSC9iTcW/NIsd1QSQwCoqDPTA6esrmTRTNXtLxzQRefjty2P
	xBrRmm2/qFkD92yyxEvHCt9Me8A7ZeIJuJumFu0YuwgoBtAqL3UHBXnrddLHlDolqgX7ij
	gMt/ly+iMSokss/aZKWzPzGDMYSN1KM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-SJ_edObnN1mfNy-JatN0xw-1; Fri,
 08 Nov 2024 05:58:53 -0500
X-MC-Unique: SJ_edObnN1mfNy-JatN0xw-1
X-Mimecast-MFC-AGG-ID: SJ_edObnN1mfNy-JatN0xw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4F931955EAC;
	Fri,  8 Nov 2024 10:58:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9BD61956054;
	Fri,  8 Nov 2024 10:58:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net 1/2] mptcp: error out earlier on disconnect
Date: Fri,  8 Nov 2024 11:58:16 +0100
Message-ID: <8c82ecf71662ecbc47bf390f9905de70884c9f2d.1731060874.git.pabeni@redhat.com>
In-Reply-To: <cover.1731060874.git.pabeni@redhat.com>
References: <cover.1731060874.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Eric reported a division by zero splat in the MPTCP protocol:

Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6094 Comm: syz-executor317 Not tainted
6.12.0-rc5-syzkaller-00291-g05b92660cdfe #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 09/13/2024
RIP: 0010:__tcp_select_window+0x5b4/0x1310 net/ipv4/tcp_output.c:3163
Code: f6 44 01 e3 89 df e8 9b 75 09 f8 44 39 f3 0f 8d 11 ff ff ff e8
0d 74 09 f8 45 89 f4 e9 04 ff ff ff e8 00 74 09 f8 44 89 f0 99 <f7> 7c
24 14 41 29 d6 45 89 f4 e9 ec fe ff ff e8 e8 73 09 f8 48 89
RSP: 0018:ffffc900041f7930 EFLAGS: 00010293
RAX: 0000000000017e67 RBX: 0000000000017e67 RCX: ffffffff8983314b
RDX: 0000000000000000 RSI: ffffffff898331b0 RDI: 0000000000000004
RBP: 00000000005d6000 R08: 0000000000000004 R09: 0000000000017e67
R10: 0000000000003e80 R11: 0000000000000000 R12: 0000000000003e80
R13: ffff888031d9b440 R14: 0000000000017e67 R15: 00000000002eb000
FS: 00007feb5d7f16c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feb5d8adbb8 CR3: 0000000074e4c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
__tcp_cleanup_rbuf+0x3e7/0x4b0 net/ipv4/tcp.c:1493
mptcp_rcv_space_adjust net/mptcp/protocol.c:2085 [inline]
mptcp_recvmsg+0x2156/0x2600 net/mptcp/protocol.c:2289
inet_recvmsg+0x469/0x6a0 net/ipv4/af_inet.c:885
sock_recvmsg_nosec net/socket.c:1051 [inline]
sock_recvmsg+0x1b2/0x250 net/socket.c:1073
__sys_recvfrom+0x1a5/0x2e0 net/socket.c:2265
__do_sys_recvfrom net/socket.c:2283 [inline]
__se_sys_recvfrom net/socket.c:2279 [inline]
__x64_sys_recvfrom+0xe0/0x1c0 net/socket.c:2279
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb5d857559
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feb5d7f1208 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00007feb5d8e1318 RCX: 00007feb5d857559
RDX: 000000800000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007feb5d8e1310 R08: 0000000000000000 R09: ffffffff81000000
R10: 0000000000000100 R11: 0000000000000246 R12: 00007feb5d8e131c
R13: 00007feb5d8ae074 R14: 000000800000000e R15: 00000000fffffdef

and provided a nice reproducer.

The root cause is the current bad handling of racing disconnect.
After the blamed commit below, sk_wait_data() can return (with
error) with the underlying socket disconnected and a zero rcv_mss.

Catch the error and return without performing any additional
operations on the current socket.

Reported-by: Eric Dumazet <edumazet@google.com>
Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d263091659e0..95a5a3da3944 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2205,7 +2205,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		cmsg_flags = MPTCP_CMSG_INQ;
 
 	while (copied < len) {
-		int bytes_read;
+		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
@@ -2267,9 +2267,16 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-		sk_wait_data(sk, &timeo, NULL);
+		mptcp_rcv_space_adjust(msk, copied);
+		err = sk_wait_data(sk, &timeo, NULL);
+		if (err < 0) {
+			err = copied ? : err;
+			goto out_err;
+		}
 	}
 
+	mptcp_rcv_space_adjust(msk, copied);
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
@@ -2285,8 +2292,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
 		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
 		 skb_queue_empty(&msk->receive_queue), copied);
-	if (!(flags & MSG_PEEK))
-		mptcp_rcv_space_adjust(msk, copied);
 
 	release_sock(sk);
 	return copied;
-- 
2.45.2


