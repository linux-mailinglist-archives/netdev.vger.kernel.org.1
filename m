Return-Path: <netdev+bounces-127206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399BD9748C3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F381F268D0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9763EA76;
	Wed, 11 Sep 2024 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0fR/vPr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AA3BBF5
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026105; cv=none; b=k6zAHkwXCBnDDnVRIsMUumvUMhGqB1BT1gP7iFyqrG+408b8zk8BhUweqFutvisFQabcjmlEQasm2/bnCDPg6SJKaEpGAEu8ojwOyPztGdQ5VnJMf8m20XWIZM3iq2ma8pmslTcrPJ+d84LLHWYHqKu9jt38/nXelXm13e4Kvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026105; c=relaxed/simple;
	bh=rJYvWkB7ScfNu1HSBhulsrDv6xXwX4/vF8+VLJ/vb0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=os75hcILZa//tQuLk+x715A+7hqTv3+7rP2nw2hcZHU2aAAmyXH7zimfhH4NFuzuRcyYvc+J7qRQykknaqThQjxJGVslNu5c9tiZi+rJ+9WPK9P4KFu1LzpoHU96aYg+kLpjYMHE38I6IZq99q+rDbMYWaJzygVEChpO9RQec+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0fR/vPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+J236T6pgkbhgAgrX3KyOZMQGHGE3Be/dQ9diTCoxY=;
	b=e0fR/vPrN8CgL4RwnNwjfekQXeI/5Wn+DCobviwKzC093KBPMMYkKvUU/T89tUzHq+RMfh
	J/OuEGdVQU7Q8jYGEOnrqtf5M0cdTUpFFQX3Ym8jfcTaKLF0k8pbZIoBhYsKgHFshnys5Z
	/YKjG9Iqg3NzsKiIAtUVLOce3gDXDaU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-vVsEjKuDP6yrs-h2-SPbGA-1; Tue, 10 Sep 2024 23:41:41 -0400
X-MC-Unique: vVsEjKuDP6yrs-h2-SPbGA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d889fde2aaso7588157a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 20:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026100; x=1726630900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+J236T6pgkbhgAgrX3KyOZMQGHGE3Be/dQ9diTCoxY=;
        b=Y+8yDYj0c76/Gc3sYq+DLHwvvIBaJ0fupqiRJu27lzjVU2e6K7WnWoP0cEvJOaZ2sZ
         A5FOt6OZ9RUQ8OnLQ70wMYBNBtnag6W4J9YgbXdAbUcYaqxhCuY2EJKQSs2h87+QPe4s
         nLDBLaYKaD1/NGZg5EuM+dK5olmkR3rTxH/Z2e+fmcLJakd3ZD+0g+0EGX7E1/UVrE5M
         +xWnVbIyKlBdkTttNq+ez9P5ZGPvfrwnhqu3scElORrwcFW+luOKzWYG0zojcpS59MZT
         mxHZqZPbpwd+FEmmYFAgNfarih/wF7Bs2nGu2QJmlG/kOgQzfJIu3z/mAcv9hrIwIIOp
         pQaw==
X-Gm-Message-State: AOJu0YwcsKyXnbBhZFR4SswRQ/SLQicee2gGXkInrR0H2+8HUgc5DKHj
	XvfQOXweWsnAI714L0TvtCKZKJq+wKXEuRovK2s9vJ+XT4f3tg2GgB/Mz1ou7ronQ171hlVkNYQ
	n6idaQqT7YMpJ9R+3V92JqIqZDlqlTGVSpwgG/u2s+vxR9ZrKf6AW6Mi+WrCONYYF9S+lsf+p9U
	6xTDhuFO4MakT1VjRzvIIJ0iT6Nemr
