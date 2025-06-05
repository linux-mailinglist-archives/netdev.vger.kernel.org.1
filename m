Return-Path: <netdev+bounces-195222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E337BACEDF8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7673ACA2D
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60556214209;
	Thu,  5 Jun 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3pmxSuV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D94A1A
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120584; cv=none; b=VoKf+oq8wpyI7XTPQWrH8u0kYrxm+8ukawPngK6Y6auSiW7di9wjZudvhC5veBeoneVlKBYooDzYQ74HvLqcvj5+wgSw/M96s0f+LhCp39OpQHVIGNvHt20+NNHLpSm5+FzW+i+mgKHovWNL6cT6P4pUJ9feODuFpY84KEANqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120584; c=relaxed/simple;
	bh=v6xtrxLxYH2hT45AwJwhvKFFiSUu0RR5YURtbwGRkts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmNya/eAsgdTyp7QIPT9wKrtYeb7TafPKpn786/nPxPvasAVpsM0xM4Agg/bLH8nc4O6252uUidUj9sG4rRC1xZN8vXsJk4OBl1ivaBpZ/yQk0M4ZrmufKWg9QxoQfG1KsQln5VNRDZP28OLAQFgcvJGm5p8dsauWdFE4EG4YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3pmxSuV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFCw24n0s12QidmEWqSONjnqNtdgJB5XvQGER4+bs+o=;
	b=J3pmxSuVNbf38IVFexS3ncxv/qwuN4/ASviy7RnisqNJ2gPQPDA5w5OfIptVfVwHNwmFrL
	EHu32n3XOfZa9MCD+x2/EG1vjLxsl9Kwbr56a0167HmbFiimdcoDgamOQw8j+wiG/2MMs+
	lkesWsQCY4tiRuaGxzlf9XQ5gbgUhmo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-3JCYwpisNi-sVLT5a5FTWA-1; Thu, 05 Jun 2025 06:49:39 -0400
X-MC-Unique: 3JCYwpisNi-sVLT5a5FTWA-1
X-Mimecast-MFC-AGG-ID: 3JCYwpisNi-sVLT5a5FTWA_1749120579
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a582e95cf0so7901661cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120579; x=1749725379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFCw24n0s12QidmEWqSONjnqNtdgJB5XvQGER4+bs+o=;
        b=heiq8oRXEJQUo3pGqK46R7OT26Sx3wxdjUfTEb9wEyMXtaWK0AmZ9gg3dSUcZcwEbp
         I2Ofm7Umv0urwOjxDdI3iIdfkLO7ESPP2OrjP6jfJNWdVr7yR+6DwtzrXeVY2C7d9AAl
         whw6hZmJbQFNQasc+xD+YnSzKLaJRnxRMeDs0uniP2mKpHAcnSBW9QDScNOQemPNcO4I
         arn9rqiiE4oYe1IDxKB1gbqvFLZvXmC/g81X4fckFK/aXWrx32bQk5PES5HLp/ltotGa
         TwouMd6QQ6htrGJxz9eNtEuaUQx3oRMC1sw9u4Pz94LZbe0+dtmBklcO6ZIX/ap4HaAH
         YhPA==
X-Forwarded-Encrypted: i=1; AJvYcCUieUgKmS5YXkU523OfEooZ/DTFvkhB8WtxQMqgzqPxhRpBgAsq1ahfvWdRhnFSCIKmB1S5rtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00mbu00zxi054trWy+eUxzlN1mZzVyZ1K/NhbSNatEnNk0lu/
	pOpFz1pYTO7qcpRnxg+0cLJmeuo/0U9XjZi78pU7wq8WE+yy3+SQ/7tXjZmKOUb7Vigwx1bfT+6
	gwpaLi9id235yqpYgAiuud4OcIj6SjX0JNjuLnMKuclxvNVIyDC1aZNXRyQ==
