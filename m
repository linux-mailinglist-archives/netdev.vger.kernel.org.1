Return-Path: <netdev+bounces-120277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54F958C30
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8284D284C3B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBF71750;
	Tue, 20 Aug 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8PI3g7z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEA4409
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171414; cv=none; b=AxQQSzHfw/3ip4rk68SAAZ2cOBugA5ebu0W1/q3E5hmkZhL5bmKHbBwQ3iqKM12kJ2mJknBWxYpoXm3RiNX0QM9P6yT2eCV/SPFiB+eT/zZvA+vqb9LeM2fcUEj3pskTjDrFyRLM1EYtpSwg51QZwTYXcqhmjg7r/7FGf3ZukY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171414; c=relaxed/simple;
	bh=Q6CKskFWl8XlMyka7KwWO87jEeFXscEDIxQgJB3/d94=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FXsbl/VI+/eMAHpOOgb2LRNMcZmw2i4+YM3Z7yzLID+SXjDWqkxERwUNQrLPGoVMka3DFuNLIo1KxfptmTasoHRIfSiJXzpvJvY1rSQCwsKofDrG1qh5twGkYfZxLmrK7+EWHzXDm0yfCCR92VZaWEYCmqV38u0F0WC/oU2zqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8PI3g7z; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d42da3f7so360578885a.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724171412; x=1724776212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QInPkXiTlrqwtHojvgxf9M4k9KqxyEnaMAF8tQz5CyM=;
        b=J8PI3g7zwkdhAG5aSVDxbRMx+F8BC9bHNei07efCCLnEKFynvdkBbqvM2SGnCgI6NC
         ZVYVwMVLLhGuWiURA2TJTWPyga3nT7zVdNOyn5rDGFFimYi6CEjskIzbH9b22yesJiBz
         yv4J+gstwMkBCsb6EW8042e9az5Lvx6vzl8cwMAF85eQu5odB1i9LT/P34E/RVBf9DgQ
         I/RjjgzdfWNrNvdzBjiHZw9feTy14HMIjiZVniKq/Uz6/dVidtrhMsOdxXW1ZmWDD4EB
         Oxv/1M55H12CoduOUCmrU0CGg9zIXWUeiglQGEaGV4Pg665ge8ieo66gva72nBPrg3vA
         AE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171412; x=1724776212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QInPkXiTlrqwtHojvgxf9M4k9KqxyEnaMAF8tQz5CyM=;
        b=YxrjPfYOKF3ke5CK4ayLMPkA+MENiut7U7UqIMQpx7C19iPGsR6zPvqU+hSTWH72Eg
         6WFV0iU+F1EIWyimuOIv2Ni5h6fOlcpE92aEC6+ZLOCyiFqwiSzspg7G7gPB2+Mj/z1E
         OUjAxCz1KL84O7XyIsxWaad8vQHmLQAPrqwsIn72nRXarLkvz/r3rTl+z7M0F4OM3/xF
         /0RW03uKk+lIfGM7FseOvPm+TOmF4lp0PSA2GQUaNQ+4KmxXJH1AojjXK298MJf7+dkA
         h3/vwanRFAllS+Rc93bybcHZzmOuefBZFYnxsU0V2Qi/C3b1ns/1VKRXYX+/bc/Uhpl6
         g+4g==
X-Forwarded-Encrypted: i=1; AJvYcCURZ+Oz3792aGmXI4poAtBgfqMg+JfjmqzieCWmjC1UJd8EBN0LirlZiGev+EZJmQNwY9sboWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcfU/IjvSADy2GgXZSk6AsMvz/l+UDIIPniqX7oFY1hKG2EKR
	JD57jJbRLGexVzxIZfpn+JaCwf9cvtSH5DiQunGA2YysQE0oegOO
