Return-Path: <netdev+bounces-135184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4143199CA79
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F72283DA0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CF1A7275;
	Mon, 14 Oct 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gThvu3nu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5B15A87C;
	Mon, 14 Oct 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909869; cv=none; b=A8fSfR5lDp6R7BOOxCGJHTJHb0eucGJ7nBMldo5duMYI4ldhVhcYiDEDJ1O/34qjlt/g4SQxi+c4DtAyn60xedE5PD8XuOWWVeQ3/XyDDsgxDVXH/Ik4MxPwtH6zoydC+2NC/eXfX0QcjoRLb6pKFP7lhi4e0tzeQAjE5mm5jCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909869; c=relaxed/simple;
	bh=OTNra8UpT1H9QV0NcWfsZ6RoWqvXPbMa/Wpns9ASq7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEymP/GEXabaVeP6guYLI2yTMBER6j4+pWLN0v2xnhhQIooa8BsJkcYAXyCX6Te9b/H/P2Yu3mVsOdZLrHwZtF+UgPtZmt2Kl2zcXllszOqywt+VjeAu3pPZnOLkZzBiJK7/pQ0+UAsKWUH4lmvSLVnQsnYs2zglwk+3EYLuFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gThvu3nu; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e214c3d045so30812447b3.0;
        Mon, 14 Oct 2024 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728909867; x=1729514667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKaKf6K0lMfEPAUX3tm6OhH+0miEV1nfLfpCNX5G+vI=;
        b=gThvu3nuAevhNMcfc1xv2IeqSgQ6axxZZZoQotwH7PZx3Qq8CNhnQt9dogZtMXPQT9
         PVM7swBwqR244ssK0euahsRV7e0ufDKiSaMqxwwuR9wQMgBNfUtNpOPWHwMFrtVAFK3j
         AMX2vNitB9Lx6WZQqYTuBO7NA2EPEAyNzzbeih0z3npLRviqqGd4ZAS9i43xt7VhMbSS
         a/LL9m+yMbqi9IAKgwsqtibWSH1u2scmWhcjRJiBEEws8j82xT7UU66JTnjMtdkICyy2
         Q1fRimWjN+PmUQPxaR+jDdQ48lt62ZQF/Eg4iuV4HUtK+6vgKbv0XDf5E90lFcwJGJFJ
         OfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909867; x=1729514667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKaKf6K0lMfEPAUX3tm6OhH+0miEV1nfLfpCNX5G+vI=;
        b=sjiUgKyEzktugZzEG5pDMH4cf3Yj2ry6SJX8zWjq7hkHjdd+YAhm4p6gDdRDb/m0XQ
         Q/9g904lyw24WiG8EE2etUC4wGl735L+K0TN8tKE89Ci0ftEGFxrSeG8yEXEAxDcYSVx
         O3k/gaSv+RYDpbrcbIryncnEiv4rEMFurbVQu2CMsd/JxRnqNW0sOVp/oo/lIblDUZ0O
         7RwvANMFz1Va8gf2dT3PBJYq9JdYx4gDVtQu8SuNUmWCs6P42uAIocmIIS0+KJtfQpnQ
         HZVEAhylxDN3sQ8o1kAvneYor2VtHy5Apon07sjSLJ6GHynsayD4envKcCM/5Ofgou7T
         SlOA==
X-Forwarded-Encrypted: i=1; AJvYcCU4MjdNjrlU1F5Lo5Mo5YtjWqibjoyYb66grpwauVAbbCkfaIh0OFDZtSwxONqxxYePOtvGC8RYm2h6WGI=@vger.kernel.org, AJvYcCULzbuRPgVesFfIWiESAsbmwsyyL6MQcjl0jpG2jQ/1r1N5n5Z5n+TeOwh5GDDo6WvspUQhN9bm@vger.kernel.org
X-Gm-Message-State: AOJu0YzH180tdM7AsLN0f+4/znRoI99m52qLt2nAKg21hyLPM8QN0Dwn
	6Lj4lRQKRppT12pZtJuJqNYXC0XlcDJkmGbN2Ilja58jLRLnsuhCNScdfZcKyUtPaw/qUY8lhoa
	NEkkSV5huq72HCM/poU3uYWom7yA=
X-Google-Smtp-Source: AGHT+IGkMh8YvcEzFZwNeJ8uqlNWdzrx1eQt4TmWoZ7Jr1bL4vc2QgvjpdK+OE/xElJ5xWW7qVPd63Eg9hU2ljYdnI0=
X-Received: by 2002:a05:690c:23c1:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6e364349001mr60262517b3.23.1728909867379; Mon, 14 Oct 2024
 05:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-7-dongml2@chinatelecom.cn> <Zwuxwavki0lL01Ox@shredder.mtl.com>
In-Reply-To: <Zwuxwavki0lL01Ox@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 14 Oct 2024 20:44:27 +0800
Message-ID: <CADxym3b5ONVmiG8WhSsGs0zVGKwu6S=E759EsgiodZOXQ_y43g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 7:41=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Oct 09, 2024 at 10:28:24AM +0800, Menglong Dong wrote:
> > Change the return type of vxlan_snoop() from bool to enum
> > skb_drop_reason. In this commit, two drop reasons are introduced:
> >
> >   SKB_DROP_REASON_MAC_INVALID_SOURCE
> >   SKB_DROP_REASON_VXLAN_ENTRY_EXISTS
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> IMO the second reason is quite obscure and unlikely to be very useful,
> but time will tell. The closest thing in the bridge driver is 802.1X /
> MAB support (see "locked" and "mab" bridge link attributes in "man
> bridge"), but I don't think it's close enough to allow us making this
> reason more generic.

Yeah, the concept of the second reason is a little obscure to
the users.

>
> [...]
>
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index 34b44755f663..1a81a3957327 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1437,9 +1437,10 @@ static int vxlan_fdb_get(struct sk_buff *skb,
> >   * and Tunnel endpoint.
> >   * Return true if packet is bogus and should be dropped.
>
> The last line is no longer correct so please remove it in a follow up
> patch (unless you need another version).
>

Okay, I'll remove it in the next version.

Thanks!
Menglong Dong

> >   */
> > -static bool vxlan_snoop(struct net_device *dev,
> > -                     union vxlan_addr *src_ip, const u8 *src_mac,
> > -                     u32 src_ifindex, __be32 vni)
> > +static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
> > +                                     union vxlan_addr *src_ip,
> > +                                     const u8 *src_mac, u32 src_ifinde=
x,
> > +                                     __be32 vni)
> >  {
> >       struct vxlan_dev *vxlan =3D netdev_priv(dev);
> >       struct vxlan_fdb *f;

