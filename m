Return-Path: <netdev+bounces-162455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83EA26F83
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9D07A4CCC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C420A5DF;
	Tue,  4 Feb 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU9XRue2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC642207A3D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666105; cv=none; b=SYMYtSy16B1jqKW56CBbJTuy9r9TIxpUedJta5hJeFeYkjdqrYf44yqQ2ZoPZxfacqGHzU3XdWxi4xxZYxBg8C2LENmwxT2NoTG1X7NF47bSCCwrDuJQi2WtbBf4vy0iwgzGjPGK6GhdTjK1pdgl78RLzsFxhCQxKezEX3qsqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666105; c=relaxed/simple;
	bh=cyGA33b/NdQQJBtf58IVwfYJrY9Eyjgi4QS9AJOKhwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Czx7NEEZZzJp+ZL6OZLvE4NX7HIPQWrwR8iWiSvGFbRtNUhW5DDBbQFk04SFUS1ZRAfVfOMZqWqWwI9nqIgXX6qxDbqJSx2jEPMcOSEW3oNFmY2Xdy7H0oeubO4ZD6DZk9ZKycCloc03GO5TQgwRHKm/fSj5wLfPZJi7NDG+TD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MU9XRue2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738666102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib9GdMMM92Kn1QwpmqHFt1fIzd+JK71nD5JxBqISYE0=;
	b=MU9XRue2rHRGb1RVdaQmKTBjvKsc/SvczJaD113U71PyoVIpoxe3XGfjrPVJisodURWQeu
	JxCmpZMWgC+C4EqoXZGXLzB2rP/kGGNEyrBCTMHOUjbgxu5sJXtLtPjV/m6/zSGFuGypt8
	QNnblKVXuKyjVPK20Ui0OgeQOr5mX+I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-BxTjJFM4O1aoMXWlQW9Ssw-1; Tue, 04 Feb 2025 05:48:20 -0500
X-MC-Unique: BxTjJFM4O1aoMXWlQW9Ssw-1
X-Mimecast-MFC-AGG-ID: BxTjJFM4O1aoMXWlQW9Ssw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6f2515eb3so532559585a.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 02:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666100; x=1739270900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib9GdMMM92Kn1QwpmqHFt1fIzd+JK71nD5JxBqISYE0=;
        b=Zc4GcYDYIgbsquTqBw8eDJGp/T2RliizpzO7Te5qrNLxX2SjD/kZcHZGJ/DQV3wego
         /qY80dLA7Eb7HQQFAES5e3FSLEcERXY6Tesq5ALjwMHuCUScq/A6xqcE0eBZkJbRqhdD
         Ws9ESMooYlbbNN1wGEwEaPUThZEWQCTiZ3vy7MO5uiNuH7x7/yLkUbrUP1gOlV3Tvm6f
         +wd6pJqv2JyZhtdl3PD1baUSS8R5Xoo6dwLFsysHx05UvGtG33griLBKM9s2LPbpsNpQ
         JjTpEiBJpRBCmPSTQ22TAVPNsRj2g0SQWfPHtpg0xzjmcJ9I0Oz2ugQfxovJ/Se24ZgG
         XdXA==
X-Forwarded-Encrypted: i=1; AJvYcCXIFdux60dUIb6gRjsG9E4G6IsiDEln8AtK753BbOTTtqT8Qsu1xTOwZx56ELGL6AGi3TZzwto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsYOCYFOpQz3LfRWJi76hXMGBOgjQ8cbMW6mMxpDebE+yo22m
	2hsZc8MW1A3bzneXc7fa/vFAh/k/iIgOvBWOkXCfz5uJmtvi81fRE1Ry++KrvBPTlnNt/a0dwl8
	y/PHT7YlYPlEnby/ChM8KDnkneRMX03mtOhaozycmQ5lncey1c9n6pw==
X-Gm-Gg: ASbGncuy4P10/CaGk3AUOlUCh9+kAKDEE1r4Vi41+OhqcI8NERIUhjufA1a/PPe6eAK
	HhgAYD0CEsKm7TTxMEgZsKVY20xS8zv77cxvToey1Hu6q8o3DfvcTa6uwv2I/2GosfdnT+n3gS7
	n23QOBqiqjd4nANymePd+5OGKILoL29W5btNpxPofTwWdQFObIPKTjyz6MUwD46ibDIa1MEfthh
	AHnq/4tD7V3ucGv/UDA2ciGGJUzRpfPtza9fJB+Ysc/ete7YMlTlvBG5BBozcmi9Yak/FuYJuaa
	Ll5Kx/L4zQ==
X-Received: by 2002:a05:620a:d85:b0:7b6:dddb:b88 with SMTP id af79cd13be357-7bffcd906a3mr3221739185a.38.1738666100364;
        Tue, 04 Feb 2025 02:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyS4pM3BbTlkiJH2SUxbl7kKmozzkleV4I5y1eWPlp7iuWf7SUwv0O2TYLTNUnXglQInatEg==
X-Received: by 2002:a05:620a:d85:b0:7b6:dddb:b88 with SMTP id af79cd13be357-7bffcd906a3mr3221736885a.38.1738666099958;
        Tue, 04 Feb 2025 02:48:19 -0800 (PST)
Received: from sgarzare-redhat ([185.121.209.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90dd95sm623272985a.112.2025.02.04.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:48:19 -0800 (PST)
Date: Tue, 4 Feb 2025 11:48:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Message-ID: <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>

On Tue, Feb 04, 2025 at 01:29:53AM +0100, Michal Luczaj wrote:
>Explicitly close() a TCP_ESTABLISHED (connectible) socket with SO_LINGER
>enabled. May trigger a null pointer dereference.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)
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

Since we are testing SO_LINGER, will also be nice to check if it's 
working properly, since one of the fixes proposed could break it.

To test, we may set a small SO_VM_SOCKETS_BUFFER_SIZE on the receive 
side and try to send more than that value, obviously without reading 
anything into the receiver, and check that close() here, returns after 
the timeout we set in .l_linger.

Of course, we could also add it later, but while we're at it, it crossed 
my mind.

WDYT?

Thanks,
Stefano

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


