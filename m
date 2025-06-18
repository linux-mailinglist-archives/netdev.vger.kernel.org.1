Return-Path: <netdev+bounces-199063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573CADECC8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24151BC484D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207D2E2640;
	Wed, 18 Jun 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XvAbdhO9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE512DF3E8;
	Wed, 18 Jun 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250095; cv=none; b=fdu00lFHmAkfBCBSAiR7PxOiBzJ6///ozfV6wyo2V8+YrEKKPIoAQU0oJ3ONjl4Hsbty+n+NQa88PSj6V0jUDEJreh/ixJF9qAVi4VjKqjSMrUJ1PLgqk9iooxg/oKfzLccgfrMKjBbvkEkavlSuT7rkqPmEM+fc7SKL6WBD61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250095; c=relaxed/simple;
	bh=+xdQqkU9neaPKDSewD9n2v8JbhsqM+sf1DMZOvK233o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9wPvaRQfs5J5GoHU7tFds+ho8ESCM8o7cA+OlmGy9H5N/oTkB5EVIDxr2ockrPccO6+oLgJULNra0cmgX/nQUDkKq+gkmOco+a1J6txB3u9clbyeGd2LXpfw9M1Zz0BCpYI+fSXYoKgysYOMKTmopwHm3XAPYKS13jhwtiAOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XvAbdhO9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uRs0B-00CJi8-BH; Wed, 18 Jun 2025 14:34:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=1LkTAo+m9WKRSreDzMStbwx7+niLQSYtLsSyhAAe21M=; b=XvAbdhO9KtxJO1qpncN+sUSEsM
	rU3XMLdFUByT85WjEVJWzsRO59VfiZ2o0E5izBBBLhW3Ll6QOncuu3kwkydfPHAiAB6zDEJeCzg27
	Ubienf0YiWiBW5QjFDIcUEcyapQbnEFfYnd6qAtvGQKOnwuGLj6wwbVLKn7AC5oUxb0qQOWukETzt
	u5YM3L/DFC2UoNXwfcohWA5lGwVV6q+1xmA2iq0MB5rTeoDBwEyi4n3baWp/yXU3XlT/4cmaNtm6V
	bHF551DtBzyZaGnJJ1001WTg6DfkCnlY5hTcjPL3AUXB8hxSiV4JzUTNC9iiyr2S9QTASYWspjNOH
	GwlXgJFw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uRs0B-0004by-0H; Wed, 18 Jun 2025 14:34:51 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uRrzp-00DbRZ-RC; Wed, 18 Jun 2025 14:34:29 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Jun 2025 14:34:02 +0200
Subject: [PATCH net 3/3] vsock: Fix transport_* TOCTOU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-vsock-transports-toctou-v1-3-dd2d2ede9052@rbox.co>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
In-Reply-To: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Transport assignment may race with module unload. Protect new_transport
from becoming a stale pointer.

This also takes care of an insecure call in vsock_use_local_transport();
add a lockdep assert.

BUG: unable to handle page fault for address: fffffbfff8056000
Oops: Oops: 0000 [#1] SMP KASAN
RIP: 0010:vsock_assign_transport+0x366/0x600
Call Trace:
 vsock_connect+0x59c/0xc40
 __sys_connect+0xe8/0x100
 __x64_sys_connect+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 337540efc237c8bc482a6730948fc773c00854f1..133d7c8d2231e5c2e5e6a697de3b104fe05d8020 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
 static bool vsock_use_local_transport(unsigned int remote_cid)
 {
+	lockdep_assert_held(&vsock_register_mutex);
+
 	if (!transport_local)
 		return false;
 
@@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	remote_flags = vsk->remote_addr.svm_flags;
 
+	mutex_lock(&vsock_register_mutex);
+
 	switch (sk->sk_type) {
 	case SOCK_DGRAM:
 		new_transport = transport_dgram;
@@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 			new_transport = transport_h2g;
 		break;
 	default:
-		return -ESOCKTNOSUPPORT;
+		ret = -ESOCKTNOSUPPORT;
+		goto unlock;
 	}
 
 	if (vsk->transport) {
-		if (vsk->transport == new_transport)
-			return 0;
+		if (vsk->transport == new_transport) {
+			ret = 0;
+			goto unlock;
+		}
 
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
@@ -508,8 +515,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	/* We increase the module refcnt to prevent the transport unloading
 	 * while there are open sockets assigned to it.
 	 */
-	if (!new_transport || !try_module_get(new_transport->module))
-		return -ENODEV;
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	mutex_unlock(&vsock_register_mutex);
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
@@ -528,6 +539,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	vsk->transport = new_transport;
 
 	return 0;
+unlock:
+	mutex_unlock(&vsock_register_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 

-- 
2.49.0


