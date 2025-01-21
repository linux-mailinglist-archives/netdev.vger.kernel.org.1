Return-Path: <netdev+bounces-160072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2243A18048
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609BB3ABB8B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C41F4295;
	Tue, 21 Jan 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BbT0fp8h"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B01F3FF4
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470696; cv=none; b=VJEu4mbTG0qlWjfh9+W8p8/FPLSPZeh0l4gEV8El/2BMFrM/fhEaV+o8rwKEjrOrQgKkzUXBFHCGWo0cYfYW0VT42FQwTG14AyBnD8cIG2GxI09WG15hIPR7XziBXM3GYopgKPW3ycE9+JX+XCSQWHViNRgtfRvdD5WmqwgT1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470696; c=relaxed/simple;
	bh=TZCLWQzVkNs6E9f6kP5vaY9QG9zRW2VrMJCAHoRHp/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYB/r9MECxICS9tegt34lRJdse77RBegATqaX9LsRV2zF83v7dePks/WfDdy1lxNNdx7tQmoN5eHwOAPrmIuXefzyr9nBcMu6BPsxz5fdmzlgjvrCt3bn2TnUio7yBF4lMY8qeLzAJboyIEsc1ywCpSDC0HV5M1W9J6xQ91KMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BbT0fp8h; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFUq-000mEV-2Q; Tue, 21 Jan 2025 15:44:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ldYInreJ0LkUXcXkdY7gO4eqNazyOLax6WM5tdMRfi4=; b=BbT0fp8hsV1BlpB0rKASgfUoKb
	nuSSwOr4qj4/8EsPXdCQsQNq0AuNmUE26OP8CjYaIqeCRr1LKbVWaG/KHTko9XEpdTrs2fnTFFsAA
	pX5ngykc/zUjTZL2zGtHVVqYHw3UuitdkY8wst59+kSVahhQ2WJ4vx3wZeqtzSkdW7iSvXqvszMl9
	jgtdNW4QCa4iGTpvehZXV03xia7A2H6qQi5h0B/xPz5JVsHYDMaTJue/zjD6Hxf3N07h3DjO4fnKl
	QfNFTaD3NsbL+zLCvPf1kw3jlj+N47kyZL5uVc5DSIATtFLLtFR20nfyk3cGwhkke60Qn/d7JKozL
	bJR5So3w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFUp-0007PH-Nm; Tue, 21 Jan 2025 15:44:51 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFUS-00AHot-FE; Tue, 21 Jan 2025 15:44:28 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 21 Jan 2025 15:44:06 +0100
Subject: [PATCH net v2 5/6] vsock/test: Add test for UAF due to socket
 unbinding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-vsock-transport-vs-autobind-v2-5-aad6069a4e8c@rbox.co>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
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
 tools/testing/vsock/vsock_test.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 28a5083bbfd600cf84a1a85cec2f272ce6912dd3..572e0fd3e5a841f846fb304a24192f63d57ec052 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1458,6 +1458,59 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
 	test_stream_credit_update_test(opts, false);
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
@@ -1588,6 +1641,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unsent_bytes_client,
 		.run_server = test_seqpacket_unsent_bytes_server,
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


