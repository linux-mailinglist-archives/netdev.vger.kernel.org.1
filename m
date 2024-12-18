Return-Path: <netdev+bounces-153107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199149F6CB4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5265816545A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA21F7072;
	Wed, 18 Dec 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glZnQOdS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2750E142624
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544490; cv=none; b=SFnMsY9BcHRRLXmkA7WIIjFbhhKr9Xfqvpcwh0AXDzShRWP2qbm9gAukoXGODJznNjS0baBRwHtSne4oiOc4hZ8yc1doX+GLSnl/Xe9wnEMaG1fSUjBSsG8JUnyNe9K8KmJ60z0sm+2s47LYLUHHZ12bQ9Dn0iJn/YE8WyLyl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544490; c=relaxed/simple;
	bh=GtRKQ858L35ZpQRnnsZfY80ZSVPUCXlz+4DUlCucSzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csqc1ejkZx+/ec7+Kqeh2EhJmdLnZAstdu3F4dToSjA+GNFIpxndIDOaBYpbrI2OYF/V5ujXeGjaLogISPhKpeeQhcC6mxr+Abj6PyhaOCj9UMJK03NhiHGHhNsF3janoab/umeLCzjvnEXcYuIkuGszOUBtXyDO0fPFzXRkPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glZnQOdS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734544487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqR0qUKVsyQz6PVuo/IkTGTx1/0WjnExCLPMkb+unAU=;
	b=glZnQOdSdG+KyPF1JB0Mp5E6mD4dIk5FxkrNpExNxx0oyeWcmmkmyJrakNe2yQBGxdkvoj
	B/buYPVDtv0uIHB7FqsOfQcrYE28tdt0HxRRMKuEWbgu9y34cYB7cqzQETdSp8dQgm1iH9
	cijGl49FWt82InCxrhqyLxXy9FvJSl0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-p0VAJ9MwPjOFVHC8CBL-0g-1; Wed, 18 Dec 2024 12:54:40 -0500
X-MC-Unique: p0VAJ9MwPjOFVHC8CBL-0g-1
X-Mimecast-MFC-AGG-ID: p0VAJ9MwPjOFVHC8CBL-0g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3878ad4bf8cso4336146f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544479; x=1735149279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqR0qUKVsyQz6PVuo/IkTGTx1/0WjnExCLPMkb+unAU=;
        b=SkW8jI98VTf6D970qv2X64aLodflYhg26AzgToQxtroegAtPyVD9Gu18I+ibteZsek
         s9rdkugoU2hMDV1RAvaiM7WNfCRfSRvxvipIzT2g1ZejwQOn3XXT/bnHzKajksXj4XtU
         QGpQV5Kzq8TUUsoggmfRioXnezQpjYySm67Sy/nzD5T9LpuKaHxsv3b6V3VYNiXoL7Ji
         iI0avnl8dPmLgHTdFfUqPorKayvndRAiDOsaLhFttzgLS1UZjcp50uPdl6PRr7fSpP2C
         8TglLMDg8SBcM2X6MXiZN+afNI78hzTPTzFj/u7YDrnlcD4rytWqYVEXHPdoWstRNaqI
         9I3g==
X-Gm-Message-State: AOJu0Yz4SCj2L9xDixgTLVroNGD3WuCRdDLxkuCZheTVNhBh7W62wNOH
	vU6jGrWDCccnZZ5K3jxF/JRvk7m6IoAGhKHFpV5zwJAjX4RLY0jvxfRoO16zRg5I0EE2d2aA0qp
	gvVqccEeh9Mkvi7GJjeSxv6H4hYO8fWef75h9xbyrreh6nWLxaqll/w==
