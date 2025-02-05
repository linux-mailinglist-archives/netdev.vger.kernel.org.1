Return-Path: <netdev+bounces-163285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88322A29D28
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD31886589
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645021B918;
	Wed,  5 Feb 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="d48ZKKpl"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E1215F42
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796836; cv=none; b=YTTSal5s6HuaC2Ubm/kDKFCOBPd5bnWEFkB8zEVqp4J9UAOkSu92nhcOKhmViI3ar54d3CHvRPga2YV4tB7W3wblMxHirY0BO+sRf9qSxLItRAPn5q5wF5nvFLooLS4WhlimtTJfV4+JhrIZp4CszP6/T3IGCFf1T+k+ctjycUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796836; c=relaxed/simple;
	bh=oiQL0rGNDZ46rJCsYVvAQMrGpmw5q5aq+uZvd7k0acE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=im7rjP9JZo2m+M0q1jTedf6NtPd6o1AbTzjpuBLYsgPPv47BhTqagqy3St+JHeg4WZxap8RJelSDUgXR2db0fSkbUf9iRfOIZvOFQRtk1TpgUPT5j/NMByMhi+ZkKNqXt5f6pDs6WsMA7HAjwdoIeEvACSZT+7MWFDAhdfCM1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=d48ZKKpl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tfoU8-008fAz-V9; Thu, 06 Feb 2025 00:07:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=UOUxlpZcOVasweLp4wnSsb70UvGKPP18Kr2dC+XZKoc=; b=d48ZKKplNHHIwIOA8NqDrepnOL
	00/f2Z0UxkaUQoOn116xQNHU6+KDrHUiLpSCEPQ6Fi/7nZaGuTxNcUtaO2Mm/Jg43HcAZP6TX5w7F
	FRDajqf8+RTJcHAHYJ93xV+WxzU1GiYZG7nkA1LB6Jppqy5sYTnI2sYE53vtO4ajunqBv5awERijH
	98wHPeLlEdeKqXQqWE3P1gyrqd9ET4r5FTUP/whv+LksDIvcNxsKWyzCk0pEan7Bim6TDaJoCImFz
	mbhJsq7CsEYF+f2Qmav5gP3GAg2PkRJMxNiBq9J+TtlCTUQg6d9sheLWMGqrp8RYp6fafIoITT4/E
	fVd+AV5Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tfoU8-0006G5-IZ; Thu, 06 Feb 2025 00:07:08 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tfoU6-009hRv-5s; Thu, 06 Feb 2025 00:07:06 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 06 Feb 2025 00:06:48 +0100
Subject: [PATCH net v2 2/2] vsock/test: Add test for SO_LINGER null ptr
 deref
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-vsock-linger-nullderef-v2-2-f8a1f19146f8@rbox.co>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
In-Reply-To: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Explicitly close() a TCP_ESTABLISHED (connectible) socket with SO_LINGER
enabled.

As for now, test does not verify if close() actually lingers.
On an unpatched machine, may trigger a null pointer dereference.

Tested-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index dfff8b288265f96b602cb1bfa0e6dce02f114222..d0f6d253ac72d08a957cb81a3c38fcc72bec5a53 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1788,6 +1788,42 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_linger_client(const struct test_opts *opts)
+{
+	struct linger optval = {
+		.l_onoff = 1,
+		.l_linger = 1
+	};
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
+		perror("setsockopt(SO_LINGER)");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
+static void test_stream_linger_server(const struct test_opts *opts)
+{
+	int fd;
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
@@ -1943,6 +1979,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_connect_retry_client,
 		.run_server = test_stream_connect_retry_server,
 	},
+	{
+		.name = "SOCK_STREAM SO_LINGER null-ptr-deref",
+		.run_client = test_stream_linger_client,
+		.run_server = test_stream_linger_server,
+	},
 	{},
 };
 

-- 
2.48.1


