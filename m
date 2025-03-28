Return-Path: <netdev+bounces-178111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FBFA74BCC
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EE11B62B75
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87214D70E;
	Fri, 28 Mar 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjTAEozu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FE2114
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169706; cv=none; b=C24R+5AEXAbfeKPonoECK9yRuOCOM7+wTgEc73QbdNXRP/Imnksgzcr+5XuDkd/M7+NHjYUUPOxTVTYoNMpEtDWYiZm7/bH2GniCXWM6yVjPq/ye2oI+BlCp068Fg35s3xn0R/rpJaksaAXAUcq1oEacO0IP1yKhREQ1grPpu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169706; c=relaxed/simple;
	bh=+S8MKQkkSs/8tMleB9wK11MPHYdYhT6bb/fff8/MzIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2XCWdW+CJiUZTA8aV1w8hmNFUkq7bvTBne/xx5+1P2J1s6g7l3ltjXE8WkKQqVHO3HOWc+if0d/NOaZ3/iC/d37+APoJsgvf+o6Nfez1IFjHDrrCRJIwRJbfJtn0xGXKaxvkdHvEqLjpFycL8e8XDgzQ0gOvTzA0JLKj8fsOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjTAEozu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743169703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPTNrMeu6/Cig+m6oOG7xyDbUSBNSDtp9SZo7fIlG4Y=;
	b=TjTAEozu6nMV+g3EHhuD8EPDL6jgELeN7+/fy8Pw7WlW/NzzjCUF03cS3g8Wp+BjfRROk1
	CY+VviOCP4fT3HW40PdlndLkAMynzSHY19QE6xgiGdmUJhePb3eBcn/cE2E7A7C/COLKG+
	2tx6nvcwgQ+Say7s1Wsycw7OmRPP7Pw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ZSuJZGxgOYeVwRtjic2YTQ-1; Fri, 28 Mar 2025 09:48:15 -0400
X-MC-Unique: ZSuJZGxgOYeVwRtjic2YTQ-1
X-Mimecast-MFC-AGG-ID: ZSuJZGxgOYeVwRtjic2YTQ_1743169694
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3c219371bso49971266b.0
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 06:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743169694; x=1743774494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPTNrMeu6/Cig+m6oOG7xyDbUSBNSDtp9SZo7fIlG4Y=;
        b=CsR1rcm/TKU1WsIjz4kt2+Tie5gXu34YGE+vIz1BwzeD5NWallZ9GInpRJ1tdfErJe
         6m91ZfxF/ieLwKl4i9tmooFBD6C6ztLaKWPd5Mqlj1V95e6BvPIWzGBlqT68HFhMpb/v
         9bN2anxz4GJUQGpc7D9vyLo2D99cj8qXLPcwfL8OwCozVw9OHtQbaSNKXj3HNr88RRZs
         ZqseHdr2SEyhw3OmlOZdooAa/6XCAYkIyQwgQAPsO0BAUNSWhZI+r1iHpTaa+lz7a9Sj
         OCwTLoAIccipXL7JgRtTPzQbaOH0VNB9xGIg3zeHm7u08tqxmdetWyM/ey8kzSfMEjKp
         jzNg==
X-Forwarded-Encrypted: i=1; AJvYcCU/AiyxmNJg9Hme9T12eMbma+vE0niV4oEAwbw3TLDgUFkH1rttsKTfg0tKinYF7H/bw8WzbOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5xiI0vppQtYb01BBNog2IKHO5BCN53vg2wPde06CmwDivKU9
	shBQcxF4CzwVN00xenKkUxakNlR8aW7DtypZxiAU8Zy35FwzPK1QDGK8Y+z+MSuLMM5A2hcr8Gf
	MVdDlDLCSjVDdM2LYV8uF+EcggjC4/0lnKNCAEdJDfw3XU+gH6nGnq2IeSSrVKFBe
X-Gm-Gg: ASbGnctyiC1ApaPgJ1p4g6Z+24Ue21NxccntAnV6+BDliPVdK3UarWEHm43MfygzXwU
	fm6Dtg+xZU9AO7gWRe3fYLVbTEU9fumDX4Trb9q33U4MREfE4tzjuXNVXvZeSqmgThQTGJSJ2uY
	vUUoiIbehWvA/sy0oMEV19sfChn+GAyYkmCR3K1i4jG2CGGvMUQNOJfV3La7/27WXolDLGJKrZV
	nOoAccJyODk1iRN2XZxTbXfHbgsUeyKJBnsr5aJh6gLg30qBIOje8Vz2aRTNTB2qX4VWD2UNj5O
	AIjaONWSi/8jrELeZtvb+C7FrWJu2/yQ0EUFPpWtlYbjSD40C+vCe4eZxTjlmx6f
X-Received: by 2002:a17:906:444:b0:ac7:1be2:1a79 with SMTP id a640c23a62f3a-ac71be221c6mr261204066b.4.1743169693821;
        Fri, 28 Mar 2025 06:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Do6TwhXVYcLm9d7+oMf8jMoIxW/KsZPz70Fgkxrb6TK+oJV9OIZ2ipHzwvR6fy5R3aM9oQ==
