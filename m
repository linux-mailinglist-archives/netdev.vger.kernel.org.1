Return-Path: <netdev+bounces-209118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B5B0E619
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC393541017
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93111286890;
	Tue, 22 Jul 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27zex7WY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D1286412
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222240; cv=none; b=A3JFJ/rnp/oxGTpGhpakPJKDYj5wNDi2MkjCr3fdgzfjKUj0rBQ2UknU5OTwiJA3s0ksuFgTvL0NLJmULTx6o40Nq86LcL9YVLAvExZaeBZqtqCpHSNBpHBX98uOYdz4x1o2IE6KOZWe+z0Ezr9oI2AxUjBFeEI2uttZx9QY0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222240; c=relaxed/simple;
	bh=4GHGRtwRBLmcMIRdERctVgE5I68OlYIasVtsJkUN8UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR2sQw2DFYZHLMsCSYpJpOXrqL8gAqDR7Y82y4mb2C9LIaa0U/vYuLurkCKFj6GGguRsKp0BT1RSqT/1k6fon2hZ6D5T3oJcmt9JSevGSN2MOTNXnfKI5rqDxkIsUn5/kE3yg/jWDC5zFV7zFJ+T2/z4dNfAD/kBgp+8Av2qbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27zex7WY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af51596da56so4333049a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753222238; x=1753827038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMu39Qawe4doNbq7gca8Aps/3YUEzEFiqgdkwW68ctc=;
        b=27zex7WYoQ5ZetYeZYiZTe8IpGUluE/SdVBIvH0P9yB2rM44fMREC7WZNoVRRoy51o
         ozyqrJ5n14pqz5X2NUUU9yGK51dV0gfU6RjBpqwo0riBBn4OMI3l7lNuPbTui/1DQhS0
         tJSSVh19MYuY9R5as15f9s8gCxg5tQhXIjv/gjvAE12n7+F/I4vkGeQIwywUQeKoghhP
         ltu04geDeRMIFpogkOqQ4GBxcFM9KFDjwH1Mh2u/pTYbIIJXDk9cnMry+dkxqQusGrRx
         7D1i0YKlhpSvJMbkkgiO3J+/ZJYrkBK8Mx5KdZMkKaymYE8yRw1utlFNRXaNqo/Sq2Oe
         N0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222238; x=1753827038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMu39Qawe4doNbq7gca8Aps/3YUEzEFiqgdkwW68ctc=;
        b=wEVQEKruyz8ynxMnBtW1C+mPz9vLh53HevHLIm0muTbuhVvUmglFiTBpuQNNewvpDN
         N989q76IuIBL+QRIgIDhYP8yZ53OgZzh9wXxvPPMrUnVyQYmIirRlHLGm10rSD+Fx7oC
         Pz2Pbbmqb4rwV/wve5Lhzyp7Z1HvfJw0lKtUPs5enBTsx/JsZLDXt5DNCMLRf8Nx7GXa
         LxGpjJyhSg0zQE/SrJyn4WgSb8DxXv+xtfz2frdOazIXeThZh6eTWhoAsoHmLv16Nowa
         rNFMWZ07dlMpAV2/Orjk86sTk1UUZM3+cQzyhmN/LejzMxZnjPgm5lVVcKN4TaBnOaVg
         3LIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmciH3r8yuO3oYbn9Xw4yqn4YB1ruQfmQB768AH4qD4jl7B7URDVZVEzNRbBUb+zIm/P7oGxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iFaml1N5tjMNL+cx1X51QI133U35XL3WrLBVTpHsxKNdhTd8
	EEitZeBb4TPPiP6I3D0aeaeHkbb6JHxQp8PGllQ/0EJ9TVhK36mpjKgzvF6v/pdkXydxm6J3l5l
	i6TVGQ+tGXL0BE/sX4RyJcqgIFVkbFCe2sW+8YFaA
