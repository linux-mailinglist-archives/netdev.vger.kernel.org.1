Return-Path: <netdev+bounces-62747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD357828EAA
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 21:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5091C2412E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5203D978;
	Tue,  9 Jan 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS8ahHPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110B37159
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eabd1c701so4161325e87.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 12:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704833641; x=1705438441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA490/8LHeYGhBvxVi7doNyPyEexTmFRhWlBYSLND+0=;
        b=OS8ahHPYgW+WfknuzkYWee+OhpVpoFluaiC461np6vWqac8gkH4rPueaSSmGcxlcel
         ZSPXuksAuE0R+xRUg1gD/2O/HAXH6tF/eWkJo7UjI/Szz3Na4Kz3n+HWBvhcKexGhE4c
         P2pIyVDuNBrBV8qGcAWAyXL7HgZ80ZwE7AeP+Rjjyi4aIKbdKlKLqCBYMgPpx/I69NEY
         B/lRfEzLV0RjcCXNrsjJJ11eZRUS50+GsfU4xLZZNEyaylNPJZ0cVTahX+4Uj2gEnBlR
         4f/00dQ9C4Mou2K8YW3syvxCTXVlD9f9rYWH/M5TZ5lhhkKZ6dtbm/WegHJxZ+twJ+KQ
         p0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704833641; x=1705438441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA490/8LHeYGhBvxVi7doNyPyEexTmFRhWlBYSLND+0=;
        b=S7nvgvFlygs8dW7nL+u3/Y3THeX2FVGThFT02Bl+S4SZDePyGBQ2uNOS6i3bWejAxz
         AH1jz1nxtSpnFb1WHitWT0dFtlmWMqXLMe2gG7Mis9/AHlNVux/v1VRbHLLbfn1AUgYB
         upwwdQ8nRSbypWyfOKL40cJWWU0fAP0ho+omjmEnyqBL/3F9f/m9SmpB7nkH27+l86gz
         GiyfT1KpjJ7UyvT2zcfOmmaPpi13waC7swLy79nQ+s6YUq+wrTxAPMxeonbiFtJY3U8F
         CYfwrOyLu0byfgXOQ82czCB1XSc/m69XqL9hJDgJxnleREnMOQov6MIZWhqTCPYH11Nn
         vkxw==
X-Gm-Message-State: AOJu0YylNF2hgFoD58Hcc1L27OkKn9vWyv1NHzppAE81k6b3m7Wjq6Ae
	beALCb9D+TNfaVo0iWJbc68BVf4aVeSquLlEnv0=
X-Google-Smtp-Source: AGHT+IE2952D2vzeQYOPRCMcldIEK/ZY05aUqBMTm+zwzVufOkIIZhE2/J+H8wc/Il9G/ur+7uCT12mlU4p1lqohxTM=
X-Received: by 2002:a2e:900a:0:b0:2cd:4b4a:5c39 with SMTP id
 h10-20020a2e900a000000b002cd4b4a5c39mr2415814ljg.64.1704833640583; Tue, 09
 Jan 2024 12:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109164517.3063131-1-kuba@kernel.org> <20240109164517.3063131-4-kuba@kernel.org>
 <58364a9e-a191-4406-a186-ccd698b8df4b@lunn.ch> <CAHzn2R3ouzpsJySX50bVEdAeJ1g4kg726ztQ+8gFKULfAL335A@mail.gmail.com>
 <99fa44f0-fcd7-4732-b118-c52dfe1c482d@lunn.ch>
In-Reply-To: <99fa44f0-fcd7-4732-b118-c52dfe1c482d@lunn.ch>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Tue, 9 Jan 2024 21:53:48 +0100
Message-ID: <CAHzn2R2P99bz9K075MHLT8AnQZV=e23Uxo7mK4hZgVuywnk6YA@mail.gmail.com>
Subject: Re: [PATCH net 3/7] MAINTAINERS: eth: mvneta: move Thomas to CREDITS
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 9 sty 2024 o 20:01 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > Albeit not asked, I'll respond. I've worked on neta for years and
> > still have a HW - if you seek for volunteers, you can count me in :)
>
> Hi Marcin
>
> Please submit a patch to the Maintainers file.
>

Great, I'll do that after this one lands, so to avoid a conflict.

Thanks,
Marcin

