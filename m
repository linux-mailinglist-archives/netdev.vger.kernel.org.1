Return-Path: <netdev+bounces-124474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BAB969A40
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541E61F23E63
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759019F434;
	Tue,  3 Sep 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd4rJjBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF31A0BEC;
	Tue,  3 Sep 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359602; cv=none; b=PV8aDuuxifqVOvq/V6YKCSm9P4DiIA2B4+VDRrF5u0LLCklSsT4yt5+r8aT3sMdTl4f5B1GcXZHAH8zZ2n/HCOmGFFJWnuY2b8k+SCrEONGoW1SiXqwufXcNmh9hphwKziC0/CdrKNrU6eAo5m9N/v0CyAS2wnbNK+y6h1d5dBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359602; c=relaxed/simple;
	bh=ym+4wwvyQj3hCdU0IvLIVTgauKzQvNnj/eQp5QdHg+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGpR11OeS8DcAOxSyMWaVWFZjdXEzHDy7+ICU0yEwoYgO9Et9YM/h9syt71+abFL1tEcpSefMljcqfB44ylbdDT3XCtGOhJkbcpgHZom81cLqbTbZKfHB70Qgk3yPMo4vKnG9S2aPJec8o9k6IR8cKNQZnXgSVAU9ctY4VlfGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd4rJjBk; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6c91f9fb0d7so47977777b3.3;
        Tue, 03 Sep 2024 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725359599; x=1725964399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCAdgvZx69R+Inx1xIn1qv1QpEbNVZIKK3gneUW2eRA=;
        b=kd4rJjBknsAIb7ZVD1/faJN+GEUXx0HWLdeboWWvjnVIrVAds/18p9rNdxqTemRMWH
         mBpTfPIS80Ui28YhoQ6QwpTWstDP58nTRWxfgoyUMhPZ4VJuhVOGnHERP3ZOTk7hWlAZ
         Oe1rXcCB7zkrSFyjm2vaoqIqaLkIPuxjmi5uAcpNM5ZoZBRx/CZdmwsOlrzT5a8oWtAt
         QCFoqiAIKEWtdmRvMAs5JnSh7ymDZweY3bUuNzM7rmBf9mK2tfxQERJEcrldt6MutXL/
         Dvk9kyfq6IE1BJnRkjT0KT5FPRwxygG6iPjFkghzIyf6mNPDoPxAusOvCcI2ooB3ygMk
         qOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359599; x=1725964399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCAdgvZx69R+Inx1xIn1qv1QpEbNVZIKK3gneUW2eRA=;
        b=kU0tQ2dYQx0nIlBefXXc8hQmUUdUNkBO1iMmcM4puaSh/I/wBwSM1uCkKcKP9yBKfO
         LN7IRviAj3RAQebCfSL/+AhjCO+p7ATdI5+eaqfwlbqrR9QsfHdfH1EqgHT+Z5MtMypm
         tWIE0vhXq3Au4coMfbIttrHzLLvZfgx7fMhwl1QzZcrg/dX6UwKaBBUG22pGLzmEHHgC
         9wq6EfgLv/G4ZgV/GrkgplQgbKzGDrb080hWGO/nwAcMwPKYaQdeySyubEXQCTaow3KJ
         GZqHSY4db6XZEfH+ddKhE4tX1hAG2rT/wDeQOKEDaU6Un6WA6ulDE4x8yQwMymqYkbfn
         1TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV77zAZcl1XYGrvpjL/xmWh4jUQNl56cq/nrcDZ7BtSHkVFCf0deQvjXOoJOsUp1EZ3e+GaFfwo@vger.kernel.org, AJvYcCVdg6I7Y/un4LdNkaKQVrqiFXnAsxxvbeegPBaZzbPBETR6FBAl3cPF6RYn6kFmsJHckzYOtZWyXCSsPtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYruPrnbzpPLVA7vpbPo4uemolMgn8+8HVkRQrKvA1c3M6v9O
	tK1UW6ZmtVNIKvtdQ88IdgtteVy8deQShLGimk7qMAn81sHL2FZ2DOJeJY7foq2HEkeRuD71hQq
	DMqLeu46SKZGchvGMx+kjMm1/mGw=
