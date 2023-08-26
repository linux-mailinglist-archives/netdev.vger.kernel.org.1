Return-Path: <netdev+bounces-30861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8D789493
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 09:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C0C2819A0
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801761379;
	Sat, 26 Aug 2023 07:58:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451401371
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 07:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABFFC433C8;
	Sat, 26 Aug 2023 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693036713;
	bh=SwXTEJn40xmEeql6k4bN/d9heZHQEFszpeuASizr9Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+Cj2QTCePl/4MqNY2xuwunpHw25uZh+s/JPtyVR8e6FRisbC8nN/KsEE7kINIkXK
	 skVET8z4KK77OlO8X12R6BFiQY45hVbDIkv7ZUfcP3rptvHeTTqMa2Zvy5c47HPrwJ
	 7Ebc16igzsbpoAN3u8akeA0YwSkBeEklnQAWVyrwRtlwNVfLA97iWUvLFQCED1N3N+
	 qbz4hMas8aIiunm2TPilyAqvrDqgElrjSi03vHxONt3ovviRWQyov8EWQ2p08v851u
	 fD3YlcjUxv8O58fUlBcqYAomBVfhlMXJAwGsTYTrXNHKixnGOYD9rstc1PYQvyqDqr
	 qGzOsgYa+AJKw==
Date: Sat, 26 Aug 2023 09:58:28 +0200
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, gal@nvidia.com, martin.lau@linux.dev
Subject: Re: [PATCH net-next 2/2] net: Make consumed action consistent in
 sch_handle_egress
Message-ID: <20230826075828.GP3523530@kernel.org>
References: <20230825134946.31083-1-daniel@iogearbox.net>
 <20230825134946.31083-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825134946.31083-2-daniel@iogearbox.net>

On Fri, Aug 25, 2023 at 03:49:46PM +0200, Daniel Borkmann wrote:
> While looking at TC_ACT_* handling, the TC_ACT_CONSUMED is only handled in
> sch_handle_ingress but not sch_handle_egress. This was added via cd11b164073b
> ("net/tc: introduce TC_ACT_REINSERT.") and e5cf1baf92cb ("act_mirred: use
> TC_ACT_REINSERT when possible") and later got renamed into TC_ACT_CONSUMED
> via 720f22fed81b ("net: sched: refactor reinsert action").
> 
> The initial work was targeted for ovs back then and only needed on ingress,
> and the mirred action module also restricts it to only that. However, given
> it's an API contract it would still make sense to make this consistent to
> sch_handle_ingress and handle it on egress side in the same way, that is,
> setting return code to "success" and returning NULL back to the caller as
> otherwise an action module sitting on egress returning TC_ACT_CONSUMED could
> lead to an UAF when untreated.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Simon Horman <horms@kernel.org>


