Return-Path: <netdev+bounces-239869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A78C6D532
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F746385B6F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304862E54AA;
	Wed, 19 Nov 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFM1j/Xq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277332779D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539004; cv=none; b=ZUCW3fNnvTQohlHKqr0U6svuKyZUq/uXMtjxEzXr9/ki8xIf/7ztpWrjMNrf156NU8ZbnVPFZ7clVxnqPcv3UXF8gYbApD/UkiDl99Rw6Bp4Sk+sbciEKlWmeGbkN4qhuc5HO8AZt29UCpmrWTgSXCcm52dWE51mL9y5//i+LEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539004; c=relaxed/simple;
	bh=rEXvudxkQhACY29ZQzHhhu73feIKH7DIWejsnTjRwDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3B/TJ1Uud6DC8Egne39O0E/88eTKGU26QlWK6QNk34vKDq06X2og2+tfZ8Vc8jiCW1B773flSQR9bs87sz2BZFMP/QrNidbsQrasvA54lDJgHxAynL5l5uPIlW8L2UZCBdUlbgvGGep5fROxXY75ObxFPSIjTe2bo8igKC+X0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFM1j/Xq; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640c9c85255so6833784d50.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763539001; x=1764143801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnLuhq+bNdf77j9DiWOZnNN0ok/zvj+B4h8aoL60/Eo=;
        b=jFM1j/XqKnt6qB0L3lxQiepudSb+NyvezZWMf+3y9g5mykDaJTCnON8t1/qeoc6/Ke
         HbYMMsKxXfigk64PNSEC35hF74AC4ArorKVQ8S+rCEAmE2k+40nHBEIaye4FExW+0GID
         9z2DkF43Q1YKEFxwhQo++bV8us7Rpz0K5AcM8Yq+roBtD1qrMlEwL23ar9913NMQ7zpZ
         wjCnpLBzzWbhExKMaGhUhUbZCX8hW6OuhHoz+otNTnpH/iFBgfJpjZ9PE+J7vib4Y92k
         PapfIjeW7j/2fZt0ljK9xr27Y/SP7S8gDrHg0b2nYGmDcGh0XYYqzRigT9TCJac7dzzf
         kmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539001; x=1764143801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnLuhq+bNdf77j9DiWOZnNN0ok/zvj+B4h8aoL60/Eo=;
        b=p9G0hoN1Rylyn8bc3Ac1Vm6rV0PvupFSlpped7iHM8HQ/ufVEpmm2wWoqqwcx3Fcx/
         KxbapAMHSFfY+iUfya2dPRwE7qTLadjziQhdcZPBac1O0MM4iQkPGuEkEI3+JpgAjvN6
         dSInaks5eRxmB8yoSEVpXtlrQgpcf5hRygSxeODo97WKRcgSNG6PiXJW0fnRx2X1cKJE
         QzXTiRR/5uJs+7WFY4XKZDAV8ddu/eX9ThLGlpxhHGwRmH5RUrcMCcaC5Yh/ptZ/1+7U
         weR7qeddcKH0uqdKxLI7VsSzFGNMcIIWXuqvvRGmKFJ97URPooGG0J6dmVCrtyCf4NTS
         6iMw==
X-Forwarded-Encrypted: i=1; AJvYcCXMV97oZ7I174PpZvHXgyILANTdv6w+lVv15IABDoYrw0cbSmUAcWem3WTR6RiuKZZY5nbgOSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SCKF1mHm8FGlkWIlgDWjjwzpFAMjQMN62+XXSISc51RvBCC5
	oce/ZtpcTaN8zly/yNBBYLhaSdrnuGg6M6DKTz6img57Ah1cF2zTLKYTxZGWxzRE/JrLmWgT1So
	Sy2ryVtQ2VK8Vb7IoYD7aUKe9b7/bweJdOV8ndL0OX/J3m99v03En3d/+
X-Gm-Gg: ASbGncvCLPzl32sg2R4bfms9Bv/52wS9EFAZz7ezeC2mYIDFqgN+DqRtWMutiGOfr8p
	o0LxKdryDJTJIGvOhtddQgYAW/X/97RLo5gCg6reqfEu20zeiAdIu/SpslP7hEMa1J67UU1m6oN
	w9bdV3PqExC7GOHaGZteAjF1ZU+A1sFlcHZ6NlKwFRNLAXfnq39BmrEn9dyWInOv2gI5sJLeDlp
	6397cZdWf96kLcYQRIRizUiMdHvZ1WPKs8iyclrjYjtaUYMysoT8PdxJYv8BhUiIJuR
X-Google-Smtp-Source: AGHT+IGyny9/IswQOI0uO0AQgkDhk9qjgq2p3rVcyFnTKlrhJBeddq01b40dTexZNZVTh7omHihMViSJ1pBA6YAe92g=
X-Received: by 2002:a05:690e:1581:10b0:640:e021:ff79 with SMTP id
 956f58d0204a3-641e763f310mr13353732d50.39.1763539001181; Tue, 18 Nov 2025
 23:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118070646.61344-1-kerneljasonxing@gmail.com>
In-Reply-To: <20251118070646.61344-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Nov 2025 23:56:29 -0800
X-Gm-Features: AWmQ_bnahoEUrf47hvK3QwrYdF29OolGylbOZYrpVIrgYq2lLe-vkIyRPIGo9qM
Message-ID: <CANn89iKYj-N6fm7LYX7V63EZU5fnMCfnOTbpixhDEQ7h=h3hhg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: adjust conservative values around napi
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:07=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This series keeps at least 96 skbs per cpu and frees 32 skbs at one
> time in conclusion. More initial discussions with Eric can be seen at
> the link [1].
>
> [1]: https://lore.kernel.org/all/CAL+tcoBEEjO=3D-yvE7ZJ4sB2smVBzUht1gJN85=
CenJhOKV2nD7Q@mail.gmail.com/
>
> ---
> Please note that the series is made on top of the recent series:
> https://lore.kernel.org/all/20251116202717.1542829-1-edumazet@google.com/
>
> Jason Xing (4):
>   net: increase default NAPI_SKB_CACHE_SIZE to 128
>   net: increase default NAPI_SKB_CACHE_BULK to 32
>   net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
>   net: prefetch the next skb in napi_skb_cache_get()

For the series :

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

