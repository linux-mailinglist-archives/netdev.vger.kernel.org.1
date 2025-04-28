Return-Path: <netdev+bounces-186454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB2A9F2ED
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77C0461C82
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49526B0B6;
	Mon, 28 Apr 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwAih4/j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0C269D13
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848622; cv=none; b=THlIvrqF2ho/2vYamVUZT8UWbOLeNx0+RA6WNwYc4ZmzcM3pwd20sCh2lQsO5248Fgb8epuA6O17gJTxTKKHQ6WG+mBpqhsDNVKcauVjfEqUeehZ6PTF0uIQpsC2FJ66tJkEHyGkbpiIW0x4kwpAIo3T3rjv073p9O6GJ/4/vjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848622; c=relaxed/simple;
	bh=70lfu/B2ib3SJpO5ooGMaAt1QBpRSWIEV/Np9sKATMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOmxKm+zSO8wm46oA+55rZ2wSPeRBKGDaHX9+1oM3ld3BM1n6LnDE7bvuS5CyHtXbQUIK0RteaviLb5hLK7pvFrSLnJuykd0SOwNi8ocRov3e7c8Bw9TvdumoqcCkQVlIqU2BLoCNL9p+X7/afBTKNCkM6V5AE0X1CtUkDP9Y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwAih4/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745848620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHyYAaJAMEZKibWtlyqh2W6HZtpo9zi498VVY4y0rAg=;
	b=IwAih4/jkU+Ra+U5JMFKoKAAtGzLZSHEUgXmSw8SNKzaBJBjHeB4eibuL4rIIPhD/oML+A
	fgOi1hAEbwNIqtuaKQZwfSz8ZkTfHHq1LzF89GmVuBCmSvn+zcvDKm+H47YSKItqNV1+FF
	ny+ue8TD1+wLyIzY7uIKfPwAjY/4Fi8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-iUh07l0XM1y7CSio9801Ng-1; Mon, 28 Apr 2025 09:56:57 -0400
X-MC-Unique: iUh07l0XM1y7CSio9801Ng-1
X-Mimecast-MFC-AGG-ID: iUh07l0XM1y7CSio9801Ng_1745848617
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c95e424b62so629362885a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 06:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848617; x=1746453417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHyYAaJAMEZKibWtlyqh2W6HZtpo9zi498VVY4y0rAg=;
        b=Qs1szPKxRHCVCSgyC6wHZiH/2+jMISS60QktAgGOVf519h6SLSjGa0hGb1gF1z1M4i
         yecCdioBdLN01M1dQ2b1flBJwtPALSRAls+uOA0a2t/asnBbe/XFvpYxWJ8/6uTEcCc5
         XdWWHaM7FjXyhJzk4IRB2D6BEHv9ooJfm9+6v5NZMWxVhGHq6QqRfM0BuuQtmVeE+haA
         VmWNM3JPysVGr4vqmYt3OXGmAF5wEFGgnftbabGBm4Q/pxj1WUdLqEqwhBfSCS2hOOAO
         0CBVFCDYPxU52ISlkor9yqtHYETr/fe21yYKGIOSkoLczam7hzD7KS0IBDCDz8jXbZod
         0mMg==
X-Forwarded-Encrypted: i=1; AJvYcCUeiDKBpnMiEd9zUu6I66FimQ3yy9sbZiZi6/9MjFWTouWDZD/qgaTvk4NIId7WpqDXb2+lCSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPuk9Wf6JR+NvnkaY4Eb5B5xudpNeiOyCJiKQomj20ER3tfnI
	01i4JYlXm62c5VwGqecpafsUAvRIPJuxyOr7BbTQx0wgTxx/MTpItPygSclm+EOKazCaYYlkXpS
	guJSg0qRxenLgKJPEOQroRiayugp38pWr/MzXKR9NNtTa0cocs+XKkw==
X-Gm-Gg: ASbGncvuGenzyWdgT/qm3CJI6QisONFdpRBeKs+LcMKi6bLF6YVZGVzbsYxEyJq0hal
	V4iRf13upMVj67b4woEenUE5ZKbo1xGWzuC3bwAnJqH8oe8YgB5L3m1bqD4NlXmIV0zF6yZ5Tx2
	psk1DBYJ/bin+B7gCoQhV8+TKq86SGOSFjTHw/VFKb2RVjNjAXyGIz8naKl9CkOjrABjBTeQpNw
	FFWWdwFouHADlLgbewUCAT8slKTYfUnCZUqvxRrYObTCeXVlBM2hPTWmibSfKisdVqYMtb49rT4
	afZ9QPVBolmr173w
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr2487228685a.11.1745848616943;
        Mon, 28 Apr 2025 06:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF77QtEVSxz59mKWcWmWXJCMGCmi0uBQwkt5f3Bu+dckdVzt5kbvV5X2qwCObb0VZdyOuwAw==
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr2487224585a.11.1745848616412;
        Mon, 28 Apr 2025 06:56:56 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.205.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbd048sm623795385a.43.2025.04.28.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:56:55 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:56:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
Message-ID: <wff4t4owsukm2jynm2dhju4rrtegyjjlrhu7o5xppsxfqrcus4@wmsvcwkdtdat>
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
 <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
 <k47d2h7dwn26eti2p6nv2fupuybabvbexwinvxv7jnfbn6o3ep@cqtbaqlqyfrq>
 <ee09df9b-9804-49de-b43b-99ccd4cbe742@rbox.co>
 <wnonuiluxgy6ixoioi57lwlixfgcu27kcewv4ajb3k3hihi773@nv3om2t3tsgo>
 <5a4f8925-0e4d-4e4c-9230-6c69af179d3e@rbox.co>
 <CAGxU2F6YSwrpV4wXH=mWSgK698sjxfQ=zzXS8tVmo3D84-bBqw@mail.gmail.com>
 <81940d67-1a9b-42e1-8594-33af86397df6@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <81940d67-1a9b-42e1-8594-33af86397df6@rbox.co>

On Thu, Apr 24, 2025 at 01:24:59PM +0200, Michal Luczaj wrote:
>On 4/24/25 10:36, Stefano Garzarella wrote:
>> On Thu, 24 Apr 2025 at 09:53, Michal Luczaj <mhal@rbox.co> wrote:
>>> On 4/24/25 09:28, Stefano Garzarella wrote:

[...]

>>> You're right, it was me who was confused. VMCI and Hyper-V have their own
>>> vsock_transport::release callbacks that do not call
>>> virtio_transport_wait_close().
>>>
>>> So VMCI and Hyper-V never lingered anyway?
>>
>> I think so.
>>
>> Indeed I was happy with v1, since I think this should be supported by
>> the vsock core and should not depend on the transport.
>> But we can do also later.
>
>OK, for now let me fix this nonsense in comment and commit message.

Thanks!

>
>But I'll wait for your opinion on [1] (drop, squash, change order of
>patches?) before posting v3.

I'm fine with a second patch to fix the indentation and the order looks 
fine.

BTW I'm thinking if it makes sense to go back on moving the lingering in 
the core. I mean, if `unsent_bytes` is implemented, support linger, if 
not, don't support it, like now.

That said, this should be implemented in another patch (or eventually 
another series if you prefer), so my idea is the following split:
- use unsent_bytes() just in virtio
- move linger support in af_vsock.c (depending on transports 
   implementing unsent_bytes())
- implement unsent_bytes() in other transports (in the future)

WDYT?

Thanks,
Stefano


