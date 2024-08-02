Return-Path: <netdev+bounces-115414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC569464BE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681431F216BF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E47346C;
	Fri,  2 Aug 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cdkx9Kt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70D4D8D1
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632406; cv=none; b=lN54OXtWbQg2XguUZ9DrCc3B3z+Wyr8V3QMRAv/VRngy22SqMLaJ3XH0cHzqOHscv99hoWe14BNDWmxurTNFOtvaxUMDpo4znfBoP8F+2mmhf2I0zwb1sC7hEcGbwVihHYuh0g4hXLByiv+Vmmdn0PjHHHsBEUqr3VIAnQgW1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632406; c=relaxed/simple;
	bh=ur6PCk4noD2N+76JrhCMPAyiGFsnK3iW68h7iJXOdts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo+c/Vp0sfUrt5Zu5rOZqBcnKFtECefrHrJVsMvjuLhsUwAPECJkuhBcJKMLTwDXlmm/6XBOY6NIaMLvQYrEC9Sxb3FCldvMS574ddEtOU9Cq4GTqwIGTJhhy7AHRUu+VS9kyTWMEpFMAHa8nlk6/1HZo1PwQtnc0xHXT0zOcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cdkx9Kt3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so17826761fa.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632401; x=1723237201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur6PCk4noD2N+76JrhCMPAyiGFsnK3iW68h7iJXOdts=;
        b=Cdkx9Kt3cdHTw3s7AkRwmBj9o06PYxerRusRD2mShUs/bjkppJHwqrDuAgBqF6lmQ7
         5Fbpd64g2IWsAIJ7kmFaP0u/p7SI4XrDnlKvG8J5CxUd+py3e9+77CafnK/s45yfJ19f
         URQaXX9ClOhI51tbjIrQ38aXRI/77igvmhm4tY9sJX5Ek4tlzJpleduvpmHkXu67xXUA
         kqbT1QSQ758fZ6JR/l9p5D8BUTDCvuKTpz1MwFWSzPjhXgVyAu7YHsBCx/RC/MHYTGI7
         nHKKJsKlrPmnPlWD6Yw9UiiEoLpVoeEpzJ75np1Pz/obP3POHe1rkqJybbGlap3NjS3f
         Fv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632401; x=1723237201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur6PCk4noD2N+76JrhCMPAyiGFsnK3iW68h7iJXOdts=;
        b=Lrl8lZ1q8giuJ1XiQKWNxmNrOOuRBLMK0XL25s1JRrE7vj8ZyF+80aQdWPNMli0Byx
         YNHd+JXaGcw3SYFdrK1mwganMqveAtDzzqRYG5rgolahs6NT7y8/JU/zfked0+1+7kHo
         lMGkne4veOa/hXdmFg2vGmb4u84evd0/7pVxdEKw607qWDwMs9OjDgP9cvOMItCL4xu9
         QCWONRl4YKW2b47HqPx27lo6NTXHfm7RMuc+uDCteHB3iNWzujArER9jsWPKwaovy7Nh
         e+jxdQ7mz75UOyMJLaSOdEFQkvHHLc59WMU1mP3s8tb+UOYbfYX84vP3/gj1QXk/sztR
         fPxw==
X-Gm-Message-State: AOJu0YwVwoyr1ZqNVffZWD+0a84aYGHgxqrHPx8Z0N+A4eohxT1Q+MSt
	egdQObl3haKL8hjsczfPSjr3m6qysSdI5qxIu1P1FBYPG6Dv0v7kIraljiBjO0sTxJ51qXEUyp1
	dfyp3b2YAvFXeXYU6gwz4Kf/0Jr/+sVPLbBuPwg==
X-Google-Smtp-Source: AGHT+IF5WfbIZF95CVQO81XJg+lvsexJOkUsD984b9B1TGK/MPMHFPTGd2W1SKk7KG1xx0cb7erDtRot9mLe6r8vGVY=
X-Received: by 2002:a2e:8187:0:b0:2f0:1c7d:1ee2 with SMTP id
 38308e7fff4ca-2f15ab27bf9mr31038641fa.41.1722632401226; Fri, 02 Aug 2024
 14:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-3-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 22:59:49 +0200
Message-ID: <CACRpkdZ9yB_12Vr_HJ1BUUENmKQXZUoZTLq=p_CLG1Ym93d7gQ@mail.gmail.com>
Subject: Re: [PATCH net 2/6] net: dsa: vsc73xx: pass value in phy_write operation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> In the 'vsc73xx_phy_write' function, the register value is missing,
> and the phy write operation always sends zeros.
>
> This commit passes the value variable into the proper register.
>
> Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

It makes perfect sense and I have no idea how I managed
to write this bad code or why it worked so far.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

