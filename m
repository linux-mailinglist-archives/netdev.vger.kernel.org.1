Return-Path: <netdev+bounces-136534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992969A2087
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E19288354
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B431DBB03;
	Thu, 17 Oct 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFuj+u2O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0F1DBB0D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163059; cv=none; b=Y9Z+IJVUGQaLzVf9J7c+oy6ToxFOjZJ1B7/hbFx9aGOs4kOoN8MYMgKWT6EagwB+IXmoMxwweAA78JPZzX9SyW3TCe9PwGYXaqAOuhV8P7s/E3b0h38Art9/bGkY+JrDj9KyLLh1kOzfW7FMaBaDl5FGsxu2C9uNxlj94I76Tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163059; c=relaxed/simple;
	bh=taufqpI73+kpr0Ades0/aP6u1dipBaCN0nx2Z+dJKsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFTGUY4Bq3ur2/cObmxhn0Uofl0RIhCLJpzP+cmjo6sSvQ/hNoVn+nv/Z10mm0c7G3dNk36VqJ7KoMTpBO2elQSblAl7rrPv7tkGwlm1WQtnJyVvoH8CB1zMxTmMRtImre4iX7VfVomKSt53HAO/fEe02/oXtc47NDjk/TVKIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFuj+u2O; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e66ba398so23073e87.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729163054; x=1729767854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhSgMw/IF59qkvvEibQnpN4brZ6Rd7pimetak8BWaqs=;
        b=mFuj+u2OBbuhIek+p5HTlzxd0rInAbNOlzrAqoOvBJXQRkCnctFhMk0YNKmjIfCAJO
         RuJYuei4ekCtG29lbAjc1F/cAPwbRGk0PhkHnjF/xpD3hCk7VSeldhevY4j52aQfMj1+
         DZUEeAFFaAJnVvvM/SqaZj9oR4dAD4vtdDPyWf7jwwOMpUyp/4FH75CLVzqEgjXYKrEg
         rUks6WQ3A3WqezfJT10w45h9LkgH9DXVK6zlZxwC7+vEsLMB5GD+RXOZcom/3VnfGMG0
         E/7SLf1dsZqg+7UFbkpm4dAY+9MlJtOFmzVwcilCfZqxbzFo5W44Ofg2D4dXBcFfEfob
         WbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163054; x=1729767854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhSgMw/IF59qkvvEibQnpN4brZ6Rd7pimetak8BWaqs=;
        b=wllNMPIMW0dorOmUJZu/Ae22vzXKf06e1BvBAqMQmAO8EpjAIPG9QRl/co1Xq9RXBl
         oGrMnVHLyVQGjGSjj/ayA2UdsdevI7no3Mjs+2Tzu+8zWgEqjWe33kEaWnU+8fZukc5B
         VVv+rJ8Ui4iLdd3APXWVlLbtyiO3l3CUYNZHHV1H2T2Z80cHMlzxJoOWtgfpBR/rOllU
         ClI4ZfZda0Vof2TlLHaQQLOsPea01otL7qLQ9ZMoth/ngXqqjYlk4mgMgczBfmrkkhFk
         yYWNXWxLIlVqBMofXoGCk4932b3imDFNx1hQ0/yfUjBmomV3h7fPlIaE3XRr0TT60zrL
         H8mg==
X-Gm-Message-State: AOJu0YzKd85vH4YhmhkBI1qO3vbUPzovcTZj2cEzosA2my+CeDkLy4Ho
	EOMW4M68pX+qIVo/neS+4vf6WcuZozAWhI4nGbLriKeI6ARhUhsnI0JUBLrXAvgAxIZzg9YBtEp
	xY3rTimQVE1qI278cSuklnv1nvY6MuNo1OQT8
X-Google-Smtp-Source: AGHT+IHcz3uoXkkXHaV2C8zXH5/MeVYWSXCYVKatTeRbFdahiI5uvrYww63i8awkMqWZn+QTudgiNvlmTE6fO4S1hLk=
X-Received: by 2002:a05:6512:a8b:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-53a0ce58e4cmr425311e87.2.1729163053576; Thu, 17 Oct 2024
 04:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017094315.6948-1-fw@strlen.de> <CANP3RGeeR9vso0MyjRhFuTmx5K7ttt0bisHucce0ONeJotXOZw@mail.gmail.com>
 <20241017105251.GA12005@breakpoint.cc>
In-Reply-To: <20241017105251.GA12005@breakpoint.cc>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 17 Oct 2024 13:03:57 +0200
Message-ID: <CANP3RGcWhTKOgNsCEb8bMNhktgdzXH+00s5zTKU3=iVocT5rqw@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: migrate: work around 0 if_id on migrate
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Nathan Harold <nharold@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:52=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Maciej =C5=BBenczykowski <maze@google.com> wrote:
> > > +found:
> > >         /* Stage 2 - find and update state(s) */
> > >         for (i =3D 0, mp =3D m; i < num_migrate; i++, mp++) {
> > >                 if ((x =3D xfrm_migrate_state_find(mp, net, if_id))) =
{
> > > --
> > > 2.45.2
> > >
> >
> > Q: Considering the performance impact... would it make sense to hide
> > this behind a sysctl or a kconfig?
>
> Kconfig?  I don't think so, all distros except Android would turn it on.
>
> > Yan Yan: Also, while I know we found this issue in Android... do we
> > actually need the fix?  Wasn't the adjustment to netd sufficient?
> > Android <16 doesn't support >6.6 anyway, and Android 16 should already
> > have the netd fix...
>
> ... seems you already fixed this, so I suspect this slowpath won't ever
> run in your case.
>
> Following relevant cases exist:
> 1. Userspace asks to migrate existing policy, provides if_id > 0.
>    -> slowpath is elided.
>
> 2. Userspace asks to migrate existing policy, the policy is NOT for
>    xfrm_interface, -> slowpath is also elided because first attempt
>    finds the if_id 0 policy.
>
> 3. Like 1, but userspace does not set the if_id.
>    -> slowpath runs, BUT without it migration would not work.
>
> 4. Like 2, but the policy doesn't exist.
>    -> slowpath runs and slows things down for no reason.
>
> For 1 and 2 even sysctl knob is irrelevant.
>
> For 3, sysctl knob is *technically* irrelevant, either migrate is
> broken (sysctl off) or its on and policy migrate will work.
> This also hints we'd have to turn such sysctl on by default...
>
> For 4, sysctl could be used to disable/avoid such slowdown.
> But I'm not sure this is a relevant scenario in practice, aside
> from fuzzers, AND it breaks 3) again if its off.
>
> So I don't see a need to provide a config knob or a sysctl
> that would have to be on by default...
>
> If you think a Kconfig knob makes sense for Android sake I can respin
> with such a knob, but I think I'd have to make it default-y.

I'll trust your judgment.  I thought we could maybe eventually
deprecate and delete this, but it sounds like that isn't going to be
the case...