X-Gm-Gg: ASbGncsLhDDkk8YlYjf9wzX5oA+Yc9nODmY3e+9FcKrqQ0cqygSDHi2VTQLtAqCF4P7
	33Jv3EqUOVFK2ztugUgTOFK4YqIU4jL3PB+e9YHqzqpZUcVX1cIZ2tOdIMnSwcth2PG4rAvErDD
	WUPyVEXxEPRuHi9B0V36VeKfwB1FS/MCyJEmFx67h2W8Y4YzjLNoUmWf+3nczD1eJQL0QZJf0BD
	y8tvyu9X7liQiAEX0sNW3nAPmNy7nyz+nKV0k3N5iFK1QLGPWA9uyGHaIImqAY1v8Sf1Lu6J7Rj
	aBnw6AgD3tS5YCuH5hWoKAdQGRDIQbow
X-Received: by 2002:a5d:64eb:0:b0:385:dedb:a156 with SMTP id ffacd0b85a97d-388e4d2e2ccmr3858836f8f.6.1734544479422;
        Wed, 18 Dec 2024 09:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSQfvzAam9LVh9r56rFM9S900vYGx2nx+Klp4qY3LeVqCqqg3QBeZQGKVSRTNM/7BsqFUizA==
X-Received: by 2002:a5d:64eb:0:b0:385:dedb:a156 with SMTP id ffacd0b85a97d-388e4d2e2ccmr3858808f8f.6.1734544478720;
        Wed, 18 Dec 2024 09:54:38 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013a1sm27512765e9.11.2024.12.18.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:54:38 -0800 (PST)
Date: Wed, 18 Dec 2024 18:54:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] vsock/test: Introduce option to select
 tests
Message-ID: <sjvfyu4wurdko7jnqprwuikhmr47o5po6rneyswjech3cv2sx7@aku55xjzagi3>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <20241218-test-vsock-leaks-v3-2-f1a4dcef9228@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241218-test-vsock-leaks-v3-2-f1a4dcef9228@rbox.co>

On Wed, Dec 18, 2024 at 03:32:35PM +0100, Michal Luczaj wrote:
>Allow for selecting specific test IDs to be executed.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 29 +++++++++++++++++++++++++++--
> tools/testing/vsock/util.h       |  2 ++
> tools/testing/vsock/vsock_test.c | 11 +++++++++++
> 3 files changed, 40 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..81b9a31059d8173a47ea87324da50e7aedd7308a 100644
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
>@@ -505,9 +504,35 @@ void skip_test(struct test_case *test_cases, size_t test_cases_len,
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
>+	static bool skip_all = true;
>+	unsigned long test_id;
>+
>+	if (skip_all) {
>+		unsigned long i;
>+
>+		for (i = 0; i < test_cases_len; ++i)
>+			test_cases[i].skip = true;
>+
>+		skip_all = false;
>+	}
>+
>+	test_id = parse_test_id(test_id_str, test_cases_len);
>+	test_cases[test_id].skip = false;
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
>index 38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe..8bb2ab41c55f5c4d76e89903f80411915296c44e 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1644,6 +1644,11 @@ static const struct option longopts[] = {
> 		.has_arg = required_argument,
> 		.val = 's',
> 	},
>+	{
>+		.name = "pick",
>+		.has_arg = required_argument,
>+		.val = 't',
>+	},
> 	{
> 		.name = "help",
> 		.has_arg = no_argument,
>@@ -1681,6 +1686,8 @@ static void usage(void)
> 		"  --peer-cid <cid>       CID of the other side\n"
> 		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n"
> 		"  --list                 List of tests that will be executed\n"
>+		"  --pick <test_id>       Test ID to execute selectively;\n"
>+		"                         use multiple --pick options to select more tests\n"
> 		"  --skip <test_id>       Test ID to skip;\n"
> 		"                         use multiple --skip options to skip more tests\n",
> 		DEFAULT_PEER_PORT
>@@ -1737,6 +1744,10 @@ int main(int argc, char **argv)
> 			skip_test(test_cases, ARRAY_SIZE(test_cases) - 1,
> 				  optarg);
> 			break;
>+		case 't':
>+			pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
>+				  optarg);
>+			break;
> 		case '?':
> 		default:
> 			usage();
>
>-- 
>2.47.1
>


