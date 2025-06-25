Return-Path: <netdev+bounces-201017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE076AE7DF0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E851622BF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04129AB02;
	Wed, 25 Jun 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlLygutP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26B29B201
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844616; cv=none; b=eftxkl6zqxDWw+Z0ggzyZj6WlD+Cf58EK8sGopFwj4IX4Lfh+G4BwItFIFWuIteO/bidic6JpF9c/VPm7YtBBlK917h3zHVKTeDcxRAfdsykZLnUlWu9K6Z8s74WGlHSZ96OnnL0V+m4J4sxmbrJiD4xx8f95VI5nryqpk5YO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844616; c=relaxed/simple;
	bh=2j45+rPtRz1ewRaL0XUO5kzZtMolvDfs0wZcojUZxeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4x9c12QlLBsUlBPJVAItVlpzRYN/BwPc00ZTseW/gYFybY/YF6YATyPIVxO1H/B2BOIUiJPMmc8D1APdm8mJKjdOPvMktfy+1zGkKQADz0ZQfAidL7sxlGskdsT5tSyuiyRnsnooxXJAFAw8JOCY+aQUK+CzgXVbVoG4CsmEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlLygutP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4312b4849so15436681cf.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750844613; x=1751449413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVQI9Zy0+HJVx5+KHBhYNPrK325t8eWnTOx9TGA6634=;
        b=hlLygutP6GQI8+oxNKX8+5M8a3okXNEBRKYPAQye4T45cpI0QUQw0/3R5bhhtmTROU
         dkMO3RQIWZV+icGLCSe9kZDooRpuLLew67bRr8Sr4rIQePJaGQGYbVAQUAmIA27Semlv
         dsvEI01vHdqKvkrKJxxalo7K75+Ez8Y2XplV7e+0TYWjuE2bIIlyy55oZut40EOVatS7
         dV8dLrd53QmYhUD8q4z3b3D992PpNAtO1hXH/fAI/fUJlEAlOWp0HTf9LaLLsSlqDYzq
         xqtDSTAhCF3pwgaRGtsCFuJbCgE1UgAQ/RPLgzdOuMK8d8Lvoiz+ukLr7TGsmNRBmeM+
         6Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750844613; x=1751449413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVQI9Zy0+HJVx5+KHBhYNPrK325t8eWnTOx9TGA6634=;
        b=witMrgVyurP8fTWphAapOM+ekEaFAd9iGG6yKGnGrFgQuHBEXlnSL6ifXPuiSZsDQl
         vuqIhYIHDvJuRd/kJBcU25ULJXaTYHjS3NO1J3lNxxVkYRC8gDCjyRCLuxm25AUVPWfR
         QETUosLJD4lHIwGg2y/PmrHwfztloEn/0ZalJVMhfR31x9nOEpppO853t56DzyqUDyjA
         /edvK90UcMHKYuaAz909GmbekBYn081FN0804qyEkYvm+cFh4c/tJmQNSgUHcBzW5tqr
         sIz3P5vMxqCQxNl70kQfvjX63uIEq6MoR2m8FZIFcDNoAMXsJMlr3cJ3fPd6diBNbvTV
         /S+A==
X-Forwarded-Encrypted: i=1; AJvYcCXwir+iz9mcdaKjNLqa1iZBtsiqBpswYQDYrJP0AyJZaT4J5a2K6fb4oPP3/lsZccyNPgCvJ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztS9/Fjtj+gk9YTNo6+s5W7PsrR/GAmkVBav+xtXBQnjYL+nf
	yM5xPe+XN7VRlfZHwu+NVxGlNKKO9VOc18gTdMTcsMWkpBzZuoonj/7refWfcQynt4Q9n55VjLT
	8aRoLiXloDvImedrskFnhai3aYGVBCB9qNM4u1kaC