X-Google-Smtp-Source: AGHT+IF3c9YuyUc212u09o+8P5RpUYUnWWOM17W0nZktOE0Xi+Dt9rvoPWomvN70Fho9ERbWpjVnxA==
X-Received: by 2002:a05:620a:31a1:b0:79e:fc9c:4bcb with SMTP id af79cd13be357-7a5068f8af8mr1837757085a.11.1724171411823;
        Tue, 20 Aug 2024 09:30:11 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff120085sm534267485a.131.2024.08.20.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:30:11 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:30:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Message-ID: <66c4c493543_aed9229422@willemb.c.googlers.com.notmuch>
In-Reply-To: <CALx6S37CEvh1zBijdP7NWfom8_5YByUegAaYr4jibeKOoO=TpQ@mail.gmail.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-2-tom@herbertland.com>
 <66bfa0823734a_184d66294a3@willemb.c.googlers.com.notmuch>
 <CALx6S37CEvh1zBijdP7NWfom8_5YByUegAaYr4jibeKOoO=TpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] flow_dissector: Parse ETH_P_TEB and
 move out of GRE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tom Herbert wrote:
> On Fri, Aug 16, 2024 at 11:54=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Tom Herbert wrote:
> > > ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
> > > a plain Etherent frame. Add case in skb_flow_dissect to parse
> > > packets of this type
> > >
> > > If the GRE protocol is ETH_P_TEB then just process that as any
> > > another EtherType since it's now supported in the main loop
> > >
> > > Signed-off-by: Tom Herbert <tom@herbertland.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > > -     if (gre_ver =3D=3D 0) {
> > > -             if (*p_proto =3D=3D htons(ETH_P_TEB)) {
> > > -                     const struct ethhdr *eth;
> > > -                     struct ethhdr _eth;
> > > -
> > > -                     eth =3D __skb_header_pointer(skb, *p_nhoff + =
offset,
> > > -                                                sizeof(_eth),
> > > -                                                data, *p_hlen, &_e=
th);
> > > -                     if (!eth)
> > > -                             return FLOW_DISSECT_RET_OUT_BAD;
> > > -                     *p_proto =3D eth->h_proto;
> > > -                     offset +=3D sizeof(*eth);
> > > -
> > > -                     /* Cap headers that we access via pointers at=
 the
> > > -                      * end of the Ethernet header as our maximum =
alignment
> > > -                      * at that point is only 2 bytes.
> > > -                      */
> > > -                     if (NET_IP_ALIGN)
> > > -                             *p_hlen =3D *p_nhoff + offset;
> > > -             }
> > > -     } else { /* version 1, must be PPTP */
> >
> > > @@ -1284,6 +1268,27 @@ bool __skb_flow_dissect(const struct net *ne=
t,
> > >
> > >               break;
> > >       }
> > > +     case htons(ETH_P_TEB): {
> > > +             const struct ethhdr *eth;
> > > +             struct ethhdr _eth;
> > > +
> > > +             eth =3D __skb_header_pointer(skb, nhoff, sizeof(_eth)=
,
> > > +                                        data, hlen, &_eth);
> > > +             if (!eth)
> > > +                     goto out_bad;
> > > +
> > > +             proto =3D eth->h_proto;
> > > +             nhoff +=3D sizeof(*eth);
> > > +
> > > +             /* Cap headers that we access via pointers at the
> > > +              * end of the Ethernet header as our maximum alignmen=
t
> > > +              * at that point is only 2 bytes.
> > > +              */
> > > +             if (NET_IP_ALIGN)
> > > +                     hlen =3D nhoff;
> >
> > I wonder why this exists. But besides the point of this move.
> =

> Willem,
> =

> Ethernet header breaks 4-byte alignment of encapsulated protocols
> since it's 14 bytes, so the NET_IP_ALIGN can be used on architectures
> that don't like unaligned loads.

I understand how NET_IP_ALIGN is used by drivers.

I don't understand its use here in the flow dissector. Why is hlen
capped if it is set?=

