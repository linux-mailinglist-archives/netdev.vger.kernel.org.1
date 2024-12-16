Return-Path: <netdev+bounces-152244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2B9F334F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0FE1881244
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D46204092;
	Mon, 16 Dec 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahBl+ifG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB417557
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359735; cv=none; b=nOfZzGygq6N0qaZZABhx0W9ohuIHLnT9oNeOgrRc1G7T+cZSv2JzWA/J6ZUguCgEatkSZCT88bQHlOK/6aBPIid7SHrFy/aKsiuL6y9fFpthjzksw/ya/I9z7EMUAElK36fEGzHIyqB/bnvmvXal2VYQuSEk37d/lKUAHxVj+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359735; c=relaxed/simple;
	bh=CeqvSxqSGKymc8v+8Owmxe/UVVY5TKm27ltKUYAVZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLBI6LdTBGv4+MpBb6k0Xwi5DjCN/g0Uq5Vx9wuTsUciwrBTyjFqjC/is5SwWlXtIr3/x1L9YJDaxciAlrmpIi7HPPZ3jhwUrkUmsrcqyBuOg/I73xAiGg3EFUuMxSC9KaU3m7jSxDy+3hKtg22f+UUIe3WDJK/EsmT60MjveU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahBl+ifG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734359732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKxgxwLG9sT8KvPHvHVTJiG+Dve/nXws91UvZ01LZ5E=;
	b=ahBl+ifGiuvycUFvU+mEzcpfns62g0zLehoCZRugTnQIIIGeduNi8NHul+M/xxaRWKjrj1
	wg10y7HbUvKOr1rqwU/UxpLpBlc8LsJWOFJskNevUyswyqmLFlkOGxZPXjvO24o078Rmtl
	WAG/fwkZTfqu+tGHlFjC/5DCq3ch3co=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-rV-Tw8vrOAyxY-B7Ig7ZoQ-1; Mon, 16 Dec 2024 09:35:31 -0500
X-MC-Unique: rV-Tw8vrOAyxY-B7Ig7ZoQ-1
X-Mimecast-MFC-AGG-ID: rV-Tw8vrOAyxY-B7Ig7ZoQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f94518c9so101093196d6.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359730; x=1734964530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKxgxwLG9sT8KvPHvHVTJiG+Dve/nXws91UvZ01LZ5E=;
        b=aDAwa5uoxrt24xkeH78V0ytnfj9/XLMl6f4UB7ppBdN2soU7Eza30LhrNHPfQC+eg1
         6aRYO/zkQ/e2kYUQPV6l46WPEJ+sk7kL9hsN/YRyI7s+rkkoFf/uPSZZzstEHnus+ZFh
         3A3k0qkoUlJBmXJG8Am3ibZaqNkcrOBq1xqXkm3fc0PFoPMk7twOoES6VNMT9rfZQdsY
         kGDCHTNqdUMJGyP5DnLtYsaNRNYqgzaNzk/00nCtYLgQIueicAunyC1V9q+VnBdWevgR
         mCDAvDsEEnTL9SVaTxURLs/glEsQylMH1bTqv3+6DgXQlR2D2btbaDEriGTXCbmlZu9x
         ibLw==
X-Gm-Message-State: AOJu0YzdSBN8vVeRmOxzoK80KDQ4F87O1mWDMpNNBU4E/FYXYiPa7CuA
	88i80/verPr+nzNKN+KCEDxcPSjwQ2ONx6Lq5EYa6ah4c0HKibe+QzVJ6m3wd+ldA+dfp/fe0h8
	c0LKCr5TNxkN6JTibu8LHSGMdJ3xlRArqG8+Z3QqjGbpgse0eIwvhFyJQv5F0D11O
