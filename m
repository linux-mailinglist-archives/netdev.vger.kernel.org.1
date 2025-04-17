Return-Path: <netdev+bounces-183642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AFA91603
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA907AA445
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B71229B01;
	Thu, 17 Apr 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMRKEHMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A41DB37B;
	Thu, 17 Apr 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876775; cv=none; b=T7aScRPhew91jMIOcETVofVkt6RUC7X9mDvQMeNH5/OM9F4Djbt0nJmvbQysslKFjQhV06FaaGtwvJNdDJyFO/qEzehnVlxEJH5csyA0Fr4EucvYtdwilm0P/9EPKnsIRdveK5lLc2XJt2zUHYXijnWr/6u0KPzcqymb1lRCB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876775; c=relaxed/simple;
	bh=S+8xAVlBGvhFxaVyLV6xjlgBsecr0EUiAAEmRSCuI4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0RrU9YNzx71gSZUNrn6unKSe/wMqRrM9cCqAgU8z6O3qR3+6jMA58WSAGO3fYELCZp6YwEbvh2Lc1SQBaOo1e8xFjIqTySr++8dmAPSSUbKI32/KqV61huwbdhvJ/yixWVraKFwWx3wKfksG9Pg0Ai/sZqcLX/r570Nw2YHvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMRKEHMn; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e63a159525bso416371276.2;
        Thu, 17 Apr 2025 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744876770; x=1745481570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Pap+fTgN7kJgMPRg160k1QP7LAV22RH2hrqdeXtCQ=;
        b=SMRKEHMn7jxqkINKVjszTxD9GGFOfs5zXlr5CTOKzsEoYCr695MUwnyFy11FmsHCmL
         EZMBBtd2oszS+0OxG9Rnd/cUHHO1DlI4/qPg8QmO9/fzoe1c3jTmR56/smMQ66uYmOSo
         L0ueZ63ISCn+Cyjmx0GnBF4rK7SqnzsErYuMd1gmfDBYeKwdbIxjDb4vLzhK7J6RIxeL
         1P5VYGpumjfk5zAeiEgCzTjSELuH3DfKu+2xy2M3u4S1EZTz+DPNL1vlzOsFa7aNbtKF
         eZzRm3WeCTStvqt1uCYLXDu9MVKGOnuAw9FXQaCui1mV5bVYLY8Yy+YA6w8L4buR0Rf/
         7ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876770; x=1745481570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6Pap+fTgN7kJgMPRg160k1QP7LAV22RH2hrqdeXtCQ=;
        b=jwdtjYbLkv6FhN67F8D5vB9LoCEAcLBZsRay+pZyPWCUQcfKtCardEX7Olxny2mFlj
         ut3N+skw+q2kOwzOP8NJUyYd8ZLUMIV2UWt+cAXcHcwHKPWe076JPLacQeGfxFMNpUNi
         NY+IzQ6/ZGNUCmjvrbuTSGafp+Brl3/BnsOp8xKxP+6QuVAy3ZldOAL8udLoevdVbQMg
         6ptGU2+ecZhPtQorJxtpwaIbR7B2TODvf7I2ZXYDaevqjXxHAVO5xtO5ylf3Z10vMuoZ
         h49x0kgG7YYyiH6TDk+2yCYXPXGYw0cxPkLFSKKDAsaEkFZOnwO+VcIG8AM5DOUmchz1
         0wQg==
X-Forwarded-Encrypted: i=1; AJvYcCUEAho1k1A1g/cY8ONwIjBUlPgZKyAFT1FvPOdLBqy9BFFfPOtcHXCHuPStc4s4oMVCPovSJmrSdUlBOpk=@vger.kernel.org, AJvYcCUsl1ZONS+PmrN+5URjwwkmKREWHPZP4sAfuZ11ZPCaALCgmHyBpE/w3RJsELvHggKTsL9NmuKG@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxtZ4VuKzWNSrtamt+1/nrz73lr6Ool544s6nNS0/HNx+Ga4N
	c5UA7MIlY6aG6Ol7Z+qZ+3qANoZSLQP0CxrtYCxp6kP3VTHjZDeW3OfMM9PKEPBDOy9Vm2ZetUz
	cx6Z2jmgmYCi+ElaYyw7aOynJ/fY=
X-Gm-Gg: ASbGncujCWKe34QTDEJZxE09N0SRH6NPbWOBLMtIrtFrw6sEnbvFm5N+Btt9vpXlv3E
	SZnag6KLIxwqjK1cCLR1O7sjEuPQhyqSKBhsCX6DgrlZPgj1j2D9MDqpcbqhIYnT0GTByZSZHji
	GG3EwPcTg3vp1KU3AyTSzkTX9ZL0XaDaTssC4Xmg==
X-Google-Smtp-Source: AGHT+IHBHp91ZlVZdDGJsjwFo0RBSJGsJCTPeVjJm6reEXOcrWb0Ty/gQ7iaifYWhmq3E964zcrbaunUab8FIJx2MW4=
X-Received: by 2002:a05:6902:2211:b0:e63:326a:3ad7 with SMTP id
 3f1490d57ef6-e7275f37dffmr6920865276.49.1744876770298; Thu, 17 Apr 2025
 00:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417032557.2929427-1-dqfext@gmail.com> <20250417093834.4e1d29b6@fedora.home>
In-Reply-To: <20250417093834.4e1d29b6@fedora.home>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 17 Apr 2025 15:59:20 +0800
X-Gm-Features: ATxdqUE6Wv2T3fqXQOxzpuEZeKxMPxDJgotXD0MxMlV5V95BOCqWsEsErly9mIs
Message-ID: <CALW65jaAMpUSZnezmFB+gA6=BUaPkr6Afuhs5wkv0yyv+7XMrA@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: leds: fix memory leak
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Nathan Sullivan <nathan.sullivan@ni.com>, 
	Josh Cartwright <josh.cartwright@ni.com>, Zach Brown <zach.brown@ni.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>, 
	Qingfang Deng <qingfang.deng@siflower.com.cn>, Hao Guan <hao.guan@siflower.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, Apr 17, 2025 at 3:38=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> On Thu, 17 Apr 2025 11:25:56 +0800
> Qingfang Deng <dqfext@gmail.com> wrote:
>
> > From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> >
> > A network restart test on a router led to an out-of-memory condition,
> > which was traced to a memory leak in the PHY LED trigger code.
> >
> > The root cause is misuse of the devm API. The registration function
> > (phy_led_triggers_register) is called from phy_attach_direct, not
> > phy_probe, and the unregister function (phy_led_triggers_unregister)
> > is called from phy_detach, not phy_remove. This means the register and
> > unregister functions can be called multiple times for the same PHY
> > device, but devm-allocated memory is not freed until the driver is
> > unbound.
>
> Are there historical reasons for the triggers not to be registered at
> probe time ? I agree with your analysis otherwise.

I'm not sure exactly, but both register and unregister are called
under a condition:

-  if (!phydev->is_on_sfp_module)

Which may not be available at probe time.


>
> Maxime

