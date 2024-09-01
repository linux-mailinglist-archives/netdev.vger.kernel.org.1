Return-Path: <netdev+bounces-124042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F478967674
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567CD282495
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76516EB4B;
	Sun,  1 Sep 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APY3HxE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2014A4F1;
	Sun,  1 Sep 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194179; cv=none; b=EZKBmFOunicWNW/s05aF3+KtZcpY4/k9YHG1xGEPVWyKemOxg+w9Q86pJK10mTFexWM+cpFkeWugKveR3gJpolZVpkck579aRe3O/Nusf0M2TQwehwMiKe9w3DtTdqdwt4VF+jQJz0dg9s75oZJTCDqoqb5cYNoRzPdz1LEY3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194179; c=relaxed/simple;
	bh=HOG1AKA66snpkUc2yReDJH4AlZkrYPqjb9lUqIp5w5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3k/VCpzVaqGu/X6fHEuXtSfl1OAFztDXfv+rBQAnQ5bDgIASagoIQxeoyBquTYmDtko385a/kKE4+LtAuFrjXSZ/S4AuZ3wlWON0FUF/qVAm1nSvDw1a1mloz8YEchy0WIKL9621txbwrrNq3AUNxfEVj6BeFTByoV3SYIVJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APY3HxE+; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso859399276.1;
        Sun, 01 Sep 2024 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725194177; x=1725798977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaXHGSbPWmQL2tyYute7dYQIRE3ISeHNHqwtraGs6XY=;
        b=APY3HxE+Gtk4TKbEudtPOKCNMiQvX8ScRvtiy7VJvo9BsOTjCrZk1LmAEXTJjXS9zD
         BidhnIWyX+0qsjn/HEWwrHAk1qicnuuK0k4zu1t3Fr4tnRKOKeU5oq6V5RIjV7YFvE/Z
         MmjjTkfl8ly5w26ub3KaNKItuwe7FiaI59PGoLs+zcSR7h8TOn4rmQ+hcdQtoGY3Ooxz
         lxS1qGoVKukU0v5n11uc4OpcYtCJNHtAZRJchYDVtXv+NKQbxusg2uOVOYtAEfPU/FFV
         3nSpU8MA7MM2Cxwg9ZUuwE1t/McCAzPwn86IoXZsE4KvgakpTq0i0lXBAIJ/vWapPkRg
         b2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194177; x=1725798977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaXHGSbPWmQL2tyYute7dYQIRE3ISeHNHqwtraGs6XY=;
        b=FMOVcCFoDKWeutdATk9Ne14554CQ8culO533DhH80WVnvLCrHNM8GmkV871aL/ZNkA
         GgBlpggePxLkE7/LjIrZTpDbRU+Sjo5cdbvny80gg69/Ehs9FJ/4/bNx29AYEEJSvS6S
         9HwMQ8GgFndjKMOPCUf8KeDslxMJKB4l+sTyrSSlvbIX4ZpvQYCVLDhIKjpGQQpadj96
         werMGSydfyeSl8MhPHvuokkXUc6HO6AzD1VDtOQRX7svSveSJnZRfYaTEO+5ZSgaB+2d
         FFj2OPFTZakRZiLcj6O1NdxZzpmjfZoMqIc+X12GbNVcLhdihxzLrhavl47WC682ikHQ
         fjtw==
X-Forwarded-Encrypted: i=1; AJvYcCV4VlYnGaLn+30ghIzm1T+vFsXDcT2W1dF933gzoVon0h95B7u6lcZjmqGLbnXWkvtFhGPpP6HQatRD0Vs=@vger.kernel.org, AJvYcCXG9+V+xrdM3QLHywCVbTRMbR9VteAdCy60Da9w0M2lVWftJ+ockYos6+Q1ROqpI3lSAS61L6BM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2DeIXBajP8UZNC0Bkq3qOCRSY/R3m0zHFEPry/hLp/nCgzIo
	TJ/Duj9/iFZhLRcGunmdTokQ4GiX/WMGGv6itC50cNFTjIA4G4Ob3qdjgbtQK8bWXlXO0AE9kG5
	fnbUiDJtIB/aDo/LznkpmZJihdGk=
X-Google-Smtp-Source: AGHT+IFyROopcm9RVA9/q/rMRHNc0JtJxNnT5qzYxa63tmh3DGexVb685meabAPwOZ5jJkpqGow3TcFMVFaz0vReF64=
X-Received: by 2002:a05:6902:11c2:b0:e0b:2c11:bc4 with SMTP id
 3f1490d57ef6-e1a79fe3898mr8942260276.6.1725194176442; Sun, 01 Sep 2024
 05:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-5-dongml2@chinatelecom.cn> <9410cc52-129c-4bc3-a0f3-9472364f158c@intel.com>
In-Reply-To: <9410cc52-129c-4bc3-a0f3-9472364f158c@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 20:36:17 +0800
Message-ID: <CADxym3Yis_0oxunLGsiYhoTNG-9RATq7Ggj9ZfZ5WR9C=hi2_g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net: tunnel: add skb_vlan_inet_prepare_reason()
 helper
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:47=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Fri, 30 Aug 2024 09:59:53 +0800
>
> > Introduce the function skb_vlan_inet_prepare_reason() and make
> > skb_vlan_inet_prepare an inline call to it. The drop reasons of it just
> > come from pskb_may_pull_reason.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/net/ip_tunnels.h | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> > index 7fc2f7bf837a..90f8d1510a76 100644
> > --- a/include/net/ip_tunnels.h
> > +++ b/include/net/ip_tunnels.h
> > @@ -465,13 +465,14 @@ static inline bool pskb_inet_may_pull(struct sk_b=
uff *skb)
> >       return pskb_inet_may_pull_reason(skb) =3D=3D SKB_NOT_DROPPED_YET;
> >  }
> >
> > -/* Variant of pskb_inet_may_pull().
> > +/* Variant of pskb_inet_may_pull_reason().
> >   */
> > -static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> > -                                      bool inner_proto_inherit)
> > +static inline enum skb_drop_reason
> > +skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inh=
erit)
> >  {
> >       int nhlen =3D 0, maclen =3D inner_proto_inherit ? 0 : ETH_HLEN;
> >       __be16 type =3D skb->protocol;
> > +     enum skb_drop_reason reason;
> >
> >       /* Essentially this is skb_protocol(skb, true)
> >        * And we get MAC len.
> > @@ -492,11 +493,19 @@ static inline bool skb_vlan_inet_prepare(struct s=
k_buff *skb,
> >       /* For ETH_P_IPV6/ETH_P_IP we make sure to pull
> >        * a base network header in skb->head.
> >        */
> > -     if (!pskb_may_pull(skb, maclen + nhlen))
> > -             return false;
> > +     reason =3D pskb_may_pull_reason(skb, maclen + nhlen);
> > +     if (reason)
> > +             return reason;
> >
> >       skb_set_network_header(skb, maclen);
> > -     return true;
> > +     return SKB_NOT_DROPPED_YET;
>
> An empty newline before the return as we usually do?
>
> > +}
> > +
> > +static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> > +                                      bool inner_proto_inherit)
> > +{
> > +     return skb_vlan_inet_prepare_reason(skb, inner_proto_inherit) =3D=
=3D
> > +             SKB_NOT_DROPPED_YET;
>
> This line must be aligned to skb_vlan_blah, IOW you need 7 spaces, not 1
> tab here.
>

Okay! I'll follow your advice of the format in this series.

Thanks!
Menglong Dong

> >  }
> >
> >  static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
>
> Thanks,
> Olek

