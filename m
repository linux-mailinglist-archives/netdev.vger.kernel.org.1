Return-Path: <netdev+bounces-177759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FFA719FD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050DD16BD0B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C461F3BB6;
	Wed, 26 Mar 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdzMKDui"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2DF1F3BBB
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002068; cv=none; b=cHqg7pPduibc3IDoLFB8WC3fpWCuPElzvyjHjZ0x5olb0nB+FPt4UWbedMw/DSb2er8L9rGkQvk73on1zfqnXL5RxbMK8eHoJtHG9nG1/qXx1dSCE01dvuKmAL6BMoRBQNE6FMNXJNNqpywy0EG8iVX+a9RR+bIcKm+Yr1iJYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002068; c=relaxed/simple;
	bh=HQUnbYOHztWJlIEUmRKH75bQVKxvC05Z8Czi7nqAq54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7WTbZPql4mR/WiOWOVdg9Oq43w+qcGLolEY4ZPFe4ZTowJoyEnG5d/QadTLN3fuQMF49h6DfROMxGD/YuZAcQuFgdlA2KW2s3pRJe1Rfan8wMC68fVsshXVvezMelOFhmnKFRYUffSogxFUTdvpGZcdgWhBzpp2QfbwqF67fiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdzMKDui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743002066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPLJoTpj9mwt9aNlegdCeCagVemKudQjbGtSj2yURtA=;
	b=UdzMKDuiKuxZiAnAE2/3+j7ISnyxR07MvPkGqEsSjPC2C3rG8rK2bYZxkuvtmyXK4CCfNi
	lUpyI7qf2covl9bsIC1gXff5lkSgrafZGiXUN8z03ACfawvOgM/3F/QnPXhnNW+GQ2uA66
	F0NoLct/TZmsS1wTPozvhbJHG3iY8Kg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-E5LhvtH_PHKmGnD4XBZafQ-1; Wed, 26 Mar 2025 11:14:24 -0400
X-MC-Unique: E5LhvtH_PHKmGnD4XBZafQ-1
X-Mimecast-MFC-AGG-ID: E5LhvtH_PHKmGnD4XBZafQ_1743002063
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913f546dfdso3739318f8f.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002063; x=1743606863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPLJoTpj9mwt9aNlegdCeCagVemKudQjbGtSj2yURtA=;
        b=hxIBjwBRSscdMZfb8RmYmPhTud1xw+TVxXT/H//zjq+/okCq+OCrklpWKf7Z19LhQX
         WaWP5LdVXYiSjdGWeye3YDY9SP4qI38JLBHMjXYPGEwwfdEjGqCPApSBD/NcxwdSuOVL
         qDPSVQUdei24oee9vt1nH9MpElJLLQbU3JvDUPpIOZ7UKREKSvmbgEOoTj+rqQC7L34U
         fvVGn5b9cpGavw6xgXhHcCdzOxEyFItu85vGU8biR/ryh8cW07+Rh/ZfySAZldFA4+c9
         4VT9jAB7UTrAFpOu4yug0jLcl+UXeoIArhvvFMBVcbmFHtdWMQ1dB3qjTzuMfCChoeRr
         Mp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7NBj7uHCMEvuWIBvQ87H5LAmjSr8TIBGcbIhS7fnTeB3fWwT72sd7JBlWJ6/i4/YYkS9Tt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyprd0ycAHQzq9NzHI3uIIswnodDOIlUrOo9eStMhYr5jsJ++c9
	xp566VlWKM3BDBe6u6dehMuToiLweaJBabn6CfePqazRmEJXW1PyvGiCKAv/IwyYjl3zC0rO5Do
	DmGCJI5bQYFCJDfHtc40MnXCqpUbbhCM7vIeyLUPUujmNkb7/peH5Aw==
