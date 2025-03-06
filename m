Return-Path: <netdev+bounces-172361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4483A545DA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D24016C916
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103A209695;
	Thu,  6 Mar 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLXJ068n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FF20967B;
	Thu,  6 Mar 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251948; cv=none; b=NUikHsPUpX09/X9R3IzteJ2s/6VRx5uZXGvqP+MswBSIiHWq5FLBQ0WvKVxFJuFvhR7Hl+QenNwd+ED+knk2OpXz/WKv/lYyP5u+GnKWmjPh5THLEdZSYezs9DBqBdwEhhqE1hItuNdqe8JxIQZ5IrpLUJW4f3Eutsb9NcyzN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251948; c=relaxed/simple;
	bh=tBF7qxWzzza3ZW6Fbt/OJqSoYXdfOO97tMGgtm4bT6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4ekfhXEpGXLiQWpukbcXeFnfQ34Vfz1Ot/qJS92UM8DNxDCsgLb2AhPskrXtp5OxaQ2/yx21TX+86d5zf4gkbiqNkxjji9ahX44KWaHI+xkXEodshY3n3n+4UOooccVSyJR8KgLeKUVPgQahe8Tg0f99F7SLra76TxGhGaU4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLXJ068n; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so641730a12.2;
        Thu, 06 Mar 2025 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741251944; x=1741856744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF1a4xy5g06O2GkwhB05ytvAS2BqrA8TH0Jy33gZxiw=;
        b=XLXJ068nQF617QcsTcy1UAF5lPxx3GnBfjfa+C36yU7rSvA4xLdLGIV98Dzg92NEub
         Ke4Vsl9QQP3/hYA2lUpJxYpMzhUg6UzKCSuVoKcDueZHwz7k0gzA5j+lBrotssOAF+bY
         Qo/+xo0UQPmC+ubkoY6uDJTaE6chnzu4+S8Ovpipd5Dvc0bhkDwo7sonT80+tbxpfovO
         L71ZKmeTWkx5/JqZKdfTHG0CCior8j6rE3HND0Vvdyy/H4TmAPoHutJtYJb5MX986Ast
         P96sYYDGA+3O8TQUaTyd/0t9u5fjDWW6ZZ2Sh0IZq7ItdhNiq8CvkJQEzl563vnlZwdo
         V27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251944; x=1741856744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF1a4xy5g06O2GkwhB05ytvAS2BqrA8TH0Jy33gZxiw=;
        b=t75E2Xs/JxKskRnREqvL10iIsbBEeGOJhQKHNCFrjf23WXAKef896ef/eSRagyLRao
         vPAlpPy9eAHgcRUjrJy6D9+uGSk8lLFKf+SFKdywABkymsNhinURFtmOGi/wFeHeKaaC
         9LRcvYFEVB8egXFwOkt/yBkQjR18JTdJps1JOp3MncfpdlQKVSOOn+BqBC0B6A5569HE
         4kp4q+YKImyhM2KvrXo8vNOIv25JPjk4eXAFlPHNdnZhcrx2Sa2LilvOE9WaPCH8orzA
         669J/9A3x8qU6Sp0BYr5iKUgAILsU3zb9oBDzRLAIsN3J8NxTNqX6LPl5ZY9hC0e8tro
         2gqA==
X-Forwarded-Encrypted: i=1; AJvYcCUV1T8Ee4Ctcu6y+cwXmhWab8/azRdpmmISv0M5Ax9E+/M7CSA6Ox0p3w4tUby9SuGQduCZEg9Q@vger.kernel.org, AJvYcCUaod/z7+h4i9R453j8SDS5a/5WQv/eOn93pvRGsML6jy30ydvlwuHTjVlzIkdNaQ/NTx786i9/sUQlpfc=@vger.kernel.org, AJvYcCWNfPtdKKyJI5bndBiGngVofVobEkyGGh+g7pWBAfQExteY5Xj/yKyW5MnJGBC7rHWORaLFls/XAtXpZTxZuEIvKAdIeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQG3EqFJ/km3oC3xEwXWsaKN9Ti+zv0h2z980u7RK/NVqvYEt
	XX9+IL+w+5wx7xt0PaRz+p0UYLOwtj6Ry9Qz42BbjtqOncd5CiEWgH3/5C42DAksiJg27T/caiV
	zsouH53hrV1Ujvxj8VVPNmQV7ZqU=
X-Gm-Gg: ASbGncsoxe8s33U1rOfaCFTrrxBBmX4W8O1FSbNfkfA8b+MV4ZRcqRWonHnSISsJbIC
	yaVlb3WfqeVWXXdvyxA6EoqSSD8tvvirOL1E9kOIIbRmw7JBrOzmrMivvUKMMhswx5NR9WGchVE
	9ENw3TWk0jjJzNwRHCww2uyYv94KqB
X-Google-Smtp-Source: AGHT+IEZf+mByLmt2C5pECGvzvf9DNU4dvPx4rdt3aJSm/Ho3YYl4NaclXM6a/5zGcCuNqGotXObOzkukzSbT9Fj/lE=
X-Received: by 2002:a17:907:2d21:b0:ac1:de84:dea1 with SMTP id
 a640c23a62f3a-ac20da878e7mr662880966b.43.1741251944175; Thu, 06 Mar 2025
 01:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
 <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>
 <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain> <601c88fb-8ec8-4866-a45d-f28dea6d9625@linux.intel.com>
In-Reply-To: <601c88fb-8ec8-4866-a45d-f28dea6d9625@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Mar 2025 11:05:08 +0200
X-Gm-Features: AQ5f1JpWFPB7HB7xwoyOVydwoKV_kFgASdMk4fd6Z1W-9JCutpUYIBvLsaYm1DU
Message-ID: <CAHp75VeOKbAsvSuf5+VQnGFmUcN92TNnR2eF1+70h3PjaMdMqA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, David E Box <david.e.box@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:39=E2=80=AFAM Choong Yong Liang
<yong.liang.choong@linux.intel.com> wrote:
> On 6/3/2025 3:15 pm, Andy Shevchenko wrote:
> > Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:

...

> >> config DWMAC_INTEL
> >>      default X86
> >>      depends on X86 && STMMAC_ETH && PCI
> >>      depends on COMMON_CLK
> >> +    depends on ACPI
> > Stray and unexplained change. Please, fix it. We don't need the depende=
ncies
> > which are not realised in the compile time.
>
> The dependency on ACPI is necessary because the intel_pmc_ipc.h header
> relies on ACPI functionality to interact with the Intel PMC.

So, that header has to be fixed as ACPI here is really unneeded
dependency for the cases when somebody (for whatever reasons) want to
build a kernel without ACPI support but with the driver enabled for
let's say PCI device.


--=20
With Best Regards,
Andy Shevchenko

