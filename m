Return-Path: <netdev+bounces-251828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNHMIT6hcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:49:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F354AF4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FC785E70A2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40447F2D6;
	Wed, 21 Jan 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wyhw31bZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzR05uDB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525147ECFA
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988218; cv=none; b=tCxSpvUIAp5CHi1UycbDqcn2mFXXHrbt9+yxp8mr00Pbu987F6x8zB8favcs+WlU5xWkMRjqzpzykzkLRS58U59haT2A81A27fbBfQCtWhXuwk+KGDBVJPw1Tu+USNOtX8ZWXYDuhyj4yOR1RkLoJc5hgFAzU9eCUapLP9sWa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988218; c=relaxed/simple;
	bh=iqmFsw95eeMyB4kgugRjX3QYRWWCtwCFA+YNnFmxnAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssuS6/GzfgU7Dmp0lxE7U776J73szxZvawcP8zZLsPjmyrw+YbWxjkcNbz1+Vyae7bHn3y+Ckc1BBXR4QLbDNPhgt1qJjs6TYtsFFsq9N55grWr2OFfmxwzcgxSaRg7mzBCxYHck+wA0Qe5JB1ezQrWMQmAEvxY3NjDVV66+G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wyhw31bZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzR05uDB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oY0QgHfuK6okHlFI9jmjaQHqyNLbsKWPmz3mcrgnNlQ=;
	b=Wyhw31bZ5Sql2jWfk1RyWieKFIT3D99/B+wFFFh3tptSuUzerKUAVn6j9UHLq7CPG+eDhT
	fAv6Ui4pWzi2MlznLbQ+mh11ihmRdERI9ffbkVHFLvycw9Hz2B8mYe5uAOf1Xt6d1jAieu
	qng8zp0Vf9NeYln39xoEcvWjZHe9iAY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-NnVCwqcDNJCdA6e2QA9iqg-1; Wed, 21 Jan 2026 04:36:54 -0500
X-MC-Unique: NnVCwqcDNJCdA6e2QA9iqg-1
X-Mimecast-MFC-AGG-ID: NnVCwqcDNJCdA6e2QA9iqg_1768988213
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325cc15176so4357422f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768988212; x=1769593012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY0QgHfuK6okHlFI9jmjaQHqyNLbsKWPmz3mcrgnNlQ=;
        b=FzR05uDBvIXq1WDhCXg78+pEa4s3hjNWJ2V+XKISAWwz2mczGgP/SRiSxQidAAlQgf
         urh3qqqL5BOYF1eVOOkTsmL5PoTdOWLTulsL/axJKiKO7xrthCgTUsVdYXMTiHlp7W+p
         tLDEyoiJwf3RzKru26+ezctULqO1JyGVNoeKnu+AE0BdCTmFzm3hB3qrZve9Q3qt+cIk
         08KWjMxEUav5ARG7soUu6lsfNVF9guO4NeQuzKosmRTh5IQTcXzq4g7qJCZaSDyDOvwU
         UHX6P7roIm/R7FNHg2OfZW9Lpv8DAC6G3BJb/9E8we/zDwHjl98qAmikOj146+tFzcLB
         1EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988212; x=1769593012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oY0QgHfuK6okHlFI9jmjaQHqyNLbsKWPmz3mcrgnNlQ=;
        b=lzQOaxH2QaSQPaykc8weaabkqOaRGddfyU5IrDrEKU85C84rPVQeTuX3mIC3AaO2dw
         xEL2Sra/9JIMrBwsYEpk8EFXoshEA2RqpJlxVLjWujYsT7layxMIKLiRLeaIZ+jZpFBB
         x78BoW8Y0EkWJ78zf2FWh7BLpzuHpeMtHTmU23SwHCiircXYlfdRepIAJ3ANDjyyt0yG
         Lbd8PtSSn3jtJ97+IwKn6C5y1LRZFD1Ld+7R8N0xuDoObjOVvJgHFIIUFTKSZDrAcD4D
         fIt7pWssBgioDprx3AzpXsyadSCr+lrOqiScB+oSKSUvI2xal9M8D5hmTEbUArZYWnqg
         uwVA==
X-Gm-Message-State: AOJu0YwZZ8qIJmBYh+zJPtwalCJEYOu/VKhLbA558Ebpig126LkxzRJv
	2xeDmIGrhXDEAZZAhDxBu8TafK/Oru8TvNFYrh6NFh1TOPd+DjhgNk6R+TMoSKwd0rw7i9GUBtx
	2NLJ4og31T8owAaTcqfss8+Nmjkuhi7GUikMFuzH4oZ3Qxaac7aHeE1400Y+tMUcup56y6uR/39
	vPbBJzrFmxpn4R1N0WCJ06OPIYBasjYpMCiWxUtnRcSQ==
X-Gm-Gg: AZuq6aLPiQpn/Qzo10vQqJqaqzsy+0XzbyorofO+D1dTSXbmkthbcFBiWJfdB+l/7qc
	4EpBat0XkKdGt1TS6jZtfNWF8i7xmzFDUdFogO+DRfDia7QoNfN+gEdY7+s4mg68dpeHfn9HZXH
	Lzl+LM5xqdU7CXjuWdDOHURnWn5ZcgL0M0mtjWLBwlOKFM2oV3ae1c81nmC2DWG4OeXOv5J1MgL
	G1hNNhNkLO00OGgVMs4yP74ebdOu+5mpPJgLwSBhmrAdjNQ7bYlDmG/pBZVi5PWVU3FiS0kAWdL
	atuDwLHRMWtsQYtGDaK+mExsD3Y/RlPqrkErfetlgdkDZlVDWaLaDa+Tc5v1kh/fdwsGt8gpnlv
	tK4qT2kaDjBF9a45qeQREQQnNUawmoSqATCtBsp1OGXeE4ZJfcX/JWrFzV3t8
X-Received: by 2002:a05:600c:4e05:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-480416867d8mr47222105e9.21.1768988212180;
        Wed, 21 Jan 2026 01:36:52 -0800 (PST)
X-Received: by 2002:a05:600c:4e05:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-480416867d8mr47221465e9.21.1768988211696;
        Wed, 21 Jan 2026 01:36:51 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm11893828f8f.11.2026.01.21.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:50 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v6 4/4] vsock/test: add stream TX credit bounds test
Date: Wed, 21 Jan 2026 10:36:28 +0100
Message-ID: <20260121093628.9941-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251828-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,sberdevices.ru,davemloft.net,lists.linux.dev,vger.kernel.org,linux.vnet.ibm.com,linux.alibaba.com,gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 455F354AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 668fbe9eb3cc..5bd20ccd9335 100644
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
@@ -2419,6 +2515,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msgzcopy_mangle_client,
 		.run_server = test_stream_msgzcopy_mangle_server,
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