X-Gm-Gg: ASbGncuOaonGqhh+NCt4RxyUPl0MmOEyIiSXD8Xv2X6/0p//XKFywg4UUN7gNZA29FU
	149qpn1ft5SLRR05nr+SSjt+E6ocGJ3b/EliJHeLIFA8DPLv2unCyTg4XlDfozGhDn24W5YPdvq
	pQVrlr22roNPfUUyXzuJGOX5jDXacS52DkZOI7tnYR9URRK2+vz3C6zR2LY+0JPhtZIiN1Kr3dD
	LVLgKprC5FYYrRQfQkHJS/yULxh1PVr38ptXCEbCoKAszolMmZpnckIOBbRZ6g8DYoYc0y/GY0T
	237U8mDeRtALy7pwgw==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr21794410f8f.25.1743002063261;
        Wed, 26 Mar 2025 08:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDszGJVF0UQWbzTWPDs66IMD9GSVlTSXE4mrjhgf35Uxdu3u5FMnMzdvDiVttQywI4kT7Hw==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr21794380f8f.25.1743002062777;
        Wed, 26 Mar 2025 08:14:22 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdff2sm4960435e9.17.2025.03.26.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:14:22 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:14:20 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>

Hi Michal,

On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>On 3/14/25 10:27, Luigi Leonardi wrote:
>> Add a new test to ensure that when the transport changes a null pointer
>> dereference does not occur[1].
>>
>> Note that this test does not fail, but it may hang on the client side if
>> it triggers a kernel oops.
>>
>> This works by creating a socket, trying to connect to a server, and then
>> executing a second connect operation on the same socket but to a
>> different CID (0). This triggers a transport change. If the connect
>> operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Just to be clear: that's the splat, right?
>
>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:vsock_stream_has_data+0x44/0x70
>Call Trace:
> virtio_transport_do_close+0x68/0x1a0
> virtio_transport_recv_pkt+0x1045/0x2ae4
> vsock_loopback_work+0x27d/0x3f0
> process_one_work+0x846/0x1420
> worker_thread+0x5b3/0xf80
> kthread+0x35a/0x700
> ret_from_fork+0x2d/0x70
> ret_from_fork_asm+0x1a/0x30
>

Yep! I'll add it to the commit message in v3.
>> ...
>> +static void test_stream_transport_change_client(const struct test_opts *opts)
>> +{
>> +	__sighandler_t old_handler;
>> +	pid_t pid = getpid();
>> +	pthread_t thread_id;
>> +	time_t tout;
>> +
>> +	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>> +	if (old_handler == SIG_ERR) {
>> +		perror("signal");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>> +		perror("pthread_create");
>
>Does pthread_create() set errno on failure?
It does not, very good catch!
>
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>
>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
Yeah it's probably excessive. I used because it's the default timeout 
value.
>
>> +	do {
>> +		struct sockaddr_vm sa = {
>> +			.svm_family = AF_VSOCK,
>> +			.svm_cid = opts->peer_cid,
>> +			.svm_port = opts->peer_port,
>> +		};
>> +		int s;
>> +
>> +		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +		if (s < 0) {
>> +			perror("socket");
>> +			exit(EXIT_FAILURE);
>> +		}
>> +
>> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>> +
>> +		/* Set CID to 0 cause a transport change. */
>> +		sa.svm_cid = 0;
>> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>> +
>> +		close(s);
>> +	} while (current_nsec() < tout);
>> +
>> +	if (pthread_cancel(thread_id)) {
>> +		perror("pthread_cancel");
>
>And errno here.
>
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* Wait for the thread to terminate */
>> +	if (pthread_join(thread_id, NULL)) {
>> +		perror("pthread_join");
>
>And here.
>Aaand I've realized I've made exactly the same mistake elsewhere :)
>
>> ...
>> +static void test_stream_transport_change_server(const struct test_opts *opts)
>> +{
>> +	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>> +
>> +	do {
>> +		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>> +
>> +		close(s);
>> +	} while (current_nsec() < tout);
>> +}
>
>I'm not certain you need to re-create the listener or measure the time
>here. What about something like
>
>	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>	control_expectln("DONE");
>	close(s);
>
Just tried and it triggers the oops :)

>Thanks,
>Michal
>

Thanks for the review!

Luigi


