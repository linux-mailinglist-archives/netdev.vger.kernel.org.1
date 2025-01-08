Return-Path: <netdev+bounces-156385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15EA063FA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331291887B7E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DAA202C47;
	Wed,  8 Jan 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYqH7pF5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40637202C2B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359594; cv=none; b=FYdgdgjh+qHIYLt+BErrXW8JZzZHqJMvkmnAJRqK3Gi9WSG25rugNcpXnbidWVkAQGEUcGR4bM5scBFM/lISKRmzUzjHCYkE58y9e70uZCfl4icYA9hxwrw7LQCRNTJU5C4SQ7m1TQF7cVxRdujXx5pQXkjc6431RsgFMaYgHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359594; c=relaxed/simple;
	bh=XhT2B/XMcI2q+vQQF0C3xrDtTRflQwJMsW4aCd7eL48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdX4N/VsxqAcEWmCm2qnQpKJOPg++ZI+IrwTPVz9pPrId4dK7M/YOvLI4lYk0ZJ6f2VNb/mYt5rBXNvlDZU8iOjy1KNwKhMwoG4xgw0SjWHCl7bVfbQE1erLn0v7rgP2kRaE2gAQbff9e7hSxuUD5EEfIEBK4h6tmnXAGY73OyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYqH7pF5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P81z0YmLvdT8m64Ix0hrS5vpO81KiskzyN+gGNFCQNI=;
	b=hYqH7pF54knbIgedPB//go0vfJ9GKlesedUU6u0KhURifXEWd5wlK28umesbU+IaHmriJD
	wNQ+QxjP1R3hffq+Xr+B6w/M3498g2a8LdxSG8vOrMM09wJWC0j3EesMES+6yrLgIhvzjM
	AmCLjrUb9Q0L88qkdcrMiscC9aHYj10=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-dlZnBRaiPUuGA757knlDhQ-1; Wed, 08 Jan 2025 13:06:30 -0500
X-MC-Unique: dlZnBRaiPUuGA757knlDhQ-1
X-Mimecast-MFC-AGG-ID: dlZnBRaiPUuGA757knlDhQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a891d2aa5so43892f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 10:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359588; x=1736964388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P81z0YmLvdT8m64Ix0hrS5vpO81KiskzyN+gGNFCQNI=;
        b=WTrGV/2THcBSTneQpQUP0NlBFey/io9zDWmquAZjGoBgPkzzjQxTnbJS/hGGDJDqnO
         xh6h6wYInyC4pX6a61MBa764hHL6aTsxRRUZwsJ2hGkfMdX08cTV9C/lq12HiuWDVh3a
         vvu3YqLsYzbnqspJqFcX316P0TUn/ARm+Z7iwjpf9M8XyBMfZ+yTfGFA/fXDG+qehllG
         V+/cpgYeGhmtRi5wJsmd9jInjso2k04FL1y5uwMOLc64aFH0ehHFFQcaC6b6l63j1xOn
         qpG00fR/CLZ6rN9X4y/iu6xhBYy9mMKWeb75n7LwfxpoYlwCPsjM9AukoWAAMO1Z9sFT
         BqZQ==
X-Gm-Message-State: AOJu0YxRAFp9hDxlt0l9qB+nG46dBcsyFoUHKLEAAoBjnI0KRCmniha7
	PtBnrE1SJRNHOY1RHamyuh7oGl19HexGHzVb3jGvJZ4GtEH4ZXUWKZEC6Npn9xP/nGzJZSzMeD5
	RllN3Z10dFVOQDxRui9Hjp0zVVcysGkQ3XzUicyvQpUQiUW9LYfoUHt5wBfh/DBIURDZNMcsoLb
	6DfNkCaHa70Gzp1BFH+xvxM7byifiFvazXafuHqD/8
X-Gm-Gg: ASbGncsvfy/kLOf+MMqOUsYX1DyCUkHmDPKfNnxYBrULWqI7zxX5oarjP6mtuLjUnKl
	QQ31Qlcfd8sxwPd/xGWIQV6CjqY5Lfk8LLOwruIAh4jQBITK8gD8u0J6WevW4hFjQAJ3Td5qjDw
	PuCpUJh1IdURmkOWfSXXGsX54LVMyiOdMoA5xlvCk58x7YkfGCTWerKze0PjZxM1kR/lhTFEBim
	KKL9NB9QTf0MoqeqnTluXls0Kp9rSwuztHa5qSWU0X8P9c=
X-Received: by 2002:a5d:64af:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-38a8b0fa39dmr213715f8f.28.1736359586639;
        Wed, 08 Jan 2025 10:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyImssYlGKFMwIIkelKFtn5EBvRpRzebX/KbLVJOoRVPg+AYW6dhCm61RcqZ/eZtr4R9nAwQ==
X-Received: by 2002:a5d:64af:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-38a8b0fa39dmr213656f8f.28.1736359585987;
        Wed, 08 Jan 2025 10:06:25 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8292f4sm54344839f8f.3.2025.01.08.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:25 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org
Subject: [PATCH net 1/2] vsock/virtio: discard packets if the transport changes
Date: Wed,  8 Jan 2025 19:06:16 +0100
Message-ID: <20250108180617.154053-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108180617.154053-1-sgarzare@redhat.com>
References: <20250108180617.154053-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Reported-by: Wongi Lee <qwerty@theori.io>
Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..51a494b69be8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.47.1


