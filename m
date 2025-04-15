Return-Path: <netdev+bounces-182804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BAA89EF5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5657A9ABF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6FC296D0A;
	Tue, 15 Apr 2025 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lll8txmx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FD2820B0
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722451; cv=none; b=OmxlrJLOuGtP2gVlAnxPUlh8eaI4MHcZBRZOnG06QBRV85Rl7KSwPCFQNYSWNm8C4ybEcHT7zyZDoN3ncBdjD0Vy4AKWyOpSQ+6cHjWsd/al2h2LcM/v/HhAHopqzWubUAKh3oqxB3sR/zxLoaOUfA/Mv12aQgWhOZVIclfl0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722451; c=relaxed/simple;
	bh=hbAmnZsh5Ulpas5PQOBKrcCxo8u/pRs+/rsbRISvROI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqNo47fM2OI1h9U+VKVaHd4r0vGxCd+rZhUmQGJQN/iq/MnFe1n4aXEMTxm1yha9Lh4PwA1Bvt4qViVK1VvChamouVgnGuL9HYuOJaH2eeK0ZcO458Jm1gtE/RarR9NOvXoWeYoNnFJFhjDeYIfCEc38+w04qJaiMbTa21+i9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lll8txmx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744722448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nSyTSXqKjTcBXn4151tXkrtZryXo4pU/7BOagEpBZqA=;
	b=Lll8txmxkDNUAirqesQ82MF4mLMA9VxheTSam7+8thZZiFBv3/nfpg9sj+YQDDAhjacObu
	bUJxDwLEWup6vjWAuhjyArSTKnnjFY+TwXKQXGH6kHxsddktb0E4KiRFYMVkcVZ0t1OW+Q
	eBSkCQYd0IK72CXmJag8DNnVLsunqN8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-qNKSl4tmOwu_H17wIbqiSQ-1; Tue, 15 Apr 2025 09:07:26 -0400
X-MC-Unique: qNKSl4tmOwu_H17wIbqiSQ-1
X-Mimecast-MFC-AGG-ID: qNKSl4tmOwu_H17wIbqiSQ_1744722445
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912a0439afso2273129f8f.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744722445; x=1745327245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSyTSXqKjTcBXn4151tXkrtZryXo4pU/7BOagEpBZqA=;
        b=plGzHw1cgvSjtssRTiv823JbaxBLaUJj6j+1jSemOJEFyKRfNsstHLSNYqLhldOSil
         +6oPE5KwCw7nUx7f3N6pCctWbUJ3znrjWMPyzD0f74gHLnZ3yEzW3KzVqvLZGPb5EJn/
         KSCrEFzRtDBHEx3ndiz465ucFY9OroHLdWvxz1PWDcRTM49yQHBO24vJ3qLnxgTRlAMn
         /dsIg62VKDG99BeavDoeH/ClMrCaCx6qRsS4RFwvLLAPEgh9teGVVA1TbS/8gC1Kpkwd
         O8mBqK8YisaxqlcOuDefC1dP6qVafZJcwHFGAQupiS51mNYQ1KlQK65SqZF/ChOCqb+9
         OXMw==
X-Forwarded-Encrypted: i=1; AJvYcCUKw3wSYdIPKcLDW4p951cQxDirnkUjamdEuCt4LpIa6ZXpKVLtNUM972DnmrXv5S050E9dgUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcepni7vGki/AolVA/XIUDPBF/BWjGEIjNqyckwyVsK2LMlimY
	b4aI8nvdWeKR+lh+1SHJ5l9NznncGUDdeHFZWnMGUAat8HS48PdH0WApkxfr6jkwAzRVZc8gQ6j
	pkqoFPPO37Bu8PCnnVmn5O/9kEzl5eNpBTtgZ8SpNPPEh+gtBGNtMpA==
X-Gm-Gg: ASbGnctEq7f8x8LQ7ty5C1P3hGzbHa5gG58XAT6ZW02a136rkjJr2qjqjVktdgATr/Q
	DYAbUXG8sV7XVr9rd/evZb9qE3rmg6s5UpbznU1G3yI+vFMd+IBkdWprefbiM5eTPst2SIsH/8+
	dcutkcmKUAnPM/zh8t0Qs+RPzah2SoODpjGzB4zYidoqNd0moa9WSTfinJx0XWdcGpYDgV4LGAi
	OdYEWVrjvHHP89GUUjPrxvzvRRk0YQuDD9XX9goiOWgjnU4ahmafhLy9qi4LOO2B+nD1x8eRgra
	5OKhECcL9LsYUiQMwQ==
X-Received: by 2002:a05:6000:40c9:b0:39c:1258:2dc7 with SMTP id ffacd0b85a97d-39eaaec9f18mr12258703f8f.56.1744722444831;
        Tue, 15 Apr 2025 06:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGCpp17azL0waomWVbI/H3QHq8JDgj/Oln6djR13jBcm4wCNObRACIdSPwy7UY64ggQFtQ1w==
X-Received: by 2002:a05:6000:40c9:b0:39c:1258:2dc7 with SMTP id ffacd0b85a97d-39eaaec9f18mr12258604f8f.56.1744722443728;
        Tue, 15 Apr 2025 06:07:23 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.149.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae963f62sm13964116f8f.5.2025.04.15.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:07:22 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:07:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: vsock broken after connect() returns EINTR (was Re: [PATCH net
 2/2] vsock/test: Add test for SO_LINGER null ptr deref)
Message-ID: <js3gdbpaupbglmtowcycniidowz46fp23camtvsohac44eybzd@w5w5mfpyjawd>
References: <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
 <d3a0a4e3-57bd-43f2-8907-af60c18d53ec@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d3a0a4e3-57bd-43f2-8907-af60c18d53ec@rbox.co>

