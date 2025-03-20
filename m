Return-Path: <netdev+bounces-176437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64941A6A4F3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1953AA40B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59491E1C3A;
	Thu, 20 Mar 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmB6O0Gy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC44189F36
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470272; cv=none; b=U/KuLW8Yo2ydnUy1N3y2SE6m23jKs2dqFMSJSZYgnTP3PWgZw8YTQ9F+R5TI0Gg6OLc5XQF8X8Nbym+jt9NfNAlN6wu7f9x6XE7CYhzo18cacAqkif9zff9j1nQ2UlTQPwZ0JBakY7jQphFPp+S3GuDSSwMR1mQLrvXsv7jZKF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470272; c=relaxed/simple;
	bh=OlKebDkiBnvETfrxopM5NzSzfY4eHdInX3iRtMvbp2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3rXnEQ4NnUN4yi0fBbrFjYoAw3M2IEgOiP5sEO9nTg64pyD4pLTvKmrh3gWqbMcAR5X4ufLmHxoo9u6D7/8HnTVrh8+TPl1JU/m/0frymTFMmVprgDPjTbQhExMofdRH62uWrN8ZeOpYzOz3JjzMxw9GXg/FkBxXzgWALPdldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmB6O0Gy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742470270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nXHT8vbtKdc96K5nssrlFhMLLDy+mx+mK5XfQCW5nw=;
	b=DmB6O0GyvVXj7ubL5YgAY743CtxFEb3+dtPQN7wqnX8IErK/lQLSRIl0HPg4jnFr5Q3duO
	UPJ2cbEGruztUezLDx/u046SXcrFL7g7L7AdVqgHUmgLiWHAWDtv0xevMHoNgsvb9D4hpu
	/huUwPq7e0OtYSGU7kwdObeMY4FPiEE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-tpQW03g8OjS4ohI7mVTgrg-1; Thu, 20 Mar 2025 07:31:08 -0400
X-MC-Unique: tpQW03g8OjS4ohI7mVTgrg-1
X-Mimecast-MFC-AGG-ID: tpQW03g8OjS4ohI7mVTgrg_1742470268
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so3549675e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 04:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742470267; x=1743075067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nXHT8vbtKdc96K5nssrlFhMLLDy+mx+mK5XfQCW5nw=;
        b=wOyL6QlKd8pnVUAaOxxLA/4aIpBOixFu7YGBQetoTz/wyo6V2AEU1mr+jgbheG92bt
         Y82OupSnw7JyRGPfnk1jG6+oNWlhOUTf2fVqsSHTy5KoVUsVhf8izHiJqgfoJ6xefGU+
         tqScDqpobc83Oglz8+N8UOlg0vCPBtpm892sp/d0S7bNMFyMZZZUHA613OrAdOCGR7mB
         thpMHD25Bc3OV+kMtzyljNva35aF4LgeLvp6McOIOTG+Lv4a4k7F+qj+Jcx59JKeETI0
         ATXf9StKvsP4yXuqheDF/TDbTh3V8iXTHvKcNfpCB1a8Hac4cSswU2WD7G5FSLjzXRu0
         E3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqTkgq4vdtqa81O1g76U6X24SDx1B3jPXyMIRcEsrH6WBmA/ty5RdbLbX3qxzPrstlXUAx7vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU42kKvOOaMM10IP+DpR7rRxlGDxuswfw/g1Ng+YzcT7IeQOKr
	SLYGlNDA3yx7aOl/kG9IIG9L/rmOKOhbmFGv0LKUlprwyrpw8plSBhDabVoLvYBunfZ11WRWiUi
	MbE8pFmwMpgma78rgaaFQJXDB0fQDQptyUq/KQ9z+W6WnGVc1F/nA1A==
