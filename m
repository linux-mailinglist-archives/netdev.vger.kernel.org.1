Return-Path: <netdev+bounces-57054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17440811CB1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C341C21135
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6E25743;
	Wed, 13 Dec 2023 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="s+BIkmE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F69D0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:36:44 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5e25d1d189eso14345327b3.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702492603; x=1703097403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LV7HxdseqDQxFYWwOh7IHUm2T6Unjch5zzPRUEIi6A=;
        b=s+BIkmE8MQAzI9BvP6M7b2/RiGU7Vp9GOs+9f3fLk5pGbEV2mFMKvDHZ5IBswOVMiS
         Bai4vQ6ypIrvybGctThhIMe/PB6XGHChW8KzuiAPucf4vmf7+JHSz/LcE5YebIPCKPUh
         EG4Z/NZBeHFznfBHtHWQZ3Um0O5mXTUMueKwmrmNuR9yb3Duo84yvwA1Cv6HUj2oEbYU
         a/kYmdJsLTi/uVmh3TNDDQuTmxOg93BQSgk+uwszfNQ1yPrfr45Sa2z+d5vVk3PAPspq
         tJAKYlSmCoNRrs/tavZcrgej4N7sQclybtA3fPF6gvzptj72t1KHBWeD2QpWgd4CffnA
         dXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492603; x=1703097403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LV7HxdseqDQxFYWwOh7IHUm2T6Unjch5zzPRUEIi6A=;
        b=CkeWuWyiATdc3J8YDd08VrbeCGsaILJXrlo1Pp9TrOwxKlhSbP8vkLCEwY6qtg0JUB
         gobYAfCI/cs6IiQ+WQg4gqlW1onLX5pATmbaz+wsf69hWQjgXhlj3nhqulffCZu2tHPc
         kxWlQiC8sVYNrHkxdc1/ZnB8SZg8dXkK2lE8PAwsA1jGP9WWCd6YB0vm1Nk3TfKmKN2G
         6cLNjmzqTC1daDwG2q88PlNc/AmefcPVR+lxyz98WGnSUvHF/qbAFZkFd13guxMwHa+3
         HXjvp1oKYBcZgjdznKUrc9xciO06FTOO1h83Wr+mefasYwPMrzKWvnj/q68oLVwzde42
         sFEg==
X-Gm-Message-State: AOJu0YwfBo9VIor3ypEYuUXSQu8MmhgDwf884WouRC1DoY9/jxzR5KJB
	R9KMFEhykcKt9TjwIrXH0JiqBLEc76qps6kjBijnVA==
X-Google-Smtp-Source: AGHT+IEyG93uqY+dG0Slu4QFyNREPv72Zm9hexzQLXJFGDAMgSXJ6+9EVgRAZG4L7+WVkRt2tNe4TlkCZV6gvvVemtg=
X-Received: by 2002:a81:7102:0:b0:5d7:1940:3ef5 with SMTP id
 m2-20020a817102000000b005d719403ef5mr6737874ywc.38.1702492603560; Wed, 13 Dec
 2023 10:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205205030.3119672-1-victor@mojatatu.com> <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org> <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
 <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com> <CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
In-Reply-To: <CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 13 Dec 2023 13:36:31 -0500
Message-ID: <CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, pabeni@redhat.com, daniel@iogearbox.net, 
	dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:17=E2=80=AFPM Jamal Hadi Salim <hadi@mojatatu.co=
m> wrote:
>
> On Tue, Dec 12, 2023 at 11:57=E2=80=AFAM 'Eric Dumazet' via kernel issues
> <kernel@mojatatu.com> wrote:
> >
> > On Tue, Dec 12, 2023 at 5:28=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> >
> > >
> > > So when we looked at this code there was some mystery. It wasnt clear
> > > how to_free could have more than one skb.
> >
> > Some qdisc can free skbs at enqueue() time in  a batch for performance
> > reason (fq_codel_drop() is such an instance)
>
> Ok, makes more sense, should've caught that (there are others like taprio=
).
>
> > I agree that all skbs in this list have probably the same drop_reason ?
>
> It seems that way. We will review all the qdiscs to see if there's any
> exceptions.

Putting this to rest:
Other than fq codel, the others that deal with multiple skbs due to
gso segments. So the conclusion is:  if we have a bunch in the list
then they all suffer the same fate. So a single reason for the list is
sufficient.

cheers,
jamal