X-Received: by 2002:a17:90b:274d:b0:2d8:f0e2:96bc with SMTP id 98e67ed59e1d1-2dad4de1093mr22343359a91.4.1726026100061;
        Tue, 10 Sep 2024 20:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaDwp3Q0SLnWzKfVCgb9BODneaoPaF+zndWs3xBjNW61sf48WRFvCmYORhIvNKIq+tqmO6iMQDPRfKisgXoG8=
X-Received: by 2002:a17:90b:274d:b0:2d8:f0e2:96bc with SMTP id
 98e67ed59e1d1-2dad4de1093mr22343332a91.4.1726026099534; Tue, 10 Sep 2024
 20:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
 <CACGkMEsnPmbo8t6PbD8YsgKrZWHXG=Rz8ZwTDBJkSbmyzkNGSA@mail.gmail.com>
 <66e05a2259919_9de00294f9@willemb.c.googlers.com.notmuch> <66e05d81c04fe_a00b829435@willemb.c.googlers.com.notmuch>
In-Reply-To: <66e05d81c04fe_a00b829435@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:41:28 +0800
Message-ID: <CACGkMEt9NLqwLB-fyUi0qNW7ZKO2o7rgC1Y+=UTHw8eXf=Coqw@mail.gmail.com>
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org, 
	nsz@port70.net, mst@redhat.com, yury.khrustalev@arm.com, broonie@kernel.org, 
	sudeep.holla@arm.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:54=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Willem de Bruijn wrote:
> > Jason Wang wrote:
> > > On Tue, Sep 10, 2024 at 8:40=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > The referenced commit drops bad input, but has false positives.
> > > > Tighten the check to avoid these.
> > > >
> > > > The check detects illegal checksum offload requests, which produce
> > > > csum_start/csum_off beyond end of packet after segmentation.
> > > >
> > > > But it is based on two incorrect assumptions:
> > > >
> > > > 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GS=
O.
> > > > True in callers that inject into the tx path, such as tap.
> > > > But false in callers that inject into rx, like virtio-net.
> > > > Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> > > > CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
> > > >
> > > > 2. TSO requires checksum offload, i.e., ip_summed =3D=3D CHECKSUM_P=
ARTIAL.
> > > > False, as tcp[46]_gso_segment will fix up csum_start and offset for
> > > > all other ip_summed by calling __tcp_v4_send_check.
> > > >
> > > > Because of 2, we can limit the scope of the fix to virtio_net_hdr
> > > > that do try to set these fields, with a bogus value.
> > > >
> > > > Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port7=
0.net/
> > > > Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in vi=
rtio_net_hdr")
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > Cc: <stable@vger.kernel.net>
> > > >
> > > > ---
> > > >
> > > > Verified that the syzbot repro is still caught.
> > > >
> > > > An equivalent alternative would be to move the check for csum_offse=
t
> > > > to where the csum_start check is in segmentation:
> > > >
> > > > -    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header=
(skb)))
> > > > +    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header=
(skb) ||
> > > > +                 skb->csum_offset !=3D offsetof(struct tcphdr, che=
ck)))
> > > >
> > > > Cleaner, but messier stable backport.
> > > >
> > > > We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L=
4.
> > > > But that csum_offset test was in a different commit, so different
> > >
> > > Not for this patch, but I see this in UDP_L4:
> > >
> > >                        if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM=
))
> > >                                return -EINVAL;
> > >
> > > This seems to forbid VIRTIO_NET_HDR_F_DATA_VALID. I wonder what's the
> > > reason for doing this.
> >
> > It tests &, not =3D=3D ?
>
> Oh you mean as alternative, for receive of GRO from hypervisor.

Or it could be a physical device that can do GRO HW.

>
> Yes, fair point.
>
> Then we also trust a privileged process over tun, like syzkaller.
> When it comes to checksums, I suppose that is fine: it cannot harm
> kernel integrity.

Yes.

>
> One missing piece is that TCP GSO will fix up non CHECKSUM_PARTIAL
> skbs. UDP GSO does not have the same logic.
>

Thanks


