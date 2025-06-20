Return-Path: <netdev+bounces-199809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBEAE1DBE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25351BC7243
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327D293B42;
	Fri, 20 Jun 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0FlJ4JS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF3293B46
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430630; cv=none; b=s3DwwkUFsCWdkfuxpfDn6rzi+/azwaWGCPh/zeya2bgEMnMYegR10JKvom2gpz2Lna1V4G/RWutiDEnw0tHOtYS+BfyK3W0+E9Fv21GBvB0ES8jZJ0iQEWxvkUNkROPS3nHPWD2eLymlRTdwZajEfMHCMA7XDPlfipQ0YfZzYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430630; c=relaxed/simple;
	bh=a5B74DWktSn3f4M4HL5uKwz80yVFCjRGioEiYX6Hb4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oI7gEPGihFFwtuMtJE8jRUw7x7nKsUA4tfdfL7xenbfOXjfa+1INukcAdXbKtKbBha9WjieZT2Cq9qoRmpeTyuK0eYlkupYhnqWEhQFsMEz5a0GcoSE08NJC83mvN4vNDFHrytFXwkjDo1oMSfidUaWTBIXaEEi/dN0s1Bq+5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0FlJ4JS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750430627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RWq+TaKLrZiqbO1v7nR3iQ1EOBBcwIYtFqUwQIs1s4=;
	b=E0FlJ4JSQnde7pYn58ypkvdOHm+cJhQ0D16t2xVQgifI6A+loumPBSRI8n97kiUUxxoMoJ
	VuJ1qOxJ9AdmrsyxMc71wocAgj1ORn9NsNQpRKU26/QocSSUeLVmzlq7nxWj/AdlgP25XN
	mdCA2HxVMMzqPFxkqG8jvwUX1vP4le4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-6ZS-r2RBNzOi_DoQJSiz7g-1; Fri, 20 Jun 2025 10:43:45 -0400
X-MC-Unique: 6ZS-r2RBNzOi_DoQJSiz7g-1
X-Mimecast-MFC-AGG-ID: 6ZS-r2RBNzOi_DoQJSiz7g_1750430625
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-710f05af33eso26751777b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750430625; x=1751035425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RWq+TaKLrZiqbO1v7nR3iQ1EOBBcwIYtFqUwQIs1s4=;
        b=BtuvSamOnyGnJj3qTBqcMc3XDJGbMDKYMyxVj+U0to2xNlbQIp4QmODLrZIb0AdlCC
         aLF/PaokKdgTIVrU9d9nnNbfEh+d+KvThGG2azO/VjiGoeNpNBqHoUn9d9JsDavVcyxu
         UmNqmexqMOQvfcTJZ4G+eeas7TncPgTFdu4c1S9WoJMEmiUo6ugOIoEd2Er35JnZQkAJ
         EON5Nm/f3Il5n7NgzySuBgg+ghNaHpC3tPLnwvv1tTdU7UrTlKlJtcMtNQ8CDU9VJhD3
         gZA3u2GEPdIJ5nDqLtLqRa/nK61kxaDWdKnym2twPgSlM/IsBrl0uUvMXf6YsWsgRcBT
         RlKA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGWLhBkgNCJmTE5Yq4qrSbuAdZLZQAiU/P17rC0DUCdseqEZydXR1X3vwzt9gPZmF0STJwR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0gfQpu73ZRVwlEamqCAwa6vPM7YqaEGoKlxLyhKjFfIDipzZ
	OOyX4VU5/P61Gjl4fW6Et038cAU7KNuHKv3iNE+pcUoxJOPhTU4DF6G3hzPUAOcR9oWYuA040wB
	TofArUqNALqCOR/lRTJ+rzO19yrQVBw7Qav+rBQk6IhgfwGOTPqjXLKLb/jBZ9LJQX17S5amB5x
	Q84W8oUDcJRVMIFjQFhfhG0+VvyiG7a5+F
X-Gm-Gg: ASbGncs1vMo2ucTedepvVX2sQTmtyst5MOSYw0O/ZxQp3KIDwXflE/um843VW2APyFi
	K8brFRzBANLeCnyxlGC0t85Ue8FtlcykN6BtO80Rmcifigwox0jV8h8iC67mZ7j8vywkrYn59xe
	PwgUrf+A==
X-Received: by 2002:a05:690c:6213:b0:70d:ff2a:d686 with SMTP id 00721157ae682-712c6511072mr43807757b3.28.1750430625032;
        Fri, 20 Jun 2025 07:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe8e+Y9SKGTNdJZM58PzhuRTK0sXl6mD4naZIe3BBYmK051ZMAuMgEUmrIkfQ9WrqWSNmp2ZUFBijynJid5O0=
X-Received: by 2002:a05:690c:6213:b0:70d:ff2a:d686 with SMTP id
 00721157ae682-712c6511072mr43807327b3.28.1750430624599; Fri, 20 Jun 2025
 07:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
 <r2ms45yka7e2ont3zi5t3oqyuextkwuapixlxskoeclt2uaum2@3zzo5mqd56fs>
 <fd2923f1-b242-42c2-8493-201901df1706@rbox.co> <cg25zc7ktl6glh5r7mfxjvbjqguq2s2rj6vk24ful7zg6ydwuz@tjtvbrmemtpw>
 <4f0e2cc5-f3a0-4458-9954-438911e7d104@rbox.co>
