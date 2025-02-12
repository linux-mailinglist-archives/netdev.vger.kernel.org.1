Return-Path: <netdev+bounces-165465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E31A322B4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 10:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B06167262
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF61F03C1;
	Wed, 12 Feb 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOD+Ake8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D01EF090
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353643; cv=none; b=pg4TwUmEU6Uuekxw2fEfS0IEweIXj/iO73kkE/OeX7OjH1JYihRIHC77e4UvefdbREdSqsX+54o65OzY6GJyR6DYePZ37Jm7Pcn9kPg1f9lvrOWE6IqidWKUGyfDfWZaCcjlZIhMKdKL1+w/8cq9BbIS7P5wKlZZy2bOcJxxrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353643; c=relaxed/simple;
	bh=TKqcICL6TXKPxSRegpy9J7XyX60nER860Jd1kslHKlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyomYi9fyhLoaOHvbeY/i/Zaabd30OuE/RMFd8S8Rs6M109tUtVqIDzqeCQ9lx6Zm6DCt+fQme5249zxVUz99qneTP0t6QA6ZVjOH4niS/bGGMUpFLtycIlxEfq3kPzML/8+PExQD+y+W/7S9+GqlpkGlPnZRRx6jBM2X825iZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOD+Ake8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso9782554a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739353640; x=1739958440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKqcICL6TXKPxSRegpy9J7XyX60nER860Jd1kslHKlk=;
        b=zOD+Ake8DyXjX6p5UpYt0dkTWSVP3hII4Pb9TTAmi7P/ajGoE4D/QRXJGStq9zuwAK
         HpJkdDOGnMbcMTGhjKbkKkAIhUq8e4qYeYJiE1u5IE2xT3HqRlJopjmz+dZZ4fjJO9LH
         bPHYWpCDdOAM/tjO0y+YCTAVi22GmUBBtPN7+oS4WzxmAckeGO8ph9yfQLE+VWbAhw7a
         2LTnj7H4ZimyzY+zbL7Pto4STZt2bMxo7JDT2gO8hMDz+owHV2GymQqjmEZfe2Wz88gC
         qd9Kel9Izes7JmuxIXoUAg07SgUvo3JQo7OIHIi+XnkNPnEybnNB3FZ10DLMUU3hPIsZ
         xm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353640; x=1739958440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKqcICL6TXKPxSRegpy9J7XyX60nER860Jd1kslHKlk=;
        b=ii/1mox57GF/TyrvxQ8rD5FwUfkb8YWrN/89B/gJ8oMpwmRpgG8pUbUF2m1yvB3DAj
         LA3byPY23JlNtkz55IQeeNBRyA3LlGLexAYR5TdzG/BUylgVDMvvlFp61Og47DsdZiAJ
         cT0UIvJLd+Em/fDahjcRT6poEuiiYQwl5V0H5U6jkSTUM95kLc2lsxWdoPVyZu7CD86o
         4X5zcsZ2YDCla29veHB2I/zW4UiL9SawNjqg0G5Rl857ZK9/Gx6DBkMAa+UA+h82IaRj
         c9yFLCSEV+AX3pANk3RVtL5PP+AM0/qNzENrUboegHLr2G5bL2n4J0l0TI1UeWtWqySi
         JwFw==
X-Forwarded-Encrypted: i=1; AJvYcCXEBx6N4PgYiLyP6HkL7BzgZO+X0pCeErpBsmEItWiW+z/CA2sQTY0ITcbJjlC7zWMKNIeWePw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cKkhropBxPiyFn3tgqwrBGv76dxN9d9BU/wfWkd4VSrLqh3Q
	RyAvSgItFVG1Y27Eu6i4fKjBUBchzEg6+0Wt/7E44li6OrKTDXOowbPk/51h0xQ/aN9gSyGGya/
	WTYUVVXi83FaOk3+hSBQ6MOD/Dr9rD5DPsTGr
X-Gm-Gg: ASbGncvbTNKg8awhFqwEFY7daMHGmy6TBsCCMxoBnNDL5ZXYQQ0Qex5tUF9l2ttZXjY
	1a70RMyqgmffraAhAWg48IrerPlp6w1l4U8GdNoi/UxMSGlVyHb1LAcaAVuhTKqQM55zCPEGPRY
	M8fJFHdsGWP6oxtZZqby8RkOY+s1X4HA==
X-Google-Smtp-Source: AGHT+IGQtYtV8hB9z4cqfu+GD6xWt9yKHzH3Tmh6TBoqYNAt+cogJqa1226aKLwvMy8OQDTzT4ej9do/nT4u8m18J2A=
X-Received: by 2002:a17:907:3f8d:b0:ab7:dc1d:7d7d with SMTP id
 a640c23a62f3a-ab7f33c578dmr199546266b.25.1739353639819; Wed, 12 Feb 2025
 01:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB04210D3E18CFEA27AE9E9338A1FC2@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB04210D3E18CFEA27AE9E9338A1FC2@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 10:47:08 +0100
X-Gm-Features: AWEUYZmVcw8L3xAI6H_huoGpEXCmHBOAY8OxIyVRj6KAvbkKDGsIbSCp832MFn8
Message-ID: <CANn89iKxw4=29p_Ys3H0=mDQFOfZYbqxaTuLsRYK2X2tJCuwHQ@mail.gmail.com>
Subject: Re: BUG: corrupted list in neigh_destroy [with reproducer]
To: YAN KANG <kangyan91@outlook.com>
Cc: Joel Granados <joel.granados@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	"j.granados@samsung.com" <j.granados@samsung.com>, "linux@weissschuh.net" <linux@weissschuh.net>, 
	"judyhsiao@chromium.org" <judyhsiao@chromium.org>, "James.Z.Li@dell.com" <James.Z.Li@dell.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:18=E2=80=AFAM YAN KANG <kangyan91@outlook.com> w=
rote:
>
> Hi:
>
> I found a kernel bug titiled "BUG: corrupted list in neigh_destroy " whil=
e using modified syzkaller fuzzing tool. I Itested it on the latest Linux u=
pstream version (6.13.0-rc7), and it was able to be triggered. I found earl=
y report has no repro. I have a reproducer that can stable trigger this bug=
 .
>
> early report: https://lore.kernel.org/netdev/20241007202240.bsqczev75yzdg=
n3g@joelS2.panther.com/
>
> The bug info is:
>
> kernel revision: v6.13-rc7
> OOPS message: BUG: corrupted list in neigh_destroy
> reproducer:YES
> subsystem: NETWORKING

FYI, there are already many public reports using bcachefs to trigger
'bugs' in networking or other layers.

Do not send other reports, or make sure your repro is _only_ using
networking stuff.

