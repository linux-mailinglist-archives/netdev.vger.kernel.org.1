Return-Path: <netdev+bounces-160349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47127A1957B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F215160509
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E72147E5;
	Wed, 22 Jan 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdoS7R+5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D064213E61
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560400; cv=none; b=RqiaBeKzOb8idkwBAhXAFEUR1SWu6Il5oiohid0QQ3T3YNt8F6Cnan5yOt1fUzMJUEH5RPrlGHOBSzAU5I8/Ie0vXH1c8oNORo2iAivOuchfq/CGFw6cIKGHp0FXhh1A71/CfhgMK09W8ErK/ZfSnK6tk/qSRRTnWxKtLDBWK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560400; c=relaxed/simple;
	bh=KahofyBUmQUWSqtvKwhK/H/fViMFjZ3gem6jPBnmB/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JODQqTGT9GQTB8SA4E3ZhvBIPP804ux4EheRSOw7N9O8JY06yNesWKwCYZr30IZBZ5wkUA5qD7jyfprUZV/zRdPMKH9MrLNAZhylO7BHbowqtTt4tbdvLqo7TquhVicuCqAsJdvg2UNVm/PjHKIHHNlOZOUAEbd9irQf3ciLqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdoS7R+5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737560398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMXPAh3AQ7BUMaH00BcOjWybJJGK7Ux2ciO3ww+bOCU=;
	b=DdoS7R+5t6D/B8HhoqJ8b4Wy2QCVCbELMhvvqx/w9DjrnHY1AnCvbPAYElKSf764DXD/t3
	KLr0MHTqFwVF0kRvzqvEJGRGdiUeoBSNq+gh6OyprXwADTtbNe3IqQj01qlJufOqJWD/Wk
	JNkpvUFUkJi5C4t1BMrVahfzd/hpb7o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-d01ZEpXeNQ-s8QWdGzZOxw-1; Wed, 22 Jan 2025 10:39:56 -0500
X-MC-Unique: d01ZEpXeNQ-s8QWdGzZOxw-1
X-Mimecast-MFC-AGG-ID: d01ZEpXeNQ-s8QWdGzZOxw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6df9ac8dcbeso238170396d6.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 07:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737560396; x=1738165196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMXPAh3AQ7BUMaH00BcOjWybJJGK7Ux2ciO3ww+bOCU=;
        b=nAvE7hxBn/caTR5F2obdQm3ZCOZrNNHbgMiUcit4sjAy0wiioTb60LhH3m0GHbv9gW
         8qsLuOqCa7Ct9S0MpzB6E++mARNXv+CLu+Oh3y6ijsn9/zlA0LT7fzHUOqgs0uiMFoxQ
         Sux+IEYdFJ/Z3x7K9GGTs9akq1so4sDpNRl2cFnyLua8iRojcKOZOq0JYAvpWk/sbvRx
         H4sQXQJ8lXpUYneDdBhpKaRYEJwnpdy7txrKSP6HZQQiSOy4IvtyF/Kx26SkcGZaZ4Al
         Yc04TV6S6f4VdCQYpJdLk75J14vO1S0n/h7rIByA8FW6S+WXJEpQoxh694UfLbFHMgMW
         K/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCW8OueJncbzCwrpM2PiB18g0MWlg3AeKbw8qDzKaiRGa3IjcM4gAcPXloDIb21VAzWjob9MghY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAOsB8GxKZ7KrCNgNYqrNtkcXQp0mJTOF4rYLHRDVYNG0sQCy3
	b8yXCaQArPt6fHANA/df1pMhVxJ0EoQhtdvbv9a8XDDAQ/Yv1Qpo+BAPmTRwKj5K/6a25qjJ1T2
	eLXi4E+B2aNjxj91LQM6dIri9zv1tlp8PcLP9J3y7hSAM8rnUKGjbDA==
X-Gm-Gg: ASbGnculFGGkqi/5Ws9EFIeVXvoag0M1X20YiLoWJ73yB75wWsBFaR4oNxZrjNg0hFG
	+WErBdzBFprXIDydynEoS4xLNetJQ340PwCRN2900h63x7hHCbQRAWTl+L09J8o4MzPUERSGWGg
	BcgfQckJIVpRqGYZiAEu6h+FZiFaZrM2DxhbSaw0KR0c5gI6NnRSPTa9igcpyuwunQKOCrqT3OZ
	Z4lQ+H4IniC9PmagZu+SjWwenzjO4YzejH88bAV/yOYZCgDoPDiCT/Mi3/I3LW2Mw3OZjLb3A==
X-Received: by 2002:ad4:5c68:0:b0:6d8:aba8:8393 with SMTP id 6a1803df08f44-6e1b2235c2bmr310013196d6.44.1737560396194;
        Wed, 22 Jan 2025 07:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjaHQr4gmuDD6lGt7CG9FrPQPtVMjVIOGAE+c//0BEcZHOt2V3+4GXT08m5aKyQumw/kwTaQ==
X-Received: by 2002:ad4:5c68:0:b0:6d8:aba8:8393 with SMTP id 6a1803df08f44-6e1b2235c2bmr310012996d6.44.1737560395962;
        Wed, 22 Jan 2025 07:39:55 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcf6d50sm61967926d6.116.2025.01.22.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:39:55 -0800 (PST)
Date: Wed, 22 Jan 2025 16:39:51 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 6/6] vsock/test: Add test for connect() retries
Message-ID: <i7a2alvtk5v2s3zgui3alv5dta34erwpwj44rdz5moulmc7iud@i4w7l3cinltl>
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

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


