Return-Path: <netdev+bounces-63289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C303082C24C
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CDE1F26397
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F396DD09;
	Fri, 12 Jan 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="STXwxPwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344C6E2CA
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ed10316e22so63042197b3.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705071358; x=1705676158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVnHuloox4t25UnlyviJ2gBRYYCzorAJooMsAwmOhl0=;
        b=STXwxPwDpHuRz3QeuetupHDaNTj+3Rdf2vml55PzrESbYecURPOtggXSNOxDOETzVa
         rLBG8MqDUjcOVJgonNl9RiN1RClyvEi26J/2MQdq/aCUl0SefDrC0Cj5OfDU7bRZi9TW
         gA1HlhPqRZGYI5879B0+6yulYXerTI3l+noy1ylUxLBjZsLIas9OgyVjK0k22BJMNIoR
         hoDD2sk5/slM1pnb35Ym/b7KLdsL15bgejit8HLJKN2E9IaB9VmMRhMuOpss97pBOqqF
         mMUlAJqTK96QPPpFiq+TiDiRgM12eUKMATcBj7XpgffChSsThh3vgtA/c9D4fpzPVE8Y
         0Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071358; x=1705676158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVnHuloox4t25UnlyviJ2gBRYYCzorAJooMsAwmOhl0=;
        b=jMy5amfNpXKmWn9noEkUCfioHsuHtedfhCK5rWSUHSOw6tCt0ci9Z4tx02u/4ikJrf
         N1Dg4PT5SBKisHwvrEKPHjtTN7bDQXgkjwQhVN6FtKNG0G7i4eVzaXJKWgH+AU0gBvup
         aZ4qEwPAzW79FPBal00ujdVYIFP6lPIGVVyOJWj4F2OUob8tBes7aBsRdTOStzTCQbkN
         DRCuEwr+zQN+9cJ7P4zha1oAa27/HTL6HPqRhmTEx10X0Nl+Zz0Q6qobn1qifM1FAPS3
         NVfyzepBzWe5JHaq8ktPSsoLZdwMB1o1vPItakaaG562XFTLAJ0aYT8J/aY4N6ehE9UX
         1s3Q==
X-Gm-Message-State: AOJu0YyNyUSiCPClvbzeYQKsk1ougQX3zG08mo4U1IzIuhlePyy1J6OI
	GKEYx0844eEmOsYvi2Zsds4ZiYv3UjvJsdjzoz7uKpqyAbS6
X-Google-Smtp-Source: AGHT+IHU/aN/LL04Z8A/bRm2Siu0Q5O31AY6OjnFp8XB8f8LQVg06FDOfKrLgVHFlrp6BWT3LLKUFvVycdBa4+e//fQ=
X-Received: by 2002:a05:690c:d94:b0:5f8:b42d:4707 with SMTP id
 da20-20020a05690c0d9400b005f8b42d4707mr1702129ywb.101.1705071358458; Fri, 12
 Jan 2024 06:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111184451.48227-1-stephen@networkplumber.org>
 <20240111184451.48227-2-stephen@networkplumber.org> <ZaEzpWaTLDG6Ofby@nanopsycho>
In-Reply-To: <ZaEzpWaTLDG6Ofby@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Jan 2024 09:55:46 -0500
Message-ID: <CAM0EoM=bAsbaNsQUbfO_yLHR2PFXBF9Zq3VXBGPhmKtWsMv5tA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next 1/4] man: get rid of doc/actions/mirred-usage
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:42=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Jan 11, 2024 at 07:44:08PM CET, stephen@networkplumber.org wrote:
> >The only bit of information not already on the man page
> >is some of the limitations.
> >
>
> [...]
>
> >diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
> >index 38833b452d92..71f3c93df472 100644
> >--- a/man/man8/tc-mirred.8
> >+++ b/man/man8/tc-mirred.8
> >@@ -94,6 +94,14 @@ interface, it is possible to send ingress traffic thr=
ough an instance of
> > .EE
> > .RE
> >
> >+.SH LIMITIATIONS
> >+It is possible to create loops which will cause the kernel to hang.
>
> Hmm, I think this is not true for many many years. Perhaps you can drop
> it? Anyway, it was a kernel issue.

Hmm back at you: why do you say it is not true anymore? It is still
there - all in the marvelous name of saving 2 bits from the skb.
If you want to be the hero, here's the last attempt to fix this issue:
https://lore.kernel.org/netdev/20231215180827.3638838-1-victor@mojatatu.com=
/#t

Stephen, please cc all the stakeholders when you make these changes.
Some of us dont have the luxury to be able to scan every message in
the list. I dont have time, at the moment, to review all the
documentation you are removing - but if you had Cc me i would have
made time.

cheers,
jamal

