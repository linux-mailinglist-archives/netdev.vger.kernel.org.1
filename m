Return-Path: <netdev+bounces-129829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9079866A8
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAE81C214ED
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA713AA5F;
	Wed, 25 Sep 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i98m374d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569B219E0
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291338; cv=none; b=MSa5nl6VeBxZg7jUW/hE1F725NjvRWwW+bHWJZBV2iqtSb0KD+Mm8fNUYYrpaQgtdvmGas/dtpzoVyhxTNwJgbqBD7NZ0SbgNemVX7PS5SVSPD0/e3JvMFNQUciUDSkPLwA/bCbILGIAEDYjMyJrAPfuCthUbDKjKoDn9cq10n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291338; c=relaxed/simple;
	bh=UJiopwuZsQHsB3mtyoZASiXhMO0AaI2RbHUxgc2yw1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ly8N6BfzyYpcTuSj61P4E9rEniz/aEBh5bv3++5pMvIqa/iQK/0cPxjRPYtfA9mtIv/hOPRknpUQ+wZLGE73/RsQTIx9wJhDl3Q4FWZqV/2OJ1ZFXgmVuI/XOd/14Cb43Wp+S0AggKnkwH0GZbHlaXerhxf7QVHy/2vaxRlCkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i98m374d; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53568ffc525so279047e87.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727291335; x=1727896135; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJiopwuZsQHsB3mtyoZASiXhMO0AaI2RbHUxgc2yw1s=;
        b=i98m374dsK3h4+AQufBsdJOaDVwZZkYZRNCh/0jh8tpwCixhJd9AbMRAlOzZr3EzJS
         8jVt3ect1Y8d8WEg81uw/Kd5eby/xB64Ox/9okdXqcfPhYXN/Vv/LrgG2KOxEPBnzwLn
         Efl+yENM0ggUjGc4CblEmSwAR8frne3DDFbWaILfsge7G/iBktSIv4CNO9/Fc4/JgCtF
         40DWGf5vULV2oBhcVVcxBDA5Nn/2471kpdDDjtE14fNaHa11dWJIK4MzETkOkoUwfKWK
         26QJM4R6ab8aUpMTLOsZ5n1SINm+fdHDAdtjDrxvHvGviaWdcED0iWP1nQQ1GcE5cJR1
         F6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727291335; x=1727896135;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJiopwuZsQHsB3mtyoZASiXhMO0AaI2RbHUxgc2yw1s=;
        b=SVC+5b+lR94ToR5gPH1O0D3OIsuo/AvJoBBaql1jMtTV14tXuRuCqw6O/3rn4/Zfg+
         hIOGbV0LIDYliVJi9zGhuG+jYlbUUis/7Xj2D1+pv7AFiFWbpvZjyjQBpJdbatU8KoGt
         s42BGmYU1jOZj2MiElM8g0RUyBmEEP1eFnuSBmTf8Sw0BPTXTyJnxXi2FfhZzFttnobr
         WpW0hA5j4gplVI7CKcu++XVDoJmfw8wVP+DT0/MNvgbhAHKGHlQjfQk7c4eZYogkytBJ
         ytYa49cY73ZpbtLhEliO/UWMMeCbm6sWOO0ZBrnAIazQfIw8+0nKHP6diqYsrqoYsOX0
         Cdwg==
X-Forwarded-Encrypted: i=1; AJvYcCW6DXjPBsXo0t03e1Q5zOQ5AINzSWzQEPKQIKh29dsiffJKhISpiO5pdzS9onuQ2lkPwLbW864=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQwSc70JkFr+eVy2JPabMfxvMKcu3OaLoywNDRYps30gOOynU
	4WMsS13mQZqGfYZDxyx3sZpPhY+rkuNg8qNManOd8e4P4AVzoGH4tHNmt8EauHLY06mXBWmtICr
	BMjmyvJrd9OBpCNi3v4/SPSPwDPZKUCgT4AIA
X-Google-Smtp-Source: AGHT+IEHdkH9L3bzVK0SzDNIIEtTypCtQWA2O2Ckqob790H/DZfbNiXEJ80AqUUhT8x+PzfyklAKYbox/z+9a+1sy1w=
X-Received: by 2002:a05:6512:b1f:b0:536:54df:bffc with SMTP id
 2adb3069b0e04-5387755df0cmr2621139e87.42.1727291334744; Wed, 25 Sep 2024
 12:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924150257.1059524-1-edumazet@google.com> <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2> <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
 <ZvRVRL6xCTIbfnAe@LQ3V64L9R2> <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>
 <ZvRfVKoPsPnPMpoW@LQ3V64L9R2>
In-Reply-To: <ZvRfVKoPsPnPMpoW@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Sep 2024 21:08:43 +0200
Message-ID: <CANn89iJ_9OdDr9N9OSoU_DF_vSMran8zPpfQaEY48bUVqcDSJA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to qdisc_pkt_len_init()
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:07=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Sep 25, 2024 at 08:55:16PM +0200, Eric Dumazet wrote:
> > On Wed, Sep 25, 2024 at 8:24=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> >
> > >
> > > > git log --oneline --grep "sanity check" | wc -l
> > > > 3397
> > >
> > > I don't know what this means. We've done it in the past and so
> > > should continue to do it in the future? OK.
> >
> > This means that if they are in the changelogs, they can not be removed.
> > This is immutable stuff.
> > Should we zap git history because of some 'bad words' that most
> > authors/committers/reviewers were not even aware of?
>
> I never suggested that. I suggested not adding more to the
> changelog and also mentioned you could feel free to ignore my
> comment.

I do not ignore comments, I learnt something new today, thanks !

