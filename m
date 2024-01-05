Return-Path: <netdev+bounces-61760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D207824CEB
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E57E1C21AF1
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91B1FC4;
	Fri,  5 Jan 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA3opElf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954C1FB4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso13440771fa.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421602; x=1705026402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYLLP5vaUS29qOkVnZYDtpW+xH7SG3TG0JM2AcQcYNU=;
        b=bA3opElf2d7AYAeLYOui05zrWMtkRNBhpvw7fLOmMNprYrU+QnlT6qP7W4DbkTxG8r
         rz8Ke+cgvlRxHPoQvCHKgEe/w2aq5zpLCpHoNzz0/wF8ER1WstKpWhX/PkiE0XdGvt1L
         kpMWly4tUeM0s3qsfRBFtXQM8ffDpO1ELcmoFz58/Y+pReEoAjxMmp/+MX9TsSW9tN+p
         Ljz7RpwwBATYrJyueVvRQ/ZJj46Jx2WDjhJ3KQaAameR0HtGq6rkbMPZdHCcr5BcXXEj
         7FvaUrjEltAoxz/z2pswh3sBJI/pMe1sYRVAc1S9kV/LxObpRE/SGH5eeYt2TBoRuPxz
         wGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421602; x=1705026402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYLLP5vaUS29qOkVnZYDtpW+xH7SG3TG0JM2AcQcYNU=;
        b=OCPUJW8j3mmJ5EB8CAe4tu7+PDuRfe5j9xWyX9j14UNa/wopIhc+F7iZJCoGJXahKJ
         131EQRORi7GxjdCDLjwqp30dLX/pw133WIlNrOLXvqRe98FmMyPXleOdsr7K1WhX6smy
         UFlvJ/A2Al6k7joW45KNeZc2IEg408OOWZeeuwL3sXUTcXwDTLXudK6f2wgvY+9nL2nD
         ta7hVkktfm7Gin9FwQBcWZA3QYOw1crNNyPvvQC/CNdmuWfKPdK4T3qRXqf6SG4eI4x8
         3FxrYYU3ZIhPOSTo3qRWi3diR29R4ClIE4DV7/h+UNzqnn2j6DarBwLMvd0b2CQQdU5f
         86qw==
X-Gm-Message-State: AOJu0YwnfmG6aUlDnYlgUisEFwIOnziWivA0R5s4Pj0ik/6eTH4xqhIw
	NUPzCWCTpyDX/6GUkRuAPmb+bL58Ls9vfp45/U0=
X-Google-Smtp-Source: AGHT+IEZ+ffxtVyL4VRgPWz2ByGRCV1t2ZyO9xey3KwipQdXwGTWKsfk4Mt7Ah/780/+XvIUoM+H+27nZHa4imRxb8Y=
X-Received: by 2002:a2e:80da:0:b0:2cc:ceb2:372a with SMTP id
 r26-20020a2e80da000000b002ccceb2372amr689857ljg.96.1704421601857; Thu, 04 Jan
 2024 18:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-8-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-8-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 23:26:30 -0300
Message-ID: <CAJq09z6f5U166ek4P2Ce4MwhGf5xbW=UrVpvxdhx+pZOeB41bA@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] net: dsa: qca8k: consolidate calls to a
 single devm_of_mdiobus_register()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> __of_mdiobus_register() already calls __mdiobus_register() if the
> OF node provided as argument is NULL. We can take advantage of that
> and simplify the 2 code path, calling devm_of_mdiobus_register() only
> once for both cases.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I should have read all the series before... :-)

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

