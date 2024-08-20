Return-Path: <netdev+bounces-120281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54528958C84
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6771C21D1A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340E1B86F1;
	Tue, 20 Aug 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Zec+lOXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95218C92C
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172149; cv=none; b=Cz5KGYZmysnk7GA5l4VLHmFmFOdnxIlrZBHDwwSSGaKSDrHCN2aPC0n5gu4pos/OMEdxyqNs/ZgaWZgo1noTE+ha0S5YNVj5Jwn1KPLSNYf5GrfW2RhlOUePnd8Lob8RhW5Nrz/k+DC2lvrsBR5A/Nq6HhKx0XqgSJtM6Q+I45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172149; c=relaxed/simple;
	bh=2vRNixAWtclxcQZiSOznAoA/bBOCV5VQEvi3Ygtmkik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDxdS9vn0C9YAX4z6l1boTn6X4klUPXLhTBKavqeqGVGYyuEGCdSV9gWkxejOZk2F2YH0VvbEHz6kivxpm8MO1kSSFFIJGLBuhujcVMVHaYpqql1XwAVjh/JXGC5s6gzG6vXCiyXgum4VEpfUP9hGkWfCWbclpCf+aO2L1UGnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Zec+lOXI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bec7ee6f44so5324163a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724172145; x=1724776945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vQZkAXhhfpfj8h8sbzPkAGSApbvJq152rmpW+cRK2M=;
        b=Zec+lOXI+3R/EFCVIZVWEnOxUHa26T5yWBED7Dlkgns2kIhNwGa1uuoWKz0m1BzFuu
         T765JxYfKNLcyNYjhkKe/fAzN9O/p6GnCkHCSWaSZlZSI6gSWCvA2fpa6aBynh6zXO/u
         eIEGq9rdOalZvXzhwQmSiqvQOYK4040uOEGjZ/btLUXV6Vo568xNQqrIcFGJsLaZ29v7
         /luskG7NMv/2rtrDBLkL6IgmG8Cwy9VaAj8FCsv1c/Fgf2QyGeNoLf+Qzc7ysJoPHPct
         2pR/pXlJfSLlCzZCCWToOzm1aJj/6Vj0QxTpMDuY9dlzHL347XRhTNYeHGvv9c4P/I/n
         o+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724172145; x=1724776945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vQZkAXhhfpfj8h8sbzPkAGSApbvJq152rmpW+cRK2M=;
        b=JLuOsIrKJgUFPevtZDqmWOi6Yjray48pwrjIAbTsnlQl0SHQcxIMRwtaEBv9zDtScz
         iLWSNFHOjRVBe+jDm83tu5YG4uyWCMLr9rVM+XnP0/6SWsniDCO7GUBhRfa2eS65G8hf
         s4QAQhljZd2pt+wHzBSSvDbGz/Jpmw7oGIVz1DnWzKXKnz0YfEwwmU+DVxXKNsZnrw/O
         7rKmMD0rM3wfustDGwiIAxVOdKWyvHH4KtUiVOQjmIkXyUqKz+lclEtBY0KxrVNAOE30
         7Ah1TOy773Y8w3zlzQgFyXadrMxNwDxbjNJlftDLt9xDgb2vN/es1KGvO1W9TUrjHjZy
         xwYg==
X-Forwarded-Encrypted: i=1; AJvYcCWy5TbcqBb+hD9jRhqY+6gSd0DWv8p4rDChkfAFsiw+ih+fCRcy7vz9q9alCYr3Pz/zZoF6cEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueKTg030KOoatthwWpEGpg/LrAAw6s+4NYov6DARKmZgSUobS
	pToVCOyIhfRn7SBIIpLXF5q475970gv1wEbKz9Nf/WiSCZbayc0n8T4gGgLoqAjn7Eqm+5nazi7
	fd24PkKK1qMpOsFUnCdG207OSrRGHM5aU8vf9
X-Google-Smtp-Source: AGHT+IFc/60yA71CSodDlxN0om+qq6AjZc1wSpgiEG6p+ZQB5Qo/KN557HMhFIv4bpz561IcADvESGuxD37hNGFLTJk=
X-Received: by 2002:a05:6402:254e:b0:5be:daba:8bc5 with SMTP id
 4fb4d7f45d1cf-5bedaba8e8emr7818996a12.16.1724172144836; Tue, 20 Aug 2024
 09:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214527.2100137-1-tom@herbertland.com> <20240815214527.2100137-2-tom@herbertland.com>
 <66bfa0823734a_184d66294a3@willemb.c.googlers.com.notmuch>
 <CALx6S37CEvh1zBijdP7NWfom8_5YByUegAaYr4jibeKOoO=TpQ@mail.gmail.com> <66c4c493543_aed9229422@willemb.c.googlers.com.notmuch>
