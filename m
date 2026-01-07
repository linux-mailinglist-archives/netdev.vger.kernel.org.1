Return-Path: <netdev+bounces-247678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0FCFD480
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E578C3037686
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1D3090D5;
	Wed,  7 Jan 2026 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLWhlqTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD773090C4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782826; cv=none; b=AG9p/IM6yZVukS0vcOrnEp9ja+jxCE6Kh4a1Et/vq+fvYsUJ620Kn0YIAQ8rSS8yC48kAfzXWZLLT1Q5VmbC+BHDp3o8cdkPdnYoYVgPId79gmVFEYto0aXrCU4PdWsx/6+w/ASsIs4zR7NpO1W9QRDK+CzoqFBkvibuOksty/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782826; c=relaxed/simple;
	bh=ulbcZYWII5NCCc5uqMzcr2BuWXQe4RwOPeygY0K63t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuRdmv3CYemBJSLY8Q2ZfjKR1INqCIps4KWlZ1oh9xyPyRwlamzAOPqQAQoOfpTfGDSVfs1Mba8hBTRBZgAXE8j/8YzMAJjAq5bPrxjuO31Xwia4RKV0y7LYYFEtpn3POpZhaNcdZh8ndz2BJaDbja04hBVoPWi3+Ga8VaAUKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLWhlqTC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed7024c8c5so14822281cf.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767782823; x=1768387623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVukp/m5SwTlf5BMI6pVcRysU+a+pHXzRqnUAfBSEt8=;
        b=iLWhlqTCsWs+D6irIyIBwwJRsOGx35XhT2vJ5H6h71V5UTd83i3GdzSs3OisvqDkHu
         FRXqgZ4qE5IFu14Rg3dS4+wgaWUk9v6L8pIN5LEASjMMspleh+d6GOlJEIWFQ4hPL9Dt
         R4W/6l3MoRyHRtzCbUrinki/TcXdkuWpyn4B5Nw/6XSk/av53ysDnOVo8KxL0kSmV09v
         I6W1IPETssLRZTG/nNNZUgX+ScF4zMJIx/voBBFzFgdf1j3iPNIhH0z8PQ9relIRnwF8
         Qny9yVP2f3mkd9dZ/BJHSbqfPcn+zUZ5q3bYlh8cbXzUS3xrwBGrWuu89m71RfiPwJ68
         nu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782823; x=1768387623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVukp/m5SwTlf5BMI6pVcRysU+a+pHXzRqnUAfBSEt8=;
        b=JAPqlTFeVY9LMQTrV8UzMQPZOxcxkt/ZKRL/6+y+uIiiO6t09fOsvBmeF6ndc9xjyq
         kkxiv/uylIEbts1ld5srC32iO5+Hx9T3D8wF0XFfRzPrsBuD/Wakc0mtEPriAtB7bbKT
         xkEUsL6AR0AKA9SdqpF7X3Lm4+fFa995yhsocn+Gx3ZUPakay/ZCY2yp/h7/waOZVN1x
         tO1I3YcYcVeGIoBSSwMfRcTkFbwyWMkotqnQYFy65SpVkuub6JrcJdDA6WuaUMwwKKXr
         UYwsiKIFeoWJCMA10vmIeDsZFAPOyYRkIm3HDZa4K/1hpXHqWibIi++SC/WnRj6NlqV5
         Uy1w==
X-Forwarded-Encrypted: i=1; AJvYcCWso63L+VEJ0N46yOXN7LGtOWf8C+cumcd4ZvAhE45OqtFP/1vk85aCLFB7jQq4sgIMix/Rfvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2rFMAMqlcWog72bWyWNRmJkXmK7wIttEAQWEGjskvYyWE8qj
	Df2C5SOS1YXZn5aZx6kK64cE5E2IhRV31y0/eZWrH6CiNGwL0kEHXdY4D8Abc1Jst1aXM2QFQVR
	L5L1PC8/2JFJs5CpWdU4NL/6jbzY2lL/AKbMRTgHL
X-Gm-Gg: AY/fxX4mnpe0JD2WunOOdoP8HL6aKQowQ2xtGxDDhOxVydi+pkmPXFBiCVfL+W0tThN
	NjPVQCx5z9/IAyJMVyRyxhkI5iwiMVgCoMBKKcszYItFibEUDh1h6m7D6m6tk1KTBoYWdtrsJF8
	BnuGZ/QwJtq6ssDNCOaROJ+0EeI+mTNnq0ZJTc0IgM0a6JKZ+zR94ANDJOgIS9moMaGQiBtHaSu
	4YdyyFm+bRfVPEHoRsiveI8U4QV8MvV1fnOxREgMbsLv2bKKtxaObDoa8FL/fxJWBJcsg==
X-Google-Smtp-Source: AGHT+IG2mfw65eBJ7CpgRxpamHWOtViycHdcnjB0Smr82hPEi4EkSGQIsZmGaPcq4g1r3PCN7WjlqB74ebV28nx7dOs=
X-Received: by 2002:ac8:5902:0:b0:4eb:9df6:5d6f with SMTP id
 d75a77b69052e-4ffb4ab7c03mr28047401cf.74.1767782823165; Wed, 07 Jan 2026
 02:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107083219.3219130-1-edumazet@google.com> <40b42159-d7d7-44a4-9312-24cf87fd532b@blackwall.org>
 <64698c47-18a8-4dae-938c-ef8203031396@blackwall.org>
In-Reply-To: <64698c47-18a8-4dae-938c-ef8203031396@blackwall.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Jan 2026 11:46:51 +0100
X-Gm-Features: AQt7F2r0lMmpm61vSLCB6P24KNNChRNLZuqf_jO-z0Dc6-u8rg4D7YLKB9JPEBU
Message-ID: <CANn89iLaMpL1Kz=t13b0eGZ+m5dBxUpXx8oPKD1V-VwBAkzbJA@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: bridge: annotate data-races around fdb->{updated,used}
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:43=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 07/01/2026 11:00, Nikolay Aleksandrov wrote:
> > On 07/01/2026 10:32, Eric Dumazet wrote:
> >> fdb->updated and fdb->used are read and written locklessly.
> >>
> >> Add READ_ONCE()/WRITE_ONCE() annotations.
> >>
> >> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity
> >> notifications for any fdb entries")
> >> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> >> ---
> >> v2: annotate all problematic fdb->updated and fdb->used reads/writes.
> >> v1: https://lore.kernel.org/netdev/CANn89iL8-e_jphcg49eX=3DzdWrOeuA-
> >> AJDL0qhsTrApA4YnOFEg@mail.gmail.com/T/
> >> #mf99b76469697813939abe745f42ace3e201ef6f4
> >>
> >>   net/bridge/br_fdb.c | 28 ++++++++++++++++------------
> >>   1 file changed, 16 insertions(+), 12 deletions(-)
> >>
> >
> > +CC Ido
> >
> > Oh you took care of ->used as well, even better. Thanks!
> > Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> >
>
> Sorry, I forgot about br_input.c: br_handle_frame_finish()
> use of ->used:
> ...
>                  if (now !=3D dst->used)
>                          dst->used =3D now;
> ...
>
> That will need annotations as well.

No worries, I will add this in V3 tomorrow.

