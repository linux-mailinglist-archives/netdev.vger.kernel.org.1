Return-Path: <netdev+bounces-109948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4CD92A70C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EAD1F21F3A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7214B952;
	Mon,  8 Jul 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgi96ixz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9714B092
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455207; cv=none; b=DbLflILqL7YdhhECHHYYLkI8t0L/YBFcvV4UFCsnQWTzPlot1WiLrlf6WjkWpbGUcG9nDnJ7VJp0fMvXxM9+J7eGm3tgni0smNlLYgsHrkLNSLsYuGzwsQwpwvW9kVpTmQiUme/2CtGpIDsQuMktm4FESl1i9FBl8dPP87kyEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455207; c=relaxed/simple;
	bh=rGy590sLzuITt7tzw1hl+05OIXHjx37bMbKM81ORtWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qshiFBGB8yu8y6CuSq4YBlMrEhFlLo2BatOwr2pUHs+diWUQS5DmVzoxLu/XTkntZ4zKob6N0Nub7ISpIfz6/VsyyvqUaP0Eyl+JY69q4gDYseLJWP+WzYBJ/T3F+wEfQaXN0vX6u9phLG3eEqOZVZlW4iGUvceyyYPyERs4VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgi96ixz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B6FC4AF0D;
	Mon,  8 Jul 2024 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720455207;
	bh=rGy590sLzuITt7tzw1hl+05OIXHjx37bMbKM81ORtWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rgi96ixzOq/hHxRJHt6mG37TQJi1eq3MqlK5yHmHbUgYoE4COlzdUzICyyE//mvBK
	 A/F4qPPQQZOBEq3DRi7JBAJcPUFxSKndCitS2nlGf3zL2EQlL5HG502wbM8CUZaJag
	 xaWfeQr7tbOte8GwN6AqMxWe2hba9RePPXmZUVqiwTRm3SSuXhgHBcV62mKeDDct86
	 HaVMCwx22hruZcpQMutqkCcv3mJ224bc4UaFkxZQPMsrbovS8IU7USSfsnmThzGwDV
	 NRHmceFa+xDt4pTgL0umqN8UfDTNuGhI3NedPkaoFps56dEeWvefHpAHzQpmgWG5s2
	 Pbxi/l6+hQ/HQ==
Date: Mon, 8 Jul 2024 09:13:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, petrm@nvidia.com, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: rss_ctx: fix cleanup
 in the basic test
Message-ID: <20240708091326.4e704b46@kernel.org>
In-Reply-To: <66894c659cee8_12869e2942c@willemb.c.googlers.com.notmuch>
References: <20240705015725.680275-1-kuba@kernel.org>
	<20240705015725.680275-2-kuba@kernel.org>
	<66894c659cee8_12869e2942c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 09:53:41 -0400 Willem de Bruijn wrote:
> > @@ -89,6 +88,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
> >  
> >      # Set the indirection table
> >      ethtool(f"-X {cfg.ifname} equal 2")
> > +    reset_indir = defer(ethtool, f"-X {cfg.ifname} default")
> >      data = get_rss(cfg)
> >      ksft_eq(0, min(data['rss-indirection-table']))
> >      ksft_eq(1, max(data['rss-indirection-table']))
> > @@ -104,7 +104,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
> >      ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
> >  
> >      # Restore, and check traffic gets spread again
> > -    ethtool(f"-X {cfg.ifname} default")
> > +    reset_indir.exec()  
> 
> When is this explicit exec needed?

When you want to run the cleanup _now_.

We construct the cleanup as soon as we allocate the resource,
it stays on the deferred list in case some exception makes us abort,
but the test may want to free the resource or reconfigure it further
as part of the test, in which case it can run .exec() (or cancel() to
discard the clean up without running it).

Here we do:
 1. constrain RSS
 2. run traffic (to check we're hitting expected queues)
 3. reset RSS
 4. run traffic (to check we're hitting all queues)

so step 3 runs the cleanup of step 1 explicitly.

