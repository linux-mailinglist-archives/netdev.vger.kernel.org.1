Return-Path: <netdev+bounces-178557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D747A778DE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E8716A2F8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6028E1EFF8C;
	Tue,  1 Apr 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOGUbvO9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5D1519B8
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503581; cv=none; b=i1E+gUOFZz+BsBN9DsKEHBCtCJjgdyS+pDOjKD1M/xsG6MDFUEnJEAWPlmzWllGOLAYx1yH2jPatUyhkcc0ESqLAYfZIw7Jgwmc2AtIWFM5GoAM3sNrvMfiGqLiGP51TLKTibjbvrvvSk68Fdee15yEohZnnUUh60g3MMECdmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503581; c=relaxed/simple;
	bh=QArgkVBhdmQ0EwLOryTjYfrwmRzIux1XiQRL70HH2dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tArU14dlHuBVXWEuZ6QjxK5fewKTPGYmaaYv0eoHD7coblXSXhkzrCOr+iR1x+JdEazC/7yR4dGVx3SvZttVzixbCmOjKDEc2qFmlIvYi6n0Twiik2rL6QAq66R1MnrqXFio9iQ9VKGNcrO+j6DampaKXgAOo4B8RdyXPL3zKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOGUbvO9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743503578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1CikcrhQ5Hvzq5QreMHsg0BJZv6lAm2A9H81S8gb1E=;
	b=LOGUbvO9VPixgNxOKg4tmJZ+gSD2cJEEslM8CnuDsX+Mc9ACQK4b+tMkVHKetsigImmlwN
	xOAo+bp7OkIv+v+IpX7TEo5f2cggoty2mgH/K7QGrRr6Q8nY1lMhwixrl1xrV3/jfxgjNV
	gbUrxmMUjvChj61FKtxIn2HBdDFqRNY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-j0xfllq1PtyzDT4k016zUw-1; Tue, 01 Apr 2025 06:32:57 -0400
X-MC-Unique: j0xfllq1PtyzDT4k016zUw-1
X-Mimecast-MFC-AGG-ID: j0xfllq1PtyzDT4k016zUw_1743503576
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913f546dfdso2803215f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503575; x=1744108375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1CikcrhQ5Hvzq5QreMHsg0BJZv6lAm2A9H81S8gb1E=;
        b=CA8qWSxjiLCwoYcuGvrEuvASlvglRpGOE397aLmlOskp0BVeqKFUzHSquSWZh2vs9H
         DG09BnuxqDkMax7VAMjUbHIATURJWy3aAmZV/t5BbcmZOEfMb78PAUIUrOcdRcAdIQbS
         ORKqtLwhWCf3rATFAeaydUUlde1n8P1deLLllsB06+UvKmAe6JYazdbw43usS/9H8MVl
         WWOwwM0Qb4RZTxfjgZ9gprMN4Uu7ASKD/Lqv9+Xnz6v/W3U2zkSaelK50/6ZnDne8Ahy
         n7FvZ9qCbWRLcPMTxDH59GN3bx+CKJURv8aWoVSodqKZH2i4E9hngu6XQGSsHryVB26h
         oxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh+sJ36g3jNNBE/CrBYZ6PFyKtDyLu8wJGtogE9h1qqyHQag3zuCKFTeF+WDLJRfPHKutk1nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8gQdR2odudrXaRsQQUoC+YvD8kCHnV0fOSv28MALdq16vnLo
	Crsnj2w7LxZYjx11hIsvUynnllHDkrsI8Soh6RFdrg/HuuNqUScdIHk1cHrfrbILd3/oZQUV51W
	RCI3kEonXTst87JrXzXqnpNS70NLeWa6aMgQoxX7sXj8K23nDxS4GTEoQssGfC8P2
X-Gm-Gg: ASbGncsz2xrM03TwtSRIisbfndbqHCPzGGaysMiSE1DqY5R1VKoPKR2ejH+bXSm03/P
	gwr3HGdopRvrYMTSXPa3oxzmDqlwIkfE4ArezEinXC8Fri7qveHD0IH94H/HifkNLT4ERabMrxG
	cMlxghv7yjzQ9Uf8XI64E8nzXPyiKK5dp9w2onmX/X48YndlJLNJC5rElgctpImOoU0btcIEz+t
	JuHvqcXDnz30PlBDS0bBw2zlDexjU8URbGUmPwKEyUHyzJtlqWmIPCLsZmQhwjCRXR2c6Sf0Hm1
	miYiaVONBE3JFLGkbP4aVZ8pTRovdJcWocnfLdt/SsG0cIZJL0pD6GY/1SA=
