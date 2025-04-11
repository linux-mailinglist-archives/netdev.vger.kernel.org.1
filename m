Return-Path: <netdev+bounces-181642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E93A85ECD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EA9C03CA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974812D7BF;
	Fri, 11 Apr 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivulUPnV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE12367A8
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377711; cv=none; b=qx87xVWsVZp+gccICdePiXaUy80+7nAv8tD7AYY+d7titSME08g5zO3xmmWxr1oVYM/HOmcXnyHT51qXDn5GCSYyB1pxM8yjXnp5HnYYr4jju+h/X5cnCU2wjH3XpPiA6JryPeo7HcmhC1se2vm7KXuYDTc+Q4/cuJyFEUmGLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377711; c=relaxed/simple;
	bh=2izCmvpULaCQGYdf+HOgpKCx+fLajVrGyH0jwZTqtqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQV62bAaY9X8nkC8k5+Q620uj2QO7kS5bwqT3Tz4+VFheNZOL/EU9JignWHKiaWkScTrjFfRz4MIkpwF+4SBYYPLsleLcp5RkqZwRF5U0DHPclmmRJhn3QrzB+Y9o1qwEAYPoYQx+j1lmi5G/lCwiK330QxnoXpSgLLHwjOmtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivulUPnV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744377708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9R6db3rFnuQ9WOMdAGd1sTEHhzVWZOZ2OxYvrM6xjsw=;
	b=ivulUPnV5JV4ZRHfKm69kFHLYxFq4bvHi5PjeOBtKtto54a8JYWhQKvWCykIXIZTZ+590y
	WRYr4cnpSouqqT43b2hiGkUDfNB8rFtg8EuSfWzmEuCsgJDWMM3ybSYbyrUxqnglnTwxGz
	TXx+rW5ZK8SbzuMk2xf2dX2ZeR//i+g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-264Eu2JqOH2URo7JlpYo_A-1; Fri, 11 Apr 2025 09:21:47 -0400
X-MC-Unique: 264Eu2JqOH2URo7JlpYo_A-1
X-Mimecast-MFC-AGG-ID: 264Eu2JqOH2URo7JlpYo_A_1744377706
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e623fe6aa2so2056890a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 06:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377706; x=1744982506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R6db3rFnuQ9WOMdAGd1sTEHhzVWZOZ2OxYvrM6xjsw=;
        b=pv26CgVpFjb9GokM2FYL8ZLVe4IaqPh80e5rCtqdf6k5LDMMMIcvEp5Whd4qwy7CAz
         TPkSC5mQ+eqLAhTAIInmgoQOJL65SsHb9qMDVUjRVAZIn7DwtSMxGt7c0PCRZ7HVZJdv
         kg6DERM2j3+WV4wbW5gRtHiWi/NItTgrHinni+h92Cx3YTwcQJC/X6yZgN5JcqZpJ8Hq
         0TMcO++I8sejBQ5Nq8oLuY+aWI8SNKgNh7mgOxrQswFMQdB/sSi1DFDed0yprlbyg1D0
         Wznl0cbrxDkPVx1peyA0Z7Zu7qAKMNUKUpgsZHuepCWuhhrr9EKZ5o9WntpJ/7U92AG3
         qwWw==
X-Forwarded-Encrypted: i=1; AJvYcCXJYDxzR/cLMxougV6OHPn29JaS4wVQ+EiK0DCuOGNLNG4aweSlZu8NH8z7B1djYTIlq7OLd+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL8fymJ/wMptxCuU/4zpPxS4GmAnmhHfWpCavidD88DU1YmFob
	nGj9Rf3yWiIB/Ee1+VVqFUAliIzdUnDiN663pLUDAcDa97khMZkxLfZpKuddXdNDZybBiLEV7tm
	EqiodQT0xVBrwNyAhJcEt1mDEfTdYuMnLqMfeK2l1rlQQWAyB8hc3ng==
X-Gm-Gg: ASbGncsXgTaL3fM7qAxYqTso7XaRPDHPRuLG4G+xepLRprG+7vY0OnKZ6YcjWugKjGz
	v6pRkyFsa6UnxncaHn1dGBOV2xRHlFZWqoctLCeUot5zi3aBwnwd6lkA2Rnszq2JCJAFOStiytG
	VRGrtrxpgGnDmLZWXUK3vX3cIe2umcBdHx84L4hD40c28e3bMMN8tuSTTpC84nB7/fRka8vV+nm
	/R4RiaIxCehs38qPo0vmCSvCSBNDTiIvCljJyPbT3vS6rwrRGS0OwqvkBbskOaMYzqyUB2tG8Gy
	MZfchZ9HQeUdQXnOZnCWdEJB8T4tqDkiqit9yJqyFjCLXMo/4119MlYFxe4i
