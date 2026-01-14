Return-Path: <netdev+bounces-249823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA4D1E9E3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B92DF300F710
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49239447C;
	Wed, 14 Jan 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJJuQd4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DE335542
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391746; cv=none; b=AtX6QmqBkzys/rhUG+We3N9Ve4gC2coW2Fsf6+P247xS/cWe68nncD/JrshgBVoz6McNtdvhfhBFt8NNo4hdvJYDDt8U9BWYNWoXN9dHcdiAzCUAZa/wnY6v3Sno/0On76CuRou2OchwMLke5BL8UwEdXRMgFjGWc1q4Ptgquzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391746; c=relaxed/simple;
	bh=RYWaRv10yDIeIHo2FrYnr3gnOtr55+eBsvXd5OKczjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL77P7ILLLHrAJh5AypjWkfX8RgYaMU1HZiAfTS/DAxizmHL6VTgaWYuxQqmAu0u7iA3U2YR9484qtMTUpAzzYg8jHcCv61bfBPU8fD7GsdOf2Zc1MItik92eIlwwiaMlLfMM0NrPYmJiguofJysGBuAKmZN/+tEaOeKvqnE2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJJuQd4g; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so13780682a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768391744; x=1768996544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69DLf9uq3Kof3aVtQbEyY5tbVzuTc5c56CQDu7fHFbM=;
        b=nJJuQd4gaGlvy/FLW0Z58hJUXC0Xe8DDaAU2INEcza3PgzXIE2V0xi8vtC3F3p0anR
         0H9a6DrjwLi73LuPcVXPL+JmIk+NK8cwQJRl/N/PBnEk+z3Pxa6RFwLlE1GBUI2KKPlV
         B4yVvyFK6lyXjaYY40+ZHw92ZoNAWg50dbH9eXY62yMJIAaqfgyNsJtdSJRctnNhGQlV
         rRCT0JoWWx+40fMul0jJ1XkStJpcYjOqq97l9d4JK+LtzGY9C0ZTOTxqD1r5hFrJ9TMT
         Qv1Lp/PWzC/VSxIvGISqvGr+RwCUROO7gFO8/tHrg5cMh1Q9yO/qE7sR+t83Ek2Rw48K
         rK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768391744; x=1768996544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69DLf9uq3Kof3aVtQbEyY5tbVzuTc5c56CQDu7fHFbM=;
        b=pu5ylDCpDlFsiSss4oKPnQsLBA1IvoTx6inqFgqOu7JUQMHTshGnmT+HJJY9wG4oM8
         GMXRfH3fcZ86JPUJHKN1MatfjePVNbL/x31IV+e5uVvjHKN4+cMY3ON8xElqqWMnXfHL
         CeeSZwYrEdLoFtRv0ND2tkMt76rq9wglVLisPi8A1H7LcMaa0b1L2FHdU0khiMarC3RE
         1CoVbARKAGLUxKBMRihHCX1y81Pbd97mfxH9HxCdgBLb/YXo84BSv/MhexrE/M5xuwsj
         67Vt1lskUAORngmPGei5FNnl9lCKtGyxvhfvTOOVAzZbH2+dsXQKtLIbWsDRj8XRvjNS
         y0Kg==
X-Gm-Message-State: AOJu0Yxo3Akqn9mDhO++PFPSXSFIycJ8qA/vrQKtC561sQ9QSjL39HvG
	LePPCkejMgoX4BRc9b3Hq3hNtC2KCGlnFo1Q3XbubJQ1nBEN5lzeGRraUGgeDAs9LYG0kmPu0UB
	KHICbxzIj62QypvM9oolj40DNo0T5nUMALKth