X-Gm-Gg: ASbGncs1kFueckfwK2Hz8t3DR5j1qwyI6kBISNDQ2q/UF9pIMsQwrFZiEu+nX/hgIJ1
	R8uvlw0RCOIwrFuSxKPUhieGQq/JCPExS1SM1gaKpN2QhMuLgwFcCG15oP//yg8TVVSeYLxGdoD
	+JS4h0SbgnOXBWrY7REXPDhOE+HCIGoAU69Hf9UYxoR0jLHBZ8F2cRbH1j/p6Agw+WAG6zDEEtE
	oIN/NpWaGgW5cN6R67w8hv9bvyu/OIEEys4hg9vAQrGJF6YHY/jubomgnl5SHfY3r3kWJRa21M1
	d9wNkVxorFnwSRQ6Jf98+3u/TbOsEFoPWnhOM50J
X-Received: by 2002:a05:622a:1e09:b0:494:7e12:3af1 with SMTP id d75a77b69052e-4a5a57d78c9mr86480651cf.36.1749120579343;
        Thu, 05 Jun 2025 03:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuytOkkTXaF9171ida68ClPpKBp0qePtAr6diOEmKuDIQGiXedMTQ5nJki//BunkRdWpInWg==
X-Received: by 2002:a05:622a:1e09:b0:494:7e12:3af1 with SMTP id d75a77b69052e-4a5a57d78c9mr86480401cf.36.1749120578921;
        Thu, 05 Jun 2025 03:49:38 -0700 (PDT)
Received: from sgarzare-redhat (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a371bcsm109556211cf.52.2025.06.05.03.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:49:38 -0700 (PDT)
Date: Thu, 5 Jun 2025 12:49:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 3/3] vsock/test: Cover more CIDs in
 transport_uaf test
Message-ID: <dth7n7nahmfzbiymldaxmlir64o2ck5iqo2zldppiukfpwdiqh@u6342kxtih4c>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-3-8f655b40d57c@rbox.co>
 <ocuwnpdoo7yxoqiockcs7yopoayg5x4b747ksvy4kmk3ds6lb3@f7zgcx7gigt5>
 <77c48b6d-4539-4d01-bd7f-7b5415b7b995@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <77c48b6d-4539-4d01-bd7f-7b5415b7b995@rbox.co>

On Wed, Jun 04, 2025 at 09:11:33PM +0200, Michal Luczaj wrote:
>On 6/4/25 11:37, Stefano Garzarella wrote:
>> On Wed, May 28, 2025 at 10:44:43PM +0200, Michal Luczaj wrote:
>>> +static bool test_stream_transport_uaf(int cid)
>>> {
>>> 	int sockets[MAX_PORT_RETRIES];
>>> 	struct sockaddr_vm addr;
>>> -	int fd, i, alen;
>>> +	socklen_t alen;
>>> +	int fd, i, c;
>>> +	bool ret;
>>> +
>>> +	/* Probe for a transport by attempting a local CID bind. Unavailable
>>> +	 * transport (or more specifically: an unsupported transport/CID
>>> +	 * combination) results in EADDRNOTAVAIL, other errnos are fatal.
>>> +	 */
>>> +	fd = vsock_bind_try(cid, VMADDR_PORT_ANY, SOCK_STREAM);
>>> +	if (fd < 0) {
>>> +		if (errno != EADDRNOTAVAIL) {
>>> +			perror("Unexpected bind() errno");
>>> +			exit(EXIT_FAILURE);
>>> +		}
>>>
>>> -	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>>> +		return false;
>>> +	}
>>>
>>> 	alen = sizeof(addr);
>>> 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
>>> @@ -1735,38 +1746,73 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>> 		exit(EXIT_FAILURE);
>>> 	}
>>>
>>> +	/* Drain the autobind pool; see __vsock_bind_connectible(). */
>>> 	for (i = 0; i < MAX_PORT_RETRIES; ++i)
>>> -		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
>>> -					SOCK_STREAM);
>>> +		sockets[i] = vsock_bind(cid, ++addr.svm_port, SOCK_STREAM);
>>>
>>> 	close(fd);
>>> -	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>>> +	fd = socket(AF_VSOCK, SOCK_STREAM | SOCK_NONBLOCK, 0);
>>
>> Why we need this change?
>
>It's for the (void)connect() below (not the connect() expecting early
>EADDRNOTAVAIL, the second one). We're not connecting to anything anyway, so
>there's no point entering the main `while (sk->sk_state != TCP_ESTABLISHED`
>loop in vsock_connect().

