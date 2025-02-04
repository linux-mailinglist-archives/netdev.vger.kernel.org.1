Return-Path: <netdev+bounces-162316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D182DA26894
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042E318865ED
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A178C9C;
	Tue,  4 Feb 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="g6bp5K4C"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6B4879B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629049; cv=none; b=owGBcvlBQrm6nY9IEgFp69JxJT631iHvWEzfUtq5wbw7kFkni+IOdKc4Ura1AoFGM4n/D3t7bxs4J4OJeFWtbBT3rS5KFh7AqobwXqA/VumPtBNuh5nxvcdRGhdmVC1RmKPX1fxGtmeH29fLk5tAENAC478Sbc2AgZ6JcVXHAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629049; c=relaxed/simple;
	bh=KFmeFmnqbrJ7uwigw3ARkNhUE5dqs8Qdlr5i52M3O7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+hvxZdeiQS1TJ8fCFVFmqwPav5n4/oOc4rYuuBMyUDiZwLGMBhv2IK11TD17/jrJa/b0yvt6Qp4ZgdeaH02dk5d0J1DQ8hUU2Oh7s4C5uFpb4yv6Zk0CVKKigze6F/qX//wFTTDzQ6fdWkEwAvJ4woh89yZ3UNUEHDVKWcWdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=g6bp5K4C; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tf6pr-0035La-6Q; Tue, 04 Feb 2025 01:30:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HLHHwK3KlipEI/wInfgJ29VkRsH8Ic65of+MuS8I38A=; b=g6bp5K4Ceeo6yBl7WOCAQIPAwr
	WBGOnRdEKsZuDzC7iCwAe4rJ1weTdOL8Ao1/XWhY+2HbbGWpRre4JmfSQqu6gO1CAKWNidiWgj09L
	4K9Uu9mf213E9feZB+EGOLV6f6iTNeMycuDIuz5zHSC10jAdX7HWAVhsD9dxhm6WQ1/+cqhF2tLyL
	3V5QiEFVwiookDaf70QpoGGJ/YlCm8lOATdMrK9julGG82muFEQtCgSGYgJGhxUBd58JlEirSEOyb
	6ev17wZH65RgBFFeY6LHVZAPWEe/PP8fqf3lSL6cdj44+R23C0K6gLGl0Vm9UWuDcK1c3cnseIh7t
	Y2M89JQQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tf6pq-0003s3-MS; Tue, 04 Feb 2025 01:30:39 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tf6pY-006aWc-EG; Tue, 04 Feb 2025 01:30:20 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 04 Feb 2025 01:29:53 +0100
Subject: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
In-Reply-To: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Explicitly close() a TCP_ESTABLISHED (connectible) socket with SO_LINGER
enabled. May trigger a null pointer dereference.

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