X-Gm-Gg: AY/fxX7ujV3en0MMAHCAi+lNwyjkQp1m5H/pY8F5yWffloXreR3aVzf0V6Xtn/s5wrK
	XxynF3I/qf86raFSpxGFaoQ0nuTq3utIPqyB3wF77ctLvUCR6tnXh1gi9xgrBlnnhkC5+FcwVi8
	Dh9TwEVb7wsY3AxyPgKNwKYpYLpmFp4bPH0gAYJbif3hydyCs40l0r6aWw+Jd16WC8yKDC5/E3f
	zRhET2EphTDBdDUyKpYITeUqqnw/Z3PahpqcqSVfhCExHK1AZ0I/9As+OqgXJLQjGBIacJdBMcT
	0E3WBkig
X-Received: by 2002:a05:6402:50c8:b0:64b:4a33:5455 with SMTP id
 4fb4d7f45d1cf-653ec446f0cmr1855413a12.16.1768391743487; Wed, 14 Jan 2026
 03:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105180712.46da1eb4@kernel.org> <CAMArcTWF12MQDVQw3dbJB==CMZ8Gd-4c-cu7PCV76EK3oVvFXw@mail.gmail.com>
In-Reply-To: <CAMArcTWF12MQDVQw3dbJB==CMZ8Gd-4c-cu7PCV76EK3oVvFXw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 14 Jan 2026 20:55:29 +0900
X-Gm-Features: AZwV_QgzgNfx-p0ssPDKbPHzSkbP7xH2kYaImrZCYbOZSvFe1zozzaHc6_ln6C0
Message-ID: <CAMArcTX97OGA7HXwUQk3MPdhrJo_LfNzi73XDZEKZyBbUEtwHA@mail.gmail.com>
Subject: Re: [TEST] amt.sh flaking
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:52=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> On Tue, Jan 6, 2026 at 11:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
>
> Hi Jakub,
> Thanks a lot for the report!
>
> > Hi Taehee!
> >
> > After migration to netdev foundation machines the amt.sh test has
> > gotten a bit more flaky:
> >
> > https://netdev.bots.linux.dev/contest.html?test=3Damt-sh
> >
> > In fact it's the second most flaky test we have after txtimestamp.sh.
> >
> > All the failures are on non-debug kernels, and look like this:
> >
> > TAP version 13
> > 1..1
> > # timeout set to 3600
> > # selftests: net: amt.sh
> > # 0.26 [+0.26] TEST: amt discovery                                     =
            [ OK ]
> > # 15.27 [+15.01] 2026/01/05 19:33:27 socat[4075] W exiting on signal 15
> > # 15.28 [+0.01] TEST: IPv4 amt multicast forwarding                    =
             [FAIL]
> > # 17.30 [+2.02] TEST: IPv6 amt multicast forwarding                    =
             [ OK ]
> > # 17.30 [+0.00] TEST: IPv4 amt traffic forwarding torture              =
 ..........  [ OK ]
> > # 19.48 [+2.18] TEST: IPv6 amt traffic forwarding torture              =
 ..........  [ OK ]
> > # 26.71 [+7.22] Some tests failed.
> > not ok 1 selftests: net: amt.sh # exit=3D1
> >
> > FWIW the new setup is based on Fedora 43 with:
> >

Hi Jakub, Sorry for the late reply.

The root cause is that the source sends packets before the connection
between the gateway and the relay is established. At that moment,
packets cannot reach the listener.
To fix this issue, the source needs to wait until the connection is
established. However, the current AMT module does not notify its
status to userspace. As a temporary workaround, I will send a patch
that adds a 5-second sleep just before =E2=80=9CIPv4 AMT multicast forwardi=
ng.=E2=80=9D
After that, I will work on adding status notifications to the AMT module
and to iproute2.

Thanks a lot!
Taehee Yoo

> > # cat /etc/systemd/network/99-default.link
> > [Match]
> > OriginalName=3D*
> >
> > [Link]
> > NamePolicy=3Dkeep kernel database onboard slot path
> > AlternativeNamesPolicy=3Ddatabase onboard slot path mac
> > MACAddressPolicy=3Dnone
>
> I will try to reproduce in my local machine then will try to fix this pro=
blem.
> Thanks a lot!
>
> Taehee Yoo

