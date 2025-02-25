Return-Path: <netdev+bounces-169552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C518FA448CE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C664A882128
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529919ABAB;
	Tue, 25 Feb 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhpO8Rmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F81991DD
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505318; cv=none; b=Oa9nxoX/r25DoZGc40++Cb0jIM4FWZUfZO4FvpOCtKBzvoRgxSycEPnGAfgV67Og048zpWacfJRkLUyz5DJnPBBsozBv+g+6erKjgKyI4xQbuL819N1xBM9oWUWkqFW+zYDaU8DCOpnF0+FOOvqjdNowva5tAAtrMcXEnH3s8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505318; c=relaxed/simple;
	bh=iCX+nG23CjC2fxQmPixSN8EXGqI2yLXhnVoBGQ220Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZsFEeGBBUmHjS9YTdY8ZPpJpsTAlP9rfMG2qC1WIIwqjyihgJvz4pkz5oNpNEKIPMkUV6GXjfpK+XhoPKuAr2mdvQTOwvrFY180WRM2ete02Vj4Q8jdOjcT2AfuhMsBrajbHV0tdxgCMUe8SFkqVSNWaXD3o9sUzS1iJlYYfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhpO8Rmx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212222d4cdso3495ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740505315; x=1741110115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqjq5AFXxwlxfq4VPVA6M5Ee2CpyweWj+2y/hfe9AzE=;
        b=fhpO8RmxBeBGKT/5ZKbYywJBbdjJlmt3ng8Wjc4s/xgU+uY7xS01nlIK/TUBh6YfxA
         dMg04rKf1e6n12Aq9NXmheY6VKIokCil6E/Cn6Dt1d0bsyOlT8ODB/9XEAm4JcQPT3ZB
         Dhto1cUSl6rI9dZly5XAVVQSDEkOlMNtfNbF1AxgMbSmatvMLQR7mpKdD+6Mq4hv+D/6
         Rktp688V8SegHs1CqB2RF1hNZjq2TgXtIQt6bAXicdTVTn4MHN42Ds++qsKdCkYASL2E
         q0s7RUrtkkIkdmIabrI68/KioDWhOPMPpFp2Ig6fRmct79NFZedPvxpDISLltrLfgb91
         c9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740505315; x=1741110115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqjq5AFXxwlxfq4VPVA6M5Ee2CpyweWj+2y/hfe9AzE=;
        b=eP5G3IBnl0MmTXp6djhaW7qzh7BYc2aONuigyT5uFHoNEtuwaxsvm5jsjuGAhGYeoY
         wr0XXeJyzajMZ8ZTBf8DLh17ShUnrxwJrT9ahyaTdRBlclE5KkJS+DCt/1PjAmxvLT/E
         2jhk5OFZou2npOyuF26iV2lIDDa8LPou+t4GoNelLtTrt4PewasAavY1ZEn8ZYvPYDVY
         K6nTBSapnyrJILzpGB8ldrnqHFSWD5KnBoPRfg1RaXJInfX3AdK0M4TedQ4R4LLknCEz
         RQUpHVs4RxtswOZCo0JdVXcnyfixUNGGs17qCI/CXN15TlBd3BLq0w4QYpTpsvWMVRGP
         fJyg==
X-Gm-Message-State: AOJu0YyLg8RuWWDetVdX1Y6+edhoWXdAwR3C8RfXgBQG/9HTQ8yDd9/h
	b8AXq38/hL/5pJl9DTRRSy+mK6te82ib/yXM/G7huyciDvqJ7oDpQi+/mB4rR7d/6zNMrQM+Ejq
	Jqpk7AJmpE3FdyWSOz1XXfJMYJ61L7RBzbupM
X-Gm-Gg: ASbGnct5zrXa0OiuPWFJel1b14y9aMNqkWtOHfaUXmivynYAJpXaOdH2BymdWzYihhf
	qx5mAFBAF+dlQpKaFXFF/6XUBuEKXtNKcJEIatw6wZRr+H+hghucX4BM8C6HGaCYPMwFYs04Rvi
	HjsYTFx2M=
X-Google-Smtp-Source: AGHT+IHPa/zeMhv5rS+FoFIXRfGiR3W5Ojq1INXwGU+EkhH1BWbASSdZ3ThN+JgVulgi4m91g+jKNlJGa8ARq6KoZcI=
X-Received: by 2002:a17:902:d50a:b0:21f:3e29:9cd4 with SMTP id
 d9443c01a7336-22307a98cbcmr3805795ad.20.1740505314655; Tue, 25 Feb 2025
 09:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com> <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
