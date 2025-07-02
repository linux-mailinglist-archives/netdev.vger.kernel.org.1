Return-Path: <netdev+bounces-203365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39557AF59BC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BD94A233A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF428AB0B;
	Wed,  2 Jul 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TqPekNS9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E028A1F4
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463540; cv=none; b=WCcVEdKwQJ0wXokWIkz0qFV3Qh2/9S2CivydB0nTxsbYCbQRRsrIeb0hkpMXOw3anWGlM6ctj6I2+9R7OgMG4/lDvBzOXcgutAfYLD0LeU7TGllBozTQiF9zY5sOlP2NR6kyuZQTI1se7K4ECcnXPANTDoUuGfFsz3I3mQeexak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463540; c=relaxed/simple;
	bh=xJyaNJQ7LbzJGPjFyc9HUYGLS31iY7vm48JnwuM2+hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sn81UZ+E44yiP+u/me7QCPTh65LV/O/O6AWC1pAv22hCWcbEwzK/v7moESk+7s4KfkOSF5hOGShxJK1Z/R9vwkyqNP/QnLGgxDglRkHmJVIodDdNdRSYt/RHN2YVr0f1C85OV3Oy+ZDwI3VwpC71ze4cnAjZvvn3DU0kXhVUQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TqPekNS9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfs-00GcMn-Cw; Wed, 02 Jul 2025 15:38:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=QANjNkCZa2tpxhq6eTHKRMBXrJr14UZJplu1Q4IRXac=; b=TqPekNS99PHx54hoQEU9loZqjp
	I/9vGeflCOEd86fcAvOThawzMsvnuMzT8nG7NWkB68wh9BaY8JV6vrGYUL15kdQGghnmVMIXIBWQ3
	7m4zYyzpdBYQfIYyLv66Rysr1KQ4bLWuuzH9ALKXf09/fUKnmBGg3ZHnjZez2078Vxz+zx04EmPcd
	+xus3xE9/yFHYzBNZD2IAhKflHXOoCAe7KgdTapqcuGC1cjnkjgo5BiVvZx9xAy8k5bRBVYDdvL1J
	yJ2n9pfbyGwC8AL+qth5DEOKhM/WeRIpxJGssUdmj8/mnzXfVDRqn0Ki8lvdYaz0/oHZoC07vpNXl
	4Ggg6qpA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfr-0005Hm-TU; Wed, 02 Jul 2025 15:38:56 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfm-009LQl-68; Wed, 02 Jul 2025 15:38:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:43 +0200
Subject: [PATCH net v3 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-vsock-transports-toctou-v3-1-0a7e2e692987@rbox.co>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
In-Reply-To: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
transport_{g2h,h2g} may become NULL after the NULL check.

Introduce vsock_transport_local_cid() to protect from a potential
null-ptr-deref.

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_find_cid+0x47/0x90
Call Trace:
 __vsock_bind+0x4b2/0x720
 vsock_bind+0x90/0xe0
 __sys_bind+0x14d/0x1e0
 __x64_sys_bind+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
Call Trace:
 __x64_sys_ioctl+0x12d/0x190
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965db30b6ee295370d866e6d8b1c341..39473b9e0829f240045262aef00cbae82a425dcc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -531,9 +531,25 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+/*
+ * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
+ * Otherwise we may race with module removal. Do not use on `vsk->transport`.
+ */
+static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
+{
+	u32 cid = VMADDR_CID_ANY;
+
+	mutex_lock(&vsock_register_mutex);
+	if (*transport)
+		cid = (*transport)->get_local_cid();
+	mutex_unlock(&vsock_register_mutex);
+
+	return cid;
+}
+
 bool vsock_find_cid(unsigned int cid)
 {
-	if (transport_g2h && cid == transport_g2h->get_local_cid())
+	if (cid == vsock_registered_transport_cid(&transport_g2h))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -2536,18 +2552,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
-	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
+	u32 cid;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
-		if (transport_g2h)
-			cid = transport_g2h->get_local_cid();
-		else if (transport_h2g)
-			cid = transport_h2g->get_local_cid();
+		cid = vsock_registered_transport_cid(&transport_g2h);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_h2g);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;

-- 
2.49.0


