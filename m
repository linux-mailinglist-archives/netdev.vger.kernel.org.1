Return-Path: <netdev+bounces-124782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D894C96AE28
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68761283CFF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1F9FBF0;
	Wed,  4 Sep 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui1Soong"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82093C17;
	Wed,  4 Sep 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415161; cv=none; b=Xl021fOXbjgxav3Vkh/S3JZHH4YTC4ydKr5kxJsZ9iwJVm9XtGWNl42VhxnjRcD+hRrQ4VZwnLeIqeT5a1v7uuVTJN7gG+kAeNYjihLyr/mhSdNzqL5q0bLcO6b/74OkcE/vdX+OWC+Z9s9ZG+kkmPOkEyC/BYCC0n3FEm9yERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415161; c=relaxed/simple;
	bh=SHBBMj+kcNZa4ko/RtLnwxdJwc+D2I5cUK8KVSfR8Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1jBeEMwVcNpOwxZe6vz5JpHor7Zvxfbott/Zji4rELEbuft4PSmiwt4b1NmAkSfJxwrViPLVrPKuSS9afgnPDH6NyRbeEsUnBk05hBaZH61EeRHksbW+6GdYw3ifYUSkia9bO/TojYt/z9rfo8Qmgn7t56/+YeZYBVjLW1UEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui1Soong; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e116a5c3922so5742381276.1;
        Tue, 03 Sep 2024 18:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725415159; x=1726019959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySY+JqVL2bcg8x2diCk20FCdTyllIvauVkwMxwotWS4=;
        b=Ui1SoonggVKkHTYcGO5E3ZTIjE3Hz23eviSgqE/5/NM4IdSNkvXrRoyYxV5t/aUNqv
         KzlVTG0BK63AoOtdULDpmlZCyQwbR6eku/Z2c0mTPIPKazxxUuqNVbAM4AohAgHYNAg6
         wwvU6C3piYdKY/ZaBMr7dnxLYs3DW0xfk3iRB6i1UOwggEQHXZAbqc0ZI4M0rkaf9+rT
         mTGoWgTQNvPHS3lZWZqwbukt/mGLFgiPkdWyEuFefvDps4i5LXkoQpRviiERs3YBGhBH
         KgrUOYPsFL4bNOBkrycmLvv9oJ90Rp347epHi/KUTFS/MF14V9Z+GHj4T5E7CKbIzXyJ
         Dosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725415159; x=1726019959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySY+JqVL2bcg8x2diCk20FCdTyllIvauVkwMxwotWS4=;
        b=bbEfWusSIcreUXWLnL+UsS82n2NMxtvVXBS/W6XqG7ipe0tz0e9z6hW2/T7bSDq8a0
         0GugXWTj1YvRJ61Gq8YG+CQpKSxYRoq8IBh9/z08huYJNQkQpli3ULpCRKJvm2Qh+k3u
         ShtDVWKpCLDG8Bc1HAjZ8/3o45ZCvaaG/zYNUwb6trUWGMREgLMVGc/TD4zv+mrCUHJp
         UDpUfdoj9fveMPB4acgHicXNyXBlIubs8Kfmy3qwp8mo1Ms/3cKL6XgVrQHB/5xV6O5f
         U0OYEze9aNlw5qCv0bG1+9SWZKo3Qia7NVjl67MRm6gkXVOTqsO0AcFLJ0fHw8i6slY7
         cGjw==
X-Forwarded-Encrypted: i=1; AJvYcCU5k9EH8xsl1A00WDK71uPZbuNB9mpseXFvc5VGqlKx9Ne0D/DkLgZKCUJ6BADbCKQhb3XH6u5sbz8XqoU=@vger.kernel.org, AJvYcCUeviO0RRdavMc3sFxcEVITDM9D8BOyHS+Wv4zbxcLdeoEOCa4zK8OEFfMSQl2MLGC7rP0DEwC6@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3XNbKPB8UCU26DZ0KBi5GuzASIN5lqmig/BVTscc30HXCuIZ
	RH/fYyH+SZjdiSbvVKigKCge9N7+0oDfw+pzQgQ8yJl5n6n9VlL9WV5PgrLDwE/N12eXZN6gHUJ
	j26Uu05++8fp6pp22qwgCs4nhXV8=
