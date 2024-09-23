Return-Path: <netdev+bounces-129369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A449997F0F3
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02028B21A2A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493971A256A;
	Mon, 23 Sep 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLPYjr2+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BC1A0BDE
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118031; cv=none; b=QzyOgLdzbcyUQBgMYmZ3q3N/xf7U+NSVpwWRyQm7F3ZZmq5+5fGXbCzLdRSBqbmqcmbDcG+FVSBW4jGqqt8ngvOFS6aIcBhyYEk9LzAdj73Equf+o3f/duq52ecVoMr3nbxBHqNqDRgGH/KeBWf+8pxY3KGLq81allIR1jONnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118031; c=relaxed/simple;
	bh=KAaix+v1Nmt80SgIqm4r/9G89wehkqX0YwhcE1WNplE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3VwbVRa1aKAcOfU0HduDy2zRVHD/cZ2NPbN7oIblea+ttVJZ8Q/Kj3wObOuji8qsEsEftrje07deoFxmSYG02dkRpmmgrOVv01JOrlhO4NhOnDwQgvyfLcHlmV7eDmw6B76d9KAE1C4jNBdVEcCu6qZ9Sh9HcLZ572DazIohnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLPYjr2+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so6378687a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727118028; x=1727722828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAaix+v1Nmt80SgIqm4r/9G89wehkqX0YwhcE1WNplE=;
        b=eLPYjr2+B11LsaauIL/OvOHnrZCJCuos6sdiCHRsOLA/8FhLszAVhoSmPso8FLlQ2T
         A6Sj1bIfcOw2W0+6Yu6Vo9EMp3f+JpmFRyjVB26f4HV/r3MyRlNxTMn76DDNAuGgeffl
         wzzJsBYslSwIWIF0HZn2MTUlg4TYF108TiKDjiMpi/RcTjmCJsG7Go2fm7PNmV34+Gmw
         gJuWjQbcTfYuPNf+ySNyC/y7KqqKFruXQgMwhoF19/wEMA9WDM/zVNP05PxT3UZBkU3z
         e74LSnU7/oI1f5c1RLw/+qeLdWxc2FNjmaaSkSA1uhPSTzRK+bVrvGvhaHqGk3R6r8CB
         vBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118028; x=1727722828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAaix+v1Nmt80SgIqm4r/9G89wehkqX0YwhcE1WNplE=;
        b=v4Dwlnuf6OlKo7l12PCTFfkfZ3vC5AS3QUZ5aoP/Vs8MtkX9JxA2a1uYr+mZ6tEfgE
         U2WEBFbyE3vW9MUPtUxQxaWc6V9to3dkyTDM35oCy2ryKZ4dzC3b1/3Emma2hBOvR6dz
         2u4mo9EnkmEGlQFzfUdrhIq+v1IsCSWu+587t1iF4mHRCg5QELHe+7vE1hB0icz5y7km
         ZY9973PH02Rbdeyq2W+fj8BY/huAl0BEw2zVzitjivJFyTWye1jgwRRUQMRFv0+jbW/x
         xS9kFNyCPXBick7hWZx1uyYQ2VaouD8Fq5b51zEbSOWbpF3HsTTvsAKgDXHvRQJCz/qs
         FbAg==
X-Forwarded-Encrypted: i=1; AJvYcCVs+0Hd9D9O9UCzRWZHTlxg6NCoO037t2lLACluem3kMs6rG4AsmmCQdePUoxZL9M+EizP+LPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QxyCEfxCda4JvNyrORBSIsJxSBuPi8yHYPnwpgZwVT91Z6Iq
	pVyMn6Ciph4huREMtPTIJzkw2XAnOd9+E14HmOs52BDWweHg7PeE/740JevtnBE0kix2sCYbiCU
	jmFdAuuTAF3pUGZyZ9wJFs+mUsyuFAYf1XOi/
X-Google-Smtp-Source: AGHT+IG9uvgkc7X2OG17Cu1QPn9Bc8J8r2Ll+iEJKAeFhDcwaXtWGop4ONOS9mnGDNrJ97x0HZLTBiwZCnl8ZD7Wnoc=
X-Received: by 2002:a05:6402:510b:b0:5be:fa43:8017 with SMTP id
 4fb4d7f45d1cf-5c464a3f568mr10793810a12.16.1727118027711; Mon, 23 Sep 2024
 12:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923170322.535940-1-sahandevs@gmail.com> <CADKFtnS7JRHz1eg8M3V52MAcJUW3bVch2siaoqQSqMPW7ZrfUg@mail.gmail.com>
 <CANn89i+asgFpSSAxavvLe22TW897VaEdyYzMJ_s0JpH+2_RzUA@mail.gmail.com> <93d71681-1a3e-4802-a95b-4156fa3847fb@gmail.com>
In-Reply-To: <93d71681-1a3e-4802-a95b-4156fa3847fb@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 21:00:16 +0200
Message-ID: <CANn89i+PnFohFa3Q0DhcVS129u8NVbtnNkUvgCFRKocgP2Ekrw@mail.gmail.com>
Subject: Re: [PATCH] net: expose __sock_sendmsg() symbol
To: Sahand Akbarzadeh <sahandevs@gmail.com>
Cc: Jordan Rife <jrife@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:45=E2=80=AFPM Sahand Akbarzadeh <sahandevs@gmail.=
com> wrote:
>
> Yes, existing program still need some modification in order to work and
> are already broken (from kernel 6.8 to master branch) for some time. The =
issue
> here is there is no direct probe equivalent one could use to update those=
 scripts.
>
> By adding `__sock_sendmsg`, one could attach based on kernel version or d=
o something
> like this:
>
> sudo bpftrace -e 'kprobe:sock_sendmsg,kprobe:__sock_sendmsg {}'
>
> which only throws a warning if it can't find the `__sock_sendmsg`
>
> - Sahand

Convention on netdev mailing list is to not top post.

Removing the static is not enough, a compiler and linker can
completely inline / delete this function.

Anyway, I do not think sock_sendmsg() was part of any ABI.

If it was ABI, we would have to reinstate sock_sendmsg(), not making
__sock_sendmsg() visible.