In-Reply-To: <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 25 Feb 2025 09:41:41 -0800
X-Gm-Features: AWEUYZlYYSHH7_9N4ByWFALTxxtUrWQmHLefEElJbkJw4zmyNRZgN3GST52xcig
Message-ID: <CAHS8izNfNJLrMtdR0je3DsXDAvP2Hs8HfKf5Jq7_kQJsVUbrzg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:04=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/22/25 8:15 PM, Mina Almasry wrote:
> [...]
> > @@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dm=
abuf_binding *binding)
> >       unsigned long xa_idx;
> >       unsigned int rxq_idx;
> >
> > +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> > +
> > +     /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
> > +      * erase.
> > +      */
> > +     synchronize_net();
>
> Is the above statement always true? can the dmabuf being stuck in some
> qdisc? or even some local socket due to redirect?
>

Yes, we could have have netmems in the TX path in the qdisc or waiting
for retransmits that still have references to the dmabuf, and that's
fine here I think.

What is happening here is that tcp_sendmsg_locked() will look for a
binding in net_devmem_dmabuf_bindings with binding->id =3D=3D
sockc.dmabuf_id, and then grab a reference on it.

In parallel, net_devmem_unbind_dmabuf will remove the binding from
net_devmem_dmabuf_bindings, and then drop its refcount (which may be
the last one if the 'get' in tcp_sendmsg_locked has not yet executed,
triggering the binding to be freed).

I need to make sure the lookup + get of the dmabuf in
net_devmem_lookup_dmabuf() doesn't race with the erase + put in
net_devmem_unbind_dmabuf() in a way that causes UAF, and I use
rcu_read_lock for that coupled with synchronize_net().

Note that net_devmem_dmabuf_binding_put() won't free the dmabuf unless
we put the last ref, so any netmems stuck in retransmit paths or qdisc
will still pin the underlying dmabuf.

Let me know if you still see an issue here.


> > @@ -252,13 +261,23 @@ net_devmem_bind_dmabuf(struct net_device *dev, un=
signed int dmabuf_fd,
> >        * binding can be much more flexible than that. We may be able to
> >        * allocate MTU sized chunks here. Leave that for future work...
> >        */
> > -     binding->chunk_pool =3D
> > -             gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> > +     binding->chunk_pool =3D gen_pool_create(PAGE_SHIFT,
> > +                                           dev_to_node(&dev->dev));
> >       if (!binding->chunk_pool) {
> >               err =3D -ENOMEM;
> >               goto err_unmap;
> >       }
> >
> > +     if (direction =3D=3D DMA_TO_DEVICE) {
> > +             binding->tx_vec =3D kvmalloc_array(dmabuf->size / PAGE_SI=
ZE,
> > +                                              sizeof(struct net_iov *)=
,
> > +                                              GFP_KERNEL);
> > +             if (!binding->tx_vec) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_free_chunks;
>
> Possibly my comment on v3 has been lost:
>
> """
> It looks like the later error paths (in the for_each_sgtable_dma_sg()
> loop) could happen even for 'direction =3D=3D DMA_TO_DEVICE', so I guess =
an
> additional error label is needed to clean tx_vec on such paths.
> """
>

I think I fixed the issue pointed to in v3, but please correct me if I
missed anything. I added kvfree(), but we don't really need an
additional error label.

If we hit any of the error paths conditions in
for_each_sgtable_dma_sg, we will `goto err_free_chunks;`, which will
free all the genpool chunks, destroy the gen pool, then do
`kvfree(binding->tx_vec);` to free the memory allocated for tx_vec.

> [...]
> > @@ -1071,6 +1072,16 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >
> >       flags =3D msg->msg_flags;
> >
> > +     sockc =3D (struct sockcm_cookie){ .tsflags =3D READ_ONCE(sk->sk_t=
sflags),
> > +                                     .dmabuf_id =3D 0 };
> > +     if (msg->msg_controllen) {
> > +             err =3D sock_cmsg_send(sk, msg, &sockc);
> > +             if (unlikely(err)) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +     }
>
> I'm unsure how much that would be a problem, but it looks like that
> unblocking sendmsg(MSG_FASTOPEN) with bad msg argument will start to
> fail on top of this patch, while they should be successful (EINPROGRESS)
> before.
>

Thanks for catching indeed. I guess what I can do here is record that
the cmsg is invalid, then process up to MSG_FASTOPEN, and return
EINVAL after that.

Although that complicates this already complicated function a bit. Let
me know if you have a better/different solution in mind.

--
Thanks,
Mina

