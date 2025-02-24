Return-Path: <netdev+bounces-169077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9946A4280B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540953A6C42
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828D261570;
	Mon, 24 Feb 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="cMFoXYGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AA157465
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415007; cv=none; b=NUl5ly/eTOkCNb7ffi0UHhGz61IQLFAiNEo4fuEXNwrvC/GWkZdhajS3X8R+MMEhaT61/Z/jcogCDROPaTiQ8C1sjgaR8Ylwg4jJWAx86FgVt19Kijn3jY3ueCVZpmYtWsAiCgcA6uRWKDl6XsGLlJSnDuHYcIXpxbLWCx4OlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415007; c=relaxed/simple;
	bh=0uYjuk6mE2snGziB67mxxRwlBE5PpWNdoZF1RzbiQr8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mt/3stgduqSCnQeY+SsWcCd3+tCnBFE7DiP5SZXRBjB636dnJR5edclrhJS9Td7FSXbfQvAELBkNuW+0YCrxa8ZfayQwBQujsLbGnMTXIJfhU46UqZEKflC2+hFIWOsuO1BxgMUD4uWCbS7mmifQoD5+FMmWIOVzMa91Gt52oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=cMFoXYGI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd43aa1558so38522206d6.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 08:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1740415003; x=1741019803; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVuSofnGaHccOc0CbLUNBzJ0KuW/Yx2ONRYAm3brts0=;
        b=cMFoXYGIshLlbb6+jgKu905QNQ83OrCT5U8jQY0oxuJU8KPkd1//jCc9UkIfKT/nn4
         y7/iWbpnStFj+zW2JDmxu3pEwvULb+U/T96+2VhHrj51XYrAkpaTc+Dog1qFO1vWWfbb
         i6YwRl/H7viVfS92fun/wamt387HDXTSvZQbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415003; x=1741019803;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVuSofnGaHccOc0CbLUNBzJ0KuW/Yx2ONRYAm3brts0=;
        b=YZOIBAoxeAxr0ZIyZNzavVPAdgJyCPZ2b7BfxThp2Jgw8nNULTkfDtgdiWhUGClrmR
         Z5Ogdy6QhWyILmlXV6uy2BcQzOT6cjt9eLxBDgDZBrZTJK42yEniq+dB7bVIKzXkBI0Z
         XjPrXmYnAPulRifMkWIFDIxyfeX0o3h6uMOginKjp+38fGGZFm+ZLgAokrP7mwP2KTX0
         xGNWCuY2WtJEqUBL6Nd0WeqFFSdhXJ3Xm0dDZE5X8lqlAFKkmMEQVNEDmifkk3bNfr85
         l9HPfjZQ+Fz+7lvZHq/HuBW176AxwkwFJkAKqcSmDEFFnWMzG4RM+nlirlUUYszTxljI
         8jzA==
X-Gm-Message-State: AOJu0YzyuDsv32PWxRljaxU/g0g3QcI4DKiHxTOrkEqNuiSKPDIgowvO
	qlNkmyqyaRVFc+FSUzulX1zIBH1/6Z/rBv4OWs+ukpgRd0Oof5HO+NTQvBfn+/gx0uoEkzDIXuk
	=
X-Gm-Gg: ASbGncs0yE41y7TsNWyOFpwl4Gaw63A8J63x75hiEeTXTzawvtK1QMJDpaqVVZEQUa9
	RsnVVqNGyzAPflAK1ZwdYLMbogbj/jFfYvHMqnBTz1fQFvWaRNzhDrTEEbY90pLXo/WDKGOtNiG
	eEdeHdmzpu0XAarU5EhwW6v8gfH347UdGMqT9tbdhzfmXoG1MlK354SFBQxkAEnNPPlRwp/LhBB
	HxH+SmWClRilbAIqdkdPQOuWXIAbm/ebnJuoNBmmUhbOA+MjnVvJuTOghRBMJ+aTWNGdx8D9mG8
	2iTWgmgxNpN3OejmTBN8PzyUSYaLFbBviAdNfSuVBrJ9c5NspYo96cQB
X-Google-Smtp-Source: AGHT+IHyTDHr9r5xle+1v0EgjaG5t758xy8ylh5kD14mCT2drAU6K7Mo+oMmiEUkbR4qnijm4VKUkg==
X-Received: by 2002:a05:6214:ca4:b0:6e4:3cf1:5628 with SMTP id 6a1803df08f44-6e6ae7c96c9mr191271516d6.3.1740415002653;
        Mon, 24 Feb 2025 08:36:42 -0800 (PST)
Received: from smtpclient.apple ([2601:8c:4e80:49b0:a51d:1829:4848:c3d6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77a2bdsm134500356d6.11.2025.02.24.08.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:36:41 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH iproute2 v2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <395fdc3a-258c-494f-914d-5da3861c0496@kernel.org>
Date: Mon, 24 Feb 2025 11:36:30 -0500
Cc: netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <789337E1-213F-4FAE-A5D4-4647C0A288E1@8x8.com>
References: <20250216221444.6a94a0fe@hermes.local>
 <B6A0B441-A9C9-40B5-8944-B596CB57CF0E@8x8.com>
 <395fdc3a-258c-494f-914d-5da3861c0496@kernel.org>
To: David Ahern <dsahern@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)



> On Feb 23, 2025, at 10:06=E2=80=AFPM, David Ahern <dsahern@kernel.org> =
wrote:
>=20
> On 2/18/25 1:10 PM, Jonathan Lennox wrote:
>>=20
>=20
> lacking a commit message. What is the problem with the current code =
and
> how do this patch fix it. Add an example that led you down this path =
as
> well.
>=20
>> Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
>> ---
>> tc/tc_core.c | 6 +++---
>> tc/tc_core.h | 2 +-
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>=20
>=20

Sorry; this was the v2 patch and I explained it in the v1, but I don=E2=80=
=99t think the
threading worked.

The problem is that tc_calc_xmittime and tc_calc_xmitsize round from
double to int three times =E2=80=94 once when they call =
tc_core_time2tick / tc_core_tick2time
(whose argument is int), once when those functions return (their return =
value is int),
and then finally when the tc_calc_* functions return.  This leads to =
extremely
granular and inaccurate conversions.

As a result, for example, on my test system (where tick_in_usec=3D15.625,
clock_factor=3D1, and hz=3D1000000000) for a bitrate of 1Gbps, all tc =
htb burst
values between 0 and 999 bytes get encoded as 0 ticks; all values =
between
1000 and 1999 bytes get encoded as 15 ticks (equivalent to 960 bytes); =
all
values between 2000 and 2999 bytes as 31 ticks (1984 bytes); etc.

The patch changes the code so these calculations are done internally in
floating-point, and only rounded to integer values when the value is =
returned.
It also changes tc_calc_xmittime to round its calculated value up, =
rather than
down, to ensure that the calculated time is actually sufficient for the =
requested
size.


Can you let me know the desired style for commit messages =E2=80=94 how =
much of this
explanation should be in it?  I can submit a v3 with the desired =
explanation in
the commit message.

Thanks!

Jonathan Lennox


