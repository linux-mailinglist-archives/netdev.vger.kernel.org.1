Return-Path: <netdev+bounces-250638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380DD38726
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A693064371
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E725399A45;
	Fri, 16 Jan 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs/sAs0y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsvgaclt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F334CFA8
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594301; cv=none; b=oBcKayQzOJsZsYNAynhzEjuKtKTESIgbAtLy9HKP2l4vBP2/TecWLYZldT9uixDBJirytK04gbvYyDKqMpWG3gNUEk8wumR5VQSqvCju1mO39wvFddf9SUfYLrIYX3Ivyu5UX+QSc7qqgD6ULPS0JqHrwcnELTCAExj2RH3kJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594301; c=relaxed/simple;
	bh=A/Z6X724OpOjH0JR1tZITqCXaxlg20lb95ngLUoUj2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAAsIdwnXALzvP8A8v31y2V81qY/LI3jQRITa6VBD5TyYW0vFyzx4nMJoEivk4p+fABPq5Ilohh4Pi8BwpECCSi74pv/SVAzBTqvB5ApE8xX6GsBSV9c+Kn9N95Ii01UA2MlmX4rwsFJC5VfQ8CDFHMcPDRjQBxCuIIjzYCBEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hs/sAs0y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsvgaclt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
	b=hs/sAs0y8qCf4tOdaf+Xe94BTueUYVxl/YO2jwBeKVg09xv9SzKV9qcv7MFkUm7N2jZbL0
	TcYYdtWWQ2KRpU0CoAWszu7vkvciHWt/Z4WJjWRP0OX4dx/D8/RgEOL0NzxSFtZLV5bWHi
	5VUlb6dAjgYMN9jHHYcZWj1Ht+0MwTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Hj9xJwtDMtuL6pxaN-Ui_Q-1; Fri, 16 Jan 2026 15:11:38 -0500
X-MC-Unique: Hj9xJwtDMtuL6pxaN-Ui_Q-1
X-Mimecast-MFC-AGG-ID: Hj9xJwtDMtuL6pxaN-Ui_Q_1768594297
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801d21c280so14327825e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594296; x=1769199096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
        b=fsvgacltM3bh/fw63AIwoAAocTNnH7UGUh9SfiOOdUUrOJokXe9dL+A/QQnIloxaet
         MiOkPRLrcVCTFkyR++zWYC/SUb4qZnYeVHvESVu5Y62aWpKkc8sO69odLg98k7wzyUPe
         6a1a3zwVcxF4L+vYB7UIlU7uRT0QF2h7Old54/YG/wP3jCtyJZ3IjGbk382+I5bFS+Jn
         U4c8SnqYUoBPu5U8S2M9RC7xwaUynUDsu8V0RX3lZ1Y425xuFizH5cqMkVQNIotm59GJ
         Is/oRO4Tn4wo730gQAFrWGKHYs+UfsmkxkLU6mSuXTdEdiqsO79V0Tr4zaybDm8vLvzF
         uH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594296; x=1769199096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
        b=FoePeUt+tMehrFkajUgQRi6aa4AMb/WZbOmbu9YnhXgHdqZgp8OC34zmCLhRNinOAw
         DkIkdIoaEzZHwqtR2k4z7soVC8WRigYIOGXLf4amf3NT5XDQKtsHk3FF5GAGaWktvbYk
         hKt0JoiSzeAwvc0haQm8PXVWYKUUsmfytfFlMjK5l2DjePUO3uC9RHPsN8NPqH5C6s+O
         95Dol5V4gRI/47+zxh/i0s/ZCk4lmsNOkXpY+ceDph7BQLWw4rR1qFtquzXugEwhhJ/A
         mOS8crziIEDv8f3v9lFZiaHJvMPAQbb8kT+AHWcLhDd94Pu0VGlfzMtWf+MfJNv0kzxx
         vzCg==
