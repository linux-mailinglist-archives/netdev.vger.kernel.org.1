Return-Path: <netdev+bounces-152241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E09F3345
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E4F1883D02
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51F202C2A;
	Mon, 16 Dec 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl3E9yjW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAD1DDEA
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359551; cv=none; b=WJ/CxSyAQxy/QxM1MmzWZMVo3GfZkW9cH1nc2UVJdQNq0BAFzp198DXbZLYdkJnxyslvhpOamW0Ms7oA8YlzK3kAOJEBVjfw2A3Oh75YgadN5R+FAM5UgMKcfP6TOBDIlNHpRz3KkQDr2js4AgWQQNTzwLLdpId8v5+y04sqe+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359551; c=relaxed/simple;
	bh=my8dWBTFG0ulc98l3huT3hnch3RduOfXO67XktfWhhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUCMMLFKodQ8hb5VG6zDGglj0VpdQwgbUR4cfEhnWLMP+HGtcOs2n8MReTdhy1PACUdJDXeSWU4mfyShchxkpvm6mL7aB1GogsM7MSt/I89tjuD2+P9PqtPM0zHOvmzhIN0i6+kSmuJEOc6rWcFq64CAMQzPWkuJvmTcu/FaICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl3E9yjW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734359548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AM8yKmG5IScW1+yl0nTgCeRcUqrgRKK9NmYSaqMfnts=;
	b=Cl3E9yjWkDeWbfYMG6vaSVhzPzxgYZbtheWDjhekGRhGx4Jv1FLtPd81xm8IjsnixDLeBj
	jUKraVeqBMzOVPX4yGAk9U2bk70v69TMgU/wl2Umnx4H6oVTr0mQ/zTzByIVDrEoS5BkeO
	KjjfiuakhCmffHv9MgKImUvsKi6A0U8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ErKa4-hcNNK0hZIB8d634w-1; Mon, 16 Dec 2024 09:32:26 -0500
X-MC-Unique: ErKa4-hcNNK0hZIB8d634w-1
X-Mimecast-MFC-AGG-ID: ErKa4-hcNNK0hZIB8d634w
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467b645935fso38400601cf.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359545; x=1734964345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM8yKmG5IScW1+yl0nTgCeRcUqrgRKK9NmYSaqMfnts=;
        b=u6hOnS5VMbi3D4AQTzk/rU1FoH9ANooqeCkvI3LHYXOnn7zNTr1Mw6qlvjSvOSqDif
         F78kvmkUXw6RA8wLe0OepkoC73cwc6a5w7PAlGnCFxxEE7/mk0R9Uq+0TlToEZyp+qgE
         2m6ieNwlIRcb0JKqBQKMfhOcoP7rNyz7lK+RC8ayHo/+UUv+ux8S+AFnnOnLtxeUQNAx
         esQxnLeUi8ZJ8AaXD04FLWLbewzF81MrzUthg0Csr0CIh3CdhKVYrRFhgjabNPgadH/K
         X0517YERwEE6ZxyYRTT3WcVJr5mFlyxoCzOQ6nL2LJ717SoJJwPDGgaphwzLGJZysSH0
         Qfsw==
X-Gm-Message-State: AOJu0YxaIJliHskoh/9MdUwi1dl6YA+MmdQH+LdJQyf1lQ0yxfINzhsO
	A3q/h/6Aqz2h1hspmvKbcTICH/7IKjZrRbjIiyFs7P6KGL49uTUFiul5mriOmWoYc+a47tmpt6O
	ACeoPgBddmLNFv3ZxkTlVfzvN9EUTjU/IB+9nuPscL03lrkAdC9dGArgASRBYkvOg
X-Gm-Gg: ASbGncvBxFQorwv3NDFvFfooKacJK9RogZPHlesGgKVu5HgIfV5xzXC3fAznv88Z6Ss
	tyYFFH3JfYLimp6pWfmTwXmTH04hsXZ+ZDP1i9SLp6+AGP5KjnBf6wCBNE7/v/D9tVMUWtTvg3v
	faXdOT10L1YXD6SOynQJGqK2flJrJLtWeIcC28JbeXdmn95CVRyzY/+0ZI2PZma1OnXxoMPemu4
	DgQAusCYE4ZTrjoI7YFbPqGLAUKgxRi4V2cDY4oik/iU/WQX/0o2cNIbHDrhvEOo5VGnRjddcdx
	asomLYT5oQmVVyRzB3lhm+ijNA0QLUXT
X-Received: by 2002:ac8:5910:0:b0:466:9197:b503 with SMTP id d75a77b69052e-467a5841f01mr257195331cf.46.1734359545104;
        Mon, 16 Dec 2024 06:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8ikWy2U5MrBr55xGTVF0n64wlHuV1Y1gdAIJP3/f1I6p9izP56L2Jr44iinziRqJ5AE1f+Q==
X-Received: by 2002:ac8:5910:0:b0:466:9197:b503 with SMTP id d75a77b69052e-467a5841f01mr257194861cf.46.1734359544690;
        Mon, 16 Dec 2024 06:32:24 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2eca6a8sm28134391cf.77.2024.12.16.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:32:24 -0800 (PST)
