Return-Path: <netdev+bounces-31475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30378E452
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FA41C209A7
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013710F6;
	Thu, 31 Aug 2023 01:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E10E1
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63CCC433C7;
	Thu, 31 Aug 2023 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693445334;
	bh=W1sfS0py5k1Q/miyIyzOhcYwK57jwaL+ysqBtshR9P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TG//sZ9a0Niqa4UsnybrA+vvA470R7MyzTvKU5J4vA0fJKu2+KHlsfL8lvYW1jriH
	 zbtEAunGrcvi506QnUhks2u6BqzvvJK2QV+vwv34SWTTNNBsqIXNCVdc6W1ZHSA59r
	 YdowkjdhrVqV7Ef/oWnAgsQRGmDV9/HCBWxIFJFpFpsvXAi3Q0r/gpo1ufjRQvrBYm
	 y0+EKkd/DblmPLOt23LGLcdGb5gjkhI0qw5b+eZ0LFSJaFW0LZXGyrVBpVSedouEvC
	 aoe55blkLMmqjBMMEfTnUoH1/TdyXaPZSm8C5JAWh9CbEpya5vF/g4yo2ehzkiFrnN
	 krPsQHvgMMt6w==
Date: Wed, 30 Aug 2023 18:28:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
 davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com,
 dsahern@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 3/5] net: ipv6/addrconf: clamp preferred_lft to the
 minimum required
Message-ID: <20230830182852.175e0ac2@kernel.org>
In-Reply-To: <20230829054623.104293-4-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
	<20230829054623.104293-1-alexhenrie24@gmail.com>
	<20230829054623.104293-4-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Aug 2023 23:44:45 -0600 Alex Henrie wrote:
> If the preferred lifetime was less than the minimum required lifetime,
> ipv6_create_tempaddr would error out without creating any new address.
> On my machine and network, this error happened immediately with the
> preferred lifetime set to 1 second, after a few minutes with the
> preferred lifetime set to 4 seconds, and not at all with the preferred
> lifetime set to 5 seconds. During my investigation, I found a Stack
> Exchange post from another person who seems to have had the same
> problem: They stopped getting new addresses if they lowered the
> preferred lifetime below 3 seconds, and they didn't really know why.
> 
> The preferred lifetime is a preference, not a hard requirement. The
> kernel does not strictly forbid new connections on a deprecated address,
> nor does it guarantee that the address will be disposed of the instant
> its total valid lifetime expires. So rather than disable IPv6 privacy
> extensions altogether if the minimum required lifetime swells above the
> preferred lifetime, it is more in keeping with the user's intent to
> increase the temporary address's lifetime to the minimum necessary for
> the current network conditions.
> 
> With these fixes, setting the preferred lifetime to 3 or 4 seconds "just
> works" because the extra fraction of a second is practically
> unnoticeable. It's even possible to reduce the time before deprecation
> to 1 or 2 seconds by also disabling duplicate address detection (setting
> /proc/sys/net/ipv6/conf/*/dad_transmits to 0). I realize that that is a
> pretty niche use case, but I know at least one person who would gladly
> sacrifice performance and convenience to be sure that they are getting
> the maximum possible level of privacy.

Not entirely sure what the best way to handle this is.
And whether the patch should be treated as a Fix or "general
improvement" - meaning - whether we should try to backport this :(

> Link: https://serverfault.com/a/1031168/310447
> Fixes: eac55bf97094 (IPv6: do not create temporary adresses with too short preferred lifetime, 2008-04-02)

Thanks for adding the Fixes tag - you're missing the quotes inside
the parenthesis:

Fixes: eac55bf97094 ("IPv6: do not create temporary adresses with too short preferred lifetime, 2008-04-02")

The exact format is important since people may script around it.
Since we haven't heard back from Paolo or David on v2 could you repost
with that fixed?
-- 
pw-bot: cr

