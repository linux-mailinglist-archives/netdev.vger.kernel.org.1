Return-Path: <netdev+bounces-177768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D23A71A64
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ADD16D59B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB55D14A4C6;
	Wed, 26 Mar 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYwCYMlN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E941F1908
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003157; cv=none; b=aZD1vS/x/T2pU98VFH12p6/+EUxXHiMA7HvUyAM41lz103xv5m5KVsGB3w2SxTUm0Q/jbrdjLPgfKOG+9cqvyCyM2TMMsrPTWPcpM3xjIJYW081xfiwUcbUh0NOjrcr2PIsPUa9uPYJ4lO5WpQQeDT8wqxPgGFkLhXDQQiMIgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003157; c=relaxed/simple;
	bh=3FJc+P6b3zzJcpkV8eK+FP3TgtJw7jYvpWP0TF2ajgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGhAMtOx05gMB99Jtt8AbOZMn/q1bIyig6oBUhnswEnVlToc8b0G+/iwg2jQvnVibANzxrt6yJEXvomN/5VsCLB0xfACxBDqQu/q2JP3kNw8hb+m1KnC0Bs5fRCvyXFqDWqKlsrbZ9M7M9/rzAXzewfoQBecf/7NMJeXdSWo2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYwCYMlN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743003155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cy6PJe0sMeoJhLcbhlkwSjbydSqh6/me/pxc/YeYWRY=;
	b=PYwCYMlNa2gUVWUpZBBnOdejJKr6eUC1GhpL/9hnl8LmwY19s8uT+ZuANKUw3qX4gbtngS
	r4EqFwmsTE6BpYQtEyMwfHsHKJq0Pkc9czJc/XcTCcvwedP0huMh5GqpokLS3ITpRda4PG
	cHTyc2FcqWCONss+zdDpahF+oozWyTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-IEESHenhNsaubjGVFi6-Eg-1; Wed, 26 Mar 2025 11:32:33 -0400
X-MC-Unique: IEESHenhNsaubjGVFi6-Eg-1
X-Mimecast-MFC-AGG-ID: IEESHenhNsaubjGVFi6-Eg_1743003152
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d01024089so51731035e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003152; x=1743607952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy6PJe0sMeoJhLcbhlkwSjbydSqh6/me/pxc/YeYWRY=;
        b=oi1zIUy69SntJ13XpUlLw7gE8bS3R/GNKrcfAxfPvZ5HxX6aRjx+77o0wRB82B4z47
         Jm3YYg9H9Kf0F2NIIFd9QzWBeoyK8yLKumlbHCa46iZk6o++KPz4AJqiasEyeOE8BAR8
         WabFSGJlmB/z8AagAszywTRmEs6x8XFntDvQ8vcPktIUtsGWfdviRi+K/cT3ezPTLlbJ
         7MC1/rePN1fB1Jhiql5glJUJCROkqD7DCeaFev46OD1VdKB5yCTGHB0wkXm1ZUJkn5fv
         zA4PlNq9jJ/b0aUrseLbMhaJClqz3Ocvh6VvPR556kjkBOTNUvHcyhDG1qoGFImWIm81
         noKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbFHv1EGZn4jfTKioKtjAv26AzamYBAfxOGad+AwlTQGMXTWR4QnclqFFGeLy7vkHJgbvD73w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYf+YioXy7TSJbO79VL8jkYoNp9jAN2NziDS+9qtWYYSvKv6d1
	SIgX16fUJjxtNzmO4bjbv0nXWy6k3dPlTDC4kR+NWoFqRYjWf06sL51X0pTI8gMAlYtK0ggLakV
	SYM3efl0pvLprYvyuL7a/jMBI3OlxC6mrWCEGJap1q6FMSI82PecU5g==
X-Gm-Gg: ASbGncvlg9Gv/yA61MQbD6d2cWk2NY8k5aQMMd8q25tK4xdIu7mbpu4Dg15++5gTR8P
	RYVzxLbHOe4i29yo7A3OrvJUna8aYFHoKbe3+QLbG7377dQvL2DySaYSwsH7F2ahU50pDbUifgF
	/rOLMlypSMC7gyoMEv8ZwYf95kbNGQTy8sq1JMEPC+Bu8b9RtaJSwpwmRsnhNmvonSNoM4wXGfz
	RgvCmIaRUQbjLSLrY1dsqw3/vqsYr9QibFEJ2oGMP4kXg643kfTfHiXX1fig+iVMaaqqXV9Ulry
	2z7EBN3fYLhY/MR4iLCILZzQq11SAO1NRnJQat4upVGQ7BBsjpE/DEV8sFelYtvA
X-Received: by 2002:a05:600c:3d93:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d58db553amr142517315e9.12.1743003152357;
        Wed, 26 Mar 2025 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRLuNTDcftGdYLrF6TRN76YPNKGjROf60zN8Q6h9HxP9LzdIxTJHT5qWOkTTFeksKVqeo81g==
X-Received: by 2002:a05:600c:3d93:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d58db553amr142517035e9.12.1743003151832;
        Wed, 26 Mar 2025 08:32:31 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e834a5sm5891945e9.13.2025.03.26.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:32:30 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:32:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <7ursz6zrffsljkvo25qvgaa5vroflpibtrgnz446ga36kzqtfc@l7v62brwdvod>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
 <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>

On Wed, Mar 26, 2025 at 04:14:20PM +0100, Luigi Leonardi wrote:
>Hi Michal,
>
>On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>>On 3/14/25 10:27, Luigi Leonardi wrote:
>>>Add a new test to ensure that when the transport changes a null pointer
>>>dereference does not occur[1].
>>>
>>>Note that this test does not fail, but it may hang on the client side if
>>>it triggers a kernel oops.
>>>
>>>This works by creating a socket, trying to connect to a server, and then
>>>executing a second connect operation on the same socket but to a
>>>different CID (0). This triggers a transport change. If the connect
>>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>
>>Just to be clear: that's the splat, right?
>>
>>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>Workqueue: vsock-loopback vsock_loopback_work
>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>Call Trace:
>>virtio_transport_do_close+0x68/0x1a0
>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>vsock_loopback_work+0x27d/0x3f0
>>process_one_work+0x846/0x1420
>>worker_thread+0x5b3/0xf80
>>kthread+0x35a/0x700
>>ret_from_fork+0x2d/0x70
>>ret_from_fork_asm+0x1a/0x30
>>
>
>Yep! I'll add it to the commit message in v3.
>>>...
>>>+static void test_stream_transport_change_client(const struct test_opts *opts)
>>>+{
>>>+	__sighandler_t old_handler;
>>>+	pid_t pid = getpid();
>>>+	pthread_t thread_id;
>>>+	time_t tout;
>>>+
>>>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>>>+	if (old_handler == SIG_ERR) {
>>>+		perror("signal");
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>>>+		perror("pthread_create");
>>
>>Does pthread_create() set errno on failure?
>It does not, very good catch!
>>
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>>
>>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
>Yeah it's probably excessive. I used because it's the default timeout 
>value.

Please define a new macro with less time, something like we did with
ACCEPTQ_LEAK_RACE_TIMEOUT.

Thanks,
Stefano


