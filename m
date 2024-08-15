Return-Path: <netdev+bounces-118968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF0953B41
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9CA281E65
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBAC13D276;
	Thu, 15 Aug 2024 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="YUmb/q1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0299811EB
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752213; cv=none; b=qHqZGHZPKGXR+R2FjZ1RzFo8RHOgHonmnCqYphRnDEom8R26HDMohzDib87/LYiy+rBANjFvYhoXpyyMGUcRgzRmJjarEpp0yGeoVEIdS5i36pwuBKsw+m5Z+4kKQYnkZsOcCk4JAOSaVx3EmnHEjUo1I5KZvYkQCx1b/TsdUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752213; c=relaxed/simple;
	bh=sH2VR3bVmHw2rzLxED/tH3Bwi+osquI9an8ghpP2+nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR4u19C4qBw/IFN/ZUr8FG241620RclASSCOqMMYTBJW3WwICB8bV4/lKeY8xgZsdV0tlbKMvE+eL3AELa6ih9mWqUFZB+6/+sje8JQneDqCr5rSYuWzxYBiCJsD2abuS69FLyIQ2yLEEY8w+T5Oqajvu3A3m+DyYPnkvAzHtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=YUmb/q1I; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8384750ca7so44340266b.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723752210; x=1724357010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QypwFSSF4TbFZFoiZSjFGiPBTF/zN386poq8ySGdudA=;
        b=YUmb/q1Io1BB+KdAFTRfzOZRBmw/6ZOP5ja/hOj0TAI42USePtemRrEWX/A8JqWs9q
         KaCFy/oz/IbTz3M60PFEJbYqyQ6TlUQf3e39XuFBMlk+A8aE8PFfC76PXhU6/BDtOQvs
         0nv8s/XDlREs5sPUjlPbZta/HZhUKHbNI6ywCClaBgqwlWEEQzji3Wvkq3y7F4WUm0pG
         CVu+aMFqup9eR8NZufykgSro/xG9tWsn0AUfZoEzWzwi2EoOzq6BrcAIatpZI7q3YYSR
         vs0ZnI6c4My69Z/SUMTA3AefV1bIYDjKaguRgzvJ1R8c6XTbR95I+flQY7APovZY7QxA
         e9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723752210; x=1724357010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QypwFSSF4TbFZFoiZSjFGiPBTF/zN386poq8ySGdudA=;
        b=VsO1n2ack/KWPF+4cVOx2fX+DnScss15d2AlgBOGeuQJRdxga4gNZ+KOCTbj3HKWXc
         kjWzoRpX9rs9e1RIduPbalQzCRupsbXf4gyc+9WATkW/rl0KX4S03TQhugieBwb7qm7o
         D43b74DDISzKuqpl15w4LwHhI5VHmxO6Oj50Jv7ITxJ1KrtAxoM3sCqU1gfH6iNiZg8z
         7XKX0RTggQFC00vZRjQf+lzICF0l27yG/Hd18wceHuPXCE8YWFM37dmJBeiSychl5RYO
         O9Rq9CvgFe0OcIaTNYBfiL+SxjUUtwGVQmXXUtnrIAEbujeEKJ95cR3alrLvILNNxXGz
         u/3g==
X-Forwarded-Encrypted: i=1; AJvYcCU6Om+yUthZWvMPEAk2wpIpg3J3jf/8J0fbHmn562j/uj7aBz88m4FswYomrGCtQtsmVPRyjbe9cZAwuyOI72jBimDttsgw
X-Gm-Message-State: AOJu0Yw3AvCD5wvtVQlHeWU3u5uQoOSk4m8+ObMAspLHzciv5VygDpbt
	pHnsex84/Qe6w8zTevz/WJd9DVwDZ+7FcdJZH+zIpyYR4FXkIgOf8DpuA0cGG4M1znXzSfp5kWq
	DKHbW6wlQsVUkaW1Wc5Ea81ZzDW7yhz1x6zCz
X-Google-Smtp-Source: AGHT+IFxcXVKMqpX+HBhwcePsAwdhzdm1qeIrvB43SYKPv4uki0TvryLWkVXGRu+q9c5X7dgvcCby0JOHngZCUGemJs=
X-Received: by 2002:a05:6402:d0b:b0:5bb:9ae0:4a49 with SMTP id
 4fb4d7f45d1cf-5beca79a781mr405852a12.30.1723752209848; Thu, 15 Aug 2024
 13:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <20240731172332.683815-11-tom@herbertland.com>
 <66ae816115189_2a7a1f29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ae816115189_2a7a1f29434@willemb.c.googlers.com.notmuch>
From: Tom Herbert <tom@herbertland.com>
Date: Thu, 15 Aug 2024 13:03:18 -0700
Message-ID: <CALx6S34V6J7oxsqBVyGb+AsT0c1khuB+mDBPNiWZSRjgRoxqsQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] flow_dissector: Parse Geneve in UDP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 12:13=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > Parse Geneve in a UDP encapsulation
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
> > ---
> >  net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 3766dc4d5b23..4fff60233992 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -11,6 +11,7 @@
> >  #include <net/fou.h>
> >  #include <net/ip.h>
> >  #include <net/ipv6.h>
> > +#include <net/geneve.h>
> >  #include <net/gre.h>
> >  #include <net/pptp.h>
> >  #include <net/tipc.h>
> > @@ -808,6 +809,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb=
,
> >       return FLOW_DISSECT_RET_PROTO_AGAIN;
> >  }
> >
> > +static enum flow_dissect_ret
> > +__skb_flow_dissect_geneve(const struct sk_buff *skb,
> > +                       struct flow_dissector *flow_dissector,
> > +                       void *target_container, const void *data,
> > +                       __be16 *p_proto, int *p_nhoff, int hlen,
> > +                       unsigned int flags)
> > +{
> > +     struct genevehdr *hdr, _hdr;
> > +
> > +     hdr =3D __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, h=
len,
> > +                                &_hdr);
> > +     if (!hdr)
> > +             return FLOW_DISSECT_RET_OUT_BAD;
> > +
> > +     if (hdr->ver !=3D 0)
> > +             return FLOW_DISSECT_RET_OUT_GOOD;
> > +
> > +     *p_proto =3D hdr->proto_type;
> > +     *p_nhoff +=3D sizeof(struct genevehdr) + (hdr->opt_len * 4);
> > +
> > +     return FLOW_DISSECT_RET_PROTO_AGAIN;
>
> Do you want to return FLOW_DISSECT_RET_OUT_GOOD if IPPROTO 59.
>
> Per your spec: "IP protocol number 59 ("No next header") may be set to
> indicate that the GUE payload does not begin with the header of an IP
> protocol."
>
> Admittedly pendantic. No idea if any implementation actually sets
> this.

It is a legal value in an IPv6 next header field. I'll add
IPPROTO_NONXTHDR and handling in flow dissector.

Tom

>
> > +}
> > +
> >  /**
> >   * __skb_flow_dissect_batadv() - dissect batman-adv header
> >   * @skb: sk_buff to with the batman-adv header
> > @@ -974,6 +998,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, =
struct net *net,
> >                                              target_container, data,
> >                                              p_proto, &nhoff, hlen, fla=
gs);
> >               break;
> > +     case UDP_ENCAP_GENEVE:
> > +             ret =3D __skb_flow_dissect_geneve(skb, flow_dissector,
> > +                                             target_container, data,
> > +                                             p_proto, &nhoff, hlen, fl=
ags);
> > +             break;
> >       default:
> >               break;
> >       }
> > --
> > 2.34.1
> >
>
>

