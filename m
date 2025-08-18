Return-Path: <netdev+bounces-214715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE281B2AFF2
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91167AF615
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732EE32BF26;
	Mon, 18 Aug 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvAnLqoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8932BF22;
	Mon, 18 Aug 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540251; cv=none; b=UObtBHwvZ3t2KY8j7H4DACvanexGinVGluLWoN6WWMtMzJN+/XRyIP4qifnZkuOyOX1f4IshdrA+qOghV6BAP8DTEsu6bFPzpQvN1Y8i5+atfF4w6ChmaFW8LwNq905yeujTNmCsphYzT4NiMKq0Ec2A3quO2MPpnGGdac3dZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540251; c=relaxed/simple;
	bh=/AOGjfiZYjmG5cI+NtFHNOOC86oa3AeQx6qXCDPv+Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vfodvg72Nkf81eAytF/KIVkZO28JIvbpwrZq+Q0N2nv5yxTbxmBGfN6DrnxdlMXEGNenpl//+vKNMf4dBMPIWsptaPGeM37Sjy490PxR8l0pUBSFZyuX9VUvyrkqcOw7tNuJGBmfABRZLYJqbowObcp8wRiZDXE8KUSrhritktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvAnLqoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A189C4CEEB;
	Mon, 18 Aug 2025 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540251;
	bh=/AOGjfiZYjmG5cI+NtFHNOOC86oa3AeQx6qXCDPv+Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvAnLqoLBaZIyR9jPqZgLJekypsulnNJk/W3ktJ4lo7UlZlVJ9Dc6/zvuurcyE8eA
	 T60VBmqaXU2jDgeFb9IKOpX2Wku+6l9VKdERle2ZsmA6S93paD3sb3y4fHxwuwT672
	 r70loXcRqS65X3U5UDw3ddhoifR9w/t4RFN8vLEz265jTLB1xZnKjsuRvNNcWGAGcO
	 fhaxcrCzI9i2QH18zjVcfQzmSI+xHhGJ4Qxf4G6Yu/BcU3ncTg4GtqDQ9+BfT7MTSk
	 1q+BFSIK0CFzTI3WUBtKbJ697Megw590c/e2fM0Q7/AnC0WxZRY304RSoDbGJsQF1l
	 2HYia467SZg0Q==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Subject: [PATCH 2/2] vsock/virtio: Fix message iterator handling on transmit path
Date: Mon, 18 Aug 2025 19:03:55 +0100
Message-Id: <20250818180355.29275-3-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818180355.29275-1-will@kernel.org>
References: <20250818180355.29275-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs for handling
large transmit buffers") converted the virtio vsock transmit path to
utilise nonlinear SKBs when handling large buffers. As part of this
change, virtio_transport_fill_skb() was updated to call
skb_copy_datagram_from_iter() instead of memcpy_from_msg() as the latter
expects a single destination buffer and cannot handle nonlinear SKBs
correctly.

Unfortunately, during this conversion, I overlooked the error case when
the copying function returns -EFAULT due to a fault on the input buffer
in userspace. In this case, memcpy_from_msg() reverts the iterator to
its initial state thanks to copy_from_iter_full() whereas
skb_copy_datagram_from_iter() leaves the iterator partially advanced.
This results in a WARN_ONCE() from the vsock code, which expects the
iterator to stay in sync with the number of bytes transmitted so that
virtio_transport_send_pkt_info() can return -EFAULT when it is called
again:

  ------------[ cut here ]------------
  'send_pkt()' returns 0, but 65536 expected
  WARNING: CPU: 0 PID: 5503 at net/vmw_vsock/virtio_transport_common.c:428 virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
  Modules linked in:
  CPU: 0 UID: 0 PID: 5503 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-12063-g37816488247d #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014

Call virtio_transport_fill_skb_full() to restore the previous iterator
behaviour.

Cc: Hillf Danton <hdanton@sina.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fe92e5fa95b4..dcc8a1d5851e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -105,12 +105,14 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     size_t len,
 				     bool zcopy)
 {
+	struct msghdr *msg = info->msg;
+
 	if (zcopy)
-		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
-					       &info->msg->msg_iter, len, NULL);
+		return __zerocopy_sg_from_iter(msg, NULL, skb,
+					       &msg->msg_iter, len, NULL);
 
 	virtio_vsock_skb_put(skb, len);
-	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
+	return skb_copy_datagram_from_iter_full(skb, 0, &msg->msg_iter, len);
 }
 
 static void virtio_transport_init_hdr(struct sk_buff *skb,
-- 
2.51.0.rc1.167.g924127e9c0-goog


