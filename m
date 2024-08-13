Return-Path: <netdev+bounces-118156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B0950C6A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536851C2130E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C131A38E7;
	Tue, 13 Aug 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WgcLfLRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7BA3D
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574424; cv=none; b=gbpaX9USmzMeBYPD11c/Zgta0bCrk9ay4YNN/2R0jFap/CMigwcrHSvjCPnk4NPO7W2ocqAzjABDIED5EP8fWuB+JX+AZrrq8oLzRq9wN8vidU2sKHlIion4QPeVXRVV+uaoHp5fjs4pOn40071fvTGtpZhbirZU68xDKPxbtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574424; c=relaxed/simple;
	bh=HB9kwri3wgCHBgqM3c2NHftTYVjLZwyldnoIFxfPM+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXVsxMz9Lyo17Ymv9BkbZsYeU3fgnQ8Q6S19QABLaP3ocm38D6NxAzdNqxcCYsHmDiDEHvOUTvSZOhXCT3DmCiwP3uHT/q+eZJZwRsaRvz1WXFwUcn587HJYZJLi0qu1X7r84kpK2AlOYLXtisiZjf8+d5C1V7gURv8Mr+hrB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WgcLfLRU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so242713a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723574421; x=1724179221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB9kwri3wgCHBgqM3c2NHftTYVjLZwyldnoIFxfPM+w=;
        b=WgcLfLRUVV2rYevLYCI/qZzBelKlQrqS1v4x2A9CtWP5+oS1Y/B/ME2QRyDypNpRV1
         cK7u/RyxKZtcD2AhXA6R5fuClOrep2XPuM2yWjJ3zo7Gr1FKj6bkT9bqZlai/PNhDfN7
         5TwzDaZJ/PU/m70DFvxqLqk1ZfksoHcEECP3+j/XaPTTLfk8vV0Lx/+23zr/jRb587Qz
         Dy1ljZqRLEgY/f4O9vMZqWLDftcSCzSPhLslphw7cLSjHY9Tjalq7ejgxSi15V4b2/o1
         k7cOgDbMYCu9q+FBgP8WSmuerrsmMMo186bKH9w3BMKtsiWXjgtahVEavNSwItt/dwj2
         wjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723574421; x=1724179221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB9kwri3wgCHBgqM3c2NHftTYVjLZwyldnoIFxfPM+w=;
        b=duBK6ebB/PuMtmYGchIf1xAlwm/uCFVCF6ETxyUW8w+DjZ4nQ/Re50WYLV6FvsAHMw
         QNvOgmZspHZ1UzvgX7HyDynkTN15FhJzKGkO53tj/TEj6gdJO0m30Jgy263/7Ehx3WtY
         siFASVn1H0PvzupSAG/j+kPZNgZQOVdPEij731TrqZgANn0tLA7ZOlE4b8b1mXz91ulJ
         iJbAX0PpHlL1Q/7oxs6Dn+fonhJcWdmNaLdJp51FmXwQLJ/iGIhTiTjc2OBx5D5s/KCI
         ZKw4pcGnp0zz5+EIsBSVvHmpGAJFUUi9fif5EVcIfOvKoQgFTOOgGsmFJZl2TyYP/Zql
         7w1g==
X-Forwarded-Encrypted: i=1; AJvYcCWHwKQMllHHjshrZ2gV1vgzFZd0yKsHhErxCYBwr9UW2AQBIyZdeBUbr8GuNXq6+K+5Xl3jIYD34BMS0GrjAaO4Ap/Si3a0
X-Gm-Message-State: AOJu0Yw4P8qL7J1zPFu62/I/Cck7GT9sLR9oUjYALZQbAig/a1U5JAT7
	9w2PN00ci6tXS/IDhp/1rrAP5t5k8pHH2SJDn6l9xtzIeSWle2dLuIIAIQpDGMfGecegNVcjlRI
	KWRyaSA5a0fUayUFqORdTs6NzWDSePcmOviGx
X-Google-Smtp-Source: AGHT+IEGiFyLmUjvA3/inD89ruZTnIAfDGJVsG0xoBpch6LIDvxd7KRE2LScRqlgymBfnr2RPuzuwz7pHkYK+YFXD0M=
X-Received: by 2002:a05:6402:5483:b0:59c:50c3:af65 with SMTP id
 4fb4d7f45d1cf-5bea1695e12mr488743a12.14.1723574421313; Tue, 13 Aug 2024
 11:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c99751b0-ce71-4a27-99c3-097b62078179@yandex.ru> <20240809213804.7fa79cf1@kernel.org>
In-Reply-To: <20240809213804.7fa79cf1@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 13 Aug 2024 11:40:09 -0700
Message-ID: <CALx6S37hSfQWw3Rku8vsavn8ejk0fndRk+=-=73gU7G-RbnK8Q@mail.gmail.com>
Subject: Re: On KCM maintenance
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 9:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 9 Aug 2024 08:13:11 +0300 Dmitry Antipov wrote:
> > Recently I've posted a tiny pretend-to-be-a-fix for KCM sockets, see
> > https://lore.kernel.org/netdev/20240801130833.680962-1-dmantipov@yandex=
.ru/T/#u,
> > and now I have a question about the subsystem's maintenance status. Sin=
ce net/kcm
> > is not even listed in MAINTAINERS, it would be interesting to know whet=
her the
> > subsystem in subject is actually alive and worth any further developmen=
t efforts.
>
> Maybe float a patch to delete it, and let's see if anyone screams?
>
> The concept KCM implements is really nice, but the lack of bug reports
> also has been making me wonder if its in use.

It's possible it's not in use and I suppose we could see what happens.
Hopefully, it won't result in someone reinventing it...

Tom

