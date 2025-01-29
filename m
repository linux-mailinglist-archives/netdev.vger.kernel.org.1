Return-Path: <netdev+bounces-161539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B5A22280
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042BD18823A3
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3B1DF977;
	Wed, 29 Jan 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4u3z7LN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779842A8B
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170290; cv=none; b=lHvBFycIigY6wIeiLY9hXwC/dczuWOwi8PXTXv17ZAkLXuYcvgub/tA1BYuXZl47AskdGE9bf8QFDEEmLbqPRNophOvK6mrZBgJSvi4aGIKtFhSuDKR4McPz12hcLsWlOo8sy5V/fYypO7YXVUYUFdFAwXpJ995olA/6845wyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170290; c=relaxed/simple;
	bh=9PJwGCb/VZtui3L5qOUGJQP5Tb/QmMsr7V1Ii3+2xZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOzCkk2ND6hWT7watLggPIIB85vtWRm9ei6jNojCrOWol3rGUQYOEVJO2Rcrd8V6iC5RBczBSbD+max0bdi4VXV7kUMHGVZkrFSclxkomGXgFffTzT4RB1nirEl8x+sgv256mIefmN0fQh2Z5jud9ZjozYFk8erhEqQrOppG0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4u3z7LN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so375391566b.2
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738170287; x=1738775087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PJwGCb/VZtui3L5qOUGJQP5Tb/QmMsr7V1Ii3+2xZI=;
        b=g4u3z7LNPqbJjKQpdEy8z/rFBhvtjavhbJLQ5FCwL7qEiC3aMOGzn8al3NQ/QK8ZwW
         FOnuPeqR3LSelWWGCEvTo/fSfDElJA05KButuE5W8Zzh9toWXMaq8lXiaeuPOGGCf7Y6
         6HlgsHEZUC0xvGPMciuOWO+IRpefHqNDGyQPASo5Zsakper4AwhO6a8u2CwEI9Onz30N
         hbj5xPbgweKd3Y0jVnXjT6m9RpqekhI1xIWJxMBTSLXNX3jMsyCi+CSKEpfZaMgJak9G
         YlETPKuXMFVT/7Ldp7cBgLR9lIPuIoiCgcsdltTgtEGhXfGrIJPlJwIE9F3vq5GRBn2F
         pQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170287; x=1738775087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PJwGCb/VZtui3L5qOUGJQP5Tb/QmMsr7V1Ii3+2xZI=;
        b=XO0yqLYikjiuqCfTsU5C2I6DQ4BbBZg5adafZ7DxaNo4b0v3JL8KQSuEiM80eJSomb
         TnH+eUgTpPEDOLns8A4xkJaIZAFhxFIfM9IJIXgTxObaHSsUy0Y83T1TPZn1gvWGd+3y
         n+uQv3blznLJDDxHTES2n0qAtbVOYloiHcBdg/8FbC8xPVnRCnVRnNPRgbdDnugmBxNR
         cJHnsiHtSa3Eg4j5Q20CDTNTbt7DpBWqNe03Q9Us93M9LDzpWtZlI3U/ra+s2xkwVkoN
         1JH+5vJQXelsYedxLjPJHNImp7EgO2cozMacYeSHZTAggQBRKpQDvGsC8+BTbpb4KtfM
         xKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc0ZCBSvdKBTsxIfOA6Y//lclqjmsyJD8+9hyrRv5yvuspQPHbbKHp49tm02K7NKh+LzmdDB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhx/WehdRYBYmIb0MHVmawnAabukqmypkwbWQQLbRaHF5kpon
	oJcsP8VIkAr66PMDOLCiEajelqWJUp7QaxT9fR0BU8EwIaUveungcbTaK7Tw1UK5uKdLrojBjwj
	W0Bm/knyhyxSJtZeJiLuCr0YBXLdRVDkN6HjG
X-Gm-Gg: ASbGncvaP5GYiyx7HmKD1+LlSN2xD5eWjPSTr6ks5x9TTtY6tLR0Bf1q7KxTXRND6Bv
	GDj+eCjmIZa9rZKKIwKHVVBQUPsmfE6LVetrwJozpaqbfzqkZy0xedHwZUAhNUaFiNVpxE8g/gg
	==
X-Google-Smtp-Source: AGHT+IHLHkXsWut7BzXrQMri1ku4+1hvDnjq1NpY5CNowtpBL4K36ZxrfVTI2qDZHw/4EUK6S9GgHqxVzFuakahPW/A=
X-Received: by 2002:a17:907:7e96:b0:aa6:a9fe:46dd with SMTP id
 a640c23a62f3a-ab6cfdbc619mr382747466b.38.1738170287102; Wed, 29 Jan 2025
 09:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com> <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
 <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com> <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
 <13345e2a-849d-4bd8-a95e-9cd7f287c7df@redhat.com> <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
 <CANn89iL2yRLEZsfuHOtZ8bgWiZVwy-=R5UVNFkc1QdYrSxF5Qg@mail.gmail.com> <CAGXJAmyKPdu5-JEQ4WOX9fPacO19wyBLOzzn0CwE5rjErcfNYw@mail.gmail.com>
In-Reply-To: <CAGXJAmyKPdu5-JEQ4WOX9fPacO19wyBLOzzn0CwE5rjErcfNYw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Jan 2025 18:04:36 +0100
X-Gm-Features: AWEUYZk995CLzz3ysTjvOmGnb_Aca4bIJlC13qo4wM7naSfODngXCohgdj0gTmo
Message-ID: <CANn89iJmbefLpPW-jgJjFkx79yso3jUUzuH0voPaF+2Kz3EW2g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 5:55=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Wed, Jan 29, 2025 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jan 29, 2025 at 5:44=E2=80=AFPM John Ousterhout <ouster@cs.stan=
ford.edu> wrote:
> > >
> > > GRO is implemented in the "full" Homa (and essential for decent
> > > performance); I left it out of this initial patch series to reduce th=
e
> > > size of the patch. But that doesn't affect the cost of freeing skbs.
> > > GRO aggregates skb's into batches for more efficient processing, but
> > > the same number of skb's ends up being freed in the end.
> >
> > Not at all, unless GRO is forced to use shinfo->frag_list.
> >
> > GRO fast path cooks a single skb for a large payload, usually adding
> > as many page fragments as possible.
>
> Are you referring to hardware GRO or software GRO? I was referring to
> software GRO, which is what Homa currently implements. With software
> GRO there is a stream of skb's coming up from the driver; regardless
> of how GRO re-arranges them, each skb eventually has to be freed, no?

I am referring to software GRO.
We do not allocate/free skbs for each aggregated segment.
napi_get_frags() & napi_reuse_skb() for details.

