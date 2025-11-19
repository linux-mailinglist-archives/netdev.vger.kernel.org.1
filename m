Return-Path: <netdev+bounces-240008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D727C6F1E5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C350229345
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40BC325737;
	Wed, 19 Nov 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="xco3s39q"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959A2FB0BD;
	Wed, 19 Nov 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561069; cv=none; b=Yt8MBNeqtKmnvyk4PnavGzvB0M7OWnPwnFRgLf7VN6AILY9hF8q4xEFWTMDFOFUwhChwkLKwu8SDOAAdWfW4K/a/It+RPRCYcQjfhNh7sQCZvM1moI5DDvYCTZDPxdeSJOrbqy07mIEz9KTh6494Y57baV3JsMezY8JOY9xRzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561069; c=relaxed/simple;
	bh=/+BPYtNUG5Xu5+ISDv/HUJHRqC36BinwRESOVXe6Aa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JQTev5lZI/NlOgcS1oHVDgL5/JWPowPVwP9UMJWMp/M0kTBt02yw1sbsFy3M71bjGkfAsJd73WnUVFvITVPalhMSz8wKlNry84E3b2YWb4eDbNrXpNgzi7gVSEsynN5xRP9HZ/qDfbBE1HTZNv/qjBafizDgnZvpuYu1cwgHdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=xco3s39q; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vLinA-005mv9-3g; Wed, 19 Nov 2025 15:04:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=LL1kx54MTYNXzaYfz6YCwaEQd6cdxw7HMjZNJrr5nf0=; b=xco3s39qM71PqlAo+Xqb/nar0N
	kToWfsOyzPkN62CvWVnE4HN+owlB8sFFFl/jnYaEXKBpAY380ZU+HzbEOV7QH2lCVjtrRAIWBLOFA
	smJ2I5h4KFG1gVqHoic+8jnHw0xFQkH90+j65LrGJcY/xmRxECj1utt/T5HFgcDRxdEid8tfjmJzp
	4KragQmk8IoFCu1Z1IrkZ+KeUBL9h5mf9gU0IFvZ0YFoGS37WGDTdfHN9t9DF6ZjulXRqR17L9CaC
	10d74XSAxNMvhyvFrzsehI0kyjerH3Q7vXJo9AEQ32COCfT2bncGMs6x49yiiyR2aQqBXv5l/XWF4
	O7RNb1cg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vLin9-0000kv-3C; Wed, 19 Nov 2025 15:04:15 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLim2-00FgY3-Qx; Wed, 19 Nov 2025 15:03:06 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 19 Nov 2025 15:02:59 +0100
Subject: [PATCH net v2] vsock: Ignore signal/timeout on connect() if
 already established
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co>
X-B4-Tracking: v=1; b=H4sIABLOHWkC/32NQQrCMBBFr1Jm7UgmWmpdeQ/pop1MbBASSWKol
 N7d2AO4fP/z318hSXSS4NqsEKW45IKvoA8N8Dz6h6AzlUEr3aoLtVhS4Cc6nyXG9yuLQQ7eC2e
 0vTZ2bNVZs4G6f0Wxbtndd/CSYajh7FIO8bP/Fdqrn5qIuj/qQkg4sdIkver4ZG9xCsuRAwzbt
 n0BrRB3kMUAAAA=
X-Change-ID: 20250815-vsock-interrupted-connect-f92dfa5042cd
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

During connect(), acting on a signal/timeout by disconnecting an already
established socket leads to several issues:

1. connect() invoking vsock_transport_cancel_pkt() ->
   virtio_transport_purge_skbs() may race with sendmsg() invoking
   virtio_transport_get_credit(). This results in a permanently elevated
   `vvs->bytes_unsent`. Which, in turn, confuses the SOCK_LINGER handling.

2. connect() resetting a connected socket's state may race with socket
   being placed in a sockmap. A disconnected socket remaining in a sockmap
   breaks sockmap's assumptions. And gives rise to WARNs.

3. connect() transitioning SS_CONNECTED -> SS_UNCONNECTED allows for a
   transport change/drop after TCP_ESTABLISHED. Which poses a problem for
   any simultaneous sendmsg() or connect() and may result in a
   use-after-free/null-ptr-deref.

Do not disconnect socket on signal/timeout. Keep the logic for unconnected
sockets: they don't linger, can't be placed in a sockmap, are rejected by
sendmsg().

[1]: https://lore.kernel.org/netdev/e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co/
[2]: https://lore.kernel.org/netdev/20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co/
[3]: https://lore.kernel.org/netdev/60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co/

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Keep changes to minimum, fold in vsock_reset_interrupted() [Stefano]
- Link to v1: https://lore.kernel.org/r/20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co
---
 net/vmw_vsock/af_vsock.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 76763247a377..a9ca9c3b87b3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1661,18 +1661,40 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeout);
-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
-			sock->state = SS_UNCONNECTED;
-			vsock_transport_cancel_pkt(vsk);
-			vsock_remove_connected(vsk);
-			goto out_wait;
-		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
-			err = -ETIMEDOUT;
+		/* Connection established. Whatever happens to socket once we
+		 * release it, that's not connect()'s concern. No need to go
+		 * into signal and timeout handling. Call it a day.
+		 *
+		 * Note that allowing to "reset" an already established socket
+		 * here is racy and insecure.
+		 */
+		if (sk->sk_state == TCP_ESTABLISHED)
+			break;
+
+		/* If connection was _not_ established and a signal/timeout came
+		 * to be, we want the socket's state reset. User space may want
+		 * to retry.
+		 *
+		 * sk_state != TCP_ESTABLISHED implies that socket is not on
+		 * vsock_connected_table. We keep the binding and the transport
+		 * assigned.
+		 */
+		if (signal_pending(current) || timeout == 0) {
+			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
+
+			/* Listener might have already responded with
+			 * VIRTIO_VSOCK_OP_RESPONSE. Its handling expects our
+			 * sk_state == TCP_SYN_SENT, which hereby we break.
+			 * In such case VIRTIO_VSOCK_OP_RST will follow.
+			 */
 			sk->sk_state = TCP_CLOSE;
 			sock->state = SS_UNCONNECTED;
+
+			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
+			 * transport->connect().
+			 */
 			vsock_transport_cancel_pkt(vsk);
+
 			goto out_wait;
 		}
 

---
base-commit: 106a67494c53c56f55a2bd0757be0edb6eaa5407
change-id: 20250815-vsock-interrupted-connect-f92dfa5042cd

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


