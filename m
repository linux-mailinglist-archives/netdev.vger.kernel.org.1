Return-Path: <netdev+bounces-163596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB47A2AE09
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E834D3A3DBE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FC235361;
	Thu,  6 Feb 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4/XCpQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE44C8E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860253; cv=none; b=iJmhdZ8qQHkMgE/AqxY3vgtdbee8Nu9bynFUEzESPdu7IDxzY+hPrpkAMizkf3OFcPIztuRmx1OZhFp3FJc5hncKr0yrXg2+v5+sp9XOa/jXyKLQ9k7vxY6GOKRruIQU1TooMWiI7EO04OEQe+A8ga/ayVh92DrrSXSDvhBvj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860253; c=relaxed/simple;
	bh=jxobSfLEKm4wpFa23Dr97Q/zoak7/sZyLnpsDk0bgBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2sU5/yIazftsX7fqsj9Q8iBA6WoTtgTIXuPR0jU2OArUCyFR/sJaARX8wtcHv+yubVFqOz5KocG3Lo4ox+s1MvKmpLBMgdkjk9GRLvO8r6KXJJq9OQXUdb4aHpozhxMqUUcSySDeNlEGPzd1GfcqWJVy1y0KyHQAPjpPcL9AwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4/XCpQt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21625b4f978so31845ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738860251; x=1739465051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+ql/Xpqbf0V0x/nKLbPCdZXR2FbNas+vsyUMybto5M=;
        b=m4/XCpQths+QBZs+ZtGIjeTyu+7vfdPayepP1NK5ezCcJCaRMwiJmtZh6Gnr7IM85h
         mfMEz3GnNEQ8YsWLX9upA3JMu4vPGLITE9ic5M53TiOxB58M3wNV4Wrg9eROsYgC7osp
         FO+Z5rgnaD8by51DA4XB0Wpc6/CGdDKDItDTYAaOtpOe8IWZ1h6zompPYSSP2Z+OrXjE
         bYZELrQ6QdyxVaYVuM+ti2UaJHhFdi52YlUe21c8/V8X8Ukh3ckS9SfN9yotQjqdHxwT
         8j8PKnGTTLUivh86LeYgWIzRfeW3/b0phhlW/bZu2/UExboxGXUhtNkFm6cAQV6d7bNG
         I6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860251; x=1739465051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+ql/Xpqbf0V0x/nKLbPCdZXR2FbNas+vsyUMybto5M=;
        b=BXDwPE9g2d19C4j4OdVZQIMcL4ULnYBgdaK4JgvG0EfxB/onBVn3rBGW7Df18lI7iE
         SEHkAB8W9txFf01xgiqluf0FhkJwHjmOY27m19FNk6unNwrPsiKHDfFAd3y9t/NJB1B9
         ycn11V8g9GxD2ZUtkJQPk1ZXa1uIRfSVOQ9zjd4SECFBAzMZ5HA0l9t1KmQaIBk19J3T
         J1yRvtR5rCpxgt4zHkJS10m4Z6iPIUKERVO/i0BSyYJ/L3eJaIN9JhfDLTSU7Z/BvySU
         46Eta5Iw30ImvxJ3JdtEMmpRcC62FDQwNw3+UZfRk9oyRoD9TDsIremRwVwTE+KK1Ru5
         n2qg==
X-Forwarded-Encrypted: i=1; AJvYcCUyysiSGKn8ApP8a8YMZAHf3mFaUPgpIRoTEOouvXgyyhJxGYf0ll8EIaJsyMOFJXnVbuRmxkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMH4IEKKj9+iNB86+cnh0RD/whHMkc/GVcZp9FhaowlxKmkddO
	WX7NFGNwLe9KZMgbumPP9EuIrvjLbdd9y2KoViQ1Q2MwEDXweADKRyHXS4EsIn1Mx5UQLsOGclC
	fFWGwhL+Mgz3hhpIVRe3TfKcsikjTXAWeqRtzgkn9shClDnp6gY7k
X-Gm-Gg: ASbGncsSGj0Lo/mcQZU0YgZjjEqKJg5sckmcZhZ77bQy2Yo1YeS1IrLXMLQ5iTvMii3
	n6o+KdNHw49C2AeHD41SWsMAMugEGQ/W+c3iApFBbbmIlKBktJc0j/lYtB31aMu5tdy0zFQRH
X-Google-Smtp-Source: AGHT+IHHVnxP8jAJO/n9BzneLMBTjdXVIFk7wYnAxeqZWgSRMHX1DfQ/g5uHRsyukWyDa25O8b/aux3ZXa1CZWs6UNU=
X-Received: by 2002:a17:902:8e87:b0:215:aca2:dc04 with SMTP id
 d9443c01a7336-21f49ecb21dmr537845ad.26.1738860251012; Thu, 06 Feb 2025
 08:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205190131.564456-1-kuba@kernel.org> <20250205190131.564456-4-kuba@kernel.org>
In-Reply-To: <20250205190131.564456-4-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 08:43:58 -0800
X-Gm-Features: AWEUYZmnlcHWLL1eOdozVqY4i3L52yu2mItApsOOYwALrCrPJ8E5V1b0XAT0spk
Message-ID: <CAHS8izNWmcYvFBNwa_kUrWFWAHO_6h9Pd67BTCadeaDX3H8GhQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] netdevsim: allow normal queue reset while down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Resetting queues while the device is down should be legal.
> Allow it, test it. Ideally we'd test this with a real device
> supporting devmem but I don't have access to such devices.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  drivers/net/netdevsim/netdev.c           |  8 +++-----
>  tools/testing/selftests/net/nl_netdev.py | 17 ++++++++++++++++-
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 42f247cbdcee..d26b2fb1cabc 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -644,6 +644,9 @@ nsim_queue_mem_alloc(struct net_device *dev, void *pe=
r_queue_mem, int idx)
>
>         if (ns->rq_reset_mode > 3)
>                 return -EINVAL;
> +       /* Only "mode 0" works when device is down */

Just to make sure I understand: modes 2 & 3 should also work with the
device down, and this is an artificial limitation that you're adding
to netdevsim, right? I don't see how changing the call order to
napi_del and napi_add_config breaks resetting while the device is
down.

