Return-Path: <netdev+bounces-65000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB2838C77
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D4283752
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8F5C912;
	Tue, 23 Jan 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xz9b8zkZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D345D720
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006907; cv=none; b=ajQvlCdCd0XuB0+Qfw8fMUVsqcc2idD4yuhqCMF7IiomPKQsJ7ROhAIeeECsD6l9nXGZsyPYTwJDgRxXQtL6mVMLVl7l0+fguqaYtGCLObcqUhcGYKTI9YL7rUF/u/gw4HFkB3pvgyx/ojOdYcr1KVA919f3Y+QL9WVg5K7y/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006907; c=relaxed/simple;
	bh=r/FKTETBcTJPmiH5nxx++oUTYldyQGmZqvGuYmXwNzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Li73Ic9/J6HUcOuD45kMlXDnJzMVvc2MzZfYpFRy7AlxoUbNenGczf5ry+3OKSoSpa718a9Jb0ytMYSSg8+jT3ZAvUXG3fQ4Le5dP9kw2NpBztfTM7N+snifhM6kemc6Dk7yBajFATpGYGARUE24E9en5/wJzS8121XawEDD8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xz9b8zkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706006905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YBh2lGn7jwZTfKB5dlz1NWEh0ryVv+MvKM7aUDXUn4=;
	b=Xz9b8zkZTVnagsbUXTXbBsnsVf0Zhme0eznMjhb6sCau/kI51SVQPXUJQACUvJcczNeJPt
	dC4O2EK71Ff6vhPuLVR2HrGmccXMrAXep8tGjS+uyXFzKA3ONAB1Fs9LckIRywywksOq8l
	Ge41cGOECnUj7Zm8Q8XV8nuqkM0W6RQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-sMu5EBXyPEiLCv9ScvsmHw-1; Tue, 23 Jan 2024 05:48:22 -0500
X-MC-Unique: sMu5EBXyPEiLCv9ScvsmHw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-469c0622932so191914137.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 02:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006902; x=1706611702;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YBh2lGn7jwZTfKB5dlz1NWEh0ryVv+MvKM7aUDXUn4=;
        b=Yx2TqKQlkphgyuufblNXa6S9HUGWAIiZkfHUbKyqNjsx7ggX5vo72UpZwBw0MJttxC
         bx093SlJ1QmKr+YFJfRocOec3MnuHYi7s6jgMUxmAEJxBC+d+2Ojn+A5K1qN694QlXQX
         ST+s/PBqnd8ayZaFeqN2KT4BJZPqFfn2kvRO8+6Yr2VkJp/4SkuhZkEu5z7DzH1ZF26J
         8vkHSMte0nTn97FimDwBD+7EFY+pzApxSNI/xHFAhjCd8GdFm0PoaAoob5Sh1gdint5u
         AY18AMbXmUtYqc76LP4WqRH0ATZYuSdWIyYn6L99d1v05QodHzFwW2uNrbmlx3lSBZAJ
         E6mg==
X-Gm-Message-State: AOJu0YzhwLH+w4sUD0gwiuEqjLaNWvVwl53oeCjvXfEy8U2w9EbcORow
	r551WObeFyA0oEuNIex7fBV5RniYkRd4Jmi7hvhYJETqYFPpCEEcWiyCKglDZIJcN4GzKETlDgQ
	o//7K3Gw8V3h5wfnGh3G3H74eAE3VEE66TxP7CLYb0tJ+y0UjZSxOug==
X-Received: by 2002:a05:6102:300f:b0:469:a5a6:6d0b with SMTP id s15-20020a056102300f00b00469a5a66d0bmr5488811vsa.0.1706006902114;
        Tue, 23 Jan 2024 02:48:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHboCQHDZkTrLupgdVWubBgd3pLMrBMOM5h6w6Yr/0/WTIcWxeFOi/gPc25keqPq5oSSxunIw==
X-Received: by 2002:a05:6102:300f:b0:469:a5a6:6d0b with SMTP id s15-20020a056102300f00b00469a5a66d0bmr5488799vsa.0.1706006901775;
        Tue, 23 Jan 2024 02:48:21 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id ma8-20020a0562145b0800b00686a0102df9sm546134qvb.128.2024.01.23.02.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:48:21 -0800 (PST)
Message-ID: <64ed7596ce8550079ecef8a76eaaacd594535e58.camel@redhat.com>
Subject: Re: [PATCH net,v4] netlink: fix potential sleeping issue in
 mqueue_flush_file
