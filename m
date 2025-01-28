Return-Path: <netdev+bounces-161324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07952A20B23
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561D1164DC3
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145E1A83E2;
	Tue, 28 Jan 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Eg8Tud4x"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CF19AD48;
	Tue, 28 Jan 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070171; cv=none; b=OAEScBaPgIt5TFrFdqnJkEjFU17oBwPb0NSexDuRH7eOhlvOfYC7oY4iHIxxRuWY6a5I+kAkDiWnqfg31ibOUcRMKD5SEF8MsIgVFSOhN99ZU61wyAHJ/o0sLsCC5arod5zM+f7O+5P+59Wd3eWLdOoNR+ewKTrRXwyTEQemyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070171; c=relaxed/simple;
	bh=3z2PnVno2WMWCgJRiXopFRiwcTXT2eT8/Ec6OK1EgZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUfzWnElDyGXrKNU/8JQNbckRgFROeWD8YoyDjNSkQ//Hhb4be4Ex2hzyVuQzs6eevnuevN25AT18rTv/ae+nWBjee4QNPH+gAg9hTSVt0xtEwrdQBgOuKlnaofTtemO0DJnu2bjE5k36LlSgq45hKYQt1mVTvsSVdMa/2+yGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Eg8Tud4x; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclRc-002o44-P5; Tue, 28 Jan 2025 14:15:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ulOBA5zraqg9Cx36pRszEPMHhmD1X6DYSEnF8qJ9Bd0=; b=Eg8Tud4xNCCFCWx+BhJ4hMPdwt
	OUYrCcapQp5WCG+Cne1tLsZXZ1QSzRqsZmnsEtZ3u1vD3PJNN3CXvBewkvw9jw/HzSIzScmC6zWFX
	X0aMrtu+PdYCG/fNB2kfYTW7Bi9PNwMyvQ9XqiF2f/IdCxpbo+wfhTL51TbABBoAWqOQHHBB94YKi
	e4IujHrNx0BE8V0tlOzTOcRbiFbGybFHg+imGcc46muVZT8pYkU25dHWyWonitVgAs8CZpa1JZNPh
	Z/urF8kCDSx18wUWAaL3KxFOldOqRqp41LcMKMbf+AUIxE7VnF6j1wfFIIMbIhN8OBG8Sz0LYLQZS
	DQoMpCEw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclRb-0007KA-Kb; Tue, 28 Jan 2025 14:15:55 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclRL-000mZg-M2; Tue, 28 Jan 2025 14:15:39 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 28 Jan 2025 14:15:32 +0100
Subject: [PATCH net v3 6/6] vsock/test: Add test for connect() retries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-vsock-transport-vs-autobind-v3-6-1cf57065b770@rbox.co>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 Michal Luczaj <mhal@rbox.co>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Deliberately fail a connect() attempt; expect error. Then verify that
subsequent attempt (using the same socket) can still succeed, rather than
fail outright.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 92cfd92bbfdc2cca75dc1149bee7f354262ad2b1..dfff8b288265f96b602cb1bfa0e6dce02f114222 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1746,6 +1746,48 @@ static void test_stream_transport_uaf_server(const struct test_opts *opts)
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
@@ -1896,6 +1938,11 @@ static struct test_case test_cases[] = {
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


