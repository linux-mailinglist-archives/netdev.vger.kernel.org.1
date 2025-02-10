Return-Path: <netdev+bounces-164710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83196A2ECAE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C925163592
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C31EF082;
	Mon, 10 Feb 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Q4CVAClm"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AB22068D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191181; cv=none; b=hmkliZDCkWmqIgmJKw1w3wtLcdHQRsMqbRJE/1XTQbGe5aBYpm/iSucuUL/1V/Arg1B7zlloVVTlQvwNWzf6qQa83C2QraGwn5TA9aYV9yTac/Lmj9TjqarMojmgAe8U316QjJZVaB4rXKRKHwfkBRPDK7AIqJ974oIaBWiEvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191181; c=relaxed/simple;
	bh=jkugRWJoUQUlKrU43pCxmnqut5A206wldvnTWxyMGJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7e68sQ/Ofv+Nyr1z4uhh80bm6kQUUc7Mk6gqMT7xynYnvmwl7E4VmPX/EBNtWkVmlnmuz+hY4ZY8pBXh/9F2dZU1egiJAG0AmgW1vj/gZ6CzZ8TIVTZ23F4dIt45UTaOM4t2OwKE7nB1AyPSanbV4tN5L+iRtCgJe139Ge68Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Q4CVAClm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1thSh2-00BOci-M1; Mon, 10 Feb 2025 13:15:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=s0XEXyzf1IhZ34ddP3l/xQwx44nn6AeJ5GmAr2ID/ag=; b=Q4CVAClmiQNPKMA2U2Nfj6FeOh
	VgHzCA2ay6PDpbzroOgwWROmlFA1rWoAr7u8RJI0zwj9rCwtgztbEs+uPLSZRgwqk98CBnFlBiAeX
	A44+O0vwfq2tV4gWdhZEYZz5WX1SMbNV2phvDtwLgyahAHGq+hV0CWnSZA6Efv2rlqgOk4JpaRsRi
	riYCPNeSuWEseOekCbYAGaVGfaLReAe3u03mHOxDeay2kRzzHEWd5anquGyZ6jM56S2J7T4A6HkCY
	ccQkjnq3CGOxCab6JDu3aLV5iPAjtn9Ocn9J6rEQRcmGvySd0G6dZZk0xoqDDsNWW4bhIVLp41ZGb
	QiG3px+Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1thSh1-00088d-W9; Mon, 10 Feb 2025 13:15:16 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1thSgy-007tu3-1p; Mon, 10 Feb 2025 13:15:12 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 10 Feb 2025 13:15:01 +0100
Subject: [PATCH net v3 2/2] vsock/test: Add test for SO_LINGER null ptr
 deref
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-vsock-linger-nullderef-v3-2-ef6244d02b54@rbox.co>
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
In-Reply-To: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
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
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


