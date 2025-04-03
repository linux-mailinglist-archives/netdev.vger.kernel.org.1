Return-Path: <netdev+bounces-179206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB95A7B206
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2003B1C19
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91D19F471;
	Thu,  3 Apr 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="da/mwRbM"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763A2E62AE
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719277; cv=none; b=pxGrYFNVu140dzUzL+LWAevMReUZUu4uM0YqzIOZE+oxzuxdUlo3JvOIpGrh9MexAg6Pzi17c5uzacNt5vX59UYfVAdT1aO7+S/L5JE1TaftbtWrH5HrrjmZhhHsPqikEP4hVQyMHM48pHDqsyOzuVfv+/Xr7iB6Y+J7ejtNkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719277; c=relaxed/simple;
	bh=qH3fJl0q59Mny9rkqtHSYI6oZZzxEjNK7rETaxK7VxY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a248a1/gELXeUtN7ei7XBt2ApI/wxezA9zid8gbKc4RwdYdLtWFiIzVocMgFfhHYf68dESnGV3bO/rOzmLhabmi8lD9Vjh8oMo+PzwVSOfvJbYdd8mmg5XNQcnOlefu53OrdP+RJ5+V/+PttII/HCgOpl19rGjD6hH7Cmd8FsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=da/mwRbM; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u0Si5-001qPN-5X; Fri, 04 Apr 2025 00:06:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Qql1xClaNY85wlNMfqVKN49eDbeiQf2bCrIo/uVuuL0=; b=da/mwRbMsJRyvzAeuLEuhVy+uu
	mXDwfaq6vs88HuUTEz5UA6rH8ZnwW4B/QSdfHmUUrxlHxoG5D/N/ERBssDjX/iZOfqN7xqgfSIaka
	/wyDN8adAsAFtVolClsjxv00qZ4V8W0I2C7pAIS7rLqI1nnam45D/buCMn7NBfLkC8V7NrRh9mlMb
	8PskpPo+VBYl2XeZERyVC2X8bDowaPVScZUWS5gGfQDULAXqEdLb2AMLA8g9w1GDiy5WsmXtQHaTg
	tfagFmimODOK7nTwO5MqPSjuYeJYkfc+XZCiBveqjnTptw/N5SvI9phUgK47IUIjm8dJfv/buk5Wv
	zmBBet9Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u0Si4-0007Tr-Fv; Fri, 04 Apr 2025 00:06:52 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u0Shq-003NAP-6H; Fri, 04 Apr 2025 00:06:38 +0200
Message-ID: <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
Date: Fri, 4 Apr 2025 00:06:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
 <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
Content-Language: pl-PL, en-GB
In-Reply-To: <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 12:32, Stefano Garzarella wrote:
> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>> On 3/20/25 12:31, Stefano Garzarella wrote:
>>> On Fri, Mar 14, 2025 at 04:25:16PM +0100, Michal Luczaj wrote:
>>>> On 3/10/25 16:24, Stefano Garzarella wrote:
>>>>> On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>>>>>> ...
>>>>>> I've tried modifying the loop to make close()/shutdown() linger until
>>>>>> unsent_bytes() == 0. No idea if this is acceptable:
>>>>>
>>>>> Yes, that's a good idea, I had something similar in mind, but reusing
>>>>> unsent_bytes() sounds great to me.
>>>>>
>>>>> The only problem I see is that in the driver in the guest, the packets
>>>>> are put in the virtqueue and the variable is decremented only when the
>>>>> host sends us an interrupt to say that it has copied the packets and
>>>>> then the guest can free the buffer. Is this okay to consider this as
>>>>> sending?
>>>>>
>>>>> I think so, though it's honestly not clear to me if instead by sending
>>>>> we should consider when the driver copies the bytes into the virtqueue,
>>>>> but that doesn't mean they were really sent. We should compare it to
>>>>> what the network devices or AF_UNIX do.
>>>>
>>>> I had a look at AF_UNIX. SO_LINGER is not supported. Which makes sense;
>>>> when you send a packet, it directly lands in receiver's queue. As for
>>>> SIOCOUTQ handling: `return sk_wmem_alloc_get(sk)`. So I guess it's more of
>>>> an "unread bytes"?
>>>
>>> Yes, I see, actually for AF_UNIX it is simple.
>>> It's hard for us to tell when the user on the other pear actually read
>>> the data, we could use the credit mechanism, but that sometimes isn't
>>> sent unless explicitly requested, so I'd say unsent_bytes() is fine.
>>
>> One more option: keep the semantics (in a state of not-what-`man 7 socket`-
>> says) and, for completeness, add the lingering to shutdown()?
> 
> Sorry, I'm getting lost!
> That's because we had a different behavior between close() and 
> shutdown() right?
> 
> If it's the case, I would say let's fix at least that for now.

Yeah, okay, let's keep things simple. I'll post the patch once net-next opens.

