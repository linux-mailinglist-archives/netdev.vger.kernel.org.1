Return-Path: <netdev+bounces-62295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB582679B
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 05:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8369A1C2165D
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 04:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24317EC3;
	Mon,  8 Jan 2024 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5cktqpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471B79D8
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso13515951fa.0
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 20:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704689059; x=1705293859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwRiofniac0/JmQ0akfyz6gQap0jjLoOEdtHTb9uIJE=;
        b=k5cktqpQSdtg8HgOd/SV2PT56snZOGWrwZHIW2N9qVEwJxmyU0E9pjBh5uHtTYAIUI
         SgMTV6kSGdL+4ptjkAvSXo/4FoycNCarTs32bSFKqexBrq+IY1PB/j6elhmbgUBHW+8N
         eFyRfBrjpK95nkH2W+oGkg0tYWCFXLceFfllSAY9ix2RKxzLg9Sb4EOs37bZuZwdVpC8
         JYiGxhgRkq3D4oo5WTN7nVxcJ0tQCzNer3qdFfy3agSA9eP6xfLOG9etIEjqPspLyVEs
         sT+VdMREhSqKCdjgFTtb83vnCmnjuw9mQdjVuNMJrkuof0Gq7WQaYPIfGHmreG1Trv0t
         L0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704689059; x=1705293859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwRiofniac0/JmQ0akfyz6gQap0jjLoOEdtHTb9uIJE=;
        b=jUdnVGLf3Kr+YBL9EIEc6zR8yST3D2v4L94rKznZn9uESs/v1UFfNpmNoPO3gJ4/Zz
         yX3OoEWmH8SUNoZr5TRpCqAA9tDl3ZK3ivUtNAxrMa2/g7Hx7hlgELAbVBmOOzKnaQGV
         nIRIqNX6N+gQIdoX2X2eYw6SankTLg2hVWSFI8M4wOuX9PyOzPIjHWojMPbjttbAhF8V
         Uo3j0Wh2rsnEZNNiE5ddxz6l6Gv6o0KTPnIP4NkKz2QLuFnKdwJh5/ny1IlL1Uzf/2Zf
         A26awQ14OklYgGeKTTW87iQ80nLFEKPefdDlYm4oR6AC9t6rkygAuBvyiOG/m91wRHmU
         1p/g==
X-Gm-Message-State: AOJu0YyZxt6f9jPdhdereWgZzKTIdV+94f4QR66a3byKTHaXKHnaV5bh
	j3+2gFIajbeWuN90p4M8lY/5juy98Cnj5MrgoCM=
X-Google-Smtp-Source: AGHT+IGESSSJPK9qY3zbeG5EkEgyDwYiP5lrfmpKXVu9cdJynSSPqxYlWc/qcrkfGVnGl3xVgJKQw/uNCmb47HHcziw=
X-Received: by 2002:a2e:9092:0:b0:2cc:c723:9a12 with SMTP id
 l18-20020a2e9092000000b002ccc7239a12mr924856ljg.68.1704689059268; Sun, 07 Jan
 2024 20:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-9-luizluca@gmail.com>
 <a638d0de-bfb3-4937-969e-13d494b6a2c3@arinc9.com> <7385ca39-182e-42c1-80bf-fd2d0c0aabdd@arinc9.com>
 <92fe7016-8c01-4f82-b7ec-a23f52348059@arinc9.com>
In-Reply-To: <92fe7016-8c01-4f82-b7ec-a23f52348059@arinc9.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 8 Jan 2024 01:44:08 -0300
Message-ID: <CAJq09z46T+uySp7DOLSpmh-Zouk2_CwvdMSmyuqB14bKSYf+jg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/8] Revert "net: dsa: OF-ware slave_mii_bus"
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arin=C3=A7,

> It looks like this patch will cause the MDIO bus of the switches probed o=
n
> OF which are controlled by these subdrivers to only be registered
> non-OF-based.
>
> drivers/net/dsa/b53/b53_common.c
> drivers/net/dsa/lan9303-core.c
> drivers/net/dsa/vitesse-vsc73xx-core.c
>
> These subdrivers let the DSA driver register the bus OF-based or
> non-OF-based:
> - ds->ops->phy_read() and ds->ops->phy_write() are present.
> - ds->user_mii_bus is not populated.

I checked the changes on those drivers since
fe7324b932222574a0721b80e72c6c5fe57960d1 and nothing indicates that
they were changing anything related to the user mii bus. I also
checked bindings for the mdio node requirement. None of them mentioned
the mdio node.

> Not being able to register the bus OF-based may cause issues. There is an
> example for the switch on the MT7988 SoC which is controlled by the MT753=
0
> DSA subdriver. Being able to reference the PHYs on the switch MDIO bus is
> mandatory on MT7988 as calibration data from NVMEM for each PHY is
> required.
>
> I suggest that we hold off on this patch until these subdrivers are made =
to
> be capable of registering the MDIO bus as OF-based on their own.

We might be over cautious keeping this for more time after the realtek
refactoring gets merged. The using OF with the generic user mii bus
driver is just a broken design and probably not in use. Anyway, it is
not a requirement for the series. If there is no objection, I can drop
it.

I would like to send v4 with the OF node handling simplified by the
change in the MDIO API. However, I'm reluctant to send mostly the same
code without any reviews.

Regards,

Luiz