X-Google-Smtp-Source: AGHT+IGKCu11O1Jfjlj8c7VOd7RU9KnonePXHCWMKLEzBVLyTko/XhgLPt55/hjnqeVHevyODbO6v6jCX7rI/9RS9Ww=
X-Received: by 2002:a05:6902:e8e:b0:e0b:e2de:a64a with SMTP id
 3f1490d57ef6-e1a7a1a37c9mr16230052276.36.1725415158704; Tue, 03 Sep 2024
 18:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-7-dongml2@chinatelecom.cn> <20240830162627.4ba37aa3@kernel.org>
 <CADxym3bkVFApps1wJpSQME=WcN_Xy1_biL94TZyhQucBHaRc5w@mail.gmail.com> <20240902181211.7ca407f1@kernel.org>
In-Reply-To: <20240902181211.7ca407f1@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 4 Sep 2024 09:59:20 +0800
Message-ID: <CADxym3aH_tH7Kq2jXqKt+4owp85nfELdPBJMapG2mwHWN8k98Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac() return
 drop reasons
To: Jakub Kicinski <kuba@kernel.org>
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun, 1 Sep 2024 20:47:27 +0800 Menglong Dong wrote:
> > > > @@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *v=
xlan,
> > > >
> > > >       /* Ignore packet loops (and multicast echo) */
> > > >       if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_=
addr))
> > > > -             return false;
> > > > +             return (u32)VXLAN_DROP_INVALID_SMAC;
> > >
> > > It's the MAC address of the local interface, not just invalid...
> > >
> >
> > Yeah, my mistake. It seems that we need to add a
> > VXLAN_DROP_LOOP_SMAC here? I'm not sure if it is worth here,
> > or can we reuse VXLAN_DROP_INVALID_SMAC here too?
>
> Could you take a look at the bridge code and see if it has similar
> checks? Learning the addresses and dropping frames which don't match
> static FDB entries seem like fairly normal L2 switching drop reasons.
> Perhaps we could add these as non-VXLAN specific?
>

Yeah, I'll have a look at that part.

> The subsystem reason API was added for wireless, because wireless
> folks had their own encoding, and they have their own development
> tree (we don't merge their patches directly into net-next).
> I keep thinking that we should add the VXLAN reason to the "core"
> group rather than creating a subsystem..
>

I'm hesitant about this in the beginning too, as VXLAN is a standard
tunnel protocol. And I'm still hesitant now, should I add them to the "core=
"?
which will make things simpler.

Enn......I'll add them to the "core" in the next version, and let's see
if it is better.

> > > >       /* Get address from the outer IP header */
> > > >       if (vxlan_get_sk_family(vs) =3D=3D AF_INET) {
> > > > @@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *v=
xlan,
> > > >
> > > >       if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
> > > >           vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifi=
ndex, vni))
> > > > -             return false;
> > > > +             return (u32)VXLAN_DROP_ENTRY_EXISTS;
> > >
> > > ... because it's vxlan_snoop() that checks:
> > >
> > >         if (!is_valid_ether_addr(src_mac))
> >
> > It seems that we need to make vxlan_snoop() return skb drop reasons
> > too, and we need to add a new patch, which makes this series too many
> > patches. Any  advice?
>
> You could save some indentation by inverting the condition:
>
>         if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
>                 return (u32)SKB_NOT_DROPPED_YET;
>
>         return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifin=
dex, vni);
>
> But yes, I don't see a better way than having vxlan_snoop() return a
> reason code :(
>
> The patch limit count is 15, 12 is our preferred number but you can go
> higher if it helps the clarity of the series.

Okay! I feel much better with your words :/

Thanks!
Menglong Dong

