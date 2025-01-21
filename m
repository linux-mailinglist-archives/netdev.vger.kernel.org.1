Return-Path: <netdev+bounces-160073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CBFA18049
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D527A5007
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19831F3FDA;
	Tue, 21 Jan 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TuYs/pqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D11F4730
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470698; cv=none; b=polv8G70wJwWuogJTQs1QVQ7ENVon1cBG5UiVR2KvEv1qf2kSMKnexNYq1Ojjzt3wn6zAXzXxLnlEnnmfdRVfIHds+Xduc7dfFuSx09q6jstEylHtpBcFOHsJg3nVbyf+WKqXeNatKolQTdcc/BYCenviZaqU0NQGrdI252U8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470698; c=relaxed/simple;
	bh=uW1lQgTHZr75SZty0STqUI0yyG5r3HIRD8ZLlklhD8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6wr51zh0WfDPqkLdFJylcgmEWulBeBVDWhq1eSY2EcSOZEeUBR2ait7W909rhhVvbNwiJNKV6633X+gnxOYi9isLEcAuuzNTQ2VyvdZ/2BVbWDf+c/E9I0Qlbx1Rl/sDcv+mliQzuL92j7zHtrDukcKVKn9n9fFhyPdroC6lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TuYs/pqJ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFUt-000mF6-AC; Tue, 21 Jan 2025 15:44:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HHwAc9EmXoGcar1XfefmQSS/eJdt6bpVAAIiKB+ilQQ=; b=TuYs/pqJgH6tsGUx2s6HwVIAbJ
	LTPVN84bP3aR0svcTcpZIZEKLbmi880ouVq5Fc39SBQNwxNAvpV6r5Ea/Mwd2/0xeQZwzlGAzO5WW
	uL4Si4yaa2zFwBRevIgaWwoP/XMtJOzf+mIjDrsQrsyQotXl4+aWQsCd1nqgi2gh38OHSfJIklV88
	m8Yz51LURW1iGRkIkhYSNmfUmmlOB6/+KTG9YZkOwNxgdyPc/58AVYQCsuSJukTYh+lzPEY4k3kOK
	UxI8rrF6r/VNt9cHNlCSLnnezEQBxJ+2YBOFTjxZuf5+7GmIlsoCHUTi5Yiw5W/3jSaU7lxH0Me0v
	TCP5P5xQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFUn-0005jr-Rp; Tue, 21 Jan 2025 15:44:50 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFUS-00AHot-Vo; Tue, 21 Jan 2025 15:44:29 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 21 Jan 2025 15:44:07 +0100
Subject: [PATCH net v2 6/6] vsock/test: Add test for connect() retries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-vsock-transport-vs-autobind-v2-6-aad6069a4e8c@rbox.co>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Deliberately fail a connect() attempt; expect error. Then verify that
subsequent attempt (using the same socket) can still succeed, rather than
fail outright.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 572e0fd3e5a841f846fb304a24192f63d57ec052..5cac08d909fe495aec5ddc9f3779432f9e0dc2b8 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1511,6 +1511,48 @@ static void test_stream_transport_uaf_server(const struct test_opts *opts)
 	control_expectln("DONE");
 }
 
+static void test_stream_connect_retry_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!vsock_connect_fd(fd, opts->peer_cid, opts->peer_port)) {
+		fprintf(stderr, "Unexpected connect() #1 success\n");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("LISTEN");
+	control_expectln("LISTENING");
+
+	if (vsock_connect_fd(fd, opts->peer_cid, opts->peer_port)) {
+		perror("connect() #2");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
+static void test_stream_connect_retry_server(const struct test_opts *opts)
+{
+	int fd;
+
+	control_expectln("LISTEN");
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	vsock_wait_remote_close(fd);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1646,6 +1688,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_transport_uaf_client,
 		.run_server = test_stream_transport_uaf_server,
 	},
+	{
+		.name = "SOCK_STREAM retry failed connect()",
+		.run_client = test_stream_connect_retry_client,
+		.run_server = test_stream_connect_retry_server,
+	},
 	{},
 };
 

-- 
2.48.1


