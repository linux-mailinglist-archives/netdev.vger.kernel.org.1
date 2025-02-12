Return-Path: <netdev+bounces-165386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744DBA31D00
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF141611E3
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A181DA612;
	Wed, 12 Feb 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI5w8LhP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7841D517E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331808; cv=none; b=VNIk54fdr++cZW+MwNvWYjY3evdjwQaXMkCJtNcbQ5gmW4c5F/jMI34PeyWsRSS+SyUCtuGSSK4Y0glrHh1IdN5B+hfQDVL8Fkv5e1FU2ERGMeK+QufHwD2rKq+q+umdJ89Sc0WBpXO1oiB7PJvvL9WtjDg0+b5qJC33TOwLCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331808; c=relaxed/simple;
	bh=sEocHyf9c7fMaQzybkZ3+7TbK/RqGExikXkm8Fdt+js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0nO6m3U+YqJN3SR5G0UCy0g6p/JLgwyaDTppR1hfAVcfeewLUIzH9EDh1QxXSnYWSgdsemcH5xsy1jLEDYu00laigmoN42qMkcYwYRClFesZrV8jZAS4LQbU6+jPFb+MjnV5NZS7ewpArjuy4fpXsHVdxDd/8jmPkm2xc4yARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI5w8LhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F032C4CEDF;
	Wed, 12 Feb 2025 03:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739331807;
	bh=sEocHyf9c7fMaQzybkZ3+7TbK/RqGExikXkm8Fdt+js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gI5w8LhPS3MPJzklLMEcXQRdz27wFAfrmEzZ5NDtjPUUe5I2HjLTfUzmadTRCuzw4
	 EWKKnQuDcRq+upQq47vY6F6SxNkW8UrR+frw0UaFAtUVQubHHshofV/fPaYoyRlN28
	 1uvf/0GTl4tCwpvid1ewiTc8iwJK9piiUstCtbRi7Zo0GLq6GQ8Z/epulFzF0IIGKr
	 y3wbjw8FTFkp/2+2/SdVnPRZ8wgWOzycoiI7i6C4aOfU1SHy6vQNkg/SHqjF/ug3KF
	 cw0Tqty2VUFHfSgSmmi3avWeAMWC/zkEHKcqfdOHpU1VfyKbAnvYMuG0b7DChMppyL
	 x5pK1BR3FPNpA==
Date: Tue, 11 Feb 2025 19:43:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
Message-ID: <20250211194326.63ac6be7@kernel.org>
In-Reply-To: <CAL+tcoA3uqfu2=va_Giub7jxLzDLCnvYhB51Q2UQ2ECcE5R86w@mail.gmail.com>
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
	<CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
	<20250211184619.7d69c99d@kernel.org>
	<CAL+tcoA3uqfu2=va_Giub7jxLzDLCnvYhB51Q2UQ2ECcE5R86w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 11:20:16 +0800 Jason Xing wrote:
> On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Tue, 11 Feb 2025 18:37:22 -0800 Mina Almasry wrote: =20
> > > Isn't it the condition in page_pool_release_retry() that you want. to
> > > modify? That is the one that handles whether the worker keeps spinning
> > > no? =20
> >
> > +1
> >
> > A code comment may be useful BTW. =20
>=20
> I will add it in the next version. Yes, my intention is to avoid
> initializing the delayed work since we don't expect the worker in
> page_pool_release_retry() to try over and over again.

Initializing a work isn't much cost, is it?

Just to state the obvious the current patch will not catch the
situation when there is traffic outstanding (inflight is positive)
at the time of detach from the driver. But then the inflight goes
negative before the work / time kicks in.

