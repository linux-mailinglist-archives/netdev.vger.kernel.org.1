Return-Path: <netdev+bounces-233745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54517C17F03
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE9A1C65373
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997A2DECA1;
	Wed, 29 Oct 2025 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn/50x1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95672D94B5
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701846; cv=none; b=M1kKQR7Seh8hWjYUTgrofLfLwF8IzG740tOSIMralPok+VskmlTK7+fbPH5raxpCAFif+yrvriX7YGW8SBukg24Hlr82kZWnjAv6RsjQQ75aIALkCj8qG1eRurG+f6tRmU9nTIfngybR4O+0GYMpV6PQ6Zz599bMDMnXtmjZ9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701846; c=relaxed/simple;
	bh=zcE89Qfzpg/a8Ic1pSZI3SQfTyKmPOCwz5Hme+dQsCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz0P+l8ij1h0tpfS+XEJ+toa1a+cJoL+hNRlhHyuLElO3onf54Z/gTlbJ4JJewj7DNFthiEFXuyuTatG3OFsWGNuI9xVQ9Jt58+PDzvMmF0wy9fm9M7aOjwS+4cCl7eLuErkC/9/YtmP4AXWbOpZG9H2s4AmWwnuklLWbiLUds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn/50x1L; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so281790139f.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761701844; x=1762306644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3/zTtHXFt9g714ZItEP4tvd61nHhi95RvsnW2TZsOU=;
        b=hn/50x1LN2xpR4o+d1uuXRVOUkNhlQzUw3xZfLoR7qA+UDDfWSeBSnZHSujawYc7V6
         mhcRetaCW4cQg9iQ3OTIgzku37jBOzA7gUSCRiVJ2wmSpeLdytO2VXDU3wDEnXytF7aO
         BPYVW9GWAMOs2kgRzfVGUp8DT5Se8tZY91C9199fIB+V2EMW54TdQ0Tc36zYsypqYbqf
         15B67+BQeAb4g0rbP9Ewp1YNOdw7qakFS/VOkW2wDwW4YS2oXd+OMvwgtOX0tWb6Dude
         wISPbEAGZcvfgzrEq7xH0bYi8hY8lfULRn8ehfrFCxmf105cW2h4OdhMHtqlEh0F2aWN
         r27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761701844; x=1762306644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3/zTtHXFt9g714ZItEP4tvd61nHhi95RvsnW2TZsOU=;
        b=cdXirCcK/hJN3WfKlAIN61kae7UjWegzv1gYaElgCAvzdq+pFtMWd514R+aw6lMHuA
         hoKwkwAtPghOz6KkyhA5vnvewaDw/52bCLHesFjgnmMbn6dRMRy7B9m8jFvrPn07LVny
         CVoxCqlU9Lx0p8rWfPMdUKiU3079a33RXfwANyRJIaALa7KjsZcHqKnLgIyodnQLjU9d
         CMeZa7AcscGFV2Kjg8VNz6cxVFkbtZUgnMxFzIKFuoum+E2RGzRHUxKYbI9cYpPzRpE4
         Vw7yKoZpeWH7NAOndR/xG6c+O8T+SeWHh0G3iav89y72nBvNdcCR73G7bCTSVrWRPpO0
         T6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUgAbn8RJCbTPcGJxdVAxlSGySXiFvm4oSTKkkinyLzazTDgQf1HvbAqkBwu34VlIvgdxcKO5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLHc7R5IRu5wbY3kQ17/UkurnuXAw7LvJQLD9xp0K8rK9/MIy
	YAOs7EGctMjahxfgga9A8SXjQDtp+EsVdP1D2+YWspdxkhce6UK7zwYGtIi6VRPQjHkpMKTUbs7
	Rw6OZ2wZl7eh69ardKrQfi7xHoxE74PA=
X-Gm-Gg: ASbGncuJBx0PLI5bTrgLlaEqd7HPcQ6e/u/YyysjrQOfDyEFnj99tyMQdSNZjbqa5bR
	l3oNnIAloecebW9n3/o/8JDDjxjbLou7yfbCVyErOhaZqKu9JRwDxbFzo+PDoWT1EX2qhEg10EV
	99FEm0CCZEs9SsIIgi2933x5BM6NWXQK8CJXvrFaEwbo57jbRilvbClRf8LoYv3MQIPP17RTN7p
	V3uv5fl2KuVbQyFnCDQvF/pLcGml6rUHy0L0yKQnzMxni8mIdcGv36fnWq2
X-Google-Smtp-Source: AGHT+IGbWpCA71HkuR7oTqa22GcL0bg9YQlpIglFomWMKZV3mrbvcuAL6aKEYrdGScMS93ygQSm1nWdSdxNKw6Zviyw=
X-Received: by 2002:a05:6e02:97:b0:42f:6790:476c with SMTP id
 e9e14a558f8ab-432f905fc3dmr20080875ab.23.1761701843727; Tue, 28 Oct 2025
 18:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
 <20251025065310.5676-2-kerneljasonxing@gmail.com> <20251028172903.677f46ba@kernel.org>
In-Reply-To: <20251028172903.677f46ba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Oct 2025 09:36:47 +0800
X-Gm-Features: AWmQ_bnEufjN7yrxinjG1cqV4mzmcqDGdKn-kje9_FXsPptovuxlRGztF4a-4NA
Message-ID: <CAL+tcoDJ00BzKAta6=M0K9JkoT80DVkSDvevGug28b7RrTf6hQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool is
 not shared
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 25 Oct 2025 14:53:09 +0800 Jason Xing wrote:
> >  static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> >  {
> > +     bool lock =3D !list_is_singular(&pool->xsk_tx_list);
> >       unsigned long flags;
> >       int ret;
> >
> > -     spin_lock_irqsave(&pool->cq_lock, flags);
> > +     if (lock)
> > +             spin_lock_irqsave(&pool->cq_lock, flags);
> >       ret =3D xskq_prod_reserve(pool->cq);
> > -     spin_unlock_irqrestore(&pool->cq_lock, flags);
> > +     if (lock)
> > +             spin_unlock_irqrestore(&pool->cq_lock, flags);
>
> Please explain in the commit message what guarantees that the list will
> remain singular until the function exits.

Thanks for bringing up a good point that I missed before. I think I
might acquire xsk_tx_list_lock first to make sure xp_add_xsk() will
not interfere with this process. I will figure it out soon.

Thanks,
Jason

> --
> pw-bot: cr

