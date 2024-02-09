Return-Path: <netdev+bounces-70522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A584F5C0
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E6B284EBE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69A381AB;
	Fri,  9 Feb 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYJEfSwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD329CF8
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485020; cv=none; b=fmJLfdMk36+BXjSLDI1pFaUhSbTgzr8m+fjoiRtotYPVkyS2nrioJol1UcSc5dIF7kD4JPWpkt4cj0WWju+UMUOBviMFfnuoTLixNHwCscZOHJozSdBmYTRtHnA6neesAyJw1p9ZT8/fQtbPgj/MecITZKjDRvqoynToXH4Kfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485020; c=relaxed/simple;
	bh=pV/czTdtZUlf2axchXtZeUtL5E+/aI+Dq0Gj1xXUuPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js6I4dtWUDt5Q2ogeCotW6SLDgBw9xmuhk+SN5oG4yTdWzGKOfGpWnCgXfkkez/LVR1Xsj8FehIVcsGmrACsrd0mW0xxtG+UR+bJOlx8koVSf2tssuA0VGSO4JcXlsqmXNCqWZsJ4IxaJlhBk8V/NuMzoppzaBYhvCHNi6vPeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GYJEfSwL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60493e299b6so9597067b3.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485018; x=1708089818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV/czTdtZUlf2axchXtZeUtL5E+/aI+Dq0Gj1xXUuPg=;
        b=GYJEfSwL6mPP5J2oS0PRQMAvX5ph0E4yzU3lUIeQNMd0ezprK9ijK4y0gLi6tx1C3E
         ydGGpSDyIM+NsDd1rMeeAycQe3HlxCf8WGhakQs9WS/ZadoLhctg/bPm5DlgxmgRxkQq
         quFMpdOGNNT8gt6a//Wb24jhu3LUAM0QhBNJ2Dv/0yT0O7FUwPLox9nUwhi9Vg4UOAq9
         Il13yK07KB9X8j6ofalo9oJDgQWmqYMOYfXOO0MuM4+IT9a3CqS2aRv3l5sLCwv4jU+c
         nAJnKULWrwfCNePiot6PIkHovqPh7iEMcMpMh8exNHwQPSBKJyzSMqKQ0eJrU0E10Ram
         Q33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485018; x=1708089818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV/czTdtZUlf2axchXtZeUtL5E+/aI+Dq0Gj1xXUuPg=;
        b=jOom5dpg8g+ph+YuzeR5XC7DnUNaroV/sQ0w8GiRGqYnj5BPyf1ntKn0JteSggaS/G
         wjPYYWgPHM4wR+QAfvnsfJ9aoxMRxqLSHYU8FdW3f7Wa83Nw/6kTYqhJCYGvks9vqY7Q
         WZDGO928zuXE/9XnaFwFGiqRPu7xLmeFPqVjjLfaftKkFWy/aqjajQif6o1dZwzBVE3m
         mXQ5Mwhmr7NCptoGMwBU/Zn2+Gy66Dr5fJ4fIhIjQG7aYz9AYt9VNgEGJwuyBLgI9Uqf
         8DTedsB3broThhF4HYHa3jjIvbHO3YzLnXxVsKytRGogwppb85tEULWXulqKvSPPxOxa
         ml3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCILcq121l+GLtD9uTULhC7PawTw9CQHi63m3zmuFrl7zcc1GUEPPTQmRvq3h51JGFBfErZ8F9K1J/vZrWli/o4PdeU0Du
X-Gm-Message-State: AOJu0YzrEI/8MhxYBnKmg4CZHmzCnOUHcVn+fJQEKIgtG1npeYBKMvwu
	NesMiXwHgHJh1U9mUOsgHN+62GOnzcaUdGHcVICcDMRKY0zYdOmdr6gLAJXt9XdrExGBkD+rDpg
	bjtFvECOaYd2jzYiFeJN/av8eIN0+LjcPHHhqPA==
X-Google-Smtp-Source: AGHT+IFft6Gv6jD+JbYytajC/m1eKoeEa+fbalCewVaoRGzTB2K40tUtmyUDlS1DBLVdWdX1cjEAtdXpnCIT2zR1VV0=
X-Received: by 2002:a81:9108:0:b0:604:11f9:5bfb with SMTP id
 i8-20020a819108000000b0060411f95bfbmr1604557ywg.18.1707485017812; Fri, 09 Feb
 2024 05:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-10-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-10-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:23:27 +0100
Message-ID: <CACRpkdYwipccH8rQHCkE87FRzWw+=xwZEqT49N9CKX7bceeQhA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 10/11] net: dsa: realtek: use the same mii bus
 driver for both interfaces
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:05=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The realtek-mdio will now use this driver instead of the generic DSA
> driver ("dsa user smi"), which should not be used with OF[1].
>
> With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
> no longer necessary. Now, the realtek_variant.ds_ops can be used
> directly.
>
> The realtek_priv.setup_interface() has been removed as we can directly
> call the new common function.
>
> [1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-o=
lufsen.dk/T/
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

