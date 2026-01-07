Return-Path: <netdev+bounces-247784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9106CFE6A3
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5091300E623
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE134E753;
	Wed,  7 Jan 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgSelP+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9631CA7B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796951; cv=none; b=jD6ZNsVGb2YyqMK8DGhdJWyHnnz+0OerJYG4hwqCQGoPugtkO7OTPPTDKOYinAulHyd1fiAqs+2k4ytwbftLtHZNyBYLly3X1KEK6QM8Wh1alznSQ09nXfH1LIIluTxuDBw+kw+Wg7OxFQBoWGpmUE91n0QC47pChsaiGU2c3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796951; c=relaxed/simple;
	bh=em+eQasoXV+ieZ2VzId4L8I6qfX07Vo0APfNOC9Axao=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ISVVD/ecNK+oJ2VD52tndndykhsVi8kQKZPu4MuXWuJBEJxyKYqk32+SwMupE2EFY5yRFIozGDpxmczfXaF8FpSuqdTjD+Nz71cR/Zi83g7Ne6UmLsJicmYXvmm5I8O+Elj5b4Nqa3HN1ebQ+ve0jRrhwOnc08hBmXuoG+9UL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgSelP+j; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6467bed0d2fso2145604d50.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767796949; x=1768401749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpmSZto6HCh21XHSuuIbEddw2MefFg0sEaIgISNXX6I=;
        b=NgSelP+jdUB6XhD3MEbjQejJ1m4e3MImFWVTfVPGAAH8XYHIvj5FJtfMcGzRMfCOgg
         VcPwNvD9xPJbnUdzR2htfFxPtxpKVmWFZBHRBcZIQXzcCTfeWA5M3I74UPz5siAf7d6T
         xx5Tz7+QTgpSacVUbyH018wBoSlFU1dYcJXAFDOK1rY0VA4uERqVDnxtKXVpBlHisv4R
         7wsU4biGze0W6BPOLRxIxaMl23BXvPCRvx40NeN5srdlDV7jMm84zlAYSxJOXxRsCrHK
         qNUidHAuxZabfDaA4lep35wgAipuNrWNgIFgms5XzmjRMSy9Uv+jJv5YlbrUvHwMtKiQ
         Jzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796949; x=1768401749;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpmSZto6HCh21XHSuuIbEddw2MefFg0sEaIgISNXX6I=;
        b=g9pxLBPBdXnS6exFLAdHAW/YFpcD9Q8OYJrD5NpB//P+n/w5xyz1jf+mxgrnHxh/gG
         xEeSScrbDPiJwX+qzPforr1lAr6vrK/C/jOP2pK3oX9dif4WrHQeSZlWwLlXBnMDZg5X
         9KM3mnehuC0uvc5dMafHtwOmzILt4jwrDRT4rLvgIOgxCwT50ph61HmZ7Lotu3QLdS9H
         jvo/xap53HyoaxrZuORyBh6knz2YEkEBJWscI5KQDVSJkRNAiXBY/RzxUJUvmXu42DnF
         s10eVKdZt3d9HlsEUceLZMQEOBVTDrH/n4WLGvkvO8WS9L4pbfPbdTjNnhPtJzwvfXh0
         AJcg==
X-Forwarded-Encrypted: i=1; AJvYcCUtBBV/n9r1M8Fs7gHu/5DiRjrnZnvlOFReYf2djrYkHlgJNt62XT0pSrc4NbjId73LPb+DSs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1Po2wWzDWhWknsKi9MriRUjgkWI4Tfwl0mOT4dn5To/sVbhS
	jjkApNl+V/vGuyByYXBxuiVi5U57aIP71RgAmAl+3nlTsZNSfM9iejm5yBBHdg==
