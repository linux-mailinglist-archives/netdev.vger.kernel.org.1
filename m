Return-Path: <netdev+bounces-145884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA299D13D0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3650C284079
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981871AA1FD;
	Mon, 18 Nov 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="g0GjTl7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91C1ABEBA
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942006; cv=none; b=Rp16DDBV0EYhB06QBO3Df6uKCKJGhbl7tiQfHqvWkaxMkc09ZymE9gMhJguqFC29+Vh+DtP5KO/teFbu7qnBnLRLjCNe3/4jxxPAiTP+ai6hcz41JGNC3RoyrWYPCnWpVzk/KxO7guwSSXE/dBPfShWtWnQhfMZzJ+OaQicE/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942006; c=relaxed/simple;
	bh=DV0wLt/fJAQ1zmwK7t51dfn7cg2V4txHVmffmYrdNDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGD/a6zMK8nB2BDZvhi6wW1k9KRGpsC0neGW61qwDEuOhUm/WgE24gJggrUg1RLeArxhbphTKAxgDHZpn176doDdIBcPPqhxs1KsV4mw8fTFq6ijbHPLM7Q/jVPFtoVkrGAw40WHBH2XLNwU/2JEcFReMb3U+Dj4A21IyZO5k6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=g0GjTl7Q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso4576835e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1731942003; x=1732546803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zJ4FGoi5ftTI56Hvv5JnS/WGB8iYYkvstT7BpBSm10=;
        b=g0GjTl7QCbDHMhHMIvfAz1rO2ckf/Fmvo+VKilnZ8gjPGrYWF8Hy6ySwwND1UQ/uek
         0KZfrbUTO92b3RLK92Dk+JEeEEg9aO7lp7Tj+IuHNM+1b2cB4bSWfavk5Sck4efbfHG8
         QESm+k2GToiwr6BbTashhbnVCBWKWEUydEhfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731942003; x=1732546803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zJ4FGoi5ftTI56Hvv5JnS/WGB8iYYkvstT7BpBSm10=;
        b=uZL2815OCNlGPLIqQxl+NUKmgv8MUnNnfhZuCjYd/Km0Pg9zldoSfZ7xmOiglLdiGw
         74GvHZSiDPdqsBjl6frBNayuhYGcM7VFe/TsCKXFe1N0Wpt5yT9CGnn/UoIScEnbo9uP
         dATvd926xR0D1IlyAy2ufwnkNL7U7EzKVhjAoQDZxFRQTJRCDc5ZtRrNE13tmZJ2V3qV
         1OJmX7SXRm8/MFGqDKb6Ov4G4AkvSRfBeD2G3rxKwwi4aaEdUlMJSLLMAPEOE8Ogt6pc
         9VL9Q3RZ9Et+i6PGc3v8PGEEDRyyIFxD/+mnKR59dHEF91OxfWB3FJTqJ2c/0Rfj7kyv
         g3+g==
X-Forwarded-Encrypted: i=1; AJvYcCVYc8GE5AENVQ9FoBpCPZaUAcCuR/UIhHVtb1iu0eqz5/fFG1v9XEKrdJkJ89RgOT9ACf4ErPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOswazb6oCBAcUFHspW7bKGlr0mulQ1bpO+cI0doGedvOpEoBc
	JFr8tQGV6W8hSxRCshMJCvwpTW+9Yzlq8Z4b2CDv27JRQQhkjwVeuwI1ZSNi57C6Hhhu/jMfdBQ
	8zffX30nYG7o+dulbiL4eom1keA1320dt0cSXQg==
X-Google-Smtp-Source: AGHT+IEye5AclSa0Dtqlqp4wT1D/SzXX4+blQIj+JyQyDIjVt4YGD2ypM1int4wOl7MFpC8uCGhhzy1mK8dlUxsjQ5k=
X-Received: by 2002:ac2:4342:0:b0:53d:b0ea:9efa with SMTP id
 2adb3069b0e04-53db0eaa7aemr2498033e87.31.1731942002224; Mon, 18 Nov 2024
 07:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117091313.10251-1-stsp2@yandex.ru> <CAJqdLrp4J57k67R3OWM-_6QZSv8EV9UANzdAtBCiLGQZPTXDcQ@mail.gmail.com>
 <d1e90994-ca11-4a3e-b627-e3425dc5bf26@yandex.ru> <d99a9ccc-6cc0-4978-9930-7021979703c8@yandex.ru>
In-Reply-To: <d99a9ccc-6cc0-4978-9930-7021979703c8@yandex.ru>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 18 Nov 2024 15:59:50 +0100
Message-ID: <CAJqdLrr1oet6F_EQSaiSfwnMCvt0Omvicw5Ed7FkiyrQagfgMQ@mail.gmail.com>
Subject: Re: [PATCH net v2] scm: fix negative fds with SO_PASSPIDFD
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am So., 17. Nov. 2024 um 11:11 Uhr schrieb stsp <stsp2@yandex.ru>:
>
> 17.11.2024 13:04, stsp =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 17.11.2024 12:40, Alexander Mikhalitsyn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> Hi Stas,
> >>
> >> Actually, it's not a forgotten check. It's intended behavior to pass
> >> through errors from pidfd_prepare() to
> >> the userspace. In my first version [1] of the patch I tried to return
> >> ESRCH instead of EINVAL in your case, but
> >> then during discussions we decided to remove that.
> >>
> >> [1]
> >> https://lore.kernel.org/all/20230316131526.283569-2-aleksandr.mikhalit=
syn@canonical.com/
> > Yes, the patch you referenced above,
> > only calls put_cmsg() with an error code.
> >
> > But the code I can see now in git, does
> > much more. Namely,
> > if (pidfd_file)
> >     fd_install(pidfd, pidfd_file);
> Ah, I guess pidfd_file is a culprit.

Hey,

Precisely, when an error happens then pidfd_file is NULL.

Kind regards,
Alex

> Thanks.

