Return-Path: <netdev+bounces-232169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD692C02019
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 451E2566390
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195F3148BA;
	Thu, 23 Oct 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnqjvVeB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F92F6188
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231788; cv=none; b=WjA+KDwyqs9btVpPprKysKmBIJykI71BaRPw5IsyeZPzbUDHO4s2eb0Ufjqq4CyHCPxT9FgA3Z1oGZRHMsJMj7nR36VfPOXFWfBskSUH5FN/zRFNuc6Zmn9qnxFkoNWKGoN0ZMhglixeaMoE2KmaonKMDa71kxELNYnaezniaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231788; c=relaxed/simple;
	bh=rUXPOmt1EUm6PmY/o2/f0f6SGZnwJKW35QEQoqk+Bgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anT98fbJsnLdLA3WcosmKTWsiPizNj3SZeDuC+ZsGi6okGZPVnkG+dfeofZ5P5DnF6TRZs9I+ZDDlPVqK0P+PFPkjXcvnOoKKmyMVXcG6Lhww8ccLrIF8F+w7Q1itAeTT4P7SE5D7QriT9dqHHAOtLxQXoTtZm7ipLJQGpo0xRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnqjvVeB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430e6ac6bccso11929985ab.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231786; x=1761836586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYCbUEr4F+tt1NYE5yx2upuNkL2M3VcbJfhNaJaIvbk=;
        b=fnqjvVeB3OtERClXkynBBL9lMj9HKkDf+AJj+1JAePUOyMUf6ffobnv7OhcnLYod2G
         KSwh9yuurtsHvTu4KHqDH1ALIcYIBJuL4K6Mwpcyk578wlUKiAclN5f3zgdTnyQCn/P2
         3EHGs1LlzQTI3hya9unC/5RnD/1GexRVL+sopL7IWXqqCi0KU3xAlIifL7apLdmHvpbr
         CoD4G7F3Ng8FfytQB5yoQatvU7dkZUUHXtOa4QjSBPX/9jpJlBjZlJwwzjGpUWVBXEMU
         d7yPcX/BgZmzdrOJfnTaoxh/O8G8MCk1ciLYIjYDey8RbDPdHZeamed4g6Fr31jUNQMC
         TPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231786; x=1761836586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYCbUEr4F+tt1NYE5yx2upuNkL2M3VcbJfhNaJaIvbk=;
        b=Ou5gt5tpD6X0Db7nT7N4eb/ZKmAmMa5detkMOv/+J72iEFc/wzSeKcDzo7eneM3gu2
         PBJv/RxcBGK9MYq2tRUqi2JEUTrRJKwuCtTkIHpjd78DHvLL4N9D0gJiwSAbAa6JjE5M
         4VHstQSoXV4FZpOCSfgLlB0Qrp1Cr58nZmN/ghb+9BJfHiQmH9NHKkRZTC0Db+3O3pje
         3d4nZdzFhePlR5ECeW0ZL++tJEmR9jZqq9s1VUb/LSc/iyfDf5rr9WZLZYDGcwUhqbft
         5vVioG/PEC2jm4cX+FhvRN9gMkrhcI7U62eZs8BnA+0UE73zwXosvPvqYRbxVV84yZ5b
         FvJg==
X-Forwarded-Encrypted: i=1; AJvYcCVsW1bcgelZrfazgJHoBy44aLzFL+MQmXmqLI/1vwDNJHFpBLzzGdxAt2waY0h4i2DwVXmtwFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5hJQOjhSZ0uskerhLCaSM/DvtNa7PcMl+3FbhdPFVxVU+Vbc
	U4obxQCL6ixFcrPtnJ/nNHYl+jpStpwqac1UKhZufyczn5fE90Agf0UsjYQqXayk9DdplBcPkrq
	SyYLpNSPMla6/IPgxr2OAWgqq6bbrk6Q=
X-Gm-Gg: ASbGncsAKZIq1A1O2EYTgstCAz7pz20p4N1xBFXD5+/golSN4ev3K7+aMXcNMRBs7Zk
	NEkF++GVVKwe3WJ8hwGU2KrNaV5sO4QLxZxoPMn4fqDy32+Np5e5qnbjyk4CVzc19l0VMgZZAOe
	nWnnme1+ZGOsewFHolao7RFET9mEucHSQGX4Gn0EEQ6wNrmvCcPsXBoY32Nf2klPdistEWVp0pQ
	7zghVVyA7zegXVtumKocWSCGDcf4wi6N0GOWtLtFavvvASMw5FLwnOGh2rW+Gih
