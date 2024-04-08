Return-Path: <netdev+bounces-85684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6489BD9E
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD5C283454
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BD5FBBE;
	Mon,  8 Apr 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWhRQhaI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABB5FB8F
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573715; cv=none; b=MonjWII1P8bnjx6N1mFeCGQ5Enhsiv4cjHOYB/tA5amSNR7lEEW2FgmMtFrpZbY7TX1mmsvLu+/E4HqMNKcvdMjWHe5RW/x+cJKGHdha/05ObgaiUbxAE87E4KiIzoGrg3B3YpkqkdIuJKx9QNoytS/o1RN/ZJk1WfWiigKFYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573715; c=relaxed/simple;
	bh=eLAmfJqxxHDA22In52iDjG2cO70EMUbV1rLprOAFi5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYUlSN7M7Esiof8UmkVQB1R7KBJeeE4UDI21qKf35N8uXHBINlkmrE248s6uduD4BQE3FuEyjvH3xia+t2E+X1wrrPVIdCTtj4qx7Dnv5AHlqdYdQa54rczShOkuolIAPywXIwCIYdLBUXR7eOWTuEmaK7QGM8Dv4cNm0b02/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWhRQhaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA29AC433F1;
	Mon,  8 Apr 2024 10:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712573715;
	bh=eLAmfJqxxHDA22In52iDjG2cO70EMUbV1rLprOAFi5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWhRQhaIdJgQ9cBS23EIUvC+1zpJ4EcPyTJhzKTTRLU9j3k7U0HIpD4iq45u3x+Mx
	 jgJTYeERW52kjU4FYRX6qZ2Hak6EyhPsVSAtogeBlJA/erU28z63Ht7Qz4obY8yS70
	 u4hFUZHSDHrgPIYSjMGceWhKehAdpFsMnQoVMIWjV7yYumWSn9ZXJ17kdS46UrJ69U
	 9nIAB6HgUUfg8ve5cDSid2mUeZyiYmGeIM89vIFSz0qImZRSX/25/qq7N/R7XYFC2N
	 tr0jBMrdzQWhbwIMAlN06tNzCxKbiMBTuKrhBMhelA/JoODfcKwBspHC5EKmCbRax6
	 ttI31xSxfOdMw==
Date: Mon, 8 Apr 2024 13:55:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	David Ahern <dsahern@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next] ipv4: Set scope explicitly in ip_route_output().
Message-ID: <20240408105511.GD8764@unreal>
References: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>

On Fri, Apr 05, 2024 at 10:05:00PM +0200, Guillaume Nault wrote:
> Add a "scope" parameter to ip_route_output() so that callers don't have
> to override the tos parameter with the RTO_ONLINK flag if they want a
> local scope.
> 
> This will allow converting flowi4_tos to dscp_t in the future, thus
> allowing static analysers to flag invalid interactions between
> "tos" (the DSCP bits) and ECN.
> 
> Only three users ask for local scope (bonding, arp and atm). The others
> continue to use RT_SCOPE_UNIVERSE. While there, add a comment to warn
> users about the limitations of ip_route_output().
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  drivers/infiniband/hw/irdma/cm.c        | 3 ++-
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 3 ++-
>  drivers/net/bonding/bond_main.c         | 4 ++--
>  drivers/net/ethernet/broadcom/cnic.c    | 3 ++-
>  include/net/route.h                     | 9 ++++++++-
>  net/atm/clip.c                          | 2 +-
>  net/bridge/br_netfilter_hooks.c         | 3 ++-
>  net/ipv4/arp.c                          | 9 ++++++---
>  net/ipv4/igmp.c                         | 3 ++-
>  net/mpls/af_mpls.c                      | 2 +-
>  10 files changed, 28 insertions(+), 13 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com> # infiniband

