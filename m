Return-Path: <netdev+bounces-44344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4417E7D79BF
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFC6281DC1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F115A5;
	Thu, 26 Oct 2023 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyjT9evM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBA17CD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA06C433C7;
	Thu, 26 Oct 2023 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698281003;
	bh=o74fcJsVBea/xhgwWVCnWC14swdPhGAlQdOGJ04AzI4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TyjT9evMpsPFRFfzb5PgixLSm8WTkxS+Jb/C3W4ADVaY4boC57WaLcwaFLdsPD92c
	 UDoctDZpUpM9jAtAXPVXJq60Fr9LxPGhKLdsfVSj8IdeDo8En5GYP1GdnbvquJ3QQw
	 Y10+JwjLqo+Qwz6ZQ0c1JKrR9TuehA46yAJfu/bjVOKD3zNNhHWChaKQ0dnY8JcuTi
	 wlL/kbAbmRYAhPsXvyOpn38e9093uZTE61/GSqUFMeji2slo7olfeJ6t9WScfcIt8i
	 a8iU6e5bVuywA/YWVPzynFHFD5qWffY0THmz716qbtdsSHsvdfQKhq++dV8EdR3MY4
	 UlBrki3wTas4w==
Message-ID: <862dc7d4-d5a3-4a17-984b-d3dcc1015e61@kernel.org>
Date: Wed, 25 Oct 2023 18:43:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: ipv6/addrconf: clamp preferred_lft
 to the minimum required
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net,
 hideaki.yoshifuji@miraclelinux.com, pabeni@redhat.com, kuba@kernel.org
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-3-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231024212312.299370-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 3:23 PM, Alex Henrie wrote:
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
> 
> Link: https://serverfault.com/a/1031168/310447
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  net/ipv6/addrconf.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



