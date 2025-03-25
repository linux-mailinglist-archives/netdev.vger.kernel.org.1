Return-Path: <netdev+bounces-177423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04001A70267
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B8E8463A1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5425D1F1;
	Tue, 25 Mar 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cnLG1aDV"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735CF25BAAC
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909001; cv=none; b=s1cPvFHssr97zC0WEWNh4zFg2wUDxvp68VvPDh98AXbfYUyLFm3I9s0oj+v7FHKNjSJKj8j/1JNbC+j6vEla6ylDXnVDTtSjLZUQpRyCCFvBr80JSqsh1aV5lTdoDNb9FFEDsW0o317yAzCT+x+zwuEaMsF5svzqUhuhPO1M0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909001; c=relaxed/simple;
	bh=vXOuBFyHBYpY1ypqnPlEy/jXIv3aaUGX12EsPtm+S8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYL619vm2JOVWmB8I2jpiWrvskU7feLQ71s3oHF10UE2gYf3DDqBodv+64bBj6hpjcuuVrxPpj73BKknX+XKlIdQD0Nb5YHt48ZYnpfCNaj5HXaJDkw9qa7+hLk/+mhpjDQQC6zdJyKfT6CvFHIavpId/nS4xNy0P7vgFEcvNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=fail (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cnLG1aDV reason="signature verification failed"; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tx4FG-003ych-7B; Tue, 25 Mar 2025 14:23:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=2rVx6TWFSD6f8Om7spZh6IF1bwqH+CQUf0iTpNsoQko=; b=cnLG1aDV6lI6lY/zaQAfgIXjFj
	9xMcO7jF/fp2BtFlnbI0MsnKroShmwxR/8wSriYGFuSmDpW63HHFWw5m518hcoRuSPxMvKOKeoDb3
	wwFjfy+OMwWVKH0QeS7vz/lUg0Au1fUmFFcfuzrpPyiy6qTzIjaFuhvoO/kcJp3lUEJi0SejbdX7b
	0rhdrbEsV2FAKfvzwNW00H+A9+5cREjWbB2jiUWaRnP4qlNu5DpaXCfPcafctG0GxlqHRHOMK6sbk
	TXSlkRR1Gg6K8PbgITGlWX4gVmUbLuVfaAt3eoadeDSBqDxDS/cNXArxqSNWF8e/8P2ZlNnpA6KLV
	z59+ej0g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tx4FF-0005O3-CA; Tue, 25 Mar 2025 14:23:05 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tx4Ew-00CWup-Dh; Tue, 25 Mar 2025 14:22:46 +0100
Message-ID: <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
Date: Tue, 25 Mar 2025 14:22:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 12:31, Stefano Garzarella wrote:
> On Fri, Mar 14, 2025 at 04:25:16PM +0100, Michal Luczaj wrote:
>> On 3/10/25 16:24, Stefano Garzarella wrote:
>>> On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>>>> ...
>>>> I've tried modifying the loop to make close()/shutdown() linger until
>>>> unsent_bytes() == 0. No idea if this is acceptable:
>>>
>>> Yes, that's a good idea, I had something similar in mind, but reusing
>>> unsent_bytes() sounds great to me.
>>>
>>> The only problem I see is that in the driver in the guest, the packets
>>> are put in the virtqueue and the variable is decremented only when the
>>> host sends us an interrupt to say that it has copied the packets and
>>> then the guest can free the buffer. Is this okay to consider this as
>>> sending?
>>>
>>> I think so, though it's honestly not clear to me if instead by sending
>>> we should consider when the driver copies the bytes into the virtqueue,
>>> but that doesn't mean they were really sent. We should compare it to
>>> what the network devices or AF_UNIX do.
>>
>> I had a look at AF_UNIX. SO_LINGER is not supported. Which makes sense;
>> when you send a packet, it directly lands in receiver's queue. As for
>> SIOCOUTQ handling: `return sk_wmem_alloc_get(sk)`. So I guess it's more of
>> an "unread bytes"?
> 
> Yes, I see, actually for AF_UNIX it is simple.
> It's hard for us to tell when the user on the other pear actually read
> the data, we could use the credit mechanism, but that sometimes isn't
> sent unless explicitly requested, so I'd say unsent_bytes() is fine.

One more option: keep the semantics (in a state of not-what-`man 7 socket`-
says) and, for completeness, add the lingering to shutdown()?

>>>> ...
>>>> This works, but I find it difficult to test without artificially slowing
>>>> the kernel down. It's a race against workers as they quite eagerly do
>>>> virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>>>> I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>>>> send() would just block until peer had available space.
>>>
>>> Did you test with loopback or virtio-vsock with a VM?
>>
>> Both, but I may be missing something. Do you see a way to stop (or don't
>> schedule) the worker from processing queue (and decrementing bytes_unsent)?
> 
> Without touching the driver (which I don't want to do) I can't think of
> anything, so I'd say it's okay.

Turns out there's a way to purge the loopback queue before worker processes
it (I had no success with g2h). If you win that race, bytes_unsent stays
elevated until kingdom come. Then you can close() the socket and watch as
it lingers.

connect(s)
  lock_sock
  while (sk_state != TCP_ESTABLISHED)
    release_sock
    schedule_timeout

// virtio_transport_recv_connecting
//   sk_state = TCP_ESTABLISHED

                                       send(s, 'x')
                                         lock_sock
                                         virtio_transport_send_pkt_info
                                           virtio_transport_get_credit
                                    (!)      vvs->bytes_unsent += ret
                                           vsock_loopback_send_pkt
                                             virtio_vsock_skb_queue_tail
                                         release_sock
                                       kill()
    lock_sock
    if signal_pending
      vsock_loopback_cancel_pkt
        virtio_transport_purge_skbs (!)

That said, I may be missing a bigger picture, but is it worth supporting
this "signal disconnects TCP_ESTABLISHED" behaviour in the first place?
Removing it would make the race above (and the whole [1] series) moot.
Plus, it appears to be broken: when I hit this condition and I try to
re-connect to the same listener, I get ETIMEDOUT for loopback and
ECONNRESET for g2h virtio; see [2].

[1]: https://lore.kernel.org/netdev/20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co/
[2]: Inspired by Luigi's code, which I mauled terribly:
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..aa4a321ddd9c 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 #include <linux/sockios.h>
 #include <linux/time64.h>
+#include <pthread.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -1824,6 +1825,104 @@ static void test_stream_linger_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void handler(int signum)
+{
+	/* nop */
+}
+
+static void *killer(void *arg)
+{
+	pid_t pid = getpid();
+
+	if ((errno = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL))) {
+		perror("pthread_setcanceltype");
+		exit(EXIT_FAILURE);
+	}
+
+	for (;;) {
+		if (kill(pid, SIGUSR1)) {
+			perror("kill");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	return NULL;
+}
+
+static void client(const struct test_opts *opts)
+{
+	struct sockaddr_vm addr = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = opts->peer_cid,
+		.svm_port = opts->peer_port,
+	};
+	sighandler_t old_handler;
+	bool reconnect = false;
+	pthread_t tid;
+	time_t tout;
+	int c;
+
+	old_handler = signal(SIGUSR1, handler);
+	if (old_handler == SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+
+	if ((errno = pthread_create(&tid, NULL, killer, NULL))) {
+		perror("pthread_create");
+		exit(EXIT_FAILURE);
+	}
+
+	tout = current_nsec() + 2 * NSEC_PER_SEC;
+	do {
+		c = socket(AF_VSOCK, SOCK_STREAM, 0);
+		if (c < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+
+		if (connect(c, (struct sockaddr *)&addr, sizeof(addr)) &&
+		    errno == EINTR) {
+			reconnect = true;
+			break;
+		}
+
+		close(c);
+	} while (current_nsec() < tout);
+
+	if ((errno = pthread_cancel(tid))) {
+		perror("pthread_cancel");
+		exit(EXIT_FAILURE);
+	}
+
+	if ((errno = pthread_join(tid, NULL))) {
+		perror("pthread_join");
+		exit(EXIT_FAILURE);
+	}
+
+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+
+	if (reconnect) {
+		if (connect(c, (struct sockaddr *)&addr, sizeof(addr))) {
+			perror("re-connect() after EINTR");
+			exit(EXIT_FAILURE);
+		}
+		close(c);
+	}
+
+	control_writeln("DONE");
+}
+
+static void server(const struct test_opts *opts)
+{
+	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+	control_expectln("DONE");
+	close(s);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1984,6 +2083,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_linger_client,
 		.run_server = test_stream_linger_server,
 	},
+	{
+		.name = "SOCK_STREAM connect -> EINTR -> connect",
+		.run_client = client,
+		.run_server = server,
+	},
 	{},
 };
 


