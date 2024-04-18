Return-Path: <netdev+bounces-89371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEFB8AA24E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2691B221B3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE517AD6D;
	Thu, 18 Apr 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTi9F3JX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40017AD67
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466291; cv=none; b=W5GflOG+aI6UIffG72ewtNjc512WRwzxShKfSjOvOfgDYP211T1PnlZnEtKCU8EAH6hwuRN6us5ckeBNwzFCazf7ev22dSkECYfv0E+YC0uzMyztRt/6g2Qi9KARvk03nKTKgpRb8jtPjPAbyACmP5vC+uktyepGWszpjOeekj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466291; c=relaxed/simple;
	bh=jvW7hMCjwo7CN/K5mcq8Qwa/N6UV2QWPgKjq0AlxuMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj7E7SjZKv+BRZ3gfhhMMqPl2X6DhnS1o5zzJMmyEMSchy6SXGikz3qYHXR5rL2siKYUv2GBD6kmbB2fy94AxVCJrVcnKBfLQAeWmquZXmVX+NdovdRCRT03ariGNHe/30FZTG07AOyUfuJMbl+b+f+mrmA1xDCdmQZynbbxNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTi9F3JX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so2092a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713466288; x=1714071088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvW7hMCjwo7CN/K5mcq8Qwa/N6UV2QWPgKjq0AlxuMk=;
        b=iTi9F3JXHrojVU1jE8kISEVZER9OuO8CjI52oWkscOGq6BvNtxG9pJBhZGDbBDJLEK
         tvoSzkcsy1SysuqgXiywcxJRQ4JfVEMw4Hf/jR9cnZeVRugasLKPl+i51QZm7Dnu3W0B
         J0t+0WUwo42M/Czr8rsJnFgC6HC5ueAlcH65OMqyINOkFX6UhVvrSxiMvtayiClguw3p
         M+5H57d3Ri74ltIeC7ahqDl6eydrNocoC2NadIxARXdCK6UdsTVTjpge8dsZbzzYkzJX
         UjX4HLofxVY516QmJrsZ5zEx3kOSRs/sO6LMfpjG3Vb4mzKwaEGA6T6QJRqql9U1v3Wb
         TG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466288; x=1714071088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvW7hMCjwo7CN/K5mcq8Qwa/N6UV2QWPgKjq0AlxuMk=;
        b=afHIo0m3aWmAG83WfIaI7tZcUPm8ggyLIhYIfdeN02UYjDI6bxSSI4NxHu3FIOGL4k
         +tBCdyNLXjW7wLWQleduDqLvRvWkDteYrgpjmPxn/lmMbrroeTRSRqLEXF29JEraryi4
         oaZq7D+l9UtUVSXeOjwgvK+JFKFuS71Wpiqu5x8IQLCz7O/M2vUd5I32raDOe4bdErvD
         g2f5HlJOVp8EHPjSmwVklkBa41/0e1BPGPGwoOf0gkjVEUYbG0x1qHe7KfQDdn0UoUNA
         SR0zsQJKPVF1tg5zrflMMb+Rtnwd+4EKi0bSgzb0bgjLvcqRhL+RE+UwN6EgISez61hZ
         dGFg==
X-Forwarded-Encrypted: i=1; AJvYcCUbIuT2hyGSvziTzODwwAG1Fae1h6MQ4OAxEF9p9v5b/OInfzwqkUbiTjntyYvwneXfpOBLqptlbn7pFkt4/GrV8lmiJ/P6
X-Gm-Message-State: AOJu0YyYcY9TfUT3ZVGWANkldwHl6dauN9zllz6mhY+KBiF+3rkxtLEh
	Pb/aVtEgNGwsoYl8CglDTuNu9v6Td6D94yJpnCaPqAska/DO6L8BHDqCd++k7QT41y+DgpQpLe3
	kZo4w+goiR4zXbPP1HQ1JgMfgC6nl43CLz8f9
X-Google-Smtp-Source: AGHT+IG0nwF2sPAth0hGe1xE3k7qAAwtmvw2rthCZWtTHFJ8+eKzu9jlzZvyi0B1H3T1RgbsUYyxF016Rx65y43XYBM=
X-Received: by 2002:aa7:d04f:0:b0:571:b8c4:bcc with SMTP id
 n15-20020aa7d04f000000b00571b8c40bccmr16051edo.6.1713466288126; Thu, 18 Apr
 2024 11:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
In-Reply-To: <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 20:51:14 +0200
Message-ID: <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:24=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > > I'm not sure why the patch series has been changed to 'Changes
> > > Requested', until now I don't think I need to change something.
> > >
> > > Should I repost this series (keeping the v6 tag) and then wait for
> > > more comments?
> >
> > If Eric doesn't like it - it's not getting merged.
>
> I'm not a English native speaker. If I understand correctly, it seems
> that Eric doesn't object to the patch series. Here is the quotation
> [1]:
> "If you feel the need to put them in a special group, this is fine by me.=
"
>
> This rst reason mechanism can cover all the possible reasons for both
> TCP and MPTCP. We don't need to reinvent some definitions of reset
> reasons which are totally the same as drop reasons. Also, we don't
> need to reinvent something to cover MPTCP. If people are willing to
> contribute more rst reasons, they can find a good place.
>
> Reset is one big complicated 'issue' in production. I spent a lot of
> time handling all kinds of reset reasons daily. I'm apparently not the
> only one. I just want to make admins' lives easier, including me. This
> special/separate reason group is important because we can extend it in
> the future, which will not get confused.
>
> I hope it can have a chance to get merged :) Thank you.
>
> [1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR=
8FrfRvaa-Vg@mail.gmail.com/
>
> Thanks,
> Jason

My objection was these casts between enums. Especially if hiding with (u32)

I see no reason for adding these casts in TCP stack.

When I said "If you feel the need to put them in a special group, this
is fine by me.",
this was really about partitioning the existing enum into groups, if
you prefer having a group of 'RES reasons'

