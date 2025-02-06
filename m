Return-Path: <netdev+bounces-163344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47465A29F69
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBED1888F5A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716D15990C;
	Thu,  6 Feb 2025 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="fRN3Gs98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D07DA7F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812963; cv=none; b=RlNhnkiYuwZetDDA/wqvCx8ksH9FejnAfrjPrRh26d3OkTfZqnhwzUovJPcM85y82DrSBOzyzhwUt0f8I/Vfk12oc1UGFeNQsoHUxkZ5Id51sxnXdat9HJr2DON+X8ScC7vgSkwgKNjh53wEpitMXwTrNVeJg9PzCNoiTsW6mKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812963; c=relaxed/simple;
	bh=3GqPrezd9s/s4qJ+iK3AdV52W5ExtUHW7HJn7S4SBkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZ8tVpIoU3R14IkXVjcn8bqaXgwOoKgypRHDjh4IoXl/0fK1P05OSsEGWEa1bskLPQGDtPPy3xMAD0N9IiAOfeu0L0L5yYEhscVGYxdlOLMPmZP3WaWy5nnawNzYejf3PDsJxFvS5LWMvnAh8Yn9ONwRPAvb8uVBtF9uXZjDm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=fRN3Gs98; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679ea3b13bso4214141cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 19:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1738812960; x=1739417760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GooHtYRgsDVSQFQM6OUskduKpA1W9w8+9aJsfn9Redw=;
        b=fRN3Gs985jSGhZWRpJohTk8PawsAEELOBtQ98TzaAdo9KemN1NThYl2JUPS153qYoG
         N+pO1gT4rDFyh+kKENu4PU2y6HMIBUoM9AJnXYK+3WVJNlmpzpLhifYrlWZaorP7PgEN
         RE5vKAzkVxu1t2hnU7nRsBylFgAw2qt4th1loWvBTVnaJuGa4N+O82VxP6tbP/2c0gDu
         1YN2WbgwMpRZld9YjNH0JbOPP1dT61yWybkg2AjmwzoHyg/6gsGoPOXVi6bouef5o1Ah
         hrReKGYwaq1lFK4nNH3dj64GwPtSwMM288lEQQ8x4syj98V17YzJUoKgEgkssK7laO80
         Sapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738812960; x=1739417760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GooHtYRgsDVSQFQM6OUskduKpA1W9w8+9aJsfn9Redw=;
        b=npLeiy5PUrxSMidkYDcpQNhWeLuQY1NhceqsAxBM4RBPEuIY7NtDpyZeYsHNeosrMe
         vXg85ht0f+vSt9H+tKztvB5dydV0oLTUrt7G3sdEVO2QeTXQukqdjB+nqERg1M4I+5gU
         U0biyVSLY3Srdzx8MXsNykdwETHZGWr8Fb6qMZXfX1PWM8F9vj2lrl15twnMCblO1+pc
         XP58I6SKSmow9H/luwLpuXJOycaRCMGrs99nfQqm/7MbYns5gRIGZHEk+OS7FNsTVH4j
         KQ7ANJvAMZ34KSN2Eu6zdzCn79/+xM7Rx3lYlmTd1Ps7G1wU59QVU43SPOzL0B06nVFr
         PrYw==
X-Gm-Message-State: AOJu0Yyrs/c4f9Gd4DiYAGvmXWJauQ1v7ynCtkrm/WHEqUH2VpUvlLe6
	9fBp2xKa7j/4okOhU13lPSfo3hFhZo2IOuak7dKVkmq+Enq6YM+WbjuAGlP4Q7YPqXntq3tTXEm
	7ChYQZ0Dhw13bx8eJocCciT6sZSHMP9BGljrnsiQpd4jp0AskWbQ=
X-Gm-Gg: ASbGnctF9Qt796Ob8ngizfWpklc8ESVtK/IhHdVtnCdZ8iFMJN5Zh1Ht8LBuog6C+xy
	tgsxszUv04HvJ5RpzqHuH/UXyo4IqD8cDHN4skuznHsnBiDbBLzU2jZeyxAwWM3ZpLMJzz4o=
