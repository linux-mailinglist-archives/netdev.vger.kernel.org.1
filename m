Return-Path: <netdev+bounces-157003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B7A08A5F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0461682E1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2967209F5B;
	Fri, 10 Jan 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpVovBC0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B5209F2E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498127; cv=none; b=Z8jv0rqPWukRl2ySJ33crG0XVkQaXiP7G7MnZ9Rk9Fdt6oM23EXsZ79DQpPWvLJk/Ph0AeFytSrhxkld5P0ZGGT3nmV3xsvKrR+JWpZTJ6zi3GT5tqSwifujeLfEByZZVK+sjxZuaOK5eJZK7TIVlXIWTVZOPP4kcZTc0p7HQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498127; c=relaxed/simple;
	bh=gg9zwP3NuIW09DU6vGz9JHfMW8EBO0Kk4gY/BezPQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDwChe9ztjTbSDnZDj8UHML2vm0WsOY5G9sbz1S3USc5y6lTciOeo2WOiY2hXYxs57FD8oasKiL7ueA04Hc8Px1Iq7An7zVrM5dDlaYh/ojmmhT3KwOr2NYgKfDSRpbfzQ3+TeO28/hbj8eJUZC6JegClXnjvDAT28u3dpxh4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpVovBC0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
	b=QpVovBC0QPGMXraDGp0OAVnKsjr6XsIA8IjyB2hntwevs1kvy5pS87gf/g2QqH5DhHWhcc
	TME4WdPIf6WMzQ2zJBcchhZuctosOM4Tpz2b5NAT1Jjz7OvV2TuVl/b4FEb4fOsTHIVleO
	IuEUEKfVwOZf8pODCo2cnz65c7iOTnA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-2XjQ6wJ0OryROywvEPAzUA-1; Fri, 10 Jan 2025 03:35:23 -0500
X-MC-Unique: 2XjQ6wJ0OryROywvEPAzUA-1
X-Mimecast-MFC-AGG-ID: 2XjQ6wJ0OryROywvEPAzUA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d6ee042eso1121866f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498122; x=1737102922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
        b=LibBKD+oDsr4+kdxCKNgohgIEaVDzEbd6FeKi/2y1wiNohpQ1e55PYNOO+qkEy1z7G
         xqyY3h51Mgp+d+y6sPalY/a5IZYyUcyYl5B2GDw9cXtktAAhqEjqJIcVEW9g4ww+dPkF
         NWU/77VwKof4ZlvKwh4+yk3KzWRmMFg3xMQEzOk4EktCI02X2Nh6E3Iqq4pPt3Jzdtng
         EhP4d6dna++VDdlEgCdmurGn+b+ohxQzlxVVmPjeq9QAZPBWaJ7KF3ZciTU7je5Tm+6d
         DQ9t+0KxZnm1Xvnt7kWDzBwNHl2s4j9UOa4eKjFUsa1S0UUJ1587cOVFSx/s4PMxTIjR
         tH3w==
X-Gm-Message-State: AOJu0YwtlnxH82iMS8q6E0ot1YuA1hgZB4gmk+JoXSJN7YAQbG793NST
	96JHR+sAh9cjVFQmSZNA08Qbw6hreBk1CLvmKJChQU0S7gkWubW0btthr8udCxwIUU3vLtUrb4E
	HNlqkxFA2qLjUw/3Y3wbminEl7YR/l6GnQqNDyWlc2RewxZas4mVkqliXb25FRNUldUipi8Sqs4
	LRKA5MgMUY5LunaPyxU5wsWZ2x8fNwzStxNa0QVHi9
X-Gm-Gg: ASbGncsIzCiiDVHkWMrhVU9w5/UFdx06jf760xjZYNA1sAoEHB5XPoRetmadyd8ZnQm
	z0eddfqn+BY+06ZeMlvVokmJ2YH22DsQD8SK3QTiao9XSV4GuPeqUovza/SJAo7V+ynfEs0BWFT
	/8VqoaVQ85+K5y+XcP0N7jnpZrje1qUdjuQYN1HFu72NkV+GkcwID2io3QXlzwkiDik3Lq5UvKH
	iv58QYl5y9edgla/d9G9KsgEjB1m2SBTR2sodma/Ith7vE=
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037331f8f.24.1736498121779;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaMGGKjwRAwVyhTKqw23Ww9p2dwBHr6VnXJ4BcQwGregbXhxMe1Q9lXOo3WbQYlPlIlcZAdg==
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037271f8f.24.1736498121118;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c76esm3843166f8f.47.2025.01.10.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:20 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/5] vsock/virtio: discard packets if the transport changes
Date: Fri, 10 Jan 2025 09:35:07 +0100
Message-ID: <20250110083511.30419-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110083511.30419-1-sgarzare@redhat.com>
References: <20250110083511.30419-1-sgarzare@redhat.com>
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
Cc: stable@vger.kernel.org
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


