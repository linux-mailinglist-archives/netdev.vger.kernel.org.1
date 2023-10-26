Return-Path: <netdev+bounces-44352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6467D7A18
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB318281DD6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA466440B;
	Thu, 26 Oct 2023 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kokRkpV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92C4695
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69FCC433C7;
	Thu, 26 Oct 2023 01:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698283504;
	bh=g+AYHQfnDaNQIzMW69hlh01q5EDPHDE8lxzWWQzDz/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kokRkpV1Z+YvekxL+UUfcfbGywGy0i/yIh4NOb7jr+RgMDhhf+0WXVx5zH1xr7YUc
	 ihoL2bj46bg1bCTeZFacbTPoW8gY7HVAybiWkGa1XqpxBr/0GeC2rpgRblnB02/LsX
	 98qdN+KO2AJwTm1jIC2qMn9Oz6iYBulsgf6l2F+E7hXEEjoq3S6hIojndEw+bh3U3A
	 vV6AXa6i9OewYWujIylcCmFMKEjuAE2x7Px1W28a26Me8fbam6aVyzGxKHcumVoyVO
	 GKIyVo3eE8QHCT/XESLMvStPUADEKSCCzbOvd+5FDbBPnqeuushZHG6swpvk505w5/
	 64M1IPer1QAOw==
Date: Wed, 25 Oct 2023 18:25:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231025182502.54f79369@kernel.org>
In-Reply-To: <20231025085202.GC2950466@unreal>
References: <20231021064620.87397-1-saeed@kernel.org>
 <20231024180251.2cb78de4@kernel.org>
 <20231025085202.GC2950466@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 11:52:02 +0300 Leon Romanovsky wrote:
> This patch won't fix much without following patch in that series.
> https://lore.kernel.org/all/20231021064620.87397-8-saeed@kernel.org/
> 
> Yes, users will see their replay window correctly through "ip xfrm state"
> command, so this is why it has Fixes line, but it won't change anything
> in the actual behavior without patch 7 and this is the reason why it was
> sent to net-next.

Odd ordering of patches, anyone doing backports would totally miss it.
Neither does the commit message explain the situation nor is it
possible to grok that fact from the ("pass it to FW") code :(

> From patch 3:
>  Users can configure IPsec replay window size, but mlx5 driver didn't
>  honor their choice and set always 32bits.
> 
> From patch 7:
>  After IPsec decryption it isn't enough to only check the IPsec syndrome
>  but need to also check the ASO syndrome in order to verify that the
>  operation was actually successful.

Hm, patch 7 looks like an independent but related fix to my uneducated
eye, should it also have a Fixes tag?

Is patch 7 needed regardless of what choice of (previously ignored)
parameters user makes? One way to deal with the problems from patches 
3 and 4 could be to reject the de facto unsupported configurations.
But if the supported config also doesn't check the "syndrome" correctly
in all cases, that's no bueno..

