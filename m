Return-Path: <netdev+bounces-162314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52781A26892
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270CF1883C4D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF016EB7C;
	Tue,  4 Feb 2025 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fbPObwOA"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAB35967
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629047; cv=none; b=t4JTJ4rXKcVIxV+nXo+LcoHMCg9PeEI22bXzp9UUVl2Gdg4Hbj3uod2ma/E2dqqm9KB6tQdG0VozzvQZnvIsQiO0dFwt0tA0frwooXDy3LOWyTieGxHFcou2iY2YLkAJqcugFQ967Krs29yeWUU+LAPAogMf7knCeVNgz7DwpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629047; c=relaxed/simple;
	bh=a23O4pr4xHgL7lf78s0SidMq4UAVSB4Ut3dRSrV86fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOMxpWTBUFUyTeJh+R6j2eyKon0BLgLCC6zhUY07BoMqRqVAEBQSt0iOD6pR9yPI1tmk/xEloKIUJ2QYanQUO5zdQ76c8I2gUJUeRlQQfOnO9cWC5/WvVWJ4A/LYu4lWf0pUaCoYVHXcIvZFPWXLBe6nL9UyCkvpGl4hxSmeqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fbPObwOA; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tf6pp-0035LM-PF; Tue, 04 Feb 2025 01:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=pwAHNqSfYtODufEUZzYvZd2TMQYo1ch2LMFopgwTdnc=; b=fbPObwOAuQDwOzie418PomwO7x
	PElL9Hhi8RFIYjXbTA0ruvoGBE3iZMFoPMDMinl/Ka3mxkVj3KilguH0YDhRv4CHQZtuuk1fEPbYR
	GXlEkgn5PXZNEDiQ+toQuRX+SP3JobOqFTLndp/bGAdR0IP/5UZeV4ts7xl76SffSVGXgbsQbsbZX
	Wt6We88jTEBOycdIF6Ib0peG2WutY9BeTyskIPubVzsU4UBaeF15GL5/1arMgkHaywln69NDImiEM
	21NFGsxNPIkwOy8VrxNVRhBpRhy02V0DAz+pIrGEGzX//KGlhTFunLdg50vcRsBZ1JvpeMbNoh54i
	3L5scc+g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tf6pp-0003rD-BK; Tue, 04 Feb 2025 01:30:37 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tf6pY-006aWc-0m; Tue, 04 Feb 2025 01:30:20 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 04 Feb 2025 01:29:52 +0100
Subject: [PATCH net 1/2] vsock: Orphan socket after transport release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
In-Reply-To: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2

During socket release, sock_orphan() is called without considering that it
sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
null pointer dereferenced in virtio_transport_wait_close().

Orphan the socket only after transport release.

Partially reverts the 'Fixes:' commit.

KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 lock_acquire+0x19e/0x500
 _raw_spin_lock_irqsave+0x47/0x70
 add_wait_queue+0x46/0x230
 virtio_transport_release+0x4e7/0x7f0
 __vsock_release+0xfd/0x490
 vsock_release+0x90/0x120
 __sock_release+0xa3/0x250
 sock_close+0x14/0x20
 __fput+0x35e/0xa90
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 075695173648d3a4ecbd04e908130efdbb393b41..06250bb9afe2f253e96130b73554aae9151aaac1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -824,13 +824,14 @@ static void __vsock_release(struct sock *sk, int level)
 	 */
 	lock_sock_nested(sk, level);
 
-	sock_orphan(sk);
+	sock_set_flag(sk, SOCK_DEAD);
 
 	if (vsk->transport)
 		vsk->transport->release(vsk);
 	else if (sock_type_connectible(sk->sk_type))
 		vsock_remove_sock(vsk);
 
+	sock_orphan(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(&sk->sk_receive_queue);

-- 
2.48.1


