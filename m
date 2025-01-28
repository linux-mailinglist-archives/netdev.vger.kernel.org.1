Return-Path: <netdev+bounces-161323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B744BA20B25
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC077A2146
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BE1A7264;
	Tue, 28 Jan 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="kSyWDf7e"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39483136352
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070170; cv=none; b=jqSap/ZArFLIb26IZKf5MYNHcOVH8BMkOlXiks45Nhzjseoe2Lob4fiSz46XqX8lhv7tb9pVHiaEsDYe7TXvmHq49x0SttlI/zPcesAWHRDKBSLZMDE32lJvO9wkQnquuN5caTMf2NuTirVeBiDM7FioDLDl22fUnry1DyvV8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070170; c=relaxed/simple;
	bh=40q0NRy0TSkoa4sgKuyoaDHtfeyMbdAmXoEjr56j+ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEpD4IUftvhDuSHqQSg0syzioprwPiqbtDYo4sEYJEdGP3YzmWCB2Dx+9Cc686iTk5++6HP/ve0QFtnbHzBGdN8YhgQbV5nYycgjluV/kDjNxF6L+M5CDMySgHEtVj9DeLdAcDPAD+HI4Cm1aBWoeSLioH7YNi+egMMtz6/P+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=kSyWDf7e; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclRd-002o4B-Ar; Tue, 28 Jan 2025 14:15:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=1v4A9l47KW8qox3llJv7nIWR8IMemEpyMLrxWZePBDM=; b=kSyWDf7eCiLw5g9BIrqeFcX6rr
	r8YDZwegruSmXsOIsUo+OLjD2wyrMAHGYfeWX2C5cbBKu6JMaN2hHkLc4D6jcMj8V8UJRQGk6gEiI
	WxERYRamUdOrN5Cy1xIIDWylbd6y9uc6XI1pZlM5xPkz8iOfQSydNNZGhCe1jjv0SMYeC+vym7DjS
	2LFLOFYv8VU1uQl2nPhZ1wI3/dnSzz0pMmRYfTY+U52h/9e9DjzBnmn7L+1xjbGhI7cG2UW22n823
	hGamel/mBZs3YJWCfhiXHXqzHF/bh4eq2v8vJ9X3f8mn3PP9x54zoWB84ieNA9km8H8M/w7CQHfo7
	SNpt+SpQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclRc-0006vx-Sq; Tue, 28 Jan 2025 14:15:57 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclRL-000mZg-6H; Tue, 28 Jan 2025 14:15:39 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 28 Jan 2025 14:15:31 +0100
Subject: [PATCH net v3 5/6] vsock/test: Add test for UAF due to socket
 unbinding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-vsock-transport-vs-autobind-v3-5-1cf57065b770@rbox.co>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Fail the autobind, then trigger a transport reassign. Socket might get
unbound from unbound_sockets, which then leads to a reference count
underflow.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index daa4f3ca9b6e7267d1bb14a7d43499da3bafb108..92cfd92bbfdc2cca75dc1149bee7f354262ad2b1 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1693,6 +1693,59 @@ static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
 	close(fd);
 }
 
+#define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
+
+/* Test attempts to trigger a transport release for an unbound socket. This can
+ * lead to a reference count mishandling.
+ */
+static void test_stream_transport_uaf_client(const struct test_opts *opts)
+{
+	int sockets[MAX_PORT_RETRIES];
+	struct sockaddr_vm addr;
+	int fd, i, alen;
+
+	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
+
+	alen = sizeof(addr);
+	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
+		perror("getsockname");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < MAX_PORT_RETRIES; ++i)
+		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
+					SOCK_STREAM);
+
+	close(fd);
+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
+		perror("Unexpected connect() #1 success");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Vulnerable system may crash now. */
+	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
+		perror("Unexpected connect() #2 success");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+	while (i--)
+		close(sockets[i]);
+
+	control_writeln("DONE");
+}
+
+static void test_stream_transport_uaf_server(const struct test_opts *opts)
+{
+	control_expectln("DONE");
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1838,6 +1891,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msgzcopy_leak_zcskb_client,
 		.run_server = test_stream_msgzcopy_leak_zcskb_server,
 	},
+	{
+		.name = "SOCK_STREAM transport release use-after-free",
+		.run_client = test_stream_transport_uaf_client,
+		.run_server = test_stream_transport_uaf_server,
+	},
 	{},
 };
 

-- 
2.48.1


