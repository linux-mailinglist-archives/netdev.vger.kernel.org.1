Return-Path: <netdev+bounces-102311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31290252E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D201F21F3B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACA13DDBF;
	Mon, 10 Jun 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik9VoJlz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBC13DDAA
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032509; cv=none; b=fquNAE4XPTXiLbSXzqCDVkQ4rnm1poSP42xy7lwwesy4LYAs1N+20g/OlqUeLHscjC9Ns3vLji7B44u0oHx7TVEGXhYt8ehL3lvS/RvrkUlhkL2/+kWDQyvEXwJfhzQnnET1lFV6CG1J+xzj2FaA+P7J+JUThcUBzT8nUYYMxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032509; c=relaxed/simple;
	bh=MKsQCqfN1ZQ4o2Ioge7OKkX52qONyWXvxqNAfzQqFbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2OHOkNLweazKNKDVWtBwwAvRwvSIm6wPoM6ZX2qzxukIPPAKF8v1yN/vDXs2ib3PYZsk0f+U3HBoRAYX6YnT9KwR5lyRnMKZV7MwBVvCKEytYZXPP9QcRpUPcjM+Tg6ZCDmGMByPynONLBUnhwC5Hs34vN9m59KxAVIA8fTW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik9VoJlz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718032505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKsQCqfN1ZQ4o2Ioge7OKkX52qONyWXvxqNAfzQqFbs=;
	b=Ik9VoJlzyTFHRyo4PcyyeHhojR530wZEO7bktzxgWXvMcMCwh70eMKKYDXjc2+pae1hm1v
	fDHNrT1uCaVp1cwAaYvfUctf89kwOeNPrcDvOmzNkVkjLi2q3qtGCCTdASJe1If6oWb4S/
	7yNS9vKGsxD9xeLW9b8PU/LGuEFwzyI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-nNzU09hfMuWArcKJFNU9MA-1; Mon, 10 Jun 2024 11:15:03 -0400
X-MC-Unique: nNzU09hfMuWArcKJFNU9MA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2d0e695d7so2661999a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 08:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032502; x=1718637302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKsQCqfN1ZQ4o2Ioge7OKkX52qONyWXvxqNAfzQqFbs=;
        b=uGtUhvHnULEhJ2biuvJfva1eMTgNRH/WcTdH7Fl5FMOgXtMJw1SxUa5cb8GQ1Tby/J
         5XjVtLvBdh+fx8OTRBu95vlsxhXDjxlSeXWesCi14oxK+36yhLu7JF5kYD8s9GmU7Qj0
         tumAoxalnm+YfOIGbaTnuP8S94lHqOCLn3n/UneFrMfzzl4uNzeAWcCmZ7Fo28dt90yI
         kwTQFBzCCuzdy0Bi+EudAEtWyxnfAZZe+KxzxhIgSjFimHwCH02yrOqb0EW53vw+sdlN
         n1Jww1aVdhf+h8lQ7HT2DhvfMi1mtqwJLPrPcE6IK6t28nbvXbdQtV1q90g9BMBN8C/b
         FeIw==
X-Forwarded-Encrypted: i=1; AJvYcCUxtbOVD6cVpN8170/PW0DS8l3PFmBfQakmeChvWiryQP4GQ9C5gtc5Eq/GiikgkXuzp1cU0TopPQ+l9IaKdBCSxldUI9hr
X-Gm-Message-State: AOJu0YyRfZpWSBUaP66YjAAEZ9GpRMST9A3eegMZgh/DQlNwt3wV0jp0
	eCMLvT54DD8OAH4BaI8bIFWh02RvP6SegYjujQ1Klu6B6P6svt50Bv2q6nSvRMRG7v4zObo+7MS
	iRtcaiNecfb+zWd2H8asRAqLjCMugb9yrwQdB/ucC9vk4+mzUw6baajlFT+zpluYFTsyURzaJAG
	Ov8emm2OsqKi1tsQIH0S76q/oJZe2b
X-Received: by 2002:a17:90a:cf16:b0:2c2:edc2:6021 with SMTP id 98e67ed59e1d1-2c2edc26151mr4212532a91.11.1718032502559;
        Mon, 10 Jun 2024 08:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUX+qE30sOtQcdPcBO6cllJjlpNJG1nFcZzFDbNKN76d+4g6+6h4LDFL2zf1CaTNmhGd2dMj97g14KHF/lYOE=
X-Received: by 2002:a17:90a:cf16:b0:2c2:edc2:6021 with SMTP id
 98e67ed59e1d1-2c2edc26151mr4212523a91.11.1718032502221; Mon, 10 Jun 2024
 08:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
In-Reply-To: <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 10 Jun 2024 17:14:50 +0200
Message-ID: <CAFqZXNumv+NNZjR4KSD-U7pDXszn1YwZoKwfYO2GxvHpaUnQHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:50=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 6/7/2024 9:07 AM, Ondrej Mosnacek wrote:
> > This series aims to improve cipso_v4_skbuff_delattr() to fully
> > remove the CIPSO options instead of just clearing them with NOPs.
> > That is implemented in the second patch, while the first patch is
> > a bugfix for cipso_v4_delopt() that the second patch depends on.
> >
> > Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> > https://src.fedoraproject.org/tests/selinux/pull-request/488
>
> Smack also uses CIPSO. The Smack testsuite is:
> https://github.com/smack-team/smack-testsuite.git

I tried to run it now, but 6 out of 114 tests fail for me already on
the baseline kernel (I tried with the v6.9 tag from mainline). The
output is not very verbose, so I'm not sure what is actually failing
and if it's caused by something on my side... With my patches applied,
the number of failed tests was the same, though, so there is no
evidence of a regression, at least.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


