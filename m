Return-Path: <netdev+bounces-158831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BEA136DF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFAA166D8E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E331DA100;
	Thu, 16 Jan 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivU2pRFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D631D89FA
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020695; cv=none; b=auxzKww4Poeb6b6SR4HIIJBls25DlhNj9oaa1TbNHesu108c53z7xr76t4aAhOXKXWPGpuD7Z4vacxKywapryPcabEj8nipIqJrP6kiFhsrkIG7eAip5jIAuK2KxV29UBZimcr9IYTsx9Twoigsa1T59Vvz4y23LUyxkXgalztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020695; c=relaxed/simple;
	bh=8cjgqBCfUvmD/Nakzi/u8g0O25WgCwHu79rBw/5yfFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZSEKpL3AjXmaccv/UO7H0VkyeIhojD58TK8uB2I++shjggPrDmft1K8SAS2kagxNmXSjd8+3HOOrwyyaoU6KjrBZqKU7eM4Iyvg9B18m0WlnicFMM0zrR4WgXyl+wm+nFh3JPd5Z0dF/9og9jSrr/tWixbVgaX5vQIDOxSBxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivU2pRFl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-304e4562516so8096181fa.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737020692; x=1737625492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLkMsfgSGfno6czydYkHbxN/rzByw44hUzXqWAYxloA=;
        b=ivU2pRFlBIetqObhH734/1ZyBnB2kL6P4SC05Y23hqyN+2Q4jUwylPfpPT1NlhpnEr
         jTqrQkV6l2swzOOgwp2hZKzDwxSL/Ojw5OOM6EzhGf/SkQXdS3ZOXxNSq4l987pI33AP
         +ZtTnqK1r3xoUKaYIFkPyXrLnX00odLQ3ujoN/xURE8Ra2eGZa83elLBqG1d3SS0r/f7
         M46TXsgK0KyjkLTmrG6SMc+FJHJn2IhnMrBEK0P+9cjeIvMNOpERF1QPB1hPxVynxYak
         07HVrVlHDF/VCNq/aZT69TFEs/HwGY44l5wnsZEYeD26LJgzv+xgbaj622gvmXZxDp3q
         +n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020692; x=1737625492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLkMsfgSGfno6czydYkHbxN/rzByw44hUzXqWAYxloA=;
        b=vxngtGjIGVWuSJ8TLinkhNoYgSQIPRjvx8Aj6BcfktKNC1VmdhS8UIS1MiDNReZnaQ
         t9ak89h/utorFGBzUthZsXOI45D/NXLcF56xMMPF8GOKhRGo5tcQIKDn0gB0iVuYQAMm
         xJVjllbc8jMheKpZVrkwo4lfeIxXlMCr5LL+3AfVvmEbr9Guk5kxx6Kgq4Y/qLWf3Zkl
         dsAWCeSFAVC+q/OIcbv8Ht0xNGsrFqElQmiyhBjGgECPVabpWeIqvQduAG4zuzyUqFGg
         WoLyF5W6ukufHn3UvG+zOf1Mb7hQxBP7EoDGw2rhQvqjVumnf+yjLUsM+8JgtzzUg/kw
         JPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIqJOXkNsIH6KorwEbSsO8yJWAKZg7eH7+wbltHPDN6eh1UgfTJYuPOdP20rk888iT9Vr8oXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRICmb7FYsCXkxSlrf2DFVyC6o7wzA9ud4CmMD5d6f4mY5DGlM
	NTUl7zPWeOOYpwvf6Y3KOEi5/mvJfu5tZ8pbQ6i+I+S9+pHX9uxXiIJfnG5Zua9ZmBR3im+UWKQ
	PPdlQoS9sKhuPRM/AIck4wovoopRBMUkXrVEg7g==
X-Gm-Gg: ASbGncvPLrL21HWGdose82IO+UA6wfKZ6ZNZjnpPD17ATDgTNLYTcCeqcwGmHd0tSEC
	21iJtlNhIklbfxSIB2xDL0TFbh/kyeBoN4ix9
X-Google-Smtp-Source: AGHT+IEO2UrQBQPPNxhpuGsIyQinj9e1e00jDeeneDUGdhuo8jbsWgvgZ8CLJIBEXCxSyfKMiq6XS9YXE+6OO6TGYBg=
X-Received: by 2002:a2e:b88b:0:b0:300:31dc:8a4a with SMTP id
 38308e7fff4ca-30630686f10mr26379861fa.18.1737020692039; Thu, 16 Jan 2025
 01:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jan 2025 10:44:41 +0100
X-Gm-Features: AbW1kva0mDHb6GI_lH7zjDAzCdNV603y6c8zcMnZJBBXOm3OjrAweUvcR2aovV4
Message-ID: <CACRpkdZfnqiwPC69XXcX6Fqokqxu7PV7oc4ph6+Q+Au3PmzZTg@mail.gmail.com>
Subject: Re: [PATCH net-next] dsa: Use str_enable_disable-like helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:47=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

