Return-Path: <netdev+bounces-234830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3130C27BAF
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 11:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72931896504
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449F275AE4;
	Sat,  1 Nov 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTDvP6vd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372719E968
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761993146; cv=none; b=b2Y/CxDtugu3hTuVkoSue3gogSbxkzolqw7psDVJRBWhPlht7CXMQCTKxcJB+6cR/yNYGoI3pHwoOVzUIO7zfY0BSgzMipFxY849Be7e5bZ9jkSauR6pySt74mvFZfR2l56pEik1FFSFnWZ/tnE99hHT86lSo8IW3zaifKCtGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761993146; c=relaxed/simple;
	bh=NW6qcg1RDligTQyOy0VygB5sP9HaChJrDCwpOTpDTJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGxZ9DnoWoewLlHoK2dHddu7IEC3dJ6/9usoD6Ztm5ZrDOuSrR5AoS2kCdsg01m1yyQ2a/9CRrNtmsoXAdNrco4A0ANtROh7GTeMFYxmtRwWgNyPKVyHVxUJ7Zwy7oMbA25XjFh4omETZS6EBqihybGKYlka5P4U10GNHd7dlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTDvP6vd; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7832691f86cso54784437b3.1
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761993144; x=1762597944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW6qcg1RDligTQyOy0VygB5sP9HaChJrDCwpOTpDTJU=;
        b=HTDvP6vdVU8kcVnbzwHDne38aBP8Ech07+/JrG6AtwYp+OBxqBAIFinQ7lQ5w96GWv
         DudLlkwR8Ba3gpwTQUZMScGPhxOPDsHXnXgspszaEQagiTV4i+HeOSQmGJSHRlu8RSiH
         AZ4Ni+JGTp4E46mppmMQdpZ3/tfDRoItuJQ2sJdTwoRgcNlZpPkCG0QaV0zMMafsmkTq
         RUrkWTuMixC9rBwnEaanfTMSUOciASChFFDzdtKHCS8OotkZGScaKyO2CepygMqvtw4z
         X7Ycvs8JKWtpIc9+Gbt24fxrXURhG/qanhxkmX3yYbEFJXAqOaiM5mF+AzfpBeIK6rM4
         l0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761993144; x=1762597944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW6qcg1RDligTQyOy0VygB5sP9HaChJrDCwpOTpDTJU=;
        b=rX1peH2rkni4EFdVtg9zgDYBAWJPWaQ1j+35Pyut0DmS0MOsUIF6jcJCwGql+vy4d2
         1uWdgubInVPLsd4uZSEGiwuANn1wduOSoH9W+1molqXnMPDA8MGMvXh8QvrbwHO6fOLG
         +DfYyocw0RLRkpC0mC3Ln2XpWnTAqhtROgZEWpsSs7Kp9BFzSO2PmuVQuZwqxVOOoOBp
         AH60in55fOPXtbIftcAs6byJbkWJPLmwg7PekZkDLsp94iBYZHrHTioI2LZadunca2qs
         TOCw3lIRuqFqmKhcoBJ8lkX3P5CgU9v4hd7FpwwfCuKKHF0wcGlx6H5m8VncHb5jd9BE
         Ikug==
X-Forwarded-Encrypted: i=1; AJvYcCXZPGZ95eeGLIHjfxbegtNJf1gsX7gkW1RaJX0nl0Ydg6mBOXaovI+ih03+igorE2jPPlfdDyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4gxfVI/iYZfYb/Y6mPz9WcOFfgrku0nMTHsYIVzvJMm/rkPb
	u7BFdX6+Ik0k+on8eWe11Ybrz4J0cmmYhwKYcd1hGh/ZMAgEpEhbrsD3lr7KFGHFBNEep7wW4lh
	iYcibmrXaPH2G5OhdZdEoiurHU2RUkmG3sw==
X-Gm-Gg: ASbGncssBbKALvywem8zyD/QdRxFighAAMnWHXudSYLnziurffzq5epHMQ39d9zRTKs
	4SKjZh5WBQH7SysUarWo2+gtgliFNzXmd2sh+OybZoE+5B+LP5+t1R4+EIKiH7ItK6jYgPRggQO
	YPcxWLnm0q5zOUAZ8SUNK/XAQBbfE0oTUZ0MUAWOw6bxTogpHUjf2KiGoTplvRc1Yi56gy6ilW2
	XakSknIX0gsvFPMCkJUPFfn4F1kSmRNXELK+KiYopX9dGJPOhKTfTIqtmc=
X-Google-Smtp-Source: AGHT+IE4cJ5tKilhXPYHarL/WwSTpAKLEQP79/c9FgSYQlPHxB3xnuqal+6HSN9axzRSzHDWtwI9mVnf08eSqkii1DU=
X-Received: by 2002:a05:690c:3684:b0:781:64f:2b3c with SMTP id
 00721157ae682-78648597eb0mr58171837b3.62.1761993143661; Sat, 01 Nov 2025
 03:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
 <20251027211540.dnjanhdbolt5asxi@skbuf> <CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
 <20251029181216.3f35f8ba@kernel.org>
In-Reply-To: <20251029181216.3f35f8ba@kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 1 Nov 2025 11:32:12 +0100
X-Gm-Features: AWmQ_bnrLkeoI865jzvdLW6HrNZUoAZzlwQYas0BUbzxlrfDK38hIgzRoi2f-jo
Message-ID: <CAOiHx==WU5BiaLBP=vcABV2vK0efVKKi-A0Qq0XUbfLNvqaBbA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Oct 2025 11:15:23 +0100 Jonas Gorski wrote:
> > > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > >
> > > Sorry for dropping the ball on v1. To reply to your reply there,
> > > https://lore.kernel.org/netdev/CAOiHx=3DmNnMJTnAN35D6=3DLPYVTQB+oEmed=
wqrkA6VRLRVi13Kjw@mail.gmail.com/
> > > I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
> > > which makes any consolidation work in stable trees very complicated
> > > (although still desirable in net-next).
> >
> > It's for some more obscure cases where we cannot use the Broadcom tag,
> > like a switch where the CPU port isn't a management port but a normal
> > port. I am not sure this really exists, but maybe Florian knows if
> > there are any (still used) boards where this applies.
> >
> > If not, I am more than happy to reject this path as -EINVAL instead of
> > the current TAG_NONE with untag_bridge_pvid =3D true.
>
> IIUC Vladimir is okay with the patch but I realized now that Florian
> is not even CCed here, and ack would be good. Adding him now. And we
> should probably add a MAINTAINERS entry for tag_brcm to avoid this in
> the future?

Oh, I didn't notice, thanks for adding him. And yes, I'll send out a
patch for that shortly.

Best regards,
Jonas

