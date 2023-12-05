Return-Path: <netdev+bounces-53965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CC80572B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485081F215C7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C765EB1;
	Tue,  5 Dec 2023 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G12L9azg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA6B9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701786137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9IZpMPIi3jSZTsC7HLeV6BNERkHoH4xs1hFKXipffA=;
	b=G12L9azg5MaeT/0eLhHxF5hmIuk4sk7MoBR3ReZqoGDPbqmmZo5iliE+YlpkcDKiHvI7dS
	HFUctw9r3lXuv1icNCxNOGEtgPF65NdGx2mPGuUgsUOTIA4rCbnvXPB6+lYrQzxYevg7yc
	PJ8Qrn2WWHwdGNW3cjiDdqIkn0BmU50=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-HlPM7iNbN_e3DadELe0CjQ-1; Tue, 05 Dec 2023 09:22:16 -0500
X-MC-Unique: HlPM7iNbN_e3DadELe0CjQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d87f0b71aeso4021192a34.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 06:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786135; x=1702390935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9IZpMPIi3jSZTsC7HLeV6BNERkHoH4xs1hFKXipffA=;
        b=iYPY0jzLj0aVTWv/hic0Dyq8w7u9kOqRBLITkiXZ6cT3B8vPhMabJrR6yYH1ncXFiZ
         VijnVMzUc9NR6VvquMYCIMNVZZfgH4bCQXuPYuP06cvhoIP9sHjkeRE8z3hAmhpwVL9b
         5kZRGdw+IsjaW5ogA/xLBNunEIE7Vi3Kj2YY1c3txAFok53sGRTaKFKOPdQRstCkqPTH
         uR00kVKvcSKrmjTcZVCc3LcQNoPCUsCVDARJSu8yg/I8ssO0EXxG7u2e/uFi36ti6OsT
         m/blf7UJ1fMcxpimdj+QG/UTFC6bPJ+NO4haoh8zGysgT9FXLqwRZcMLjklr+p45GNro
         Bsuw==
X-Gm-Message-State: AOJu0Yzt0K3Dru+Eq87umG+u6d5LDLgZRds8mkr39EONQjIGWlpp/3B6
	7FjvWjotIXZV5wAunHt3+W3i3qNga9Sq1srTQbn2s5LQsj0me20hQtMiUNDb0Dx36pfD+DPHOP6
	6ahw8jtyGBkKdDxBH
X-Received: by 2002:a9d:6f82:0:b0:6d8:7afe:7867 with SMTP id h2-20020a9d6f82000000b006d87afe7867mr4894118otq.73.1701786135650;
        Tue, 05 Dec 2023 06:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQM0DUJ5PkREYuL7J0Iqz04MrH5aEKcLNe4Q826QNJ3Y8wTHvA1ssEqjnGPP+m4NlCYhCYxg==
X-Received: by 2002:a9d:6f82:0:b0:6d8:7afe:7867 with SMTP id h2-20020a9d6f82000000b006d87afe7867mr4894106otq.73.1701786135338;
        Tue, 05 Dec 2023 06:22:15 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-125.retail.telecomitalia.it. [79.46.200.125])
        by smtp.gmail.com with ESMTPSA id f17-20020ac84651000000b00423dbb19262sm5169011qto.78.2023.12.05.06.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:22:14 -0800 (PST)
Date: Tue, 5 Dec 2023 15:21:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v6 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <gqrfreguavurkb7betm2utzdfnefrxgxyoilyveowvmspbwpes@45s6jshyelui>
References: <20231205064806.2851305-1-avkrasnov@salutedevices.com>
 <20231205064806.2851305-4-avkrasnov@salutedevices.com>
 <v335g4fjrn5f6tsw4nysztaklze2obnjwpezps3jgb2xickpge@ea5woxob52nc>
 <809a8962-0082-6443-4e59-549eb28b9a82@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <809a8962-0082-6443-4e59-549eb28b9a82@salutedevices.com>

On Tue, Dec 05, 2023 at 03:07:47PM +0300, Arseniy Krasnov wrote:
>
>
>On 05.12.2023 13:54, Stefano Garzarella wrote:
>> On Tue, Dec 05, 2023 at 09:48:05AM +0300, Arseniy Krasnov wrote:
>>> Add one more condition for sending credit update during dequeue from
>>> stream socket: when number of bytes in the rx queue is smaller than
>>> SO_RCVLOWAT value of the socket. This is actual for non-default value
>>> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
>>> transmission, because we need at least SO_RCVLOWAT bytes in our rx
>>> queue to wake up user for reading data (in corner case it is also
>>> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
>>>
>>> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index e137d740804e..461c89882142 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -558,6 +558,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>     struct virtio_vsock_sock *vvs = vsk->trans;
>>>     size_t bytes, total = 0;
>>>     struct sk_buff *skb;
>>> +    bool low_rx_bytes;
>>>     int err = -EFAULT;
>>>     u32 free_space;
>>>
>>> @@ -602,6 +603,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>     }
>>>
>>>     free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>>> +    low_rx_bytes = (vvs->rx_bytes <
>>> +            sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>>
>> As in the previous patch, should we avoid the update it if `fwd_cnt` and `last_fwd_cnt` are the same?
>>
>> Now I'm thinking if it is better to add that check directly in virtio_transport_send_credit_update().
>
>Good point, but I think, that it is better to keep this check here, because access to 'fwd_cnt' and 'last_fwd_cnt'
>requires taking rx_lock - so I guess it is better to avoid taking this lock every time in 'virtio_transport_send_credit_update()'.

Yeah, I agree.

>So may be we can do something like:
>
>
>fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>free_space = vvs->buf_alloc - fwd_cnt_delta;

Pre-existing issue, but should we handle the wrap (e.g. fwd_cnt wrapped, 
but last_fwd_cnt not yet?). Maybe in that case we can foce the status
update.

>
>and then, after lock is released:
>
>if (fwd_cnt_delta && (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>    low_rx_bytes))
>        virtio_transport_send_credit_update(vsk);
>
>WDYT?

Yep, I agree.

>
>Also, I guess that next idea to update this optimization(in next patchset), is to make
>threshold depends on vvs->buf_alloc. Because if someone changes minimum buffer size to
>for example 32KB, and then sets buffer size to 32KB, then free_space will be always
>non-zero, thus optimization is off now and credit update is sent on 
>every read.

But does it make sense to allow a buffer smaller than 
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE?

Maybe we should fail in virtio_transport_notify_buffer_size() or use it 
as minimum.

Stefano


