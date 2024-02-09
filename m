Return-Path: <netdev+bounces-70515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B684F5B1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6955EB20B21
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225137716;
	Fri,  9 Feb 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8OiZyFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344C37160
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484762; cv=none; b=ZyWv2wZBR3bciB9JsHZ/bqNl/RF6JeLD2BnzFskWhl8dyk3Jvxgn9pcqVAZ0cGXFqHYu1vTlUyiIvcdNTde5KsKj0ft/YkvSK2a6gnUAJHYo2/O5LgNXfGjYayu+cl/xxYrbzKPkzf3X+8c+tH3Qv+HiVk1UKM7VoAPZNsbi0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484762; c=relaxed/simple;
	bh=H0Ihgqg6vcooY6HsSUddyRQvt/glr76kGUtcEmebLvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaNw12SDZiwTJHNjRRG+A3/gea9jt8Ra1do6gaILhJHM5/+loBSSiZdLmFWe00CmP6D7BYQ5TzFD0rPeudXoKQJveciW62OLRrccGHK57OMxrZJDeqr1i6gsMmXQdbRf5o4WOuf9cyTwyzJRmlTnfvdLcxGmBWhPMOs8y2AoSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8OiZyFe; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604b23fc6a7so10479997b3.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484758; x=1708089558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Ihgqg6vcooY6HsSUddyRQvt/glr76kGUtcEmebLvw=;
        b=O8OiZyFePScKt86hTEL1JwkigXacBxrfnGWw2jyuBykB5K+Ijph0TlUc0bkr1AHqtP
         XtEMSS8igprPEaRn43fJmOv3GicsLLvQG/0ilLRKHukLk/VzJDJdGOjjwCV7VmZ4vBsM
         MQ/yiWn/omfJ5OC5MSZU8B4fSxYMd0lgONXsiNPpU3Z5SvvUshz1/pKO4/yFsCt1sQki
         VRGZWI/woSvN4lC0yLxdBFcW4UJsr+Wngbo52S18w0k6QxwM+x8JuVUe1rd+Zcbd2Nfn
         qu4CvZiayR1QRXLR43NLdWVwT6L3p23cx6tGzgxUfMPptWw0ug+x92+ZECDgOZl7OgXJ
         lkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484758; x=1708089558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Ihgqg6vcooY6HsSUddyRQvt/glr76kGUtcEmebLvw=;
        b=D4EK1L8Kr4T5ZYioAakY9ckbTU9esgfV7E0OQGb0bbUHTgwcUdnYXXGgoXZckTMasp
         +qjrVmvnLwDXuf8bxTKKNtvi5Eg1v1zMtHvrQvOJISKdSQ4cHYjjiZ6uuzh46h2+TYw0
         Jsz2/UaNBX3hS8HFMiFSao6j9eJw7Kv7QjWyKAiwYi3F5xGqXAhjOPtVmOXsdcvo8tZx
         k/vqdnQhzpD0reQCa1XnF8t2TKZylYQwZVm3JevMOASC4Rv7bW1czH9D2ReeSFL1O/Z8
         uOm4jzi4RtEUAuBjHJ5FBEdhrDlrLqs9zS+HhQ0/jwmkLM5WNSBAmAqcvCC9q+IfQUkQ
         QCcw==
X-Forwarded-Encrypted: i=1; AJvYcCWvsdai++LUdITWFqXE3BJCfT1kjRkFmaT3ci8bFamsxxO3IkXtYCeTdJ/kry5CWMgGZZbbZJzz3z680X2dyY9CdY/WF/UF
X-Gm-Message-State: AOJu0Yx7m3siL35jdRDPsW51ht6A8VU6KyQfuz+cBZ5zAXBYtp5ZemLz
	8v9TwInSSWhTVh38ugIdrnA/BibI268b2sxT8dvNFJaK82M28SbXnxuBXiA0rDE3XJbvG1SzFvN
	5TCD1TFYPoYjXm1iWf9OCsSLLsjZgQSSDEfKXRg==
X-Google-Smtp-Source: AGHT+IEWhMRKZpz6jQmO2xCeK+S38BvufNYeEIVPEoIMMs+4gr8K9BTZepoNwlEret+dAQs1S4dLcRcaZ3Sb4QQc/5k=
X-Received: by 2002:a81:6f03:0:b0:604:91b1:5401 with SMTP id
 k3-20020a816f03000000b0060491b15401mr1403138ywc.38.1707484758481; Fri, 09 Feb
 2024 05:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-3-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-3-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:19:07 +0100
Message-ID: <CACRpkdYaEAcv_au0VbJtGJtxGxNAOMrd9+5oVyR2ybb3NSJCAA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/11] net: dsa: realtek: convert variants
 into real drivers
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Previously, the interface modules realtek-smi and realtek-mdio served as
> a platform and an MDIO driver, respectively. Each interface module
> redundantly specified the same compatible strings for both variants and
> referenced symbols from the variants.
>
> Now, each variant module has been transformed into a unified driver
> serving both as a platform and an MDIO driver. This modification
> reverses the relationship between the interface and variant modules,
> with the variant module now utilizing symbols from the interface
> modules.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

The code looks good, easy to read and it works, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

