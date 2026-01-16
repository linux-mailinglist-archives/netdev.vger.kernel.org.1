Return-Path: <netdev+bounces-250641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E0D38731
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 787D43178515
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5934AB16;
	Fri, 16 Jan 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2hhfY9v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcBcQ2DM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130F397AC5
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594318; cv=none; b=RhceMH2EgkOYQrAQU16a0hanCuDi3ue82pRKgkOBas+MBJLI1XgJ6OjS0PerL4VYnNVPlfbXt1S8h7n3B8fmafICBPd7vVGp/bsSccrxmC+c01RifqP+BjkSO4sgz16F2g6cKs0W0+NHImCwf5PsqCupxQJvKXski7vS3bYnGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594318; c=relaxed/simple;
	bh=SoO7meievLXiEt+HOkmT+4mC7UVVo+dr6edO43jcmvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRDckLrAT/k+h1sTGUb7QypdfhELOfj7Kw6RBxpIyRzN7ACogcPfdYZhoAMkbWmAIMFlwwrRMltDVnvFZeGsm9ktoDOCjEUN5PKG6lMGS7H5KJdrV8B+U4uuOuLFCtQvGnvqxRS5SsvuvgUQUIL0LlT7aVk8TMEbBf/VWBybOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2hhfY9v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcBcQ2DM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeRZ4N2lg6mPjyH8cqV8u8lDtZLcsrjhMu6bgHYQOx8=;
	b=A2hhfY9vu/t+dXTv72gIFow2WaTGfGiBB7S0YNEu/ozx22275HUpESvRcXtsJ0mZXPF7Op
	nCfoR2CC7uh6TaATRTC6DSTLfQQYXmTlzB+hYWgHXje7MYMHF8JmgdyhoRBIlpO+bvyqBl
	dbJ/dZ9x1rTErkOekH8heLPeuSKL7Z8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-GIIpg1epOBmzOiTJS1H71A-1; Fri, 16 Jan 2026 15:11:53 -0500
X-MC-Unique: GIIpg1epOBmzOiTJS1H71A-1
X-Mimecast-MFC-AGG-ID: GIIpg1epOBmzOiTJS1H71A_1768594313
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee7346f8bso13200985e9.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594312; x=1769199112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeRZ4N2lg6mPjyH8cqV8u8lDtZLcsrjhMu6bgHYQOx8=;
        b=BcBcQ2DMkkBXriWquMVdHccP/oXG+qN+OGvQmnaqLjEWakmGy7ml9J1IK3GlEdQEL6
         qFwbXXklnOtQOMOd4GTftfUF50+8LOsQeLlrtQnlFyvien9FJ/NzHD3lAsGzc9pXwz9R
         IMp8Pnh1JGDLICGbH7+bTWz9A21L+mb+y7MvwloONEZsBcD51z6OD6E7vf/FYHraONHn
         MpPUGP+VabxEa/Wk7N+DJAfpFa8pQ6xyJElwI1/8h78fPe9uRtImDyGQWgPxCzlNNNX0
         /60XLW0kMV0Qb1BGSobPnClqYVtRJ/eRoQAQiXYQ0G5vUCkBcEbua6FI/nIi2v7C53hZ
         aOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594312; x=1769199112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeRZ4N2lg6mPjyH8cqV8u8lDtZLcsrjhMu6bgHYQOx8=;
        b=iKR0wwchuJIHltU/sqHpsu2IPndKV3WNOAr5IXEa3BGIqzDgovIec0OIWHgbaxP3am
         ibO28cc6QAlHAbmwc2wJQpvfx51OTR5i46vwGb3WAP6vkkN1DTUbDYP85ggn18IPEAmY
         +eNDRnXJQui07q1NH3Sy9fNP8+uUTdwlUZaISsswopHPH1xX5cCcfmi8hrNhSOOa/v/y
         ca1yrUWzm6/X+RzNeoXuSmfUHtZVSZ7vaWIAsdQSlgLLTKKkzBi2ysArPQ1macJsh5bb
         xa56c7iCkNUslmpMzm6MtOkWzHi7oI/f8QkjhmPpJrg1/zSFCWM7+BcNfDozdieR7BkG
         IM6A==
