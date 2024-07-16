Return-Path: <netdev+bounces-111805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF125932F51
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BD81F23DA4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F097E54BD4;
	Tue, 16 Jul 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY4ZkLpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6DB19FA94;
	Tue, 16 Jul 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152036; cv=none; b=RJ89FVuUGPnpYdOL55/t0tUBnJUQyTWzBT7lQOoqbCUiVi9oPxOQug+g6w+6cP587Knu1APGJ+hcafdSJzAKJ7Tq+lrWyfZAFwwNF1yFMV+MJyjAt5VRbxGG7hJINiYU8/l5Jkp9NsjTZsrzO+9qYlbNOWRaysbEybcAyzYs9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152036; c=relaxed/simple;
	bh=zP6VZGFvNqh6vr2WndNyDJWCO94Nxi1jI+zWTjI1NW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+mX2dhG9zA41LELiesnVDjxvRuMsXnNdiKApK457CwvlVZ1dfz63HTzn1VNg+hlQyJIN1XoXmxq3oBXZRkqDP4jYOBgqsVHIkOpVu4TqCZS52YfSXOsJTJMFddmkqmjKkgx74fk5eOaERHdySz5InJVjZtfG9HTbbAcC94VKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY4ZkLpZ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so6048368276.1;
        Tue, 16 Jul 2024 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721152034; x=1721756834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP6VZGFvNqh6vr2WndNyDJWCO94Nxi1jI+zWTjI1NW8=;
        b=QY4ZkLpZ3XP0NgdGZJLkHI/xbkjxpGFyq1I63K5AHemjcWK2E8QhoVm8HnGlTOmP/w
         oMzVB0Gn3RJ0nFYaUO6o5rg/mnH7dGfTsSNh/WkyV3ZaZx2eNuTMN7Ps9XNB9myofGKV
         uS9gRPxNNVDeLBWdo24NBVt5YN3PnOwNoF/dDlZ6lA+x719A/ZyEQKZ2hprrrw6AUdif
         ef0H/FSE9Y8s4hx7k7MFNWFY+1FuuLHBleBrM/kTBLT8/NW7hcdahwh2y+9fNzOKJita
         yenLedSklj/Dhpv6Cr0Cubd3uOITynGipiEANzf+iItN+Q5Dhelz6NcqDPEz5ehiMnPd
         ccYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152034; x=1721756834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP6VZGFvNqh6vr2WndNyDJWCO94Nxi1jI+zWTjI1NW8=;
        b=sQ9fJcLIsdCsZTBYY6rgu+kxIFgFaVarFhiV4KsOiErvZATorDe6NfoY34DVxQampl
         LpNKSNqnw4/gWC9Cs9NO+cQlA2ygOxCLuVi7mQQ8xWMyIdEaZOelahjXY+QdK2qYtIGO
         ATP86VqPVvUW9RMt8Ar7KiASRwNSSyQEN3JDSqGHH/CYamDw0KKErQF+zh5APa1oWu/Z
         vE+ekLDlR0RvSD86Iqo9WiC5Kch3TlRot7vczyjQNqnMWa8/RzlytlJEHgFULLlwNJiH
         3FiSHmZr78VDdBR44Eldnh8TAc8qUyIPfn+lBZbEUT8n49uJ+lCA0cyQ4NVZlt6XUwVm
         fC5A==
X-Forwarded-Encrypted: i=1; AJvYcCXiaYQ/t330zuMYimJAdylRblDkrWlE+XRBswuVeAjSfOeGpzx0Z7s/cC18qTgtYiWxMUHSvrz7pZZIAumsMpb1rt/IX3a86BIcRDWQ
X-Gm-Message-State: AOJu0Yy8Xc8xxc9Gk4O/c7pvoennr/7Ui3GE5vnBSiLY/Wl8syMhqgdI
	OortYWHf6zovsxuSYo400D8v8t1vETQw2aVzeZ46fAiwJtVruvNP38rw6hLWD/BtwbrK3wfxOaN
	mUaaxtJFMtEG2swk1ijCrEdJS6ZaqqnWdD/8=
X-Google-Smtp-Source: AGHT+IHVOI0HSJi0zRPxvELEb2w+OnjZ3yJTvbCTUdAC9u98fwxF7zADV1Q4j7u0zTquMsEiV5uh2BP6gWBZ4FpYsoc=
X-Received: by 2002:a25:83c4:0:b0:e03:6533:136d with SMTP id
 3f1490d57ef6-e05d58044c4mr3376413276.40.1721152034314; Tue, 16 Jul 2024
 10:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713211620.1125910-1-paweldembicki@gmail.com> <20240713223629.ncgkw4cg6blakv2e@skbuf>
In-Reply-To: <20240713223629.ncgkw4cg6blakv2e@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Tue, 16 Jul 2024 19:47:03 +0200
Message-ID: <CAJN1KkwWx3rHj5+VeLCJu74U2HWhsKBhn05pp2SjF=1JhKAKbg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/12] net: dsa: vsc73xx: Implement VLAN operations
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

niedz., 14 lip 2024 o 00:36 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Sat, Jul 13, 2024 at 11:16:06PM +0200, Pawel Dembicki wrote:
> > This patch series is a result of splitting a larger patch series [0],
> > where some parts was merged before.
>
> It is a good day for this driver. Thanks for your perseverence with this.

It's a small step for the kernel but a big one for me. I'm glad that
we managed to finalize this series of patches. I want to thank
everyone for their help and the many valuable lessons. Especially you,
Vladimir, for your immense patience and willingness to help.