Date: Mon, 16 Dec 2024 15:32:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] vsock/test: Introduce option to run a
 single test
Message-ID: <ybwa5wswrwbfmqyttvqljxelmczko5ds2ln5lvyv2z5rcf75us@22lzbskdiv3d>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-2-55e1405742fc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241216-test-vsock-leaks-v2-2-55e1405742fc@rbox.co>

On Mon, Dec 16, 2024 at 01:00:58PM +0100, Michal Luczaj wrote:
>Allow for singling out a specific test ID to be executed.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 20 ++++++++++++++++++--
> tools/testing/vsock/util.h       |  2 ++
> tools/testing/vsock/vsock_test.c | 10 ++++++++++
> 3 files changed, 30 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..5a3b5908ba88e5011906d67fb82342d2a6a6ba74 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -486,8 +486,7 @@ void list_tests(const struct test_case *test_cases)
> 	exit(EXIT_FAILURE);
> }
>
>-void skip_test(struct test_case *test_cases, size_t test_cases_len,
>-	       const char *test_id_str)
>+static unsigned long parse_test_id(const char *test_id_str, size_t test_cases_len)
> {
> 	unsigned long test_id;
> 	char *endptr = NULL;
>@@ -505,9 +504,26 @@ void skip_test(struct test_case *test_cases, size_t test_cases_len,
> 		exit(EXIT_FAILURE);
> 	}
>
>+	return test_id;
>+}
>+
>+void skip_test(struct test_case *test_cases, size_t test_cases_len,
>+	       const char *test_id_str)
>+{
>+	unsigned long test_id = parse_test_id(test_id_str, test_cases_len);
> 	test_cases[test_id].skip = true;
> }
>
>+void pick_test(struct test_case *test_cases, size_t test_cases_len,
>+	       const char *test_id_str)
>+{
>+	unsigned long i, test_id;
>+
>+	test_id = parse_test_id(test_id_str, test_cases_len);
>+	for (i = 0; i < test_cases_len; ++i)
>+		test_cases[i].skip = (i != test_id);
>+}
>+
> unsigned long hash_djb2(const void *data, size_t len)
> {
> 	unsigned long hash = 5381;
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index ba84d296d8b71e1bcba2abdad337e07aac45e75e..e62f46b2b92a7916e83e1e623b43c811b077db3e 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -62,6 +62,8 @@ void run_tests(const struct test_case *test_cases,
> void list_tests(const struct test_case *test_cases);
> void skip_test(struct test_case *test_cases, size_t test_cases_len,
> 	       const char *test_id_str);
>+void pick_test(struct test_case *test_cases, size_t test_cases_len,
>+	       const char *test_id_str);
> unsigned long hash_djb2(const void *data, size_t len);
> size_t iovec_bytes(const struct iovec *iov, size_t iovnum);
> unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe..1ad1fbba10307c515e31816a2529befd547f7fd7 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1644,6 +1644,11 @@ static const struct option longopts[] = {
> 		.has_arg = required_argument,
> 		.val = 's',
> 	},
>+	{
>+		.name = "test",
>+		.has_arg = required_argument,
>+		.val = 't',
>+	},
> 	{
> 		.name = "help",
> 		.has_arg = no_argument,
>@@ -1681,6 +1686,7 @@ static void usage(void)
> 		"  --peer-cid <cid>       CID of the other side\n"
> 		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n"
> 		"  --list                 List of tests that will be executed\n"
>+		"  --test <test_id>       Single test ID to be executed\n"
> 		"  --skip <test_id>       Test ID to skip;\n"
> 		"                         use multiple --skip options to skip more tests\n",
> 		DEFAULT_PEER_PORT
>@@ -1737,6 +1743,10 @@ int main(int argc, char **argv)
> 			skip_test(test_cases, ARRAY_SIZE(test_cases) - 1,
> 				  optarg);
> 			break;
>+		case 't':
>+			pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
>+				  optarg);
>+			break;

Cool, thanks for adding it!
Currently, if we use multiple times `--test X`, only the last one is 
executed.

If we want that behaviour, we should document in the help, or just error 
on second time.

But it would be cool to support multiple --test, so maybe we could do 
the following:
- the first time we call pick_test, set skip to true in all tests
- from that point on go, set skip to false for each specified test

I mean this patch applied on top of your patch (feel free to change it, 
it's just an example to explain better the idea):

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 5a3b5908ba88..81b9a31059d8 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -517,11 +517,20 @@ void skip_test(struct test_case *test_cases, size_t test_cases_len,
  void pick_test(struct test_case *test_cases, size_t test_cases_len,
                const char *test_id_str)
  {
-       unsigned long i, test_id;
+       static bool skip_all = true;
+       unsigned long test_id;
+
+       if (skip_all) {
+               unsigned long i;
+
+               for (i = 0; i < test_cases_len; ++i)
+                       test_cases[i].skip = true;
+
+               skip_all = false;
+       }

         test_id = parse_test_id(test_id_str, test_cases_len);
-       for (i = 0; i < test_cases_len; ++i)
-               test_cases[i].skip = (i != test_id);
+       test_cases[test_id].skip = false;
  }

  unsigned long hash_djb2(const void *data, size_t len)


The rest LTGM!
Stefano


