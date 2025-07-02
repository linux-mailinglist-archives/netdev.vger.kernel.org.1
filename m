Return-Path: <netdev+bounces-203364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF8AF59B6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A595215BC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CC28A407;
	Wed,  2 Jul 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="twIQfRG8"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EE289E16;
	Wed,  2 Jul 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463538; cv=none; b=U7OWV0yb7q1DnMFcSsBw7O17/V5DkiETlCUrUdKjExVXDInhSZ08Bq85uKuzNR+BDdW0itCIiYeoa0BhsMYqPbKz02CoRrm1IrtnVKdVGlpm+M1gA2Cx6C8zurIebrgAAE/QNS0Ff0RYWqlAQIoCZTY5gvfFoxkDPnZKS6ZVcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463538; c=relaxed/simple;
	bh=7oqwIalbg6zgFWyQYltaEI+okvEaE/eUEvw96Z3S2es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hv2z3NmLUxxsbFubTQSPqUAU/y1Dx5+kqc0X+RU5+cZjmtcl4uentBlcWhv4uIfPOc9WXqgEqYlFOvI3QQJfhanh0DbvoANV32MQtrCMZpYa2OTvUid4OfqKQ2k0KRHzCigVHYBah7XjbBzam8cRQ1G/YZzg1AV6buFB0ajehTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=twIQfRG8; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfr-00GxS3-2V; Wed, 02 Jul 2025 15:38:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=3kxEmPLnragLTHLWVkSfmPayQlA6UO7668ntOUDzlyE=; b=twIQfRG8s6M9NII9XrArJJgjD0
	DjrvGQxTkAbzPAWDVGTM51nyvveplh1sFFwCO/VUw4u7x8ooJtp4xPmAKLTlam/aDa9yWf/55iPmy
	jxkfMZ+hwGY8BZQmJ9lPGnvgIKs8tV6dD23QdbvKy7KzHsDJh0N5S10suj90S+CUQ2m/W2oMlOHWg
	DODZIcPZbmkhl9ATjxt3L1vcXk98MnQcSx/MvEOcDk9K4hdaIy9usWI1f7EExp5btaMsh3qrn629+
	4L1tw4gU7UqQawbaxJFdUtqvreEm5G6PFXkW0CF3f9F8DHN4D/AfN5BhjTugx6kRhtj7nIl8C/PDz
	0vpH4ZVg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfq-0006FY-NM; Wed, 02 Jul 2025 15:38:54 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfm-009LQl-Oc; Wed, 02 Jul 2025 15:38:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:44 +0200
Subject: [PATCH net v3 2/3] vsock: Fix transport_* TOCTOU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-vsock-transports-toctou-v3-2-0a7e2e692987@rbox.co>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
In-Reply-To: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 39473b9e0829f240045262aef00cbae82a425dcc..9b2af5c63f7c2ae575c160415bd77208a3980835 100644
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
+		goto err;
 	}
 
 	if (vsk->transport) {
-		if (vsk->transport == new_transport)
-			return 0;
+		if (vsk->transport == new_transport) {
+			ret = 0;
+			goto err;
+		}
 
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
@@ -508,8 +515,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	/* We increase the module refcnt to prevent the transport unloading
 	 * while there are open sockets assigned to it.
 	 */
-	if (!new_transport || !try_module_get(new_transport->module))
-		return -ENODEV;
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go await
+	 * until the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
@@ -528,6 +543,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	vsk->transport = new_transport;
 
 	return 0;
+err:
+	mutex_unlock(&vsock_register_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 

-- 
2.49.0