X-Received: by 2002:a5d:47c5:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-39c120dec24mr10524955f8f.13.1743503575494;
        Tue, 01 Apr 2025 03:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGQVLpTu6N3/mt692gxtdNYt7ybuWAdlYXw7I9Qnh1fsoYuPNGTp1taMSpCOrXIS5FZ4XzRQ==
X-Received: by 2002:a5d:47c5:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-39c120dec24mr10524926f8f.13.1743503574953;
        Tue, 01 Apr 2025 03:32:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b665707sm14020434f8f.38.2025.04.01.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:32:54 -0700 (PDT)
Date: Tue, 1 Apr 2025 12:32:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Message-ID: <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>

On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>On 3/20/25 12:31, Stefano Garzarella wrote:
>> On Fri, Mar 14, 2025 at 04:25:16PM +0100, Michal Luczaj wrote:
>>> On 3/10/25 16:24, Stefano Garzarella wrote:
>>>> On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> I've tried modifying the loop to make close()/shutdown() linger until
>>>>> unsent_bytes() == 0. No idea if this is acceptable:
>>>>
>>>> Yes, that's a good idea, I had something similar in mind, but reusing
>>>> unsent_bytes() sounds great to me.
>>>>
>>>> The only problem I see is that in the driver in the guest, the packets
>>>> are put in the virtqueue and the variable is decremented only when the
>>>> host sends us an interrupt to say that it has copied the packets and
>>>> then the guest can free the buffer. Is this okay to consider this as
>>>> sending?
>>>>
>>>> I think so, though it's honestly not clear to me if instead by sending
>>>> we should consider when the driver copies the bytes into the virtqueue,
>>>> but that doesn't mean they were really sent. We should compare it to
>>>> what the network devices or AF_UNIX do.
>>>
>>> I had a look at AF_UNIX. SO_LINGER is not supported. Which makes sense;
>>> when you send a packet, it directly lands in receiver's queue. As for
>>> SIOCOUTQ handling: `return sk_wmem_alloc_get(sk)`. So I guess it's more of
>>> an "unread bytes"?
>>
>> Yes, I see, actually for AF_UNIX it is simple.
>> It's hard for us to tell when the user on the other pear actually read
>> the data, we could use the credit mechanism, but that sometimes isn't
>> sent unless explicitly requested, so I'd say unsent_bytes() is fine.
>
>One more option: keep the semantics (in a state of not-what-`man 7 socket`-
>says) and, for completeness, add the lingering to shutdown()?

Sorry, I'm getting lost!
That's because we had a different behavior between close() and 
shutdown() right?

If it's the case, I would say let's fix at least that for now.

>
>>>>> ...
>>>>> This works, but I find it difficult to test without artificially slowing
>>>>> the kernel down. It's a race against workers as they quite eagerly do
>>>>> virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>>>>> I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>>>>> send() would just block until peer had available space.
>>>>
>>>> Did you test with loopback or virtio-vsock with a VM?
>>>
>>> Both, but I may be missing something. Do you see a way to stop (or don't
>>> schedule) the worker from processing queue (and decrementing bytes_unsent)?
>>
>> Without touching the driver (which I don't want to do) I can't think of
>> anything, so I'd say it's okay.
>
>Turns out there's a way to purge the loopback queue before worker processes
>it (I had no success with g2h). If you win that race, bytes_unsent stays
>elevated until kingdom come. Then you can close() the socket and watch as
>it lingers.
>
>connect(s)
>  lock_sock
>  while (sk_state != TCP_ESTABLISHED)
>    release_sock
>    schedule_timeout
>
>// virtio_transport_recv_connecting
>//   sk_state = TCP_ESTABLISHED
>
>                                       send(s, 'x')
>                                         lock_sock
>                                         virtio_transport_send_pkt_info
>                                           virtio_transport_get_credit
>                                    (!)      vvs->bytes_unsent += ret
>                                           vsock_loopback_send_pkt
>                                             virtio_vsock_skb_queue_tail
>                                         release_sock
>                                       kill()
>    lock_sock
>    if signal_pending
>      vsock_loopback_cancel_pkt
>        virtio_transport_purge_skbs (!)
>
>That said, I may be missing a bigger picture, but is it worth supporting
>this "signal disconnects TCP_ESTABLISHED" behaviour in the first place?

Can you elaborate a bit?

>Removing it would make the race above (and the whole [1] series) moot.
>Plus, it appears to be broken: when I hit this condition and I try to
>re-connect to the same listener, I get ETIMEDOUT for loopback and
>ECONNRESET for g2h virtio; see [2].

Could this be related to the fix I sent some days ago?
https://lore.kernel.org/netdev/20250328141528.420719-1-sgarzare@redhat.com/

Thanks,
Stefano


