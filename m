Return-Path: <netdev+bounces-162746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4FA27D03
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CB916658E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75021A433;
	Tue,  4 Feb 2025 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BydzdPmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825D219A8E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738703190; cv=none; b=ewETprAjvPKBZW6BQx+S8Y7MUrZgqJ1IXizgPiP0PcYVVRF2MM3/JJTwO43mL1HfZWN5wnLeOe5B9+EMHBovigaT5+4ZDkQbNLbJ7RRG3M7MjSla0tuGHDiMyLuEyxeyN+tcnmLsTWs7WjUsAEC9z5sSz03fNmFGhhossV3DJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738703190; c=relaxed/simple;
	bh=v2VMy/mZSzVsFKXSsZuubqeCO4lUt3dAhrwJRPjUpXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1aN7uiP8pfzn5kTYpjr1aKUQTqWWO6ucjFPSalDzvdpguSwqeCO1W4JosWrWU9TIfIx+yd7Ret6Mw22tgPyIndUcZi2dB0U0mNsZjWqxk87E20y2mk5qWGDnoTTVQDIBhr4I8Q06WqDUsk29agU91cQaIs/abFBc9uN1qkhfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BydzdPmn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso1655293a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738703187; x=1739307987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2VMy/mZSzVsFKXSsZuubqeCO4lUt3dAhrwJRPjUpXM=;
        b=BydzdPmnV9BbJ9B9Jvl31hbFH/TiXwRZrf12Evt9431E7FIKVYAI/TLIXMsgq3EPE1
         HLw/+IAhyXMAYkgmJp9k++sKtGgiGurPzedQglrCSjJn+21W4yBR05vVBBOJdo3+a+KM
         tvx3fzf/++30sWWDpa363pd4KwLyp9TseNzQq/NdBY87czLA2VCz1SB/p6n4qEFx/qb6
         Rk3D9au9h4ZgiOOqZrdzSxGxIrOhuEyYbzwlaCr16Em/6Scp11iA5EEloTwT8TPg3kE/
         1ktmEUwF9n9OHP/iBc/3PHdUXH7iO7ralpeqyAB8xEOzdlH3xAQN3Tu1/DSi/2DlKT4l
         5XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738703187; x=1739307987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2VMy/mZSzVsFKXSsZuubqeCO4lUt3dAhrwJRPjUpXM=;
        b=S2rhgcowsY8RzzeRKDDLDhMCXqZxHYEISzjkSCkqg4ur9J2W4zLyW2+lJobytYAZi2
         nPnhAdHQnR0NpaoAwzr2B0PNRQbSpoMb7W4kgsVdscehXWjchEqC/QzRUQAbalIAMB80
         OBe6cZ/8m156lpdbA4SXwFXehHZmHKxXJGv+G8kDvsoiMYruDideLJIq/q4hK6rSk8a8
         IojzT1of2MPhavw2XpUd7rXKCEFe62jDxT22oLEzG8u0xkz5ocrgS8lGbMn+uKyHUvOO
         MvCpy3r9f0eZZxs5WGMHPaw/YyfKUuz7Uzx00gk/lM2eRiIePkUBsIfXb8bU2vmja+an
         qcyA==
X-Forwarded-Encrypted: i=1; AJvYcCWiACToE3KiCHZLGcLiERliPUsHO0yWoERWcY3AZmXf4tS7ZE1e8E/J/GTI4xt2oexDCV/Yqk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCpdanvgjN1aN2JAKwqqgZIN1c1vKz6z8vmeMNVW7DkRehHMl
	AnMCVp/bJ5Ju1mpA5mCZiPSaaIpUMnnAFTrxPlPMoEROKITFt2AaQ8Czje77sfAhwsx70yXsuLh
	+g9TLt9bMlFWYgBXGpFNpnOnrj9Zng44yiHpVTm8XB9wKMlX+Rg==
X-Gm-Gg: ASbGncv7eu2YT2YvZ2R1WtN/xlpCwpgBX3un/s09xHHgQGmd6TCF4iApQMdmczL6jh7
	4iYbKGDX5FjUSPPA6y1wC8QEkJ3mQ403RlKd/lI/yt+rJM+J0aCiee25Bpcj3qGj1j9GsCF8=
X-Google-Smtp-Source: AGHT+IEtEZKGE1oy0fcpkv2AoGMFCaGgcR18DmbgunCWXKy4NrQYvAa0oQ7lmY0F9kj5vkiIWyvaL+6FgzWRCb837Ws=
X-Received: by 2002:a05:6402:350c:b0:5dc:100c:1569 with SMTP id
 4fb4d7f45d1cf-5dcdb71bb52mr618193a12.13.1738703186554; Tue, 04 Feb 2025
 13:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com> <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org> <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org>
In-Reply-To: <20250204130025.33682a8d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 22:06:15 +0100
X-Gm-Features: AWEUYZk4qe_FfPMCq9gukGi8MnE0qNu_kvmk9tAtTwPpeFmc3PiBgaIn7zHubLk
Message-ID: <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 4 Feb 2025 21:10:59 +0100 Eric Dumazet wrote:
> > > Test output:
> > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/61-l2tp=
-sh/
> > > Decoded:
> > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/vm-cras=
h-thr2-0
> >
> > Oh well. So many bugs.
>
> TBH I'm slightly confused by this, and the previous warnings.
>
> The previous one was from a timer callback.
>
> This one is with BH disabled.
>
> I thought BH implies RCU protection. We certainly depend on that
> in NAPI for XDP. And threaded NAPI does the exact same thing as
> xfrm_trans_reinject(), a bare local_bh_disable().
>
> RCU folks, did something change or is just holes in my brain again?

Nope, BH does not imply rcu_read_lock()

