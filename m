Return-Path: <netdev+bounces-159467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2FCA15944
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D25A188CA56
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E881D63EF;
	Fri, 17 Jan 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ibN3mGLE"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36761A8F6B
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151223; cv=none; b=P0yuAbkSVMUSoBed5OEzSAn0sXu/7St/Li3XsDCoFOxC14S+sa27ikOG2aZuCvTtoZAkESFGzaz+C051cPozL5WL8JZKINk4llwEmKv75kMcfWogLiql04mpyXoK0s+jSp/mW0NQ8gK3RR5iP1SHFVJj4SJbwcvZDJmrrTzjU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151223; c=relaxed/simple;
	bh=iYXOKKoNJ2ZpiCsPbfVW3ZowZOFiBz65Iw1ufi0FlTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCttxcLa+bO0j36KMuM+t8m1DPrqlbUnfy5rNDRZSftPNBrYD+sCGRM+uoOwBy2g74ml9VQ7S1G/VRyydxGklw3U6x38bOkxV1Hj1sYDaXSS/n6OoohxhUmwPK/oTXNPPukN2Qt3PrVEOXpj+WSh3seOyyBVX5JPW40P8ZzgH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ibN3mGLE; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNv-008tk4-LG; Fri, 17 Jan 2025 23:00:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=i8m1XZf2XF0dobPMD6WYcXlh8Va/xHFuLFjk21IgfbU=; b=ibN3mGLEK60AUHgO6f/uC6y1hl
	EL7Yuj8PcFe16N8YvlGEYnhNOZrTUsxiN5Yrn/HGmesa4t4SMEy9wuLO+jhPKFwjKZUs7qdrJ8pV7
	H8j4z/29XjGv7U6NpqWM5ao/Jj8SizsY2csWMy/Hd7rwUXKxlrkuJJEJPvEaKwfSV8H041HOd6hTP
	Zp/czc03cnOFbDxJ38vbMywYnAHQFDJbOWuGiQ/koWPW1rT6a5eunUbqLPDTYfrnBC7XzgAQwXBaq
	GRmA5su7/6BItMNE67YByJyHc5yipm0idRGmZfouuQk5Uq8VH7C+BipI0+q/7QqwJmpgB/auYNyNb
	1qeb/tEg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNv-0004t8-38; Fri, 17 Jan 2025 23:00:11 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tYuNl-006md8-JS; Fri, 17 Jan 2025 23:00:01 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 17 Jan 2025 22:59:44 +0100
Subject: [PATCH net 4/5] vsock/test: Add test for UAF due to socket
 unbinding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-vsock-transport-vs-autobind-v1-4-c802c803762d@rbox.co>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Fail the autobind, then trigger a transport reassign. Socket might get
unbound from unbound_sockets, which then leads to a reference count
underflow.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 28a5083bbfd600cf84a1a85cec2f272ce6912dd3..7f1916e23858b5ba407c34742a05b7bd6cfdcc10 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1458,6 +1458,68 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
 	test_stream_credit_update_test(opts, false);
 }
 
+#define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
+#define VMADDR_CID_NONEXISTING	42
+
+/* Test attempts to trigger a transport release for an unbound socket. This can
+ * lead to a reference count mishandling.
+ */
+static void test_seqpacket_transport_uaf_client(const struct test_opts *opts)
+{
+	int sockets[MAX_PORT_RETRIES];
+	struct sockaddr_vm addr;
+	int s, i, alen;
+
+	s = vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_SEQPACKET);
+
+	alen = sizeof(addr);
+	if (getsockname(s, (struct sockaddr *)&addr, &alen)) {
+		perror("getsockname");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < MAX_PORT_RETRIES; ++i)
+		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
+					SOCK_SEQPACKET);
+
+	close(s);
+	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
+	if (s < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!connect(s, (struct sockaddr *)&addr, alen)) {
+		fprintf(stderr, "Unexpected connect() #1 success\n");
+		exit(EXIT_FAILURE);
+	}
+	/* connect() #1 failed: transport set, sk in unbound list. */
+
+	addr.svm_cid = VMADDR_CID_NONEXISTING;
+	if (!connect(s, (struct sockaddr *)&addr, alen)) {
+		fprintf(stderr, "Unexpected connect() #2 success\n");
+		exit(EXIT_FAILURE);
+	}
+	/* connect() #2 failed: transport unset, sk ref dropped? */
+
+	addr.svm_cid = VMADDR_CID_LOCAL;
+	addr.svm_port = VMADDR_PORT_ANY;
+
+	/* Vulnerable system may crash now. */
+	bind(s, (struct sockaddr *)&addr, alen);
+
+	close(s);
+	while (i--)
+		close(sockets[i]);
+
+	control_writeln("DONE");
+}
+
+static void test_seqpacket_transport_uaf_server(const struct test_opts *opts)
+{
+	control_expectln("DONE");
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1588,6 +1650,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unsent_bytes_client,
 		.run_server = test_seqpacket_unsent_bytes_server,
 	},
+	{
+		.name = "connectible transport release use-after-free",
+		.run_client = test_seqpacket_transport_uaf_client,
+		.run_server = test_seqpacket_transport_uaf_server,
+	},
 	{},
 };
 

-- 
2.47.1


