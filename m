Return-Path: <netdev+bounces-163800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56358A2B982
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AD1188977F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338BE13B29F;
	Fri,  7 Feb 2025 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDgspSgW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE310E9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897996; cv=none; b=AEUweU1dXYHXDRRuK23O9tvgcArqYZRIYmpIpPJGuXN+QNTB9hkZA+ZKK6LkkPPMonJfGL47lIyxpTQUPi1gMUBC6zoiQv8Ey2AoG3wGNofZiVtVDS4537iMqAGLvfQAV7HJ2urytBokUcy7jLU54bbIIbkLido2QkgL6+ajkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897996; c=relaxed/simple;
	bh=ZMX1B97Mlox5aghP7JZKu39Vqu64Bx2P2P2nHxEJmuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r9HGYbMedBQuRlSkV3ec1DUtKe4BMs1q5Tv+mjOXqb1qK2exoM9lyFihWn7XxzakXbqER2Lf+66uP/P947tEkktGPIowKJ8XPLGkalmFdYNHEXznXYbfOULB4NjfbpvryUtm7JsEKJQNJ8VBqAzXmjxaQlTV3b17zkEW/opPOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDgspSgW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso30845e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738897992; x=1739502792; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0VU6ylENWQne19YIy4mG95TY/8BJ5b12cNwMUco42s=;
        b=lDgspSgWy9/KPpsA8OjNiSgdty1/n9yzWR0ib6m6jqhrFclM4XEtnqaAdH6cuh4bA+
         FB4neDE1WVUjVYw85BTvLuxF2tpG9Dlwx2liVdO5qd3Omtb9pzOCVVWYPtSvGWu4jIPT
         4CqR8fONj6mVVFtkoXvlyZBNiGSh2LoXEfjXeNChITCpiGkC6koaTXsGhKxpTTeSVKKt
         qaTCiMsWTMpBhSWkxo8UUGmbCDcZ+xguveJI3kmdz+EpJftzPF4OVWoPqUckqt28hZGs
         BXFsjySOgY4qtR8QigVHP4fKlhiWzztJQJtPCBghjiP84t8SGRUXY95eQDFkMGNjbTWc
         AOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738897992; x=1739502792;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0VU6ylENWQne19YIy4mG95TY/8BJ5b12cNwMUco42s=;
        b=jDh9PzezUYKQvCi7qySXB0fhDnD1kCJAUibS7BvMiTaAPyncyHo5sjDRvTJqM+vSwi
         cyIJMOB0KedRbTWp3+5rXjV1/PHuT+PjvSHY7UE13MUXRirUv3+8H7opriqB1IOKcpBb
         sDX8pGQee/WpNxjqC37ozGAZlkrmIN8AvVpMuUWBIWH9+zay6eEIJ/MNtctoR1QMgTW+
         1abEFIj4Yc+96ivXW7rblKl6UINumN/HVGeIkD9tW+WCUzNadDBIr/QIXUXlq9+n9ElC
         rkFd0QwLwC265m9qkegNx0IXQ8iy4zHXpZzhRcUFshK4sFYaBDeSKcyLvokKGGtQJcCF
         tsyA==
X-Forwarded-Encrypted: i=1; AJvYcCUf6zEtXvP9JFjG+WUziFTvuyeQLJJJDh+3b32GpJ05NdbfK0/0GY+ECdFYFXgA2lxOX6y+hHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLzNyg1RQaPrIzYbJuH8rfpPc0/yHR3fUR5j17+CuIsto+gz9
	I8emBMO9SJMt6N8Sel5Q4iA8QFoSb12COMghrbbe2gPg8nOMxQNy/Gtk5FGc9zdt8EasfhE+pP7
	Vt1y9lBQbUohDkM9BSIkGolOHKXE4HJxBLzgr
X-Gm-Gg: ASbGncvVQD53VJ4OFppoOxa32sf88+br1hkn/Y5O0sqBzHocylI6hcEdmyXqaHNw+tO
	WNBAN+qFbTaQ2preiwc/GwSLfOwY0US5C3Q4LzbT2tlRGAQmjMWNMzlUjBaBlM7shFNd5WSdAF9
	rLEWTHTL2bmgcjEKUD0ErGHkCMPEQaHw==
