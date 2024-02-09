Return-Path: <netdev+bounces-70518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECD84F5B8
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392441C22222
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911D381AB;
	Fri,  9 Feb 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRowDtdX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097A374F6
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484870; cv=none; b=ipjIcFo+jCCEESvTEbYiHNuxoPwvMkd5/JO86cWqDFtPFXof+yjavPJ8xfji5OEJ1QbCW19psyxxifj0jjr8TBP+dOmTgMRKNkP4zp8xxygxWZc1WWdkueczJ++HtjXg2GT9w/TJnIaQM21SY+KjAk0SDv1z1ENzxFrmJErHtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484870; c=relaxed/simple;
	bh=zJwquKDcQdXxx95fVyEF0thd2c92Rc/rle9klHqcSno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfBZ38TyToTdcd82EjADnikdgaM38IPl4xS+/3fWFQr6RtNvySKVk1Yotd4N4XD0eVy82uDvORkMI2whbWPW140pjgZTPXpM4+hxmUaFrtF2GfeBOZjTqJGPSKxEjDUlvY/mG8+DPI579y+wrARIkvGuwDVMsoEp4TqvyPbwFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRowDtdX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60495209415so10690207b3.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484868; x=1708089668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJwquKDcQdXxx95fVyEF0thd2c92Rc/rle9klHqcSno=;
        b=SRowDtdXAa7zu3PhWtb/UYZTa5S/Mzna9vpIk8MVHL0qc9SWbJaK5ShBhO/c6CW8xy
         7AxbW6A+ML8shjpu0pcyBCxMgEFGGeeioJB8E1Y88KS4TBjfrS/CCGUS2NxFkQTZJXBv
         o9t1vSkNEOFEFtpo+eJi6oIDUR0FiAI9BRTcJI8nxFqW7ZNW26MCKjVkqyi07wCHdm0w
         wbwuJ/RefMiojmDP07HYQdYyCua8xPeJ4LHfGjk3lJhfMqfs499PTTM4NB5OKh7A8Izp
         Y00fiOK2Y7TMcpdqK/GaHJJqJPzdr1+2XuIod4lWpLHhEsfNeZHxA7JnVjwMUMzW2w2C
         mF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484868; x=1708089668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJwquKDcQdXxx95fVyEF0thd2c92Rc/rle9klHqcSno=;
        b=d4cqX4TlmUeObABDlkrDABS+BBLpqr+k6qZFrtvvIjuZqmussGWZOnZFMQNFCO8O6V
         UBV88p+K3CYH6ZtPgRNF5/MgnmHtJSK9Xf9RWQR1uJ4TC8ji7tawwIBJexA/r9w+NZtw
         o8inh8T17K0JUCdd4aAHVRvy5U3p2c+sCum6ngk0Ojv5/XzYcHLefACI7Xkrn6nGvGKJ
         pU0yuevVm+9+SQftLAmX8L05wwiKk2pv+oOreIRcagEQYklpxeA0+5R8Tv5xmLNGj9O5
         y7ocFFab9BfVSOplWqGd37Tf2O1nsZ63l/sHzY1ZCH3EugFqWW7Fm6WXFUxPmo9r31/l
         NUZg==
X-Forwarded-Encrypted: i=1; AJvYcCVfmf6Mi1giA4LNBaS1r8PjPms1ERYe9NXz4PiJFUBHduI/8dl5wMeJN9mCNplZw8CJ7W+xRW0Xx6Q1OOVp9bB8OHA5ruGx
X-Gm-Message-State: AOJu0Yy6+CdlEU37WT91BNHJcOxPGcU67q5OAHATSTyjX7VKyKlDTSkt
	yKey21jdLVspko4LB2w7JthuGY03gSWvRYNg7FKj6lg6zMTOUV3NAfGCpWpYA8mS0xIUBQiDZW2
	ANFqgHaH7Rxc74kUjyAaf3IOprWBal8I80BFTpw==
X-Google-Smtp-Source: AGHT+IHcVHa6uuIl/rmttkT9yIiHEaYl+hdN6Go+Qba9nXw18VGXS51FICHCCsz95taf1uoA0LiegixgSjIl886ullE=
X-Received: by 2002:a81:9291:0:b0:604:7bb0:cfb6 with SMTP id
 j139-20020a819291000000b006047bb0cfb6mr1489620ywg.2.1707484867813; Fri, 09
 Feb 2024 05:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-6-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-6-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:20:57 +0100
Message-ID: <CACRpkdYgh0joQWfL-rbMfk_p_rso=zMyZAwos2wyjG=-aKY0bA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek_dsa
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

> Since rtl83xx and realtek-{smi,mdio} are always loaded together,
> we can optimize resource usage by consolidating them into a single
> module.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