X-Gm-Gg: ASbGncuk9y+1OY5E2fRxmJzyHim4eitep710lHsSuPjeI8394oDfFMBdeenIxIhGYHA
	QZBVeXfyueTsoZdZHLzM5+DJkDIBmGL13ImTtuLZbsAk5WcHE4BVNdnCcTSlGCVIQqvLwoLg3Xl
	tLkvZBl/+dwFuSlJSaVDnb/PnGnnCqqEedRjmSyzpp4DxeFvsl+/tNbQHjWNM3NPsVlF1suOGO0
	PMCVKLT0ruE9Pe8C6VGIGDGE5izG5au8f7zYW8PRxkcYk05zZVc18xXqde2KNuHOY65t8sJZ4K2
	MNb+bXsdtsyVcuuJEbqb3izopZB642krtMKUuoeZwPgnW9ZN8wlIoFRHFeV0/TgG
X-Received: by 2002:a05:600c:4503:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-43d437c3332mr72501315e9.17.1742470267555;
        Thu, 20 Mar 2025 04:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWpWQezGvrQ0uEfIDbZapw6gEzOiean9scRUTN8zh9zIWTJvkCmjYvMtcl0eAuqA51HGZxA==
X-Received: by 2002:a05:600c:4503:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-43d437c3332mr72500785e9.17.1742470266941;
        Thu, 20 Mar 2025 04:31:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ea197sm23168764f8f.84.2025.03.20.04.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:31:06 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:31:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Message-ID: <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
 <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>

On Fri, Mar 14, 2025 at 04:25:16PM +0100, Michal Luczaj wrote:
>On 3/10/25 16:24, Stefano Garzarella wrote:
>> On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>>> ...
>>> I've tried modifying the loop to make close()/shutdown() linger until
>>> unsent_bytes() == 0. No idea if this is acceptable:
>>
>> Yes, that's a good idea, I had something similar in mind, but reusing
>> unsent_bytes() sounds great to me.
>>
>> The only problem I see is that in the driver in the guest, the packets
>> are put in the virtqueue and the variable is decremented only when the
>> host sends us an interrupt to say that it has copied the packets and
>> then the guest can free the buffer. Is this okay to consider this as
>> sending?
>>
>> I think so, though it's honestly not clear to me if instead by sending
>> we should consider when the driver copies the bytes into the virtqueue,
>> but that doesn't mean they were really sent. We should compare it to
>> what the network devices or AF_UNIX do.
>
>I had a look at AF_UNIX. SO_LINGER is not supported. Which makes sense;
>when you send a packet, it directly lands in receiver's queue. As for
>SIOCOUTQ handling: `return sk_wmem_alloc_get(sk)`. So I guess it's more of
>an "unread bytes"?

Yes, I see, actually for AF_UNIX it is simple.
It's hard for us to tell when the user on the other pear actually read
the data, we could use the credit mechanism, but that sometimes isn't
sent unless explicitly requested, so I'd say unsent_bytes() is fine.

>
>>> +void vsock_linger(struct sock *sk, long timeout)
>>> +{
>>> +	if (timeout) {
>>> +		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>> +		ssize_t (*unsent)(struct vsock_sock *vsk);
>>> +		struct vsock_sock *vsk = vsock_sk(sk);
>>> +
>>> +		add_wait_queue(sk_sleep(sk), &wait);
>>> +		unsent = vsk->transport->unsent_bytes;
>>
>> This is not implemented by all transports, so we should handle it in
>> some way (check the pointer or implement in all transports).
>
>Ah, right, I didn't think that through.
>
>>> @@ -1056,6 +1075,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
>>> 		if (sock_type_connectible(sk->sk_type)) {
>>> 			sock_reset_flag(sk, SOCK_DONE);
>>> 			vsock_send_shutdown(sk, mode);
>>> +			if (sock_flag(sk, SOCK_LINGER))
>>> +				vsock_linger(sk, sk->sk_lingertime);
>>
>> mmm, great, so on shutdown we never supported SO_LINGER, right?
>
>Yup.
>
>>> ...
>>> This works, but I find it difficult to test without artificially slowing
>>> the kernel down. It's a race against workers as they quite eagerly do
>>> virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>>> I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>>> send() would just block until peer had available space.
>>
>> Did you test with loopback or virtio-vsock with a VM?
>
>Both, but I may be missing something. Do you see a way to stop (or don't
>schedule) the worker from processing queue (and decrementing bytes_unsent)?

Without touching the driver (which I don't want to do) I can't think of
anything, so I'd say it's okay.

Thanks,
Stefano


