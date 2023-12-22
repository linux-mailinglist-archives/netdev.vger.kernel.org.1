Return-Path: <netdev+bounces-59985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A381CFD1
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520D9B23862
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 22:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAAD1EA73;
	Fri, 22 Dec 2023 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrvYxHWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A81EB33
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e6e7afc6aso671714e87.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703284386; x=1703889186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4loGfeN99dyzRSQHd2z2mVuepOb1XKTxIAhBhfvZa0=;
        b=YrvYxHWYOVjSo17AO/ILMpukrJSAGnGgizuARSLtvAS65Kf/OYRhscwxfY5NHVpnST
         VP6KRg00tHTNeqdJv1jMs0yqYQ7zyEEWtKGEe70Jc06UQ7jp1qxjwCPqmlZrS0i10B13
         JWmqnsgEZsypsOF07TLH8cbtpsrlVsm9h4cXuVm47HQyN8Dy6uGm8A66akRjOWsN8MPA
         HLbMzrzYq2Byjc5Lgi+nn9ajBua1UnVb6O3Gu/6B60FYg0whlsM2Vy6of2itEVBA+IRu
         TeRdlm75UecAAwDvyJ4PTkDfrdfhOS9lzxH2lQjefS2MyK0XIvA7ApG7pxjdiwDcx6s6
         8yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703284386; x=1703889186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4loGfeN99dyzRSQHd2z2mVuepOb1XKTxIAhBhfvZa0=;
        b=Rl+DIsokc3iyUDKcEIepz3TpFI1eO//pLVoCokB7PBLJY41W/j3LPonn5WnKumhDmf
         q3iAInVGpK1dq9QuEEx3KW0Cl60lgy3gD57D07iTBXxABZ2z6JM1Dqbumom6c1+g4obh
         V21k8YaWHMNMmgb1TafqqTdnTMupPCftVCKfr38UY8CxSA6tOgnx4QAfxN23YApIRDGp
         Ta4Mkl3jmL7y4CvF/jHYOsnRs7vvTyMiQ+r4djGbSjTi7Ed3pzEElRXjHk0wPC/BJFsc
         eZDmt5Dtx1WE/0C61jLnfDXW04BcANC+xl3IjstGkZ18W45HviSHCcpD9xYGD4+Rx8Pa
         CJTA==
X-Gm-Message-State: AOJu0YyzfFoHx+9Zs+jn/xvIvUqWybDal96h/1lxTrA5Jy1Ki2BKQcB8
	cumEFTH86ZGq5a5FnyzpJNci8oXNNoXCBNolRmY=
X-Google-Smtp-Source: AGHT+IECZjkv3ZKO1q0wij2Zi2D+CKlfg2CuNKSperJFmEEIvWeyMJYQydWvwqS/goe/0zAG7KwJonIOuYy8pwzcwlk=
X-Received: by 2002:a2e:98d5:0:b0:2cc:8a2b:4583 with SMTP id
 s21-20020a2e98d5000000b002cc8a2b4583mr1101310ljj.90.1703284385967; Fri, 22
 Dec 2023 14:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-2-luizluca@gmail.com>
 <w2xqtfeafqxkbocemv3u7p6gfwib2kad2tjbfzlf7d22uvopnq@4a2zktggci3o>
 <20231221170418.6jiaydos3cc7qkyp@skbuf> <ll6hlbujrzq6djjzfcoxp3powgrwxa6moplhrzpdy5fo5qwlxt@civqgrrqu727>
In-Reply-To: <ll6hlbujrzq6djjzfcoxp3powgrwxa6moplhrzpdy5fo5qwlxt@civqgrrqu727>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 22 Dec 2023 19:32:54 -0300
Message-ID: <CAJq09z4UH_jvva871_K+9ZgahDQp8Bv101EHcYJyrQK7xkOjJg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from realtek_ops
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Vladimir Oltean <olteanv@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, Dec 21, 2023 at 07:04:18PM +0200, Vladimir Oltean wrote:
> > On Wed, Dec 20, 2023 at 01:57:41PM +0000, Alvin =C5=A0ipraga wrote:
> > > On Wed, Dec 20, 2023 at 01:24:24AM -0300, Luiz Angelo Daros de Luca w=
rote:
> > > > It was never used and never referenced.
> > > >
> > > > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > > > Reviewed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> > >
> > > You should always put your Signed-off-by last when sending patches.
> >
> > I'm not so sure about that.
> >
> > When you send a patch, it gets reviewed and then accepted all in the
> > same version, the Reviewed-by tag will be after your sign off. It makes
> > more sense to me that if you send a patch with a review tag carried
> > over, you put it in the same place where it would sit if it was receive=
d
> > on the final patch version. Idk, not too big of a deal.
>
> It's what I see most of the time, and Andrew recently pointed out the
> same [1]. Still there does not seem to be a consensus... [2] [3] [4]
>
> But yea, not a big deal!
>
> [1] https://lore.kernel.org/all/8d2dd95b-13f7-41d8-997f-d5c2953dcb06@lunn=
.ch/
> [2] https://lore.kernel.org/all/20200408073603.GA948@gerhold.net/
> [3] https://lore.kernel.org/all/20190627083443.4f4918a7@lwn.net/
> [4] https://lore.kernel.org/all/87a7zzd47q.fsf@intel.com/

I'll keep the original sequence. Normally, the last Signed-off-by is
the one that merged it, not the author.

Regards,

Luiz

