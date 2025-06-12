Return-Path: <netdev+bounces-196880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119EAD6C36
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B26189BA23
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D722AE76;
	Thu, 12 Jun 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtA1Y01P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09671E5B62
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720625; cv=none; b=LvMhwb7QFVGX3uHA0Y1qBlrqlqnEKVVoTh8xHsFrs9336oMWSanveVvbQ9h+A8Oo4+Q485IznZZsmzNdWs+xs1H0mPNLf0SVUGpeg5IAZx8o9EW0uQU2YsX5z8VBE5wlgiNAKm2ck+fO1rFgI2o2PIQyDJjA2ky5Zd7RztS9DGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720625; c=relaxed/simple;
	bh=4ygq9Ksz0EzPSaZG9OKYAVE1YdwDPmeAsjiGh8gvFqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gys8p6qSkZ73Qpr6Q7VrPsVED6854Eu8vMsuo2Mna/rBdV4M+/ad6qfiTfLudREBEftj8NhJ8JNC9kAHG7Fg7hI4eU0yqMC73t4rE2QaH5Shpl5pfhzCGcyTCOTMmcWeVEirkowdmDovuztdpUp+kCwKjjPs8bepkljHioAG4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtA1Y01P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749720622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ygq9Ksz0EzPSaZG9OKYAVE1YdwDPmeAsjiGh8gvFqo=;
	b=BtA1Y01PE7MeB1UAU535WWh6fBVD13Ahwyi3/LS1WyNb/oV6F4wj/fNNTl6QDt21JDuSDn
	JcoXsFbPZLAHCcPAHbb//4iA1KZexgQ4BcDSzKkTCsJn5GcGrsXK0u2+VCDr7rqnFvT/lk
	eSEctaAdvOURFXisq3WzzJyz0xrZdmg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-6Ppl6z7TOZKs7qn5tRAhjA-1; Thu, 12 Jun 2025 05:30:21 -0400
X-MC-Unique: 6Ppl6z7TOZKs7qn5tRAhjA-1
X-Mimecast-MFC-AGG-ID: 6Ppl6z7TOZKs7qn5tRAhjA_1749720620
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ade5013e05cso61266266b.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 02:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720620; x=1750325420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ygq9Ksz0EzPSaZG9OKYAVE1YdwDPmeAsjiGh8gvFqo=;
        b=Cdkcd13eAtUWeCHLRPa3ue96+Iz8wiZwFpjT1Kg8hEIeHdU8m3AEixeE17s5xBX3Re
         X2grqg2yzGq/Io7MRXprnsua8mX+A7g1puyPSfqxAomBhhYuVdEUynICQFAbktOry5sI
         sTOGmDA69hscFJkmLGqlTZU1/5H1DMA0UIcoWoZTQZqYCPmAsKh41YJbd8J7FneAk+H6
         1qrUd8hIesrloff00l6kMFAmNaWdqwI50GkkYPN//1FO8HkZruofBaUEm6cnklKSJg39
         F27FUVTJ328uOmMYS40WZrnd4rYgyGW3nRlJ4PPJ7cDvtbay99GcG5XS62ZoXP2gVo6q
         Ae5A==
X-Forwarded-Encrypted: i=1; AJvYcCWzYPsHfb8IjcnEd7F9LfXEKZPvLAHOgdHoTmeDoxkAKZnEkku2Ba+rX1keqZshDJ6hBBd9ozs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxldzLhh4H9s/Jb5khc4nfhx5uY06anWp3VebGY8+JnEbc35V
	9wJw5DjubSTg2dyNujJNNMpO71TlwouakmGqlztmAcq4wZzy9axMEVKn1J7WM9DZVc95QPe22LH
	PEePClYMHA+UX0Vl9QtlgIxTLaSeHtNhPYY3y6r7HH5cOkzh3t+Ep9FbQ7Q==
