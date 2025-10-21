Return-Path: <netdev+bounces-231247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E389BF680B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7C5189A5C6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E532ED3B;
	Tue, 21 Oct 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Kqkv1R9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875D32E73D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050544; cv=none; b=O0NjiFJPZBhDkSErZ9MKpDn8+fKsIPvwKNSPnNAXQfovUYiOLRDH4h6O8bDSM07WSXWxxxmMFswKMqmEKewi34T+jtzWfy7Ug3Aw9z/KThHbawU3F7f5R5AOB1sRdwYYc8le6R55HTdbMOmaBbSEmTzWlZbRMIicucP5xuH3rg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050544; c=relaxed/simple;
	bh=i/TX7MEsAkgjubTCatvjPm9vWeY3Nm5rFTIQuQTOHOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys2UuLDDk0DVVVUkj6yb+5MBZMr7sgw+GFg+tN87ZaP/7cKn8toXgZSLYpAdWWGY2qNCh2ylu3b4z61LKwkyi2gCNvrlm0TdX+WE9U8ul+g41AOMkdl9XcTBf8bGXoLTOtdfKQdK5otUFXpFUTTvdiJ4Fuo2kNLrwIa5MY6EHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Kqkv1R9v; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so5324611e87.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761050541; x=1761655341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icUi6yhGBFPCJDF6YW0uPghHiBtXnlV2bRo9arBdueU=;
        b=Kqkv1R9v16krjtFlriNDUeNgRMW2oEtVvgItTaKKtoSbSh4A87T4PUnVWkkD5tdSZD
         Ziwh4L8eJh7b+06X814b163FC4yyZ33H+oLR6aI1F3TWLbHny+E1YR2nfgtW5/iEYbWN
         bNL/YGKJyuL63tu1C9hvqH+JbLY8adDcHMptFLMJGMPMy8g2XK7rli02EfxAdEiZPL0Q
         OJKY8DPXaW6No9CKIgvbrwXkOizxKIxIOCtd/ljARBqt7QdLCtGP5CbG/9sbiAPwWMga
         HtEIsrKJBEU/ryFxhpGkRbKwgdchkva3VvoQYcXZYEh+go77+ZyOLjJfMPNbJFRBGVX9
         JKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050541; x=1761655341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icUi6yhGBFPCJDF6YW0uPghHiBtXnlV2bRo9arBdueU=;
        b=J43ohYx4Q8D6FCGWnwchHalwiMTMIuF9utst75VEfc+eu9BZhvMp/Uq7exEBKLNuzu
         kHm5gBDDeB+Xs8LCaK9UVmMKPEMN2Zhe58inPkrbqR4ZYuUeCg3VIhV+5l4mQeiK9tlp
         9QK2EiI45fj4MeYpfoUZV6mrBFtDS/go62Bx91NFrrFmG7yawAoSLGsWfYDhmBGjqswV
         nfI1TqCEGNebOypbVM44x4fQ/N/HaZyJQQ9FLEw26BDq/MKJKnvYF6z3RCv5vaFNhg2B
         eOxRJ/2TIjSYbfu5lnxcBVV6SsMRwrLFn3yOGZxok2jr4IQCkvaUJ2WjAUvFWTUk5s8q
         bz+g==
X-Forwarded-Encrypted: i=1; AJvYcCX/PgXugywBSZjzNn/Mz/xeoxFB+8RVaLyWMduBf2NEfRS+oi0yA6rTfp2ObH54RxilsUP3n5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFoS0lleFjR6YxYyFPR+Vd0/qj80t3Hbh9S3Ls3g1W1ngCSqy
	+2Q5lNvDRA+VnoAV9NFHdG3IIKe9wuD4ga4eP4L/rVK4zWlbbDrHgAbWVLuZX8CcV4sWQvz80jY
	apttRgEkXrjsS2Z9RYGZCWorxs02TLLt6AMsIupnzKQ==
X-Gm-Gg: ASbGncsdluMJOkczxVr3SL299UwUwXG+Xh+kWocvInT0Iz3N6xvLhsKrbmOMdeEPSf2
	g1H1KZ0SKJHCPIir4YjHhBUtdw/GugQoeraF24pwXa+NBpCWGbxnb6riQZGh+qXj1zGQhFTdEmu
	yxIXkfIadhyAQQ3qpmUFfVquDWbVj85wBjjUC0vH6MNDlsPyfdZB2/ioUU7UzEgYN0ElcSXFiGV
	Re40zvfuolYhpin9GgLc8KHcaiEn7JdHK9mcHK6EIrLRODLQv45rYEZXq6xu/msdL2/2qDHEkvi
	HEv9RKKoWnFst+0f
X-Google-Smtp-Source: AGHT+IFGDPpBTeZONomFBAX1YzaiEBTSDtfpfJUCvTHtBOgU4ya2tYe3GNuR1bPQdzr+C4NaB2OPAwZEOmn27L5nTu8=
X-Received: by 2002:a05:6512:b1e:b0:58a:92cc:5819 with SMTP id
 2adb3069b0e04-591d853543dmr5476524e87.36.1761050541329; Tue, 21 Oct 2025
 05:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1v9Tqf-0000000ApJd-3dxC@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1v9Tqf-0000000ApJd-3dxC@rmk-PC.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 14:42:09 +0200
X-Gm-Features: AS18NWCRXicscJ1flw2qh-h28tM6CuC6Xw1MuRCeg5_mvREPDMfXTaEvmtfWRbw
Message-ID: <CAMRc=MccHEaXs6KJfG_ph=wG5TS4UTpG4Rzj25C4qbC_fCS21A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: replace has_xxxx with core_type
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, s32@nxp.com, 
	Samuel Holland <samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Vinod Koul <vkoul@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:41=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Replace the has_gmac, has_gmac4 and has_xgmac ints, of which only one
> can be set when matching a core to its driver backend, with an
> enumerated type carrying the DWMAC core type.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> After the five patch cleanup has been merged, I will want to submit
> this for merging.
>
> The problem:
> - Any new stmmac glue code is likely to conflict with this.
> - Bartosz Golaszewski's qcom-ethqos patches posted on 8th October
>   will conflict with this if resubmitted (we're changing lines that
>   overlap in diff context.)
> - Maxime Chevallier's tiemstamping changes will conflict with this.
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

