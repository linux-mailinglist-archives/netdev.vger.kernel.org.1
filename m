Return-Path: <netdev+bounces-233696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F70C17726
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E5D1A654CD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B134883F;
	Wed, 29 Oct 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrID+pVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA363D6F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696076; cv=none; b=WNarMLBzBMx1qVIgsW5E7WPXg075SK6rn7Ncz19aQbIFm8fFg/Mx6+4635D/WlAU/YoWRZ9BICmKZWiokqrVmd5j3TuF0ugA3L5ZyyYYbMVxuIOY+SeKdWpc4DoKjRGxELIoSBTJD547N9GW6OHjguo+Z19JR83kEP02QRZmu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696076; c=relaxed/simple;
	bh=KSsYzrOROHvpveELtj2P3rV5KHC8RF3TgZLr336dA44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idxtxS4spVonBBI4lAGXb8yeez0vs3sqqfhU1Wyey9Fq6Tx5Q+rC60frgqNwTv9iENJjFazo4lyaBzuw53caA3vxNcyHa7MrZA8p8Gp+0tALWV8vi/gVGwQITUT23+9zcwDZDjiZVJWgawHN1R2csTCPXVFFcZ6bRzwI0JK7QFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrID+pVC; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-940dbb1e343so20484439f.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761696074; x=1762300874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKrUqAEKrt2jMEwY5jFnhV9CSrg3ZApnj6UHXbNZRz8=;
        b=RrID+pVCWCPAIACb78qHpH6TcrDqJKijYBuKIZosdngHuTXgN0lVOG1tjxbeyCa7SB
         PfEQCYoJjUyR3xeu+D+pRTyVoxr7zzKx+9J2ExADi8iF6eUWNmnmvYyiw+OtWnct/uEj
         GxsxQsIgIHGNmrY/gSNL10SMAM7B70hpWLav6D67HJGkO2DlOOqiuqKAZaJ9dRt8wgYv
         4NMQv73htvfJCUfnbGAOqK+KAfkZPqKPYZnuR0ynMDo7hy6qUUeSWik7X9FkQDeFuxj2
         fFHPfpcIwiKKwGKttHdVRqbRxkHft5uMJxfp827CiW6AXzNVesdY31EuiwtqGViMBzo+
         vyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696074; x=1762300874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKrUqAEKrt2jMEwY5jFnhV9CSrg3ZApnj6UHXbNZRz8=;
        b=oip8mQILDGUtJv9999hSeXqMUKSqoTPwMyWhOilzwqD15IPZY2626huXAw6Ev1ijJC
         qiTbs3JBumZP1GPKrEKwnQHaV+n4JbyBCZ0B2ian06rpH2w3G6RT4bTnXNCjpGgCX3ee
         EWF3+K0ulg96yigZD0UBADtH3jtp8ZO2Z1+/PVyJNVFvwwo/DBOfWkLNsatqDb2nIYV5
         fjgz8nA/h194Xc3i6OEUndC7YpNgyL/64vRRfpGAWrHtyu9Zcq7qzNDyx67/k5zCrCIl
         dIELANlrujBMWjm+GE5AWgYyBRiK9k12oyGPOf/M6gAxfK+o5y7O+hQ3JXvwGV9YrOXd
         UqSA==
X-Forwarded-Encrypted: i=1; AJvYcCVg7ngQenLsjxPZjFNzOGqQSpH9lrZQ00jHtgmk7wWD9LBUYRVgVC+zYvMr6krsXL7JsSZJPNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxL1Uuu8ER5kgXaTG4DIjXC5tXcLANamZwaM28GYKH7iwtt7r
	zEnVxt7b1bzYrK+mviJDLZFNk66g4K2pJol6vs9g9L8tlR+wGiiiD98/ZIRQ9g31aMAZSMk0Cfp
	IroL5tt9wk6ZjTbX10GzE7YHYzqBeJDQ=
X-Gm-Gg: ASbGnctcpdQLz1IV1m/UzPq4LYZnQhhYhamKfc4NrOAF7BPEqM7eMJ7SbPBs3Xneyyx
	OFsH33mQsAS1wY5tsA8M9x2Fsg3VhqmIpolOPO4l8/V33kKuOevQGq2Ts5bYc/Yl5u3bHN88udl
	LRJYV7njzgvPWJwcwsxSVp6kl+/3UDf5uV7pXUdKlHuGiSgbpQC9ggM4L8OsgX35zJkg8eoxl6P
	AvsrS7pg3jLSOgCU99p4MbZzyry5dSJmFq5lZa85TMNjybzkcX+dGomYv8=
