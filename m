Return-Path: <netdev+bounces-14978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F11744BCA
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 01:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C33280E48
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67661E561;
	Sat,  1 Jul 2023 23:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E152F32
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 23:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C9C433C8;
	Sat,  1 Jul 2023 23:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688254718;
	bh=Oox5uB6jRi8NGEItOzjlfFP4lIcX+zDxVCmxCvoeGjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7VS/Dl57bJX60vznQ72PYFgmsMrdLk2WdRSUXiAQDD6P2ghT/T1mvVimvb9TKFcB
	 e5dKpoEhRmVCuVmh7JKVzV2JuBN59id4tCS9S3UAFaSuSNenAItT4nynMDGpYfMD6C
	 tPTdlNABnUzvNiYdlVs8yVZt9rcc92IykE4e0VC3GeFrJLy3neYmnufpn2bzKTBu/y
	 Nf2ep7WFzeW7ITuRT/ol05Fk9h7AZuqTms20hP8oJkiEM95Jax/HZZV3HOA1FOawcg
	 KFwc3ol4GIPWrRHnHSIzlDnLxix7CjsEAtz05i6Rmm7gvT5Wp3CzPhBCqcQSbUFIQb
	 vE9Vl8NEOPceg==
Date: Sat, 1 Jul 2023 16:38:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [ANN] pw-bot now recognizes all MAINTAINTERS
Message-ID: <20230701163836.173b0c84@kernel.org>
In-Reply-To: <871qhreni5.fsf@toke.dk>
References: <20230630085838.3325f097@kernel.org>
	<871qhreni5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 01 Jul 2023 16:04:50 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > tl;dr pw-bot now cross references the files touched by a *series* with
> > MAINTAINERS and gives access to all patchwork states to people listed
> > as maintainers (email addrs must match!)
> >
> >
> > During the last merge window we introduced a new pw-bot which acts on
> > simple commands included in the emails to set the patchwork state
> > appropriately:
> >
> > https://lore.kernel.org/all/20230508092327.2619196f@kernel.org/
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#upd=
ating-patch-status
> >
> > This is useful in multiple ways, the two main ones are that (1) general
> > maintainers have to do less clicking in patchwork, and that (2) we have
> > a log of state changes, which should help answer the question "why=20
> > is my patch in state X":
> >
> > https://patchwork.hopto.org/pw-bot.html
> >
> > The bot acts automatically on emails from the kbuild bot. Author of=20
> > the series can also discard it from patchwork (but not bring it back).
> > Apart from that maintainers and select reviewers had access rights
> > to the commands. Now the bot has been extended to understand who the
> > maintainers are on series-by-series basis, by consulting MAINTAINERS.
> > Anyone who is listed as a maintainer of any files touched by the series
> > should be able to change the state of the series, both discarding it
> > (e.g. changes-requested) and bringing it back (new, under-review).
> >
> > The main caveat is that the command must be sent from the email listed
> > in MAINTAINERS. I've started hacking on aliasing emails but I don't
> > want to invest too much time unless it's actually a problem, so please
> > LMK if this limitation is stopping anyone from using the bot. =20
>=20
> Very cool! Follow-up question: are you expecting subsystem maintainers
> to make use of this, or can we continue to rely on your benevolent
> curation of patchwork states and only consider this an optional add-on? :)

On a scale of 1 to 10 where 1 is forbidden and 10 is required I'd give
it 7. I don't know of any such systems, so it's a bit of an experiment.
But if nobody is using it, it won't be an experiment.

The experience of the select reviewers using it so far has been
pretty flawless from my perspective (I mean - there were technical
glitches but no disagreements, misunderstandings or misuses).

There may be an experience gap from the reviewer perspective.=20
Reviewers traditionally don't use patchwork that much (AFAIU),
so adding actions to update patchwork state may not come naturally.
Maybe a better way of looking at it is - if you're reviewing a patch
that you don't want to be applied, just throw in the command, as if
you were telling the maintainer that you don't think the patch is ready?

> Also, this only applies to the netdevbpf patchwork instance, right?

The daemon reads a single lore archive and targets a single patchwork
instance. Ours is set up for netdev and netdevbpf, yes. But the code
isn't in any way netdev specific and consumes almost no resources..