X-Gm-Message-State: AOJu0Yw2CEjckyz94PMhsSF4+AqIC8AVgC4csYPyrYbLocTCtEbZSaqZ
	g1OPxIYkoYxlSTz5nxC9njoINUjltYYpzIFh2ga7yQ5C0gQT3QbyCgNPAodQhC8HzqXPrdJKPRW
	Q1w2MXr7yE9NwSOsgleNvsIcQUVdtC/ix1EMJ2qK44n8wp4hBwsXZZHkLd8YbZoH1yv1BoSwTR5
	YVy0N2X6J8rvrhjflLHxLfuXPsUxxQJReXwiuOVDLX2g==
X-Gm-Gg: AY/fxX7oNg8w9SvoWquVkOWrKOoMlm8N/v+R4P1EHSwLbc+2/ncCkl3vv3MW+nSUmLZ
	CvFHmPm9cxjeK7CIdqVRm2pULYnd3Ro/If2/hlxBGRfubcUb/KqjIheyYDt8fRxGcLNxpeMkB24
	E3UMlCVUj8o2tK63Te+Wdd93CMgEcw/7Mk0k6x0RdLD5JLHynzI5FHwqVUrRVpyVPcn35LpJHLx
	zhKwdufP9MbJESm/+tPfvW82JY8jkieIHkFmIh3ZDQo7h1OeE8+9Rt3CbnZuT7rFNIrHMehS8DE
	Fjw11JiaPF8+B8ucjQypQpb58t+JWshIqs0Afr1fEVjYtNlR7nEWFqwmjDOQYUmX/csPbPf/Brs
	VIEk4hkTQwfdsXM2IJUW5dO1YpXpK1iGsr0fgSLFPZwcvYpu9BtemVy6dx1QQ
X-Received: by 2002:a05:600c:811a:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4801ead0fd1mr42986415e9.16.1768594311858;
        Fri, 16 Jan 2026 12:11:51 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4801ead0fd1mr42986215e9.16.1768594311294;
        Fri, 16 Jan 2026 12:11:51 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9432cdsm24537275e9.0.2026.01.16.12.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:11:50 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v5 4/4] vsock/test: add stream TX credit bounds test
Date: Fri, 16 Jan 2026 21:11:23 +0100
Message-ID: <20260116201123.271102-5-sgarzare@redhat.com>
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

Add a regression test for the TX credit bounds fix. The test verifies
that a sender with a small local buffer size cannot queue excessive
data even when the peer advertises a large receive buffer.

The client:
  - Sets a small buffer size (64 KiB)
  - Connects to server (which advertises 2 MiB buffer)
  - Sends in non-blocking mode until EAGAIN
  - Verifies total queued data is bounded

This guards against the original vulnerability where a remote peer
could cause unbounded kernel memory allocation by advertising a large
buffer and reading slowly.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: use sock_buf_size to check the bytes sent + small fixes]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index ad1eea0f5ab8..6933f986ef2a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
+#define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
@@ -2230,6 +2231,101 @@ static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	size_t total = 0;
+	char buf[4096];
+	int fd;
+
+	memset(buf, 'A', sizeof(buf));
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SOCK_BUF_SIZE_SMALL;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	if (fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) | O_NONBLOCK) < 0) {
+		perror("fcntl(F_SETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SRVREADY");
+
+	for (;;) {
+		ssize_t sent = send(fd, buf, sizeof(buf), 0);
+
+		if (sent == 0) {
+			fprintf(stderr, "unexpected EOF while sending bytes\n");
+			exit(EXIT_FAILURE);
+		}
+
+		if (sent < 0) {
+			if (errno == EINTR)
+				continue;
+
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				break;
+
+			perror("send");
+			exit(EXIT_FAILURE);
+		}
+
+		total += sent;
+	}
+
+	control_writeln("CLIDONE");
+	close(fd);
+
+	/* We should not be able to send more bytes than the value set as
+	 * local buffer size.
+	 */
+	if (total > sock_buf_size) {
+		fprintf(stderr,
+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
+			total, sock_buf_size);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	control_writeln("SRVREADY");
+	control_expectln("CLIDONE");
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2414,6 +2510,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_accepted_setsockopt_client,
 		.run_server = test_stream_accepted_setsockopt_server,
 	},
+	{
+		.name = "SOCK_STREAM TX credit bounds",
+		.run_client = test_stream_tx_credit_bounds_client,
+		.run_server = test_stream_tx_credit_bounds_server,
+	},
 	{},
 };
 
-- 
2.52.0


