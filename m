Return-Path: <netdev+bounces-143062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24B9C1005
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CE41C219F6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA6521894A;
	Thu,  7 Nov 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="GHsepUqH"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA6218927;
	Thu,  7 Nov 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012417; cv=none; b=jFE5zN+/TzshOuIztLGkr5Rn/Uwg1fHcNH7WcFLhAc/7KrOk/igJ4I2IRdul0Sb3pUFiZM5Ri9UbGpvkCEKVE2Hv8H52q2eGpa2EWdYwkZUaaFGX+i75LEdHgF9t0TJvWlLxps98MEOQHstuAX9R2RJlTXfXED72EzFquNa32Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012417; c=relaxed/simple;
	bh=C5Woc6f29HIbt3MkBVqMlI8wGQiocL1DVd3Cqii/ztU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPosSs/7p3ItKMprsLJ8DkdxsHEwKS0ObN72myt5M/H6GAlh1q2SIiAULCGxaEYoa0AW8f/BAtoLa9cdzvseZ1QSzMmA3BGy6eVZxCmwYkOucNwxvmCtdgvZJcIoPqf6ooAXk1KYmM3yLHMU0rTNWRvDMr/9Apf1EPN6z9KadY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=GHsepUqH; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t99P2-001amk-Cu; Thu, 07 Nov 2024 21:46:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=LrIIKhPNJVyF8vcxicWn1N/DeE44H0paAvo1GcrIHII=; b=GHsepUqHcue46vv1NgtHY0KlmM
	EaaCq0DlezYAfwQtciUc/RAi0gLoJRZGMDFYMaxm6Xn32V/X5I3S7ch1AG2Zkx/pF4e4PiqbrvduQ
	hE3AR2B2YzVqWJcTYnUGh9vfZWSxrQjIcymWls/hboL7YeKHqfEp3dMsD62SqqDgRh+xYydbXz9Qk
	Ua+YknN/yybYjICWrzkSFCia9hQmgy+4n+H+SVlnvpX+8Wi33QKFqdfzZv52QA/v0Sc9whjjyMKt0
	pMddRXV/+pFgN2gn13Sd5Z0uVbq+l9y1Tfmh0Doslb7CPOH+99lOlP2q5g0Kg6ejKZReT88IYH63D
	ZzwfPodQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t99P1-0002ht-UH; Thu, 07 Nov 2024 21:46:52 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t99Of-00303e-UO; Thu, 07 Nov 2024 21:46:30 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 07 Nov 2024 21:46:12 +0100
Subject: [PATCH net v2 1/3] virtio/vsock: Fix accept_queue memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-vsock-mem-leaks-v2-1-4e21bfcfc818@rbox.co>
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

As the final stages of socket destruction may be delayed, it is possible
that virtio_transport_recv_listen() will be called after the accept_queue
has been flushed, but before the SOCK_DONE flag has been set. As a result,
sockets enqueued after the flush would remain unremoved, leading to a
memory leak.

vsock_release
  __vsock_release
    lock
    virtio_transport_release
      virtio_transport_close
        schedule_delayed_work(close_work)
    sk_shutdown = SHUTDOWN_MASK
(!) flush accept_queue
    release
                                        virtio_transport_recv_pkt
                                          vsock_find_bound_socket
                                          lock
                                          if flag(SOCK_DONE) return
                                          virtio_transport_recv_listen
                                            child = vsock_create_connected
                                      (!)   vsock_enqueue_accept(child)
                                          release
close_work
  lock
  virtio_transport_do_close
    set_flag(SOCK_DONE)
    virtio_transport_remove_sock
      vsock_remove_sock
        vsock_remove_bound
  release

Introduce a sk_shutdown check to disallow vsock_enqueue_accept() during
socket destruction.

unreferenced object 0xffff888109e3f800 (size 2040):
  comm "kworker/5:2", pid 371, jiffies 4294940105
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 9e5f4e84):
    [<ffffffff81418ff1>] kmem_cache_alloc_noprof+0x2c1/0x360
    [<ffffffff81d27aa0>] sk_prot_alloc+0x30/0x120
    [<ffffffff81d2b54c>] sk_alloc+0x2c/0x4b0
    [<ffffffff81fe049a>] __vsock_create.constprop.0+0x2a/0x310
    [<ffffffff81fe6d6c>] virtio_transport_recv_pkt+0x4dc/0x9a0
    [<ffffffff81fe745d>] vsock_loopback_work+0xfd/0x140
    [<ffffffff810fc6ac>] process_one_work+0x20c/0x570
    [<ffffffff810fce3f>] worker_thread+0x1bf/0x3a0
    [<ffffffff811070dd>] kthread+0xdd/0x110
    [<ffffffff81044fdd>] ret_from_fork+0x2d/0x50
    [<ffffffff8100785a>] ret_from_fork_asm+0x1a/0x30

Fixes: 3fe356d58efa ("vsock/virtio: discard packets only when socket is really closed")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ccbd2bc0d2109aea4f19e79a0438f85893e1d89c..cd075f608d4f6f48f894543e5e9c966d3e5f22df 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1512,6 +1512,14 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return -ENOMEM;
 	}
 
+	/* __vsock_release() might have already flushed accept_queue.
+	 * Subsequent enqueues would lead to a memory leak.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		virtio_transport_reset_no_sock(t, skb);
+		return -ESHUTDOWN;
+	}
+
 	child = vsock_create_connected(sk);
 	if (!child) {
 		virtio_transport_reset_no_sock(t, skb);

-- 
2.46.2


