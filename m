Return-Path: <netdev+bounces-124046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9292C967683
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9351F2144E
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735317D354;
	Sun,  1 Sep 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9lKEIiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06CE2B9BB;
	Sun,  1 Sep 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725195370; cv=none; b=BqfmwJkjf+zYWGOW9q42olSw1O4OAK99MCOUiVOlSm3LF1lT/IfmFrO2wo1vLn+vVRHWrUxf77jT4xXRvbZi0WnChcfTA2i/8zp5kUXU4jo8EVkcqn4mJ6i8wVY1iNiv4+1I/SKihrLsjk5JVUQLD/3I7RhQxB/zYndaoo+jxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725195370; c=relaxed/simple;
	bh=j1wx7444vm1ATkTErxadGwpTIGww9SvhaADCGALbQTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7MXbwiK4tP9Gm8vyiWqTZ4n+rH3BBMzgcwlgNhDUllm1LdO/YyRuDKOl1qlU05cYEtgywDGgJKSDAj4alj32TVQYRmtF6V0+ZPEzMhmlZCBoT/7rXnzDBEZzv6Nw+pDokH1r62UCJe7vLWVp+bGtgsWK6OCnJbsf2pEfqNMXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9lKEIiT; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so2433290276.3;
        Sun, 01 Sep 2024 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725195368; x=1725800168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG9h71V7gGQO9wfsZ3pur185vT2wpdRDz0Jknq+Ad2s=;
        b=i9lKEIiTwqKgsjScvZ8+pz2L6qhYFW+Z/1NXpagKfwhZJfr8EnEshmRxGGz4HMb4E/
         NBaDfopRTnOjx123YSSUPHKcpEQM4/o0et2edDbKKRvN8/3s5GruwvZqE2l0ELNsK7dM
         h0s+Qj/yTQBeKYONDdQtN+Qs5BUzyRdXmW4MT0JrC//9Z8VfGO+aZ5uSbfIRLqhqnTty
         BLgWQkOT3zQGOF0ShxRuZmQATxcaRGey6J12A4FQk8I5BoAjhE2W2yNU/0rrHMfolEnp
         YD+SUHlh7lbA0jEAUlL0Hp7g2HmpdDnro+IGQAcsxEgRYiCytdPpf1tDQHXOQXLVTTWh
         EK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725195368; x=1725800168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG9h71V7gGQO9wfsZ3pur185vT2wpdRDz0Jknq+Ad2s=;
        b=tDXSqvH3KdoX+Gt98bXqa9GIeBXI/nczgze1WHtaR7xsd4/MmUvXdpzlzNmUuivJ6O
         /Wzgf2w0uBLR/UUfURHkx7SM49uAFkgasb7oAeYy5mY9iX7Pskn8pGlC343a9K3TyyHN
         s4++tfxTsmd2zpFkAv6zN3G3/PivvSyIC6ehHP3pUghFXuNZwdhE9BnZ9By3hAJqJdne
         M+Q/oHR7yHZ7ZiuSs93aWubpuEEIHBPo0zr+tp/iNPajCZPxfdeG+tFLCIM7YNNcccuV
         WAOLcyPrAARkOY+fb3lbJGvZ1mvTKmX4BjQMj5fRcnPHY46lHMEbd/Eox1Xq4k3bHFwm
         gUdg==
X-Forwarded-Encrypted: i=1; AJvYcCVPyhEyxuGiD07PIxfb4a9LAauGWowZc5qtL3j4aH90LO0Glz4gNnWQjDzNzZMPoW7q8kG4IX5J@vger.kernel.org, AJvYcCXArvqHXt+XuplYNGeha3I5SPAPJgLXWHgFSoPaqHWJkHYOrcRYRCvHS/l9ILLquEaef5ZVBdCWL2ddAtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJrDh58XAHoV9mPMVyR06iSxrf9+atbeRAVc35NdZAm5S4sdP
	SeAwpZDdc2hp6KlI3o67KYaTQhIuLHnjoeX/6v/E6NyNhYhNbIFflKAlpjTbRzqmmGxS4gToPX+
	R/rEzDQMP5cgm2myvwRsDhejv+x4=
X-Google-Smtp-Source: AGHT+IEzQf2eyjOvut8rmYxQMRJACpQPZX3ZmTTNonxnvjG22GYyMbHoCu35rIVben1AsH7qGI5MQViM2n3cNRBka3U=
X-Received: by 2002:a25:a029:0:b0:e1a:8ceb:49bb with SMTP id
 3f1490d57ef6-e1a8ceb4c83mr4605669276.44.1725195367835; Sun, 01 Sep 2024
 05:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-7-dongml2@chinatelecom.cn> <19af6042-e937-4025-b947-8ff603b29798@intel.com>