X-Gm-Gg: ASbGncvsC+Re9yIbPv8Xw5+zU3bRKq/5fg1SPgBuiTtglsC4wlq79SFmx23SVneP/Mv
	7vVqV6gbH4HYUI35vJ0HJ/FSjukK6PQta5R3pIHH8j+gLp+Sc5EeFYmC5HgI0TXI9noBnzrABKR
	Ok/0a8GfEuIQJ7z9Ubn1wdR3SKZl8fW89HeBnSlewRBMVnhwMHk/IndUdIK8o6hBRw+fAbHOMvd
	q3Hy+mX4oyrctwoSuwR2BDRwzeUOp8y8xJuXA==
X-Google-Smtp-Source: AGHT+IEXpajWjFbFbIokxEFjTJObVRys/LIQ9BsDVyGOdn0Bwr9QNYm/RJoa2DfSiuRm6/HUlN8Vmr3WAOUBQQKDqI8=
X-Received: by 2002:a17:90b:4b4c:b0:311:b3e7:fb31 with SMTP id
 98e67ed59e1d1-31e506890efmr1392388a91.0.1753222238076; Tue, 22 Jul 2025
 15:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com> <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
In-Reply-To: <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 15:10:26 -0700
X-Gm-Features: Ac12FXzy1MKKZWG2l2iWJgUbEgy1nu_oczRIhl7Ym95gxwm3W6lz1uXCfPsEMTU
Message-ID: <CAAVpQUBcovfWW7K2P_6kZoQn-ZrdAJDN_yCm5unHkH6FLpS_VA@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:11=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jul 22, 2025 at 12:58:17PM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 12:05=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Jul 22, 2025 at 11:27:39AM -0700, Kuniyuki Iwashima wrote:
> > > > On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > > > On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutn=C3=BD wrot=
e:
> > > > > > Hello Daniel.
> > > > > >
> > > > > > On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel=
.sedlak@cdn77.com> wrote:
> > > > > > >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > > > > > >
> > > > > > > The output value is an integer matching the internal semantic=
s of the
> > > > > > > struct mem_cgroup for socket_pressure. It is a periodic re-ar=
m clock,
> > > > > > > representing the end of the said socket memory pressure, and =
once the
> > > > > > > clock is re-armed it is set to jiffies + HZ.
> > > > > >
> > > > > > I don't find it ideal to expose this value in its raw form that=
 is
> > > > > > rather an implementation detail.
> > > > > >
> > > > > > IIUC, the information is possibly valid only during one jiffy i=
nterval.
> > > > > > How would be the userspace consuming this?
> > > > > >
> > > > > > I'd consider exposing this as a cummulative counter in memory.s=
tat for
> > > > > > simplicity (or possibly cummulative time spent in the pressure
> > > > > > condition).
> > > > > >
> > > > > > Shakeel, how useful is this vmpressure per-cgroup tracking nowa=
days? I
> > > > > > thought it's kind of legacy.
> > > > >
> > > > >
> > > > > Yes vmpressure is legacy and we should not expose raw underlying =
number
> > > > > to the userspace. How about just 0 or 1 and use
> > > > > mem_cgroup_under_socket_pressure() underlying? In future if we ch=
ange
> > > > > the underlying implementation, the output of this interface shoul=
d be
> > > > > consistent.
> > > >
> > > > But this is available only for 1 second, and it will not be useful
> > > > except for live debugging ?
> > >
> > > 1 second is the current implementation and it can be more if the memc=
g
> > > remains in memory pressure. Regarding usefullness I think the periodi=
c
> > > stat collectors (like cadvisor or Google's internal borglet+rumbo) wo=
uld
> > > be interested in scraping this interface.
> >
> > I think the cumulative counter suggested above is better at least.
>
> It is tied to the underlying implementation. If we decide to use, for
> example, PSI in future, what should this interface show?

Sorry, I'm not yet familiar with PSI so can't say what would be
especially useful.

