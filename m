Return-Path: <netdev+bounces-153298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C076F9F78F8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7113D7A1B2E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6A2236F3;
	Thu, 19 Dec 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fwmqz8/7"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6F223327
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601795; cv=none; b=Kv2+LSp1GRkrWPUXOgQIeAc8t7mdQmr3mPmYjKJWUCWsmQSzzKBq1bAqWYg6A1BbcacF1b6h5LawAz4gak0xl5b7+wg+4EwjvSLp2+xOWKBg5ld3pbcUkH0CIzEtAx+C1DWFno9k6qKsoTUn5whoKSONTYXgbLkqUEz1Sruz8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601795; c=relaxed/simple;
	bh=ju6IGWLtYqExbV/fn7gfxYlR12Ci2mvz7HGnXsSC8+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hu3Tum4K6mIKEtj6AyDeLby1YsgCN76aR97JdH7kTUqAUFzngvSd02+YOJf1jdEBCHRh7LpvsMP9X2yavaTzxzx4Y+qcshqrUL+rQvtUt2P7FQ8+FE2jTlpj+aYMqRPt+EQ45hAuBpoW8SNkghjNGomPI+UznW4fDnAMmfi6r5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fwmqz8/7; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODAE-007Npa-H6
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:49:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=/Z3jTRGpfnS7P9pn7iHNfeuDwxiOumnJL2gR7jcfGUs=; b=fwmqz8/7ySwg6eUTqXepABDOVw
	yDK1Lv0pHdLwR/QYMSY66eDm1DjYvJ9zz3OtPcgHxiAeelLRV5vwHLyjKulAQzYHzilumaqAZnDYC
	SF1SXiyFrSU55YvLHbY5azzApkkvUIUB9Zm24mbl4SppvMPrYHmyTzxFlPxO0z0OEdibJ51JvS6dl
	sa1bovSENX1U0HMG4FXcJvn9rW9M8AhOMDutz5sFOuCeIPtAD0cJHVALoxNfwaDKXMtl9bmdMyWMv
	8w02Jh5/PVeGweCu7z1gpen6fJdeXfYBoz0TLbH7T1KRci4WmHI3gdx63ES6A43GBHzzdgiYx8c2G
	mVaT+s7A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODA9-0004rA-5c; Thu, 19 Dec 2024 10:49:45 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA3-00BSZD-Nb; Thu, 19 Dec 2024 10:49:39 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:29 +0100
Subject: [PATCH net-next v4 2/7] vsock/test: Introduce option to select
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-2-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Allow for selecting specific test IDs to be executed.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c       | 29 +++++++++++++++++++++++++++--
 tools/testing/vsock/util.h       |  2 ++
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..81b9a31059d8173a47ea87324da50e7aedd7308a 100644
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
@@ -505,9 +504,35 @@ void skip_test(struct test_case *test_cases, size_t test_cases_len,
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
+	static bool skip_all = true;
+	unsigned long test_id;
+
+	if (skip_all) {
+		unsigned long i;
+
+		for (i = 0; i < test_cases_len; ++i)
+			test_cases[i].skip = true;
+
+		skip_all = false;
+	}
+
+	test_id = parse_test_id(test_id_str, test_cases_len);
+	test_cases[test_id].skip = false;
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
index 38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe..8bb2ab41c55f5c4d76e89903f80411915296c44e 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1644,6 +1644,11 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 's',
 	},
+	{
+		.name = "pick",
+		.has_arg = required_argument,
+		.val = 't',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -1681,6 +1686,8 @@ static void usage(void)
 		"  --peer-cid <cid>       CID of the other side\n"
 		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n"
 		"  --list                 List of tests that will be executed\n"
+		"  --pick <test_id>       Test ID to execute selectively;\n"
+		"                         use multiple --pick options to select more tests\n"
 		"  --skip <test_id>       Test ID to skip;\n"
 		"                         use multiple --skip options to skip more tests\n",
 		DEFAULT_PEER_PORT
@@ -1737,6 +1744,10 @@ int main(int argc, char **argv)
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


