Return-Path: <netdev+bounces-213493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991EBB25545
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98741C845F2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988EE2E716C;
	Wed, 13 Aug 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANM2VVHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A32BE7CF
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120243; cv=none; b=eQiwjeOwdnhDnXDUetoDyq+/Y2FlsScVMDNiRAXp9ie9TTfqP5tAaJgQovEFAlFApW1GNubQsVoOe/d5bqWuR7YDmnuX32VGZlaD0JSKK0N6vAx9MfiWn+LZoZoG2RTelO+wGFqrdMGuR/jHG7VaRJPQVyK0cxv1RNHTAGpfegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120243; c=relaxed/simple;
	bh=lYfqFlKPWMxCXweXeuuMBCix7a6a6OVoEovtyupYHb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6qdmlwQExAdVj71jSvXXfBJr1jA3ahL7i5AaAdw0yDkYm0OErdBN4O3DrzUgsE54kw+bpFnne5oHoLIHepyOurlWaWT7YTKb7fjNEO9hKS18ZLbsplglJSjJRR2Ir4wYbPWK6PgmO9Vtol6CgaV7ldIfmyDiLlT4zMtl4c+8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANM2VVHF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f8f22292so2160081fa.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755120240; x=1755725040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYfqFlKPWMxCXweXeuuMBCix7a6a6OVoEovtyupYHb8=;
        b=ANM2VVHFFpXzlkSJJSg9WhRqx1O9Rkzf5IyWwmMKvgkEVx1D/4Bh9I0Vj5PyeMmx72
         DFX4Atg/L5VeJDfa3QyP1WnlstajCCGsvbTyVhCxnRKA1ho8QwB2vG81vQ2VD2hdHymj
         BdRZFwPKFMJUJh1KAx71K2G90Kn2cm7D09zeT89b31f3bQwGNMgWgAD3cCQSV2UjlmXA
         FF1SyHCi+3CZHILU+TwtbVvCTMUFbVosSRQKk/X4xBb3ACTXY4J6R1chMMLmrSOMgHh6
         9RFiyTsAPNFmnoT8Lt8j/Y2iJeswStLxPFrh59uspnacLmZILmTkz/FjZ2G2dDWi4N7r
         DgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120240; x=1755725040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYfqFlKPWMxCXweXeuuMBCix7a6a6OVoEovtyupYHb8=;
        b=rFBhwSartybJU1+PmQTeIOSjskQI9ZqEcFVUNoo2NfF5QMPkyv2cL9xa/44bdY5JGv
         LaWahI4f464yS3vSJz927UwG9J5Fo3RGbIZVUZb3ZyctftxhyJps2VeXdKx8chqH2Wz5
         FXTESvHmvUFOD6wuFSiCnI4KoDgm1YbQRFMGKaQzm4QS7p/v1inyuc0MEW58hPBk6F65
         dFzFb8Hu/Bblxp9zvD+HJjYIMlqYD2vYIsLouHjlyofbbYBNzoiad72iHLc42K4Jr7Lt
         N+Yu26cQ5/0xtjm4BrePuboOGxQ2GaM/u89CIJNm7Kl5eV+LUYlNcjQnhgdszqR8z5r4
         dZDA==
X-Gm-Message-State: AOJu0YyoYlAd+JNQeTV2ac/V5FXDH07gFRN/FLs+PtZGIp9hDXwbD3jJ
	LOilo6YB+L/sSBA1+wUuR8P69TtyjEYBgF10RrPrUa6H4+hq9HfkePcqGVkGwrk1FPJIGAni8g4
	1YV6rKht0ZDw3moj3CZtyvbLqhsAmKwrwf/Uw3PGsGw==
X-Gm-Gg: ASbGnctFliOq15Y76Eut7SZsvO3gaGTtOsG8RF6D3Mijj5IlWtRWtT3IImULMXUYDyT
	o4LGifjMIlCD7aPXhzsP8f63L9lhs8HM52+NJY9Pu2MM5E9s1fF8D84T9NP4ekuRA5KcJDYlqnC
	ZaVtC6o0zGBTEbfXbeqKfNm0MZWlPZuyG0XhLNZ0cZCUX+vhRsgTyOTXkarn3Jt54L9/wJzr/Lp
	HEbjv95FyoN
X-Google-Smtp-Source: AGHT+IFQKHOl/ks8c2sO6UHCTF4YTUDutnNXPXr1pDQpFnFdbff6CUk7MaNAdBSI0DWGZGIJ0JAWo41qD53Iktm2w2Y=
X-Received: by 2002:a2e:bc15:0:b0:32c:a097:4140 with SMTP id
 38308e7fff4ca-333fa4bfcdamr1324851fa.0.1755120239640; Wed, 13 Aug 2025
 14:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813181023.808528-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250813181023.808528-1-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:23:48 +0200
X-Gm-Features: Ac12FXwCx-uoXVs4aMDgHmYjZ2Ssd7MkYDl7neNxmuZuqzuTHDveVBYFE84fGPc
Message-ID: <CACRpkdaMPB5ydMgFvGOQRQDFJaco5bG8GNn7N6S6rkXa0FSBAA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: remove unnecessary file,
 dentry, inode declarations
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:10=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> These are present since commit d8652956cf37 ("net: dsa: realtek-smi: Add
> Realtek SMI driver") and never needed. Apparently the driver was not
> cleaned up sufficiently for submission.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

