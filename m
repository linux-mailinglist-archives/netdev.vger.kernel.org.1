Return-Path: <netdev+bounces-220750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A85B487CD
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB43D3AFD61
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D852F067F;
	Mon,  8 Sep 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHpLbmEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0032EFD96
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322439; cv=none; b=QUE4qvX50puOFMf3AwtFqmeJgxAMlXBsq9rxqv/oqU5d5t63jj1SoonQruDBu5RNgqH9sV95XNSwhS98qc8hGhOdcqHVcFgNdAMw5e/IdpuUCrk/D7CjTnaAypvhoWdbdzrKb8Ne1tVNUIqCQ3drpIZmi3203sLUjPi/ftEKdbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322439; c=relaxed/simple;
	bh=TfjlXGG0z5FLjNjKAlAUtHBt3K275PETyHD7xxP0JqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnSLKd/eaqdM+wc9EBm1MKxhsBd164LqX1NyEAURgph1AVE4NMtsUs6BqFEDWis5FrDVyY4TUjSWZ/FppYGkrmMGTXK3gmlR0P2obBFFURL4eoq44AqiKqrBOePRCPXGHvjOqQwQTi6uinRvocGOrK1u5ypdwA/KxZgJPUuXIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHpLbmEB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5fb2f7295so16802071cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757322437; x=1757927237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc6d2xJT+7rO5xhcGtQLI+Y4wTR3jsomRWKDey59PKc=;
        b=sHpLbmEBh3ETXnUVqHM4b5EqndUC6MI+vEjgHSpe2vSet7bb6IcWhA34xzBIuFfpLC
         P3VvGij3z0my/AyqUy7mTKOP2NdyiZKjjFEtGvdD1UWuEY5fjvOxUmLd+TKCqIMBY+QQ
         EvFDGeY9pUjXItt4Uealn6KI5sEZGcp5Tfk1LykKMiih59+Se+r+B0VtEm4PU5tEZ/ay
         QyYP7FRH1FI0eetI3yBbuRa5i6Y2lYtr0tMA9QoK4pMmiQXslSXURw7Ej3Ipo1ghJo3J
         UY79I4qRDMudNFPZWULTaQT0SFz2u/8nff+HknGG3RpyFJnKsjbeEPnMYd2yvGub+nmL
         nw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322437; x=1757927237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nc6d2xJT+7rO5xhcGtQLI+Y4wTR3jsomRWKDey59PKc=;
        b=CyxjWuP117fPYmYjpdE4uHJeGOr/hbeL5q/ELD16FivDsqq6Uiq1OPmZfDOCTCd3PI
         d7KJ/55JY+akLi/k3qmbgEy58CMnbwybWnxzUYphq5ZbtCwBhy3vwti/csTDMl0AWSbN
         0rXAM2TBfYXA0KZIKNWCdJzmeZfyRXwJEv0NslVB3e+S+IMbI9hCzFZK316P+7mcf/Mn
         XN4asgr8wYU06gCji9xN6VTv8TgSUN5ftUhX+SQsACM+I244XzOpiDp0UmE2t29nVp2H
         uBt60s7hsOI9qvIOHy18ER+w3ZNJ+G/Szf1rUf6kGk6NYO9dvUxPF8YCjz9P1gnguAek
         Ddng==
X-Forwarded-Encrypted: i=1; AJvYcCU1vyPMFudzFl50VKJj96ydfZzV6nffpqIdvE1TObkBUyOUJNfXV0ZPpgnPK5Qn/adVYqcz6NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMf6wgHaxGvzDy1Arl0theN5eX+eJRLgtutX23tPk6Y72JyqWe
	f8hIbC0TrRUeL7LltgWILwpCV5YzYej7Fj3m+t9XH5ah/KyHW51IPMz0kYgAoNX5CLuveha8cgP
	8p/J6h1AYsyjhv62kS838QV5sNziASNM71S4oYApN
X-Gm-Gg: ASbGncuZtf5YfDpkJdM1nDjHbQxCjo3btwWS5LRKnL5gkOlcMmeOvuSV8H0aOOwao04
	mzEY9nu5KXtJL67pZsELsKfu3A0ncYEMMZw3KKQVqg5WZaKdmE9zC55ih3lpHQ3nmHkO4ZaaYHL
	4UWKmw2c3Pw/wbx3ssyLOhotSQEYF7Zc8kodEaL0VGXbCgKjx9sEtZqv3mKPnJpg8u2C1WXC/Xx
	nJ968VRnq2DIg==
X-Google-Smtp-Source: AGHT+IH70yEY2mD+Da9VfBC/BGhMy1BSMWeXgwdvkJRstrAo8GGMJXYIVhFKhXW0wz/7Iipcm/G3lGVXveb52DY4HcE=
X-Received: by 2002:a05:622a:180a:b0:4b5:f59b:2e7 with SMTP id
 d75a77b69052e-4b5f844811emr81065361cf.9.1757322436444; Mon, 08 Sep 2025
 02:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com> <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com>
In-Reply-To: <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 02:07:05 -0700
X-Gm-Features: Ac12FXxIur2KzUGuY-o3zxu5ad5O4y1neb-cgZgcxAKaEuWlDfe2OI8kd7LHND8
Message-ID: <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, davem@davemloft.net, 
	dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2025/09/06 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> > On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> >> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
> >
> > Note to NBD maintainers : I held about  20 syzbot reports all pointing
> > to NBD accepting various sockets, I  can release them if needed, if you=
 prefer
> > to triage them.
> >
> I'm not NBD maintainer, just trying to understand the deadlock first.
>
> Is this deadlock only possible for some sepecific socket types? Take
> a look at the report here:
>
> Usually issue IO will require the order:
>
> q_usage_counter -> cmd lock -> tx lock -> sk lock
>

I have not seen the deadlock being reported with normal TCP sockets.

NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
from __sock_xmit(), and TCP seems to respect this.

