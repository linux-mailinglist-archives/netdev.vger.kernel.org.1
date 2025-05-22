Return-Path: <netdev+bounces-192803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FFAC11C7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3051174282
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B816DEB1;
	Thu, 22 May 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo4NCyb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E41624E1;
	Thu, 22 May 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933379; cv=none; b=G0DmTdma/HivkruGLmQMz+tlZfTWScpY2VsR2rkjwggyScef3AnjPEzkRWOBt1vjWqp4qb0U0UJSuW34zNJhRw87Khfrfwy4ayI7pKhEMK4jfp15by3D6DvUWrviWdRgtCa7GpHeZD4TPRJ70h6CseI4wV0KDE5vg+JOKR/MHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933379; c=relaxed/simple;
	bh=Ok5FoPBP7YEA3ocUoYDRwtdbxy+e04J/22zuDH0YDRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+Tf2X13HWX6q8hnbk4nKxTDfroZL/bniHI8F7OLTMstiSWZg8FKAAeGPoYodgyvsMIYptoqu96h8qt2vnYFN+HU8ZYVaUaoXPLBnFZjaQxbKMfA6L4khwgFAeG4pquystpJHRz0K9St99/yHtHoEpmh4Lg+ndQYdyzvQXa9Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo4NCyb4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32805275e90so47187871fa.1;
        Thu, 22 May 2025 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747933376; x=1748538176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We0y5Xpr50zg6HOukRfl3H6GTKBZvhrYRttEs21yp9A=;
        b=eo4NCyb42CpJJvMqw6KR7qDyPWX6+nyFpEjfkqq8hbSkqJDHB/PvrjZQSOJQRKgrs+
         0MtEaemjF09HmHi+AL5O0yeqVyEciHaFR7Qe58+6J/kOtvRPe/3S6hp/EJ+m/05LNbq2
         LbL6qi4JGG9EcCrV0zBr1n8+E/sZWv6DlCuaueZJYP/2awxShKohYYtx+tzvYPm456yY
         SowkwsZ5g/2To8IdhaEfpRpi4ZMGeuvyh98x6bMcKlqJwkSGF2QNpKEs2NHwK+yFPLQd
         DSnd2xMS0yHOHEY88VuBCwby6oRJq++VEOOLYSdgVvYlQvQ1rfEJz92PgWbs0raDyjms
         +MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747933376; x=1748538176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We0y5Xpr50zg6HOukRfl3H6GTKBZvhrYRttEs21yp9A=;
        b=kL62wTt1E0YXY40y5aFzh1ien4PeSFhRsBkMod/cQrcGiq83FF98/x7JMbKLr4V9nj
         vA1Vro3aIUFT4vwrg517L/1udxxzAqXzmQe7bQ+JE1sm9uPRjDOnNBtvx5KYO2JPV/Y7
         Qi8ZmTY4M6GtL5EWK2B4qAvuNatOZgjlCHpaFsQ9gq8yulx7LX9MqgHUAmWD4hd7TzOt
         go9k+8BN9DFGrCDUWYFe7c89F4PK9d4FgL4Bh9dtYlM3HfRmy7gw1b9+s14Yeb3DnCB+
         OpjgLG1hX4/2AV5gyn7709JnemUlCTAU+rLKDBH2NLiVuHwgIxKOJNxhkB7/QnwgT/Hq
         UcEA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0o8GxelUS3sdusC91m96ItZ50ZobE1UAmTd5uj3AZ0I5wmG2CCxU+tK6WS04n1KR7qVnGZsA@vger.kernel.org, AJvYcCVg/nN0E0r6VDflTF1C6xo71i5Kbg6dlugaJI6YCiFk0HvdKsZgcp2GeZk5ZWmkSvyO+HSm+Y0rl9J6yVZl5kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmH8zRLHtTUpRJKnE+hE2XvpuePzYNdpIds9Uib/kOWfHGeiO
	jaOJsJjVIBjDcrBoY69O/yvr5sSkKE7l8f3SVpzARg+ik9+iAUtRu+C8NFPhmAR/onow+IEcH3I
	98sqrFGhWThlXc9Y+4ZxWVOPgGQTvb/mX1ZMq
X-Gm-Gg: ASbGncv2YzJNZD9xKplY5I8P81TzhXJGGROVxCmbjPfH5Bfn3Nfpca0wJWh5pI3+yB0
	nyU2QkUmZt5efncpSAoysNdgYdoSAcEtzJKU5b4xMpRBrqrZ4UazwsUrJtHxjE5JoJ1T7UY4HoM
	57/JLBRuLqXi/2QOputXrQjob0KmI6yF4=
X-Google-Smtp-Source: AGHT+IEX12HECdGH93UZOr11br0jRtIfJM929AMncDIiway+/8UzdYLy1nWJWoRQ6w9I8kRJ3BAxeYP17kHL8QwM9tM=
X-Received: by 2002:a05:651c:3041:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-3280969a0e9mr76367091fa.2.1747933375563; Thu, 22 May 2025
 10:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521144756.3033239-1-luiz.dentz@gmail.com> <20250522095315.158eee1a@kernel.org>
In-Reply-To: <20250522095315.158eee1a@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 May 2025 13:02:43 -0400
X-Gm-Features: AX0GCFuLV_mV0Ph1YZlydj_SaaTb6pHzqvMkeviAgRtyttBS5YlErYPEA4Dv0vM
Message-ID: <CABBYNZKEULqzfjZ9Yoa=h3bT88zx6dM9LHaNddSOYWkjqLBp+w@mail.gmail.com>
Subject: Re: bluetooth-next 2025-05-21
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, May 22, 2025 at 12:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 21 May 2025 10:47:55 -0400 Luiz Augusto von Dentz wrote:
> > The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538=
d312:
> >
> >   Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-o=
ffloading' (2025-05-20 20:00:55 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git tags/for-net-next-2025-05-21
> >
> > for you to fetch changes up to 623029dcc53837d409deb70b65eb7c7b83ab9b9a=
:
> >
> >   Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach() (2=
025-05-21 10:31:01 -0400)
>
> Another bad fixes tag :( Time to automate this on your side?
>
> Commit: ee1d8d65dffd ("Bluetooth: L2CAP: Fix not checking l2cap_chan secu=
rity level")
>         Fixes tag: Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encrypti=
on key size on incoming connection")
>         Has these problem(s):
>                 - Target SHA1 does not exist
> --
> pw-bot: cr

Will fix it, didn't we apply it to net already though? Seems like
net-next doesn't have it yet.

--=20
Luiz Augusto von Dentz

