Return-Path: <netdev+bounces-157005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F8A08A79
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E427A4CA1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9420ADF3;
	Fri, 10 Jan 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5MgoYq8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC220897A
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498139; cv=none; b=aAZvfQqXEA6+HyZtTRIdxdFK+l+ou2pfwuSTFZBIHQ6RGdbdFMiLaAmMHGVuSyk1Rz4GKKC+k/5k/d1im68ZUZKPoPsMtG/kZyeSdcPeZjtvlBXy70upu9ShVc7i4RchI8AnITElm5G4edcx333hPpXdDYw6VXDihUFHbVNgrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498139; c=relaxed/simple;
	bh=QjfOQgTaUWrmSTlG/geSr55nIlTbnhvRsiGytk5OSls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul0fhP1aKD1Ov/6TWeywqSnL5G+bWozGtLPx/Sh1eJO7UGsoVpMPrIAN5yii791RWkkFRM0v7SHmifQBBezcku8hXrtfNKOZ29ZCJ8QLZiul0hy7TSr1aw/fkndQOdQxMKBRbkEO2vh9BKG5NvXanrdjgONRGmpMp5gcgyzdLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5MgoYq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
	b=J5MgoYq8llsSaZg5DlPTxJmyRn3oqNS4/skVdIZCccbo757hYIE8YcQLjFipsXR7tonn9Z
	IydwYJ3l41+3kTzuHRQkwx8NJAilGRD8iYVJJS9m+u7MeSuXrGcBHQHSYT0s9JZd+P0Kr4
	XNfG8ORhMSnQWn51sImr882AYEPkDU0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-E5VczT_6OQSt2TwKRByJrg-1; Fri, 10 Jan 2025 03:35:34 -0500
X-MC-Unique: E5VczT_6OQSt2TwKRByJrg-1
X-Mimecast-MFC-AGG-ID: E5VczT_6OQSt2TwKRByJrg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso9114835e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498133; x=1737102933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
        b=eArnc2Ot+Q319rpwNmldmIYUmuCJh+zZYZhfU4swdYkEoSbM7x2brlFqS9aFVUD2L5
         G0E4tPykYswt4pZsjXO1f7kkwV3CrA1x+fNCbOITOLDMgP6V/Bk8gRyZC8dCeqAtP/1P
         MGAUVsOIakEBIDgjU9+Y5Ji4aC7yoRILveA0UXM0dmzOgGPi2NSzLbTxu12fVWv4PJA5
         aYkqZ2hYzaQPEpgEhZ8bG+k52qDBqo2Wc4uY+T7/J7fUwYjpEbRcsTxYTAUDXsPnacAm
         P9MexxfJZl3fDQcK7vdNa7VOXzFDxTrwj7SsnISS6O88OFoGOR3Bq2AYTy6COwLHLOMf
         fdwA==
X-Gm-Message-State: AOJu0YxiC1l8KjG25AI392n5ImdoczJRNc8VmDQTP2OuAEz3YBiT2v/U
	SIhTwkuog14GHaSt3/eGpJ5Bv4S2znlGyC5SOvheSforJDyVlTl49eno3CtorfD8NiIpzi+bcDR
	APLAiOkEgQZ+d2OVW2t9g1rsQrsSpBvlojnljl/10SzomDTzNua5ymVfIndPinr098+bLWc2+nO
	n2cNJv0MksWCo3ADXhEdVPn2TgJq1Vse1gm4chlTHq
X-Gm-Gg: ASbGncvctzDnbT1DA8qfbQZHhgxK/12hKkmMxpNnjoUpEyzS7u8OSYBOc/B1+heKF9k
	tBAom/x1YDzRK5vRq9ufniO9rwxmljlNtDuWcWhfFNLKiGeujVk4YCkJ/mDcIGicB/TdcCT1i47
	vlNEslDBnfbJ2uRs4tfk5UYMKwtyr7VHp0sHBdktdR5cNmirr6RpcgwvBqPTdJyNjXEbaZz+9O4
	GwPcPFfq35VB2JaFZ5bx2HgUdRPIcHIwlcsQ1PbDsnwJms=
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464170f8f.32.1736498133340;
        Fri, 10 Jan 2025 00:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkY+6wyisWu9I5OnlNIAEaCc1RkfYRMe4WOOPOqI9L+4Q6XFHZJA9lRe1HqGdOwc7Z+AC+ww==
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464107f8f.32.1736498132691;
        Fri, 10 Jan 2025 00:35:32 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm73101805e9.0.2025.01.10.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:31 -0800 (PST)
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
Subject: [PATCH net v2 3/5] vsock/virtio: cancel close work in the destructor
Date: Fri, 10 Jan 2025 09:35:09 +0100
Message-ID: <20250110083511.30419-4-sgarzare@redhat.com>
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

During virtio_transport_release() we can schedule a delayed work to
perform the closing of the socket before destruction.

The destructor is called either when the socket is really destroyed
(reference counter to zero), or it can also be called when we are
de-assigning the transport.

In the former case, we are sure the delayed work has completed, because
it holds a reference until it completes, so the destructor will
definitely be called after the delayed work is finished.
But in the latter case, the destructor is called by AF_VSOCK core, just
after the release(), so there may still be delayed work scheduled.

Refactor the code, moving the code to delete the close work already in
the do_close() to a new function. Invoke it during destruction to make
sure we don't leave any pending work.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 51a494b69be8..7f7de6d88096 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,9 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
+	virtio_transport_cancel_close_work(vsk, true);
+
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 	}
 }
 
-static void virtio_transport_do_close(struct vsock_sock *vsk,
-				      bool cancel_timeout)
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout)
 {
 	struct sock *sk = sk_vsock(vsk);
 
-	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
-	if (vsock_stream_has_data(vsk) <= 0)
-		sk->sk_state = TCP_CLOSING;
-	sk->sk_state_change(sk);
-
 	if (vsk->close_work_scheduled &&
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	}
 }
 
+static void virtio_transport_do_close(struct vsock_sock *vsk,
+				      bool cancel_timeout)
+{
+	struct sock *sk = sk_vsock(vsk);
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	if (vsock_stream_has_data(vsk) <= 0)
+		sk->sk_state = TCP_CLOSING;
+	sk->sk_state_change(sk);
+
+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
+}
+
 static void virtio_transport_close_timeout(struct work_struct *work)
 {
 	struct vsock_sock *vsk =
-- 
2.47.1


