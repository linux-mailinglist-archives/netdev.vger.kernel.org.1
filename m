Return-Path: <netdev+bounces-147336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842FA9D92C0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AA216468E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF241940B0;
	Tue, 26 Nov 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDYXR+/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271713BAE3;
	Tue, 26 Nov 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607324; cv=none; b=quZBzLjEypKD3ZDudr4Yeuf9BeGCudsQmiyi4r2IA1YxZVhxx7rwh4cZe1nvfHBF3UEHqZve1fNt4aI9aFPix1VUojLKgLtfxXuY3Ha9lVKRfVmojfGSjAlq/h8HlrA0cGLOmBF5q0MZQan/7WgKGm1qSCmHkCdyVmhT7QiXMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607324; c=relaxed/simple;
	bh=skmMUS91D2aQ8NSi9NHlSuX2wfVxjq3SHr5gsfheWmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClY6UN9LHqytyB/N+HUfWK6/3igXWkhbBQIdpDJj/QadglBGViGHzCmi7uG7gMbyZ73uIpPo0wLpY1laXBn8URgifufnLGwLjkc7mKeNRiFL4aRymrLyLwKgMXqeClWuiWNabahrBj+pS95qmifitlZ05hIUSFT+5rZ65Pxgn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDYXR+/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB44C4CECF;
	Tue, 26 Nov 2024 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732607323;
	bh=skmMUS91D2aQ8NSi9NHlSuX2wfVxjq3SHr5gsfheWmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDYXR+/FosSwh8ACaruvyOGjFiJTZPSqtoQ4jGtgUzfh13D/1OeO20rDIspBuPKye
	 RAZVv1piGmYbhSyr+7fL8asnb/PEcmHCORRufcXSkw+g7G3GN3Rf6gXgGxcQMlVro9
	 6BJjVs+1slaBPCkX8CLN7qVQa+s2Q1Xl0JzPuaEZd6h6vq9eIGH0b7+/madblpTp7f
	 oh7aVy270/oSl1UnhbVcxdrjEIeoXpiejPj1a6u8rSCfUsrTBo1HP2gwQzc9szVT9L
	 dmd/t8ohBnRDcslkr+3lH2qOZsQkJSbXS85Spwco56r/bi+20zS1ZCa36UpWKmr4px
	 sJwqOxzIv9a1Q==
From: Ilia Lin <ilia.lin@kernel.org>
To: leon@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	ilia.lin@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com
Subject: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Date: Tue, 26 Nov 2024 09:48:37 +0200
Message-Id: <20241126074837.631786-1-ilia.lin@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125194340.GI160612@unreal>
References: <20241125194340.GI160612@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 25, 2024 at 9:43 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Nov 25, 2024 at 11:26:14AM +0200, Ilia Lin wrote:
> > On Sun, Nov 24, 2024 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > > > In packet offload mode the raw packets will be sent to the NiC,
> > > > and will not return to the Network Stack. In event of crossing
> > > > the MTU size after the encapsulation, the NiC HW may not be
> > > > able to fragment the final packet.
> > >
> > > Yes, HW doesn't know how to handle these packets.
> > >
> > > > Adding mandatory pre-encapsulation fragmentation for both
> > > > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > > > on the state.
> > >
> > > I was under impression is that xfrm_dev_offload_ok() is responsible to
> > > prevent fragmentation.
> > > https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410
> >
> > With my change we can both support inner fragmentation or prevent it,
> > depending on the network device driver implementation.
>
> The thing is that fragmentation isn't desirable thing. Why didn't PMTU
> take into account headers so we can rely on existing code and do not add
> extra logic for packet offload?

I agree that PMTU is a preferred option, but the packets may be routed from
a host behind the VPN, which is unaware that it transmits into an IPsec tunnel,
and therefore will not count on the extra headers.

>
> Thanks
>
> >
> > >
> > > Thanks

