Return-Path: <netdev+bounces-216218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD9B32989
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B615C1C58
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DE239E92;
	Sat, 23 Aug 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/KMsEpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0D20297C;
	Sat, 23 Aug 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962836; cv=none; b=Q9mQkv/J8wCreKQisMGnEi04tAZmgrJsJ1PAuCG6QyLonqmyjDL9uRdM4sFBB1M3ZcRD/S9ma283GPivZX1T/VrA1boMi9cGCwC+xPQYnK2WqctkUBkHwypCT5tlNSbtRC2/bufZUDVwZabJdVsaQ/eDk/yU/n/cDnhu6kjFt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962836; c=relaxed/simple;
	bh=qG8rdv5V8RmAtAHn+YMcsnsiYCckd/h+ync8GzfYo4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC3CCFyy4UPyA6x8Ccqkx9T9ts3XewQCfKEhr8Y+KF+VT8FrFRmPx5GGNLCkMAH58UrwwnF3LqDPEn+u2/AVSi9HrUkYjrMivUngX+ZeBrdktbZCH6PyhtbbRFgpImEEmBkxRqwNXrIGSWUvu5k7GsyVDGakVVxGxoh2lAeuNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/KMsEpo; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71fab75fc97so27538577b3.3;
        Sat, 23 Aug 2025 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755962833; x=1756567633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfFfbML4vi6dhQ/f2wCndzVorOOiv/586FDQhEFJGNg=;
        b=L/KMsEpoYdp/24K+JnWvzu5R/Bn3oVyXJL/NWMOmbCwnOWSeZjHL4cAfYVZa8XNmgB
         JuDOSUhd5hCdMCgLgRt39And60EXpEdpqVndqu6v/pyFjC8VJ3lOO+ThdeTntjFCQ2y7
         D6V7NBX2QHYpdLPyPt4jO8kK9MUqJGyFSLFOIPGzf7vw8nV4HRKRRVmSVWi3A6w2sw4d
         Pnl146cRSNaOwIv1hYm11xKWHuFncWZ0SQZ0yYYlsg78yTgVOm+dmPR+ni2qx0EESVma
         aZNiutkMz9kH/QhMuzJMLBEav+MIA0qPXzEFEwyiDlvA3UCGZSVKaTI8kWDMCDfFZwxf
         gehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755962833; x=1756567633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfFfbML4vi6dhQ/f2wCndzVorOOiv/586FDQhEFJGNg=;
        b=GUyRsLpL8/pdEN2Df6/HOnrggVnAFA2j5zwub/sfYoMUuEgj/6Y/KESYszLWlCDH33
         7lxz0RF35cidQGGHe07uYD9IumK9c+ExpzNC2tCp920GKMdv3PIQYhBf0oLxeZ9+ehMr
         lqCjcB46/eF3v6eMbuAXPhBxLS08eAbDSKsd6OM4YkGLRNz+Zx2aHgMXS95YAN2QjmnY
         XMdqVa4S662x1pk8VTYw1cuAextGwU6Se9cIbNagzFOkWNbKhb3sp9+PZXrHOkR1NHo1
         IzoPMSd1FUHvjCLj+qlp7CeOTxIdzY0YpqsZZNN0fSdDosx8VwmqqnmL+nnlicVZWsqF
         q1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmaZ49odeam940Yvw+1ekJrXoqhCCq+hnUOgbbnkunQBn444+MCj0DP9HLOEVaf08wfXdMA4Vw@vger.kernel.org, AJvYcCWpSljfRIPbDUsV4agXo1ilhaNtxuaknnU3pE163/yUYCr/vqrAIaVYXQOAGB+2Kl/mDWm40CKPqljwwPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+bk+uSafLiEta1HJ/stft/qJdCFujufdpXoY3la2caydb3Xp
	Ki7NsMsd8NUuqwanoPC937JqIswCvPEbqqORlUmZREszNXTamEUnWa+Xrk7pdcfFmctr928bzOd
	V6XgXsOJdyIBPNBTxikRkX1QO4U8e5n4=
