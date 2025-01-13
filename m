Return-Path: <netdev+bounces-157784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D210A0BB2E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD10516AE0C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1541FBBD8;
	Mon, 13 Jan 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzoGvqvW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DDA1FBBD2
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780498; cv=none; b=F/9hkarxAOrndU9uIg/LiVRHhupTL8Kqlhb5RibUn/mZQH+wffknffa0tCl96pyU3z0OobBZjYjB1ulR+VZfw+pyv0aPOVOnT5a+LCaGVcaqjYN+WT4x+Ds6jKZMcS7iACa+0l4ArwPK2GCisAboq0uuyywQ9+x1xYyEnONzsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780498; c=relaxed/simple;
	bh=kRR1+QzVmvo3iRgs0Rx+6BPBHxGoHd17FoeRkxQMy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI9/wMKouYDg/zOyZBOYnQv/4bY9IZpYA7pb0ND7krMyNvY/YlG4UPtDxKB77ovrf9QoKET0rqzUP5n7J2B/f3sCuXZquSCJb3EZLyOATsaOx9rRXZ8aWem178JpIZJ9YlgU6YtGVlgD91B1noSsM9EJsv54McEgnsSU2eVEq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzoGvqvW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736780494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yf80rtmCXKEEVXHQYDbWk5EecSmCyvTI8cS1zfM35E=;
	b=LzoGvqvW82P0FiOIWJUZRkf7xjr0L3yCyYHBG4tsPgofIc3K6rsvSUsQM99K1bu8aLthcd
	UGkxyjg1KOOKp7/TC6YnOTfG98QEIdG9BzZaUVZ1zgFubGq6UMoJ+Qvbdplm60+A/eOsu+
	9OF5mvWUxkU1fdcmHwE+pIU1Vhj/IXk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-Za2mGRTXPiSONWdOOgODfQ-1; Mon, 13 Jan 2025 10:01:31 -0500
X-MC-Unique: Za2mGRTXPiSONWdOOgODfQ-1
X-Mimecast-MFC-AGG-ID: Za2mGRTXPiSONWdOOgODfQ
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6e1b0373bso695324685a.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780490; x=1737385290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yf80rtmCXKEEVXHQYDbWk5EecSmCyvTI8cS1zfM35E=;
        b=YoXsqXQmmIa7cl0bM/HQsztRZHCRMQ6I9yPKwCoqeWw9unWpbMJ9A98yD+OSoaJQU6
         7NZzoN6y5n4GRbOqkce38MAJBM9wFQ2KwHhOjfJ3H1Mk/JpfauqHLBLw1GPmJLgOOKhH
         3ezc8ea2GtuEPhuRPJOaoeXVgLNxXmlz2rSSdBiOSMKJ67+QHth6bcsAOo8dK3cuM0tG
         13vjnjZ/D6/y+to46T58zgRNBt95d2z9LGc6HCpEGWjP6EPFEoBBNKWnpxa+c7Pudn0g
         xNwuNbfu1R5Azw/nYJm++s6JkRa03qUrVb71ilUn7Ao/YFOotqpUxFLYbu+4SOQ59BZ5
         r6TQ==
X-Gm-Message-State: AOJu0YzzyctV7ecEUKbJ00IdiVEZ/hOrHWHvqulOLYlLbCgMcn/zGd9z
	XIv8vVSpXrsKzU6crPzRIoStr2tka3dt+bTcXmhUIk+KMDmodJVHLQQZGmiJopk5S2KXCpQJYBP
	z9DJndsbCnFm/D+a1DCRBsjsO2ugBvOxURnri6XCAn3V5uJqwYGsvRg==
X-Gm-Gg: ASbGnctgBAMiHfn3Edqtltf172nTYxplj/jz+aEP/luw+bLEzEmWToTPQBvcwnt0TZF
	rAeL3rYKmW1O2mM1DucJ1FNllynM5rPbx458eP1gjUKfsRzPVA40d/aGc1mzfRYMreel2b3enxj
	IUwvbr2wIwEbpJxoSMAQuYbFyCv/wdPAYBgisY79YxgvhoTJT0f6B7aGBqIBBSx29Xly39l65i9
	OdL+BIvpAdiZh+Z7Ac/jzCX1vLKbikmU1WE6LfNgdu4gvbb1wWZp6TpV9SJCuUT3xHaJ5xIusu1
	4js9KcNrLWWfpQkzI0Q+B3yK3p1EVmgp
