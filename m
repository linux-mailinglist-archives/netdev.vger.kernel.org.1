Return-Path: <netdev+bounces-133211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C9995531
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C34BB26595
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA021E0DE2;
	Tue,  8 Oct 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byzNQWes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336153365;
	Tue,  8 Oct 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406764; cv=none; b=b2K0+JpmOntjhRuu1/07asJgY0+rd7CN+ODWTB7MD0RSw8FN7akWoD83J8vgCFPRmT39oiDuq11Mim7z47h3DpGARCZF83prIhxt03IvGxQKzX+VRpk3Tno7aj+38gfrQRtscs9YL6gPO5yZNh5pO3esE4ccjBj4VRdsa4xmNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406764; c=relaxed/simple;
	bh=ww/PdwMU32dIxV0+2DxsU66aBiSWMXdRV7q+lECsFNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzCXYgaDc52eFl35BjPZBuzenkYncxEImtmOpJU+S+r0R4o110owW2eYUz6fYyOOqAIL9M50rZuzjTZz6+Q41Z7duJ+UFiX5t02cUebPwVhrEJzju3e+TEaDeY8nrA5WyVllV7tSJiRYEpt17Bex9w4uSW1qikmP/1GDf1APSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byzNQWes; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2facf481587so49837101fa.1;
        Tue, 08 Oct 2024 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728406761; x=1729011561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFgf22IeF2Fd7XqiEj7HlqG+Di0IstmknMdZldE+EzQ=;
        b=byzNQWes5qRmgi+MJjZfnm100ZdUzmc6CbsBKjAPEWs4OuepK/kv/HPwt01R7BSf1a
         /0NxVaNCibJr0tPDzQrPME2vcyhGi/hgUAaCwoAg9yhDcqivW50vXVv1RkCUUYDvIRYs
         8nMRbsvkE5IcD7yqQQmYgjKsqvr3j0Y25qmdXPLYtUCzENROajXFT9aE0dfU0f3tQMfz
         O/LkD68ywngEm4hGI4pxozNWWYROa/gA5pIOc2wsGgRy05Gd0PilZx8Ocj3Fh83d4nmO
         KqUkx8RS+wEUdKkVbsYE62VMJLBArInKuQhiDAdEuZPZqGWseedekYtgeoivRtuuqKCH
         fF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728406761; x=1729011561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFgf22IeF2Fd7XqiEj7HlqG+Di0IstmknMdZldE+EzQ=;
        b=IzBpJkjisqxt57YH6CMhHgmFp8aieofbLTqfMEHik2lN3BYsijQov7oUc7fFK9p6EM
         WfoaUaFkQAkc/JcfDJC0/g7VB8t5nIqLg91AAqrqIAUgBFd1+bA+vcwncGHOvGt8mFxX
         GIg0IZHhz0Bd4FLBEtiHVJf6+byOTEALGGhzW1qbW/z1rWDsFbBvqXeTOeStZifFtZi3
         y3IbIsjs+HkP04u4DF+GAjINFqrXcIw8wW+ZbXuo3ETPyAg/FlxSVL2FYHx60lkjBRkq
         7lOma5IkURJnphaQgqGOivUbKMovMouE73FRcxIM4dCjQXgpKyavFB4S0fW30GNnX/ZI
         KK9A==
X-Forwarded-Encrypted: i=1; AJvYcCU1qtG7+s8mhYJqiwcBx+m265Atz8pXfvvfV/DwaKNA/hRl2gTZSKKGjiEAggh+iGfQ9Jt4MCIq@vger.kernel.org, AJvYcCXSGCWVYo8730F7rmVwUXnkZkrB854HDX+JH3gEyiLYVQun08wFwhmIVqwe1x/iIh+b5MWizbCFdwFQ8OA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0InyuJyDOCzwXKpi0U7nqV7C19lNiU495+XNljfiBuC6alcdy
	904Iwpfu4UaN/hdh1dvKFieUksiBs5xlnfhbSx/WZ27Jpsu1moef3TrWLhFFr7OrcdV1HiJPIdU
	7UeERKxRokEz8i+YC2jCK8dMundRND2pNHz85u7B7
X-Google-Smtp-Source: AGHT+IGjaWSRhSPVNkoNqb5MZeA9wXUH299qFdknPM0dXQsR+d+960UYHK2+rTeKjS7KFceadFUlN9N71Mx+dFS6tqw=
X-Received: by 2002:a2e:be1f:0:b0:2fa:d4ad:f4df with SMTP id
 38308e7fff4ca-2faf3c0c141mr74718161fa.7.1728406760601; Tue, 08 Oct 2024
 09:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007092936.53445-1-rand.sec96@gmail.com> <20241007172715.649822ba@kernel.org>
In-Reply-To: <20241007172715.649822ba@kernel.org>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Tue, 8 Oct 2024 19:59:09 +0300
Message-ID: <CAN8dotnMoh9VKd50MQx=FJ9ALhsHp7DMsMNq--EdrbWb8=Vv3w@mail.gmail.com>
Subject: Re: [PATCH] drivers:atlx: Prevent integer overflow in statistics aggregation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chris Snook <chris.snook@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	deeb.rand@confident.ru, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  7 Oct 2024 12:29:36 +0300 Rand Deeb wrote:
> > The `atl1_inc_smb` function aggregates various RX and TX error counters
> > from the `stats_msg_block` structure. Currently, the arithmetic operati=
ons
> > are performed using `u32` types, which can lead to integer overflow whe=
n
> > summing large values. This overflow occurs before the result is cast to
> > a `u64`, potentially resulting in inaccurate network statistics.
> >
> > To mitigate this risk, each operand in the summation is explicitly cast=
 to
> > `u64` before performing the addition. This ensures that the arithmetic =
is
> > executed in 64-bit space, preventing overflow and maintaining accurate
> > statistics regardless of the system architecture.
>
> Thanks for the nice commit message, but honestly I don't think
> the error counters can overflow u32 on an ancient NIC like this.

Hi Jakub,

Thanks for your feedback, much appreciated!

Honestly, when I was investigating this, I had the same thoughts regarding
the possibility of the counters overflowing. However, I want to clarify
that the variables where we store the results of these summations (like
new_rx_errors, new_tx_errors, etc.) are already u64 types. Given that, it
seems logical to cast the operands to u64 before the addition to ensure
consistency and avoid any potential issues during the summation.

Additionally, all counters in the atl1_sft_stats structure are also
defined as u64, which reinforces the rationale for casting the operands in
the summation as well.

Thanks again for your input!

Best regards,
Rand Deeb

