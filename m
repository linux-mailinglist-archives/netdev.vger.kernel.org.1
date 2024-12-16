Return-Path: <netdev+bounces-152176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D49F3000
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9120B1622F9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE1204C16;
	Mon, 16 Dec 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ReqnNvkH"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB6204587
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350488; cv=none; b=r1hxkuW10auxx6McewFCs9dB6VlxjkLxXqSJeknGpWrvSg3T9LkpxV9UEJB5gpf5oFLObUzU0VF409u5UIgK9glLAc6eWOkJ4vLUZSczHCarPwsCMqUUG9k79ujtP7G9nNH7f66E7s9iQTkjuyqGLqODRn+BJe1uh7Eu1GGjc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350488; c=relaxed/simple;
	bh=n3RsoAPnmyplCXfQfW1WlF3Ru8GvNgAdBJf7ibY/2TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4iTZ0NTWVQVC6zBPdmPmsgNPNLGaLg/Id4NRADEbwHFVTJXt0dC3HFwO4WsL5O2OJzfBTxlgx/mq6oyRGZKTHLLlJVw87YhJ2QdsuCmZk2Lh7rYszgWxwU5ECwYxkIV9J1Qs9cYGd7N+Vel5a2HNlN6MXGMZmXDkCIJLQaCjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ReqnNvkH; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mq-00Flk8-TU
	for netdev@vger.kernel.org; Mon, 16 Dec 2024 13:01:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=gJGXaPFHctiVMj0P7oolhApDrayAs5sV29Kv6O+qyNY=; b=ReqnNvkHT6SRzJ8ZcEoEMdR8Hb
	wYyeMhcNtEUpKaA9oNXknN2IhgAaeQs5/xtfkbnXgR3vpyf4E50qWX4w69OSzsku2gsgd6L5njIoW
	jrHS4fIAvMM58F3rDLHHPEjHCQwm65VQLKDLnkuQTaP4vlDsk2yXw1FdEOsBDbt5RmvVUJHhXZNDc
	nCdtm2PZzq6rVZJxOI8mj9B2C56ykmapP8OjD7n7m/ascFaOPVjLgCEsryq2b78f6E2l5Odzk3Pbc
	5QEvF0cDeLEcvnboRBoqAPjp6CRbDcnFnmemQCDEAwaY74ovKbe9/vWCsg2p0kcOL1IJSSmM471Df
	kD+y1iJw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mq-0001JZ-Iu; Mon, 16 Dec 2024 13:01:20 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mj-00DDDe-On; Mon, 16 Dec 2024 13:01:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 13:00:58 +0100
Subject: [PATCH net-next v2 2/6] vsock/test: Introduce option to run a
 single test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-test-vsock-leaks-v2-2-55e1405742fc@rbox.co>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
In-Reply-To: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Allow for singling out a specific test ID to be executed.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c       | 20 ++++++++++++++++++--
 tools/testing/vsock/util.h       |  2 ++
 tools/testing/vsock/vsock_test.c | 10 ++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..5a3b5908ba88e5011906d67fb82342d2a6a6ba74 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -486,8 +486,7 @@ void list_tests(const struct test_case *test_cases)
 	exit(EXIT_FAILURE);
 }
 
-void skip_test(struct test_case *test_cases, size_t test_cases_len,
-	       const char *test_id_str)
+static unsigned long parse_test_id(const char *test_id_str, size_t test_cases_len)
 {
 	unsigned long test_id;
 	char *endptr = NULL;
@@ -505,9 +504,26 @@ void skip_test(struct test_case *test_cases, size_t test_cases_len,
 		exit(EXIT_FAILURE);
 	}
 
+	return test_id;
+}
+
+void skip_test(struct test_case *test_cases, size_t test_cases_len,
+	       const char *test_id_str)
+{
+	unsigned long test_id = parse_test_id(test_id_str, test_cases_len);
 	test_cases[test_id].skip = true;
 }
 
+void pick_test(struct test_case *test_cases, size_t test_cases_len,
+	       const char *test_id_str)
+{
+	unsigned long i, test_id;
+
+	test_id = parse_test_id(test_id_str, test_cases_len);
+	for (i = 0; i < test_cases_len; ++i)
+		test_cases[i].skip = (i != test_id);
+}
+
 unsigned long hash_djb2(const void *data, size_t len)
 {
 	unsigned long hash = 5381;
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index ba84d296d8b71e1bcba2abdad337e07aac45e75e..e62f46b2b92a7916e83e1e623b43c811b077db3e 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -62,6 +62,8 @@ void run_tests(const struct test_case *test_cases,
 void list_tests(const struct test_case *test_cases);
 void skip_test(struct test_case *test_cases, size_t test_cases_len,
 	       const char *test_id_str);
+void pick_test(struct test_case *test_cases, size_t test_cases_len,
+	       const char *test_id_str);
 unsigned long hash_djb2(const void *data, size_t len);
 size_t iovec_bytes(const struct iovec *iov, size_t iovnum);
 unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe..1ad1fbba10307c515e31816a2529befd547f7fd7 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1644,6 +1644,11 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 's',
 	},
+	{
+		.name = "test",
+		.has_arg = required_argument,
+		.val = 't',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -1681,6 +1686,7 @@ static void usage(void)
 		"  --peer-cid <cid>       CID of the other side\n"
 		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n"
 		"  --list                 List of tests that will be executed\n"
+		"  --test <test_id>       Single test ID to be executed\n"
 		"  --skip <test_id>       Test ID to skip;\n"
 		"                         use multiple --skip options to skip more tests\n",
 		DEFAULT_PEER_PORT
@@ -1737,6 +1743,10 @@ int main(int argc, char **argv)
 			skip_test(test_cases, ARRAY_SIZE(test_cases) - 1,
 				  optarg);
 			break;
+		case 't':
+			pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
+				  optarg);
+			break;
 		case '?':
 		default:
 			usage();

-- 
2.47.1