>>>>>> ...
>>>>>> This works, but I find it difficult to test without artificially slowing
>>>>>> the kernel down. It's a race against workers as they quite eagerly do
>>>>>> virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>>>>>> I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>>>>>> send() would just block until peer had available space.
>>>>>
>>>>> Did you test with loopback or virtio-vsock with a VM?
>>>>
>>>> Both, but I may be missing something. Do you see a way to stop (or don't
>>>> schedule) the worker from processing queue (and decrementing bytes_unsent)?
>>>
>>> Without touching the driver (which I don't want to do) I can't think of
>>> anything, so I'd say it's okay.
>>
>> Turns out there's a way to purge the loopback queue before worker processes
>> it (I had no success with g2h). If you win that race, bytes_unsent stays
>> elevated until kingdom come. Then you can close() the socket and watch as
>> it lingers.
>>
>> connect(s)
>>  lock_sock
>>  while (sk_state != TCP_ESTABLISHED)
>>    release_sock
>>    schedule_timeout
>>
>> // virtio_transport_recv_connecting
>> //   sk_state = TCP_ESTABLISHED
>>
>>                                       send(s, 'x')
>>                                         lock_sock
>>                                         virtio_transport_send_pkt_info
>>                                           virtio_transport_get_credit
>>                                    (!)      vvs->bytes_unsent += ret
>>                                           vsock_loopback_send_pkt
>>                                             virtio_vsock_skb_queue_tail
>>                                         release_sock
>>                                       kill()
>>    lock_sock
>>    if signal_pending
>>      vsock_loopback_cancel_pkt
>>        virtio_transport_purge_skbs (!)
>>
>> That said, I may be missing a bigger picture, but is it worth supporting
>> this "signal disconnects TCP_ESTABLISHED" behaviour in the first place?
> 
> Can you elaborate a bit?

There isn't much to it. I just wondered if connect() -- that has already
established a connection -- could ignore the signal (or pretend it came too
late), to avoid carrying out this kind of disconnect.

>> Removing it would make the race above (and the whole [1] series) moot.
>> Plus, it appears to be broken: when I hit this condition and I try to
>> re-connect to the same listener, I get ETIMEDOUT for loopback and
>> ECONNRESET for g2h virtio; see [2].
> 
> Could this be related to the fix I sent some days ago?
> https://lore.kernel.org/netdev/20250328141528.420719-1-sgarzare@redhat.com/

I've tried that. I've also took a hint from your other mail and attempted
flushing the listener queue, but to no avail. Crude code below. Is there
something wrong with it?

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <pthread.h>
#include <sys/socket.h>
#include <linux/vm_sockets.h>

static void die(const char *msg)
{
	perror(msg);
	exit(-1);
}

static void barrier(pthread_barrier_t *barr)
{
	errno = pthread_barrier_wait(barr);
	if (errno && errno != PTHREAD_BARRIER_SERIAL_THREAD)
		die("pthread_barrier_wait");
}

static void flush_accept(int s)
{
	int p = accept(s, NULL, NULL);
	if (p < 0) {
		if (errno != EAGAIN)
			perror("accept");
		return;
	}

	printf("accept: drained\n");
	close(p);
}

static void handler(int signum)
{
	/* nop */
}

void static set_accept_timeout(int s)
{
	struct timeval tv = { .tv_sec = 1 };
	if (setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
		die("setsockopt SO_RCVTIMEO");
}

void static set_connect_timeout(int s)
{
	struct timeval tv = { .tv_sec = 1 };
	if (setsockopt(s, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT, &tv,
		       sizeof(tv)))
		die("setsockopt SO_VM_SOCKETS_CONNECT_TIMEOUT");
}

static void *killer(void *arg)
{
	pthread_barrier_t *barr = (pthread_barrier_t *)arg;
	pid_t pid = getpid();

	if ((errno = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS,
					   NULL)))
		die("pthread_setcanceltype");

	for (;;) {
		barrier(barr);
		if (kill(pid, SIGUSR1))
			die("kill");
		barrier(barr);
	}

	return NULL;
}

int main(void)
{
	struct sockaddr_vm addr = {
		.svm_family = AF_VSOCK,
		.svm_cid = VMADDR_CID_LOCAL,
		.svm_port = 1234
	};
	socklen_t alen = sizeof(addr);
	pthread_barrier_t barr;
	pthread_t tid;
	int s, c;

	if ((errno = pthread_barrier_init(&barr, NULL, 2)))
		die("pthread_barrier_init");

	if (signal(SIGUSR1, handler) == SIG_ERR)
		die("signal");

	s = socket(AF_VSOCK, SOCK_STREAM, 0);
	if (s < 0)
		die("socket s");
	set_accept_timeout(s);

	if (bind(s, (struct sockaddr *)&addr, alen))
		die("bind");

	if (listen(s, 64))
		die("listen");

	if ((errno = pthread_create(&tid, NULL, killer, &barr)))
		die("pthread_create");

	for (;;) {
		c = socket(AF_VSOCK, SOCK_STREAM, 0);
		if (c < 0)
			die("socket c");

		barrier(&barr);
		if (connect(c, (struct sockaddr *)&addr, sizeof(addr)) &&
		    errno == EINTR) {
		    	printf("connect: EINTR\n");
			break;
		}
		barrier(&barr);

		close(c);
		flush_accept(s);
	}

	if ((errno = pthread_cancel(tid)))
		die("pthread_cancel");

	if ((errno = pthread_join(tid, NULL)))
		die("pthread_join");

	flush_accept(s);
	set_connect_timeout(c);
	if (connect(c, (struct sockaddr *)&addr, sizeof(addr)))
		die("re-connect");

	printf("okay?\n");

	return 0;
}


