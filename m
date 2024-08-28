Return-Path: <netdev+bounces-122943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D0F9633CC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EB61C21D84
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CC1A7074;
	Wed, 28 Aug 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRFNZgVh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F5139578
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880338; cv=none; b=SZeuw4q3cSXp77xWvfEQO2v0OFYT2ZYuJ1Qab41K/wppYQr3SGkgaFaOZ48uD8zlDL+VJjLNd03JyPl+Xfyw1/iJdboficZYx0nUiaUMBvHmY3RlYSjN5k3bUO2KIJC0EFcGwrTuL1341TbbP9HON23TT5fhrNdQ/TmxK32P+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880338; c=relaxed/simple;
	bh=3fc8SOSqtxO0E0t83WmTrjKXi93qXUImNFcgQN4jXkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk/5LkWTJBW4UqNasEpCjvLgM8s30oV65IVEMxfhMCTb+XUNR5pUdYSb1TgKNrV2xd0VnshYAWMJPaA7TGeojyzQCdp6wbxC6h4kWzY3hCZahqdeip3w7YLMebOKYOzZJEGxaZmxjJvj9/KCkU9VescEZ7Cf1J/BatDMIkNQWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRFNZgVh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86abbd68ffso229166b.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724880335; x=1725485135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbDM6dUrnGJUvfT6BG+hp6ChG+JOiYpKtW5xdzXrp64=;
        b=sRFNZgVhu/IDr7aiEN8ddul8eY8x8VMRB77WNOt7FgFNo+LX/qUMl1NuD84ZnOW0hB
         DdUJC1I+VHyuRRle9KMXbS/wsh5hCD1litHe3CpOz7lB+NKM0dnj2w0GlVQJFsSLrSYG
         Ei+tID8AZmgJjgpT4fFQviGGuAfi1MjZfMAeCZ6xZfReu9WiTwwBUDgwIZ1uqsNu2B2W
         O/Um/JEUm3zYMh09EiC5WxjLitWpR9JNo0E7U30IRmGf5kSrGGNruPgwp5bpeDpJi5+e
         fp/ilnprb9k+Z1+2x6hTKHaMwZvwSDR4B6WWpOawaNLgnUeKb5kP3rqT7AIl4Cd33NWa
         Z+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880335; x=1725485135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbDM6dUrnGJUvfT6BG+hp6ChG+JOiYpKtW5xdzXrp64=;
        b=EwuIhMWYHHFyx6DNNZsVUw4fidzibLcVAJNGSuvoq0Ji3L+a5KBBFlPGrCQonCvmTQ
         G2YhkQv6gkajiZY0cyTYTODRfjtdI744uxU2hUqDDypPxz0WGsfh0G4M0LM+zh0pjtkB
         XxrFs2omn/DpUwBpr/qDn8hgFQlJ8TzicMjRQZNCi4ql/qNUMmPncpvMQB8L/9lhR29C
         i9owjLeIOJq0c6WzrucvNnZNbEzX2Trw1fbFb5A+BD/AX3u2olOtfYR4C1gd1KnZDves
         KPq6+3KQmXOU7Wx/6PpnDTI5V6rkOCXjOWh2YaEhj+UzTQP9rkd0SpIwf0AKI/7F7dy5
         Z+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRlLbtd0uyHYPty5WD2r0HApyIRsffHDB5kzAZ4orSXYhtTHl7NgYwYyUsLcyobIZeq3KhLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gI3KiZ2e3S2Cc9kRHFf5g8op4JMnKzqbXv85UfgcjHNq2tI5
	XQP9k25ZnpaIfJxAh7St2PBoxg+3KRunSyKPEanZ1K1cEDTkUZ5t8luWf+A98uagnjTMuRljLqx
	5ZutM/C4aAMJM1PaR3V4MDRiawfh0TNEx96HM
X-Google-Smtp-Source: AGHT+IGI/ICFLsRswIsvzmbc2cbrhvHph/U2lKHR1+iz6r81PshkaJSOsGee1KCPgfGfpeAbpXhj4qygAr5FHypKsnE=
X-Received: by 2002:a17:906:730d:b0:a6e:f869:d718 with SMTP id
 a640c23a62f3a-a89825f98e8mr50961266b.21.1724880334645; Wed, 28 Aug 2024
 14:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240828112619.GA8373@unreal>
In-Reply-To: <20240828112619.GA8373@unreal>
From: Feng Wang <wangfe@google.com>
Date: Wed, 28 Aug 2024 14:25:22 -0700
Message-ID: <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Thank you for your insightful questions and comments.

Just like in crypto offload mode, now pass SA (Security Association)
information to the driver in packet offload mode. This helps the
driver quickly identify the packet's source and destination, rather
than having to parse the packet itself. The xfrm interface ID is
especially useful here. As you can see in the kernel code
(https://elixir.bootlin.com/linux/v6.10/source/net/xfrm/xfrm_policy.c#L1993=
),
it's used to differentiate between various policies in complex network
setups.

During my testing of packet offload mode without the patch, I observed
that the sec_path was NULL. Consequently, xo was also NULL when
validate_xmit_xfrm was called, leading to an immediate return at line
125 (https://elixir.bootlin.com/linux/v6.10/source/net/xfrm/xfrm_device.c#L=
125).

Regarding the potential xfrm_state leak, upon further investigation,
it may not be the case. It seems that both secpath_reset and kfree_skb
invoke the xfrm_state_put function, which should be responsible for
releasing the state. The call flow appears to be as follows: kfree_skb
-> skb_release_all -> skb_release_head_state -> skb_ext_put ->
skb_ext_put_sp -> xfrm_state_put.

Please let me know if you have any further questions or concerns. I
appreciate your valuable feedback!

Feng

On Wed, Aug 28, 2024 at 4:26=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Aug 28, 2024 at 07:32:47AM +0200, Steffen Klassert wrote:
> > On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> > > From: wangfe <wangfe@google.com>
> > >
> > > In packet offload mode, append Security Association (SA) information
> > > to each packet, replicating the crypto offload implementation.
> > > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > > from the validate_xmit_xfrm function, thus aligning with the existing
> > > code path for packet offload mode.
> > >
> > > This SA info helps HW offload match packets to their correct security
> > > policies. The XFRM interface ID is included, which is crucial in setu=
ps
> > > with multiple XFRM interfaces where source/destination addresses alon=
e
> > > can't pinpoint the right policy.
> > >
> > > Signed-off-by: wangfe <wangfe@google.com>
> >
> > Applied to ipsec-next, thanks Feng!
>
> Stephen, can you please explain why do you think that this is correct
> thing to do?
>
> There are no in-tree any drivers which is using this information, and it
> is unclear to me how state is released and it has controversial code
> around validity of xfrm_offload() too.
>
> For example:
> +               sp->olen++;
> +               sp->xvec[sp->len++] =3D x;
> +               xfrm_state_hold(x);
> +
> +               xo =3D xfrm_offload(skb);
> +               if (!xo) { <--- previous code handled this case perfectly=
 in validate_xmit_xfrm
> +                       secpath_reset(skb);
> +                       XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +                       kfree_skb(skb);
> +                       return -EINVAL; <--- xfrm state leak
> +               }
>
>
> Can you please revert/drop this patch for now?
>
> Thanks

