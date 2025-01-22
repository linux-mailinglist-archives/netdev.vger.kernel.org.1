Return-Path: <netdev+bounces-160259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E3A190CD
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F93916654C
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43229211A2D;
	Wed, 22 Jan 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7vdHzZ6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F4211A2B
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546235; cv=none; b=igc7lfP9wpRycV89s9CrZKor36uZrxDQ2vsstjwkYeo+sLwL84QEK3FI3bXXZImL40Zv2TNvyo+QJVWtjGA9d6hNEzK5daTHpxRaaYPX2k3GneQmXlNf5SAxFFi0EMsS7Jtvhz3dZ5BUpkhRFpeTX6DGuqTEkoZn1UDVx9qnsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546235; c=relaxed/simple;
	bh=+WABAN42cPe6CE3ahwbtWQawMshZCG9DUOh7DpkkWRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiLoWDj0RmVZNU2laL2591dJUCjGFWAhVp82xzZpkYvxOr3znV5HEWAMLjUKjraWRwc0uprf/xk/dtV9+D7rGepNNpyVM2RWW5y66z4nKvCkylWZ0mNYO00gexV+Grnc6VfZw0QuKvEl0uFUt/IkoLhB1W50woqyaZa8W7i2aLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7vdHzZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737546232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BMBAtK0qTBFIXsxNbc4WpzAVAP8FF0A8mOF3NQu5io=;
	b=H7vdHzZ6qYh50mWSD6pnwxEV25dGK3Rf8twdKQX8CScNSSGTTcAniWnCxlE57bZpGrHPwH
	YTfeSuVYd3OBp1kZnDPb5qVPXDKEzYgvTuYf3yoSzJwsxnsngFBy51eBIIkP36NKWV0oBB
	LFCcSHJGsGN6x4Wcffz44XTh32fpIZ0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ehwTXU9YNdigEmSmkbWT2g-1; Wed, 22 Jan 2025 06:43:51 -0500
X-MC-Unique: ehwTXU9YNdigEmSmkbWT2g-1
X-Mimecast-MFC-AGG-ID: ehwTXU9YNdigEmSmkbWT2g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso538172266b.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 03:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546230; x=1738151030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BMBAtK0qTBFIXsxNbc4WpzAVAP8FF0A8mOF3NQu5io=;
        b=JKMPtdxDd5SoLjZFStXyfRNHRrqj3+aJBb1k/G4+tm+1fXR6ZB9BYv2Fv7eXTOX8gB
         VHuGYl4pbjNt/vMLkcRGAYW79hinJJw56mw435otDIaNwbMMhmKcWKIM1lP4LfftO3Au
         RC9ThXZo/xPXlQQCAMZ7GrtwJNOArVfxYj7jKppfLFcf+OKqpADDyuy0FOFgzZbSSLgh
         K+J0jWjmyDxxpIGFeZT0xPSOK07ac9PkG5qEgUj51QASHUpmVXOzUflZk2OqAyke8inu
         X033S25R9HzU9aHK4/bkBMuqRH//mqzBgSM+l1jFX903LnpkS+SjW01XuG9g/5but88j
         BMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5c13kDzpZfiqdLjIet9fqsHkXUpBGxIJ5xEAteR1SyQEjumnsAmGV0ol3dZxj/oZO+ZdDutA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhCmmJ0f6Z8HIRTbYMqXlHFsi6d7FQdp1gsY+Z9TnUAwotNN6
	PH1GhUBktfYgxYW/u+fN8CvoszumPOhjAomRrSejrl4basK5a9tFKlOeCr6RCzz8DdFevOheYYU
	HxbwuYloyPLr1GVoJ3BfnOVz2rWzuM1PWDTpNgj+drNaby0HGN6fZrg==
X-Gm-Gg: ASbGncu/e44Rg8Clf3HGLH9ZIsdZBKj/GN6wOBaD+CYQyikr9lhvagmQ2F7Uqew0wDm
	wG+cJGgdx2VZtwqNfQ8HDe1g2OZqLfLCIelUs6acmymYzIOnPu0STQ+2aDx76KNThfq65dUB+9G
	xwOzpq+gv+MVoZqTgslHW4F51JKLsnZr4KGqrSMNI01JYM0zR8OFQUUzJyYgT/H2/Zm4gPNlo1J
	auqvj6r6UYD+P2B4ZCD9mnOaJCSsNlYsOrKA8GW+XD9lfxJ9FmWtebs3veVl0OjTjyMXNQdW3NH
	zqo1eNMElYPT7wvHRBmyy+i8V0GDB9Vs8w9WeW3y5j9+uA==
X-Received: by 2002:a50:d6ce:0:b0:5d9:ae5:8318 with SMTP id 4fb4d7f45d1cf-5db7db07819mr39430195a12.20.1737546229884;
        Wed, 22 Jan 2025 03:43:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbphm4Qz+Xqk+jlijqtsT+D+4fAcSofzZWdF2ELeQpBKsfXSi+RUuyGf9a2KCqbEX4Z31nAw==
X-Received: by 2002:a50:d6ce:0:b0:5d9:ae5:8318 with SMTP id 4fb4d7f45d1cf-5db7db07819mr39430133a12.20.1737546229153;
        Wed, 22 Jan 2025 03:43:49 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1f1asm909040366b.58.2025.01.22.03.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:43:48 -0800 (PST)
Date: Wed, 22 Jan 2025 12:43:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 6/6] vsock/test: Add test for connect() retries
Message-ID: <zhumazwpah2rx3ipcofjf7xibeoyo5b753poibz4tthcqstage@6e7b2krjplt7>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-6-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-6-aad6069a4e8c@rbox.co>

On Tue, Jan 21, 2025 at 03:44:07PM +0100, Michal Luczaj wrote:
>Deliberately fail a connect() attempt; expect error. Then verify that
>subsequent attempt (using the same socket) can still succeed, rather than
>fail outright.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 47 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 572e0fd3e5a841f846fb304a24192f63d57ec052..5cac08d909fe495aec5ddc9f3779432f9e0dc2b8 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1511,6 +1511,48 @@ static void test_stream_transport_uaf_server(const struct test_opts *opts)
> 	control_expectln("DONE");
> }
>
>+static void test_stream_connect_retry_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!vsock_connect_fd(fd, opts->peer_cid, opts->peer_port)) {
>+		fprintf(stderr, "Unexpected connect() #1 success\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("LISTEN");
>+	control_expectln("LISTENING");
>+
>+	if (vsock_connect_fd(fd, opts->peer_cid, opts->peer_port)) {
>+		perror("connect() #2");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_connect_retry_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	control_expectln("LISTEN");
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1646,6 +1688,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_transport_uaf_client,
> 		.run_server = test_stream_transport_uaf_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM retry failed connect()",
>+		.run_client = test_stream_connect_retry_client,
>+		.run_server = test_stream_connect_retry_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.48.1
>