X-Received: by 2002:a17:906:444:b0:ac7:1be2:1a79 with SMTP id a640c23a62f3a-ac71be221c6mr261200666b.4.1743169693188;
        Fri, 28 Mar 2025 06:48:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719278674sm162698166b.40.2025.03.28.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:48:12 -0700 (PDT)
Date: Fri, 28 Mar 2025 14:48:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
 <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
 <qp67w36nyzgyd45wi7oosxe6syx7dzcifc5s2eg47engirtrnf@ewnk6ngqw7h3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <qp67w36nyzgyd45wi7oosxe6syx7dzcifc5s2eg47engirtrnf@ewnk6ngqw7h3>

On Wed, Mar 26, 2025 at 05:21:03PM +0100, Stefano Garzarella wrote:
>On Wed, Mar 26, 2025 at 04:14:20PM +0100, Luigi Leonardi wrote:
>>Hi Michal,
>>
>>On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>>>On 3/14/25 10:27, Luigi Leonardi wrote:
>>>>Add a new test to ensure that when the transport changes a null pointer
>>>>dereference does not occur[1].
>>>>
>>>>Note that this test does not fail, but it may hang on the client side if
>>>>it triggers a kernel oops.
>>>>
>>>>This works by creating a socket, trying to connect to a server, and then
>>>>executing a second connect operation on the same socket but to a
>>>>different CID (0). This triggers a transport change. If the connect
>>>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>>
>>>Just to be clear: that's the splat, right?
>>>
>>>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>>Workqueue: vsock-loopback vsock_loopback_work
>>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>>Call Trace:
>>>virtio_transport_do_close+0x68/0x1a0
>>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>>vsock_loopback_work+0x27d/0x3f0
>>>process_one_work+0x846/0x1420
>>>worker_thread+0x5b3/0xf80
>>>kthread+0x35a/0x700
>>>ret_from_fork+0x2d/0x70
>>>ret_from_fork_asm+0x1a/0x30
>>>
>>
>>Yep! I'll add it to the commit message in v3.
>>>>...
>>>>+static void test_stream_transport_change_client(const struct test_opts *opts)
>>>>+{
>>>>+	__sighandler_t old_handler;
>>>>+	pid_t pid = getpid();
>>>>+	pthread_t thread_id;
>>>>+	time_t tout;
>>>>+
>>>>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>>>>+	if (old_handler == SIG_ERR) {
>>>>+		perror("signal");
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>>>>+		perror("pthread_create");
>>>
>>>Does pthread_create() set errno on failure?
>>It does not, very good catch!
>>>
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>>>
>>>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
>>Yeah it's probably excessive. I used because it's the default 
>>timeout value.
>>>
>>>>+	do {
>>>>+		struct sockaddr_vm sa = {
>>>>+			.svm_family = AF_VSOCK,
>>>>+			.svm_cid = opts->peer_cid,
>>>>+			.svm_port = opts->peer_port,
>>>>+		};
>>>>+		int s;
>>>>+
>>>>+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>>>>+		if (s < 0) {
>>>>+			perror("socket");
>>>>+			exit(EXIT_FAILURE);
>>>>+		}
>>>>+
>>>>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>>+
>>>>+		/* Set CID to 0 cause a transport change. */
>>>>+		sa.svm_cid = 0;
>>>>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>>+
>>>>+		close(s);
>>>>+	} while (current_nsec() < tout);
>>>>+
>>>>+	if (pthread_cancel(thread_id)) {
>>>>+		perror("pthread_cancel");
>>>
>>>And errno here.
>>>
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	/* Wait for the thread to terminate */
>>>>+	if (pthread_join(thread_id, NULL)) {
>>>>+		perror("pthread_join");
>>>
>>>And here.
>>>Aaand I've realized I've made exactly the same mistake elsewhere :)
>>>
>>>>...
>>>>+static void test_stream_transport_change_server(const struct test_opts *opts)
>>>>+{
>>>>+	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>>>>+
>>>>+	do {
>>>>+		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>>>+
>>>>+		close(s);
>>>>+	} while (current_nsec() < tout);
>>>>+}
>>>
>>>I'm not certain you need to re-create the listener or measure the time
>>>here. What about something like
>>>
>>>	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>>	control_expectln("DONE");
>>>	close(s);
>>>
>>Just tried and it triggers the oops :)
>
>If this works (as I also initially thought), we should check the 
>result of the first connect() in the client code. It can succeed or 
>fail with -EINTR, in other cases we should report an error because it 
>is not expected.
>
>And we should check also the second connect(), it should always fail, 
>right?
>
>For this I think you need another sync point to be sure the server is 
>listening before try to connect the first time:
>
>client:
>    // pthread_create, etc.
>
>    control_expectln("LISTENING");
>
>    do {
>        ...
>    } while();
>
>    control_writeln("DONE");
>
>server:
>    int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>    control_writeln("LISTENING");

We found that this needed to be extended by adding an accept() loop to 
avoid filling up the backlog of the listening socket.
But by doing accept() and close() back to back, we found a problem in 
AF_VSOCK, where connect() in some cases would get stuck until the 
timeout (default: 2 seconds) returning -ETIMEDOUT.

Fix is coming.

Thanks,
Stefano

>    control_expectln("DONE");
>    close(s);
>
>Thanks,
>Stefano


