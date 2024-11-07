Return-Path: <netdev+bounces-143061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F1E9C0FFF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3802849C2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11115218585;
	Thu,  7 Nov 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="P96u32QF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2781BD007
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012414; cv=none; b=c815fm4d7u8e9eYQUJ4dxEiKB9hkHxCbqL6S4XK+fRsFKmZ63GRUzCkfg2yYp+rqo1jnQnUIZYdHumMfEMTwFAleo7Bp9XZ33pE4rXnRJnez8bQGLoR6d9k+r/Hgo4SpoXMr0bOuwyuhMJrPF0yp0uZ+c+NwpJgfiTb/FlgktfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012414; c=relaxed/simple;
	bh=e5IKfunyoGb0Ek5V916MuqEwrlPLdy6g8yrqoCFGBok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czBmJFtwG48SNuk7riiUGhvQJPBMa7GJ3Ekku7sW0K3EfIZzEnvoELLbyXEcxpoyQHw+ILzwBKuF7DOnfZocE1yZMMMeGFMfWjRjt+zJ5mOSMvP7ojiVabI8PzELBl0gvnYPMEJd3U5bZMl6WIcoGfjxhW33LSzHlA4mY2k2BUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=P96u32QF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t99Oo-001cxx-Cu; Thu, 07 Nov 2024 21:46:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HRZX8buQz6RmBI2DZF8lqBqN9e2vWZHgaP9nDHLV7tM=; b=P96u32QFvgzjiFL+52Wvb5uwZA
	uPOPISdQuotLj7aDj93t6BIcJ3yYGJjRX2N9X1zZHF/sEu1AyKXQND4uYGctPxG4mj2qE5HCGReIf
	6yLVm5c/6s4an7+8zm5qMXRv0GmfCuKavFkCUYY09OZ4qZc6uZ2nFBAZTmsagxmtUkYBF9W95bgKs
	vsjykjLvhQXzCuCbt/A5+EHac9U5csKbji6XTvjmC7PQMwfShCYMbgd9GsMQR0AbyimU2kU4++kI0
	Jed8FgrPU3fb0E1nJ6wQFOUQqX+f+7PCFlBqwvPrynwc7uamFboPfObT6tpRKzFuDJJ1Dlf39a92V
	KZb5Es+g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t99Oi-0003Ew-FY; Thu, 07 Nov 2024 21:46:32 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t99Oh-00303e-9I; Thu, 07 Nov 2024 21:46:31 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 07 Nov 2024 21:46:13 +0100
Subject: [PATCH net v2 2/3] vsock: Fix sk_error_queue memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-vsock-mem-leaks-v2-2-4e21bfcfc818@rbox.co>
References: <20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co>
In-Reply-To: <20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jia He <justin.he@arm.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
 George Zhang <georgezhang@vmware.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Kernel queues MSG_ZEROCOPY completion notifications on the error queue.
Where they remain, until explicitly recv()ed. To prevent memory leaks,
clean up the queue when the socket is destroyed.

unreferenced object 0xffff8881028beb00 (size 224):
  comm "vsock_test", pid 1218, jiffies 4294694897
  hex dump (first 32 bytes):
    90 b0 21 17 81 88 ff ff 90 b0 21 17 81 88 ff ff  ..!.......!.....
    00 00 00 00 00 00 00 00 00 b0 21 17 81 88 ff ff  ..........!.....
  backtrace (crc 6c7031ca):
    [<ffffffff81418ef7>] kmem_cache_alloc_node_noprof+0x2f7/0x370
    [<ffffffff81d35882>] __alloc_skb+0x132/0x180
    [<ffffffff81d2d32b>] sock_omalloc+0x4b/0x80
    [<ffffffff81d3a8ae>] msg_zerocopy_realloc+0x9e/0x240
    [<ffffffff81fe5cb2>] virtio_transport_send_pkt_info+0x412/0x4c0
    [<ffffffff81fe6183>] virtio_transport_stream_enqueue+0x43/0x50
    [<ffffffff81fe0813>] vsock_connectible_sendmsg+0x373/0x450
    [<ffffffff81d233d5>] ____sys_sendmsg+0x365/0x3a0
    [<ffffffff81d246f4>] ___sys_sendmsg+0x84/0xd0
    [<ffffffff81d26f47>] __sys_sendmsg+0x47/0x80
    [<ffffffff820d3df3>] do_syscall_64+0x93/0x180
    [<ffffffff8220012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 35681adedd9aaec3565495158f5342b8aa76c9bc..dfd29160fe11c4675f872c1ee123d65b2da0dae6 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -836,6 +836,9 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
+	/* Flush MSG_ZEROCOPY leftovers. */
+	__skb_queue_purge(&sk->sk_error_queue);
+
 	vsock_deassign_transport(vsk);
 
 	/* When clearing these addresses, there's no need to set the family and

-- 
2.46.2


