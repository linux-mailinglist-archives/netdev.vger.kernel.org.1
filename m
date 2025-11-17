Return-Path: <netdev+bounces-239228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BFDC6629A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E1594E66BD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65C34B195;
	Mon, 17 Nov 2025 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="jWxuLSHl"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89C31E0EB;
	Mon, 17 Nov 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413074; cv=none; b=dtDs9N/rR5ZVHFMIiBq+qdS48sLgayuUZdVNMGl9h/u0ei2mmr5cRp+c4T+KDuER4KAgO274Rsmk8nnHAvrpbRu08/LyV+NeUTVgk+789rhpUXunBJaNJL+olRtw5gDwInZIo57pMndPuvDLwVE34OzPeVEq595RzemSfSzsNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413074; c=relaxed/simple;
	bh=OZQqZqNqbcCpVZmL01SXwcBNOwlCzkksnH3icssSGZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uCoeE+AM/lNG/yGKO43at+GGT31OE1SBV0ScwAHMAZbhlJTeAYQjEt7nsKxUtjgQGso7wzO3Tsd0PhbEHi6520DOqIv10mF+U0fc+2siO7EL1kAybOR3M2CqNLAdNGJ64vOM/kda8YHKy6QS+n11ARG8ZE9ANiIE65bz9EF2OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=jWxuLSHl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vL6I3-000WQk-5C; Mon, 17 Nov 2025 21:57:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=EeTHPwUBuhbkQj8C5B3LXMvFAI4nzk7Ih5zbwg3nNj4=; b=jWxuLSHlmeLe/BwBnWdSAIXAT6
	gS42/FExRrsuNN3wgxhExsjL9xymlRTP89GLoLjBEq6MnRYzpH8EniGPpHLa2Wzd+F3uEMc87WugU
	FB3hytfgws2S09bk/tbNoUd5m3n5TeF34RtT4j4yKOR+sPBBrU6eRmeseUtxrwXO5a75MIt4al7uK
	XYWwK417JnhF1WtOn3bzyyzz0VfzmSh1jiByXzF+mr+dHjL3VSZeiWitPY33/iSmuybHmfJ6ivJvD
	kgUPR6WedtuOz5Hv9nKHd52c4ABevcUzBIMALMS9TuXkq9TX6syP7HzpkIoWHYujhfjlO3quOmib1
	jo9I9AwQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vL6I2-0004QI-C5; Mon, 17 Nov 2025 21:57:34 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vL6Hz-00Bely-1n; Mon, 17 Nov 2025 21:57:31 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 17 Nov 2025 21:57:25 +0100
Subject: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
X-B4-Tracking: v=1; b=H4sIADSMG2kC/x3MQQrCMBBG4auUWTuQBgPqVcRFmfzRQZiUSSxC6
 d0NLr/Fezs1uKLRbdrJsWnTagPzaSJ5LfYEax6mGGIKlznx1qq8Wa3D/bN2ZJZqBulcrjGXJYV
 zlEyjXx1Fv//3nQydHsfxA70Th2ZwAAAA
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
Note that this patch does not tackle related problems described in
https://lore.kernel.org/netdev/70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co/
---
 net/vmw_vsock/af_vsock.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 76763247a377..a52e7dbe7878 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1528,6 +1528,23 @@ static void vsock_connect_timeout(struct work_struct *work)
 	sock_put(sk);
 }
 
+static void vsock_reset_interrupted(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
+	 * transport->connect().
+	 */
+	vsock_transport_cancel_pkt(vsk);
+
+	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
+	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
+	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
+	 */
+	sk->sk_state = TCP_CLOSE;
+	sk->sk_socket->state = SS_UNCONNECTED;
+}
+
 static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			 int addr_len, int flags)
 {
@@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
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
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
-			sock->state = SS_UNCONNECTED;
-			vsock_transport_cancel_pkt(vsk);
-			vsock_remove_connected(vsk);
+			vsock_reset_interrupted(sk);
 			goto out_wait;
-		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
+		}
+
+		if (timeout == 0) {
 			err = -ETIMEDOUT;
-			sk->sk_state = TCP_CLOSE;
-			sock->state = SS_UNCONNECTED;
-			vsock_transport_cancel_pkt(vsk);
+			vsock_reset_interrupted(sk);
 			goto out_wait;
 		}
 

---
base-commit: 5442a9da69789741bfda39f34ee7f69552bf0c56
change-id: 20250815-vsock-interrupted-connect-f92dfa5042cd

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