X-Google-Smtp-Source: AGHT+IH+94xRtAvIVE/ZOK/eNXOxtwuRvLqKOUe1sKFLmQfQIZBmW06SH4ocFDsHqLhUsmhoLV54Ge1ePr59RU78nqA=
X-Received: by 2002:a05:6214:da4:b0:6e1:deb3:f27b with SMTP id
 6a1803df08f44-6e42fba2de3mr78099486d6.18.1738812959813; Wed, 05 Feb 2025
 19:35:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206015711.2627417-1-hawkinsw@obs.cr>
In-Reply-To: <20250206015711.2627417-1-hawkinsw@obs.cr>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 5 Feb 2025 22:35:46 -0500
X-Gm-Features: AWEUYZk5iSVcHiO_djxF_tq4g-ygxRuj7rcKmBCVy4Fu1w0Kp3eO9VifnM6YPQo
Message-ID: <CADx9qWhtSuYsGCsr8yrdS4OcyFMXrdwcdx0Q+691SFFzWYJB+w@mail.gmail.com>
Subject: Re: [PATCH net] icmp: MUST silently discard certain extended echo requests
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was attempting to minimize unnecessary CCs on the initial email but
Patchwork chided me for not including required people. I am doing that
with this follow-up message.

Sorry!
Will

On Wed, Feb 5, 2025 at 8:57=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> Per RFC 8335 Section 4,
> """
> When a node receives an ICMP Extended Echo Request message and any of
> the following conditions apply, the node MUST silently discard the
> incoming message:
>
> ...
> - The Source Address of the incoming message is not a unicast address.
> - The Destination Address of the incoming message is a multicast address.
> """
>
> Packets meeting the former criteria do not pass martian detection, but
> packets meeting the latter criteria must be explicitly dropped.
>
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>
> I hope that this small change is helpful. There is code that already
> prevents the kernel from transmitting packets that violate the latter
> criteria, but I read the RFC as saying that these rogue packets must
> be dropped before even being handled.
>
> I have a history of Kernel contribution but I do so infrequently. I
> have tried very hard to follow all the proper protocol. Forgive me
> if I messed up. Thank you for all the work that you do maintaining
> _the_ most important Kernel subsystem!
>
>  net/ipv4/icmp.c | 16 ++++++++++++++++
>  net/ipv6/icmp.c | 15 +++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 963a89ae9c26..081264b6e9eb 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -1241,6 +1241,22 @@ int icmp_rcv(struct sk_buff *skb)
>
>         /* Check for ICMP Extended Echo (PROBE) messages */
>         if (icmph->type =3D=3D ICMP_EXT_ECHO) {
> +               /*
> +                *      RFC 8335: 4 When a node receives [a message] and =
any of
> +                *        the following conditions apply, the node MUST s=
ilently
> +                *        discard the incoming message:
> +                *        ...
> +                *        - The Source Address of the incoming message is=
 not
> +                *          a unicast address.
> +                *        - The Destination Address of the incoming messa=
ge is a
> +                *          multicast address.
> +                *      (Former constraint is handled by martian detectio=
n.)
> +                */
> +               if (rt->rt_flags & RTCF_MULTICAST) {
> +                       reason =3D SKB_DROP_REASON_INVALID_PROTO;
> +                       goto error;
> +               }
> +
>                 /* We can't use icmp_pointers[].handler() because it is a=
n array of
>                  * size NR_ICMP_TYPES + 1 (19 elements) and PROBE has cod=
e 42.
>                  */
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 071b0bc1179d..76498a37e465 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -738,6 +738,21 @@ static enum skb_drop_reason icmpv6_echo_reply(struct=
 sk_buff *skb)
>             net->ipv6.sysctl.icmpv6_echo_ignore_multicast)
>                 return reason;
>
> +       /*
> +        *      RFC 8335: 4 When a node receives [a message] and any of
> +        *        the following conditions apply, the node MUST silently
> +        *        discard the incoming message:
> +        *        ...
> +        *        - The Source Address of the incoming message is not
> +        *          a unicast address.
> +        *        - The Destination Address of the incoming message is a
> +        *          multicast address.
> +        *      (Former constraint is handled by martian detection.)
> +        */
> +       if (icmph->icmp6_type =3D=3D ICMPV6_EXT_ECHO_REQUEST &&
> +           ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr))
> +               return reason;
> +
>         saddr =3D &ipv6_hdr(skb)->daddr;
>
>         acast =3D ipv6_anycast_destination(skb_dst(skb), saddr);
> --
> 2.47.1
>