X-Google-Smtp-Source: AGHT+IHgnGY4GUw/2aleGw4Z+iK+CQPqwf/PHsqEsn+xLKQngQMTbxmjXs+YGu4DnlTDzTBS79AHkIgo6RB01K0zLy8=
X-Received: by 2002:a05:6e02:1aac:b0:430:b467:1af8 with SMTP id
 e9e14a558f8ab-431d31906d9mr95231355ab.2.1761231785802; Thu, 23 Oct 2025
 08:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023085843.25619-1-kerneljasonxing@gmail.com> <d3c91a9d-4de4-4091-bec8-c339fcb65fb7@intel.com>
In-Reply-To: <d3c91a9d-4de4-4091-bec8-c339fcb65fb7@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Oct 2025 23:02:29 +0800
X-Gm-Features: AWmQ_bkDdf4kaZdmMEwmYL8QOtIR0q2LKK9I0PDcFOo8cU1Owbfa9JeFVM9JupM
Message-ID: <CAL+tcoCjGX8z_UMCy0xidz1kS1EYeH-Q8r_KAo+J0LexwrSnMg@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: add indirect call for xsk_destruct_skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:32=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 23 Oct 2025 16:58:43 +0800
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since Eric proposed an idea about adding indirect call for UDP and
> > managed to see a huge improvement[1], the same situation can also be
> > applied in xsk scenario.
> >
> > This patch adds an indirect call for xsk and helps current copy mode
> > improve the performance by around 1% stably which was observed with
> > IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> > will be magnified. I applied this patch on top of batch xmit series[2],
> > and was able to see <5% improvement.
>
> Up to 5% is really good.

Yep, but the perf number fluctuates a little bit from our internal
app, not like the first test showing a stable 1% number. so I used '<'
symbol. I think I will add more description around it in the next
respin.

>
> One nit below:
>
> >
> > [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@g=
oogle.com/
> > [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing=
@gmail.com/
> >
> > Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h | 5 +++++
> >  net/core/skbuff.c      | 8 +++++---
> >  net/xdp/xsk.c          | 2 +-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ce587a225661..431de372d0a0 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -125,6 +125,7 @@ struct xsk_tx_metadata_ops {
> >  int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> >  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
> >  void __xsk_map_flush(struct list_head *flush_list);
> > +void xsk_destruct_skb(struct sk_buff *skb);
>
> I'd suggest wrapping this declaration into INDIRECT_CALLABLE_DELCARE()
> here...

I see. I will add it and verify it tomorrow morning!

>
> >
> >  /**
> >   *  xsk_tx_metadata_to_compl - Save enough relevant metadata informati=
on
> > @@ -218,6 +219,10 @@ static inline void __xsk_map_flush(struct list_hea=
d *flush_list)
> >  {
> >  }
> >
> > +static inline void xsk_destruct_skb(struct sk_buff *skb)
> > +{
> > +}
>
> ...and guard this stub with CONFIG_MITIGATION_RETPOLINE, then...

At first glance, I'm not sure if it works when CONFIG_INET is
disabled. I will test it and then get back to you here if anything
goes wrong.

>
> > +
> >  static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *me=
ta,
> >                                           struct xsk_tx_metadata_compl =
*compl)
> >  {
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 5b4bc8b1c7d5..00ea38248bd6 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -81,6 +81,7 @@
> >  #include <net/page_pool/helpers.h>
> >  #include <net/psp/types.h>
> >  #include <net/dropreason.h>
> > +#include <net/xdp_sock.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <trace/events/skb.h>
> > @@ -1140,12 +1141,13 @@ void skb_release_head_state(struct sk_buff *skb=
)
> >       if (skb->destructor) {
> >               DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> >  #ifdef CONFIG_INET
> > -             INDIRECT_CALL_3(skb->destructor,
> > +             INDIRECT_CALL_4(skb->destructor,
> >                               tcp_wfree, __sock_wfree, sock_wfree,
> > +                             xsk_destruct_skb,
> >                               skb);
> >  #else
> > -             INDIRECT_CALL_1(skb->destructor,
> > -                             sock_wfree,
> > +             INDIRECT_CALL_2(skb->destructor,
> > +                             sock_wfree, xsk_destruct_skb,
> >                               skb);
> >
> >  #endif
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7b0c68a70888..8e6ccb2f79c0 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -605,7 +605,7 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> >       return XSKCB(skb)->num_descs;
> >  }
> >
> > -static void xsk_destruct_skb(struct sk_buff *skb)
> > +void xsk_destruct_skb(struct sk_buff *skb)
>
> ...replace `static` with INDIRECT_CALLABLE_SCOPE here.
>
> >  {
> >       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_met=
a;
>
> The reason is that we want to keep this function static on systems where
> retpoline is not a thing. IOW the same that is done for IP, TCP/UDP, GRO
> etc etc.

I see, thanks for clarifying this.

Thanks,
Jason

>
> Thanks,
> Olek

