Return-Path: <netdev+bounces-25928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A54776302
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A477E1C2128C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290819BC2;
	Wed,  9 Aug 2023 14:50:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20817752
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94702C433C8;
	Wed,  9 Aug 2023 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592649;
	bh=zSfTo0+x3Zdgw9w7xkZDXGx9UFzzuK53v95kjaV1d2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkYY5iFlN8+f2+ag3TD7vYWSsLXQzylQp2Hh7gVr9F689asqfL7i2QnRmhS5VcL3L
	 1WMWsuo/achkKnk/pOaifyzs3T3sf9mk0EMpxMVVproRSk9VcYT5SYWuaJa5xE+0Xs
	 Cx8xygetNHmxuuK0Loeu6NKmzb1l2I+jdTlVz7V6bqIxR9cdFrgxh6BzyubBLMW/q5
	 mwYjauOSA8WfI5z0ly+Zs02e8p4GYW+JfKTTQPugC6YafH5X90i8Jx5d3lQuejbDCp
	 MrSdSMA7TQ2ziQ6RYfW/v1tL6MAsHAJ3beYiElYMZOJZV0+KPR8rat7xRDE5awdBh9
	 lIpQ2xqGhT4jw==
Date: Wed, 9 Aug 2023 16:50:44 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 0/2] mlxsw: Set port STP state on bridge
 enslavement
Message-ID: <ZNOnxIdDNEsZN+j/@vergenet.net>
References: <cover.1691498735.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691498735.git.petrm@nvidia.com>

On Tue, Aug 08, 2023 at 03:18:14PM +0200, Petr Machata wrote:
> When the first port joins a LAG that already has a bridge upper, an
> instance of struct mlxsw_sp_bridge_port is created for the LAG to keep
> track of it as a bridge port. The bridge_port's STP state is initialized to
> BR_STATE_DISABLED. This made sense previously, because mlxsw would only
> ever allow a port to join a LAG if the LAG had no uppers. Thus if a
> bridge_port was instantiated, it must have been because the LAG as such is
> joining a bridge, and the STP state is correspondingly disabled.
> 
> However as of commit 2c5ffe8d7226 ("mlxsw: spectrum: Permit enslavement to
> netdevices with uppers"), mlxsw allows a port to join a LAG that is already
> a member of a bridge. The STP state may be different than disabled in that
> case. Initialize it properly by querying the actual state.
> 
> This bug may cause an issue as traffic on ports attached to a bridged LAG
> gets dropped on ingress with discard_ingress_general counter bumped.
> 
> The above fix in patch #1. Patch #2 contains a selftest that would
> sporadically reproduce the issue.
> 
> Petr Machata (2):
>   mlxsw: Set port STP state on bridge enslavement
>   selftests: mlxsw: router_bridge_lag: Add a new selftest

Reviewed-by: Simon Horman <horms@kernel.org>