In-Reply-To: <19af6042-e937-4025-b947-8ff603b29798@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 20:56:08 +0800
Message-ID: <CADxym3b6h6wKTsW3U8pLm+hy0BksggRwG4s9A0qLszRYg1Ze-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac() return
 drop reasons
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: kuba@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:58=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Fri, 30 Aug 2024 09:59:55 +0800
>
> > Change the return type of vxlan_set_mac() from bool to enum
> > skb_drop_reason. In this commit, two drop reasons are introduced:
> >
> >   VXLAN_DROP_INVALID_SMAC
> >   VXLAN_DROP_ENTRY_EXISTS
> >
> > To make it easier to document the reasons in drivers/net/vxlan/drop.h,
> > we don't define the enum vxlan_drop_reason with the macro
> > VXLAN_DROP_REASONS(), but hand by hand.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  drivers/net/vxlan/drop.h       |  9 +++++++++
> >  drivers/net/vxlan/vxlan_core.c | 12 ++++++------
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> > index 6bcc6894fbbd..876b4a9de92f 100644
> > --- a/drivers/net/vxlan/drop.h
> > +++ b/drivers/net/vxlan/drop.h
> > @@ -9,11 +9,20 @@
> >  #include <net/dropreason.h>
> >
> >  #define VXLAN_DROP_REASONS(R)                        \
> > +     R(VXLAN_DROP_INVALID_SMAC)              \
> > +     R(VXLAN_DROP_ENTRY_EXISTS)              \
>
> To Jakub:
>
> In our recent conversation, you said you dislike templates much. What
> about this one? :>
>
> >       /* deliberate comment for trailing \ */
> >
> >  enum vxlan_drop_reason {
> >       __VXLAN_DROP_REASON =3D SKB_DROP_REASON_SUBSYS_VXLAN <<
> >                               SKB_DROP_REASON_SUBSYS_SHIFT,
> > +     /** @VXLAN_DROP_INVALID_SMAC: source mac is invalid */
> > +     VXLAN_DROP_INVALID_SMAC,
> > +     /**
> > +      * @VXLAN_DROP_ENTRY_EXISTS: trying to migrate a static entry or
> > +      * one pointing to a nexthop
> > +      */
>
> Maybe you'd do a proper kdoc for this enum at the top?
>

Do you mean the enum vxlan_drop_reason? Yeah, that makes
sense, and I'll doc it.

> > +     VXLAN_DROP_ENTRY_EXISTS,
> >  };
> >
> >  static inline void
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index 76b217d166ef..58c175432a15 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1607,9 +1607,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *=
unparsed,
> >       unparsed->vx_flags &=3D ~VXLAN_GBP_USED_BITS;
> >  }
> >
> > -static bool vxlan_set_mac(struct vxlan_dev *vxlan,
> > -                       struct vxlan_sock *vs,
> > -                       struct sk_buff *skb, __be32 vni)
> > +static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
> > +                                       struct vxlan_sock *vs,
> > +                                       struct sk_buff *skb, __be32 vni=
)
> >  {
> >       union vxlan_addr saddr;
> >       u32 ifindex =3D skb->dev->ifindex;
> > @@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan=
,
> >
> >       /* Ignore packet loops (and multicast echo) */
> >       if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr=
))
> > -             return false;
> > +             return (u32)VXLAN_DROP_INVALID_SMAC;
> >
> >       /* Get address from the outer IP header */
> >       if (vxlan_get_sk_family(vs) =3D=3D AF_INET) {
> > @@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan=
,
> >
> >       if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
> >           vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex=
, vni))
> > -             return false;
> > +             return (u32)VXLAN_DROP_ENTRY_EXISTS;
> >
> > -     return true;
> > +     return (u32)SKB_NOT_DROPPED_YET;
>
> Redundant cast.
>

Oops, I'll remove it.

> >  }
>
> Don't you need to adjust the call site accordingly? Previously, this
> function returned false in case of error and true otherwise, now it
> returns a non-zero in case of error and 0 (NOT_DROPPED_YET =3D=3D 0) if
> everything went fine.
> IOW the call site now needs to check whether the return value !=3D
> NOT_DROPPED_YET instead of checking whether it returned false. You
> inverted the return code logic, but didn't touch the call site.
>

Yeah, you are right. I need to change the call of this function
in this patch too, rather than the next patch. Thanks for reminding
me of this point!

> >
> >  static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>
> Thanks,
> Olek

