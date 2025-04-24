Return-Path: <netdev+bounces-185446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D3A9A64B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687FA1B859EC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32820F09C;
	Thu, 24 Apr 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6kx5pfI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242D2144C0
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483826; cv=none; b=ZrqCzu4nzaBqw8+bedSignilrab0+f/Fo0d8DqVHJjpY2sxTIMT7jZsj91AJen/Z7RogBA5P3S6a5UtimfJcxpO64g2bqYHmrdSukLqhSPLoEYBVnjgFCPLmVpkwVMwoE0nk+DC36/16SzUYtsm8K3X4jlauTbsCsNDBspHoOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483826; c=relaxed/simple;
	bh=fPeja0QKwMSDRTJx03tZ5pM4veCCSXRBmgYEmRDUSpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1ppX9NnGkoOTlhc9E/CD+zYK5E78eo34eC7VHsLbR03yVpuUqU9tozhrcu0jymkpVaNiHSQntgtN69vQ51/BfQhirSpJKN7lC9Ztcml9Ftzh50gevqIOeVAZx6CPB+jN8huwHq9iSKGV++9F7LWLhywgKwcCC4K6me9tV3vRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6kx5pfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745483823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fmlstr9ginyDig4RAQsNh+6aO603AT1tDfj5LgGrKc=;
	b=h6kx5pfI0J/DnXenjy2KATMKzTR3WWelyQqChV41c+o5MNYnNz/4OPlBo11XMZERJydFzy
	2z/n7nycriFPLxg26g/CUf3Ex6Uh19zpsq3/6OoNHP+SvUht3DOSRqABcLPZnqdMsXIUnx
	SwwAtWoa7n7+s+moNDgaa+iBhhZmPaI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-g0nmDpGgMX2eifdEaasPwQ-1; Thu, 24 Apr 2025 04:37:01 -0400
X-MC-Unique: g0nmDpGgMX2eifdEaasPwQ-1
X-Mimecast-MFC-AGG-ID: g0nmDpGgMX2eifdEaasPwQ_1745483821
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e72874a21c0so920537276.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483821; x=1746088621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fmlstr9ginyDig4RAQsNh+6aO603AT1tDfj5LgGrKc=;
        b=vPs2QP2k8fVwH5aO16fFTHxGE7F/lvcI2fFeuM+bKm0owvc7vOlUC1JBf7P2aXHSpP
         dHEN8WHlgWIgWaIBV0/WSzQBoXswwIMQ4rnpwxx7p/RS6cPift+uyeRQo4J8g4hlhCW3
         3t7F8beqGjgWoI7lm2AS3HCmziPwSw5eMakxgjUGlLZcCiBYix+W23EIWDhfEm/cYrki
         ssysiMmh+xewP34heBBi3MMrlQr+/V93TW4YiWqiLcc3knzAnuoBY2se3zLDLS7TmuFy
         3o+PO+L1VUvdJf+5sIDJdXQN2UqpANjNLa8ZOnTlzVjdaMCLNEqxXhdeEVwg4Dm5sEmo
         R1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUSy/6GEiCT48hDkdhm3AaBQsm0m0+T0TyyGLoqjvewDnPEAHrjp+ystdWFzvuFhLTP7wYcrUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxC4fv+/Hiz07qgmW+OMBt9LwCZNrlkIH2TI6V9eWYnFTfBQM
	soB1cvgxKhK7zUF984h4l/NFLyPiNlGalr4xscMs/SpYrcd9ak8FdjRcH41uBN+FP/iUJpZG90p
	jscSKPNObbw9LWYgiaD1rw9my00U41hgzAQrdQG0ewe1OEtT9pPWVdDa3CzDGCINmuvy2D0JhVQ
	/JdyHUOW8CV3zAO4Kthd7AVNSAJpoY
X-Gm-Gg: ASbGncu6JBCI6fDzLk5EMBu1If9w74SJPjlaFWRXuaJl0VJG9qRTsX7dMVoB7gWsKvW
	0mqwY0nAUIB9U/aXQGLd8DNaFmnjrYJdc7zz3h0uNdFZjP0EIJpeNYGt6HSWj9BZKwtv5ckA=
X-Received: by 2002:a05:6902:2186:b0:e72:9693:7b36 with SMTP id 3f1490d57ef6-e73036372e0mr2271543276.42.1745483821381;
        Thu, 24 Apr 2025 01:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUfymtjS1vLei+DBOMXzLqv89tvpRz1tTcENml/8LK4mc8Ke+xAHKIP1Qw42phxCq+/NuBAxZdcPmq6bth+u8=
X-Received: by 2002:a05:6902:2186:b0:e72:9693:7b36 with SMTP id
 3f1490d57ef6-e73036372e0mr2271517276.42.1745483821066; Thu, 24 Apr 2025
 01:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co> <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
 <k47d2h7dwn26eti2p6nv2fupuybabvbexwinvxv7jnfbn6o3ep@cqtbaqlqyfrq>
 <ee09df9b-9804-49de-b43b-99ccd4cbe742@rbox.co> <wnonuiluxgy6ixoioi57lwlixfgcu27kcewv4ajb3k3hihi773@nv3om2t3tsgo>
 <5a4f8925-0e4d-4e4c-9230-6c69af179d3e@rbox.co>
