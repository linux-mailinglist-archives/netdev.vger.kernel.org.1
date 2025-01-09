Return-Path: <netdev+bounces-156694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14832A07811
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEB43A9F41
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99921B910;
	Thu,  9 Jan 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsaA1kcJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A0218E92
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430183; cv=none; b=Kd6/5Y4WELGHAkZbugGdMx6Y9ulWaNq8RNnEHmOT1/aS3TMfAM8jSH1k8y77Fpyfm/cf1D6AIuUlADKCsrkPXC3gCnCJSqqqRQ3uByIqQb23fVnWefSzY8RMc7S0v41GP4qmcCtGB6v8fo/ApBvSqa9h7s5OE6mfMEMLri7Y5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430183; c=relaxed/simple;
	bh=8dqpi+3F9iCh0CcG9gTM7Zeb5SSODkpsvXGULp+sSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxgsAr3rUhUFDv4h+rMpppGnrQBDBrBBrwVT5/R3M18kxDjzg3tAoUe2Zxv4/G4MXjgbhR7IdlARDQXCvD2mfCbKTTzZ3vGk7FT33yz4gNt4oRTGScCdHhdiMY8jDWxE+7bxwozUr37YiMaf8tOgJX7Ft+Gs8oKqUWiN6SAew0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsaA1kcJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkO1Khp0HMapbaFR2ikf7uwESckJYrFFK8Z3Z9FYmUA=;
	b=UsaA1kcJvsFenJ+KC+DF3gwe1w0ZfqAwAvl+5vFg0yq5BzRl5zK/OMXqqmO4zWUjxvxC11
	AXTFJM9HoibFX+n3+Fqq1DsbB9yL5bB0Ak+JihaWcTLu5TyitbVa4Bhv4zr24a1AQnNFfL
	ksYeC3Z0FkyyLyy1Sh7x9jhzRANgRZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-A_VAeiKPOIS5YjJF2ndOwA-1; Thu, 09 Jan 2025 08:42:59 -0500
X-MC-Unique: A_VAeiKPOIS5YjJF2ndOwA-1
X-Mimecast-MFC-AGG-ID: A_VAeiKPOIS5YjJF2ndOwA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so4726235e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 05:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430178; x=1737034978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkO1Khp0HMapbaFR2ikf7uwESckJYrFFK8Z3Z9FYmUA=;
        b=uW2UM2DMre3iay9p5I54JdjXI9fm8SYantBeMmXevaz7zxi0idkK1yAKf6ikTGq/2K
         T395vTbH6sUXp7qzd0bCuan/nRor+xuAsrnmlLxRRoK8wBPA9LUFIRTIC/oZqiFXMxls
         4o+q6YUruIH8n4+PJ/6yckD7r5cZPtZ99iKydhLMd84xfQ6ZHqwUfXkgA++OzewQZvWA
         3Cfwqocn4xPjQ5ZnlgGQN0jl4Gp2rWC1RG3dVQxvVOjaIc4TOK1rwejcuiZHSimN3p4w
         AZzpjk1YrRHGiqk21niseYrKKBIlR6bcqJqyrAFer2mY5pqNORpvqTSURWogZsvtxQSW
         1aAw==
X-Gm-Message-State: AOJu0YxzwPUhhjH8UefllhOFxYozimj4UnGHWaCp986EzavyFH7knka4
	nnCGMzFy+27haE9zZIC1cIYbByGjwyGF+rJ8D/THxlX//jtBUYI+5p4kMOl6mbtPkIVRaGefVY3
	THtLxGfnteot8aUDQUBBI9SDdWMKS17CoO1kPMmjoGkwx2TzFI2Iz5A==
X-Gm-Gg: ASbGncvq1Sr9MchnC/YaCL+HGWt+j7nrHWtiZbbzyLGC4lJC03d/6AHyXxmNXf5gk/i
	SNC31Gm+cgs2DS/QnJbLma3/f2eWRe3ceGsvUUkHWKnS2/i3hHXN9XltzF9P9r32ufEfnyMQCOt
	Ehks6E6KYiucvWCGNuNqvW3TDkJBKPWyGBUxTnDhZDFQL+4bVBgB7j5YpWLs91ejtVrKqMwI+FL
	iGrBSJYIsCUtb56pEzJCk4uNNxr3wmt9sdh+CFebJAIrGf0vUdx6Tfn+pU=
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-436ee0f8af6mr486055e9.5.1736430177649;
        Thu, 09 Jan 2025 05:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5m4tfgVUXXtQrzZe1N8yHzwLbDrucPzBnV0KJqzaPNouhBoh4EpWaQZfS/qgi6tjX8hNSVA==
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-436ee0f8af6mr485655e9.5.1736430176950;
        Thu, 09 Jan 2025 05:42:56 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm1871927f8f.3.2025.01.09.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:42:56 -0800 (PST)
Date: Thu, 9 Jan 2025 14:42:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <wix5cx7uhthr6imrpsliysktyae6xwuzpvg77uscswyqwszzfb@ms5osa4ckdcm>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>

On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>On 1/8/25 19:06, Stefano Garzarella wrote:
>> If the socket has been de-assigned or assigned to another transport,
>> we must discard any packets received because they are not expected
>> and would cause issues when we access vsk->transport.
>>
>> A possible scenario is described by Hyunwoo Kim in the attached link,
>> where after a first connect() interrupted by a signal, and a second
>> connect() failed, we can find `vsk->transport` at NULL, leading to a
>> NULL pointer dereference.
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Reported-by: Hyunwoo Kim <v4bel@theori.io>
>> Reported-by: Wongi Lee <qwerty@theori.io>
>> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..51a494b69be8 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>  	lock_sock(sk);
>>
>> -	/* Check if sk has been closed before lock_sock */
>> -	if (sock_flag(sk, SOCK_DONE)) {
>> +	/* Check if sk has been closed or assigned to another transport before
>> +	 * lock_sock (note: listener sockets are not assigned to any transport)
>> +	 */
>> +	if (sock_flag(sk, SOCK_DONE) ||
>> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>>  		(void)virtio_transport_reset_no_sock(t, skb);
>>  		release_sock(sk);
>>  		sock_put(sk);
>
>FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. Ended
>up with
>
>```
>from threading import *
>from socket import *
>from signal import *
>
>def listener(tid):
>	while True:
>		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>		s.bind((1, 1234))
>		s.listen()
>		pthread_kill(tid, SIGUSR1)
>
>signal(SIGUSR1, lambda *args: None)
>Thread(target=listener, args=[get_ident()]).start()
>
>while True:
>	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>	c.connect_ex((1, 1234))
>	c.connect_ex((42, 1234))
>```
>
>which gives me splats with or without this patch.
>
>That said, when I apply this patch, but drop the `sk->sk_state !=
>TCP_LISTEN &&`: no more splats.

We can't drop `sk->sk_state != TCP_LISTEN &&` because listener socket 
doesn't have any transport (vsk->transport == NULL), so every connection 
request will receive an error, so maybe this is the reason of no splats.

I'm cooking some more patches to fix Hyunwoo's scenario handling better 
the close work when the virtio destructor is called.

I'll run your reproduces to test it, thanks for that!

Stefano


