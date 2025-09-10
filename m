Return-Path: <netdev+bounces-221761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F0B51C96
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113F218823EB
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3CB32CF8D;
	Wed, 10 Sep 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZpfVRhf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B33327A19
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519759; cv=none; b=I9OLyGPHX15A4tMQx6HxLKM9bttPYSBwjVPyF7e2vKoVd7O44g+1SosnVCE+UXwU2Xkf5vb8t57gWpsMoqirJG4O7FyKLxR0AxQKLprUWOeTZhJne0Uz4EbnfGWOMG6Uo0lalYvxKtx+yXPxq+uVW3PtpJzetueZUumS+e3pTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519759; c=relaxed/simple;
	bh=JbkGbKmGymGSLLsdUZaBOo51FNEi13jYTbdjLpf1unA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCaHHEDczJW8xTwXnJoJD4kaxlUrzw7lwxZXzBIAxK3qCZBa+zAciLmtm3CRpO3J/6KCiUWWLcKRlyK6T0hgr3IEQopZwJkPcu3PSDw3txu/P3xDidDn7gyCYRXJJWZt35E9W/yTWGXJSalK0ZB0PeGlYyjpCFAnzghEnRe2XBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZpfVRhf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757519756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RAbP5UJcO2BtVVPAKVuEh/4gKQck7zOlT1pd89BKDw=;
	b=LZpfVRhf+TQDh6yiv16sYtGmEJnkDGT1RnqhUlSuUG0ifVhxBXLFX47Wu6qQosiJ4CKudj
	c2uQsUSJprvsQOMI8uq2xOeMv35nrBIKwoEBHq+Hq7+uDCAMUspUN+pG6eC9h6V6dxMSdu
	M4pRYcrj60tB5HblmvuFiyMouohq81c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-FHHhVv2PNG-lPxRKlydMvg-1; Wed, 10 Sep 2025 11:55:52 -0400
X-MC-Unique: FHHhVv2PNG-lPxRKlydMvg-1
X-Mimecast-MFC-AGG-ID: FHHhVv2PNG-lPxRKlydMvg_1757519752
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b04206e3d7eso70256266b.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519751; x=1758124551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RAbP5UJcO2BtVVPAKVuEh/4gKQck7zOlT1pd89BKDw=;
        b=N/zKqJVGzgW1+4S9xr+3mLlD5fR3yiMI8sxl1md9tc67Dxxwbf2CT8rRaZD7rN8qh1
         AIEBCh4D/Xfqi1LdE3jHnBe2dztT1TnLXUXcsacXUriWrzSIQXa9StfZqF7JsLnIHNCM
         xvld1wllkwb4seDDXq8upfH1gYyV4v5j1MAc/xthsuuY5LU7rP1L3yv+Mnn3ZgI3Fo8W
         tPaIy3pS6GGgLE0NAH1eX4rZy1lsVo8iHmaI7V+PHurR6p+sy1Vvs09/mkdBcH+DPIdv
         5QQidYsaymukStyjW88pM9iEXVPjoX7uxc+/oMAvx9yCw7PZ38B4j6LrnySjt/Md0aWF
         495Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+JtTeqreZ9RuETMKiH4ZbRpuf6nveJXETBNEJkt9a5Q7Klm2a3oW4mlk0lJUGconVhNX8UVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZO36u/KBTppdwJtRjTVBgrvenYoGW2WoqiKfFm01IqL3itTe
	e4gov2spwjvbfxsXSlB08qDfves5QbAy4pqY5paRn7KHb7XuE4TjJCQi/agCJBLtZSCkIMF6sDu
	CiGmP8haV0aXdyXMRvDpywsc0Uutq8vQlnMIPwxkZTsGl4Nv+JPnhch5XlA==
X-Gm-Gg: ASbGncseHp2xLHONvLNheDve8re3rE0ucW+L1KNf6MknKLPrrbOV1yvU0qYlkoOpxJ9
	s0uWgqb1Ihr5nhxqcIo3jBLK1G+iiLiRUuZ+E+QBpSP+xFmnBjTZgE+Tp1S5oILl9t423PoQyZR
	PHEM2s0Fq6H4TD4JEM+zh+fVSWfZVCwmXHCjCZT/Y7bNuT9a/EiFl43mi/5xttDEpypCycvbh9M
	VKC9LCtdcmpcIVYc7CIEglDhYCDgpLC+0tHVNqRoz8meKt1fZfyWf9C6G9ok4n4wbX201tgfmAD
	8FlfBzbzsIYRambYfoIGM4OMftR9kyjEBb7pVOqIIveyk+7GAd4PCy2bH5JXSy5gUpnA/9nzm+a
	97xW38dL2ns+0wTmK
