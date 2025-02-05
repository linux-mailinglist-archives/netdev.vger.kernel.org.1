Return-Path: <netdev+bounces-163287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDAA29D2A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A073A5215
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE74217F23;
	Wed,  5 Feb 2025 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Jmbwh/8X"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65297215F42
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796851; cv=none; b=DvX/6rQrsCZzPJvXz0UL1LiAOZYmqVCzfLpMN1NmsPYScRknuJPVZiZ8CaRJam8TOAN0AIKIUM5f2+Y7mTwjWZ1o9sbY7t1otmQ/fiducYWRnNEYXstRXSGaOZnQ2Od8PppwTRSf82sHKJjLk5frpxNgcZFHfocf9EbkmmcVaJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796851; c=relaxed/simple;
	bh=HFT37ec+sRmG1cHS4L1k0j/4DXXVwyXDumHH3SQs6zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FVwpZEYdh1dEUjuFPdExsGvbeeWaASPBtQ2v59HDDr61x1w6KrdDcfuNMMZl+9mhOKWvJwDjWTbJOMkQhT+pRId4lyUC6xO0l1kThJea/Rc7wQMoa033QLVE4PXbFLqULmu/Sq8qP+cxioEhgVC9ntDq11+9QjaA5RqZinGeaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Jmbwh/8X; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tfoUR-008kqD-FD; Thu, 06 Feb 2025 00:07:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=CApnBZY8aW04rYiLWasp59iJjgpPrNdh8OevlYFQObE=; b=Jmbwh/8XKyhIYxJcRBvdWvirRF
	kkRQs6yyO8HTWKFapFuIvOFFYcxg89w8wCG+LqqSp+DfV6FDxfA2hBPBQpLMhyzTl9LOEnminTytg
	CUifG5Qulv36b0GIm76bcaUy8vH+1y9Hvbubl5XSWgMUpYIXH7z6pAdHZlgpTBfJXHgoveTuO+itz
	+bsqLAP+9I9JEfv5le+FFQBptcYr3psm3oKO9fhjoRrJBtlBcZnegTYPS8TGLaIXhXyxQZ0xdwLtw
	s4AhuNgmf8XeH2cyP68ZwciErAHcPCqQA+itunakdoK8Cr6xibJhFX7XWhuyHUb+bmS2vl8sfmSMi
	0WChT9UA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tfoUQ-0006Hq-RU; Thu, 06 Feb 2025 00:07:27 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tfoU5-009hRv-Mr; Thu, 06 Feb 2025 00:07:05 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 06 Feb 2025 00:06:47 +0100
Subject: [PATCH net v2 1/2] vsock: Orphan socket after transport release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
In-Reply-To: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

During socket release, sock_orphan() is called without considering that it
sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
null pointer dereferenced in virtio_transport_wait_close().

Orphan the socket only after transport release.

While there, reflow the other comment.

Partially reverts the 'Fixes:' commit.

KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 lock_acquire+0x19e/0x500
 _raw_spin_lock_irqsave+0x47/0x70
 add_wait_queue+0x46/0x230
 virtio_transport_release+0x4e7/0x7f0
 __vsock_release+0xfd/0x490
 vsock_release+0x90/0x120
 __sock_release+0xa3/0x250
 sock_close+0x14/0x20
 __fput+0x35e/0xa90
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
Tested-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 075695173648d3a4ecbd04e908130efdbb393b41..85d20891b771a25b8172a163983054a2557f98c1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -817,20 +817,25 @@ static void __vsock_release(struct sock *sk, int level)
 	vsk = vsock_sk(sk);
 	pending = NULL;	/* Compiler warning. */
 
-	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
-	 * version to avoid the warning "possible recursive locking
-	 * detected". When "level" is 0, lock_sock_nested(sk, level)
-	 * is the same as lock_sock(sk).
+	/* When "level" is SINGLE_DEPTH_NESTING, use the nested version to avoid
+	 * the warning "possible recursive locking detected". When "level" is 0,
+	 * lock_sock_nested(sk, level) is the same as lock_sock(sk).
 	 */
 	lock_sock_nested(sk, level);
 
-	sock_orphan(sk);
+	/* Indicate to vsock_remove_sock() that the socket is being released and
+	 * can be removed from the bound_table. Unlike transport reassignment
+	 * case, where the socket must remain bound despite vsock_remove_sock()
+	 * being called from the transport release() callback.
+	 */
+	sock_set_flag(sk, SOCK_DEAD);
 
 	if (vsk->transport)
 		vsk->transport->release(vsk);
 	else if (sock_type_connectible(sk->sk_type))
 		vsock_remove_sock(vsk);
 
+	sock_orphan(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(&sk->sk_receive_queue);

-- 
2.48.1