On Fri, Apr 11, 2025 at 04:43:35PM +0200, Michal Luczaj wrote:
>On 4/11/25 15:21, Stefano Garzarella wrote:
>> On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>>> On 4/1/25 12:32, Stefano Garzarella wrote:
>>>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> Plus, it appears to be broken: when I hit this condition and I try to
>>>>> re-connect to the same listener, I get ETIMEDOUT for loopback and
>>>>> ECONNRESET for g2h virtio; see [2].
>>>>
>>>> Could this be related to the fix I sent some days ago?
>>>> https://lore.kernel.org/netdev/20250328141528.420719-1-sgarzare@redhat.com/
>>>
>>> I've tried that. I've also took a hint from your other mail and attempted
>>> flushing the listener queue, but to no avail. Crude code below. Is there
>>> something wrong with it?
>>
>> I can't see anything wrong, but I'm starting to get confused :-(
>> we're talking about too many things in the same thread.
>
>Uhm, that's true, sorry. I've split the thread, hope this helps.
>
>> What issues do you want to highlight?
>
>Once connect() fails with EINTR (e.g. due to a signal delivery), retrying
>connect() (to the same listener) fails. That is what the code below was
>trying to show.

mmm, something is going wrong in the vsock_connect().

IIUC if we fails with EINTR, we are kind of resetting the socket.
Should we do the same we do in vsock_assign_transport() when we found 
that we are changing transport?

I mean calling release(), vsock_deassign_transport(). etc.
I'm worried about having pending packets in flight.

BTW we need to investigate more, I agree.

Thanks,
Stefano

>
>> #include <stdio.h>
>> #include <errno.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <signal.h>
>> #include <pthread.h>
>> #include <sys/socket.h>
>> #include <linux/vm_sockets.h>
>>
>> static void die(const char *msg)
>> {
>> 	perror(msg);
>> 	exit(-1);
>> }
>>
>> static void barrier(pthread_barrier_t *barr)
>> {
>> 	errno = pthread_barrier_wait(barr);
>> 	if (errno && errno != PTHREAD_BARRIER_SERIAL_THREAD)
>> 		die("pthread_barrier_wait");
>> }
>>
>> static void flush_accept(int s)
>> {
>> 	int p = accept(s, NULL, NULL);
>> 	if (p < 0) {
>> 		if (errno != EAGAIN)
>> 			perror("accept");
>> 		return;
>> 	}
>>
>> 	printf("accept: drained\n");
>> 	close(p);
>> }
>>
>> static void handler(int signum)
>> {
>> 	/* nop */
>> }
>>
>> void static set_accept_timeout(int s)
>> {
>> 	struct timeval tv = { .tv_sec = 1 };
>> 	if (setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
>> 		die("setsockopt SO_RCVTIMEO");
>> }
>>
>> void static set_connect_timeout(int s)
>> {
>> 	struct timeval tv = { .tv_sec = 1 };
>> 	if (setsockopt(s, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT, &tv,
>> 		       sizeof(tv)))
>> 		die("setsockopt SO_VM_SOCKETS_CONNECT_TIMEOUT");
>> }
>>
>> static void *killer(void *arg)
>> {
>> 	pthread_barrier_t *barr = (pthread_barrier_t *)arg;
>> 	pid_t pid = getpid();
>>
>> 	if ((errno = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS,
>> 					   NULL)))
>> 		die("pthread_setcanceltype");
>>
>> 	for (;;) {
>> 		barrier(barr);
>> 		if (kill(pid, SIGUSR1))
>> 			die("kill");
>> 		barrier(barr);
>> 	}
>>
>> 	return NULL;
>> }
>>
>> int main(void)
>> {
>> 	struct sockaddr_vm addr = {
>> 		.svm_family = AF_VSOCK,
>> 		.svm_cid = VMADDR_CID_LOCAL,
>> 		.svm_port = 1234
>> 	};
>> 	socklen_t alen = sizeof(addr);
>> 	pthread_barrier_t barr;
>> 	pthread_t tid;
>> 	int s, c;
>>
>> 	if ((errno = pthread_barrier_init(&barr, NULL, 2)))
>> 		die("pthread_barrier_init");
>>
>> 	if (signal(SIGUSR1, handler) == SIG_ERR)
>> 		die("signal");
>>
>> 	s = socket(AF_VSOCK, SOCK_STREAM, 0);
>> 	if (s < 0)
>> 		die("socket s");
>> 	set_accept_timeout(s);
>>
>> 	if (bind(s, (struct sockaddr *)&addr, alen))
>> 		die("bind");
>>
>> 	if (listen(s, 64))
>> 		die("listen");
>>
>> 	if ((errno = pthread_create(&tid, NULL, killer, &barr)))
>> 		die("pthread_create");
>>
>> 	for (;;) {
>> 		c = socket(AF_VSOCK, SOCK_STREAM, 0);
>> 		if (c < 0)
>> 			die("socket c");
>>
>> 		barrier(&barr);
>> 		if (connect(c, (struct sockaddr *)&addr, sizeof(addr)) &&
>> 		    errno == EINTR) {
>> 		    	printf("connect: EINTR\n");
>> 			break;
>> 		}
>> 		barrier(&barr);
>>
>> 		close(c);
>> 		flush_accept(s);
>> 	}
>>
>> 	if ((errno = pthread_cancel(tid)))
>> 		die("pthread_cancel");
>>
>> 	if ((errno = pthread_join(tid, NULL)))
>> 		die("pthread_join");
>>
>> 	flush_accept(s);
>> 	set_connect_timeout(c);
>> 	if (connect(c, (struct sockaddr *)&addr, sizeof(addr)))
>> 		die("re-connect");
>>
>> 	printf("okay?\n");
>>
>> 	return 0;
>> }
>>
>
>