X-Gm-Message-State: AOJu0Yy6p4oerzohXnvD4mda4IF9PrR/PgX6g77gK8WePou0aBFcAIfc
	gWv+gwDFnYqmZ5i6l5lf2sLehmmv8JMwYXU31y91v7dh0hFkVqER+qVw95VHe9laTqFL7u4eydd
	nT2hU43EMqYaNAy1xT5CjfaSS/nl/5lK0aLK/gRLW97YD92tmwGDKldcyOjyEA/elybNrFm5leY
	J1IGm2LJlhrLv8hTC7UKqy4snt7uTrGY1/x9vj3o/XEQ==
X-Gm-Gg: AY/fxX7/Z6UqDaopkXG19UT3IhpsbeUe3xvRddKZ6tUCcmwksuy867v3e4XufHEw8Aw
	uRPpYLsVIlgpdDlMxh95SinV6FJbUwZMVgzPelaW/7usanxMf+IH1BGq4o4iQ5Qq4DXuu9GoRin
	XwyZo2gVNAkB93oWpfun3aSTGnJq8fLbZCeMLsAEnPZDY1UeCQ6DOpQkggEMO2kGMdXIXp5JmLB
	TJnCNrTkM/aG/69JK7XgLTMquKXqYFg2T0OtDahvTADI8jw0y0YmvbxH4VTImac2IwhcPXJpvqi
	NNmerUW8/LCde0VKoUiN3BJseGqMMwAD2gPIWJcqdZ8a2C2a/bWSf0gp6GZwONxbDIPxqo1/cIp
	pFewp10fxP3upGc8TFmbqsGO3I0JKaMi9vUzL4U1WoEB7DqMFY3T4OYbB9Fpr
X-Received: by 2002:a05:600c:8b67:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-4801e342091mr43240895e9.23.1768594296035;
        Fri, 16 Jan 2026 12:11:36 -0800 (PST)
X-Received: by 2002:a05:600c:8b67:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-4801e342091mr43240655e9.23.1768594295483;
        Fri, 16 Jan 2026 12:11:35 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886834sm60231185e9.7.2026.01.16.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:11:34 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v5 1/4] vsock/virtio: fix potential underflow in virtio_transport_get_credit()
Date: Fri, 16 Jan 2026 21:11:20 +0100
Message-ID: <20260116201123.271102-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201123.271102-1-sgarzare@redhat.com>
References: <20260116201123.271102-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Melbin K Mathew <mlbnkm1@gmail.com>

The credit calculation in virtio_transport_get_credit() uses unsigned
arithmetic:

  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
are in flight, the subtraction can underflow and produce a large
positive value, potentially allowing more data to be queued than the
peer can handle.

Reuse virtio_transport_has_space() which already handles this case and
add a comment to make it clear why we are doing that.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: use virtio_transport_has_space() instead of duplicating the code]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..2fe341be6ce2 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -28,6 +28,7 @@
 
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
 
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
@@ -499,9 +500,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
-	if (ret > credit)
-		ret = credit;
+	ret = min_t(u32, credit, virtio_transport_has_space(vvs));
 	vvs->tx_cnt += ret;
 	vvs->bytes_unsent += ret;
 	spin_unlock_bh(&vvs->tx_lock);
@@ -877,11 +876,14 @@ u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
 
-static s64 virtio_transport_has_space(struct vsock_sock *vsk)
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 {
-	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
+	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
+	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
+	 * does not underflow.
+	 */
 	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
@@ -895,7 +897,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
 	s64 bytes;
 
 	spin_lock_bh(&vvs->tx_lock);
-	bytes = virtio_transport_has_space(vsk);
+	bytes = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 
 	return bytes;
@@ -1490,7 +1492,7 @@ static bool virtio_transport_space_update(struct sock *sk,
 	spin_lock_bh(&vvs->tx_lock);
 	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
 	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
-	space_available = virtio_transport_has_space(vsk);
+	space_available = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 	return space_available;
 }
-- 
2.52.0


