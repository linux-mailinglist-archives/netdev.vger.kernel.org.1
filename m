Return-Path: <netdev+bounces-231636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7BBFBD35
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A305218C7A1C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032C34165E;
	Wed, 22 Oct 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tkC6Iyek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2B341AD7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135747; cv=none; b=dnVFAM5yQPAzi6KNbBoAZ93KiX/Mkv5O87PPDShh4irGPEMwTSKlVGvhPfaA10uGQ29AA1aTRf2sj9Fw+25Mpj7g2puZqXYjCpJfg+p/o94psPEJueBEhIY46E7Rt5QZKKQVT7NdukZfCc6C1ZXWlorkuzH9D/yCPBSqP8NhXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135747; c=relaxed/simple;
	bh=BElxTAqqQJrOvJZFCpntAANa1E1RXpxMqA95MHL9q3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOe1HNDJSUctCVfeMn3Tl2e89CPJLGAclhA5IT1fG//aC/8Csxd9Z2Tz71W0YPbP4hh8sqV2p2OmPpuOjB+SKVAhAcn8hYTwavKKo4QG62Eo/Va973hgiHEXGQG31ZRs2Av727qsfr53LCVC3DPC3iqE4EtzYzYDNveLvxI6bBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tkC6Iyek; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-58affa66f2bso8036301e87.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761135744; x=1761740544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BElxTAqqQJrOvJZFCpntAANa1E1RXpxMqA95MHL9q3U=;
        b=tkC6IyekXWvqNvAZqlRKLLBx1zlHKlMKy9AHypgVQKvlOe56k3XChntNbSdlHkAUy+
         Xf/FvunI1z2cdFIdBOKkTcdoEjf+imBkwT1skSBCHgIQj6Mm14EWAQMyGLsA3nkq2qsr
         zJssNoPnhy1Ei58rouZfoV3dX9TFV/gVxxM5hxTHWNyg7FOgEohqCG/HB58DMHNPirVk
         KNnXFthviULPqHjQ9r4aUafqb62fQgITQF6eZhsO1fq7cczxiE5SDcM8y6rawXMCTv5N
         /MVS/hEpyTOIsN7+iW/xsXGq7RdSZtfXF4nw+pU7ZB5UPs/4R29eqU1SlWLyS2TWLyUV
         Vsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761135744; x=1761740544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BElxTAqqQJrOvJZFCpntAANa1E1RXpxMqA95MHL9q3U=;
        b=bqWymg+e8rwC5DUlB3TMExq90WQ7xNzV1VW0esDfFKMD40ONzZEKP/Di6vxJ/yNZyc
         Dn5oE4XsN154P5KRHBKaJETBbcPUbwL8X3AM32wORG0bNlnZOJR729DUU0foqhPGGtzE
         Kapwp6YE+XvovRtFxer4MZ5QXpaUN445SyF6mvdDwS7bu6S5o2ZQ5mQ5CiVhujmSVlt/
         oyQCUq4mTxfTiAyVSe41a5WXtx6bnn/HN25+xIoFdGgF1KpDgTe1BhoPQdGYYsnPm1xQ
         qcXDcPVP/bqkPaCNCUUVFQH1c7pTC3VZXEI18gOAPXBwvDVq0P7cO4P9DzG93JTOrZOn
         veOg==
X-Forwarded-Encrypted: i=1; AJvYcCW4cB8Hh56RY0e2239Y8z+H+V/Mg0MQWUBNq0vHavjKl6HrxKtrIcj1h3zpEhIfyr3UPMb+s+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkA3BnrsBIdoVcYssiq+qzrS4+I2VtHKRe+cJo9ayFSwp3OIy
	27/gY2GCdBjGzLMyms0mAS6LuUgw3hJL3iOCkQBE7HVbV4UeM8h8eBapa/KJOadhW7AwRrlqPZf
	Y8hjmeOpgmuZmfF84e7Lt+QNcHCL1Fyg9E3Zda9GZsw==
X-Gm-Gg: ASbGncudfnJe1heNsDlPwBMcsl1/1k6kx8GTiWZcxw4zLxg0Dm0gYO8v+zosUbGGDBj
	lRzOyDFAKW7fBd+dtpaMCWlsChKUU1jz4Gjaf3sWjL3qY2FJ/QjnQpfQJn/lMup8iQoLnha0dD7
	fZGd6UF3q0llA1C4Sa3lCnAjb4yHp4MbIqLnr3nrBeAa4b6/b4FR1GtSeSOiKDZGcFAjMy2Q4Sk
	y6PVqWl6q0ewf2vrNvf48nuYIK+JfXHMiMYh980VkWbe8qMB3Bvz4fHFdEYjepzMyJg0KY/cvWm
	Y5ocA8iLPpAIU2Ip
X-Google-Smtp-Source: AGHT+IHopjIXv8jRnOM7SdbKGejL8HmLCEbi6BqZ/fl5zn8nC+umc/NX29TWVW5P2ry8JnLwjKerkQkMpRF8tHTR1Sg=
X-Received: by 2002:a05:6512:6c6:b0:591:c473:5bc7 with SMTP id
 2adb3069b0e04-591d858f85emr7186831e87.50.1761135743550; Wed, 22 Oct 2025
 05:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 14:22:12 +0200
X-Gm-Features: AS18NWDxwRikRa37d3sfSPIurHFNsUg5soxDVQrWVC_wnbUDqwvc55kIMFCSQNk
Message-ID: <CAMRc=MdWFL_+RJXPUNLd0BTyxbt9x8jztf5SDViPQCkxSqoHdg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: replace has_xxxx with core_type
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

On Tue, Oct 21, 2025 at 9:27=E2=80=AFAM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Replace the has_gmac, has_gmac4 and has_xgmac ints, of which only one
> can be set when matching a core to its driver backend, with an
> enumerated type carrying the DWMAC core type.
>
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

