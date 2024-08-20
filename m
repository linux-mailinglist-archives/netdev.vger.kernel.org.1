Return-Path: <netdev+bounces-120276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF712958C21
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4856AB2154F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7281A7048;
	Tue, 20 Aug 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="StZHisCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554DD194145
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170924; cv=none; b=kiOore9zZ3nWTijDDGQ4JP5obHJRu57NzACulKtUw+thXqwWuwyoLzNHQWULm156HEY63GMBHGK/tHElE8Ju/zAbgnj8QniWK4Megc0G5iE5WzOWNcxZaE8+sD2BOFCfgX9ek0vrVpzCgiTF1DPtYmhBzz1uhT0acZoAQNPmRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170924; c=relaxed/simple;
	bh=a6oWZRcg9zYwJEsO0/P6Bzp+5DTEJgP4i2nSaYQ0lzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEl7KoVRhOSJvHdXD0QfZVUss/ye/ftEvxcy+wapwQabtXbEvWv9YUTsypflNAJ0LQI2BF80M30fB7RK0S/wQ8umnE0bkTYV+xDrK035ZSPFW62FN3EAArN+03JIgfIvvNI8EG1DqS10E9JvKpMZheB3SSSY3uMyIZY79Vep4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=StZHisCT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so2889212a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724170921; x=1724775721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOa5N9Vb4zQ6xbhOuRdjlflDNZqiL9no11bE+Ee56uI=;
        b=StZHisCTxf/ZTvTpDzYkZ4Ukyxf2PQTCZUBzNZIJmIavk51ceJTsEgvHvqk59FRF/p
         MbjrsxQopnfihMVU/PETQi0Q9Uzd51MdrqerNjzTzKpFgEisE0GSNnNC8w0e/DW7I41q
         tEwnGl72XNBhE7OAlpjCOCy5ljuuaJ29UsO52MmMDWtV9VRYZgMt/peiI/6teJsSS6zd
         xXNYt4CJvecjnOi73+uQpnrYxjMNK9PZkf08mt9Xw4pEbhK/A/2JICTifECPmw1V/mx6
         aumKLGB0DUAyHE4Z/18NUgeo+T/v+LFsjtK/oQ/ORJxdld2MnZy+d+I7xfPJ+CpPN++5
         uDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170921; x=1724775721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOa5N9Vb4zQ6xbhOuRdjlflDNZqiL9no11bE+Ee56uI=;
        b=D7p8Jwg5bHU6VH74yrg2M8SMCayKz//WICdYhknjfWYY19A65WVrRA6hRIhfxMUjG2
         N/D4ytA5MOLj2UOGJuI+1vJm2VyR0D8QMKvRBKdYHXwYg2B9Iwu+FmW+YyV4QGJkVELB
         PWspmELnOV6UAO9e4tS0HN/O/7oNq2rqZRhwhpZYpbWrI5U9TKQctZigOBnbpyae7oJb
         9fWHr6rw8pqt8lQbwcsrMdDzFttudNWqnzalb9OA5tktsGPbnV+g2XhcV5CswEV9T1wf
         EBR5YjH9a56Kd+uZAni1IfDYjPkAeQLqezzCgVDjjoCLYK6Yc6jfO2YyDbQGARqnBehz
         4zoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW27uOtfc1ExJSXXDrL/7snlbmuoEbsGqjyJ2KwzFoOZyC7zxDU+l/S9ysAilaxGNXhB6uRKQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztY3+YQdjX26VsCFnLEW/zyqZ8jwBCNy60iQeVQCrOvshx9f1c
	wOIetfhb3xijSwMmmEignbwu/Im292RgY4epoeROrJBWBjXzC351muv4M8l4CZGn8JfY5sjZsnp
	ElfuPpGDNTYw1YQAOr8DSqSroJ2zL1L3UTxLP
X-Google-Smtp-Source: AGHT+IHHD4ZzadI8oaFYU+LaMfuXa5avvMINX/MufPBIvimYKnWggWCjyduPNuQ3jwf29EQyzSPo3xxWrCjq2O6FoQY=
X-Received: by 2002:a05:6402:4493:b0:5b9:df62:15cd with SMTP id
 4fb4d7f45d1cf-5bf0d2ab635mr1794494a12.32.1724170919858; Tue, 20 Aug 2024
 09:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214527.2100137-1-tom@herbertland.com> <20240815214527.2100137-2-tom@herbertland.com>
 <66bfa0823734a_184d66294a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <66bfa0823734a_184d66294a3@willemb.c.googlers.com.notmuch>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 20 Aug 2024 09:21:48 -0700
Message-ID: <CALx6S37CEvh1zBijdP7NWfom8_5YByUegAaYr4jibeKOoO=TpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] flow_dissector: Parse ETH_P_TEB and
 move out of GRE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:54=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
> > a plain Etherent frame. Add case in skb_flow_dissect to parse
> > packets of this type
> >
> > If the GRE protocol is ETH_P_TEB then just process that as any
> > another EtherType since it's now supported in the main loop
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> > -     if (gre_ver =3D=3D 0) {
> > -             if (*p_proto =3D=3D htons(ETH_P_TEB)) {
> > -                     const struct ethhdr *eth;
> > -                     struct ethhdr _eth;
> > -
> > -                     eth =3D __skb_header_pointer(skb, *p_nhoff + offs=
et,
> > -                                                sizeof(_eth),
> > -                                                data, *p_hlen, &_eth);
> > -                     if (!eth)
> > -                             return FLOW_DISSECT_RET_OUT_BAD;
> > -                     *p_proto =3D eth->h_proto;
> > -                     offset +=3D sizeof(*eth);
> > -
> > -                     /* Cap headers that we access via pointers at the
> > -                      * end of the Ethernet header as our maximum alig=
nment
> > -                      * at that point is only 2 bytes.
> > -                      */
> > -                     if (NET_IP_ALIGN)
> > -                             *p_hlen =3D *p_nhoff + offset;
> > -             }
> > -     } else { /* version 1, must be PPTP */
>
> > @@ -1284,6 +1268,27 @@ bool __skb_flow_dissect(const struct net *net,
> >
> >               break;
> >       }
> > +     case htons(ETH_P_TEB): {
> > +             const struct ethhdr *eth;
> > +             struct ethhdr _eth;
> > +
> > +             eth =3D __skb_header_pointer(skb, nhoff, sizeof(_eth),
> > +                                        data, hlen, &_eth);
> > +             if (!eth)
> > +                     goto out_bad;
> > +
> > +             proto =3D eth->h_proto;
> > +             nhoff +=3D sizeof(*eth);
> > +
> > +             /* Cap headers that we access via pointers at the
> > +              * end of the Ethernet header as our maximum alignment
> > +              * at that point is only 2 bytes.
> > +              */
> > +             if (NET_IP_ALIGN)
> > +                     hlen =3D nhoff;
>
> I wonder why this exists. But besides the point of this move.

Willem,

Ethernet header breaks 4-byte alignment of encapsulated protocols
since it's 14 bytes, so the NET_IP_ALIGN can be used on architectures
that don't like unaligned loads.

Tom

>
> > +
> > +             goto proto_again;
> > +     }
>