X-Gm-Gg: ASbGnctMe3drYiMPFxulb/8PK7I9FrVjmWbHbExF+PKRyG9MVlKH/dyJTCOPTVAWFKf
	JANkXrGociu9wYUls3vnVvVxMBxfGAvzNDRkkun+Dq9XeX9TFbisOeZ578QLfA1i7lHT0tbiaV3
	5qMNxvi8niF0PiPX3mhhIygx0fC8MRMheZ6uQofWpAPs6G29oisabPUiRcEG7giJScrsqY9kxdM
	6pZag==
X-Google-Smtp-Source: AGHT+IENNbsllcat4PyjsC5DvJ7Wh/McNrICV88xz43GX+irDDG8cVrf61OaBVl6LWVt77dE9cFTy45e1yqpjAm6Kxo=
X-Received: by 2002:a05:690c:6a0f:b0:718:37f7:66d6 with SMTP id
 00721157ae682-71fdc3c8457mr75471287b3.25.1755962833417; Sat, 23 Aug 2025
 08:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823090617.15329-1-jonas.gorski@gmail.com> <4469d2cd-5927-4344-acb0-bc7d35925bb1@lunn.ch>
In-Reply-To: <4469d2cd-5927-4344-acb0-bc7d35925bb1@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 23 Aug 2025 17:27:02 +0200
X-Gm-Features: Ac12FXxbwpPigktQlGnT3wiHc4Ew3WSInyScks4bOmK7TxTQCPRaqqwvkNEu1DQ
Message-ID: <CAOiHx=nC5f9-2-XPCKBVuVsh93NSrmbSQJp8RqF3EObbEq+OOw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: fix ageing time for BCM53101
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 23, 2025 at 5:00=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Aug 23, 2025 at 11:06:16AM +0200, Jonas Gorski wrote:
> > For some reason Broadcom decided that BCM53101 uses 0.5s increments for
> > the ageing time register, but kept the field width the same [1]. Due to
> > this, the actual ageing time was always half of what was configured.
> >
> > Fix this by adapting the limits and value calculation for BCM53101.
> >
> > [1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob=
/master/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966
>
> Is line 28966 correct? In order to find a reference to age, i needed
> to search further in the file.

Hm, indeed, it's #30768. Not sure where that original line came from,
maybe I miss-clicked before copying the link in the address bar.

> Are these devices organised in families/generations. Are you sure this
> does not apply to:
>
>         BCM53101_DEVICE_ID =3D 0x53101,

This is the chip for which I am fixing/changing it :)

>         BCM53115_DEVICE_ID =3D 0x53115,
>         BCM53125_DEVICE_ID =3D 0x53125,
>         BCM53128_DEVICE_ID =3D 0x53128,

Yes, pretty sure:

$ grep -l -r "Specifies the aging time in 0.5 seconds" cdk/PKG/chip | sort
cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h

$ grep -l -r "Specifies the aging time in seconds" cdk/PKG/chip | sort
cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h
cdk/PKG/chip/bcm53020/bcm53020_a0_defs.h
cdk/PKG/chip/bcm53084/bcm53084_a0_defs.h
cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h
cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h
cdk/PKG/chip/bcm53125/bcm53125_a0_defs.h
cdk/PKG/chip/bcm53128/bcm53128_a0_defs.h
cdk/PKG/chip/bcm53134/bcm53134_a0_defs.h
cdk/PKG/chip/bcm53242/bcm53242_a0_defs.h
cdk/PKG/chip/bcm53262/bcm53262_a0_defs.h
cdk/PKG/chip/bcm53280/bcm53280_a0_defs.h
cdk/PKG/chip/bcm53280/bcm53280_b0_defs.h
cdk/PKG/chip/bcm53600/bcm53600_a0_defs.h
cdk/PKG/chip/bcm89500/bcm89500_a0_defs.h

This is also what the datasheets say (they sometimes disagree, but not
in this case).

There are a few chips supported by b53 for which I lack
datasheets/descriptions, so they may also have that issue. Mostly the
BCM7* and BCM58* families. Maybe Florian knows more there.
BCM538*/BCM539* are likely not affected, they are older than BCM53101.

Best regards,
Jonas

