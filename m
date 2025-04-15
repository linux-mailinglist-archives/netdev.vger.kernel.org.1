Return-Path: <netdev+bounces-182866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C0A8A31C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02297A87E8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89029B77B;
	Tue, 15 Apr 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgquAFKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A437297A60
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731613; cv=none; b=Ivj1CWUCb0FUjCzICSu5rSurAsr9cd1TKQLQSzFVztO836j+YiwS94k4HPtXFD0bnF9I4JiwYcAljMyr419fl1LnrFcPYEF7yxYa8uSYPeumhuCYo0GmRNT5SFhKOpXl7lOPXaQRmQT9RsbF2PbK4O+ZSFA28HYt7/RqvzI+8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731613; c=relaxed/simple;
	bh=IuELbAbNuQOztb4igIbOswq2lVtYn0JBz/TNUCHIl4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZBPbCB8MEzn6TOos6dcDimPOYRfTLZyHKWW561JPL03pGx7T6LJbwJl2/EOCwJ3I+ALFDev3/sc/sfAZx65kmKzEVME1TbzDLABnp1dRziybUeuUQ0KafmaTRESfag4JGuRjJSaE4o7rai80voCFh76nw2VGDARVfaxHu3dMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgquAFKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C60EC4CEEC;
	Tue, 15 Apr 2025 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731613;
	bh=IuELbAbNuQOztb4igIbOswq2lVtYn0JBz/TNUCHIl4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QgquAFKPU++ITkgOW1xuNi8BAnS/yNJOdQ8Pz3uEltgf73TBvyHBAU0H68WfJqnLy
	 7clzQTiae2fUIoUMPfEuu1Y354l/mGZF5gE8Uzxe/6ppMlxzc62EBqfX1vE3oboZtK
	 BcyUfJruSziFE2TgWXYWHGygEcxHCYf21UJ0KyFAiRFJmHckUtI4UnDSI503OdcSUB
	 YIYWW8LC8gtjk18s5K3IHf2mfyfGN48JDRs0WW3XN/DCE52aeE3OMJfqLV+sBIdPtu
	 n6voT+VKkZT5FQPL0wvMAAQs1lvc/h3FYph35A+ntQ7I+MVixL5N122a+suI5cSj4E
	 oK2O2aMzSKRWg==
Message-ID: <5667bed7-3b22-484e-8e31-9abb8029caee@kernel.org>
Date: Tue, 15 Apr 2025 08:40:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: fib_rules: Fix iif / oif matching on L3
 master device
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, hanhuihui5@huawei.com
References: <20250414172022.242991-1-idosch@nvidia.com>
 <20250414172022.242991-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250414172022.242991-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 11:20 AM, Ido Schimmel wrote:
> Before commit 40867d74c374 ("net: Add l3mdev index to flow struct and
> avoid oif reset for port devices") it was possible to use FIB rules to
> match on a L3 domain. This was done by having a FIB rule match on iif /
> oif being a L3 master device. It worked because prior to the FIB rule
> lookup the iif / oif fields in the flow structure were reset to the
> index of the L3 master device to which the input / output device was
> enslaved to.
> 
> The above scheme made it impossible to match on the original input /
> output device. Therefore, cited commit stopped overwriting the iif / oif
> fields in the flow structure and instead stored the index of the
> enslaving L3 master device in a new field ('flowi_l3mdev') in the flow
> structure.
> 
> While the change enabled new use cases, it broke the original use case
> of matching on a L3 domain. Fix this by interpreting the iif / oif
> matching on a L3 master device as a match against the L3 domain. In
> other words, if the iif / oif in the FIB rule points to a L3 master
> device, compare the provided index against 'flowi_l3mdev' rather than
> 'flowi_{i,o}if'.
> 
> Before cited commit, a FIB rule that matched on 'iif vrf1' would only
> match incoming traffic from devices enslaved to 'vrf1'. With the
> proposed change (i.e., comparing against 'flowi_l3mdev'), the rule would
> also match traffic originating from a socket bound to 'vrf1'. Avoid that
> by adding a new flow flag ('FLOWI_FLAG_L3MDEV_OIF') that indicates if
> the L3 domain was derived from the output interface or the input
> interface (when not set) and take this flag into account when evaluating
> the FIB rule against the flow structure.
> 
> Avoid unnecessary checks in the data path by detecting that a rule
> matches on a L3 master device when the rule is installed and marking it
> as such.
> 
> Tested using the following script [1].
> 
> Output before 40867d74c374 (v5.4.291):
> 
> default dev dummy1 table 100 scope link
> default dev dummy1 table 200 scope link
> 
> Output after 40867d74c374:
> 
> default dev dummy1 table 300 scope link
> default dev dummy1 table 300 scope link
> 
> Output with this patch:
> 
> default dev dummy1 table 100 scope link
> default dev dummy1 table 200 scope link
> 
> [1]
>  #!/bin/bash
> 
>  ip link add name vrf1 up type vrf table 10
>  ip link add name dummy1 up master vrf1 type dummy
> 
>  sysctl -wq net.ipv4.conf.all.forwarding=1
>  sysctl -wq net.ipv4.conf.all.rp_filter=0
> 
>  ip route add table 100 default dev dummy1
>  ip route add table 200 default dev dummy1
>  ip route add table 300 default dev dummy1
> 
>  ip rule add prio 0 oif vrf1 table 100
>  ip rule add prio 1 iif vrf1 table 200
>  ip rule add prio 2 table 300
> 
>  ip route get 192.0.2.1 oif dummy1 fibmatch
>  ip route get 192.0.2.1 iif dummy1 from 198.51.100.1 fibmatch
> 
> Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
> Reported-by: hanhuihui <hanhuihui5@huawei.com>
> Closes: https://lore.kernel.org/netdev/ec671c4f821a4d63904d0da15d604b75@huawei.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/fib_rules.h |  2 ++
>  include/net/flow.h      |  1 +
>  include/net/l3mdev.h    | 27 +++++++++++++++++++++++
>  net/core/fib_rules.c    | 48 ++++++++++++++++++++++++++++++++++-------
>  net/l3mdev/l3mdev.c     |  4 +++-
>  5 files changed, 73 insertions(+), 9 deletions(-)
> 

Acked-by: David Ahern <dsahern@kernel.org>