X-Gm-Gg: AY/fxX4sOjvHfv5fPMqpUpPnY/nTr3ZrBnLgfj0lLJWyCRTFUy6Xvaui33ED2e2Rnbm
	aaAwEOMVkdYDVrfdZBGxfkg+HCzA2vjY52zZJqRMt7NC+15NtTZLPR2sH9kwriyzm6OzEhioITg
	A9iX5bEePf7bos4urREB1JQl/mHgsO4PvkE/2xdU9xz7IzlBkDt//JiXJCJQDDx0carkXO3M8/+
	1pmxBQRs26gfMPW82hqkPEX881XcyNPMMFELdduYTxlHkjzqJb0ujNRHai/vxV6co6d+t4ELvW3
	yTFpaR44utTYhsS8JnaFvJ/1X3k76cJypfLLxYRovaYsdFmHnpXQ1nznv1u7OlZunKvlsAdJ+SG
	PPQvINtolgHShEOs5MDb/asrt7qERG1uNx6//lNdVRhE0dED6VNGKS5+4c1qC2ayRavoD0j6JlB
	9aiDDD8fbavvpLI+Y+1CIkkfjjGcDTmDz41Xnzs3z+uWuquOv22Yg6bRHGXSKq+RjO9Ej1kw==
X-Google-Smtp-Source: AGHT+IHOYqgqIsQV5OCyt+nt3hkI5FRq5tt1UpWArNiIQBGiK3OY9OjfrS8IcPSJ2z64PfeXzfAkwA==
X-Received: by 2002:a53:d056:0:20b0:63f:9897:f544 with SMTP id 956f58d0204a3-64716b3a7eamr2055666d50.19.1767796949169;
        Wed, 07 Jan 2026 06:42:29 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d80dab9sm2133603d50.7.2026.01.07.06.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:42:28 -0800 (PST)
Date: Wed, 07 Jan 2026 09:42:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.c89a9fd4ffe8@gmail.com>
In-Reply-To: <87jyxt4w9k.fsf@toke.dk>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
 <20260106-mq-cake-sub-qdisc-v6-2-ee2e06b1eb1a@redhat.com>
 <willemdebruijn.kernel.21e0da676fe64@gmail.com>
 <87jyxt4w9k.fsf@toke.dk>
Subject: Re: [PATCH net-next v6 2/6] net/sched: sch_cake: Factor out config
 variables into separate struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
> =

> >>  static int cake_init(struct Qdisc *sch, struct nlattr *opt,
> >>  		     struct netlink_ext_ack *extack)
> >>  {
> >> -	struct cake_sched_data *q =3D qdisc_priv(sch);
> >> +	struct cake_sched_data *qd =3D qdisc_priv(sch);
> >> +	struct cake_sched_config *q;
> >>  	int i, j, err;
> >>  =

> >> +	q =3D kvcalloc(1, sizeof(struct cake_sched_config), GFP_KERNEL);
> >> +	if (!q)
> >> +		return -ENOMEM;
> >> +
> >
> > Can this just be a regular kzalloc?
> =

> Yeah, I guess so. I'll change this if there's a need to respin for othe=
r
> reasons, but probably not worth respinning for this on its own? Seeing
> as it'll all end up in the same kmalloc call anyway :)

Sounds good.

> =

> > More importantly, where is q assigned to qd->config after init?
> =

> Just below:
> =

> >>  	sch->limit =3D 10240;
> >>  	sch->flags |=3D TCQ_F_DEQUEUE_DROPS;
> >>  =

> >> @@ -2742,33 +2755,36 @@ static int cake_init(struct Qdisc *sch, stru=
ct nlattr *opt,
> >>  			       * for 5 to 10% of interval
> >>  			       */
> >>  	q->rate_flags |=3D CAKE_FLAG_SPLIT_GSO;
> >> -	q->cur_tin =3D 0;
> >> -	q->cur_flow  =3D 0;
> >> +	qd->cur_tin =3D 0;
> >> +	qd->cur_flow  =3D 0;
> >> +	qd->config =3D q;
> =

> Here:   ^^^^^^^

I'm blind. Thanks!

Reviewed-by: Willem de Bruijn <willemb@google.com>


