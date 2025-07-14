Return-Path: <netdev+bounces-206784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CEB045A4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A371A660D6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8932620D3;
	Mon, 14 Jul 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3nY4kX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0A45945
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511186; cv=none; b=UBNltqRoOOdLVMFz1HmRlhN9EG+Za48FSmlrKwd62IHNNttTbydgqWVaSOrf55131p+2ZZejQ7nElreQ1p/NSBbF8OBNBNhxB2jCafERVeYSZGA1sAf9adpfLguxYlwWJsl+PHu/OlHCyMDSVb1BdK4CxrlmiDUTtpUdvSy64rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511186; c=relaxed/simple;
	bh=nVGZfVvmnLc3ZSNSNApCgVpp19nDe5r2+SDjdGuL1c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv7rlVT9SZKoaIncRldb9TV2gX77TpDcjaZR5T8pBtANlrTpyp3SfC6ViU7t0+5HIxWPCAyRuT80aXnDmzOHMbZA1YbdLGmwXAn1IldseDP3EmC3ioFKZoq6mnz5leMqV/+9J5ZRLAubsX7csZX6Sn+VqA+q1EXYtgCX2VUSkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3nY4kX4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so4155526a91.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511185; x=1753115985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX+NdQT2VcB2DI7YKmKSFArOzHaTXAju68p1bOFs5qk=;
        b=m3nY4kX4hjZTfpE9chtiQmSDABnDeqF8w8Qr3/cajLstFh1v/xtfq5c1zQxHQ8vxI6
         nwwbBka3PKsMrwcPXNwD8z/XFvlVjnFkVD/PNLl9FmF3mjazNAnqlguG1tmsRD5w6lKy
         eFsTsYo9jWNqfMqnzKwHemNJOg22A0rh63wdViyVEixt9jssjJwZOBtJFrJS12VLOHgC
         6RJKKgwwkvO7QeZI7HFpZvhKsexdmqjqqprt3o2E1pyLjq25gbLAieIWU3E3/Fk7SjYD
         d9oKu+QaKiGWkeG5t/pr21tOOPjPN/5DJW12O9dbDlW1qe0ZUEX9pBCSiaJ3iV7RyDvI
         Yf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511185; x=1753115985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX+NdQT2VcB2DI7YKmKSFArOzHaTXAju68p1bOFs5qk=;
        b=qUCTO4R3aRj/DQFEDaHcvmWH/l3cXzl2hWOm8GR1X1tKBcOzOrt3mRNuUXeV8HjPKM
         sDdL4SFGScQsPi2+SvfLvY+EFbHAYUS66LchWB3bs0q6POMkpKSwhUP2gLGqgw7gnu7j
         HLibn5Make6leO9IhstIeVyPFILWCJqgQTTRvBaE/JOLn/3P++RENV1qqg/ME3bqw5ko
         Z2b2L+umIESF2Gp/plbe7flr56aJ4bBiGa280Nk81fyRZHxONI9K6K6Td8SHyI6ku9B8
         QbfRmTL/V4IfwM9GLKs8EPugF94bNaDPTBnkzd2MQHSbrZa36Sf94xpQmrw5VsgLZdx8
         Dd7w==
X-Forwarded-Encrypted: i=1; AJvYcCV2P5Tk8cZE9R8btn7sLuPPQqMavzuyPXd7o3wnU2T7eEPcF9LjHjZRklObcamw/DgNVtvFVeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnc0iiZiKJzVFea/8P+Da7KDy/xavyulxwA+zsWR6UW/ZdGy+
	PBCxpFx85ODHX0XeFdbdKwp5f7INfin9XGUnfxsuVvc1v2+PCBVxVu4N9DgJVKtFbQVWasnpBUq
	q/gEpusa3hu9XEUIvRK/JHSD5XTAGVhVPrA0vVlAk
X-Gm-Gg: ASbGncukF0wUzUGGURpaVfRM1GydoMgpViTK9ndXG0keN1l/qLX7YRSvi3Ys/Qcpspc
	tRJGWft22ftCG/5Rd5JSpLlQ6MuJ1u/Qf3L7kyC0Rw55XP6EbkvlTKL5iIyQ8ABqA4Qk3Z1g5X0
	Q8QhYJaevAM+gtjQFWEP94fLF4/8U8rmNuEN97LEf3PYVFo5ggybiEucQazZ02b3aXdLBrhv/BM
	41pibyUNLyVyDVRtAIcqHJ9NFGDAoSkIzvrJPRglSP1gAc4
X-Google-Smtp-Source: AGHT+IHuvzV1B5jmmplYRcd2fSL9lO+HJ9iCoILBY6Q+z+Ye/2f/3tqKbg7MoipTfaHsyTSNRtE3BYb2xb5g0IU2l5A=
X-Received: by 2002:a17:90b:4b84:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-31c4f4b8228mr20540049a91.12.1752511184340; Mon, 14 Jul 2025
 09:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714081732.3109764-1-yuehaibing@huawei.com> <20250714122927.GM721198@horms.kernel.org>
In-Reply-To: <20250714122927.GM721198@horms.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:39:32 -0700
X-Gm-Features: Ac12FXwFDVrP8a5a_KA8U55jsclsAFnwWq_Nmf70ytnDDTXqm8tVAqn6jh6e6Ys
Message-ID: <CAAVpQUC4=c5w4wWMnU+DTkzeuWBnw1uPdFrfn7rDchrHvsGVhQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in ip6_mc_find_dev()
To: Simon Horman <horms@kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 5:29=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> + Iwashima-san
>
> On Mon, Jul 14, 2025 at 04:17:32PM +0800, Yue Haibing wrote:
> > These is no need to check null for idev before return NULL.
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > ---
> >  net/ipv6/mcast.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> This appears to be a side effect of
> commit e6e14d582dd2 ("ipv6: mcast: Don't hold RTNL for MCAST_ socket opti=
ons.")

Exactly :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you!

>
> I've CCed Iwashimsa-san, who wrote that patch.
>
> But in any case this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index e95273ffb2f5..8aecdd85a6ae 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -329,9 +329,6 @@ static struct inet6_dev *ip6_mc_find_dev(struct net=
 *net,
> >       idev =3D in6_dev_get(dev);
> >       dev_put(dev);
> >
> > -     if (!idev)
> > -             return NULL;
> > -
> >       return idev;
> >  }
> >
> > --
> > 2.34.1
> >