X-Gm-Gg: ASbGncun0fTwENYq00Gz3poNj98oyBTQEtudLDmGheQHyB69Q/ohsy3VLNFvzoPTFy9
	Vr9C2FAY4kRMULGzT6GYo4qDyd7bT3Bfj0Lbx803XRmwEayVD8sc2m/yUvqMZQRdd3VWJkGUU0+
	rZJU4dD0RD+2RgipD4ICJfsup2YJDaRDtnydijxVpJx88eEnZ7Zo40WMv5tkTH31DiioZtxLzQ1
	+BsY1uuq1aah/nyiq4Fj2CUo2lkiD85GaAw0lF43i6YI2CFJSNx/m3QvoiP/GGlbjAZWMAtRcsQ
	lbfOZWjtsnB7+bxolF6Njj4Th/qKm+B6
X-Received: by 2002:a05:6214:262e:b0:6d8:a50f:b5f6 with SMTP id 6a1803df08f44-6dc8ca84fafmr265432266d6.25.1734359730588;
        Mon, 16 Dec 2024 06:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpQTwllIPQ1Q4vJkc7HmOko6iB83fmPfJ8ehgMElL2sVl8dnMwN7oBT06Y/FBijLV0FbAOZQ==
X-Received: by 2002:a05:6214:262e:b0:6d8:a50f:b5f6 with SMTP id 6a1803df08f44-6dc8ca84fafmr265430926d6.25.1734359729561;
        Mon, 16 Dec 2024 06:35:29 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd366238sm27736126d6.77.2024.12.16.06.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:35:29 -0800 (PST)
Date: Mon, 16 Dec 2024 15:35:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] vsock/test: Add test for accept_queue
 memory leak
Message-ID: <bl3osg7ze6bjivu53j5vdlrtkzq35vk3zbp2veosyklp53rf2i@drb2efczau6n>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-4-55e1405742fc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241216-test-vsock-leaks-v2-4-55e1405742fc@rbox.co>

On Mon, Dec 16, 2024 at 01:01:00PM +0100, Michal Luczaj wrote:
>Attempt to enqueue a child after the queue was flushed, but before
>SOCK_DONE flag has been set.
>
>Test tries to produce a memory leak, kmemleak should be employed. Dealing
>with a race condition, test by its very nature may lead to a false
>negative.
>
>Fixed by commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory
>leak").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 51 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 51 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 1ad1fbba10307c515e31816a2529befd547f7fd7..1a9bd81758675a0f2b9b6b0ad9271c45f89a4860 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1474,6 +1474,52 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
> 	test_stream_credit_update_test(opts, false);
> }
>
>+/* The goal of test leak_acceptq is to stress the race between connect() and
>+ * close(listener). Implementation of client/server loops boils down to:
>+ *
>+ * client                server
>+ * ------                ------
>+ * write(CONTINUE)
>+ *                       expect(CONTINUE)
>+ *                       listen()
>+ *                       write(LISTENING)
>+ * expect(LISTENING)
>+ * connect()             close()
>+ */
>+#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
>+
>+#define CONTINUE	1
>+#define DONE		0

I would add a prefix here, looking at the timeout, I would say
ACCEPTQ_LEAK_RACE_CONTINUE and ACCEPTQ_LEAK_RACE_DONE.

The rest LKGT!
Stefano

>+
>+static void test_stream_leak_acceptq_client(const struct test_opts *opts)
>+{
>+	time_t tout;
>+	int fd;
>+
>+	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		control_writeulong(CONTINUE);
>+
>+		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+		if (fd >= 0)
>+			close(fd);
>+	} while (current_nsec() < tout);
>+
>+	control_writeulong(DONE);
>+}
>+
>+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
>+static void test_stream_leak_acceptq_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	while (control_readulong() == CONTINUE) {
>+		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+		control_writeln("LISTENING");
>+		close(fd);
>+	}
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1604,6 +1650,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unsent_bytes_client,
> 		.run_server = test_seqpacket_unsent_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM leak accept queue",
>+		.run_client = test_stream_leak_acceptq_client,
>+		.run_server = test_stream_leak_acceptq_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.47.1
>


