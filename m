Return-Path: <netdev+bounces-124586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3A96A0F7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A71C23D8B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574044C6F;
	Tue,  3 Sep 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO0HlyL7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB12E657
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374736; cv=none; b=Q3vAkMDu1gL0T7UvpnK11d3oZvByMIDhpE121TaPBiVVw1c0USvMsl59/8NXPA7Hr7JKxE/3uSjFVADgx+WeN0zIh468IkB2nR+cS3vfAHk/szKtXEJHqNYSUEz5c9G5jMPh/6ydb16rLjl/oZ9gDBQKFrx5Ixpch+P1obz7lBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374736; c=relaxed/simple;
	bh=LD3t/ug40wU3q7R02qG9Ce7j20152XLa8ixIfV5ehwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnHbtsiPaHO5lDHxmB1KGeGYCLK6HvYzMbUl3TORYToA1wLT6il5bGzZGUI1EYZK0ENlyMI+gA2or0PZwLrm5YZLPILntbmpXm8CB1tCkOK3oMF03Kaba+Uj2TgsWa51e4Pa0gOxgBOGM+JiEsqenUH8fxdvmiQQrtO4olRr2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO0HlyL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D8DC4CEC4;
	Tue,  3 Sep 2024 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374734;
	bh=LD3t/ug40wU3q7R02qG9Ce7j20152XLa8ixIfV5ehwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MO0HlyL7i/HdJeBCZiNKbGUzYN8HJow5qVdIJMtbdksOg2PZhqIaS2fx/ZO3gUqZu
	 /Q+BXoAAKBKDM36mJdhpyCOZEm7mjZxTCBx9yNSuAQFne+7Sr7edMz4QHm6MMrkidp
	 7j785sxSRbcMxkHGXIzag/Z4sp4O5T0M9TPdYV6KVTI7ljHcAdjiAeTjWmA7MUBDvY
	 vboWejHWqcUBmsxMel/ApkIdsETk4QIMorHEraXbsroWvW7ncVjU4L2ePsI8bZFnfX
	 2lmPlWuSGEjKTKZM0XBy0fZeV+Mf0mekKgLGEppAiYLWz1IsvPSg3xMG1GUrYtw4Bg
	 qecPQyw9uNuNA==
Message-ID: <b1353cfd-565d-4f19-b21f-08beb997d3c3@kernel.org>
Date: Tue, 3 Sep 2024 08:45:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Unmask upper DSCP bits - part 3
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, gnault@redhat.com
References: <20240903135327.2810535-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240903135327.2810535-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 7:53 AM, Ido Schimmel wrote:
> tl;dr - This patchset continues to unmask the upper DSCP bits in the
> IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> DSCP. No functional changes are expected.
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> It is currently impossible for user space to configure FIB rules that
> match on the DSCP value as the upper DSCP bits are either masked in the
> various call sites that initialize the IPv4 flow key or along the path
> to the FIB core.
> 
> In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> need to make sure the entire DSCP value is present in the IPv4 flow key.
> This patchset continues to unmask the upper DSCP bits, but this time in
> the output route path, specifically in the callers of
> ip_route_output_ports().
> 
> The next patchset (last) will handle the callers of
> ip_route_output_key(). Split from this patchset to avoid going over the
> 15 patches limit.
> 
> No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
> Centralize TOS matching") moved the masking of the upper DSCP bits to
> the core where 'flowi4_tos' is matched against the TOS selector.
> 
> Ido Schimmel (4):
>   ipv4: Unmask upper DSCP bits in __ip_queue_xmit()
>   ipv4: ipmr: Unmask upper DSCP bits in ipmr_queue_xmit()
>   ip6_tunnel: Unmask upper DSCP bits in ip4ip6_err()
>   ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_bind_dev()
> 
>  net/ipv4/ip_output.c  | 2 +-
>  net/ipv4/ipmr.c       | 4 ++--
>  net/ipv6/ip6_tunnel.c | 7 +++++--
>  net/ipv6/sit.c        | 2 +-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 

For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


