Return-Path: <netdev+bounces-127636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C7975EE7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15A31C21D0F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F23CF58;
	Thu, 12 Sep 2024 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/l9Jml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00653A8E4;
	Thu, 12 Sep 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108196; cv=none; b=srvQypltVXEb1vmxjfND+wZjwKaFA+K//hh5LL1DddoOpgC5xae72d9rRxrOoTOILdZtBGFqpMDOFf+UjKNPNfbEswf44/UOXfexxZGsT8lrd2xTIz41a/SVBpRcQsf9KCNnKX02kSTgHownmy/o3vBiV2kCNqaZOPviNqWiVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108196; c=relaxed/simple;
	bh=t08umSXdAuGeBddaW526nzG0WyKi1PzANkSvIgym6lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkaPBfLQgLoJ24Dhe8jDFnF2L9EbMjdOVvr1X1zXB/yiz0kMxMl349l1mVMZf7GKj8qEuZU/InzE4OD/VC7cmg5alfaQhFOs/yE3E/PSxUjmJupFtjZRNK0QEPIjUtfcYAY8T9do9hVMDdhSS+RRSqsG5EPOX+FJSUeenj5tCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/l9Jml; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso541873276.0;
        Wed, 11 Sep 2024 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726108194; x=1726712994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWRMmHm+FfWDYa8yX01QI6M1EYeU0fnEELtdBrM9ofw=;
        b=H8/l9JmliZTmlC+we2Zfp06Lp2UrmFOGlS6F54zAgPWgBjyn+sjEPnakdWsOz/1X/E
         H2DH3SNIxl9jMvawXRBTZdZz3FJQRTukVtdyaGGHodE1nGCoDp41BJ/PdnKjFwmmxsSF
         YTrHH5LXojpqTUm7vBEBvxNJF9p2/VLq2aLxqy0vJg7hxIsvYd7KeAz0B5FmXRt8KNVG
         0wwz9szRDZ++sKQS6KUkUrO44x5pVw8Rx9S2v2xAaTxFQQKWBo4RQosADh8Rud+wqlSl
         4Y1oiNnx1CwJlKiWk8aVH63Cr4AVBkRTYljydCndolO5fqmcA2UYlAwWWLb51QMuZqX6
         XQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726108194; x=1726712994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWRMmHm+FfWDYa8yX01QI6M1EYeU0fnEELtdBrM9ofw=;
        b=safbRqW3fhqRXoCDMFhRPS99pNZdktiAoslR1Kz8E4EYo89OnTMunwwWM9sI+A+Kx8
         7xx54GiJCM8losy+/dKwYQ+kqCnj1AFBvDjgMLNp71+fDSsB4LaUZJU0ANaz/v4oH6Jd
         dsVE0MVjCX8YM001GzaYsSfusgAeXrzM9wQa/u5Glt+iFCFs7te4/4mPfl6oTpVdgAkf
         Htu+CkvsnICIqL66R+caOnKD06dde37dXMZR9B6BBCUV1L8Yku1UduIt/93e04mci1xS
         hn3jzHXAjbp1N0Y9wJZzQc4cBMftmDAHmujMNGbzAz2tqOs6DoOrtdkffSTIvQYAySW1
         0mCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuJQXwISg8SS14x8FQby0LeewyCUOFU3sW7t9KYUOvZka6rtSuW7o10frYPu1SpHF1hIMku1Q5@vger.kernel.org, AJvYcCXGcHXeULT2RABVOhGeMLzpBTgDgE+jsAgKfI8obY3SBj0RvAG9RIYX0FLB1v8BLspuCDZN6Iul5qSvmIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyHR37bLxSYdaHUyBmJYWEVMVJ1nLFAtLU4ptvVFzjIHsn/9C
	YzWayl9PptRceG3rppXn7plUbnMp9uxw2HLns9mYo8G4Iu4X+IDpRsDa0WEu7e30I9FejEL+DCp
	0PO/kf1E7jGhy0trsvjPuMKrDAMk=
X-Google-Smtp-Source: AGHT+IExPuoKunfojdj2czxk8KU+K07L0H57eNKlbS8wQqYKtiU+V90C/1MT/sEzKtMGaP4J/Nqfdiu31017kjeWy/M=
X-Received: by 2002:a05:6902:1149:b0:e11:82fb:70c with SMTP id
 3f1490d57ef6-e1d9dc6624bmr1844103276.51.1726108193657; Wed, 11 Sep 2024
 19:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-7-dongml2@chinatelecom.cn> <ZuFP9EAu4MxlY7k0@shredder.lan>
In-Reply-To: <ZuFP9EAu4MxlY7k0@shredder.lan>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 12 Sep 2024 10:30:01 +0800
Message-ID: <CADxym3ZUx7v38YU6DpAxLU_PSOqHTpvz3qyvE4B3UhSHR2K67w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/12] net: vxlan: make vxlan_snoop() return
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

On Wed, Sep 11, 2024 at 4:08=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Sep 09, 2024 at 03:16:46PM +0800, Menglong Dong wrote:
> > @@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
> >
> >       /* Ignore packets from invalid src-address */
> >       if (!is_valid_ether_addr(src_mac))
> > -             return true;
> > +             return SKB_DROP_REASON_VXLAN_INVALID_SMAC;
>
> [...]
>
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 98259d2b3e92..1b9ec4a49c38 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -94,6 +94,8 @@
> >       FN(TC_RECLASSIFY_LOOP)          \
> >       FN(VXLAN_INVALID_HDR)           \
> >       FN(VXLAN_VNI_NOT_FOUND)         \
> > +     FN(VXLAN_INVALID_SMAC)          \
>
> Since this is now part of the core reasons, why not name it
> "INVALID_SMAC" so that it could be reused outside of the VXLAN driver?
> For example, the bridge driver has the exact same check in its receive
> path (see br_handle_frame()).
>

Yeah, I checked the br_handle_frame() and it indeed does
the same check.

I'll rename it to INVALID_SMAC for general usage.

Thanks!
Menglong Dong
> > +     FN(VXLAN_ENTRY_EXISTS)          \
> >       FN(IP_TUNNEL_ECN)               \
> >       FNe(MAX)

