Return-Path: <netdev+bounces-181671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E53A860EF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E8F188C579
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60941F5833;
	Fri, 11 Apr 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UGm6efK7"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552E1F4198
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382637; cv=none; b=NZA7bTYZd14Ph6Pf1mEqKC7sd0TReJY6GJDMMoWbT5ceNf79qoYJu7Tqrpf+8C3kVZP1orYPGCa637uxFI2nf5OkhN5X1kGbXH1NtKfMd+B1YtwEW0RLJ1XlAEurS0UilD2yUN03YnqrYmZkIpOfe6274dHUX/Ri1sgx4QY/+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382637; c=relaxed/simple;
	bh=H7B/gX5h8OM603IDolO3y4bY+E4FNV78x0MG5HREifY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kBbG/v18i3gob0vj8yjvOn8AZdlctwIzJwQgxOkpZZvwIOBH1rWmeKcYHV0k7qDFR5RXfhTIMjhin7of1BiYBNQpblf824dOHpdTJkPhY83ql5T5wYwqRM8emTbht0Sq2YNOetrsC1Ui8BQNKJF2G36Xg4NaWtfZRgNBnfEm8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UGm6efK7; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Fbi-006Frc-3K; Fri, 11 Apr 2025 16:43:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=2vfBV/Ea6kFXP8/HGuYRr3HzoIFj55L3GAT5ADh/gVI=; b=UGm6efK7Zezp809lRotYPjiHq+
	+PlHVnYS72fFh7gOxqGaHruXMOGV5G7TFALWyKlId2REPRITGEuLuoHnwcy9vBXoGZWkyYsU+8KbU
	pq9hRMWRpTD6Jd8si/zmbXPYZe8tzP51Zx7qi26Ph7qamG9EEXuDRFc2fTtxSBRxcrIAgomrvpzpO
	aGodu9ZzAN842bULpjN/2C6k/lZ13JFHgyBoUFNl96sARGv7mP4OJzhvVzJO3z5OKAbLnhGcR+huh
	3fQOLCJCsZOBruTJ8FViM7gMKGAUe6eSY+HBqRnPCyHy4KlJYRZs9sQa+g+mQJYPU2YYewpskFNj7
	iWXEoAhQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Fbh-00081Q-3H; Fri, 11 Apr 2025 16:43:49 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3FbU-00Dk4z-LB; Fri, 11 Apr 2025 16:43:36 +0200
Message-ID: <d3a0a4e3-57bd-43f2-8907-af60c18d53ec@rbox.co>
Date: Fri, 11 Apr 2025 16:43:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: vsock broken after connect() returns EINTR (was Re: [PATCH net 2/2]
 vsock/test: Add test for SO_LINGER null ptr deref)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
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
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
Content-Language: pl-PL, en-GB
In-Reply-To: <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 15:21, Stefano Garzarella wrote:
> On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>> On 4/1/25 12:32, Stefano Garzarella wrote:
>>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>>> ...
>>>> Plus, it appears to be broken: when I hit this condition and I try to
>>>> re-connect to the same listener, I get ETIMEDOUT for loopback and
>>>> ECONNRESET for g2h virtio; see [2].
>>>
>>> Could this be related to the fix I sent some days ago?
>>> https://lore.kernel.org/netdev/20250328141528.420719-1-sgarzare@redhat.com/
>>
>> I've tried that. I've also took a hint from your other mail and attempted
>> flushing the listener queue, but to no avail. Crude code below. Is there
>> something wrong with it?
> 
> I can't see anything wrong, but I'm starting to get confused :-(
> we're talking about too many things in the same thread.

Uhm, that's true, sorry. I've split the thread, hope this helps.

> What issues do you want to highlight?

Once connect() fails with EINTR (e.g. due to a signal delivery), retrying
connect() (to the same listener) fails. That is what the code below was
trying to show.

> #include <stdio.h>
> #include <errno.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <signal.h>
> #include <pthread.h>
> #include <sys/socket.h>
> #include <linux/vm_sockets.h>
>
> static void die(const char *msg)
> {
> 	perror(msg);
> 	exit(-1);
> }
>
> static void barrier(pthread_barrier_t *barr)
> {
> 	errno = pthread_barrier_wait(barr);
> 	if (errno && errno != PTHREAD_BARRIER_SERIAL_THREAD)
> 		die("pthread_barrier_wait");
> }
>
> static void flush_accept(int s)
> {
> 	int p = accept(s, NULL, NULL);
> 	if (p < 0) {
> 		if (errno != EAGAIN)
> 			perror("accept");
> 		return;
> 	}
>
> 	printf("accept: drained\n");
> 	close(p);
> }
>
> static void handler(int signum)
> {
> 	/* nop */
> }
>
> void static set_accept_timeout(int s)
> {
> 	struct timeval tv = { .tv_sec = 1 };
> 	if (setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
> 		die("setsockopt SO_RCVTIMEO");
> }
>
> void static set_connect_timeout(int s)
> {
> 	struct timeval tv = { .tv_sec = 1 };
> 	if (setsockopt(s, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT, &tv,
> 		       sizeof(tv)))
> 		die("setsockopt SO_VM_SOCKETS_CONNECT_TIMEOUT");
> }
>
> static void *killer(void *arg)
> {
> 	pthread_barrier_t *barr = (pthread_barrier_t *)arg;
> 	pid_t pid = getpid();
>
> 	if ((errno = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS,
> 					   NULL)))
> 		die("pthread_setcanceltype");
>
> 	for (;;) {
> 		barrier(barr);
> 		if (kill(pid, SIGUSR1))
> 			die("kill");
> 		barrier(barr);
> 	}
>
> 	return NULL;
> }
>
> int main(void)
> {
> 	struct sockaddr_vm addr = {
> 		.svm_family = AF_VSOCK,
> 		.svm_cid = VMADDR_CID_LOCAL,
> 		.svm_port = 1234
> 	};
> 	socklen_t alen = sizeof(addr);
> 	pthread_barrier_t barr;
> 	pthread_t tid;
> 	int s, c;
>
> 	if ((errno = pthread_barrier_init(&barr, NULL, 2)))
> 		die("pthread_barrier_init");
>
> 	if (signal(SIGUSR1, handler) == SIG_ERR)
> 		die("signal");
>
> 	s = socket(AF_VSOCK, SOCK_STREAM, 0);
> 	if (s < 0)
> 		die("socket s");
> 	set_accept_timeout(s);
>
> 	if (bind(s, (struct sockaddr *)&addr, alen))
> 		die("bind");
>
> 	if (listen(s, 64))
> 		die("listen");
>
> 	if ((errno = pthread_create(&tid, NULL, killer, &barr)))
> 		die("pthread_create");
>
> 	for (;;) {
> 		c = socket(AF_VSOCK, SOCK_STREAM, 0);
> 		if (c < 0)
> 			die("socket c");
>
> 		barrier(&barr);
> 		if (connect(c, (struct sockaddr *)&addr, sizeof(addr)) &&
> 		    errno == EINTR) {
> 		    	printf("connect: EINTR\n");
> 			break;
> 		}
> 		barrier(&barr);
>
> 		close(c);
> 		flush_accept(s);
> 	}
>
> 	if ((errno = pthread_cancel(tid)))
> 		die("pthread_cancel");
>
> 	if ((errno = pthread_join(tid, NULL)))
> 		die("pthread_join");
>
> 	flush_accept(s);
> 	set_connect_timeout(c);
> 	if (connect(c, (struct sockaddr *)&addr, sizeof(addr)))
> 		die("re-connect");
>
> 	printf("okay?\n");
>
> 	return 0;
> }
>