X-Gm-Gg: ASbGnctD0O4KfCXGzIENNBPRSfT+EADGvz1bniOPgxrUAr1pZTSxCT2GsaVH35v+exv
	0IFOyFAP2b/H85wFc4or08Q66MM77J8ldjU29pNSZYHqJEHcFdQoBSMy+ay18IQcKR4VT31HKc7
	AItOZdEZY9Hfx9mzaS6pQvFWvExkdKf4FvFmNMu5Uvjw==
X-Google-Smtp-Source: AGHT+IElLwh+gcT09UiRPwLTWzsRbjjO0qD+yIlUzYBgIirHbad5dUFE2pRaeiS7UqszRvB+HUCGTuU0YnAo0nbEUXM=
X-Received: by 2002:a05:622a:1181:b0:4a6:f492:674f with SMTP id
 d75a77b69052e-4a7c0800b97mr39614451cf.41.1750844613099; Wed, 25 Jun 2025
 02:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625090035.261653-1-atenart@kernel.org>
In-Reply-To: <20250625090035.261653-1-atenart@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 02:43:22 -0700
X-Gm-Features: AX0GCFuXfk7cuBtFG3f47N-ma30Posai5j3VkM-KmB3CuVxBhyHlYRYIyXGNiMQ
Message-ID: <CANn89iK07a=NFRddVOmO1mMCFeRx3o2Lwjqakq-MCfXF=M_BhA@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv4: fix stat increase when udp early demux
 drops the packet
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 2:00=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> udp_v4_early_demux now returns drop reasons as it either returns 0 or
> ip_mc_validate_source, which returns itself a drop reason. However its
> use was not converted in ip_rcv_finish_core and the drop reason is
> ignored, leading to potentially skipping increasing LINUX_MIB_IPRPFILTER
> if the drop reason is SKB_DROP_REASON_IP_RPFILTER.
>
> This is a fix and we're not converting udp_v4_early_demux to explicitly
> return a drop reason to ease backports; this can be done as a follow-up.
>
> Fixes: d46f827016d8 ("net: ip: make ip_mc_validate_source() return drop r=
eason")
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/ipv4/ip_input.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 30a5e9460d00..4bb15bb59993 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -319,8 +319,8 @@ static int ip_rcv_finish_core(struct net *net,
>                               const struct sk_buff *hint)
>  {
>         const struct iphdr *iph =3D ip_hdr(skb);
> -       int err, drop_reason;
>         struct rtable *rt;
> +       int drop_reason;
>
>         if (ip_can_use_hint(skb, iph, hint)) {
>                 drop_reason =3D ip_route_use_hint(skb, iph->daddr, iph->s=
addr,
> @@ -345,8 +345,8 @@ static int ip_rcv_finish_core(struct net *net,
>                         break;
>                 case IPPROTO_UDP:
>                         if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) =
{
> -                               err =3D udp_v4_early_demux(skb);
> -                               if (unlikely(err))
> +                               drop_reason =3D udp_v4_early_demux(skb);
> +                               if (unlikely(drop_reason))
>                                         goto drop_error;


This would leave @drop_reason =3D=3D SKB_NOT_DROPPED_YET here, furtur
"goto drop;" would be confused.

if (iph->ihl > 5 && ip_rcv_options(skb, dev))
     goto drop;    // Oops

The following would be easier to review ?

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 30a5e9460d006de306b5bac49c92f9b9bf21f2f5..d105df76dd81696d98b3df58193=
4c27af2e0494e
100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -346,8 +346,10 @@ static int ip_rcv_finish_core(struct net *net,
                case IPPROTO_UDP:
                        if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) {
                                err =3D udp_v4_early_demux(skb);
-                               if (unlikely(err))
+                               if (unlikely(err)) {
+                                       drop_reason =3D err; /* temporary f=
ix. */
                                        goto drop_error;
+                               }

                                /* must reload iph, skb->head might
have changed */
                                iph =3D ip_hdr(skb);

