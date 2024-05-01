Return-Path: <netdev+bounces-92695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74598B8465
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 04:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518151F23AC2
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904381BDC3;
	Wed,  1 May 2024 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/fB22/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677510A19
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714531173; cv=none; b=KNW/fmJgd00S/5izFOSf7aZZF7esSDNQuZJ9MsL5SgyRmp7VM4mmPC0I5UCht1q70PZmndsY6ST2YVMuJzM9JODnl+ipUo16Gb4hSm05umDk9Kw2lW6EtEMTo5V1JlR1dBiMWyg83SWG6mc9p8q1dl3JoCvJr2Na+oc9ujnjQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714531173; c=relaxed/simple;
	bh=F7EGBr4Vm+LpjjC9/ltNpETANQ2B0FpgdccksxSnzo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3T8t0mEyN+lIQRuVAcn61VAMlmDKESxYzaDU0qqRnMQ3IBYLYNISYBapR87sDKf/4n3CMfhBKC8iA4ejsXsNGbDfDJ6Z+qdNdAzdxGU3PhEfMrJIBfl+TsxaauFETMbwkWBp9ACjDrwsBtw4Ht9pB5wCFhsPhrrWcnr9ZDbRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/fB22/W; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso3664a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714531170; x=1715135970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m76eP3AT1+hS5BG/pb9E5YTjv6WXZuxTfxIQkMYadk=;
        b=O/fB22/WONk1aUKGe6DFZsoZmojNvGJE7h8RG8D4lpc4Bj5OS2bTny/LzAdi/NWxPw
         62TUKR56C/bFpQ63aAxZokIeH8Bg1kC5pa7kyqH0XyvQuvIF+u/YKCdoytGrEwStYnf4
         ft2eO3WX3sCGFerbGKJbbUtOHJGRHDwj25S0iJ+nlacX2Gwa1qEnTslG6Y5yYMUsRsbC
         OQgp1rCJn2hCHULnd1L5PGdVTt9FG9fgDFSKfqBYP6JlF80+9cvwelCzWShOXqXHViDF
         94N5C4iUcA0DhPmrPk1p2+/ibZKsgK16yLRbXELgUIKWBxJ2Cgq/HadQh8fcMTBDN2bY
         qEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714531170; x=1715135970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m76eP3AT1+hS5BG/pb9E5YTjv6WXZuxTfxIQkMYadk=;
        b=HmVu4u/YzOO1S8bE3I1tNjws9KvY1RTcYle70MEjIH8+mwaQGpcLEwOozhBbtGK4P0
         qvMuenzA6qZQwnFi5yngAw5fawhRe6ARV0v4Zri2pUwcDFgZaqMgXPew8iSWKDaU97IG
         95ZWPv9B4jqbjGtXz3LSMRK3dZxYU/AQbaPE8h9LVhd+/Rk7XtogDh/6eXJqQeGQENED
         TgalL5X5fkgwf4uPJdRpThkyODo3w5beZUE+2OeFNCo5NetG1pMfc0NF3Q4XBrd7pfDN
         ti8N1ukhwICwCQKjC64+ChcKA1IPO3IkfJKbj6GcINnxQP4DsQ7QCI8OpNwbyNzD7iUi
         SzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhAII9NKjo5woL2Vcp841UWX/ge5XUj7jUP+fOMQsN2lSWL6Z3N77ZFx9V2otieyVQFaTp/TLs/PGElEN+lF0Xvc97tAJZ
X-Gm-Message-State: AOJu0YyOs6Hx0JoLRvZe1H2F+P23DxIC3nk2DKkLs7i3xGgWlJ7eq7Rw
	QyF/VoUd0pvPTEOZeJxG1dM/Kq+mSAtrwxSaBcAmHZ6WxJuqFiTIlDRrXVDA75wwPcxDGcuHDoQ
	xVDTjTYkE6M3iiwDwORO/Kty9q/85xxYnc9UG
X-Google-Smtp-Source: AGHT+IFhePB7tcN40amZoZZKJB60islkxa1F/nYqtojnqCYhYg1EMoWMq8cd6g5i1+u6iK65dJatZTVa/PWd5NHamyg=
X-Received: by 2002:a05:6402:1ac9:b0:572:7d63:d7ee with SMTP id
 ba9-20020a0564021ac900b005727d63d7eemr106765edb.4.1714531170088; Tue, 30 Apr
 2024 19:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430194401.118950-1-marex@denx.de> <20240430191042.05aad656@kernel.org>
In-Reply-To: <20240430191042.05aad656@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 04:39:16 +0200
Message-ID: <CANn89iLKQjD1bxbirwtvzxsfOa-i2qRTGHYH_8_8O-xCusypQQ@mail.gmail.com>
Subject: Re: [net,PATCH v2] net: ks8851: Queue RX packets in IRQ handler
 instead of disabling BHs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org, 
	Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 30 Apr 2024 21:43:34 +0200 Marek Vasut wrote:
> > diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/etherne=
t/micrel/ks8851.h
> > index 31f75b4a67fd7..f311074ea13bc 100644
> > --- a/drivers/net/ethernet/micrel/ks8851.h
> > +++ b/drivers/net/ethernet/micrel/ks8851.h
> > @@ -399,6 +399,7 @@ struct ks8851_net {
> >
> >       struct work_struct      rxctrl_work;
> >
> > +     struct sk_buff_head     rxq;
> >       struct sk_buff_head     txq;
> >       unsigned int            queued_len;
>
> One more round, sorry, this structure has a kdoc, please fill in
> the description for the new member.

Alternative is to use a local (automatic variable on the stack) struct
sk_buff_head,
no need for permanent storage in struct ks8851_net

>
>
> > @@ -408,7 +406,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
> >       if (status & IRQ_LCI)
> >               mii_check_link(&ks->mii);
> >
> > -     local_bh_enable();
> > +     while (!skb_queue_empty(&ks->rxq))
> > +             netif_rx(__skb_dequeue(&ks->rxq));
>
> Personal preference and probably not worth retesting but FWIW I'd write
> this as:
>
>         while ((skb =3D __skb_dequeue(&ks->rxq)))
>                 netif_rx(skb);
> --
> pw-bot: cr

