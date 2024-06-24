Return-Path: <netdev+bounces-106181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A052915123
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF401C2462C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041519EEC2;
	Mon, 24 Jun 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYoXxfc0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD819EEBF
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240883; cv=none; b=Go6CtXziRjc7LkIO9CYcs/xdFPHzRkvwdDGgrVUVtX1ZBcMryBqEnZNKW04O+XD00kVSUsl+t8Bgb19zwMb53+sZ+WI+MFPHvDZTaueh/sXsq325pjNzUQSpcTM9e1imjcMBXY4p3ld2qlJ0orKOKzeSxCjX2D1BV2jbB2a52+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240883; c=relaxed/simple;
	bh=R8ud80y4pRtH5aUksL9qxaZPkGYJfyD/v6g+SNR6TuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPnDoxcjljB8viAkkfYMc7NTMCFdyVPTD0XITBLe6z6gbPZ2JT94mVqnApvCrvbXUbs3XfTePiLdYpuvXXDTZFu+3gC4cxi1wpB+Si9zvPK+GO3iZ0VQ5LYpnnLhaAl3WaH7Db/mxSZDrKGMjLD8SLocTbPZaCmbWNEEtfvxpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYoXxfc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1776C2BBFC;
	Mon, 24 Jun 2024 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719240883;
	bh=R8ud80y4pRtH5aUksL9qxaZPkGYJfyD/v6g+SNR6TuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GYoXxfc0ThN2WXVhfHSkyN7CbRSI6fk4fE01DHBCr81MfQNQ1Yn+ccq/0pHEYWvoK
	 Fyn6s5tcAQx5pQWBu4Czd7HvXCnijG7qDx/orRSYZ2WrRZ9oN7c5PVF74WpE8p27M6
	 wExdGMFHVueucjlcsLZIrZG0xLxE+SBYrD1pNwTwFJD4Icsme0/0skginQcwN/gJRo
	 YiWl+s2weKWMusIcEjij6v1OwwU4hjG7Mmj7J6AQghbl+J514H9P3mi07tWtB+NDUu
	 pUsthyOEcPZ8bMOqw8+syX47utVW3QhBydV65gz0bmLU0XKpN0EN7/wCMZV/AQN4xX
	 9mTomZeg8ICuQ==
Date: Mon, 24 Jun 2024 07:54:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
Message-ID: <20240624075442.58b50bc7@kernel.org>
In-Reply-To: <c085b55f-3b42-1655-ea88-3f6a1e03cf8e@gmail.com>
References: <20240620232902.1343834-1-kuba@kernel.org>
	<20240620232902.1343834-5-kuba@kernel.org>
	<c085b55f-3b42-1655-ea88-3f6a1e03cf8e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 13:55:34 +0100 Edward Cree wrote:
> > +    try:
> > +        # Use queues 0 and 1 for normal traffic
> > +        ethtool(f"-X {cfg.ifname} equal 2")
> > +
> > +        for i in range(ctx_cnt):
> > +            try:
> > +                ctx_id.append(ethtool_create(cfg, "-X", "context new"))
> > +            except CmdExitFailure:
> > +                # try to carry on and skip at the end
> > +                if i == 0:
> > +                    raise
> > +                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
> > +                ctx_cnt = i
> > +                break
> > +
> > +            ethtool(f"-X {cfg.ifname} context {ctx_id[i]} start {2 + i * 2} equal 2")  
> 
> Is it worth also testing the single command
>     f"ethtool -X {cfg.ifname} context new start {2 + i * 2} equal 2"
>  as that will exercise the kernel & driver slightly differently to
>  first creating a context and then configuring it?

Will add!

> > diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> > index 4769b4eb1ea1..91648c5baf40 100644
> > --- a/tools/testing/selftests/net/lib/py/ksft.py
> > +++ b/tools/testing/selftests/net/lib/py/ksft.py
> > @@ -57,6 +57,11 @@ KSFT_RESULT_ALL = True
> >          _fail("Check failed", a, "<", b, comment)
> >  
> >  
> > +def ksft_lt(a, b, comment=""):
> > +    if a > b:
> > +        _fail("Check failed", a, ">", b, comment)  
> 
> AFAICT this implements 'le' (less-or-equal), not 'lt' (less than) as
>  the name implies.

Good catch!

> Apart from that these tests LGTM as far as they go.  One thing that I
>  notice *isn't* tested here, that I generally make a point of testing,
>  is: add a bunch of contexts (and ntuple filters), remove some of
>  them, then run your traffic and make sure that the ones you left
>  intact still work (and that the deleted ones are actually gone).

Good idea, will add.

> Also wonder if it's worth adding tests for 'ethtool -x ... context N'?
>  You have it for context 0 in test_rss_key_indir(), but on custom
>  contexts it can exercise different code in the kernel.

Good point, in my head I deferred all "context N read" tests until we
have dump, but the simple read test should be added here.

