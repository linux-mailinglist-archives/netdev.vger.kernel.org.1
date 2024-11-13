Return-Path: <netdev+bounces-144277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF049C66F6
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C4F1F25717
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721A64A8F;
	Wed, 13 Nov 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7NKHiie"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104318654
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463035; cv=none; b=Y4vRU3x4zL0NQFSAUwxdP1QrRano80lddAQblZrWAyLZBTQZJCAjUXo2BHWNeyWmNyhzb6WFF8g4mjZAwaWm3DTmel3F4aADTo17uw9z3UiTu/LqcvyfR81VFNL2LcYlBKIctVSgz61bJ2VhHmBVCc/8Jg0+GPJ/TECepxDF20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463035; c=relaxed/simple;
	bh=tcnNnYsxhfUVq4LTXJ5PWxllXHvN/+TRipTRnULTAuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjyF+RJJUVEeuQbgswH204IKCWZaPzKVgrS5aS9cXiz1Wi+ozHy3c4w1VXa7zWknAcwEn32vGztudw0RzXWJ34SuSSwYGT8r+raPVZ1RJfamurNgZinNh1oA/TsDflDJg+n9mIbiOpHhd5wHaJjjkVEjWa2wng7ba/96N1T7C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7NKHiie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE3C4CECD;
	Wed, 13 Nov 2024 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731463034;
	bh=tcnNnYsxhfUVq4LTXJ5PWxllXHvN/+TRipTRnULTAuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A7NKHiieoJGVBWTNuvjHfiO6A7lVcKHYbejlNvG/51Q2uaXPXP/+NcQTkweXCopm4
	 nVTpSkAX/XRrzUdPza+1C5JLvd+yujWN+xcKXdETXA2CAN1vn+ty7pyUEAMO11kxKV
	 CxMpjs68sm7Ld1SlZz7unv8q6dybnBDMG80F1cLtVP92oUAD4hPAk/ilHe1QNuqdHw
	 IsVhsj0r+O9cGsoKTGtmJ1cPeT6EYoPUNhHMVQdRg8xMe1r3zFQ90UGnjszFFzs6Se
	 mVeMhKuH2sFKfekHfbIXrfXpfVTIhyJkXKoyTlq6DMTQHeLAJEfp/aKfjIBMYbPpGV
	 EPab2zagkP1wg==
Date: Tue, 12 Nov 2024 17:57:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, alexandre.ferrieux@orange.com, Linux Kernel Network
 Developers <netdev@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic
 failure to free IDR entries for hnodes.
Message-ID: <20241112175713.6542a5cf@kernel.org>
In-Reply-To: <CAM0EoMkQUqpkGJADfYUupp5zP7vZdd7=4MVo5TTJbWqEYDkq7g@mail.gmail.com>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
	<CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
	<20241111102632.74573faa@kernel.org>
	<CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
	<20241112071822.1a6f3c9a@kernel.org>
	<CAM0EoMkQUqpkGJADfYUupp5zP7vZdd7=4MVo5TTJbWqEYDkq7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Nov 2024 12:07:10 -0500 Jamal Hadi Salim wrote:
> On Tue, Nov 12, 2024 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > I'm used to merging the fix with the selftest, two minor reasons pro:
> >  - less burden on submitter
> >  - backporters can see and use the test to validate, immediately
> > con:
> >  - higher risk of conflicts, but that's my problem (we really need to
> >    alpha-sort the makefiles, sigh) =20
>=20
> Sounds sensible to me - would help to burn it into scripture.

How does this sound?

  Co-posting selftests
  --------------------

  Selftests should be part of the same series as the code changes.
  Specifically for fixes both code change and related test should go into
  the same tree (the tests may lack a Fixes tag, which is expected).
  Mixing code changes and test changes in a single commit is discouraged.

