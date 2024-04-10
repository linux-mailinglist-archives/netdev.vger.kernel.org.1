Return-Path: <netdev+bounces-86381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539D89E8A5
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F27E285C64
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 04:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD2C2D0;
	Wed, 10 Apr 2024 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGkK+P6W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55202BA50
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721652; cv=none; b=JClvJqD6P2seZLQDSA+eXwcqIaWTHsDv3Er4/ziU/WDsAqQwimo2ZOjLGyN1oOYPqCQP/tnk/v3ZfgWliZSPYX0L5D4zuRwGU3arYtWjXsQNAXxvEP9L0r9T8sCh4lWi18np+G/yM2iMamhx6i7iwkk/nO2SDgzeGJcBHHK6Pe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721652; c=relaxed/simple;
	bh=C9iX9EN5K2Ro8VVAAiuWt++9y2FBI0Zpc08FBH0LuDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbgeX9qlr2D//g0cMfzuuyQ3Yl066Ewix4zlMPJhlA/O6KF26YAC2jXPqqBTW8I4DECsXp9Rj8dkKSuiNZCxP90rnX10pwdDac3lUTS66sxtGMpH/F706iUQNTb2jJel455kyQeP7tBAgywU77+LW6hN/DxhF9gpuyZp3RLGO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGkK+P6W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712721649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=de15/AUuRjUO/tt3yX92+ptttxMxCuHyuP0n2Hf4wZc=;
	b=FGkK+P6W2BPUYND5nq5fMa2hnng66I3wmpk7Qe6nCPApW6RC9qgj7VjYIAEn4dDCAqxlfF
	dDBCqrvYL8eJOOHGydCyEpTQyLTtqqHxHSKOanBEzf23i7dPxtnCNB1DWkaAmBABLWfm9C
	ly9NrqrqkioHEOecUr1+cQ+LjDjlkFI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-9x_G_1vPMkK52vPkzJJYhA-1; Wed, 10 Apr 2024 00:00:45 -0400
X-MC-Unique: 9x_G_1vPMkK52vPkzJJYhA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a482a2360aso2996845a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 21:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712721644; x=1713326444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de15/AUuRjUO/tt3yX92+ptttxMxCuHyuP0n2Hf4wZc=;
        b=IK6+EdXtrrRXPZvJm08ZkiIGNEERi/npBo79Ot93/NVEss9LvQY3S+hN7C9+Hs1ECs
         E7jnQ8ce2BHak3nHlIxhXIV0Ei3Z1O68tJGM6SkQ6CU8flulcBEitmRrsu50oCu24wSg
         x/DIA7KLjOQ2j668wNe/4nanbZK5XxSFVjK1XblXt2upV5H33VL+U+Eq2Ed8HzDFXlgN
         /LLpIt+ylkK+2Hs5UNVTz1PUHtUuwD6E+CrRdBziNPWDtZZkbdYcJTpjVgnQYB76rbAo
         11rwasVUIyUz4l9NbO1gNuAFPASQkLiPi5QBlpTiO25s/MF5YbHmt2WHnD1tcwz8wbm3
         NZJA==
X-Forwarded-Encrypted: i=1; AJvYcCVyj+m8VBzjhGBhT3X0K8c4gkOL7aDbwtYhTFwZFf/cgw5OEb36OTOsQouP9SFqGDmudfhvDEBV3pESXoN2ZjP76T2zFOAR
X-Gm-Message-State: AOJu0YxdWkwLDQXl6dpgutGs3MDt2Frc6w/NuYzCpz2ggxqSHPIDTVkI
	4HYtMksoSOGfibmzg91Mo60qEhbgLskuNcB8vJkqDZU7ycbyErENnS/FBYXthQV5+JeAiZdsDrj
	oU8bXUHteEtOxg+XSEhrMhUNnghAMdjVKoRb2yaf6YqcTVYPxgByalOQdESKeD3HTA6O/wIvELT
	ENzLhbZqQ3MSf4IsswaGXFkLrOUZqA
X-Received: by 2002:a17:90a:ac0c:b0:2a5:575:c58d with SMTP id o12-20020a17090aac0c00b002a50575c58dmr6289023pjq.16.1712721644504;
        Tue, 09 Apr 2024 21:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdHFAwhw+2G4PAM3Oz2MINPfDmb6Jxw1Tf4U1Ia7sHQk6lKkVYIl3TRV/Ubft2JqDpzfOhy9+AFpizuC/SKtU=
X-Received: by 2002:a17:90a:ac0c:b0:2a5:575:c58d with SMTP id
 o12-20020a17090aac0c00b002a50575c58dmr6288996pjq.16.1712721644112; Tue, 09
 Apr 2024 21:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409062407.1952728-1-lei.chen@smartx.com> <0e5a96b6-0862-4c00-b07f-7485af232475@lunn.ch>
 <CAKcXpBwE-8p+naDgJnCU41ODxRhWq7CkhEeeOAw+Ode4-J6CLw@mail.gmail.com>
In-Reply-To: <CAKcXpBwE-8p+naDgJnCU41ODxRhWq7CkhEeeOAw+Ode4-J6CLw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 12:00:32 +0800
Message-ID: <CACGkMEuiROr4EydSp+HFgG2GPqsda0zpfge5DvsSDEbsyWDuLg@mail.gmail.com>
Subject: Re: [PATCH] net:tun: limit printing rate when illegal packet received
 by tun dev
To: Lei Chen <lei.chen@smartx.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:23=E2=80=AFAM Lei Chen <lei.chen@smartx.com> wro=
te:
>
> On Tue, Apr 9, 2024 at 8:52=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
> >
> > On Tue, Apr 09, 2024 at 02:24:05AM -0400, Lei Chen wrote:
> > > vhost_worker will call tun call backs to receive packets. If too many
> > > illegal packets arrives, tun_do_read will keep dumping packet content=
s.
> > > When console is enabled, it will costs much more cpu time to dump
> > > packet and soft lockup will be detected.
> > >
> > > Rate limit mechanism can be used to limit the dumping rate.
> > > @@ -2125,14 +2126,16 @@ static ssize_t tun_put_user(struct tun_struct=
 *tun,
> > >                                           tun_is_little_endian(tun), =
true,
> > >                                           vlan_hlen)) {
> > >                       struct skb_shared_info *sinfo =3D skb_shinfo(sk=
b);
> > > -                     pr_err("unexpected GSO type: "
> > > -                            "0x%x, gso_size %d, hdr_len %d\n",
> > > -                            sinfo->gso_type, tun16_to_cpu(tun, gso.g=
so_size),
> > > -                            tun16_to_cpu(tun, gso.hdr_len));
> > > -                     print_hex_dump(KERN_ERR, "tun: ",
> > > -                                    DUMP_PREFIX_NONE,
> > > -                                    16, 1, skb->head,
> > > -                                    min((int)tun16_to_cpu(tun, gso.h=
dr_len), 64), true);
> > > +
> > > +                     if (__ratelimit(&ratelimit)) {
> >
> > Maybe just use net_ratelimit() rather than add a new ratelimit
> > variable?
>
> Thanks for your suggestion, net_ratelimit is a better way to make it.

+1

Thanks

>
> >
> > A separate issue, i wounder if rather than pr_err(),
> > netdev_err(tun->dev, ...) should be used to indicate which TUN device
> > has been given bad GSO packets?
>
> I got it, I'll remake the patch, thanks.
>


