Return-Path: <netdev+bounces-94667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6C8C01DA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CED289F19
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA1E1292E9;
	Wed,  8 May 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev506SgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E61DFD8;
	Wed,  8 May 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185277; cv=none; b=ouY38za9tjKwOKanETXd5+Oh7I71ADgaObHsUFrh5inOFhRsGW39VOym7m4SkargGjLOGT1SA5KaDxp1Akc3gq+G00YrQCdbl5JcpjerqI9phKNWmZPbaaX96FFSTTklJzC7dzUzMi/yAFKdjeNxcfSSi3larOjkuPq8VA45Jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185277; c=relaxed/simple;
	bh=1AmpNyNEuOozqrUlpUHlZ6fGF9oTiFtYHIwMkz5zBg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrqQC1yZjSvJVjgxtvPMAgXffPgC2zXZGQxLlqwG8NLsMzwkoAUOJmlDJKDKlxQ82Bte+Oes6XBZdyQxrFMFfEv1y2hYPQZ48+XMHbiV2CL454vaKTQBduL4zThE/RFWO4m8DDp1OCGvJLPpaWWnu8tFA/DtTUa7G7hVu58kjSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev506SgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA24C113CC;
	Wed,  8 May 2024 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185276;
	bh=1AmpNyNEuOozqrUlpUHlZ6fGF9oTiFtYHIwMkz5zBg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev506SgGg7jd5w/FfEnNUXbMrbkFN9gcoygyKowgL5OOC74TIrsML7d/9i1LBQ5L/
	 9B50qWC3P1rjaWRSBVAiMPfKB4n3UW0TfUryKTUfueAjzgVwo0Aoly5acl8nR2m0wD
	 xiojucEE+Z+3pRxI1+QAiDzg399OOpx1hKOYQ4J0CqIbmUqJuW6tyfi7+El18EnA+X
	 K3wZnwGYbe9/zuXsbqoD5nbXIfW/W51PCyiOxOdGQi56xsbM/nFt1pZlcfOyaZRKGt
	 FebXTJRB4OmPDE8oEcgIman52pSPIWq+wrjVpSM0PQezvpmWeD2DKHbpC4KY53Glrx
	 ul9s5MDGjyRTQ==
Date: Wed, 8 May 2024 17:21:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net 1/7] net: hns3: using user configure after
 hardware reset
Message-ID: <20240508162111.GH1736038@kernel.org>
References: <20240507134224.2646246-1-shaojijie@huawei.com>
 <20240507134224.2646246-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507134224.2646246-2-shaojijie@huawei.com>

On Tue, May 07, 2024 at 09:42:18PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> When a reset occurring, it's supposed to recover user's configuration.
> Currently, the port info(speed, duplex and autoneg) is stored in hclge_mac
> and will be scheduled updated. Consider the case that reset was happened
> consecutively. During the first reset, the port info is configured with
> a temporary value cause the PHY is reset and looking for best link config.
> Second reset start and use pervious configuration which is not the user's.
> The specific process is as follows:
> 
> +------+               +----+                +----+
> | USER |               | PF |                | HW |
> +---+--+               +-+--+                +-+--+
>     |  ethtool --reset   |                     |
>     +------------------->|    reset command    |
>     |  ethtool --reset   +-------------------->|
>     +------------------->|                     +---+
>     |                    +---+                 |   |
>     |                    |   |reset currently  |   | HW RESET
>     |                    |   |and wait to do   |   |
>     |                    |<--+                 |   |
>     |                    | send pervious cfg   |<--+
>     |                    | (1000M FULL AN_ON)  |
>     |                    +-------------------->|
>     |                    | read cfg(time task) |
>     |                    | (10M HALF AN_OFF)   +---+
>     |                    |<--------------------+   | cfg take effect
>     |                    |    reset command    |<--+
>     |                    +-------------------->|
>     |                    |                     +---+
>     |                    | send pervious cfg   |   | HW RESET
>     |                    | (10M HALF AN_OFF)   |<--+
>     |                    +-------------------->|
>     |                    | read cfg(time task) |
>     |                    |  (10M HALF AN_OFF)  +---+
>     |                    |<--------------------+   | cfg take effect
>     |                    |                     |   |
>     |                    | read cfg(time task) |<--+
>     |                    |  (10M HALF AN_OFF)  |
>     |                    |<--------------------+
>     |                    |                     |
>     v                    v                     v
> 
> To avoid aboved situation, this patch introduced req_speed, req_duplex,
> req_autoneg to store user's configuration and it only be used after
> hardware reset and to recover user's configuration
> 
> Fixes: f5f2b3e4dcc0 ("net: hns3: add support for imp-controlled PHYs")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Thanks for the update since v1.

Reviewed-by: Simon Horman <horms@kernel.org>


