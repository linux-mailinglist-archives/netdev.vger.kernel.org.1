Return-Path: <netdev+bounces-163746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B3A2B761
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0737A32C9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5EB1F95A;
	Fri,  7 Feb 2025 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymr4lX0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB917E4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889774; cv=none; b=RL5IY5F400ovrFXGigLJSfaI9NidboMSdP/CNrE8aKCizJw5A2NUnifWxj8o54GDCFGIP/TEqts30C+EjB5l3Mj9FxPHiJYKs2rdAMbbbKLov8T2aL+3Yh9ZN9iVbKQmo7mLMqCf04ieWGqAAf3Pue8NzOn+XhWeYDheSSW7nMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889774; c=relaxed/simple;
	bh=vSNj04mc2MynQa5BlyZwFPDijUHvMPyhLCaUo2qM1c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGG84cigFJsv6+IRWwcb6pszddbcXvTXlxegOrXe72VRq0dlN8Wog61Zz8xAZwp6E6fv6LIf9K/bEm3aDfPEIpNbWWRBOZOPlEHssyQl7tjie5vkV1QZX5+SpiuNgoBCPk3lAH4W6oPGalFzfVjFZAwdQIx572VSrWDjxaHsqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymr4lX0y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f032484d4so71515ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 16:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738889772; x=1739494572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwcEla9N2hy/vngJrrhW7t24YK1eBCcJFs+90wmxQiY=;
        b=ymr4lX0yBQUwMcsz2yS2O9wcf0PVrdXe467Q3UUfwAhHCXw6/92Tpyna2Y+O/HmJg9
         ai8pwYS4KmTfoRTVQmR6RLROxAsX2aa6h8Sbh1yMmBkLw6W/w5C6ks5Zjk16OXzPb2hA
         xtHUIVOE7mAt/MH26q5p1j87+WRL3Ph8FRxSTwS8X8h9/ie5mVqT5ifTGDKN8nGhcg/X
         3RhYNL1MbBZCzuSyUXKcyUzC+SYjjo0bpHqGj0MH5QQqwwzGcCjxOu7wYiG28pCtyLD9
         p6r1YxKuRaSmj0MWAqny2SLj1eqySK/lVffSUwqirghgQX+eYzmSO1OFCq5C4EjrbPSp
         xNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738889772; x=1739494572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwcEla9N2hy/vngJrrhW7t24YK1eBCcJFs+90wmxQiY=;
        b=Ad1y2uwPfXDzmv06UxrYotthfQSX33ONANDoAf3/DvCrnaB6O4SD1O7L2kljiMK9jB
         jDLPtHy6B7HthDXRH5SjdizE4I3ymdqvvVliWCd2E0xWPvv5ciGhSHTyZBREkbbvUXs3
         Zffg4SmVFGwgJ5wB3lGxIpwd8J2sBL9UrCjuH+Z6SO7Rc0Gay2pOT1wbfB9bYXBOuCjT
         CSY+skec+RO2/mkPLdBQOHQ23jT06t3OJ55+RWm2YXfLnKKAejntZ0ESX5qCCF53Fa7n
         gNy8OFfSSXEimf9HoAYYO5298ANmGl0H4HhOUkeidrB6n7hwZuH0WSRXaadlyPaIt3rZ
         U/pg==
X-Forwarded-Encrypted: i=1; AJvYcCXYcIJNzJwvCLJh333LaUuEu9TGh97NuhypXnqoh4V6UuR+1cFRuPNoy4VtddysGa12NzIKVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3T7iErTo+l0QpU61Ho4bcwrheNDM07jWbfefcoK+JmH5J/Ypw
	k1kAjxeSl/U0nM57+yMHXVKrhxlBGtH9K/nDgoSF/wtCdSsg5I/hVgQZ8rpKV6FMSAuGH3OgwL7
	1wuY/1Q1bfSi+LVPdNbn+emfwlFdNJZ+foh21
X-Gm-Gg: ASbGncucvY8mO2SyO+Py2AzgMqxAQmhUZQbDnj94OMndzF4mQODFBA+Af0GX3ZT1ZNl
	KieUZ78/Zr4K9AE1DKaykXjpvenHrAbGGrt/hLWX2WCj6zPrUCksStVjHepyHOr2Z0tRAS+pV
X-Google-Smtp-Source: AGHT+IHiaR8muEos/9jNd7Wl7SsHyLUuCQgLkeiUcdjpBqsD+KrN+9o1XdGYCk8ELM9G2OqYNtEwKnZO28w13LVpMfk=
X-Received: by 2002:a17:902:bd88:b0:21f:16af:188c with SMTP id
 d9443c01a7336-21f5263de68mr600335ad.23.1738889771991; Thu, 06 Feb 2025
 16:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206225638.1387810-1-kuba@kernel.org> <20250206225638.1387810-5-kuba@kernel.org>
In-Reply-To: <20250206225638.1387810-5-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 16:55:59 -0800
X-Gm-Features: AWEUYZn3MrV0oTEN4Yp9mcK9HRBRoS5ssmCn3dWoh4X2I352gfa2BP9W-7tzoO8
Message-ID: <CAHS8izNOCvtuND-4kjX_YPPuTPrFdW+mLghTVMG1zKmjnHmL3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] netdevsim: allow normal queue reset while down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Resetting queues while the device is down should be legal.
> Allow it, test it. Ideally we'd test this with a real device
> supporting devmem but I don't have access to such devices.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/netdev.c           | 10 ++++------
>  tools/testing/selftests/net/nl_netdev.py | 18 +++++++++++++++++-
>  2 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 42f247cbdcee..9b394ddc5206 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -645,8 +645,11 @@ nsim_queue_mem_alloc(struct net_device *dev, void *p=
er_queue_mem, int idx)
>         if (ns->rq_reset_mode > 3)
>                 return -EINVAL;
>
> -       if (ns->rq_reset_mode =3D=3D 1)
> +       if (ns->rq_reset_mode =3D=3D 1) {
> +               if (!netif_running(ns->netdev))
> +                       return -ENETDOWN;

To be honest I could not track down for myself why mode 1 needed to be
excluded as well. AFAICT it should be a similar story to modes 2/3,
i.e. we never initialize the napi on nsim_queue_mem_alloc() for all of
 modes [1, 2, 3] and this particular warning you fixed in patch 3
should again not fire for mode 1 just like they stopped firing for 2 &
3.

But, I'm not sure it's critical to expand the coverage further to mode
1, so FWIW

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