In-Reply-To: <66c4c493543_aed9229422@willemb.c.googlers.com.notmuch>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 20 Aug 2024 09:42:05 -0700
Message-ID: <CALx6S35b-YPCaen7D0THQ++giSM6cXJHVOtysg1pi5itKT-mFA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] flow_dissector: Parse ETH_P_TEB and
 move out of GRE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:30=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > On Fri, Aug 16, 2024 at 11:54=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Tom Herbert wrote:
> > > > ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
> > > > a plain Etherent frame. Add case in skb_flow_dissect to parse
> > > > packets of this type
> > > >
> > > > If the GRE protocol is ETH_P_TEB then just process that as any
> > > > another EtherType since it's now supported in the main loop
> > > >
> > > > Signed-off-by: Tom Herbert <tom@herbertland.com>
> > >
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >
> > > > -     if (gre_ver =3D=3D 0) {
> > > > -             if (*p_proto =3D=3D htons(ETH_P_TEB)) {
> > > > -                     const struct ethhdr *eth;
> > > > -                     struct ethhdr _eth;
> > > > -
> > > > -                     eth =3D __skb_header_pointer(skb, *p_nhoff + =
offset,
> > > > -                                                sizeof(_eth),
> > > > -                                                data, *p_hlen, &_e=
th);
> > > > -                     if (!eth)
> > > > -                             return FLOW_DISSECT_RET_OUT_BAD;
> > > > -                     *p_proto =3D eth->h_proto;
> > > > -                     offset +=3D sizeof(*eth);
> > > > -
> > > > -                     /* Cap headers that we access via pointers at=
 the
> > > > -                      * end of the Ethernet header as our maximum =
alignment
> > > > -                      * at that point is only 2 bytes.
> > > > -                      */
> > > > -                     if (NET_IP_ALIGN)
> > > > -                             *p_hlen =3D *p_nhoff + offset;
> > > > -             }
> > > > -     } else { /* version 1, must be PPTP */
> > >
> > > > @@ -1284,6 +1268,27 @@ bool __skb_flow_dissect(const struct net *ne=
t,
> > > >
> > > >               break;
> > > >       }
> > > > +     case htons(ETH_P_TEB): {
> > > > +             const struct ethhdr *eth;
> > > > +             struct ethhdr _eth;
> > > > +
> > > > +             eth =3D __skb_header_pointer(skb, nhoff, sizeof(_eth)=
,
> > > > +                                        data, hlen, &_eth);
> > > > +             if (!eth)
> > > > +                     goto out_bad;
> > > > +
> > > > +             proto =3D eth->h_proto;
> > > > +             nhoff +=3D sizeof(*eth);
> > > > +
> > > > +             /* Cap headers that we access via pointers at the
> > > > +              * end of the Ethernet header as our maximum alignmen=
t
> > > > +              * at that point is only 2 bytes.
> > > > +              */
> > > > +             if (NET_IP_ALIGN)
> > > > +                     hlen =3D nhoff;
> > >
> > > I wonder why this exists. But besides the point of this move.
> >
> > Willem,
> >
> > Ethernet header breaks 4-byte alignment of encapsulated protocols
> > since it's 14 bytes, so the NET_IP_ALIGN can be used on architectures
> > that don't like unaligned loads.
>
> I understand how NET_IP_ALIGN is used by drivers.
>
> I don't understand its use here in the flow dissector. Why is hlen
> capped if it is set?

Willem,

For the real Ethernet header the receive skbuf is offset by two so
that device places the packet such that the Ethernet payload, i.e. IP
header, is aligned to four bytes (14+2=3D16 which will be offset of IP
header). When a packets contains an encapsulated Ethernet header, the
offset of the header is aligned to four bytes which means the payload
of that Ethernet header, i.e. an encapsulated IP header, is not four
byte aligned and neither are any subsequent headers (TCP, UDP, etc.).
On some architectures, performing unaligned loads is expensive
compared to aligned loads, so hlen is being capped here to avoid
having flow dissector do that on unaligned headers after the Ethernet
header. It's a tradeoff between performance and deeper flow
dissection.

Tom

