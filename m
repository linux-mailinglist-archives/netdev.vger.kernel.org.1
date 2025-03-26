Return-Path: <netdev+bounces-177787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B03A71BAB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0821762ED
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE581F63CD;
	Wed, 26 Mar 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaKZ8p1O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F11F4288
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006076; cv=none; b=NSv5Cf8+ApUXKBr34jErZrWQgaLe4o6aRZE7AdyqJi/BLepFLQi+L2y/gQWRHzyv4BejjmM8ZM8Cxu+rNtEBW4obpqaUIEYQ1pIBZ7GQS59mFgcs0YGJUK16VHmsCQI7WIqBLQEh0Pwi5L8fPlXwt+I7jYAxKZ5gPzMGAL2N3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006076; c=relaxed/simple;
	bh=xejv/BHNYIpVxEwvi1agd8alfJnmDYOHhuQeSbz9TdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azgddQv1JxLn4eKfVvWXnbhn4y3I7UqLv6gR+tCVZmoziamKuCcmoNY5X2tnBo53awIUBfFeDNXLPa1EfEJyMpsS6zaXdqmZR0QoT7iIf9OU1SvTiNrt5cWUvwO33jJrUY1NjBAgPBaIntpv4///+7jlYME1FZrl6zF2zMPbWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaKZ8p1O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743006072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rhDUOfYTdvyvV/eFaMDlyCyK0NwjyAggH/NGIgz/Q8=;
	b=aaKZ8p1O/38HRcje+X7dOQqacFQscNz/V6iLrEQWynnJayrRYsZyrDvzbTk0ba7Ohsp74W
	FwLxhWn2N5OG8dH98TwglFKDBA7UtccFwATkd5jFG43+hQAUzB8es7QyzP3O4oYLxQg99d
	Jt7QZ9T6aQe/URFqY+AGAi2vbFg1bOc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pfinUsxlMJC6VOt2c4fvIw-1; Wed, 26 Mar 2025 12:21:11 -0400
X-MC-Unique: pfinUsxlMJC6VOt2c4fvIw-1
X-Mimecast-MFC-AGG-ID: pfinUsxlMJC6VOt2c4fvIw_1743006069
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c489babso171825e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 09:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006069; x=1743610869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rhDUOfYTdvyvV/eFaMDlyCyK0NwjyAggH/NGIgz/Q8=;
        b=meUDJaUv1EXPZAk3Qt85qi1nN0kVLkwEFpcV7IO5W1fGJSyDhDtj2Co1I6kELGvFMs
         XNgd4Z+wCkBFPqZDK8MQ8w9Z4lmGVryHM26NXutCGf1d8nWWf+THCM1vEsAT3ZcQOj9m
         Uqtw/xGJ+BzhSYQU+t51FzyFghhRS0zZS4fFDs85gN7iVfhnF6myfO2A9+RfNlI2jp+w
         wLVoTI3IBwTtuT0nbMzJM7phIYc5SFq81kttTjk1l+xSKGCArGBbJRjKkQCwj1qj7Cp5
         rR7AFgEGQGjgLffuxqhj6uS6jWMKGsEeDCGRd0hf/QM5D4FjLci7ggtJ2RjNT4sW1uy5
         Tqiw==
X-Forwarded-Encrypted: i=1; AJvYcCX0OREfYybtwVyfmO0Zt4G2kBv5tpO3MjstTJ2TfbM3ipqhwcYPbKx53nIkvgfbQ5n4DfGVZgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGOVTUYGkTsFkk/eKWRHK9gums2OdvjGRvPo3Hny4Noxl1skN
	PD0XsCztVdamKziRBvBHD+ulMuCi2bvurai5XP7N6MDQNZiO3XnPHNO4K1ZGTjU1TtWSHb0fkul
	ZJ0MtXtADsruzp2P2UEoWb6BGmGks5fKzRYIluGKRcOJyXaP6o8G89Q==
X-Gm-Gg: ASbGncs9NEn3p/SNEncOMe8K5+Fvf8co4Ds9LDzsWl68xUv9wubh5/k2+a2Q/diz7t+
	XPWEG5Xf5/MKE+yUg+A/Y1For/tBxyRiA0Xbz/+ak2kFkL26K+VyBvwPxeAAQpAf25aGkZ6Qmux
	n6Ih+c2qQannF+n7T5ro1fc/J8F+L6XVvi7x+KFwiujAU5lnM4fwPE1T+qwzGQ6qhJT0slEK8ZS
	NAFyYtCAGyrJgROD22hGkjI1g/A4KmyxM2Vx6ZMn06OEoeKR2owFfWwQsj8dzxH/R5wYYAWbUeB
	dfX9921pBB4JckFaqd82ZVmsGv64duQLlnCDzzMA7XZVsIT0o+Ptz/I0gHYCAVS5
X-Received: by 2002:a05:600c:5126:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43d84fb9f22mr885715e9.18.1743006069139;
        Wed, 26 Mar 2025 09:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx8/eCeBPFFtCPoCe1ZXCccXEQdNSFsGJQ/ayYaSjeZ5wE7SFAm2rdiOMf/B0yRu5sY+HFTg==
X-Received: by 2002:a05:600c:5126:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43d84fb9f22mr885245e9.18.1743006068534;
        Wed, 26 Mar 2025 09:21:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6445sm17341376f8f.71.2025.03.26.09.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:21:07 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:21:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <qp67w36nyzgyd45wi7oosxe6syx7dzcifc5s2eg47engirtrnf@ewnk6ngqw7h3>
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
>>
>>>+	do {
>>>+		struct sockaddr_vm sa = {
>>>+			.svm_family = AF_VSOCK,
>>>+			.svm_cid = opts->peer_cid,
>>>+			.svm_port = opts->peer_port,
>>>+		};
>>>+		int s;
>>>+
>>>+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>>>+		if (s < 0) {
>>>+			perror("socket");
>>>+			exit(EXIT_FAILURE);
>>>+		}
>>>+
>>>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>+
>>>+		/* Set CID to 0 cause a transport change. */
>>>+		sa.svm_cid = 0;
>>>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>+
>>>+		close(s);
>>>+	} while (current_nsec() < tout);
>>>+
>>>+	if (pthread_cancel(thread_id)) {
>>>+		perror("pthread_cancel");
>>
>>And errno here.
>>
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	/* Wait for the thread to terminate */
>>>+	if (pthread_join(thread_id, NULL)) {
>>>+		perror("pthread_join");
>>
>>And here.
>>Aaand I've realized I've made exactly the same mistake elsewhere :)
>>
>>>...
>>>+static void test_stream_transport_change_server(const struct test_opts *opts)
>>>+{
>>>+	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>>>+
>>>+	do {
>>>+		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>>+
>>>+		close(s);
>>>+	} while (current_nsec() < tout);
>>>+}
>>
>>I'm not certain you need to re-create the listener or measure the time
>>here. What about something like
>>
>>	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>	control_expectln("DONE");
>>	close(s);
>>
>Just tried and it triggers the oops :)

If this works (as I also initially thought), we should check the result 
of the first connect() in the client code. It can succeed or fail with 
-EINTR, in other cases we should report an error because it is not 
expected.

And we should check also the second connect(), it should always fail, 
right?

For this I think you need another sync point to be sure the server is 
listening before try to connect the first time:

client:
     // pthread_create, etc.

     control_expectln("LISTENING");

     do {
         ...
     } while();

     control_writeln("DONE");

server:
     int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
     control_writeln("LISTENING");
     control_expectln("DONE");
     close(s);

Thanks,
Stefano


