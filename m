Return-Path: <netdev+bounces-246355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5FCE9937
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84673014D8F
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E1B26561D;
	Tue, 30 Dec 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAW3Cd6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448D18A6A8
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095426; cv=none; b=OvdJWc3J25uHNg23FzOFRZiGRXNt9yHFggmepN36pk5WbjCPLE9p+2tF/Q1LrSHg34cLUYgyUnXL6w4HjYgDRd5n8VIJ85Rdx/EBygOjw0bVizJ74C4A6DB2CX6NfFfPPItY5KsbvFJUw0qjOX/3VxzZCErt9bdfaMlEX/hwcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095426; c=relaxed/simple;
	bh=6IFLil+wD2JSrCtWOl+NqVwmMKqZIPHW8twk7WZ3ss0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU27cxbulAht0P006C9aG5FEDQ7cGtCL3JMBVazqPAiL5tkOuMBWPRW5/go6FxpazwHJwDlHvDWIxDuOFLkly444rKVCNU2EA6a8NulgLBWHnCSx4BNpLAju/eMlm0wchpVMomn+OxjuUfg41/ADMtO4yPuaIonIlPpKxD5G+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAW3Cd6N; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a1388cdac3so92143155ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767095424; x=1767700224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdHa8PFyWxGkeyfxKnoCO0rhiy8W3DjG38QD2TZnWW0=;
        b=fAW3Cd6Nl6mZ1k0UbWSWNYWblZe+3rXre+rGWGenThw4I/xxX35ke+57xSWQT1TiSp
         lvGK04o9vfMdwrp6DZRzsxHtfdbeUnaobqhNjEsAFC9TXAVe0wtXBIQV3AYRciPfrkEy
         Nr7n3xEHywGWGBlIzcaUK7qrTSUb8BhRxGB6Wu3+9to+MWbBPA+2GN5C2HVhIbCgVSq/
         C2NIwVtBVs5GOo52/loA7UxiBJy1IeLU2BnWQsMm17IxqvMehLNP5vMGWKBizJuCSd2P
         7ts0723ZzBTxdtqjFD3URVXYwb0gNGpc7wn+u31Yz7x9F+AaUSEJCrUMQRb4oqVwAIBn
         xmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095424; x=1767700224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdHa8PFyWxGkeyfxKnoCO0rhiy8W3DjG38QD2TZnWW0=;
        b=lZ62DTCyGSBWg9glg88OKNoeHAw/VqJn20J9qOihm5sRF745MIS/sA4zImb3AlNaUg
         Ku7pgKpXpgWltKxGcj6xEFytlsKpwArSvGXvQVRlZ8gv9++32HrBdukP00/7i+Ce0xlG
         xf+qrMlXNGcx0CLdYWn8q6VG9nro+t5Lit3tMGjD+OrzBTC7a2AxH+Ksv9y+7g3V/frr
         204TwYPD89AcO1dpPbFII3lk/NB/MRkGmePc+eqAdL+aUNgIKopOfDgWfq8Lashm8JUW
         zej/EM1yLufSTZw3p/lDbtXuYsT8pBowtV+y11DHpUpaFPwV/z6HKfZk9AqFd7juVd55
         0K7A==
X-Forwarded-Encrypted: i=1; AJvYcCUtKCsD3ce7rjJwVIqCSzlCOGvtEWOaZfYCWg4jH0Vzqy3Hw/1KHmuNR1TvxHn+R9kx/CdQlV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykONRNr4iEE0uGAPC/J3sEF3qreEoxNX/GrN5MDAeN/p9VhKUq
	kjYG1odWPpS+J9xsZ6KfYta24PbqJP1ZphTeBUGGG91MmfnHR7fv9oazPhj+s22jdCBPK5cmB93
	lQGeRyBeEA4sYfHqerHDeT0tcSVaBN2g=
X-Gm-Gg: AY/fxX6c+2r5sa/1GeCVD8KxFW6Lm6Fnp5mk4b3gROqXOhxcO1sXHk/Eeaz+rdsJEMF
	Mi6IpU4YLdfcgzQkCZUxznaedhmyCwcaDlIqbAjYTrosyaEpRywajUuM3IZnDUJz+9GJiAI2Rt1
	8a/AOaHfkPJo8itPUXiRRykkwNixnRaVdu89FLHv7WismUoi/JY1OKNFj3nweoCX9Z7SwM7UKbA
	3FjJtbBiGaDzXbsC0/ngUN1cqmRB0Es869cG9i/9OS+gp2YnCwa1kKnMz2W4s+kFj6QaRRngg==
X-Google-Smtp-Source: AGHT+IFaPnCWi9xdkDb8vFzhvIsC3MueEnQ+BB8sBt9iWzRA9eQOUa/HT7hEudfWpE2f7TWEE5NOXrF94uUxKwgpz9c=
X-Received: by 2002:a05:701b:2404:b0:11e:3e9:3ea3 with SMTP id
 a92af1059eb24-1217230f5edmr19919889c88.50.1767095424448; Tue, 30 Dec 2025
 03:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
 <f04e466b-8b8b-466e-a67c-d7fbfea2fbfd@linux.dev> <CAJ12PfM3zkJCJLJ3dLtvab2t9O9Dqs8MnoEo=zDb5OcyAPDuJQ@mail.gmail.com>
 <67fb6d48-148f-49c7-86aa-4f4244ec6f31@lunn.ch>
In-Reply-To: <67fb6d48-148f-49c7-86aa-4f4244ec6f31@lunn.ch>
From: TINSAE TADESSE GUTEMA <tinsaetadesse2015@gmail.com>
Date: Tue, 30 Dec 2025 14:50:07 +0300
X-Gm-Features: AQt7F2q3p2tw78nqLVEpOi3ZlDRbSg-heSK6aPSTrOtUj-3XoyWPpVwud-GOsno
Message-ID: <CAJ12PfMyMh6O5K5Gs=gxSoTmL1ORg6a7e3Q2d0nOSyYEhuyOzw@mail.gmail.com>
Subject: Re: [PATCH] Fix PTP driver warnings by removing settime64 check
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 1:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > This patch resolves warnings triggered when either gettimex64 or settim=
e64 are
> > NULL.
> > The CONFIG_PTP_1588_CLOCK=3Dy option enables PTP support for all Ethern=
et
> > devices.
> > In systems with Intel-based network devices, both the iwlwifi and e1000=
e
> > modules attempt to register clocks, resulting in calls to ptp_clock_reg=
ister in
> > drivers/ptp/ptp_clock.c that produce warnings if any function pointers =
are
> > uninitialized.
> >
> > Without this patch, the following warning is logged during registration=
:
> >
> >     info->n_alarm > PTP_MAX_ALARMS || (!info->gettimex64 && !info->gett=
ime64) |
> >     | !info->settime64
> >     WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x54/0xb=
70, CPU#
> >     2: NetworkManager/1102
> >     ...
> >     iwlwifi 0000:00:14.3: Failed to register PHC clock (-22)
>
> It seems this patch is no longer needed. But FYI, this explanation
> should of been in the commit message. The commit message should
> explain why a change is needed.
>
>
>     Andrew
>
> ---
> pw-bot: cr

Hi Andrew,

Your suggestion is well noted, thank you!

