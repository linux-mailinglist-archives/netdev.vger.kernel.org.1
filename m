Return-Path: <netdev+bounces-55858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386180C8DD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1451F217CF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E803986D;
	Mon, 11 Dec 2023 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9/Dxd9m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1010D9
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702296108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqzvj1BVA/xUscvTFwnIQ16B6kfl78jXgo5T95qDUwM=;
	b=E9/Dxd9mvCgfL6uQPEBenTc/UVLMOwN9ELCCQncTNzwTLih1ISskxe67l5tE4f4mo7cNab
	yA0Fm//Aq/cc+1Pt+UHsHiuWmqoOMCqG3RGr1eTcj79W5AbVRGv8qK2OCQUPDRiDnKW/s4
	pUx8phtqjOmFbIlD1E9jh5yjQjVjvd8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-dIE88yWZM9id0eaPKkRWHw-1; Mon, 11 Dec 2023 07:01:47 -0500
X-MC-Unique: dIE88yWZM9id0eaPKkRWHw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a8a7f2c76so60010256d6.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296107; x=1702900907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqzvj1BVA/xUscvTFwnIQ16B6kfl78jXgo5T95qDUwM=;
        b=MDUzxQyu4/jJKvX4K1Oe+shVSuRd3US4m9lar3SRHzRbDDZB3lOVxBZt6NYcYkEDYl
         r0jKrAUJ++JoiqtUNmXyUUH8YFVjmz/4uKvKmvmxmkeQ6O09f+NqrL2vjNBxrp8pFfwW
         xjBclq8AopiXCuLpqfCDDeI9WBROOlllq+ILlJ1zG+0MzUzI3b9R66qrXr04F4xB6PCI
         B9MH2mASRZzg4Qy8YxrUwqLYzOYgISkDb3kHH1DQFqE5rqb1usELBE/wJLSO8jaAnc+z
         stnqPPUHgGXMDUIfwv3UasJ84I/Q1Uti/tv7DSWtwmH1ut2STy43yJhtt2ZrnCtkwdAG
         kJkQ==
X-Gm-Message-State: AOJu0Yz6A9uDrdxJysMKFMEpYrRqv1lU8PXXGSQBH0OI8HjzsvqK2xMY
	7BYwCaU87lxodPwbjLRlDWx7ISD4SIGTnQ18QPdPq2a+PVjqwMJ2RTg0Bls0LP6YTJ7NwKz5H6C
	NvNGs+I1uZYHyc1LC
X-Received: by 2002:a05:6214:f66:b0:67a:b963:5ae with SMTP id iy6-20020a0562140f6600b0067ab96305aemr9074358qvb.45.1702296106730;
        Mon, 11 Dec 2023 04:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJe0L6QdS4nGwvEb9tjBx33wTgJG4fosHSmbpSVi1Tq8yvZi8qUQYj5rcbM7XZsEBl/CmTNw==
X-Received: by 2002:a05:6214:f66:b0:67a:b963:5ae with SMTP id iy6-20020a0562140f6600b0067ab96305aemr9074332qvb.45.1702296106415;
        Mon, 11 Dec 2023 04:01:46 -0800 (PST)
Received: from sgarzare-redhat ([95.131.45.143])
        by smtp.gmail.com with ESMTPSA id v16-20020a0cf910000000b0067a53aa6df2sm3232285qvn.46.2023.12.11.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:01:46 -0800 (PST)
Date: Mon, 11 Dec 2023 13:01:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v7 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <s5v5hbr2memhwoqm3fxbkq6qsocs43qgyhx432zzy6ugbqhuu2@rsnm3kiwfwjm>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
 <20231206165045-mutt-send-email-mst@kernel.org>
 <d9d1ec6a-dd9b-61d9-9211-52e9437cbb1f@salutedevices.com>
 <20231206170640-mutt-send-email-mst@kernel.org>
 <d30a1df7-ecda-652d-8c98-853308a560c9@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d30a1df7-ecda-652d-8c98-853308a560c9@salutedevices.com>

