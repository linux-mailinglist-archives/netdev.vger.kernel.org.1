Return-Path: <netdev+bounces-50379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007037F5808
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A139128148E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C90C2D0;
	Thu, 23 Nov 2023 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzHGGVa8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD9C2C5
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004FC433C7;
	Thu, 23 Nov 2023 06:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700719937;
	bh=DQku18wnqsdYXsZc0AUeywTgE/+0OjpzCh6TUoIK3R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzHGGVa8ZYRin6nBAUFhf9FHVV0qh/53tQth5Ke6EHh9h/J8TNkW6IV0l52cE5OC3
	 cE04o2XyeZTgnrEwqli/L00XKXdQ7nxVQaDn7qJdXKIfVo0s/s0gBL8FKcePNg4IZ4
	 orJbATwJlHoqAbc7pEl45rRAdtRjxVhdGr2fj6Ir2WZDFP6EFZ9jp43zl3rxY5Lgri
	 LGqf7H0Xhs3vSdmVEH0JbAs1y7Nk2AIyTXeY5U7noTcGxPIKH0qCRuWTceLk+PzcpC
	 UIZaLazyvU/ZqT2SOnTXzrMUzL/xGkdaN1SO7dHJpbU25pyJgHAywQw4NWkksfm2Os
	 ME6kxwoTpu7vg==
Date: Wed, 22 Nov 2023 22:12:15 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are
 offloaded
Message-ID: <ZV7tP6Xdx93KNuTF@x130>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
 <20231122195332.1eb22597@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231122195332.1eb22597@kernel.org>

On 22 Nov 19:53, Jakub Kicinski wrote:
>On Wed, 22 Nov 2023 13:28:32 +0200 Leon Romanovsky wrote:
>> Unfortunately not, we (mlx5) were forced by employer of one of
>> the netdev maintainers to keep uplink netdev in devlink reload
>> while we are in eswitch.
>
>The way you phrased this makes it sound like employers of netdev
>maintainers get to exert power over this community.
>

I think Leon is just misinformed, the mlx5 netdev behavior Leon is
talking about was already removed and has nothing to do with eswitch,
and even that was never required by any employer or maintainer,
sorry for the confusion .. 

>This is an unacceptable insinuation.
>
>DEVLINK_RELOAD_LIMIT_NO_RESET should not cause link loss, sure.
>Even if Meta required that you implemented that (which it does
>not, AFAIK) - it's just an upstream API.
>

We only support this limit for FW_ACTIVATE_ACTION, and has no issue
in this flow.

Leon's issue is with internal mlx5 uplink implementation where on eswitch
mode changes we don't unregister the netdev which causes eswitch resource
leaks with ipsec rules, since we move eswitch to legacy mode on devlink
reload then the same issue happens on relaod, hence he needs to block it
in this patch, and we are already discussing a new design to fix devlink
reload in net-next.

This is Just a bug and has nothing to do with any requirements from anyone.

Thanks.


