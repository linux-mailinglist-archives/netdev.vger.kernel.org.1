Return-Path: <netdev+bounces-209050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B6CB0E19B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D996D1C85168
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459427A46F;
	Tue, 22 Jul 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNISjHZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3272797A5;
	Tue, 22 Jul 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201322; cv=none; b=uN6GMz8mXdzrqywRUgvMxCgVOAwhoW0xakbxONuu0ZHmPNLhOiJcTSu/LEFIqPvxgw6dNvGL+xVYUbI6q3r4wEEVVazS6HYPOCopD2OTHWptsiFfet6/J8d4a99ztsI9LuGAn46uKgry0l9vPSL3vSJvA6ZLcU9U6Yda1vaY5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201322; c=relaxed/simple;
	bh=gCgFWhgVPls3nS3d3Hjwing6Ok1m6HRQ0NLENS33B5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5/mY57K2Zq6+dYjTnpSZ4lclPJYUzbgC3zBRInikX9d2HruafCwgFrJo1vtQZph0nv7iKhsmi2H1Clen8C0cDRByI/jWu/hRkB9GJQUdrggM9PclWRQM3SmiMzDXcPGR1OrwxrzNuth2cw8epVwSFH35sRCXFKyoNuNCPqkbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNISjHZd; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6159466e80aso2747823eaf.1;
        Tue, 22 Jul 2025 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753201320; x=1753806120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YryPN4yfH4WyEOcopSfR/NDvMlQ6UvyM4OKGNmup5s=;
        b=bNISjHZdxONIi0ESfFEQLi+R3yfN6thNMaHltAEzwnK3tSgDGEjLPSQNEf1bnoaW6w
         KcdprpSOHxDQ7i8wJNCaQf9ulxzMB9rhipihDCUn7/s+c/WDxTKPjU6xCu8G9R4EWiWX
         b1YD6pWfIht7w+EOcgRORiiu51zPZST3llxlELA3KG5HnTkPB1KGH4WuDPs3bSx8UN6i
         kgCSecQo/wmJlbHdYaycdunqgprpdDLek8joyRaPaM2+Ge69BlFcuPkyEc0Zdefc4kbr
         lQ7fGUQYkPo2zpaOYYSK3RNf0a9OyvqIytC6RcbxWdPulDRkM/QwsmZfMoEVHCZErjPX
         PqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201320; x=1753806120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YryPN4yfH4WyEOcopSfR/NDvMlQ6UvyM4OKGNmup5s=;
        b=fai5g06jfpnQHUQZBXg8tB6tR/LExMYoxxr197Aqo9rsafgVz/UEq2CqU83QEFWEiq
         mHAv7eTvPa/XPORpxBLqnkClP7+SJFVV9OwtCrhV53HbKHZMc971IDstqwrhtsdRhZiQ
         KQGjUnn7B1fyvQxmuk4Ji+MFlWj5JVBaS81HN4koOFDVVojiklAKRzTcqgUyt2IuE27Z
         5MLGbco5g86I0s+RA9t64QxyrzrMJ4T6O7zs+DI/xtfOtkzeGwWcxUuM0P/wHzI9FvEG
         2CgqXPI8KtRNIEVzgdyr50KIms0LxPcKu8RODOXWZImEPnNwJXG7EON2w5L69At5feEd
         9Ylg==
X-Forwarded-Encrypted: i=1; AJvYcCUJAaqTDQRO9xU+s4QchQ9tD5ynpPBZTlu+G+3tSj5Z777rGDUEf4zDuxSunMRXSpGQUtEXcloXQN44Mvk=@vger.kernel.org, AJvYcCWj4yuaVEeUNmjrBpg4cuwGJGpwG4HZR0Myvw6QfKjPvjAXptb5cbVY9R4m0oD6PFJXbF6EYWQv@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTA4J3jpQ0917jYSe9HUQNpkSpnh4Kb9p2JYkURMmvcloxItC
	nxeBfLFZ9FxsOK36XHWcpjrcKnYuEP4AkAZXX7QEqhfHfM+Dd6zDWOfzB23LPgGHnt3IlXkDNE1
	ttZpG93MY6AUqGZa9YRiUb9FMvloi1OI=
X-Gm-Gg: ASbGncvcE+z7Oj3uOkgL9PE27yjm8lq2qgaCVE7if7vSbP4GwSiVHPRGerwIwjSMYIo
	4Ldt0taxIasr1TY5LJnPqPzl1eWHI4pUnigzQAbhxJkmNCkQ9YplbrUoSis0MbjkZS6k71D1Qc3
	i25N7jb1WrCBDo9cnIv31UOMpyd06PNmm+Wx0urtLH/P/MSBgIK+Eh9GCELtAYvJTJEEx2hWFmn
	inN6Oav
X-Google-Smtp-Source: AGHT+IEYCkCjgB9Gt/JFQzRKjHqmBKW+mGcW9Q9RRQw2mBGtJaG4K7OEwqB8wQyZTLnDusT3/VRax6jkddmgqLf3rhM=
X-Received: by 2002:a05:6871:7c12:b0:29e:2d18:2718 with SMTP id
 586e51a60fabf-2ffb2461d4fmr19477640fac.28.1753201319966; Tue, 22 Jul 2025
 09:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com> <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
In-Reply-To: <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 22 Jul 2025 21:51:47 +0530
X-Gm-Features: Ac12FXyt_g0McvdgL7IcCP1m3sdm0u0AQxMmgF5qAK_fUZg0rFYpq8SaHTzO8kc
Message-ID: <CAO9wTFgzNfPKBOY5XanjnUeE9FfAGovg02ZU6Q1TH-EnA52LAA@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> WRITE_ONCE() is missing.

Oops, I'm sorry about that.

>
> > +               while (i >=3D 0) {
> > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
>
> What happens if one of these calls fails ?
>
> I think a fix will be more complicated...

I did consider that, but since I didn=E2=80=99t have a solution, I assumed =
it
wouldn=E2=80=99t fail. I also have a question. In the Qdisc_ops structure,
there=E2=80=99s a function pointer for change_tx_queue_len, but I was only
able to find a single implementation which is
pfifo_fast_change_tx_queue_len. Is that the only one? Apologies if
this isn=E2=80=99t the right place to ask such questions. I=E2=80=99d reall=
y
appreciate any feedback. Thank you!

