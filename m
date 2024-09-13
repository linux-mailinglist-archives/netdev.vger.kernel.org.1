Return-Path: <netdev+bounces-128059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57268977BFD
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C9E1F22AC7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBB1D67AB;
	Fri, 13 Sep 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1zDysS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A317BED3;
	Fri, 13 Sep 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218821; cv=none; b=AcVZqFV73T5LSkOtoSfe9iV/z5rLexBw+3lYRLMnvCm83sXsKs2USyce/omB8qKqfqqfqZQdAPQyDDrHWMAWISJkQyfT9lC6ozyA+3+usE7CGdAUfVxfed0q1CI2p3MNsb+NwJ+sI/kkz6VZrRAfpPZXqvgRiiyDmTD0IrRF+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218821; c=relaxed/simple;
	bh=JI3m9LYyWSyk0jfVWwO1YfrWWHzbrvI0o8O2cO+Sucw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6L2lsuTirEcjI+2lMZoS+0BRezhS15Kp3WBhWiWcygaUUecM+AMXeZBJvoxeIZY4nl2B4YEb06as0Lg3b+E145vMknkSEbKC3qbyz6/jcMQXrBYhOkNneP+TN4CFL3r0G3waDTvIn0nIIps0eTLCQu6u85GZ5wCqM57lApFpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1zDysS7; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so652778276.3;
        Fri, 13 Sep 2024 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726218819; x=1726823619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyXxFHDnWBDDJlEOl6Xh69Gj8jXFozZBOH+5BBxE9Fk=;
        b=g1zDysS7Rm0RmkIVkAnWOrRu2dhw0fFbaerqiJCPaBhHM2yFXSu7fd6ALcyKXofVqh
         gfUQm+1m1WypYNCyUsemsp0fIHgpZoKBTFkasScHWhTva6D+8zgR0wM9lw+5+V16mR7E
         kGQbgBGAEOrreGn4hdUDk4BWEFUn3xWNT4ed0W3dEK0qfclHX8xYc8aZYiZlOSFfUuNe
         S+OJYusiVqVMaP1u2+PDmVNk/EvW2mqrZfcc2xfZxdJMoK6Hw0NLt7gA1fz+3qBoiSmR
         IRmGYno75JXPJdM3ny/vifsUp0sTJFUKwvkgTTglHAhQmq/zMmxxOaZGMgBzw3Y8w39L
         Hi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218819; x=1726823619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyXxFHDnWBDDJlEOl6Xh69Gj8jXFozZBOH+5BBxE9Fk=;
        b=XjyU5Dd0LUimviz/bLptscp2orymxV+6z4fcAcE71QgLuaOwVLEsuNEYAMyuuw0KUV
         LkyXZS+M+KA2fDX6ASPfkYaiUVKPuGzQMcDifBBDIzTdhw0VH9y3JXbQgQfkL3epoxus
         JxHVEbihvK1uNzywEjyeSS53JVWIwofVuaY2fvyMLvxomZ5wt6aUwn5Joco2hL9Y0AoT
         lkYN8/mmnEhE6KFaHmaKIigPdnfIFhDOpqDOoFJSrcdBeS2lDnXmletAHXj/v1Y+0AlF
         RhTIwUZwMBfCuCzO8jXVVTCqF2qx6QUjAdvCZTKTkn+jbGEcwil1rbkzyQK9QvlDSVi0
         eKDA==
X-Forwarded-Encrypted: i=1; AJvYcCUGGQBbxc/S5QLLSMOMLjEwzV04ivYFLEEiLaRv+jG4IfQBLBKDf21vzQUwECdOCsf6dDY2PDe0sZGJqyk=@vger.kernel.org, AJvYcCVEyMl9GS2iOaQCpefs4ah8kBrldRAmMuLntPI4b8gGdPJErVgNNPM5Cbch2PHYq+hgRNjtPk7J@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQU8Zl6GbNZUHuf6VcKFIrbZOy4m3LRudQ06xQ9mk2UPgGAec
	iT7cUzlHmRm8HQVQAmkXonk8Yw+YvTLW2kUm2/dS110tL4n/gRRUH9e15TkUX5YlgHu+ImJD8lk
	edrOViKobB74xFd97j8YUwHIT8eY=
X-Google-Smtp-Source: AGHT+IGTSx+nc+ZmzlzXLNrgq3ecoPsZXndDrY5v49iTDxEfSYxup4DdcsT7ch+4ToenP+w5LpUJqm5pZ41QSctqz8A=
X-Received: by 2002:a05:6902:993:b0:e11:6eb3:833f with SMTP id
 3f1490d57ef6-e1db00a735bmr1431100276.5.1726218818951; Fri, 13 Sep 2024
 02:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-7-dongml2@chinatelecom.cn> <ZuFP9EAu4MxlY7k0@shredder.lan>
 <CADxym3ZUx7v38YU6DpAxLU_PSOqHTpvz3qyvE4B3UhSHR2K67w@mail.gmail.com>
In-Reply-To: <CADxym3ZUx7v38YU6DpAxLU_PSOqHTpvz3qyvE4B3UhSHR2K67w@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 13 Sep 2024 17:13:41 +0800
Message-ID: <CADxym3ZriQCvHcJjCniJHxXFRo_VnVXg-dheym9UYSM-S=euBg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:30=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> On Wed, Sep 11, 2024 at 4:08=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> =
wrote:
> >
> > On Mon, Sep 09, 2024 at 03:16:46PM +0800, Menglong Dong wrote:
> > > @@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
> > >
> > >       /* Ignore packets from invalid src-address */
> > >       if (!is_valid_ether_addr(src_mac))
> > > -             return true;
> > > +             return SKB_DROP_REASON_VXLAN_INVALID_SMAC;
> >
> > [...]
> >
> > > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-c=
ore.h
> > > index 98259d2b3e92..1b9ec4a49c38 100644
> > > --- a/include/net/dropreason-core.h
> > > +++ b/include/net/dropreason-core.h
> > > @@ -94,6 +94,8 @@
> > >       FN(TC_RECLASSIFY_LOOP)          \
> > >       FN(VXLAN_INVALID_HDR)           \
> > >       FN(VXLAN_VNI_NOT_FOUND)         \
> > > +     FN(VXLAN_INVALID_SMAC)          \
> >
> > Since this is now part of the core reasons, why not name it
> > "INVALID_SMAC" so that it could be reused outside of the VXLAN driver?
> > For example, the bridge driver has the exact same check in its receive
> > path (see br_handle_frame()).
> >
>
> Yeah, I checked the br_handle_frame() and it indeed does
> the same check.
>
> I'll rename it to INVALID_SMAC for general usage.
>

Hello, does anyone have more comments on this series before I
send the next version?

Thanks!
Menglong Dong
> > > +     FN(VXLAN_ENTRY_EXISTS)          \
> > >       FN(IP_TUNNEL_ECN)               \
> > >       FNe(MAX)

