Return-Path: <netdev+bounces-130964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B598C3F5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB831F24098
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433A1CB508;
	Tue,  1 Oct 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnDMWlTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74C646;
	Tue,  1 Oct 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801569; cv=none; b=eyxY7441cFLKILGteuxGZc+Q24Es8//Mdi+9XvylpEakkz9CMQ41fp2BwilcpXadjIF1sYQjilQS2XgHuxhaYLwrf+RaMRy8RYZ3PhpgCuXYO4DW+U+Gl2oHJJSSyx1I4USbeexI46B9Lbp1J2fuWQMgtC902CfV4Xj95BNR2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801569; c=relaxed/simple;
	bh=Z5kdJIZxkpOTDXg8fiU0gAk5yz630imYDW3eaP1oF+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlelZOE5PUJ+wlw5ZpiMPPHqkSaqn+6jFnHzoM5IqxdPtfOa53DaxsXb3iHN26jaiqygEYkbZFlQgL55/wysKDFrETI83RR7SwtwfdT1rXqNDh6UoxW860xLjnLDrJWeh6UINTIZ73M9NJ6+MOzvdqcld7rsSqPW1ut3shOL65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnDMWlTE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398f62723eso472481e87.2;
        Tue, 01 Oct 2024 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801565; x=1728406365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5kdJIZxkpOTDXg8fiU0gAk5yz630imYDW3eaP1oF+c=;
        b=LnDMWlTExWwcqml7+XyS/AQQ1PYpuCsVy2Oz7B9fIz1ZNyLCE6gGEoKseR4Jbzk8ev
         eVXI8D+rePdn5VQaWigcTGXUaqamzvdbIhX36c5XMhhYDqJPxJH/BRobj3xUtiEQwRg4
         7GP9y/IAcIL+q2k1mj8wQ+sdTngWBZMB9948fg8mMQoxThNb0Tj/WdouPAM0p4K5xRM9
         ZUuh7hN0s+Jhn1c4qI3gGugvw0+FJILrn56MIDD2AB7YvN0tTQyfbJ7KZohjUwlO4zo3
         v35cTUrtJ7hR/3Z0PKRxA9T664poEl0Vg54gHAk+AoaTjK2TCTRrHqHFdfaee05PvtrN
         XvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801565; x=1728406365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5kdJIZxkpOTDXg8fiU0gAk5yz630imYDW3eaP1oF+c=;
        b=a9ivjyIjf43lkPFqXLEu8Tno+IF7GqVYgMv6kQd2SdK/YEyIA9yHhaWl+cIJq1rSQC
         ioAHydgwMs9sZTK4AYVQg9EME+ynGs5zo9fOKKRmYoWIAc38A/RlT3ukvueRJWPaK/6P
         a5cCxnMS7NrZXlLhwO/bOD9BUAhaDONRuEHLEpTnMv7QmBWrnR1avVYsj/RJLnqj4qGC
         8n53ntZ4yCubc4ug/eUR4yfB1dmB22BrbVLUVOHkWmKVRmu2+JCoioERn/h401IkusEK
         P2zDOb75uiD4rUD8MMjbTx5nNqC4qgdNYYyIFonqDDNUlAfROwN+vmaA/JU8EopO34Jj
         Xmww==
X-Forwarded-Encrypted: i=1; AJvYcCUT9dkMJCLpA0r286LMtymgWoLETv/o0G/utS3+Hhsg8CyLS+4NK/YaIiiNEjcaqzmnEwXmqwY=@vger.kernel.org, AJvYcCW59gUpLketvvCB3kTYlCucZJJ5VXfs2sIKly6aftW1LXP6O+SO38vKyUogg44ydaTV7489AqJoGnzXCKwrrrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZKb089HeWgUbAOVt8CWrgZ1tLJpfFit5PZjJ9zzwGHYOugZR
	le5e7o9GwtTeHavZXnuM3k2UwUW9oqz8+DfdKdPXMam0ME0s4e/aJdKAzyRbYFTIPfQoLe74FZa
	0gboA4mQka+yzc6VpAqZq7eXzgC0=
X-Google-Smtp-Source: AGHT+IGc8XJ1d7dB+/PNLfT88Hr1HD7DANKpeM8JhEpqh+dVkdk32NUV7lNuBSGaWflyr1inrlS9h4aUYGcrI1ycBnA=
X-Received: by 2002:a2e:be1f:0:b0:2fa:c944:9ad1 with SMTP id
 38308e7fff4ca-2fae10b5964mr869251fa.11.1727801565141; Tue, 01 Oct 2024
 09:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926121404.242092-1-fujita.tomonori@gmail.com>
 <CANiq72nLzigkeGRw+cuw3t2v827u0AW8DD3Kw_JECi3p_+UTqQ@mail.gmail.com> <c4a0b7c3-f552-4234-9b7f-fce01f2b115b@lunn.ch>
In-Reply-To: <c4a0b7c3-f552-4234-9b7f-fce01f2b115b@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 18:52:30 +0200
Message-ID: <CANiq72==6J44DsHh7YOMoG_43QYErq64dHdtC++oJcZfbsDeHA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: phy: qt2025: Fix warning: unused import DeviceId
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, aliceryhl@google.com, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:36=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> It was marked for stable, so generally means it will get submitted to
> Linus in a PR on Thursdays.

Thanks Andrew, that sounds perfect.

Cheers,
Miguel

