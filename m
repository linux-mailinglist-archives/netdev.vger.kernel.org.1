Return-Path: <netdev+bounces-239710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6BC6BB97
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CD43129DEF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6A2DC77E;
	Tue, 18 Nov 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHF9yGhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1D13B284
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501529; cv=none; b=kj5L2WQAw8aDbDxoHOubq7tP6ukzyFUc11al/HsMLJzrt37AXsrYHIw3KR5bMhTJCayNi4qy3cK4VfQC3V0JL+KR84Ex696vkpG/rr3/N/hP05ImmJ8cvZJ8FrxbDzISMoXD5Ross5tK+R0tyvoDYon074GPE8P7b7EmOSPa3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501529; c=relaxed/simple;
	bh=4d0Sv5r4zAn4o3n6jzfVF9Wi/u39D8DoZpWVTdLdpOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOpgsfitsLcH/Dqyr004ErF2vhVOXIjXuCvggOPcmvoCZEiBRZtgWz1OMsijxs5DpGguql1flbvDd4j9aZN0hoZpQdUl/DnuraRvMI4Uvrhk7QyUlnWdS+LWrcWCDB/tBF93ZR4/YXXd5vbdPcIKn8JPHoMHNw2ByjnxA0nCJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHF9yGhE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640f88b8613so5320582d50.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763501525; x=1764106325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCrwj5M08WsDVoCum4fbcJzY7jHioRyvfP02WEe77Tg=;
        b=KHF9yGhE0IyGhZ3kMXPQXZf4RdZscRpxuwX0JzXNgYIkBzi0JWrKRSVQLx8VuJuphk
         +YzkQ5oQvX5v0MfMCtdY+CVQpXvGLVnXwTwdM9jQ+4HIuupa6uWvUgISppo7bQEsnWh5
         NTHomcfp1LuwFtph4PZ/K2nKQq452MHxcIUx+pRUAbutFzcEddjHHGLmt994ydH74GeE
         hDvw9GnVXrRtONYGLgvhuSv0F2NtqXWxzs8l0S4LYev63aFlDkJoi1fxKT17Hg9FfTd9
         /oPeJZH7UG0rku4miZk6rLLg1JYLhe8OFeKcbzAP1G5R/dJpkOhub0lDzQveSPMNVo2h
         NgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763501525; x=1764106325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCrwj5M08WsDVoCum4fbcJzY7jHioRyvfP02WEe77Tg=;
        b=jo93JrbLvYmo/zPAsqgrItX5d0Nnu8dW7rj2Cv5YEFpMTYl98RzmYclYg/rjkElVhB
         7TFVrolyT1QWePmL5MuV033MmTl+TBsG+mGOsZa13SwEv7s0umOlIyoeSlwvg8YH5TyV
         SNz3z+VrAa6z5jAt9+YGFBvR/DwIbQKKUWOqI9KHB+WmfPD9PBFgZfm6wTq8ZNMq4WNm
         JyA+qweSCiB8WdWSbqbt6rmTlgoA8hHxdsUYvDQicoq1IYO0zOV8UjBnV8r76Yo4DIHR
         e/J8fzE7GO8zvmkA2WrL/aJ1+HppRVYZfOwjhN9+JoO09EUgyIdAi/2qmJDRTy7lFi+s
         p3EA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUZS2bKyL/1ggrc6Y/T4u62k2s5Vu++ZLkiuo47827Q0FRs0rzH1i2wk14G552tHYR6rlngY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyjbqqtQoNM/UXBOLd7bvd7w6K71K+YuiK5rf4amLSxQrsMa8
	jviMHVBCY7hIGgGwPLzGBcWul5e9i4tZl1p3kBJp+o6HQ7j8dII8n9c7VIs1FEcAW5RmcjfR7Wz
	0Ian95MSUnxnZ1A0GInF+Qg/VO3TMBKE=
X-Gm-Gg: ASbGncv4wrg/pTc2ghf+9S3amcP6RqkwiNyDsyKL1SaVLbqO1Q95gnbh5KAGWYwFgza
	3jSrowITAnhrL691UtdkZvAMG7s9ZBchn6SIRVz5TPMUI0Dq341/bgYLDDfUc6wyTZYzWH5JQX7
	HK79uDOyiSKGmtxEkS3lKw997z+SJKibKjyIowB+IvnoJhHRqsFUiux+GraSUw4UF8f0PK2ANqg
	pasMb9/NwS3dzF7CVFhjUwYWRr3bw+gadVq3XLAS3Nrk3IfgBvM8VJx8l012hzYBeEp4oVoyU4H
	6Ps0Bi3SYVlOPk4wVEfeuXJLc3YpDaHUtDIn
X-Google-Smtp-Source: AGHT+IF0HLI74QVSEAUVqsYxY+D+1wr41Ro/ELb9ISpMGu+Y8Mvbq3av4AyCs9kqTjpDfdDEQcp/6RolwDramslAscE=
X-Received: by 2002:a05:690e:4308:b0:640:b8ef:b77b with SMTP id
 956f58d0204a3-641e770d633mr10616887d50.66.1763501525337; Tue, 18 Nov 2025
 13:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch> <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch> <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com>
In-Reply-To: <aRzVApYF_8loj8Uo@google.com>
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Tue, 18 Nov 2025 22:31:54 +0100
X-Gm-Features: AWmQ_bnATrXwirGE7ScLfgF30a67HMU1fyk6pxbO0wKHYrpcG__yelELfAklJcE
Message-ID: <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:20=E2=80=AFPM Fabio Baltieri <fabio.baltieri@gmai=
l.com> wrote:
>
> On Tue, Nov 18, 2025 at 09:02:22PM +0100, Heiner Kallweit wrote:
> > A contact in Realtek confirmed that only 1G and 10G speeds are supporte=
d.
> > He wasn't sure whether copper SFP modules are supported, and will check
> > internally.
> >
> > I'll try to strip down the patch as far as possible, likely supporting =
10G
> > only in the beginning (as 1G requires some more vendor magic to configu=
re).
> > I assume the typical user won't spend money on a 10G card to use it wit=
h a
> > 1G fiber module.
> > Reducing complexity of the patch should make the decision easier to acc=
ept it.
> >
> > I don't have hw with RTL8127ATF, so I would give the patch to Fabio for=
 testing.
>
> Hey thanks for following up on this, cc'ing Michael as well, as it turns
> out he was also working on upstream support for this at the same time as
> me, maybe he can help testing in more scenarios.
>
> I did test 1G support between two RTL8127ATF cards and it works fine,
> have not tried between that a 1G fiber only card (don't own any), happy
> to drop it if you think it may not work but hopefully it can be tested
> and kept, it was in the out of tree driver after all, I'd hope the
> vendor did some interoperability test with that code.
>
> Cheers,
> Fabio

One thing the out-of-tree driver does, which your patch doesn't do, is
disabling eee when in fiber mode. I'd suggest something like this:
@@ -845,7 +860,8 @@ static bool rtl_supports_eee(struct rtl8169_private *tp=
)
 {
        return tp->mac_version >=3D RTL_GIGA_MAC_VER_34 &&
               tp->mac_version !=3D RTL_GIGA_MAC_VER_37 &&
-              tp->mac_version !=3D RTL_GIGA_MAC_VER_39;
+              tp->mac_version !=3D RTL_GIGA_MAC_VER_39 &&
+              !tp->fiber_enabled;
 }

Michael