From: Paolo Abeni <pabeni@redhat.com>
To: shaozhengchao <shaozhengchao@huawei.com>, Pablo Neira Ayuso
	 <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, horms@kernel.org, anjali.k.kulkarni@oracle.com,
 kuniyu@amazon.com,  fw@strlen.de, weiyongjun1@huawei.com,
 yuehaibing@huawei.com
Date: Tue, 23 Jan 2024 11:48:17 +0100
In-Reply-To: <1451d316-a4ff-354b-e57b-00ef85fba43a@huawei.com>
References: <20240122011807.2110357-1-shaozhengchao@huawei.com>
	 <Za4t110BCZAnlf1o@calendula>
	 <1451d316-a4ff-354b-e57b-00ef85fba43a@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2024-01-22 at 19:10 +0800, shaozhengchao wrote:
> On 2024/1/22 16:56, Pablo Neira Ayuso wrote:
> > On Mon, Jan 22, 2024 at 09:18:07AM +0800, Zhengchao Shao wrote:
> > > I analyze the potential sleeping issue of the following processes:
> > > Thread A                                Thread B
> > > ...                                     netlink_create  //ref =3D 1
> > > do_mq_notify                            ...
> > >    sock =3D netlink_getsockbyfilp          ...     //ref =3D 2
> > >    info->notify_sock =3D sock;             ...
> > > ...                                     netlink_sendmsg
> > > ...                                       skb =3D netlink_alloc_large=
_skb  //skb->head is vmalloced
> > > ...                                       netlink_unicast
> > > ...                                         sk =3D netlink_getsockbyp=
ortid //ref =3D 3
> > > ...                                         netlink_sendskb
> > > ...                                           __netlink_sendskb
> > > ...                                             skb_queue_tail //put =
skb to sk_receive_queue
> > > ...                                         sock_put //ref =3D 2
> > > ...                                     ...
> > > ...                                     netlink_release
> > > ...                                       deferred_put_nlk_sk //ref =
=3D 1
> > > mqueue_flush_file
> > >    spin_lock
> > >    remove_notification
> > >      netlink_sendskb
> > >        sock_put  //ref =3D 0
> > >          sk_free
> > >            ...
> > >            __sk_destruct
> > >              netlink_sock_destruct
> > >                skb_queue_purge  //get skb from sk_receive_queue
> > >                  ...
> > >                  __skb_queue_purge_reason
> > >                    kfree_skb_reason
> > >                      __kfree_skb
> > >                      ...
> > >                      skb_release_all
> > >                        skb_release_head_state
> > >                          netlink_skb_destructor
> > >                            vfree(skb->head)  //sleeping while holding=
 spinlock
> > >=20
> > > In netlink_sendmsg, if the memory pointed to by skb->head is allocate=
d by
> > > vmalloc, and is put to sk_receive_queue queue, also the skb is not fr=
eed.
> > > When the mqueue executes flush, the sleeping bug will occur. Use
> > > vfree_atomic instead of vfree in netlink_skb_destructor to solve the =
issue.
> >=20
> > mqueue notification is of NOTIFY_COOKIE_LEN size:
> >=20
> > static int do_mq_notify(mqd_t mqdes, const struct sigevent *notificatio=
n)
> > {
> >          [...]
> >                  if (notification->sigev_notify =3D=3D SIGEV_THREAD) {
> >                          long timeo;
> >=20
> >                          /* create the notify skb */
> >                          nc =3D alloc_skb(NOTIFY_COOKIE_LEN, GFP_KERNEL=
);
> >                          if (!nc)
> >                                  return -ENOMEM;
> >=20
> > Do you have a reproducer?
> Hi Pablo:
> 	I donot have reproducer. I found the issue when running syz on
> the 5.10 stable branch, but it only happened once. Then I analyzed the
> mainline code and found the same issue.
> 	The sock can be obtained from the value of sigev_signo
> transferred by the user in do_mq_notify. And the sock may be of type
> netlink, and it is possible to allocate the head area using vmalloc.
> Not only release the skb allocated in do_mq_notify, but also release
> the skb allocated in netlink_sendmsg when put sock mqueue_flush_file.
> What I missed?

I believe your explanation is solid and the patch looks safe, I'm
applying it.

Thank you!

Paolo

p.s. for once I'm answering in place of Pablo, which is sort of funny
given that our names are confused a significant number of times on the
ML...)


