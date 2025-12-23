Return-Path: <netdev+bounces-245833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AECD8CB5
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C89EB300A29E
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B19430E836;
	Tue, 23 Dec 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlA+Ryqw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/GTEssy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC02BEC43
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485667; cv=none; b=Aquhcd+XQtHTyO81EMmfD2FoOKvsW5CcYd7sWfcdAu4+dtl1IYQBdBRxhQL1NSvIAUzrsE72VAko1PtQsFIbxwJ1bgDylNTD+3eyohqQMe02q3GkYRAw3X8oQevE508Cxv8R4pV7KGkc24gE6HR0DKcbkaWiu+xsz10VqC7tPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485667; c=relaxed/simple;
	bh=9E1dhQvW0zJvMjo+SEKbX4bLuVFOxDgDELOrkB3nh+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3WY6EBg7YqYWFUNGyk89NGhunYn6Cno6fkdnara4A1J4Qgc4agDvY1RO2YQWEHObptGS7mwQIjgHzT/bLJNGDiwLmZcI9gvKTo+0cA9goMMOCM4BEfYEAwlgL/7whuo8TWm25YUT12OjE8u+ESedd9WQx5DMllpU6rcMlOa92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlA+Ryqw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/GTEssy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766485664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuSneQFcRp+xpxbp1diVmYhq/nUgwmScL4d+4Vec74k=;
	b=WlA+RyqwDP2NSVez59G4Xv8YNHakXa3DE0/NKTD2/MBS5trP0g7THbYtqJPP2T57Pl+BCy
	aI8GMognPx/KOaLf9MWoe08p/ThED8zpfkLbUAnATYBhPcBM//CL/nycz3MT+Bpw21xNGN
	BWGpfPyghxsyn2BYpOhTE2mFd7U6PXY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-82O3hbWROfWmiJnKBJk9xQ-1; Tue, 23 Dec 2025 05:27:43 -0500
X-MC-Unique: 82O3hbWROfWmiJnKBJk9xQ-1
X-Mimecast-MFC-AGG-ID: 82O3hbWROfWmiJnKBJk9xQ_1766485662
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776079ada3so48091335e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766485662; x=1767090462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuSneQFcRp+xpxbp1diVmYhq/nUgwmScL4d+4Vec74k=;
        b=a/GTEssyOXomAZoxBy4gAGdcKgOGUqISDskjqaiNBpOA+pSA3JDWGrodVkYPY8lTRd
         Er+hmiX2XA7G8VastBvY0HohWLbYR5y3og+6W57rrkYXQ62dPbiixYUzZEXaJ25KhLgV
         8QTXr9W6gPZz7Som3ypUaWivBPyOhBVMWbxAeI8jgalT+Kr4G2ZrZgGc6wOJvNtdCR5h
         +f4nVJmQbBn+jtDk5L8MLqM+a1U/SM/ZNRSTT9xhqBjrQ47PrmubpLDfvEF9cnvRNfye
         pOmgPpgyYrYa5/MGrmkFpdkJ0GspRJ2dHBbq20QrGxeRukMg7kvIaMx39QyiDZjakLiG
         8eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485662; x=1767090462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuSneQFcRp+xpxbp1diVmYhq/nUgwmScL4d+4Vec74k=;
        b=ku6qDTzU55t1TI9zsMULe2MGJ9fQnLOm/WqrXsU4dwBGTlP8yO7faYTMZ8kOlnMoQm
         J8n9nmrly22IeidBZ5YkqAVxuUO6pQU+5W/FMO2lKWNjGx3VAu08dJ1sqIi3cgI0p5Ub
         k4LFZ5DuITPfbOhfyt2OpnZZcDgakI82Z3CScLgJV9dl+wznaEPoJwxGDRO9xWfHTrVA
         F7wdVTeM0+hGPf5+ymGmcN8fgvSU1uowl3lVIm6rd+tIG7l0YWFSqGcUWojX0/LAYrZ5
         Qj8eOhf3v58aKdpENmZdYcX9BsqE/W1Gk4yMZ1Xb4mWmFiQITe5dGZQVa9EUNnRFjqpv
         JChw==
X-Forwarded-Encrypted: i=1; AJvYcCVPyy430hb5HPJmKcIXPd9RpwIe8Et/+diIvEDLjDQvclWIEwD8p3OZHVB+Ekv/Blyzcwyom4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2n1sN+gKDV4KePT6MmNSkWYH7LR6EnKBQunYfVXOIyOC0hS6V
	kp9kqfIYrAOKUP4BknMOQ5KwYxIS8LMh751hu/SsffInUlNkkNLCn8+78ABD+WNPEozVm7OIRKc
	3IxP92Gj2NG9aJ8jSGI0BKTbIZEj1/UnBvgO21cd+LGkFFwx3GpaaXdEtjA==
X-Gm-Gg: AY/fxX6Yd70g+Un12aV3Qv1qW1q/NxO2UMFoT9UY2Dxx1nj34hzbZgviq8KdjCtAw+7
	wQgJntiXkPivQmKEuC0ARfZCQKaUZI//HngyVxN0RdWJs5zItsRs9qw1TE91iQsAT0hK5K3A7TO
	5MzkUEJMVbV6ZFftvEhqFaejd+3KoOebHJTQCMvH40h3oMWmzSBMFP2XPpt7q1AnfC2doSwhbBj
	+itouU9Pt1psFybrDkbQB1xigZP/FgMaRcbZfZ41880QAGCKRvWhkCakaHgQXKak62ORAlKhclA
	cutsGA5RF1y11V9LhAEqBwnfcPS33Vyd+XOnCZ54PJMX6oaUMh8+WMkbv7MYgvm3aNNnUzOki2G
	9V0lcte/nNE7OPQ==
X-Received: by 2002:a05:600c:3b0d:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47d20021316mr130186865e9.23.1766485661950;
        Tue, 23 Dec 2025 02:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAU8P34Cgza55aRvc7Wpg5XlBwMBb9w2I/Kua/0BmNl7IFw3gXWjgeX8hANngFkh4wwllVpg==
X-Received: by 2002:a05:600c:3b0d:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47d20021316mr130186655e9.23.1766485661549;
        Tue, 23 Dec 2025 02:27:41 -0800 (PST)
Received: from sgarzare-redhat ([139.47.16.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm230722985e9.2.2025.12.23.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:27:41 -0800 (PST)
Date: Tue, 23 Dec 2025 11:27:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUpualKwJbT9W1ia@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>

On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>handled by vsock's implementation.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9e1250790f33..8ec8f0844e22 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
>+static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);

This test is passing on my env also without the patch applied.

Is that expected?

Thanks,
Stefano

>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -2371,6 +2399,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unread_bytes_client,
> 		.run_server = test_seqpacket_unread_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM accept()ed socket custom setsockopt()",
>+		.run_client = test_stream_accepted_setsockopt_client,
>+		.run_server = test_stream_accepted_setsockopt_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.52.0
>


