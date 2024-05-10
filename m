Return-Path: <netdev+bounces-95435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B458C239F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626B01C23A4A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FD16F0EE;
	Fri, 10 May 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAjliYte"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33079165FB6;
	Fri, 10 May 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340639; cv=none; b=sefPeSKThWDHBEjZYq9tCLOSv74x5RtspDK5qLvscKgahootwhbDDqPu3WmfRXyipeSguD4PO4v3N2DaMaPQ2vr/HQt8xLO3uyYAwKE4KyEEZiuzO3DiJLDj61nJBLRmIGwR3RIBLmgdoqcK98pyLHF5ysK0/rs+ae7B3cA+DYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340639; c=relaxed/simple;
	bh=R02VxDDaHuGhaT3r9ObK5PaVxGdV2DnLHafkPnqWiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOd1cWhhUMu8uvAY7jyn64S37h9Bx1tNz2enjDa0BSDhKxBCdl3yTG4giRVVTZ/Dp1/YxFx5C995y/9LsDW4+LTx1JH6nwz81bZW7y1dwiSzvjyiGE06hyPv3JeY8/BZVak1MLUlAWgL6VNKZsU00UGoplkl7lZyPNuYSTpx/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAjliYte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75670C113CC;
	Fri, 10 May 2024 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340638;
	bh=R02VxDDaHuGhaT3r9ObK5PaVxGdV2DnLHafkPnqWiqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAjliYtendi43yxreNAKQ51nuo4db/SU34bycLnDsumI/SX5u5PBZ81svivEQyALy
	 Y7aNaMhgQjkxnRUU59KoFiEeYUWHw1IWhXT/BPmCr3qA6+Ce0BspnzZ8tHkMQxICQI
	 GZOp54BSv9fV7gJD1uqxDdvaEIMFAmQ0bmobWH4sib92PhH/kaT6QSAk1mMFgnLs1/
	 8WY2feAroTJGUb6BB2Z/sAw/gLB2tQ4EUvgJ7AQ2U11lBnGDEEp51dgNEZW6u2AJh3
	 tDF5DBjGR50dEXoKCk337fn7DIki0eTtvlYHGgwkn/5owuFs5igWlkEEeqlbJ4Rq3K
	 I/UgRIiG1OBiA==
Date: Fri, 10 May 2024 12:30:33 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 12/14] net: qede: use faked extack in
 qede_flow_spec_to_rule()
Message-ID: <20240510113033.GO2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-13-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-13-ast@fiberby.net>

On Wed, May 08, 2024 at 02:34:00PM +0000, Asbjørn Sloth Tønnesen wrote:
> Since qede_parse_flow_attr() now does error reporting
> through extack, then give it a fake extack and extract the
> error message afterwards if one was set.
> 
> The extracted error message is then passed on through
> DP_NOTICE(), including messages that was earlier issued
> with DP_INFO().
> 
> This fake extack approach is already used by
> mlxsw_env_linecard_modules_power_mode_apply() in
> drivers/net/ethernet/mellanox/mlxsw/core_env.c
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> 
> ---
> Note:
> Even through _msg is marked in include/linux/netlink.h as
> "don't access directly, use NL_SET_ERR_MSG", then the comment
> above NL_SET_ERR_MSG, seams to indicate that it should be fine
> to access it directly if for reading, as is done other places.
> I could also add a NL_GET_ERR_MSG but I would rather not do that
> in this series.

Reviewed-by: Simon Horman <horms@kernel.org>