X-Google-Smtp-Source: AGHT+IGA9aek/qyQ3u3BrYjoPk2A6zcGsd3cA67Uo4udmJ/qkSUbGkJyeqlv6kamjRM2gF9vAF3t7+tx75oN9zP3Q9E=
X-Received: by 2002:a05:690c:2a92:b0:6d1:f545:4ae6 with SMTP id
 00721157ae682-6d40dd71718mr102102167b3.16.1725359599390; Tue, 03 Sep 2024
 03:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903045937.1759543-1-bbhushan2@marvell.com>
 <20240903045937.1759543-6-bbhushan2@marvell.com> <ZtbY9AF1fjUCcBOH@hog>
In-Reply-To: <ZtbY9AF1fjUCcBOH@hog>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Tue, 3 Sep 2024 16:03:06 +0530
Message-ID: <CAAeCc_=Uox_JkD2WMs1ZqC-XFHfBnHWALEZC6iWhb0BNWB9Uow@mail.gmail.com>
Subject: Re: [net-next PATCH v8 5/8] cn10k-ipsec: Add SA add/del support for
 outb ipsec crypto offload
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, richardcochran@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:08=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> 2024-09-03, 10:29:34 +0530, Bharat Bhushan wrote:
> > +static int cn10k_ipsec_validate_state(struct xfrm_state *x)
> > +{
> > +     struct net_device *netdev =3D x->xso.dev;
> > +
> > +     if (x->props.aalgo !=3D SADB_AALG_NONE) {
> > +             netdev_err(netdev, "Cannot offload authenticated xfrm sta=
tes\n");
>
> This should use extack, to return this information directly to the
> application that's creating the invalid config. You can propagate it
> from cn10k_ipsec_add_state down to this function, and then:
>
>     NL_SET_ERR_MSG_MOD(extack, "Cannot offload authenticated xfrm states"=
);

ack, this and other places
>
>
> > +static int cn10k_ipsec_inb_add_state(struct xfrm_state *x)
> > +{
> > +     struct net_device *netdev =3D x->xso.dev;
> > +
> > +     netdev_err(netdev, "xfrm inbound offload not supported\n");
>
> Here too, extack.
>
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static int cn10k_ipsec_outb_add_state(struct xfrm_state *x)
> > +{
> > +     struct net_device *netdev =3D x->xso.dev;
> > +     struct cn10k_tx_sa_s *sa_entry;
> > +     struct cpt_ctx_info_s *sa_info;
> > +     struct otx2_nic *pf;
> > +     int err;
> > +
> > +     err =3D cn10k_ipsec_validate_state(x);
> > +     if (err)
> > +             return err;
> > +
> > +     pf =3D netdev_priv(netdev);
> > +     if (!mutex_trylock(&pf->ipsec.lock)) {
>
> Why not wait until we can take the lock? Failing to offload the state
> because this lock is temporarily busy isn't nice to users.
>
> > +             netdev_err(netdev, "IPSEC device is busy\n");
> > +             return -EBUSY;
> > +     }
> > +
> > +     if (!(pf->flags & OTX2_FLAG_IPSEC_OFFLOAD_ENABLED)) {
> > +             netdev_err(netdev, "IPSEC not enabled/supported on device=
\n");
>
> You should also use extack in this function.
>
>
> [...]
> > +static void cn10k_ipsec_del_state(struct xfrm_state *x)
> > +{
> > +     struct net_device *netdev =3D x->xso.dev;
> > +     struct cn10k_tx_sa_s *sa_entry;
> > +     struct cpt_ctx_info_s *sa_info;
> > +     struct otx2_nic *pf;
> > +     int sa_index;
> > +
> > +     if (x->xso.dir =3D=3D XFRM_DEV_OFFLOAD_IN)
> > +             return;
> > +
> > +     pf =3D netdev_priv(netdev);
> > +     if (!mutex_trylock(&pf->ipsec.lock)) {
> > +             netdev_err(netdev, "IPSEC device is busy\n");
> > +             return;
>
> If we can't take the lock, we leave the state installed on the device
> and leak some memory? That's not good. I assume we're going to reach
> HW limits if this happens a bunch of times, and then we can't offload
> ipsec at all anymore?
>
> I think it would be better to wait until we can take the lock.

This is atomic context (in_atomic() is true). So we need to call the
trylock variant.

Thanks
-Bharat

>
> --
> Sabrina
>