X-Received: by 2002:a05:620a:3726:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bcd9759b5cmr3148821985a.45.1736780490414;
        Mon, 13 Jan 2025 07:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmhCA+6joXrA0wKVaaHTe7fd/trt2RKjBSiBo73zD2W/+WWXHhQD1dIWKITENXxjV/Gx6S4g==
X-Received: by 2002:a05:620a:3726:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bcd9759b5cmr3148813685a.45.1736780489785;
        Mon, 13 Jan 2025 07:01:29 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35042eesm496383085a.86.2025.01.13.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:01:29 -0800 (PST)
Date: Mon, 13 Jan 2025 16:01:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
 <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>

On Mon, Jan 13, 2025 at 02:51:58PM +0100, Michal Luczaj wrote:
>On 1/13/25 12:05, Stefano Garzarella wrote:
>> On Mon, Jan 13, 2025 at 11:12:52AM +0100, Michal Luczaj wrote:
>>> On 1/13/25 10:07, Stefano Garzarella wrote:
>>>> On Mon, 13 Jan 2025 at 09:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>> On Sun, Jan 12, 2025 at 11:42:30PM +0100, Michal Luczaj wrote:
>>>>
>>>> [...]
>>>>
>>>>>>
>>>>>> So, if I get this right:
>>>>>> 1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
>>>>>> 2. transport->release() calls vsock_remove_bound() without checking if sk
>>>>>>   was bound and moved to bound list (refcnt=1)
>>>>>> 3. vsock_bind() assumes sk is in unbound list and before
>>>>>>   __vsock_insert_bound(vsock_bound_sockets()) calls
>>>>>>   __vsock_remove_bound() which does:
>>>>>>      list_del_init(&vsk->bound_table); // nop
>>>>>>      sock_put(&vsk->sk);               // refcnt=0
>>>>>>
>>>>>> The following fixes things for me. I'm just not certain that's the only
>>>>>> place where transport destruction may lead to an unbound socket being
>>>>>> removed from the unbound list.
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>>> index 7f7de6d88096..0fe807c8c052 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>> @@ -1303,7 +1303,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
>>>>>>
>>>>>>       if (remove_sock) {
>>>>>>               sock_set_flag(sk, SOCK_DONE);
>>>>>> -              virtio_transport_remove_sock(vsk);
>>>>>> +              if (vsock_addr_bound(&vsk->local_addr))
>>>>>> +                      virtio_transport_remove_sock(vsk);
>>>>>
>>>>> I don't get this fix, virtio_transport_remove_sock() calls
>>>>>    vsock_remove_sock()
>>>>>      vsock_remove_bound()
>>>>>        if (__vsock_in_bound_table(vsk))
>>>>>            __vsock_remove_bound(vsk);
>>>>>
>>>>>
>>>>> So, should already avoid this issue, no?
>>>>
>>>> I got it wrong, I see now what are you trying to do, but I don't think
>>>> we should skip virtio_transport_remove_sock() entirely, it also purge
>>>> the rx_queue.
>>>
>>> Isn't rx_queue empty-by-definition in case of !__vsock_in_bound_table(vsk)?
>>
>> It could be.
>>
>> But I see some other issues:
>> - we need to fix also in the other transports, since they do the same
>
>Ahh, yes, VMCI and Hyper-V would need that, too.
>
>> - we need to check delayed cancel work too that call
>>    virtio_transport_remove_sock()
>
>That's the "I'm just not certain" part. As with rx_queue, I though delayed
>cancel can only happen for a bound socket. So, per architecture, no need to
>deal with that here, right?

I think so.

>
>> An alternative approach, which would perhaps allow us to avoid all this,
>> is to re-insert the socket in the unbound list after calling release()
>> when we deassign the transport.
>>
>> WDYT?
>
>If we can't keep the old state (sk_state, transport, etc) on failed
>re-connect() then reverting back to initial state sounds, uhh, like an
>option :) I'm not sure how well this aligns with (user's expectations of)
>good ol' socket API, but maybe that train has already left.

We really want to behave as similar as possible with the other sockets,
like AF_INET, so I would try to continue toward that train.

>
>Another possibility would be to simply brick the socket on failed (re)connect.
>

I see, though, this is not the behavior of AF_INET for example, right?

Do you have time to investigate/fix this problem?
If not, I'll try to look into it in the next few days, maybe next week.

Thanks,
Stefano


