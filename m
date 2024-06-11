Return-Path: <netdev+bounces-102734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FAA9046CC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835811C240F4
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489E1552F8;
	Tue, 11 Jun 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvr7QjPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD3154C00
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144052; cv=none; b=MIbJ7qHlQ3ZjXEMlpn7B92LUsrN049I9qWvBRaXieb33aG4MsEuIqXF6ZawAlP6zYdai1hV47yuEyHjk0hrvwLIdv5wMigs41YI9VWbFFBPNN16IiPHqdtVeUvplfzriPBjV8U8Tx2twXdPzy9SrXiHKOmNN8IxDneAWKLt66B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144052; c=relaxed/simple;
	bh=dgd2gxREMu5XUau4oavqQoWlbsTO40tosBCUZXfMJAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7lYrqSxILKv4Opp/+1dbB0MYPsrbIL2Us6oZWQpw4ZqzKyszK6qaqCP0PLbfhR3VMxLorM3r7XxatSSu867N8hJHybmucRMO7qHidNZUqBLkKmsta5X7sJ3cfrojCbL91A9ii+Jy1Ex/uwByAtJRTlaeoVnvRynWiHyaAhuXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvr7QjPA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295eb47b48so7305385e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718144048; x=1718748848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgd2gxREMu5XUau4oavqQoWlbsTO40tosBCUZXfMJAM=;
        b=uvr7QjPAzlrSuyUCmdjVvR4RdXDaxjnoDH9u/5LDJIB511mGNgdwo+8PiEO169Sne8
         8ztxkx7eDKQvReRNA6hxOc7SL4eHLPP3MdEQExCLh1p0JbLRiUrIcfLkxVUoCgYmyqwX
         1CjZOrggoOMvV7oup9r4G0Z4lNp4TKcuQlCHECtJepbPTB+pB2RVjnMUQjcXCMNcBZm2
         kGAd5AdQw9a71efMlH1wBLJN/GE+fa7yQemdOL78tdttQRZeuUTM4csKwwN8MjoaBz3y
         dgKImG5Hqrt4mzjwIAjRwcTHDAPTHPMB7uELhRhbHKDqrE30o1egZR7wG+tQyoRPT0yD
         45qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144048; x=1718748848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgd2gxREMu5XUau4oavqQoWlbsTO40tosBCUZXfMJAM=;
        b=EojWkDpcl1GAiayvGn+M2XxkeXZ6Syi/FRr1TNHPqn+eI2ZZ2Y/LuvqemK2jj0aEcX
         XM3QXriWc9YUqX0KzBh5FMTNCogAVIk3OxPP2GhBRVUVutR0KvEVl44Egb/HVP4hl2jn
         bJGbcvAd9LrtbGV8LVN30ZTBy4FIA/UfT5xrF2tu4gRwbbG9ZgKQllwCjiiMklVeCrbK
         OANBjveKJoaDHlnzLe20lwbaew/olk5T0JCYnVsA3zBKY/XWCeQuI05fOnFvZ6xE5eHo
         H6YwMLtUcnAy8/95jZPmgoPR8JvShrCcs6X/DQSShEapqmWiNI+4Wr3WXwzWSXnpwiEL
         jgtg==
X-Forwarded-Encrypted: i=1; AJvYcCUVPi+PVh0ac2/QgAdQcrwJ9C1hHwPyUr+ou0/Im5Bb8Wb15+vzg3UBkXz+gGUP9ZIDx91dLSlvOkkw5BEWWwiOYkOOr2Lk
X-Gm-Message-State: AOJu0Yx9H3X30KUl9QhoBVgMO+juSkYjSRwoc2nm2dvgZU7Fggdl1/FX
	UqZlIiewZ2kyUl0emcjW+sDHaeOEfv4sTT8yE/u4G2bYn8Pf9fKwdVx+HZBF19U10YmHJwLEwLp
	dS0uhvzCLB++SmEfTIrabNIYiQwSRjdF4ik54K6di+VxZexGF
X-Google-Smtp-Source: AGHT+IHfY/q/cePfsrmUdvmQzxhTsMhZ1rs7ja/Ex9eG+8XjJ1a29geG+XyIqLfctsaWD+jBjjaECZomaXufChgbzk0=
X-Received: by 2002:ac2:4850:0:b0:52c:8023:aa9 with SMTP id
 2adb3069b0e04-52c9a3dfb4emr29645e87.36.1718144048216; Tue, 11 Jun 2024
 15:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org>
In-Reply-To: <20240528120424.3353880-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Jun 2024 00:13:56 +0200
Message-ID: <CACRpkdYOb3S8=EffjE8BpP1GTu5SWSEyorJ7i9HA2u7GQexwzg@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver fails to link when LED support is disabled:
>
> ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl=
8366.ko] undefined!
> ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek=
/rtl8366.ko] undefined!
>
> Add a dependency that prevents this configuration.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I tried to create a separate .c file for the leds and stubbed functions
for the LED stuff, but it ended up having to create a set of headers
just to share things between the different parts of the drivers and
it was so messy that it's not worth it.

Yours,
Linus Walleij