In-Reply-To: <5a4f8925-0e4d-4e4c-9230-6c69af179d3e@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 24 Apr 2025 10:36:49 +0200
X-Gm-Features: ATxdqUF_58noK2_e9QPMXCT-pjwdIdBihMopt3yWeIxTGLAFMTKaBY4Kl-orunU
Message-ID: <CAGxU2F6YSwrpV4wXH=mWSgK698sjxfQ=zzXS8tVmo3D84-bBqw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Apr 2025 at 09:53, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 4/24/25 09:28, Stefano Garzarella wrote:
> > On Wed, Apr 23, 2025 at 11:06:33PM +0200, Michal Luczaj wrote:
> >> On 4/23/25 18:34, Stefano Garzarella wrote:
> >>> On Wed, Apr 23, 2025 at 05:53:12PM +0200, Luigi Leonardi wrote:
> >>>> Hi Michal,
> >>>>
> >>>> On Mon, Apr 21, 2025 at 11:50:41PM +0200, Michal Luczaj wrote:
> >>>>> Currently vsock's lingering effectively boils down to waiting (or timing
> >>>>> out) until packets are consumed or dropped by the peer; be it by receiving
> >>>>> the data, closing or shutting down the connection.
> >>>>>
> >>>>> To align with the semantics described in the SO_LINGER section of man
> >>>>> socket(7) and to mimic AF_INET's behaviour more closely, change the logic
> >>>>> of a lingering close(): instead of waiting for all data to be handled,
> >>>>> block until data is considered sent from the vsock's transport point of
> >>>>> view. That is until worker picks the packets for processing and decrements
> >>>>> virtio_vsock_sock::bytes_unsent down to 0.
> >>>>>
> >>>>> Note that such lingering is limited to transports that actually implement
> >>>>> vsock_transport::unsent_bytes() callback. This excludes Hyper-V and VMCI,
> >>>>> under which no lingering would be observed.
> >>>>>
> >>>>> The implementation does not adhere strictly to man page's interpretation of
> >>>>> SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.
> >>>>>
> >>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >>>>> ---
> >>>>> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> >>>>> 1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >>>>> index 7f7de6d8809655fe522749fbbc9025df71f071bd..aeb7f3794f7cfc251dde878cb44fdcc54814c89c 100644
> >>>>> --- a/net/vmw_vsock/virtio_transport_common.c
> >>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
> >>>>> @@ -1196,12 +1196,21 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> >>>>> {
> >>>>>   if (timeout) {
> >>>>>           DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >>>>> +         ssize_t (*unsent)(struct vsock_sock *vsk);
> >>>>> +         struct vsock_sock *vsk = vsock_sk(sk);
> >>>>> +
> >>>>> +         /* Some transports (Hyper-V, VMCI) do not implement
> >>>>> +          * unsent_bytes. For those, no lingering on close().
> >>>>> +          */
> >>>>> +         unsent = vsk->transport->unsent_bytes;
> >>>>> +         if (!unsent)
> >>>>> +                 return;
> >>>>
> >>>> IIUC if `unsent_bytes` is not implemented, virtio_transport_wait_close
> >>>> basically does nothing. My concern is that we are breaking the
> >>>> userspace due to a change in the behavior: Before this patch, with a
> >>>> vmci/hyper-v transport, this function would wait for SOCK_DONE to be
> >>>> set, but not anymore.
> >>>
> >>> Wait, we are in virtio_transport_common.c, why we are talking about
> >>> Hyper-V and VMCI?
> >>>
> >>> I asked to check `vsk->transport->unsent_bytes` in the v1, because this
> >>> code was part of af_vsock.c, but now we are back to virtio code, so I'm
> >>> confused...
> >>
> >> Might your confusion be because of similar names?
> >
> > In v1 this code IIRC was in af_vsock.c, now you pushed back on virtio
> > common code, so I still don't understand how
> > virtio_transport_wait_close() can be called with vmci or hyper-v
> > transports.
> >
> > Can you provide an example?
>
> You're right, it was me who was confused. VMCI and Hyper-V have their own
> vsock_transport::release callbacks that do not call
> virtio_transport_wait_close().
>
> So VMCI and Hyper-V never lingered anyway?

I think so.

Indeed I was happy with v1, since I think this should be supported by
the vsock core and should not depend on the transport.
But we can do also later.

Stefano

>
> >> vsock_transport::unsent_bytes != virtio_vsock_sock::bytes_unsent
> >>
> >> I agree with Luigi, it is a breaking change for userspace depending on a
> >> non-standard behaviour. What's the protocol here; do it anyway, then see if
> >> anyone complains?
> >>
> >> As for Hyper-V and VMCI losing the "lingering", do we care? And if we do,
> >> take Hyper-V, is it possible to test any changes without access to
> >> proprietary host/hypervisor?
> >>
> >
> > Again, how this code can be called when using vmci or hyper-v
> > transports?
>
> It cannot, you're right.
>
> > If we go back on v1 implementation, I can understand it, but with this
> > version I really don't understand the scenario.
> >
> > Stefano
> >
>