X-Received: by 2002:a17:907:6d20:b0:af9:70f0:62e3 with SMTP id a640c23a62f3a-b07a648ed52mr11274166b.15.1757519751560;
        Wed, 10 Sep 2025 08:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4scsY5n/QsLA6mG0sjvrsfoCoD0h3ZgLanYsu42CsuN5gQm2fBKl3Hy6FexJBMaEtSlxTnw==
X-Received: by 2002:a17:907:6d20:b0:af9:70f0:62e3 with SMTP id a640c23a62f3a-b07a648ed52mr11271166b.15.1757519751033;
        Wed, 10 Sep 2025 08:55:51 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-93.business.telecomitalia.it. [87.12.185.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334dd71sm180635766b.61.2025.09.10.08.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:55:50 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:55:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, Mike Christie <mchristi@redhat.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <p43lkbkmsgnztlfbnrebsnnlkdvz4lt53vmnenoarejg6lhivz@cbia5lxat73k>
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
 <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>

On Tue, Sep 09, 2025 at 08:33:27AM -0700, Eric Dumazet wrote:
>On Tue, Sep 9, 2025 at 8:19 AM Richard W.M. Jones <rjones@redhat.com> wrote:
>>
>> On Tue, Sep 09, 2025 at 07:47:09AM -0700, Eric Dumazet wrote:
>> > On Tue, Sep 9, 2025 at 7:37 AM Jens Axboe <axboe@kernel.dk> wrote:
>> > >
>> > > On 9/9/25 8:35 AM, Eric Dumazet wrote:
>> > > > On Tue, Sep 9, 2025 at 7:04 AM Eric Dumazet <edumazet@google.com> wrote:
>> > > >>
>> > > >> On Tue, Sep 9, 2025 at 6:32 AM Richard W.M. Jones <rjones@redhat.com> wrote:
>> > > >>>
>> > > >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
>> > > >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
>> > > >>>>
>> > > >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
>> > > >>>> made sure the socket supported a shutdown() method.
>> > > >>>>
>> > > >>>> Explicitely accept TCP and UNIX stream sockets.
>> > > >>>
>> > > >>> I'm not clear what the actual problem is, but I will say that libnbd &
>> > > >>> nbdkit (which are another NBD client & server, interoperable with the
>> > > >>> kernel) we support and use NBD over vsock[1].  And we could support
>> > > >>> NBD over pretty much any stream socket (Infiniband?) [2].
>> > > >>>
>> > > >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>> > > >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
>> > > >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
>> > > >>>
>> > > >>> TCP and Unix domain sockets are by far the most widely used, but I
>> > > >>> don't think it's fair to exclude other socket types.
>> > > >>
>> > > >> If we have known and supported socket types, please send a patch to add them.
>> > > >>
>> > > >> I asked the question last week and got nothing about vsock or other types.
>> > > >>
>> > > >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
>> > > >>
>> > > >> For sure, we do not want datagram sockets, RAW, netlink, and many others.
>> > > >
>> > > > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL
>> > > > being used in net/vmw_vsock/virtio_transport.c
>>
>> CC-ing Stefan & Stefano.  Myself, I'm only using libnbd
>> (ie. userspace) over vsock, not the kernel client.

Thanks Rich for cceing me!

>>
>> > > > So you will have to fix this.

How we should fix that?

IIUC GFP_KERNEL in virtio_transport.c is used only by workqueue's 
functions, but we have GFP_ATOMIC in the fast path that can be called 
when the user is sending a packet.

This is basically the driver for the virtio-vsock device that can 
allocates extra buffers to be exposed to the device.
In this case the allocation can happen in virtqueue_add_sgs() for virtio 
indirect buffer, that IIRC virtio-vsock is not using currently (but we 
don't know in the future).

In any case, we use GFP_KERNEL also in virtio_transport_common.c to 
allocate the sk_buff, so that should be the same issue.

Thanks,
Stefano


