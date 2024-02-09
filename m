Return-Path: <netdev+bounces-70513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEA584F590
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D121C21DBD
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398CB376ED;
	Fri,  9 Feb 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v22Ciwcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B3374F8
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483831; cv=none; b=rd7scSBlej3noKlMI+jc5DSq1OT8qmQi1ZzqPefBzBfpto5f5Hlx3qHPUoUQrTZ0McQB5v17xDlcm//7emytGJ0ph9DtJEB7/fCIKxHNvSy3Z/muKPokiPpqka5YdUq8PU6pySKNgBr30yEQ0dbKoEZa4QpoVlMTq8Y8aGZwMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483831; c=relaxed/simple;
	bh=5Dm9Sef/c0+IpFJXoQ2G422bYW6l04FNCs0Rkmqa12M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ehobv/CQNTvbwwcEIP8WF6gV3PUvtxrVSCIvE3oU7xTS6f9zDyuV0xNfEhZsDX5DYUUMoukHA8bSEB6sYrZEgoWNqbYYCnlAFrzpaGU+6uI+zMp3b3Jp1RMy9PzqRdm7cGM4CPpjPNkZWF9i9I6w4C/0ghzLUk9NBUIf8XAU0DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v22Ciwcd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6049c6f79b1so9576507b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707483828; x=1708088628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dm9Sef/c0+IpFJXoQ2G422bYW6l04FNCs0Rkmqa12M=;
        b=v22Ciwcds4T3MyPWiB40+Wf1vWqBy7jR+WL5BZdtGB4Ca3YhwT0quDJAlUcftL64Ql
         8ETjeWJgWYkYyFQzoQSmtTcIZ8TtjPIlRf28VPYygjHfVsUhRxe5iVq2C3d8crZ3rfWl
         8ISnCJL9tPcutOl+68ay6xDtjiIZnfY46bXKGn9yq+c0sxsWlYscr0ztJawxh1i27b8t
         E3b5AtG1EGv4Ab4qMasWVpOPrQlfOE+TbPb5HpiHrbgpYUcwAiXWOTKQlMcPqb7s8vl/
         MyTPnSfVf871qUYI04xpS764S7HMuVcGqHGPlMT9VxRKfrafBpb4l10hFS098ZqQe5N+
         LTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483828; x=1708088628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Dm9Sef/c0+IpFJXoQ2G422bYW6l04FNCs0Rkmqa12M=;
        b=KGA0Gi29xyP4r2nMTb/i0cY4tp0ZyAsYJzlN6Nda58qxNwOx2DqzzTP8Nl8LSQCza3
         Dn8WOrdqP1Hi+m7hCfoyC23+WL79cT9JZpnPwtWMEqzxFMZ7iYk61WK9OogzYmETFOxC
         rrYqv3JDzZRdoIImdpjmZu7WTOP010jdVwltWQYae2sRCStaFRf6SsNfDkc+vLKKwBtN
         v3FvCw6TXb+M6Fuq8KARRjvIX9nEOr+tmW5DI2ho8FGzGpzddXsw/XwDpndKacdlZrz5
         +jxSmcdA4dhhPUAXVR7eM8F9fmuv0IWn56LNDccP3gqD0ApWA7Tkx4asSzik4eVgAUYb
         TV+g==
X-Forwarded-Encrypted: i=1; AJvYcCXCLh1d4E/KyeqnQuA+RO9pzvp54pADWo1iUV2H3RiwBt5QLjpG+iiAm66VWS0iEQFmopwHcFXTCYyWlX3IhF+XoZPinEX/
X-Gm-Message-State: AOJu0Yxkm9IDg4uNllhpyCzkRfxphZc+OMm+yEL1p9WBk7LjEUTfZGEe
	RdFhH/MoxMlBoxHCzGT5QwAeL0wruLEpiVpQ38JuLkYKkcFOTyO5gP6WB3yR/6L9kzouMH9ILYT
	e1YIjneIxlEMVUmN1oDFVWtsqQTzXqexSPAC0jA==
X-Google-Smtp-Source: AGHT+IHRaA9PmrrTXofU680GgYl5PKjfjw/jXlmCDUvWjB8I8wzpchTgQklCETuZqhqnS7GOsPBXmvMdhWJv5GWfAAk=
X-Received: by 2002:a81:a045:0:b0:602:ab33:5f5 with SMTP id
 x66-20020a81a045000000b00602ab3305f5mr1426479ywg.11.1707483828518; Fri, 09
 Feb 2024 05:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-2-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-2-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:03:36 +0100
Message-ID: <CACRpkdb-BwCaKkjs5y3wUoznjyj1sCw0WVrWwMs880zRHsXRfA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/11] net: dsa: realtek: introduce
 REALTEK_DSA namespace
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Create a namespace to group the exported symbols.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

