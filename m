Return-Path: <netdev+bounces-15575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2C174892B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F451C20B7A
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E7125DF;
	Wed,  5 Jul 2023 16:26:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927E346AB
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 16:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24788C433C7;
	Wed,  5 Jul 2023 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688574360;
	bh=y6pPhcs17DpuMEEaw5aoZ0cxtLYlNI6VVnK7BjYFSG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7Q7ph3U+UyQr61khI/pXOgMk3GNjsuddjzWWISYBen0aedjlUuRG03cJ7OS1a0mi
	 q0UaFhuTx/yMU/PyFZ704mkcq5RT0+GHnBvK4GhFQGdW4ZZRlileKUVL5jYf2dtAiJ
	 QXcxZ1tVAU/KPCCGR8q8Nu3YVAUMUsiA5offwjlW9bLkaV5VnEM+ld9qF3T7XGL79B
	 zERl1w1blpHwtE/oPduaoQVZ1WwMEKFGBxRE5/0RXggqlPOZ67mLCfTOtT4sWBCNLg
	 ZXlkJ/KbPkDYulFwm1J96bBuWtno1zvNn5KxcYgdrOukwdzeoGkVKohXXf8H6xRmVE
	 caTA1GuE+gIGg==
Date: Wed, 5 Jul 2023 09:25:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joachim =?UTF-8?B?RsO2cnN0ZXI=?=
 <joachim.foerster@missinglinkelectronics.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tariq
 Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH] net: Fix special case of empty range in
 find_next_netdev_feature()
Message-ID: <20230705092559.4b60f7b1@kernel.org>
In-Reply-To: <ed966750-482e-50e3-7c27-028e135d3208@missinglinkelectronics.com>
References: <20230623142616.144923-1-joachim.foerster@missinglinkelectronics.com>
	<20230626141739.54d78c7e@kernel.org>
	<ed966750-482e-50e3-7c27-028e135d3208@missinglinkelectronics.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Jul 2023 15:40:29 +0200 Joachim F=C3=B6rster wrote:
> On 6/26/23 23:17, Jakub Kicinski wrote:
> > On Fri, 23 Jun 2023 16:26:16 +0200 Joachim Foerster wrote: =20
> >> Fixes: 85db6352fc8a ("net: Fix features skip in for_each_netdev_featur=
e()")
> >> Cc: stable@vger.kernel.org =20
> > Nothing passes @feature with bit 0 set upstream, tho, right?
> > Fix looks fine, but it doesn't need the fixes tag and CC stable,
> > since its theoretical/forward looking. =20
> We are triggering this issue by using the inline function=20
> for_each_netdev_feature() from the kernel header files in a custom=20
> module running on a stable kernel involving NETIF_F_SG, which happens to=
=20
> be bit 0. So my argument is that the function is part of the public API.=
=20
> Or is this actually not supposed to be treated like it is public API?=20
> Does this statement change the assessment in terms of tagging with CC=20
> stable?

I believe so, if an upstream user can't hit the problem its not
a bug for upstream. I'm not familiar with the concept of public=20
API, but I'm afraid it may be a bit of a pandora's box. We have
Documentation/process/stable-api-nonsense.rst, tho, I'm not sure=20
it applies to this case.

> Regarding the Fixes tag, I think, I made a mistake, since the previous=20
> commit 3b89ea9c5902 ("net: Fix for_each_netdev_feature on Big endian")=20
> on find_next_netdev_feature() already causes the issue by not=20
> considering the special case of bit 0. So I will repost with fixes tag=20
> updated ...

For networking stable =3D=3D fixes more or less, so if it's not a bug
fix it should not have a Fixes tag either. But we're not maintaining
stable ourselves, we primarily care about describing the situation
and tagging appropriately in the commit message. You can still try
to convince Greg KH to pull it into stable afterwards. Who knows,=20
maybe Sasha's AI will even suck it in automatically..

> > Please repost explaining how we can hit this problem upstream
> > or with the Fixes/CC stable replaced by a sentence stating that
> > the problem can't currently be triggered. =20