I see now, please mention it in the commit description or a comment in 
the code (maybe better the latter).

>
>>> 	if (fd < 0) {
>>> 		perror("socket");
>>> 		exit(EXIT_FAILURE);
>>> 	}
>>>
>>> -	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
>>> -		perror("Unexpected connect() #1 success");
>>> +	/* Assign transport, while failing to autobind. Autobind pool was
>>> +	 * drained, so EADDRNOTAVAIL coming from __vsock_bind_connectible() is
>>> +	 * expected.
>>> +	 */
>>> +	addr.svm_port = VMADDR_PORT_ANY;
>
>(Ugh, this line looks useless...)

Yep, agree.

>
>>> +	if (!connect(fd, (struct sockaddr *)&addr, alen)) {
>>> +		fprintf(stderr, "Unexpected connect() success\n");
>>> +		exit(EXIT_FAILURE);
>>> +	} else if (errno == ENODEV) {
>>> +		/* Handle unhappy vhost_vsock */
>>
>> Why it's unhappy? No peer?
>
>It's the case of test_stream_transport_uaf(VMADDR_CID_HOST) when only
>vhost_vsock transport is loaded. Before we even reach (and fail)
>vsock_auto_bind(), vsock_assign_transport() fails earlier: `new_transport`
>gets set to `transport_g2h` (NULL) and then it's `if (!new_transport)
>return -ENODEV`. So the idea was to swallow this errno and let the caller
>report that nothing went through.
>
>I guess we can narrow this down to `if (errno == ENODEV && cid ==
>VMADDR_CID_HOST)`.

I see, yep I agree on this new idea.

>
>>> +		ret = false;
>>> +		goto cleanup;
>>> +	} else if (errno != EADDRNOTAVAIL) {
>>> +		perror("Unexpected connect() errno");
>>> 		exit(EXIT_FAILURE);
>>> 	}
>>>
>>> -	/* Vulnerable system may crash now. */
>>> -	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>>> -		perror("Unexpected connect() #2 success");
>>> -		exit(EXIT_FAILURE);
>>> +	/* Reassign transport, triggering old transport release and
>>> +	 * (potentially) unbinding of an unbound socket.
>>> +	 *
>>> +	 * Vulnerable system may crash now.
>>> +	 */
>>> +	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
>>> +		if (c != cid) {
>>> +			addr.svm_cid = c;
>>> +			(void)connect(fd, (struct sockaddr *)&addr, alen);
>>> +		}
>>> 	}
>>>
>>> +	ret = true;
>>> +cleanup:
>>> 	close(fd);
>>> 	while (i--)
>>> 		close(sockets[i]);
>>>
>>> -	control_writeln("DONE");
>>> +	return ret;
>>> }
>>>
>>> -static void test_stream_transport_uaf_server(const struct test_opts *opts)
>>> +/* Test attempts to trigger a transport release for an unbound socket. This can
>>> + * lead to a reference count mishandling.
>>> + */
>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>> {
>>> -	control_expectln("DONE");
>>> +	bool tested = false;
>>> +	int cid, tr;
>>> +
>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>> +		tested |= test_stream_transport_uaf(cid);
>>> +
>>> +	tr = get_transports();
>>> +	if (!tr)
>>> +		fprintf(stderr, "No transports detected\n");
>>> +	else if (tr == TRANSPORT_VIRTIO)
>>> +		fprintf(stderr, "Setup unsupported: sole virtio transport\n");
>>> +	else if (!tested)
>>> +		fprintf(stderr, "No transports tested\n");
>>> }
>>>
>>> static void test_stream_connect_retry_client(const struct test_opts *opts)
>>> @@ -2034,7 +2080,6 @@ static struct test_case test_cases[] = {
>>> 	{
>>> 		.name = "SOCK_STREAM transport release use-after-free",
>>> 		.run_client = test_stream_transport_uaf_client,
>>> -		.run_server = test_stream_transport_uaf_server,
>>
>> Overall LGTM. I was not able to apply, so I'll test next version.
>
>Bummer, I'll make sure to rebase.

Thanks!
Stefano


