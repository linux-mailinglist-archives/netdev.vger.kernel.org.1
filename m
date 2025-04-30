Return-Path: <netdev+bounces-186994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7BDAA4690
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC201C00CE9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0242222590;
	Wed, 30 Apr 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Od62oz2g"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A222206B1;
	Wed, 30 Apr 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004293; cv=none; b=rYHTaC6USqOnGTlP//7o0Zc99HOAKeph3AOOdPAMEeQsmi4um7pOumy0UebMPEwq8zvfjzGimKC2FRonxxHR+8v0ePIULFPsKI+mx3UhHDFtI8bqQpei+wyeYSsy/ODKG28CDRFF2WYhj/JM/a9G98k8ljh10Ha/WW66CdvOk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004293; c=relaxed/simple;
	bh=bU72gZf0Mlr4a1DTEu4p6xddG7QuL34UyWY76ya9fjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7amN1DM8enpElR9Gi21r/frfzZy0Su95lY5GCrBPOb0vEWopNh5KHsvMr4W1+e/kLm6d+Gop1vrVcBRaNfCmPkiMgUi+4wqVRzU9w0ZRw9wuUvq0Rab//ZsnnfkpYdJcBMU6CGT0rlxMLwNJbDHKeoGdDa8RgNlT/LJ+51raSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Od62oz2g; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uA3TK-008kiE-Rw; Wed, 30 Apr 2025 11:11:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=qswCCZ7zdNCGMNQd6xheEFi5M2DI/AzAcjRQmm33v3U=; b=Od62oz2g3gZ2EUHjTYw5tBPwoZ
	CDxRntznQChxQcpTAJUZvMuRlnTk10YchPg4Cl8TKpSoahDFBxzQeDxX2p+hEHaXQsvf+RPBHFskK
	4NsrgRErZqA4aFhqmRSb0G6yhloq4oMNdyIgSR9Y9kel1bbhOQHju1kHxHfh4k1wuVcg5F92ue0rP
	uSthcxhEycxXcaWdgrgOSkOx34/kd83sX0IBtYQ1aZtBhgf+MHLsjibTc+Gsb/JHtTUBbRQlsO8Rr
	mAaYwtfHBm6/Yy8PYWg9Xl8wthV5KMzqhozBkd3lCA35BEBBZdvibDsrpFCeYmlCyDTpV0LKP9RCk
	f4m0FsSQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uA3TK-0006Am-Ch; Wed, 30 Apr 2025 11:11:18 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uA3TJ-00CDEV-3C; Wed, 30 Apr 2025 11:11:17 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 30 Apr 2025 11:10:30 +0200
Subject: [PATCH net-next v3 4/4] vsock/test: Expand linger test to ensure
 close() does not misbehave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-vsock-linger-v3-4-ddbe73b53457@rbox.co>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
In-Reply-To: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

There was an issue with SO_LINGER: instead of blocking until all queued
messages for the socket have been successfully sent (or the linger timeout
has been reached), close() would block until packets were handled by the
peer.

Add a check to alert on close() lingering when it should not.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..82d0bc20dfa75041f04eada1b4310be2f7c3a0c1 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1788,13 +1788,16 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
 	close(fd);
 }
 
+#define	LINGER_TIMEOUT	1	/* seconds */
+
 static void test_stream_linger_client(const struct test_opts *opts)
 {
 	struct linger optval = {
 		.l_onoff = 1,
-		.l_linger = 1
+		.l_linger = LINGER_TIMEOUT
 	};
-	int fd;
+	int bytes_unsent, fd;
+	time_t ts;
 
 	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
 	if (fd < 0) {
@@ -1807,7 +1810,28 @@ static void test_stream_linger_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	/* Byte left unread to expose any incorrect behaviour. */
+	send_byte(fd, 1, 0);
+
+	/* Reuse LINGER_TIMEOUT to wait for bytes_unsent == 0. */
+	timeout_begin(LINGER_TIMEOUT);
+	do {
+		if (ioctl(fd, SIOCOUTQ, &bytes_unsent) < 0) {
+			perror("ioctl(SIOCOUTQ)");
+			exit(EXIT_FAILURE);
+		}
+		timeout_check("ioctl(SIOCOUTQ) == 0");
+	} while (bytes_unsent != 0);
+	timeout_end();
+
+	ts = current_nsec();
 	close(fd);
+	if ((current_nsec() - ts) / NSEC_PER_SEC > 0) {
+		fprintf(stderr, "Unexpected lingering on close()\n");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("DONE");
 }
 
 static void test_stream_linger_server(const struct test_opts *opts)
@@ -1820,7 +1844,7 @@ static void test_stream_linger_server(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	vsock_wait_remote_close(fd);
+	control_expectln("DONE");
 	close(fd);
 }
 

-- 
2.49.0