In-Reply-To: <4f0e2cc5-f3a0-4458-9954-438911e7d104@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 20 Jun 2025 16:43:32 +0200
X-Gm-Features: Ac12FXwn4NPco6cJ8tD5ShQh8qplPM91KYLaJd-jSDdO900oR85uZRyuzJXCs3s
Message-ID: <CAGxU2F65bh=jU6MVnhh=EzP19iayWATEezDFDd+c9o+K3Bf6YQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] vsock: Fix transport_{h2g,g2h} TOCTOU
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 16:23, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 6/20/25 15:20, Stefano Garzarella wrote:
> > On Fri, Jun 20, 2025 at 02:58:49PM +0200, Michal Luczaj wrote:
> >> On 6/20/25 10:32, Stefano Garzarella wrote:
> >>> On Wed, Jun 18, 2025 at 02:34:00PM +0200, Michal Luczaj wrote:
> >>>> Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
> >>>> Make sure pointers remain valid.
> >>>>
> >>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
> >>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
> >>>> Call Trace:
> >>>> __x64_sys_ioctl+0x12d/0x190
> >>>> do_syscall_64+0x92/0x1c0
> >>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >>>>
> >>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> >>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >>>> ---
> >>>> net/vmw_vsock/af_vsock.c | 4 ++++
> >>>> 1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
> >>>> --- a/net/vmw_vsock/af_vsock.c
> >>>> +++ b/net/vmw_vsock/af_vsock.c
> >>>> @@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> >>>>
> >>>>    switch (cmd) {
> >>>>    case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
> >>>> +          mutex_lock(&vsock_register_mutex);
> >>>> +
> >>>>            /* To be compatible with the VMCI behavior, we prioritize the
> >>>>             * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> >>>>             */
> >>>> @@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> >>>>            else if (transport_h2g)
> >>>>                    cid = transport_h2g->get_local_cid();
> >>>>
> >>>> +          mutex_unlock(&vsock_register_mutex);
> >>>
> >>>
> >>> What about if we introduce a new `vsock_get_local_cid`:
> >>>
> >>> u32 vsock_get_local_cid() {
> >>>     u32 cid = VMADDR_CID_ANY;
> >>>
> >>>     mutex_lock(&vsock_register_mutex);
> >>>     /* To be compatible with the VMCI behavior, we prioritize the
> >>>      * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> >>>      */
> >>>     if (transport_g2h)
> >>>             cid = transport_g2h->get_local_cid();
> >>>     else if (transport_h2g)
> >>>             cid = transport_h2g->get_local_cid();
> >>>     mutex_lock(&vsock_register_mutex);
> >>>
> >>>     return cid;
> >>> }
> >>>
> >>>
> >>> And we use it here, and in the place fixed by next patch?
> >>>
> >>> I think we can fix all in a single patch, the problem here is to call
> >>> transport_*->get_local_cid() without the lock IIUC.
> >>
> >> Do you mean:
> >>
> >> bool vsock_find_cid(unsigned int cid)
> >> {
> >> -       if (transport_g2h && cid == transport_g2h->get_local_cid())
> >> +       if (transport_g2h && cid == vsock_get_local_cid())
> >>                return true;
> >>
> >> ?
> >
> > Nope, I meant:
> >
> >   bool vsock_find_cid(unsigned int cid)
> >   {
> > -       if (transport_g2h && cid == transport_g2h->get_local_cid())
> > -               return true;
> > -
> > -       if (transport_h2g && cid == VMADDR_CID_HOST)
> > +       if (cid == vsock_get_local_cid())
> >                  return true;
> >
> >          if (transport_local && cid == VMADDR_CID_LOCAL)
>
> But it does change the behaviour, doesn't it? With this patch, (with g2h
> loaded) if cid fails to match g2h->get_local_cid(), we don't fall back to
> h2g case any more, i.e. no more comparing cid with VMADDR_CID_HOST.

It's friday... yep, you're right!

>
> > But now I'm thinking if we should also include `transport_local` in the
> > new `vsock_get_local_cid()`.
> >
> > I think that will fix an issue when calling
> > IOCTL_VM_SOCKETS_GET_LOCAL_CID and only vsock-loopback kernel module is
> > loaded, so maybe we can do 2 patches:
> >
> > 1. fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`
> >     Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>
> What would be the transport priority with transport_local thrown in? E.g.
> if we have both local and g2h, ioctl should return VMADDR_CID_LOCAL or
> transport_g2h->get_local_cid()?

Should return the G2H, LOCAL is more for debug/test, so I'd return it
only if anything else is loaded.

>
> > 2. move that code in vsock_get_local_cid() with proper locking and use
> > it also in vsock_find_cid()
> >
> > WDYT?
>
> Yeah, sure about 1, I'll add it to the series. I'm just still not certain
> how useful vsock_get_local_cid() would be for vsock_find_cid().
>

Feel free to drop 1 too, we can send it later if it's not really
related to this issue.
About the series, maybe it is better to have a single patch that fixes
the access to ->get_local_cid() with proper locking.
But I don't have a strong opinion on that. I see it like a single
problem to fix, but up to you.

Thanks,
Stefano


