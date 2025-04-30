Return-Path: <netdev+bounces-186995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C6AA4696
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4192E1C00E8A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70F2236EE;
	Wed, 30 Apr 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Uk8aiSiB"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886EB221F1D
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004294; cv=none; b=PLWPXKxP2LDgVMM3jAhxg6di3k+SeA3QtqR1qnJo+oGBnMGKw73lQGcuxVpcFFqwdoI2umxUhIMy2bdKmdqixEVpYwe4n3aEMJmXOCP5xswmQWXwuHHJLq93MYMO0Ta4cmXDScwWE+JdxzBng7pkiNV2g85SifjQkmAhcvfYA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004294; c=relaxed/simple;
	bh=h2owf59eEgI833PcMlqHoA2GqBM6oQTPhXWSLBaut3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDR24PYZTzqlUaC+LENcIZytsIo1tPk0aw2dIMcYYFHipeQzv7LzeIrrEnfJRKh7OdTrjOSIbYxQSQNIrnWwjO1IU1WEGwX8lX5UM1FvIY4quNP5oSJhL4o5g045I+cywOiKn07UeHLJsPPlXfJhFB3UxNuh91Q12KEgHFTpfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Uk8aiSiB; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uA3TK-006EEO-7T; Wed, 30 Apr 2025 11:11:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=DW7ucJ6dWqPm7JmubDw+SOLAZx/FUUKm5KizEO3YhQI=; b=Uk8aiSiBm+f3k9AQ4xtNgCv4Mx
	ApF/yvsofovWSB0LCwrJA4agLjugAVEAktvaxtiJg6EfiVstKmDGNJPGq1s8kdJaR8Wl4ih3dPcEo
	vOciNguLZrw/iak09HUNDIA85MUVXSgxZ4l+JenIPeky3B2lUR5Oq5a2nDBlsaRtQ+30JVyHgmqIh
	uISmJl0W1KDmTBxNDrCAjfYG5J1779JuHxF2dPU2m75sx2IAAG6aX0QRvRaP+EwhmNZxf5LbYSBGM
	JakA+JbzGslwA4sUWHOGfcD10ggV6IEy33OtHBDgXtAsqnimoe/x0yrvC/nEfGJ/4SHSOyr7NV31A
	hlVSkHYQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uA3TJ-00050f-5s; Wed, 30 Apr 2025 11:11:17 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uA3TG-00CDEV-Of; Wed, 30 Apr 2025 11:11:14 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 30 Apr 2025 11:10:27 +0200
Subject: [PATCH net-next v3 1/4] vsock/virtio: Linger on unsent data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-vsock-linger-v3-1-ddbe73b53457@rbox.co>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
In-Reply-To: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Currently vsock's lingering effectively boils down to waiting (or timing
out) until packets are consumed or dropped by the peer; be it by receiving
the data, closing or shutting down the connection.

To align with the semantics described in the SO_LINGER section of man
socket(7) and to mimic AF_INET's behaviour more closely, change the logic
of a lingering close(): instead of waiting for all data to be handled,
block until data is considered sent from the vsock's transport point of
view. That is until worker picks the packets for processing and decrements
virtio_vsock_sock::bytes_unsent down to 0.

Note that (some interpretation of) lingering was always limited to
transports that called virtio_transport_wait_close() on transport release.
This does not change, i.e. under Hyper-V and VMCI no lingering would be
observed.

The implementation does not adhere strictly to man page's interpretation of
SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d8809655fe522749fbbc9025df71f071bd..49c6617b467195ba385cc3db86caa4321b422d7a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1196,12 +1196,16 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 {
 	if (timeout) {
 		DEFINE_WAIT_FUNC(wait, woken_wake_function);
+		ssize_t (*unsent)(struct vsock_sock *vsk);
+		struct vsock_sock *vsk = vsock_sk(sk);
+
+		unsent = vsk->transport->unsent_bytes;
 
 		add_wait_queue(sk_sleep(sk), &wait);
 
 		do {
-			if (sk_wait_event(sk, &timeout,
-					  sock_flag(sk, SOCK_DONE), &wait))
+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0,
+					  &wait))
 				break;
 		} while (!signal_pending(current) && timeout);
 

-- 
2.49.0