X-Gm-Gg: ASbGncu0UHiBMSbPZwkDPtWgXM/09jm2UlnQStdy3469c60Olpl/Dxo3W9XZqVYippJ
	MIJT2KMMhQTVCZj80dzdTbRr2ZHHMxSaPMLAaKoZMr68RAsCJZaa7eQjMnI2yF/fnhjvHsh6baY
	+QjhuTudmrut5nNx34Enh54SUJWnG3N8e008cCE9cm++r1pxWzhhSb1pv3EY7cz+3e7trwOPiCs
	e7ALIJTOl+GEFfTOBmTEDesnUVM9OuZ/rhQBrKYf1kzZ6dVLEBqSVQBEmG3IBSzNXXu3EeCIYWG
	Pzt3WunDyKYOXAlgMexAjP6To40j
X-Received: by 2002:a17:907:9404:b0:adb:14f3:234 with SMTP id a640c23a62f3a-adea8d2a7femr202985866b.8.1749720619716;
        Thu, 12 Jun 2025 02:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/Lug4eBXscrw4Su9HuFYOFwJuHPtuXS+7rbCJ7Q+kF4SSqVkab1vunsa/YWLwUrWOIkfLw==
X-Received: by 2002:a17:907:9404:b0:adb:14f3:234 with SMTP id a640c23a62f3a-adea8d2a7femr202981966b.8.1749720619118;
        Thu, 12 Jun 2025 02:30:19 -0700 (PDT)
Received: from sgarzare-redhat ([2001:67c:1220:8b4:edf4:d580:147e:ea8e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4cde8asm102655966b.7.2025.06.12.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:30:18 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:30:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: Oxffffaa@gmail.com, avkrasnov@salutedevices.com, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, horms@kernel.org, jasowang@redhat.com, 
	kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream
 sockets
Message-ID: <gqwp3mkdx3uaedmxx4kqvhvbgfvp3dtabm5ciejitk4x573oww@ek4agftt56np>
References: <CAGxU2F4JkO8zxDZg8nTYmCsg9DaaH58o5L+TBzZxo+3TnXbA9Q@mail.gmail.com>
 <20250612085514.996837-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250612085514.996837-1-niuxuewei.nxw@antgroup.com>

On Thu, Jun 12, 2025 at 04:55:14PM +0800, Xuewei Niu wrote:
>> On Thu, 12 Jun 2025 at 10:21, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>> >
>> > > On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>> > > >
>> > > > > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
>> > > > > > No comments since last month.
>> > > > > >
>> > > > > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
>> > > > > > patch. Could I get more eyes on this one?
>> > > > > >
>> > > > > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
>> > > > > >
>> > > > > > Thanks,
>> > > > > > Xuewei
>> > > > >
>> > > > > it's been in net for two weeks now, no?
>> > > >
>> > > > Umm sorry, I didn't check the date carefully, because there are several
>> > > > ongoing patches. Next time I'll check it carefully. Sorry again.
>> > > >
>> > > > It looks like no one is paying attention to this patch. I am requesting
>> > > > someone interested in vsock to review this. I'd appreciate that!
>> > >
>> > > Which patch do you mean?
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > I am saying your patch, "vsock/virtio: fix `rx_bytes` accounting for stream
>> > sockets".
>> >
>> > Once this gets merged, I will send a new version of my patch to support
>> > SIOCINQ ioctl. Thus, I can reuse `rx_bytes` to count unread bytes, as we
>> > discussed.
>>
>> As Michael pointed out, it was merged several weeks ago in net tree,
>> see https://lore.kernel.org/netdev/174827942876.985160.7017354014266756923.git-patchwork-notify@kernel.org/
>> And it also landed in Linus tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ca7e9f0730ae36fc610e675b990e9cc9ca0714
>
>I misunderstood Michael's point. I am new to this, and not familiar with
>the process. Sorry about that...

Don't worry ;-)

Hope now it's clear!

Thanks,
Stefano


