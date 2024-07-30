Return-Path: <netdev+bounces-114190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4BA941431
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E315E1F21A78
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227D1A00FA;
	Tue, 30 Jul 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2biFIF3h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2451974FA
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349323; cv=none; b=h5+NQcczrR1b5FQ9jZ7b1Djq+GAOvpmvc3qzGsvr0Lm4Bw/70h7b0mR0itfNhYEMLkXrNLsDIHlvnb7limbo9l9Om3GgB2gF093a7zWOQUwyqfTU/0Wlrq/sVD30pOjD+xT0omOG0boqE78SwxplhVx92Ly1urGz50CPc3gzvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349323; c=relaxed/simple;
	bh=td2GxPmq4Vy21N4rNHmuDatGvtVOhvlUn5hPXhRZmWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8EgvtvEIVZOqhYbzF1RLGZ2eqo1NB126Azlbdt9Vyj4BTtdnbm8LxE69tjG1W/WrrKK8a9STfBIz/f10635nbkquv2J/NTu9SInGRUxFNjRFHbZqbQIFiQZe+iewkrXjeTsbu8VjrT60wOTflB8HxDAw/9i8T4vHTHpGNBec9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2biFIF3h; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso16258a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722349320; x=1722954120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td2GxPmq4Vy21N4rNHmuDatGvtVOhvlUn5hPXhRZmWs=;
        b=2biFIF3hT5cKiLf3l9IJBTXBAXb8M3aePJO3RJQkbtobRqQnD1tyLOs3aNwhLoB5h5
         3m3al7op4HnB0ZazA2ie1LUCuCS9Z91H/lRMFOFZ4F3FaP0h0JoUuT5KS8QqbM05agAC
         mP/HbFS0iZA4cGxoeCLeEQePF8NV5lH6sac1zl91L5dECk31Au9irEVc5pUHmuhZMsWK
         aLENVgJJMmKs1l3t/dD3n2r7q8oiVW2Y8Nsjz3i5fSNXDIPwetJcj1oZ+w4dqj8iJcMo
         tRoiWt2ZZu59Qb+rEo6P0NnDOJ3GsG3olFvtQ4HETEFK+YB2hgC7BCGiYXJyIntiqn9s
         zIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722349320; x=1722954120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td2GxPmq4Vy21N4rNHmuDatGvtVOhvlUn5hPXhRZmWs=;
        b=xNUSt+FuScIgnKLLIN7cNatCK1fTcwznbFHo/VuGg54h2KFV0VCViq8faGzV166rDe
         Xy4ZqrnmTYMAuaqyHylR2WgP5J3msIVStGbC+4aAZcVu99wEqadPrWZreh6ZeS8n+tTT
         c8StOw4p6oZ9KWtF2bP1QQSV1QvvqkWQB43x+P/VssjJJISnWyYARdQahz1RqfPyddDL
         S9arGcGyAWjYRcFXztLn5gHLvBh57I8bKXxNXkn8lJgngKg3Hk7Urxop2Q/dDfpHQq4p
         Q6TS/jejXJx/YDmVokmqp7afgTWDJdIuAWzyDSGKGxJxS1frJnjS6EOT/Ockuam3bNOP
         gbYA==
X-Forwarded-Encrypted: i=1; AJvYcCUpJelhDbpsunXpHM/7ixDDT+GTIyVPq191WNj+T57uDoZkUTKOfbwzsTBw74UqynGg98qYHLR2Oafdgs5op9bbKdyoBXNK
X-Gm-Message-State: AOJu0YwFPpOPwbPjGIJ31/NBjy2i9xw+V1J6dkU4NuQKFE6mCDZumrDT
	0KrCXiQqYrxvxm2yrS04IR5odHtAlF7NWl7H93UYv5IjEjJtrSHk+fQhGdJQArCaz1KEnewGc2p
	XPgFhe7Cc1XK6DgOzNLcjKRJWHYrVDGRNwAjk
X-Google-Smtp-Source: AGHT+IFNRt9lpQJOEzcfsYE0mrEb/1SkVVKFpCb9n0uUdrImQXtRw3QVcDxx5iBxxIvYyeI287MXeXkna33vpnW2CaY=
X-Received: by 2002:a05:6402:34c5:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5b45caf9b01mr152338a12.0.1722349318850; Tue, 30 Jul 2024
 07:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729104741.370327-1-leitao@debian.org> <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
 <20240730105012.GA1809@breakpoint.cc> <c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
 <20240730071033.24c9127c@kernel.org>
In-Reply-To: <20240730071033.24c9127c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jul 2024 16:21:47 +0200
Message-ID: <CANn89iJ7vw5KzPqBuaoe2g9AKUnC0vsSST-6Xqw4fvL5n9gkJQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when debugging
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, leit@meta.com, Chris Mason <clm@fb.com>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 30 Jul 2024 13:15:57 +0200 Paolo Abeni wrote:
> > > If thats the case why does it exist at all?
>
> +1
>
> > > I was under impression that entire reason for CONFIG_DEBUG_NET was
> > > to enable more checks for fuzzers and the like, i.e. NOT for producti=
on
> > > kernels.
> >
> > I feel like I already had this discussion and I forgot the outcome, if
> > so I'm sorry. To me the "but is safe to select." part in the knob
> > description means this could be enabled in production, and AFAICS the
> > CONFIG_DEBUG_NET-enabled code so far respects that assumption.
>
> I believe the previous discussion was page pool specific and there
> wasn't as much of a conclusion as an acquiescence (read: we had more
> important things on our minds than that argument ;)).
>
> Should we set a bar for how much perf impact is okay?
>
> FTR I suspect there will be no measurable perf impact here.

Same feeling here, I think this patch is fine really.

Reviewed-by: Eric Dumazet <edumazet@google.com>

