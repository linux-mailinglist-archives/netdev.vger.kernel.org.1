Return-Path: <netdev+bounces-131753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785B98F6E8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6D28195F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E71AB531;
	Thu,  3 Oct 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXBhVT07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970671A76CF
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982996; cv=none; b=ONebT8UDuMf3FvmIUz6zUSy9shJMIXBO6lUOgKj3fmVk7LYHku02ocfZSNzGxBN2jxL0NUWgNyzu2UMd/IRN3TieAi2ziLSTeiBeqciq3wAjMgkkr9aFNQpzwsiWeR3DmU3FTdakU02cKYFgIxE0lNw7v+zMkXcxmAHtkgIHDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982996; c=relaxed/simple;
	bh=9Dr9FrVCifF+wc9L5JQPmQlw8IjuOSIeGmh0+hJxFoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYikM5EwJQXYllrG7B5dI+W77uod6WzK4Bqe2ZTPc894LXRJEfaB+JDz2qJ/JyUFZ35C5EzaLKC0g7zPPkFOsUOqJPg9jdNfzQ0xKvPJG+i7h7M244OzpS76ruC8qDGE2OFY/FK9VHv5zVYDUlhUAcJGBdKLT1KuG8oxazggWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXBhVT07; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582fa01090so50891cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727982993; x=1728587793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Dr9FrVCifF+wc9L5JQPmQlw8IjuOSIeGmh0+hJxFoI=;
        b=WXBhVT07tSscB+2et4mWwAud5nUElfCj0asBiedlRtZhC4tUbtK33ZGaT/mh8K0nvy
         MsYCO2uITtU5JsP/6uNlQuLTLGz8705PpV+N28BuAzThCJBCbses0igyxPovHm2SPJNg
         fBRwxNMx/vmuFrHPSN40MItrhK/jqqFEhHIpFlC/FwDKFNHmWg3SKTQz2UhK96bJlx3z
         aH8H95slP20t2KyH1ysFLybU8Ie/Iw6fTdVLPUsX13kixUaCeHel8FI71Jeofk2GhmmO
         LS2+UY9bFGriZcQaod4VqMLLfl7nNtRyu6bTOjyYy6Ldqcune5Q+IZ7af9xr3j1Zygff
         u4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982993; x=1728587793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dr9FrVCifF+wc9L5JQPmQlw8IjuOSIeGmh0+hJxFoI=;
        b=jpZjAP1GfJCm+P1ddyWnEBE461Eci5xfy1jAwMZTiPT6//xFkukDWBj3HTmckbuT9r
         b8+0XkGWjKqiBLX5OzunvoMHWFmFbdM9OFohfgTxuoprKSvA1hL4G1u5v+LhC3f84c59
         fdRYXkQn8QSrtjbK1hciGR2TJmwyMSH6LQ1rCvfbp3IMzco1CQsE+OP5JqeFTKaa9zY2
         Fn1VzCB4VmWh3xj3KoMnSHvTvNLnewBp9jIhLI/HWTVOREwxC8crI3UZwtylNo83TGgy
         5okbAk/L4EjP39mW81SjOsHSWlpqxauveSe9UNXN1WXvfMVSxkqMKOM7sYvuMG4pDkii
         qa/A==
X-Forwarded-Encrypted: i=1; AJvYcCWTc933lGJVnOxjSYfSTJXSe/2+JVnsLfMGHxhm32T3DETxLWyfhTMoFse55hE703ccei5aQV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+b27xQuFT4YsvZF6WCevwDwIV2B5RHZttsrgWoHFrTpbBmos
	zYgapwY91IHIUj12lFAlXlPoLHuu47GjAv04FMbhUzZ0vpElHR5VYlO3q6/3LT0+B7o+pRG9sbA
	7vwK1wAPBZoCh6+2iD+1d3ccwRYwxfKHWRyJp
X-Google-Smtp-Source: AGHT+IGttVX/T4W/nx91eYNLNpPB6dx1tomc65fLqxgiGgP+3Hmp4QVcuJzkAyqaKx0620/V7y+qM/6ouf/r4bOx+/4=
X-Received: by 2002:a05:622a:458b:b0:456:7ef1:929d with SMTP id
 d75a77b69052e-45d9bda1f9fmr151911cf.12.1727982993239; Thu, 03 Oct 2024
 12:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-12-sdf@fomichev.me>
 <CAHS8izN6ePwKyRLtn2pdZjZwCQd6gyE_3OU2QvGRg0r9=2z3rw@mail.gmail.com> <Zv7TpwAgpVs2SjyH@mini-arch>
In-Reply-To: <Zv7TpwAgpVs2SjyH@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 12:16:19 -0700
Message-ID: <CAHS8izOvRgAoJVH28wj3+7QF2kHPON71vsHOp-1NtBxDnugFHw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] selftests: ncdevmem: Move ncdevmem
 under drivers/net/hw
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:26=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/03, Mina Almasry wrote:
> > On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > This is where all the tests that depend on the HW functionality live =
in
> > > and this is where the automated test is gonna be added in the next
> > > patch.
> > >
> >
> > Tbh I don't like this very much. I wanted to take ncdevmem in the
> > opposite direction: to make at least the control path tests runnable
> > on netdevsim or something like that and have it not require any HW
> > support at all.
> >
> > But I see in the cover letter that Jakub himself asked for the move,
> > so if there is some strong reason to make this in hw, sure.
> >
> > Does it being under HW preclude future improvements to making it a
> > non-HW dependent test?
>
> I'm moving it under drivers/net/hw only because I want ncdevmem to end
> up as a TEST_GEN_FILES dependency (drivers/net/hw is the directory
> that the vendors will eventually run against their HW so this is
> where the HW-dependent tests are gonna stay for now).

Ah, OK. Makes sense then.

Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks!

--=20
Thanks,
Mina

