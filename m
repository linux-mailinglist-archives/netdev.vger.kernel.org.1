Return-Path: <netdev+bounces-229080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73936BD8120
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658A11922804
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDB530F54D;
	Tue, 14 Oct 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4jzwApa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200C30F555
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428905; cv=none; b=gHnpWtoOIFmI/VH2yL0mJXLvQ3bg2oVqy+WPIohmK0Bm3vSeqovLjFD/EITk7PhHwr8unWVyH1SaHwn3AHX2bvCCkUDHGpufa/a2z0wy6hk5RAzncA1snOFV5jjTNcrdee/mIMfMsuAz/QOD5g85ynohrUDsKsYUapP/eC/79Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428905; c=relaxed/simple;
	bh=h945n2tX0hRCi2/XGYNekabLz1wkUR0DboGrkFD/ceU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNv0Hu3ivh6nsyQErpQM62hq9NDdo5F73uyZpEZIY0c/QJWTFdRqDameMM6WUdsUumwcvxVeViq2MspCL0Qbx7PPQ3XCbvb6wvGphyofnSM5LkDlpfx5+3INcaFaMRAItK1XgBr1/A81UDP0HEUDcWkQeIPSxgIfApxhF4ruutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4jzwApa; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87a092251eeso78591986d6.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760428903; x=1761033703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej1XZzpzLLlS67kemjQbbuKwXS8XEJbjTOnSk8Bgc24=;
        b=J4jzwApa+/ZAnuy/brDMP+GoXrhF5j+teS4ptJ+Te66N0Cy05KB7YQji2REYjwbCUf
         aFfQLPWtqtPYu4b+rIrpgvY5QlZzNnx8G7Bn4wk51FMWVGDhNG3EicaIfWTdJC2BO8I6
         Y9TxBV12rglBECtPwFpsjoFi1KAre16lCXCErXriMGC/5dTyhxW9XcUZyi4ZkAbfcajD
         GCH52pAUYNHfhy0d1tL5FD7Uh9fS4x6HO5JHOoTTugu9yKwfsiBAvqGA7BzxyXwxOOPJ
         STZ0ZHXTZB78L62cldaSLfybhWgtRYdGuK0cIxXlFvdLq9CuW8ws9Jzot/2cOEC6E/DU
         F91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428903; x=1761033703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej1XZzpzLLlS67kemjQbbuKwXS8XEJbjTOnSk8Bgc24=;
        b=vsgMlXkoQM49C2TdJzSutZD0G8nxvXyg/6GGjv6ETRg7JPfmyd6R9i4djyjT+OIKBj
         rlnzacojDRv3ofpxvcFSPIuvxID1bI6Ngo73pP/6DrY48p6F6C9OrXRXRv8qjhPgTe10
         K67t6dBTElEMAaONK9lSwUTba8FSyj4BnS0flhgks/etXhAXNYwXWqcRvG6g7khRLdO6
         XPPuPiSD3COPG3+8b8n2+AoI9xpQRwTXMGf07YLLvaa5Jkrg7LD1Hb0L61oAsY0t8QD7
         6a77jJQSW7vHFjwzcvyWsOiP13T57j7tfbXU+7C0K870ujlAJ1FhGYjRsGCJypMxkuhX
         NaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlRW8y+I+Oqdb+5Egow2XTh3FZE5jiD81dzU2cyBuVjoV/dzrwhZ51gkzI+rCw9GyLkKPWg98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiEYR3vgigMvPLuwdzvZwAE44Nfri7piI1GizIibVrfqu6gSD
	CA0xVxv5QcDPCwhYRpCjXEsFjIgXGLo4ZOeRO+E2RFewOuJJAofgCFbdgQQaqBigDYeVSmBoiqB
	snJisVw6ZL+F/grYEhwGyOjsG29azgTTVPNMhpiQp
X-Gm-Gg: ASbGncsv8sfFbr7eJuVOFvMCN1UZETeGL3MGYMGaOePTj4dtkTMpjdVInw62xlzaWnb
	Av6ap396Rpc0cdIP/5S2Z0fKzTZKbb3ASF090C4ZDPY304TYdWy050E43cJwg+ouHH42bU+SEk9
	ivRbRY9+3cEFBWXEyxquJqVUhMPrSxvFNyjOIOzPCcDfFRkkanWBZLB/IFBuPO/PeinQ3wq5sPs
	J530kQDuF1Rh2LeCB03mwlYNmQPMli7NVKb0xgH5dE=
X-Google-Smtp-Source: AGHT+IFOjZr87Sa8nBIk4CLkMQDGzdar8eYeb+O4U2yekEyv5QMj/d1F4sOLs7kioeAcSSEabh2dlhk2bsPcq3M/5LY=
X-Received: by 2002:a05:622a:189e:b0:4cb:979:6467 with SMTP id
 d75a77b69052e-4e6eafdb9dfmr312053551cf.17.1760428902136; Tue, 14 Oct 2025
 01:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com> <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
In-Reply-To: <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:01:30 -0700
X-Gm-Features: AS18NWAEXUzAImILCQghr4WXzNGVp7hELV1LnCGwr0A4eG47GGkBiPpPrH8H3D4
Message-ID: <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:43=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Oct 14, 2025 at 12:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> >
> >
> > On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> > >> Michal reported and bisected an issue after recent adoption
> > >> of skb_attempt_defer_free() in UDP.
> > >>
> > >> We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6=
979f
> > >> ("tcp: drop secpath at the same time as we currently drop dst")
> > >
> > > I'm not convinced this is the same bug. The TCP one was a "leaked"
> > > reference (delayed put). This looks more like a double put/missing
> > > hold to me (we get to the destroy path without having done the proper
> > > delete, which would set XFRM_STATE_DEAD).
> > >
> > > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> > > x->tunnel as we delete x").
> >
> > I think Sabrina is right. If the skb carries a secpath,
> > UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will be
> > called by skb_consume_udp().
> >
> > skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> > skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache()),
> > the skb will go through again skb_release_head_state(), with a double f=
ree.
> >
> > I think something alike the following (completely untested) should work=
:
> > ---
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 95241093b7f0..4a308fd6aa6c 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> > sk_buff *skb, int len)
> >                 sk_peek_offset_bwd(sk, len);
> >
> >         if (!skb_shared(skb)) {
> > -               if (unlikely(udp_skb_has_head_state(skb)))
> > +               if (unlikely(udp_skb_has_head_state(skb))) {
> >                         skb_release_head_state(skb);
> > +                       skb->active_extensions =3D 0;

We probably also want to clear CONNTRACK state as well.

