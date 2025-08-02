Return-Path: <netdev+bounces-211446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3557B18A92
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 05:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AACA565ECE
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89A18DF80;
	Sat,  2 Aug 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx46Mq9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAECB672
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754104808; cv=none; b=qsqjy4SqKhZ+CH2LSjOQie5YFNsBVieQY7tdbNhwSZ1Xqc3W/LKrS33xixag7yDeLtADRsOM9+nMLnJMff/hIrIA05q0GB7Yz5/xsnN41kkUy+HDUuscxvn12bvklwNEIjpe1U7i18fVgekCt2F4j2qnEPUiR8FtnocrTRpZqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754104808; c=relaxed/simple;
	bh=pqVjSbrDP8clLJWmxPGuF4fZDgwlHEFepQ+Xxhtv//g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRWSLI/+DwcsDQK3snRLoo1fc5Y/xYrXZsuR2QtnP7fpoq8qGq1s0g1axQ7ZkDhb8iAwn1k/pNUw6BkYjxL2DDY4RhlZCrpNfcjme5Zyp769lOhMnoFlnK4D8uYOwyeHJ2Eo7H0GLu94i+sz+A4B9P3yI8tr09hMnGvjAx4X+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx46Mq9Q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so1630089a91.2
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 20:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754104806; x=1754709606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFJxqAjoXMQmiboUDu8b2Uc4ERam43/QZtivchKfK3w=;
        b=Wx46Mq9QQZjEtvyEU4KAjL0D7MPsXW8B23k8SSqsMkEMAKwOg6ilPKTv3h83815RDy
         cFx6cvK8mNZdim8gkr5pR/wEGuryrExJhla3aY7gtp+J437OPugGkyHF+6HpISp/HaAf
         Gw7LcGJQNRlL/8kzcTS1F7c1DpcrRdfr9Wz2ih+ccNc9BKFwzaxkDf4ooPhHZWCCa9DS
         Os4BNwt2aj3LKM1rMggVef5P2oywDIZhj5ozSIo6ktZfLkjyF7VATkdKb6Qb1oG09qxr
         X31jA1p3n5fMt++oxcD1xtLq47LhmivN50+D9+EqDFTz0H0rLp8bvOnGGzRMbZHIIpEk
         QpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754104806; x=1754709606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFJxqAjoXMQmiboUDu8b2Uc4ERam43/QZtivchKfK3w=;
        b=BoT2OaIzx3BAXE/Tz/YzsWYl0325SmkJsL//H1HB0C5h5bZTrXK7piTUhHbOwoMhXE
         DvTsB4IZC1f2SQsVVSrH2modA+DhxSjnLNvHn6ArTQvPWMGOMjgvxg1MWXUj3HZzFJqy
         y9N+EcjjseAQT3I0VOieeTco8hNT4plMy1vVHaepc0TeCTV7sukAzoijz04Kx4uZPbpW
         5siocKxDZDg/Tz5oZrK9BLirpSj3T5T8FF2SeJn3DONhG4VNrQ85VpyWusw6QmKELCfv
         VRND2Dp+6OvcaTv6qnTzJrjG9jIiuuQAHXjaQoh2dQy8usoOXJovwY+zr7mn3V8ikn04
         Nmug==
X-Gm-Message-State: AOJu0Yyqx4R1brG/k8Ogp24jf+bCrkobrNwuZGxMPd0VtthHWhetyF/t
	z+/zlZnQdHt1K/pJbA2UDj+7Fwuz86CMpQjhOcEephsywvIkRGTJ9bwydTAHV76O85t4H+3WVDT
	pEm+xkqOj0FZ0MWsayUHOTe7U0TE3g+I=
X-Gm-Gg: ASbGncu8p6Gyk77Lntc0GfpKGvw6Iep8t90ng6P0xK/usVXIvpwbIrnXBfB2FA2O9CC
	xiRScpFCsRd2oYnLcfdOICy5ikQYd/69v5TL21108UTReRE+u4EEQA1fv6Dra9hOFMw4tpWaymZ
	KxLCzjA6NjYsi5zrX4nZiTyu003oucC11CFMqXkTgfl49A5CTrLC3on1sxdGF4hWFGcxBCFY2kV
	CKFamhh1fbgLB5x
X-Google-Smtp-Source: AGHT+IFvQBexRhiHlkndrfR049tNPICFHpB+viWXnrPgDmI6HYA1YBnRVggGIjrlQQZUq5yAzus6b7pS7vAR5TTrbIg=
X-Received: by 2002:a17:90b:5804:b0:31f:eae:a7e8 with SMTP id
 98e67ed59e1d1-32116203b03mr3448661a91.11.1754104805998; Fri, 01 Aug 2025
 20:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729104109.1687418-1-krikku@gmail.com> <20250801143543.43c6843c@kernel.org>
In-Reply-To: <20250801143543.43c6843c@kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Sat, 2 Aug 2025 08:49:29 +0530
X-Gm-Features: Ac12FXyGpTiVy4QXaTRC6qg7MO6PFIFZuAMd6ogMpXbShvtp4Od8PLJiOfXZ7VM
Message-ID: <CACLgkEY0NBc6GQV=N0Wt5VpNrvhoOdW9M2q5ET1miV=kBGgw2A@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 0/2] net: Prevent RPS table overwrite of
 active flows
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack. And thanks for the feedback!

Regards,
- Krishna

On Sat, Aug 2, 2025 at 3:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 29 Jul 2025 16:11:07 +0530 Krishna Kumar wrote:
> > v7: Improve readability of rps_flow_is_active() and remove some
> >     unnecessary comments.
>
> Thanks for dropping the comments. The 6.17 merge window is open now,
> so we can't apply any patches. Please repost after Aug 11th.
> --
> pw-bot: defer

