Return-Path: <netdev+bounces-178118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0DA74C36
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5349C16A6C1
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4A1B4223;
	Fri, 28 Mar 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIYbxoZL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE85149DF0
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171344; cv=none; b=gFkRYfRCQG8Lux4cAgHd0K8lqfr/7KGO9p+7tqdh8HuZpeOMvUTvQW5H9AHfx0I+nbxnjqsAHJ6cdrnykpgAkd3uSD2btIwcZjYfZoy3bSpy9Zm2SSd32uZR8Ik6o6PuzhSSGrDSSAYWP2RrBMFHtcrjBl7lfQCifgiGFGuQ9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171344; c=relaxed/simple;
	bh=FRgwR9NVLePyoA/jx/Us5P4QY3HAIJ4YkA7LAoces9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWYdYfK0JO+1NVXnlk8paYGPHxAi5xhEWU9clytniLAW/pzHnIB70BMI79dCNQrOvKWwVIIiJ/xycXFYME0BENyT4M0Th4M2x/04SRv9sTfbNK1qSHVesmv7EjpQ9p4qRvu+whkX+OuN/DjtafM2GdAT0LGkxKJGQ9QaAlwz0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIYbxoZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743171342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xooqL8JNylDfTCuXDGiM3ZS3m3cKnxP7jiQvva2sy6M=;
	b=GIYbxoZL/kvcKGeuups8dQByi3yklsQOHBHrLzM8xFeH0gwKFxVVSPqIGAMHr38qC/zqYX
	EInH0B5CiWVDp8Z8dVDZGzHwnd7gw8yfaBr+6iwcOvclgGW9D5qrguewRdPVTOKjkWWpbX
	1CKpv4OmYf/847XziZGhURju4LpgLTA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-UW6vAt86PcSoXESdHjDvJw-1; Fri, 28 Mar 2025 10:15:40 -0400
X-MC-Unique: UW6vAt86PcSoXESdHjDvJw-1
X-Mimecast-MFC-AGG-ID: UW6vAt86PcSoXESdHjDvJw_1743171340
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac6ebab17d8so68386866b.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743171339; x=1743776139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xooqL8JNylDfTCuXDGiM3ZS3m3cKnxP7jiQvva2sy6M=;
        b=Calu3QnlJvJ9A4taztc/8qvDd6rwyceDYVn4njfse6WqUxE8icbPdkL05hpYJTN0Vp
         eVoeumPikRbAxBmDg1KdhStYc09Jueky9MGrMeIqPeBhrmas/iAU4OViZINb8VdjTxEW
         LQWiz6idGU4aAMYHNWpLblVpy2ETbij+eMwA40N9y2D1HLouAGZKPRFnqD46WjubzM2X
         Ic2yT2V6P24LiUyZtycXsY+WteVxGCkCvm92iUsOJtoZgJ6hXIyRPP2FMjAQrTvmubzA
         jTroySXL8wveyHBHjBhtg/KKjsd87/QHSmLZxrJGuGtrILEUoxC+9pU4KBce13VIOZwL
         Hm6Q==
X-Gm-Message-State: AOJu0YzQer858NNg4Tya+WqKAq6QX2AE3PIx75CrEOapOGj17beb361f
	QlghUxbl6acFOjNtddvU9311zU4U5Kxmiffeawc40PltKQ63Ke7Hat6rP25jayRI83an75BoYXc
	VF4wV+Nk+W3aU9lxVaOvJ1N7Kc9fa8qf7LNhHOAflZnjG/b4Fwl4yiVe+BvJR4v9MdDz2D6ksUz
	r3os+Aks9EE115LOis1VhCv1ynvuZE2OoydmpZAMET
X-Gm-Gg: ASbGncuwc2A4pYtuvZk/b17Aq3ud3/Xa7kJJ3v3sP7FUDNkKuQGOOGp/shpBBhxufJ8
	642+24Sod4ob3RgKKd385byW7GvhI1GPMpxN4m53aY8xxSZq9YtvlYqg24xqn94Gp+tjWD1Rpb/
	PbLEV+sn3Xd+TK2ZFP6KgxwXP6tRVoD/z/sBXHtwEV47einkQaZZS6RKYzm0A7/jSbbz6Qaqn7J
	0/Kn6IqTTCgylf/fGNwFzhn2ULPh4+cZlERIx9VGf0knvZRgoJLk/hXrR7WC4sDYZKpbJEFOXLU
	K0tHGJVkcLUXEBcrMZG/A6MFZzdki1uTetA0UVHpgjOIcr+GCaq1ouG3DTkSrChlGEmYWzMo
X-Received: by 2002:a17:907:6091:b0:abf:750b:93b8 with SMTP id a640c23a62f3a-ac6faeb60camr729517666b.22.1743171338976;
        Fri, 28 Mar 2025 07:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF1MvdaI0gZUTJ8fsf5IgoIHUlwoojKm+uMy9J1qv93tB206JFCOV8hdYvaYSnFXxyhmZ7Zg==
X-Received: by 2002:a17:907:6091:b0:abf:750b:93b8 with SMTP id a640c23a62f3a-ac6faeb60camr729508066b.22.1743171338172;
        Fri, 28 Mar 2025 07:15:38 -0700 (PDT)
Received: from localhost.localdomain (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f8fbsm166142266b.107.2025.03.28.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:15:37 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Luczaj <mhal@rbox.co>,
	Paolo Abeni <pabeni@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andy King <acking@vmware.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Torokhov <dtor@vmware.com>,
	Simon Horman <horms@kernel.org>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net] vsock: avoid timeout during connect() if the socket is closing
Date: Fri, 28 Mar 2025 15:15:28 +0100
Message-ID: <20250328141528.420719-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When a peer attempts to establish a connection, vsock_connect() contains
a loop that waits for the state to be TCP_ESTABLISHED. However, the
other peer can be fast enough to accept the connection and close it
immediately, thus moving the state to TCP_CLOSING.

When this happens, the peer in the vsock_connect() is properly woken up,
but since the state is not TCP_ESTABLISHED, it goes back to sleep
until the timeout expires, returning -ETIMEDOUT.

If the socket state is TCP_CLOSING, waiting for the timeout is pointless.
vsock_connect() can return immediately without errors or delay since the
connection actually happened. The socket will be in a closing state,
but this is not an issue, and subsequent calls will fail as expected.

We discovered this issue while developing a test that accepts and
immediately closes connections to stress the transport switch between
two connect() calls, where the first one was interrupted by a signal
(see Closes link).

Reported-by: Luigi Leonardi <leonardi@redhat.com>
Closes: https://lore.kernel.org/virtualization/bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn/
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7e3db87ae433..fc6afbc8d680 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1551,7 +1551,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 	timeout = vsk->connect_timeout;
 	prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
-	while (sk->sk_state != TCP_ESTABLISHED && sk->sk_err == 0) {
+	/* If the socket is already closing or it is in an error state, there
+	 * is no point in waiting.
+	 */
+	while (sk->sk_state != TCP_ESTABLISHED &&
+	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
 		if (flags & O_NONBLOCK) {
 			/* If we're not going to block, we schedule a timeout
 			 * function to generate a timeout on the connection
-- 
2.49.0


