Return-Path: <netdev+bounces-139568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1D9B320D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8361C21C7D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918F1DDA00;
	Mon, 28 Oct 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrQepBxB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7281DD533
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123103; cv=none; b=RmAKEYjLJm+QyRF5LRAeNKguuoZ97FsDXV4ZNju08UHLB+zUpQTh08sHEZoGML8+w7Fqw3xppV0QPpJCdSDj5t1eIY+TLGjvAXEQFpLZHZYd9XRy32FTKU8Gz9iXgm3BkPQUzsA+IBnLoqfphm2ZjzthC1nyWVg4Pn8tAdfnlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123103; c=relaxed/simple;
	bh=aEs7wkOs/9Tmtuzmg6k86fkOGprpHMB9+QFgot8mjSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKaMVelC9OzYB4I4f/dPd40k8plAfckJdHSU5mbtqrNbC8XylRpApCeNiXv3g1MAh1EiKAxwfTTKJbbCuM6MRb2MtJ4DbtZMeqbrXulaCYpVgdO2IRWs8tMY9l1wQ+8Ae4wJGX+GuM4GrVBRMIEMohbv1Og+u7T+nzbAlNV2Bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrQepBxB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730123100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vGL1SVZq+LgfXtvaR3j6jeveiqx6XHBU95MSTDGVg4=;
	b=BrQepBxBEfqeIeeoAXz6Qe4kdRgcRe33fWkBWk+JCgTZ3IYuNIgO2djpR6Bbim1l67r7xx
	S/1dyV9YfwLknbh3tvexPW6stvgiuEVhs2+CuJjc9PeY7gPPFgqAF8vMAEzMXPNOhnktdn
	hPJbEMW2UeuBQIUQ+lLBm0MSWz/QJTY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-UksBqTIoOq-UMRhyjBjzaw-1; Mon, 28 Oct 2024 09:44:58 -0400
X-MC-Unique: UksBqTIoOq-UMRhyjBjzaw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b15d3cd6dcso823414785a.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 06:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123098; x=1730727898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vGL1SVZq+LgfXtvaR3j6jeveiqx6XHBU95MSTDGVg4=;
        b=Mwk8HYAu5EFmGxEY1WvXmey34JBUJktx9qnG+oEd9W6lYs6gm6YU7Mf5QLo5GQiXn8
         yphwW756Q5vFUJngdFy3OwpirE4RMrDucdDDoN3U5qhy9SS+c4XsDeKrMqhf5Xxqo15u
         IYqFfD65DhI0qj3PKSgvIcEobPa1K9u6oOA9jz5ZUrYvRPb4xuzjZ16fHL+KFuhpzSc8
         mtxJmhmLsRfIu+x+W/0Fa8uAcfa7UT9ABZclBaCLt4ICJQsPKYSM9m1leXnYDJEjXUXQ
         16Ke1xwz+kK8yruN9jgJ71hkBcukmdGtIBkL+LzjgVsvnvZdK44gKJv9AuAtptIX8/0i
         HNgg==
X-Forwarded-Encrypted: i=1; AJvYcCUtvMC/Jdykf5dWRwLLUe+d882uFOQQfgz71XQ2qESS4nQhuIalJ28H/sbrwFdj55Eqd3eVsk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHyoMtHaVD6gdzWpQ5p3Lsgnv9qVpz/pmKFbduDw5WjMkEwmd
	VLr8O+SErSGFyLR061IQUyjD2ynaWYvVomdD+BGf2K7eFWWBwzTCwguHtNyjySR7tjOMw6uTNg/
	oc5m/ICQPMfI+GuO7BG7xm2SXlEFnK1v+Z2h+Zn17eEroBWcnRqd5V8h0p9dOOQ==
X-Received: by 2002:a05:620a:1a1c:b0:7b1:44f1:cb6d with SMTP id af79cd13be357-7b193f3f2d4mr1447475185a.42.1730123097798;
        Mon, 28 Oct 2024 06:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDCoi09rdBp6AbuPJnFmwQMjbUbwDykG7M6wD0fUANXJfHN4wHVrUUk5Lqyj/Lt6o3xbXOQ==
X-Received: by 2002:a05:620a:1a1c:b0:7b1:44f1:cb6d with SMTP id af79cd13be357-7b193f3f2d4mr1447469985a.42.1730123097245;
        Mon, 28 Oct 2024 06:44:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17973d8bdsm32521456d6.18.2024.10.28.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:44:56 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:44:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <s5mhlz5szowwse52t6u44u3despluqb2ucudmmolx55vmtvs2l@eptqoed2qwmv>
References: <20241025154124.732008-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241025154124.732008-1-kshk@linux.ibm.com>

On Fri, Oct 25, 2024 at 10:41:24AM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in vsock_test failures, while vsock_perf doesn't even notice
>that it's failed to change it.
>
>Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
>Changes for v3:
>- fix the same problem in vsock_perf and update commit message
>Changes for v2:
>- add "Fixes:" lines to the commit message

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> tools/testing/vsock/vsock_perf.c | 6 +++---
> tools/testing/vsock/vsock_test.c | 4 ++--
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 4e8578f815e0..22633c2848cc 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -133,7 +133,7 @@ static float get_gbps(unsigned long bits, time_t ns_delta)
> 	       ((float)ns_delta / NSEC_PER_SEC);
> }
>
>-static void run_receiver(unsigned long rcvlowat_bytes)
>+static void run_receiver(int rcvlowat_bytes)
> {
> 	unsigned int read_cnt;
> 	time_t rx_begin_ns;
>@@ -163,7 +163,7 @@ static void run_receiver(unsigned long rcvlowat_bytes)
> 	printf("Listen port %u\n", port);
> 	printf("RX buffer %lu bytes\n", buf_size_bytes);
> 	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
>-	printf("SO_RCVLOWAT %lu bytes\n", rcvlowat_bytes);
>+	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
>
> 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>
>@@ -439,7 +439,7 @@ static long strtolx(const char *arg)
> int main(int argc, char **argv)
> {
> 	unsigned long to_send_bytes = DEFAULT_TO_SEND_BYTES;
>-	unsigned long rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
>+	int rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
> 	int peer_cid = -1;
> 	bool sender = false;
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..30857dd4ca97 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -833,7 +833,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1282,7 +1282,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
> static void test_stream_credit_update_test(const struct test_opts *opts,
> 					   bool low_rx_bytes_test)
> {
>-	size_t recv_buf_size;
>+	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
> 	void *buf;
>-- 
>2.34.1
>