X-Google-Smtp-Source: AGHT+IGgLc96ZMr6l+/NUQL1N7IsFmNZTxHwZhGsXXdYttZwvnG2iOf3+nncQ6djkp1cF/5AZXtX8idEXUBgTmL2Y14=
X-Received: by 2002:a92:cda5:0:b0:42f:a6b7:922b with SMTP id
 e9e14a558f8ab-432103d8780mr67405685ab.7.1761696073792; Tue, 28 Oct 2025
 17:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-2-kerneljasonxing@gmail.com> <aPt_WLQXPDOcmd1M@horms.kernel.org>
 <CAL+tcoDnAv7+kG4WdAh1ELP0=bj_1og+DdD-JS4YuWzZC+9OhA@mail.gmail.com> <aQDW3HK6bx2LgfBY@horms.kernel.org>
In-Reply-To: <aQDW3HK6bx2LgfBY@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Oct 2025 08:00:37 +0800
X-Gm-Features: AWmQ_bnfQud7JTOfOAs9f495lJaHp_F0FO0O7ztnBuAzpwXum4nybDK_Fz258Do
Message-ID: <CAL+tcoC6AAB3Ag_LpNUp6_WLoNziK4Du0=wtPWN8hm_SbdRSaA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:44=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sat, Oct 25, 2025 at 05:08:39PM +0800, Jason Xing wrote:
> > Hi Simon,
> >
> > On Fri, Oct 24, 2025 at 9:30=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Tue, Oct 21, 2025 at 09:12:01PM +0800, Jason Xing wrote:
> > >
> > > ...
> > >
> > > > index 7b0c68a70888..ace91800c447 100644
> > >
> > > ...
> > >
> > > > @@ -1544,6 +1546,55 @@ static int xsk_setsockopt(struct socket *soc=
k, int level, int optname,
> > > >               WRITE_ONCE(xs->max_tx_budget, budget);
> > > >               return 0;
> > > >       }
> > > > +     case XDP_GENERIC_XMIT_BATCH:
> > > > +     {
> > > > +             struct xsk_buff_pool *pool =3D xs->pool;
> > > > +             struct xsk_batch *batch =3D &xs->batch;
> > > > +             struct xdp_desc *descs;
> > > > +             struct sk_buff **skbs;
> > > > +             unsigned int size;
> > > > +             int ret =3D 0;
> > > > +
> > > > +             if (optlen !=3D sizeof(size))
> > > > +                     return -EINVAL;
> > > > +             if (copy_from_sockptr(&size, optval, sizeof(size)))
> > > > +                     return -EFAULT;
> > > > +             if (size =3D=3D batch->generic_xmit_batch)
> > > > +                     return 0;
> > > > +             if (size > xs->max_tx_budget || !pool)
> > > > +                     return -EACCES;
> > > > +
> > > > +             mutex_lock(&xs->mutex);
> > > > +             if (!size) {
> > > > +                     kfree(batch->skb_cache);
> > > > +                     kvfree(batch->desc_cache);
> > > > +                     batch->generic_xmit_batch =3D 0;
> > > > +                     goto out;
> > > > +             }
> > > > +
> > > > +             skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP=
_KERNEL);
> > > > +             if (!skbs) {
> > > > +                     ret =3D -ENOMEM;
> > > > +                     goto out;
> > > > +             }
> > > > +             descs =3D kvcalloc(size, sizeof(struct xdp_desc), GFP=
_KERNEL);
> > > > +             if (!descs) {
> > > > +                     kfree(skbs);
> > > > +                     ret =3D -ENOMEM;
> > > > +                     goto out;
> > > > +             }
> > > > +             if (batch->skb_cache)
> > > > +                     kfree(batch->skb_cache);
> > > > +             if (batch->desc_cache)
> > > > +                     kvfree(batch->desc_cache);
> > >
> > > Hi Jason,
> > >
> > > nit: kfree and kvfree are no-ops when passed NULL,
> > >      so the conditions above seem unnecessary.
> >
> > Yep, but the checkpatch complains. I thought it might be good to keep
> > it because normally we need to check the validation of the pointer
> > first and then free it. WDYT?
>
> I don't feel particularly strongly about this.
> But I would lean to wards removing the if() conditions
> because they are unnecessary: less is more.

I see. I will do it :)

Thanks,
Jason

