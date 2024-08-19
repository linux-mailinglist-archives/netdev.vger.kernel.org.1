Return-Path: <netdev+bounces-119925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F895784A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0FF282336
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424201DD3BC;
	Mon, 19 Aug 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LubDwco5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E73C482;
	Mon, 19 Aug 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108387; cv=none; b=hCOK0XwPr88Wd4tcj6NU2me3Or+Jkwjl4MCrUP1zbzlRyI6ziSysJ8DiFjLYyNPagfWtzHGeHWhwo4k8S4wCOzJDTrbm5R1DY7y5vJ2ev+JMAUyLpv1Ra+k8UwHWEd1WA8ut4ex6wDIztiLO9bKlN/290L3LyRXfUmdYaLyGTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108387; c=relaxed/simple;
	bh=eWWL8a5aUhphKSl55AdJyMlyCybyuLzO4j2y4lBBjd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7Cp/0wDtAXGsaQ0jxXRgFZ/XNLJrLvFZ65yCRfkMdG4vbsJDtMRhHHTIqA6Fr9XyzlCw5tGuEim9NMK6RhLQNgo26pbN6a1pXsXXv7vNdY0lFl8rcCdGWz3q6Z52cdFYihpqL+gKxZ76y46IsNNlkKczQa6C/2jwSyVnJMYf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LubDwco5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12440C32782;
	Mon, 19 Aug 2024 22:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108386;
	bh=eWWL8a5aUhphKSl55AdJyMlyCybyuLzO4j2y4lBBjd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LubDwco5Ktq/x+WKdAVqvd5sV1DNHVrKUx2zrUPmwLa7pM8mKCvJIfM/03BxXWvk/
	 uTZodsd5nxwSe+xcgloDaZ5YU+8CN5EhKYcY/8flUZz/AJ3YZw+z0DntgkKwsbQVmU
	 JYfn56XeEWabxcWow6EblYsqWmHFs0v7yvEScB6x1s7VpknlDU2pxVs3vFxxhuxqGT
	 Lez3qkjppeuzAUezEysaQ8kizxju2D3hNVr8n78qZFY+rm+dAANoBvTtbQwF9nj9r+
	 laNjrwFQPZ+r3c6hMGqghcVL1lIOUfe43zoqLQu3VPi2WmUJ8ok8SykF1AFEHWx1ep
	 +s/bIaeGp6UWg==
Date: Mon, 19 Aug 2024 15:59:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, dongml2@chinatelecom.cn, idosch@nvidia.com,
 amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to
 vxlan_rcv()
Message-ID: <20240819155945.19871372@kernel.org>
In-Reply-To: <CADxym3ZEvUYwfvh2O5M+aYmLSMe_eZ8n=X_qBj8DiN8hh2OkaQ@mail.gmail.com>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
	<20240815124302.982711-7-dongml2@chinatelecom.cn>
	<20240816192243.050d0b1f@kernel.org>
	<CADxym3ZEvUYwfvh2O5M+aYmLSMe_eZ8n=X_qBj8DiN8hh2OkaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Aug 2024 19:33:23 +0800 Menglong Dong wrote:
> On Sat, Aug 17, 2024 at 10:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Thu, 15 Aug 2024 20:42:58 +0800 Menglong Dong wrote: =20
> > >  #define VXLAN_DROP_REASONS(R)                        \
> > > +     R(VXLAN_DROP_FLAGS)                     \
> > > +     R(VXLAN_DROP_VNI)                       \
> > > +     R(VXLAN_DROP_MAC)                       \ =20
> >
> > Drop reasons should be documented. =20
>=20
> Yeah, I wrote the code here just like what we did in
> net/openvswitch/drop.h, which makes the definition of
> enum ovs_drop_reason a call of VXLAN_DROP_REASONS().
>=20
> I think that we can define the enum ovs_drop_reason just like
> what we do in include/net/dropreason-core.h, which can make
> it easier to document the reasons.
>=20
> > I don't think name of a header field is a great fit for a reason.
> > =20
>=20
> Enn...Do you mean the "VXLAN_DROP_" prefix?

No, I mean the thing after VXLAN_DROP_, it's FLAGS, VNI, MAC,
those are names of header fields.

> > > @@ -1815,8 +1831,9 @@ static int vxlan_rcv(struct sock *sk, struct sk=
_buff *skb)
> > >       return 0;
> > >
> > >  drop:
> > > +     SKB_DR_RESET(reason); =20
> >
> > the name of this macro is very confusing, I don't think it should exist
> > in the first place. nothing should goto drop without initialing reason
> > =20
>=20
> It's for the case that we call a function which returns drop reasons.
> For example, the reason now is assigned from:
>=20
>   reason =3D pskb_may_pull_reason(skb, VXLAN_HLEN);
>   if (reason) goto drop;
>=20
>   xxxxxx
>   if (xx) goto drop;
>=20
> The reason now is SKB_NOT_DROPPED_YET when we "goto drop",
> as we don't set a drop reason here, which is unnecessary in some cases.
> And, we can't set the drop reason for every "drop" code path, can we?

Why? It's like saying "we can't set return code before jumping to
an error label". In my mind drop reasons and function return codes
are very similar. So IDK why we need all the SK_DR_ macros when
we are just fine without them for function return codes.