X-Received: by 2002:a17:907:948e:b0:ac7:66fb:6a07 with SMTP id a640c23a62f3a-acad3439f1fmr218416766b.6.1744377705689;
        Fri, 11 Apr 2025 06:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp0psu4iT1l8JGgaOCjIYth/pHGE3c9bQX+KEloRAVQ2nvQCXhiOnko527+LnHynH0j42tyQ==
X-Received: by 2002:a17:907:948e:b0:ac7:66fb:6a07 with SMTP id a640c23a62f3a-acad3439f1fmr218412766b.6.1744377704974;
        Fri, 11 Apr 2025 06:21:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb2ddasm445897666b.36.2025.04.11.06.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:21:44 -0700 (PDT)
Date: Fri, 11 Apr 2025 15:21:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Message-ID: <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
References: <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>

On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>On 4/1/25 12:32, Stefano Garzarella wrote:
>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>> On 3/20/25 12:31, Stefano Garzarella wrote:
>>>> On Fri, Mar 14, 2025 at 04:25:16PM +0100, Michal Luczaj wrote:
>>>>> On 3/10/25 16:24, Stefano Garzarella wrote:
>>>>>> On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>>>>>>> ...
>>>>>>> I've tried modifying the loop to make close()/shutdown() linger until
>>>>>>> unsent_bytes() == 0. No idea if this is acceptable:
>>>>>>
>>>>>> Yes, that's a good idea, I had something similar in mind, but reusing
>>>>>> unsent_bytes() sounds great to me.
>>>>>>
>>>>>> The only problem I see is that in the driver in the guest, the packets
>>>>>> are put in the virtqueue and the variable is decremented only when the
>>>>>> host sends us an interrupt to say that it has copied the packets and
>>>>>> then the guest can free the buffer. Is this okay to consider this as
>>>>>> sending?
>>>>>>
>>>>>> I think so, though it's honestly not clear to me if instead by sending
>>>>>> we should consider when the driver copies the bytes into the virtqueue,
>>>>>> but that doesn't mean they were really sent. We should compare it to
>>>>>> what the network devices or AF_UNIX do.
>>>>>
>>>>> I had a look at AF_UNIX. SO_LINGER is not supported. Which makes sense;
>>>>> when you send a packet, it directly lands in receiver's queue. As for
>>>>> SIOCOUTQ handling: `return sk_wmem_alloc_get(sk)`. So I guess it's more of
>>>>> an "unread bytes"?
>>>>
>>>> Yes, I see, actually for AF_UNIX it is simple.
>>>> It's hard for us to tell when the user on the other pear actually read
>>>> the data, we could use the credit mechanism, but that sometimes isn't
>>>> sent unless explicitly requested, so I'd say unsent_bytes() is fine.
>>>
>>> One more option: keep the semantics (in a state of not-what-`man 7 socket`-
>>> says) and, for completeness, add the lingering to shutdown()?
>>
>> Sorry, I'm getting lost!
>> That's because we had a different behavior between close() and
>> shutdown() right?
>>
>> If it's the case, I would say let's fix at least that for now.
>
>Yeah, okay, let's keep things simple. I'll post the patch once net-next opens.
>
>>>>>>> ...
>>>>>>> This works, but I find it difficult to test without artificially slowing
>>>>>>> the kernel down. It's a race against workers as they quite eagerly do
>>>>>>> virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>>>>>>> I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>>>>>>> send() would just block until peer had available space.
>>>>>>
>>>>>> Did you test with loopback or virtio-vsock with a VM?
>>>>>
>>>>> Both, but I may be missing something. Do you see a way to stop (or don't
>>>>> schedule) the worker from processing queue (and decrementing bytes_unsent)?
>>>>
>>>> Without touching the driver (which I don't want to do) I can't think of
>>>> anything, so I'd say it's okay.
>>>
>>> Turns out there's a way to purge the loopback queue before worker processes
>>> it (I had no success with g2h). If you win that race, bytes_unsent stays
>>> elevated until kingdom come. Then you can close() the socket and watch as
>>> it lingers.
>>>
>>> connect(s)
>>>  lock_sock
>>>  while (sk_state != TCP_ESTABLISHED)
>>>    release_sock
>>>    schedule_timeout
>>>
>>> // virtio_transport_recv_connecting
>>> //   sk_state = TCP_ESTABLISHED
>>>
>>>                                       send(s, 'x')
>>>                                         lock_sock
>>>                                         virtio_transport_send_pkt_info
>>>                                           virtio_transport_get_credit
>>>                                    (!)      vvs->bytes_unsent += ret
>>>                                           vsock_loopback_send_pkt
>>>                                             virtio_vsock_skb_queue_tail
>>>                                         release_sock
>>>                                       kill()
>>>    lock_sock
>>>    if signal_pending
>>>      vsock_loopback_cancel_pkt
>>>        virtio_transport_purge_skbs (!)
>>>
>>> That said, I may be missing a bigger picture, but is it worth supporting
>>> this "signal disconnects TCP_ESTABLISHED" behaviour in the first place?
>>
>> Can you elaborate a bit?
>
>There isn't much to it. I just wondered if connect() -- that has already
>established a connection -- could ignore the signal (or pretend it came too
>late), to avoid carrying out this kind of disconnect.

Okay, I see now!

Yeah, I think after `schedule_timeout()`, if `sk->sk_state == 
TCP_ESTABLISHED` we should just exit from the while() and return a
succesful connection IMHO, as I fixed for closing socket.

Maybe we should check what we do in other cases such as AF_UNIX, 
AF_INET.


>
>>> Removing it would make the race above (and the whole [1] series) moot.
>>> Plus, it appears to be broken: when I hit this condition and I try to
>>> re-connect to the same listener, I get ETIMEDOUT for loopback and
>>> ECONNRESET for g2h virtio; see [2].
>>
>> Could this be related to the fix I sent some days ago?
>> https://lore.kernel.org/netdev/20250328141528.420719-1-sgarzare@redhat.com/
>
>I've tried that. I've also took a hint from your other mail and attempted
>flushing the listener queue, but to no avail. Crude code below. Is there
>something wrong with it?

I can't see anything wrong, but I'm starting to get confused :-(
we're talking about too many things in the same thread. What issues do 
you want to highlight?

Thanks,
Stefano

>
>#include <stdio.h>
>#include <errno.h>
>#include <stdlib.h>
>#include <unistd.h>
>#include <signal.h>
>#include <pthread.h>
>#include <sys/socket.h>
>#include <linux/vm_sockets.h>
>
>static void die(const char *msg)
>{
>	perror(msg);
>	exit(-1);
>}
>
>static void barrier(pthread_barrier_t *barr)
>{
>	errno = pthread_barrier_wait(barr);
>	if (errno && errno != PTHREAD_BARRIER_SERIAL_THREAD)
>		die("pthread_barrier_wait");
>}
>
>static void flush_accept(int s)
>{
>	int p = accept(s, NULL, NULL);
>	if (p < 0) {
>		if (errno != EAGAIN)
>			perror("accept");
>		return;
>	}
>
>	printf("accept: drained\n");
>	close(p);
>}
>
>static void handler(int signum)
>{
>	/* nop */
>}
>
>void static set_accept_timeout(int s)
>{
>	struct timeval tv = { .tv_sec = 1 };
>	if (setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
>		die("setsockopt SO_RCVTIMEO");
>}
>
>void static set_connect_timeout(int s)
>{
>	struct timeval tv = { .tv_sec = 1 };
>	if (setsockopt(s, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT, &tv,
>		       sizeof(tv)))
>		die("setsockopt SO_VM_SOCKETS_CONNECT_TIMEOUT");
>}
>
>static void *killer(void *arg)
>{
>	pthread_barrier_t *barr = (pthread_barrier_t *)arg;
>	pid_t pid = getpid();
>
>	if ((errno = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS,
>					   NULL)))
>		die("pthread_setcanceltype");
>
>	for (;;) {
>		barrier(barr);
>		if (kill(pid, SIGUSR1))
>			die("kill");
>		barrier(barr);
>	}
>
>	return NULL;
>}
>
>int main(void)
>{
>	struct sockaddr_vm addr = {
>		.svm_family = AF_VSOCK,
>		.svm_cid = VMADDR_CID_LOCAL,
>		.svm_port = 1234
>	};
>	socklen_t alen = sizeof(addr);
>	pthread_barrier_t barr;
>	pthread_t tid;
>	int s, c;
>
>	if ((errno = pthread_barrier_init(&barr, NULL, 2)))
>		die("pthread_barrier_init");
>
>	if (signal(SIGUSR1, handler) == SIG_ERR)
>		die("signal");
>
>	s = socket(AF_VSOCK, SOCK_STREAM, 0);
>	if (s < 0)
>		die("socket s");
>	set_accept_timeout(s);
>
>	if (bind(s, (struct sockaddr *)&addr, alen))
>		die("bind");
>
>	if (listen(s, 64))
>		die("listen");
>
>	if ((errno = pthread_create(&tid, NULL, killer, &barr)))
>		die("pthread_create");
>
>	for (;;) {
>		c = socket(AF_VSOCK, SOCK_STREAM, 0);
>		if (c < 0)
>			die("socket c");
>
>		barrier(&barr);
>		if (connect(c, (struct sockaddr *)&addr, sizeof(addr)) &&
>		    errno == EINTR) {
>		    	printf("connect: EINTR\n");
>			break;
>		}
>		barrier(&barr);
>
>		close(c);
>		flush_accept(s);
>	}
>
>	if ((errno = pthread_cancel(tid)))
>		die("pthread_cancel");
>
>	if ((errno = pthread_join(tid, NULL)))
>		die("pthread_join");
>
>	flush_accept(s);
>	set_connect_timeout(c);
>	if (connect(c, (struct sockaddr *)&addr, sizeof(addr)))
>		die("re-connect");
>
>	printf("okay?\n");
>
>	return 0;
>}
>


