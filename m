Return-Path: <netdev+bounces-153109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B322E9F6CBA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B95C18892F4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6B81F9A81;
	Wed, 18 Dec 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtLHf1zO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB821369B4
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544576; cv=none; b=XXfwdMkYp+eFLw9wEY3Q79OJC/YGxBZb6pjRtrOe9glA0rp6ENeig5xCeiljK+GXxomvxSkY5gQNcQe/3Sh6afeRD00NCSdM72qzflfAhNxPO6qfl8x2iMxmXOaHlZQmAlqkw6S3tIGwwIxyb3i8Oy4NCjdBOR0uTaFo12L1JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544576; c=relaxed/simple;
	bh=akEgO504lSXBP5t9Qqkp3K6xBLJAjmV7FbJ0HPRRdo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOtUlvKtDgC6WuDv5dX6ePSjxwxSMpSFcz3IAnEEZhXgOXn4C/HnfFst/4buU/8bh+Csak1nyv5YdPbMW3yfQopoTdxn6c+vORbyzSK9fb/OD6d/toV6rcyZsdLqgbzXeF2cmvryaMbVPRl/5UNMw1VjPOrdTlP+bAi6Vld2FlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtLHf1zO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734544573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3dAMPkY89hhzWGcO7nEI6frV/IohjwKRD/KDB21+ys=;
	b=dtLHf1zOw8clnqmInhQoxwumfJe551dzigPZB/VLr09g0p90bqwjKIyL5nMXhqkDWeHHGc
	QfVAcZv3NixEVyPzFjExOfbKVFRVHKj6sAbRpBiA4tJ7zAKsw5DSIi7r0g56WCSe1D7Do2
	+hk1j7rW2x7IORJqN9nlxPZ07U+9kh0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-MPNkXU4wPn2BrMfsuJIO6Q-1; Wed, 18 Dec 2024 12:56:12 -0500
X-MC-Unique: MPNkXU4wPn2BrMfsuJIO6Q-1
X-Mimecast-MFC-AGG-ID: MPNkXU4wPn2BrMfsuJIO6Q
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385ded5e92aso2790666f8f.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544570; x=1735149370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3dAMPkY89hhzWGcO7nEI6frV/IohjwKRD/KDB21+ys=;
        b=DAZk0IwHvoJ8vhsrTLGtc+le9Gl/k64dwDb8ci1ijyc81WEfIY+o3eajsk0g6IO1Zq
         ZI/ZdwP3J0eLrldnMBjreXWHh/YR33QGZ4f4QKWeP/gLMz2Bl+mdMVcr4jaBMm26I1yh
         6KbMsHoiOsW6+4cD++bCyPv0TherVP+fUwIytakK3srC1MXdPEv79TSJDLL7qsTeb8D0
         cvgR4U68qMws9CF6GnxgdoIXNcrx1tU5ZIUXp691idqmVWf2bnIH8PLcCNSh/AnQ3+/d
         K5c1ZfpFuqWf8glqaXUVfVArx6iJ3SWl2oilPUW5x6hoj9Dn2NSqxYyolFabyv6h2i/X
         7gJQ==
X-Gm-Message-State: AOJu0YxjRzM3S9s6ZBG3p+bgJM4/rO91o+AoEdpMfK28wj4AD0N9e1AX
	HRbScam7Ivv/ToKWea/kSWo6F0pe3Jy8jjpf5nnmTDwzucU07zDenYR1XNC/lbWkZDD4JPNKOLJ
	ll2iwvaYPIzIxemVMXGY/iZlSbypqtKz1E62ZUR9IFksxcjcsUa+dJ7IOuYpoJylV
X-Gm-Gg: ASbGncsUoJ3h2VlyatxwdxALe4pfXrVrYoTypU6UNe39rfMYSJ+bsikCLrnRtzJWiPY
	muUFanH7dZ5kTNlbJyK4stBRWZ6HcXsyHTKFFq9mmtz6/Xt936cjfDRhkcyRLFphTAK1x4OQpyY
	UCaNy7CuLYzcKerGGL71KSrU2pbbbOkkdJaDE2dJtlvBcnmZ3LYHTG44ATEj/tPLMqOW38MfTjx
	SQ0Dhdo1FSZkTNJ3pWeyyzi4U7248GY/KwGgn65WAOrZuHmal3gWOKML1mfyso7P806Gq7Y/TII
	BLc9EwGIiogaKgbnMG+0iYU8VlTyyIFL
X-Received: by 2002:a5d:64e2:0:b0:386:4a16:dad7 with SMTP id ffacd0b85a97d-38a19aded10mr536131f8f.10.1734544570537;
        Wed, 18 Dec 2024 09:56:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/r0rMNNAnljSF5X6jkzMO3ai+j2XQPFO6feQBcxitEeAVHFOdxNFmsRQE77v9SO683TeOzw==
X-Received: by 2002:a5d:64e2:0:b0:386:4a16:dad7 with SMTP id ffacd0b85a97d-38a19aded10mr536108f8f.10.1734544569871;
        Wed, 18 Dec 2024 09:56:09 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012034sm14458047f8f.22.2024.12.18.09.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:56:09 -0800 (PST)
Date: Wed, 18 Dec 2024 18:56:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] vsock/test: Add test for accept_queue
 memory leak
Message-ID: <mnqfajtappfhgav2wqxbxi53bvnstqhwjhtdnarlmlp3uy7tid@rqcuvan7ky4b>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <20241218-test-vsock-leaks-v3-5-f1a4dcef9228@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241218-test-vsock-leaks-v3-5-f1a4dcef9228@rbox.co>

On Wed, Dec 18, 2024 at 03:32:38PM +0100, Michal Luczaj wrote:
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
> tools/testing/vsock/vsock_test.c | 52 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 8bb2ab41c55f5c4d76e89903f80411915296c44e..2a8fcb062d9d207be988da5dd350e503ca20a143 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -29,6 +29,10 @@
> #include "control.h"
> #include "util.h"
>
>+/* Basic messages for control_writeulong(), control_readulong() */
>+#define CONTROL_CONTINUE	1
>+#define CONTROL_DONE		0
>+
> static void test_stream_connection_reset(const struct test_opts *opts)
> {
> 	union {
>@@ -1474,6 +1478,49 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
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
>+static void test_stream_leak_acceptq_client(const struct test_opts *opts)
>+{
>+	time_t tout;
>+	int fd;
>+
>+	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		control_writeulong(CONTROL_CONTINUE);
>+
>+		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+		if (fd >= 0)
>+			close(fd);
>+	} while (current_nsec() < tout);
>+
>+	control_writeulong(CONTROL_DONE);
>+}
>+
>+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
>+static void test_stream_leak_acceptq_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	while (control_readulong() == CONTROL_CONTINUE) {
>+		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+		control_writeln("LISTENING");
>+		close(fd);
>+	}
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1604,6 +1651,11 @@ static struct test_case test_cases[] = {
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