On Thu, Dec 07, 2023 at 01:50:05AM +0300, Arseniy Krasnov wrote:
>
>
>On 07.12.2023 01:08, Michael S. Tsirkin wrote:
>> On Thu, Dec 07, 2023 at 12:52:51AM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 07.12.2023 00:53, Michael S. Tsirkin wrote:
>>>> On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
>>>>> Add one more condition for sending credit update during dequeue from
>>>>> stream socket: when number of bytes in the rx queue is smaller than
>>>>> SO_RCVLOWAT value of the socket. This is actual for non-default value
>>>>> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
>>>>> transmission, because we need at least SO_RCVLOWAT bytes in our rx
>>>>> queue to wake up user for reading data (in corner case it is also
>>>>> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
>>>>> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
>>>>> not.
>>>>>
>>>>> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>>> ---
>>>>>  Changelog:
>>>>>  v6 -> v7:
>>>>>   * Handle wrap of 'fwd_cnt'.
>>>>>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
>>>>>
>>>>>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
>>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index e137d740804e..39f8660d825d 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>>  	struct virtio_vsock_sock *vvs = vsk->trans;
>>>>>  	size_t bytes, total = 0;
>>>>>  	struct sk_buff *skb;
>>>>> +	u32 fwd_cnt_delta;
>>>>> +	bool low_rx_bytes;
>>>>>  	int err = -EFAULT;
>>>>>  	u32 free_space;
>>>>>
>>>>> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>>>>> +	/* Handle wrap of 'fwd_cnt'. */
>>>>> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
>>>>> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);
>>>>
>>>> Are you sure there's no off by one here? for example if fwd_cnt is 0
>>>> and last_fwd_cnt is 0xfffffffff then apparently delta is 0.
>>>
>>> Seems yes, I need +1 here
>>
>> And then you will get a nop, because assigning U32_MAX + 1 to u32
>> gives you 0. Adding () does nothing to change the result,
>> + and - are commutative.
>
>Ahh, unsigned here, yes.

Ooops, sorry I was confused here!

>
>@Stefano, what did You mean about wrapping here?
>
>I think Michael is right, for example

Yep, I agree!
Sorry for this wrong suggestion!

Stefano

>
>vvs->fwd_cnt wraps and now == 5
>vvs->last_fwd_cnt == 0xffffffff
>
>now delta before this patch will be 6 - correct value
>
>May be I didn't get your idea, so implement it very naive?
>
>Thanks, Arseniy
>
>>
>>
>>>>
>>>>
>>>>> +	else
>>>>> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>>>>
>>>> I actually don't see what is wrong with just
>>>> 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
>>>> 32 bit unsigned math will I think handle wrap around correctly.
>>>>
>>>> And given buf_alloc is also u32 - I don't see where the bug is in
>>>> the original code.
>>>
>>> I think problem is when fwd_cnt wraps, while last_fwd_cnt is not. In this
>>> case fwd_cnt_delta will be too big, so we won't send credit update which
>>> leads to stall for sender
>>>
>>> Thanks, Arseniy
>>
>> Care coming up with an example?
>>
>>
>>>>
>>>>
>>>>> +
>>>>> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
>>>>> +	low_rx_bytes = (vvs->rx_bytes <
>>>>> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>>>>>
>>>>>  	spin_unlock_bh(&vvs->rx_lock);
>>>>>
>>>>> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>>  	 * too high causes extra messages. Too low causes transmitter
>>>>>  	 * stalls. As stalls are in theory more expensive than extra
>>>>>  	 * messages, we set the limit to a high value. TODO: experiment
>>>>> -	 * with different values.
>>>>> +	 * with different values. Also send credit update message when
>>>>> +	 * number of bytes in rx queue is not enough to wake up reader.
>>>>>  	 */
>>>>> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>>>>> +	if (fwd_cnt_delta &&
>>>>> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>>>>>  		virtio_transport_send_credit_update(vsk);
>>>>>
>>>>>  	return total;
>>>>> --
>>>>> 2.25.1
>>>>
>>
>


