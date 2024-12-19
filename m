Return-Path: <netdev+bounces-153300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A59F78FB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF517A2ACD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A85223C5B;
	Thu, 19 Dec 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="J0WfvCd4"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B793221D89
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601797; cv=none; b=uhdbNqf+1HIOvJN/S5O8AXnkV5KFXOGS03d+yIGo3fKYskzwBuikPf2cdWMEMZhIj3pvtvSRIyr16I9vH/z9mi0dGuAkMRI7zTajx2aLE2gBi2CfvUJbWRCWoofdYc3MqiLgPUUvU2AdKWJI+wVBA9dTXW35JjysWOhW2/byc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601797; c=relaxed/simple;
	bh=OD040imbW2yV/0U8dRlyv9pGGxmj6Y+WphcRdZmXcus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAS25pX6faDyDsWOn+B54pZVYe32NTyh2rcJ3eTe5dZCaNpkuIV/HNwNn3kg0CtPtn4mWkUcDf1SrSntY9Yx8qX/FAR1y3vcQ4GGIhhWdnh5MOxTJvJOyI3KZdQaLqhMjZmz9NI1xGkZmiIqfxsTrw9ALuWvZfNJOcYHtYz4Vyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=J0WfvCd4; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODAH-007Nps-Iv
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:49:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=DJg1AzGG5wTXwMVaemQbEGXpC8TQCp81zUdC7bdHEvQ=; b=J0WfvCd4DhVgWDuh/84/A88UgP
	YfgB5PCSmhFQnQAtrzNbEmW9lHqJm4AOcfNS8MPfbi+Ntdi3CdYKPGegovLp127CDTDudlYA2iUqv
	lFVkVM6r7kH5pKp0E41OahPjw0GdOfeWare/yGLNUhgNgBQ1bODBD5JwWXJRANzGa6qU2Dgj4MXbn
	WLPOs3sgdt1ssu/eB/m+pJkvNpjyWVHaUuKSwQYWSgKPjKDarr3sNHb8WrIejN/89GkPW9QyHcFP3
	CWecYTKlhhS6+p514b1GLB+0fR1ilmWdECzBdiI+zRDBdjgMXd1VUiTj7oKjqc24rCsg4cmo7SRNw
	epFEHY6g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODAH-0002jI-9c; Thu, 19 Dec 2024 10:49:53 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA4-00BSZD-O9; Thu, 19 Dec 2024 10:49:40 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:33 +0100
Subject: [PATCH net-next v4 6/7] vsock/test: Add test for sk_error_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-6-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Ask for MSG_ZEROCOPY completion notification, but do not recv() it.
Test attempts to create a memory leak, kmemleak should be employed.

Fixed by commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak").

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 2a8fcb062d9d207be988da5dd350e503ca20a143..2dec6290b075fb5f7be3a24a4d1372a980389c6a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1521,6 +1521,46 @@ static void test_stream_leak_acceptq_server(const struct test_opts *opts)
 	}
 }
 
+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
+static void test_stream_msgzcopy_leak_errq_client(const struct test_opts *opts)
+{
+	struct pollfd fds = { 0 };
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	enable_so_zerocopy_check(fd);
+	send_byte(fd, 1, MSG_ZEROCOPY);
+
+	fds.fd = fd;
+	fds.events = 0;
+	if (poll(&fds, 1, -1) < 0) {
+		perror("poll");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
+static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_byte(fd, 1, 0);
+	vsock_wait_remote_close(fd);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1656,6 +1696,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_leak_acceptq_client,
 		.run_server = test_stream_leak_acceptq_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_ZEROCOPY leak MSG_ERRQUEUE",
+		.run_client = test_stream_msgzcopy_leak_errq_client,
+		.run_server = test_stream_msgzcopy_leak_errq_server,
+	},
 	{},
 };
 

-- 
2.47.1


