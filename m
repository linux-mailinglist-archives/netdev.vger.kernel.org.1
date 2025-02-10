Return-Path: <netdev+bounces-164641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0FA2E93B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694D07A3386
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DC1E0B66;
	Mon, 10 Feb 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm+DtC/f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A31E04BE
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182866; cv=none; b=ay3SYppLPK3P6MOip9KBFDUlX4IorR92ZnTVBliK9DghoHZtl/0HZ63nNI62jW322eoWZq1BWn33StgtasmJJp2B/b/apEoyaKKAp2hXMpUhc+vhOnZLh9f7ks7mAE/wdoH2edGYfSu0tXzPHvNJXVINBDfNG/UuNpAVtQ9XcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182866; c=relaxed/simple;
	bh=SjxpoViRRUJMYf5HMy2R9EEQje7spE+QwEA9cDQhYV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ00TRnYst6l2bDoito1VeCl3k8KWP8zi2YCak/aYhBPzwJ8Y+4Ru9sbsIM2fXWjNSexBWVK0JEaDO9s6ILDwbspSjJf3rQeNyttaTrmV+iS1B0RGqC9D2bBZk3WPS715rWVLOc6nl77cB/ud6ZixLOZZDEwP66PSep6N7o5QA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mm+DtC/f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739182862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcc7oTQuTQ+nV5fDZHirwJ8W3b89Pi6Do8TO5JtQzXY=;
	b=Mm+DtC/fOorRRcb4VfmIZT0v08eGLSLOo+rlFbOm7/P8FQJ/NCwgK+ykw5NCz9JHzjf8pd
	XjtmDAWR+/EOPDTv8CAcl8+rivnzilC3/KqyPKV2eTfh+ehRJhDEOo1GuuDHX+Yh4XTMvX
	jsWYN6jiKIi7VqDVa35D2l27I4nD1BU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-2lxnfgZjMzmx-HS49nS9Rg-1; Mon, 10 Feb 2025 05:21:01 -0500
X-MC-Unique: 2lxnfgZjMzmx-HS49nS9Rg-1
X-Mimecast-MFC-AGG-ID: 2lxnfgZjMzmx-HS49nS9Rg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dd533dad0so992646f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739182860; x=1739787660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcc7oTQuTQ+nV5fDZHirwJ8W3b89Pi6Do8TO5JtQzXY=;
        b=J2+jieKFrGfeH+ClwcvXmCkb23SLbBflPSsXUOicPL/MrSeFEArZkWz9K0tDbXpevS
         uU+r3MizISxRYKxSL15JMpG4FMr0nPB4GV3Bs6hU9uwxiif7Z5IIyfNJGrilHh4Q3JeD
         fz8VfRtipSWQkMXRWay57GuiewnUpRLp9JbZo0XB7cTzuj8ROoZER2fa1u3xD1CpAfg7
         Vt/0j9Q32L18I8/zD2ov2fXOBzzJCQmPYo5g/OncQbHzh3c4ZlDuPxbsyb43LdyzJ3Lz
         UFyqdON1ZqkY+hT5HAIzn5THBcxmJzODg+W8Y5/JVd3WpmKNkJEVr6C87A6Npo08LcvB
         EBZw==
X-Forwarded-Encrypted: i=1; AJvYcCXYYSjK0jl8T0QZyPecUZ6qTyt3UluvBhDWutwoAU1BPmbqhYs+CzoV0dVc1hJHvetTwFi/4p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lwbF+xF634hYx8msE++9pkAqkcchJ9bwZoXqW374PEG+MAAn
	R4bcSywHyHdSSOXEM8vn4hQUKnEjPebkULYQECvgWBrnGL0US2tG0L5zQBl4zh1/3fO0Onb1lSm
	vNDdZuJcweJUuVYMQ8aqeqfAFVjKtbrZEb0ade8Q5+Ru/+3lE4cnTDA==
X-Gm-Gg: ASbGncuk5F2OaP876Y8B+COOvz+zJayFbWMy9XpFmAiuKhXwmwkCnCqR7v3o7k0Xgr2
	k1j5Bqmol+G775DqYHL6EJhX+PSmcSjvj4Jgo9ybRAyff8uv1EOiy3RwBfUj2vB63XsEB0W4fdc
	Hsapm4ipY6o9deotdtPVfiZetMVTomyn+c8qAvZ6qxfz4rmVlSi68dLquIp2kePKKhsw5g+e8Cj
	PbizV89F67E1VzW0qsfpC1yI1ltEXOFEUN/A4m9xYRcoKyTdjYIN/tGGshThLLTUqrnPeYApRE2
	KO9Cif4i7doQQpVCK5W0Zvg9rV0fAAiulhotQM2skSGvTQEwJoEOPA==
X-Received: by 2002:a05:6000:1f84:b0:38d:caf1:41b8 with SMTP id ffacd0b85a97d-38dcaf14441mr9077695f8f.39.1739182859954;
        Mon, 10 Feb 2025 02:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmjXX8GoNn0vwO6RsrfVCcVr00Q6EZB4atQh0jOxGjhyit3nNGsDQXvL/8qDaU0AwyNh8ifw==
X-Received: by 2002:a05:6000:1f84:b0:38d:caf1:41b8 with SMTP id ffacd0b85a97d-38dcaf14441mr9077649f8f.39.1739182859367;
        Mon, 10 Feb 2025 02:20:59 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc2f6aeafsm10789246f8f.20.2025.02.10.02.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:20:58 -0800 (PST)
Date: Mon, 10 Feb 2025 11:20:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: Add test for SO_LINGER null ptr
 deref
Message-ID: <s4jllsolwiqdd4uwgytb2zbofnaujh34bhwrtaikup75zoqrko@uds74ecujnh3>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
 <20250206-vsock-linger-nullderef-v2-2-f8a1f19146f8@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250206-vsock-linger-nullderef-v2-2-f8a1f19146f8@rbox.co>

On Thu, Feb 06, 2025 at 12:06:48AM +0100, Michal Luczaj wrote:
>Explicitly close() a TCP_ESTABLISHED (connectible) socket with SO_LINGER
>enabled.
>
>As for now, test does not verify if close() actually lingers.
>On an unpatched machine, may trigger a null pointer dereference.
>
>Tested-by: Luigi Leonardi <leonardi@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index dfff8b288265f96b602cb1bfa0e6dce02f114222..d0f6d253ac72d08a957cb81a3c38fcc72bec5a53 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1788,6 +1788,42 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_linger_client(const struct test_opts *opts)
>+{
>+	struct linger optval = {
>+		.l_onoff = 1,
>+		.l_linger = 1
>+	};
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>+		perror("setsockopt(SO_LINGER)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_linger_server(const struct test_opts *opts)
>+{
>+	int fd;
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
>@@ -1943,6 +1979,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_connect_retry_client,
> 		.run_server = test_stream_connect_retry_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SO_LINGER null-ptr-deref",
>+		.run_client = test_stream_linger_client,
>+		.run_server = test_stream_linger_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.48.1
>


