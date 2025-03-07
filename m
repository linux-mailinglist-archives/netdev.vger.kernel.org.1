Return-Path: <netdev+bounces-172860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1224A56534
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3C21898DC7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1520E006;
	Fri,  7 Mar 2025 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KsoaRTbC"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF820DD71
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343296; cv=none; b=pS02f1EZ1vueHNTrNAkgl5cr5UD3GcXHzrJG6/JZskRV+idedCQWr77+G/MJ13QgMaHx31uqzPw+ZmT7lJwY1XAtAj06vk5091YpZ85WrMl7BtcshAyMpnhEnLUTOOZ5C9I8SsdMvfsR8SEHjimx0RHxGqg3CbUKFAGh/GvXrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343296; c=relaxed/simple;
	bh=jrQxx963u0UIh0LMWTyR85DyjzQHKWDA6KlOFHvOOg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LzlSS7f9n6e3HzeFuTVSfDU8KecLe2QvZtVaQQSRNEIPOkVI6Xmsmn3jo6Jr9EMo11JtNUswSSCZtdeiYjDeLgI9IlHpl2g8F5Q02N5KC5rK03sZktdwaAfFGzdV77TGib2PTxVRu7HYbhUKhzBEsP2NoNvUkvhQ3J61POw1O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KsoaRTbC; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqTzx-0031mN-Jd; Fri, 07 Mar 2025 10:28:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=7ur2YaFrKmvtBuyp9fEmTVu7+f1jUmCVVpaxPwcaTXY=; b=KsoaRTbCTxrSkkLRLeI5VAYAMf
	aLXznNbisLgYo+D+hZlu7iXGi8y/SYM0Z+sSW6ROWi2UdoG1xPGfmzzRA0eeUw8YW5x0aCgrm39pY
	9pt6KTWhNoa2+e4r0BT4o946/VjyWcFlCbStfLi7wwTDj1fx9ZxnsU3CzRNtwnN7c3JbFSihH+mWe
	e2hgbgDN4Jrozcool9HtDT4NOpCJMNe4nL0KOSJd9WHH7Nr5xu9aDp3yt4phNxPH4bQsuYd0egkld
	86YPgycwJBM6FXW8fnkckUOJLjj1toRXpa4l8TNpHO4mzh31d7HWB+QGVJp/vJg7lNG1AmxLjvVaQ
	IY36IjPA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqTzw-000212-Pq; Fri, 07 Mar 2025 10:28:04 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqTzs-00636i-Hb; Fri, 07 Mar 2025 10:28:00 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 07 Mar 2025 10:27:50 +0100
Subject: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
X-B4-Tracking: v=1; b=H4sIABW8ymcC/x3MwQqDMAyA4VeRnBeoFafuVYaH0qZdmMSRiAjiu
 1t2/A7/f4KRMhm8mhOUdjZepaJ9NBA/QQohp2rwzveucz3utsYvbhrE0LhIWFBDJExPn4ehHZO
 bJqj1Tynz8T+/QWiD+bpuojxgE24AAAA=
X-Change-ID: 20250305-vsock-trans-signal-race-d62f7718d099
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Signal delivered during connect() may result in a disconnect of an already
TCP_ESTABLISHED socket. Problem is that such established socket might have
been placed in a sockmap before the connection was closed. We end up with a
SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
reassign (unconnected) vsock's transport to NULL, breaks the sockmap
contract. As manifested by WARN_ON_ONCE.

Ensure the socket does not stay in sockmap.

WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
 sock_recvmsg+0x1b2/0x220
 __sys_recvfrom+0x190/0x270
 __x64_sys_recvfrom+0xdc/0x1b0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c  | 10 +++++++++-
 net/vmw_vsock/vsock_bpf.c |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7742a9ae0131310bba197830a241541b2cde6123..e5a6d1d413634f414370595c02bcd77664780d8e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1581,7 +1581,15 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				/* Might have raced with a sockmap update. */
+				if (sk->sk_prot->unhash)
+					sk->sk_prot->unhash(sk);
+
+				sk->sk_state = TCP_CLOSING;
+			} else {
+				sk->sk_state = TCP_CLOSE;
+			}
 			sock->state = SS_UNCONNECTED;
 			vsock_transport_cancel_pkt(vsk);
 			vsock_remove_connected(vsk);
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 07b96d56f3a577af71021b1b8132743554996c4f..c68fdaf09046b68254dac3ea70ffbe73dfa45cef 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -127,6 +127,7 @@ static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *bas
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+	prot->unhash = sock_map_unhash;
 	prot->recvmsg = vsock_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
 }

---
base-commit: b1455a45afcf789f98032ec93c16fea0facdec93
change-id: 20250305-vsock-trans-signal-race-d62f7718d099

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