X-Google-Smtp-Source: AGHT+IE7+jfBYInJx2BCah/D4tVU5LhjaMnABqhGnmzKK50VapgUDzBX+++RLsfN6WWHCupQW7ebgPLNh3OxAghyaCc=
X-Received: by 2002:a05:600c:568f:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-439252682demr588935e9.2.1738897992111; Thu, 06 Feb 2025
 19:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <Z6LYjHJxx0pI45WU@LQ3V64L9R2>
 <Z6UnSe1CGdeNSv2q@LQ3V64L9R2> <CAAywjhQAb+ExOuPo33ahT68592M4FDNuWx0ieVqevBfNR-Q5TQ@mail.gmail.com>
 <Z6U8Smr1rwMDHvEm@LQ3V64L9R2>
In-Reply-To: <Z6U8Smr1rwMDHvEm@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 6 Feb 2025 19:13:00 -0800
X-Gm-Features: AWEUYZla2SWAUY96jdfj4QXqNthKLYivNQbeqYRB-3fSarc2FXE8PhgxpIhoA-U
Message-ID: <CAAywjhQ+KBTaqQ=jtOtpx9+82ToOid5n06+NdqLX_iDhH7SQcA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:48=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Thu, Feb 06, 2025 at 02:06:14PM -0800, Samiullah Khawaja wrote:
> > On Thu, Feb 6, 2025 at 1:19=E2=80=AFPM Joe Damato <jdamato@fastly.com> =
wrote:
> > >
> > > On Tue, Feb 04, 2025 at 07:18:36PM -0800, Joe Damato wrote:
> > > > On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
> > > > > Extend the already existing support of threaded napi poll to do c=
ontinuous
> > > > > busy polling.
> > > >
> > > > [...]
> > > >
> > > > Overall, +1 to everything Martin said in his response. I think I'd
> > > > like to try to reproduce this myself to better understand the state=
d
> > > > numbers below.
> > > >
> > > > IMHO: the cover letter needs more details.
> > > >
> > > > >
> > > > > Setup:
> > > > >
> > > > > - Running on Google C3 VMs with idpf driver with following config=
urations.
> > > > > - IRQ affinity and coalascing is common for both experiments.
> > > >
> > > > As Martin suggested, a lot more detail here would be helpful.
> > >
> > > Just to give you a sense of the questions I ran into while trying to
> > > reproduce this just now:
> > >
> > > - What is the base SHA? You should use --base when using git
> > >   format-patch. I assumed the latest net-next SHA and applied the
> > >   patches to that.
> > Yes that is true. I will use --base when I do it next. Thanks for the
> > suggestion.
> > >
> > > - Which C3 instance type? I chose c3-highcpu-192-metal, but I could
> > >   have chosen c3-standard-192-metal, apparently. No idea what
> > >   difference this makes on the results, if any.
> > The tricky part is that the c3 instance variant that I am using for
> > dev is probably not available publicly.
>
> Can you use a publicly available c3 instance type instead? Maybe you
> can't, and if so you should probably mention that it's an internal
> c3 image and can't be reproduced on the public c3's because of XYZ
> in the cover letter.
>
> > It is a variant of c3-standard-192-metal but we had to enable
> > AF_XDP on it to make it stable to be able to run onload. You will
> > have to reproduce this on a platform available to you with AF_XDP
> > as suggested in the onload github I shared. This is the problem
> > with providing an installer/runner script and also system
> > configuration. My configuration would not be best for your
> > platform, but you should certainly be able to reproduce the
> > relative improvements in latency using the different busypolling
> > schemes (busy_read/busy_poll vs threaded napi busy poll) I
> > mentioned in the cover letter.
>
> Sorry, I still don't agree. Just because your configuration won't
> work for me out of the box is, IMHO, totally unrelated to what
> Martin and I are asking for.
>
> I won't speak for Martin, but I am saying that the configuration you
> are using should be thoroughly documented so that I can at least
> understand it and how I might reproduce it.
I provided all the relevant configuration I used that you can apply on
your platform. Later also provided the IRQ routing and thread affinity
as Martin asked, but as you can see it is pretty opaque and irrelevant
to the experiment I am doing and it also depends on the platform you
use. But I can add those to the cover letter next time. Specifically I
will add the following plus the things that I already provided,
- interrupt routing
- any thread affinity
- number of queues (already added)
- threaded napi enablement (with affinity)
>
> > >
> > > - Was "tier 1 networking" enabled? I enabled it. No idea if it
> > >   matters or not. I assume not, since it would be internal
> > >   networking within the GCP VPC of my instances and not real egress?
> > >
> > > - What version of onload was used? Which SHA or release tag?
> > v9.0, I agree this should be added to the cover letter.
>
> To the list of things to add to the cover letter:
>   - What OS and version are you using?
>   - How many runs of neper? It seems like it was just 1 run. Is that
>     sufficient? I'd argue you need to re-run the experiment many
>     times, with different message sizes, queue counts, etc and
>     compute some statistical analysis of the results.
>
> > >
> > > - I have no idea where to put CPU affinity for the 1 TX/RX queue, I
> > >   assume CPU 2 based on your other message.
> > Yes I replied to Martin with this information, but like I said it
> > certainly depends on your platform and hence didn't include it in the
> > cover letter. Since I don't know what/where core 2 looks like on your
> > platform.
>
> You keep referring to "your platform" and I'm still confused.
>
> Don't you think it's important to properly document _your setup_,
> including mentioning that core 2 is used for the IRQ and the
> onload+neper runs on other cores? Maybe I missed it in the cover
> letter, but that details seems pretty important for analysis,
> wouldn't you agree?
Respectfully I think here you are again confusing things, napi
threaded polling is running in a separate core (2). And the cover
letter clearly states the following about the experiment.
```
Here with NAPI threaded busy poll in a separate core, we are able to
consistently poll the NAPI to keep latency to absolute minimum.
```
>
> Even if my computer is different, there should be enough detail for
> me to form a mental model of what you are doing so that I can think
> through it, understand the data, and, if I want to, try to reproduce
> it.
I agree to this 100% and I will fill in the interrupt routing and
other affinity info so it gives you a mental model, that is I am doing
a comparison between sharing a core between application processing and
napi processing vs doing napi processing in dedicated cores. I want to
focus on the premise of the problem/use case I am trying to solve. I
mentioned this in the cover letter, but it seems you are looking for
specifics however irrelevant they might be to your platform. I will
put those in the next iteration.
>
> > >
> > > - The neper commands provided seem to be the server side since there
> > >   is no -c mentioned. What is the neper client side command?
> > Same command with -c
> > >
> > > - What do the environment variables set for onload+neper mean?
> > >
> > > ...
> > >
> > > Do you follow what I'm getting at here? The cover lacks a tremendous
> > > amount of detail that makes reproducing the setup you are using
> > > unnecessarily difficult.
> > >
> > > Do you agree that I should be able to read the cover letter and, if
> > > so desired, go off and reproduce the setup and get similar results?
> > Yes you should be able to that, but there are micro details of your
> > platform and configuration that I have no way of knowing and suggest
> > configurations. I have certainly pointed out the relevant environment
> > and special configurations (netdev queues sizes, sysctls, irq defer,
> > neper command and onload environment variables) that I did for each
> > test case in my experiment. Beyond that I have no way of providing you
> > an internal C3 platform or providing system configuration for your
> > platform.
>
> I'm going to let the thread rest at this point; I just think we are
> talking past each other here and it just doesn't feel productive.
>
> You are saying that your platform and configuration are not publicly
> available, there are too many "micro details", and that you can't
> suggest a configuration for my computer, which is sure to be wildly
> different.
>
> I keep repeating this, but I'll repeat it more explicitly: I'm not
> asking you to suggest a configuration to me for my computer.
>
> I'm asking you to thoroughly, rigorously, and verbosely document
> what _exactly_ *your setup* is, precisely how it is configured, and
> all the versions and SHAs of everything so that if I want to try to
> reproduce it I have enough information in order to do so.
>
> With your cover letter as it stands presently: this is not possible.
>
> Surely, if I can run neper and get a latency measurement, I can run
> a script that you wrote which measures CPU cycles using a publicly
> available tool, right? Then at least we are both measuring CPU
> consumption the same way and can compare latency vs CPU tradeoff
> results based on the same measurement.
I am not considering the CPU/Latency tradeoff since my use case
requires consistent latency. This is very apparent when the core is
shared between application processing and napi processing and it is
pretty intuitive. I think affinity info and the mental model you are
looking for would probably make this more apparent.
>
> By providing better documentation, you make it more likely that
> other people will try to reproduce your results. The more people who
> reproduce your results, the stronger the argument to get this merged
> becomes.

