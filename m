Return-Path: <netdev+bounces-20785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF27A760F79
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8028168B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B0156F1;
	Tue, 25 Jul 2023 09:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9314A91
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E707C433C8;
	Tue, 25 Jul 2023 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690277910;
	bh=ctHfhoRdylUzYz2QPWQuPgSyO/aXFdULfe/vVVsiePk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbNu7QEIfH6iAx/02yPCAFTBXbhvxiXFtM2E8QBtdEkdSncKPuC2RpMdVEt8FGtD0
	 gkQQdbikxn2gU73QR584BJuGPjk/wSfODzYhKKWQQUTjIaj5QWB59f8uqURxk4VCgJ
	 1rS5GPn7rQIsdMRXUXdNElFg52eDoJtmsHLzF95ItiLATTbyVOmHDJLiMbMa5Eu38P
	 rn/smGIr0LeyvjnLItieNhtfw+oPuAqm4zYJ8/mKotfzSdfHRR63FSpNatDAZ7hp7N
	 idUZkzkpF9PiR47vUenyBIDx6bpVM28valnultNU5skseNgV2C+BGBX7yDwlQvok+W
	 5kvhWQ9gxWGMQ==
Date: Tue, 25 Jul 2023 12:38:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230725093826.GO11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
 <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
 <20230725051917.GH11388@unreal>
 <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>

On Tue, Jul 25, 2023 at 12:11:06PM +0300, Ilia Lin wrote:
> On Tue, Jul 25, 2023 at 8:19 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> > > Hi Leon,
> >
> > You was already asked do not top-post.
> > https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
> > Please stop it.
> >
> > >
> > > This is exactly like I described:
> > > * xfrm.h is included from the net/core/sock.c unconditionally.
> > > * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> > > being compiled.
> > > * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm member.
> > > * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to compile.
> >
> > I asked two questions. First one was "How did you set XFRM_OFFLOAD
> > without XFRM?".
> >
> > Thanks
> >
> In driver Kconfig: "select XFRM_OFFLOAD"

In driver Kconfig, one should use "depends on XFRM_OFFLOAD" and not "select XFRM_OFFLOAD".
Drivers shouldn't enable XFRM_OFFLOAD directly and all upstream users are safe here.

Thanks

