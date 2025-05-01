Return-Path: <netdev+bounces-187285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B1AA6184
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824BA3AEA6F
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B120B807;
	Thu,  1 May 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6uVooMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AE210185
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117666; cv=none; b=S8LPunRgrtufHB+X6zseaLAkT5r7zlMbEpgVgH2MqEYM6IGrz1KHTjcbsEpt21X7oDHRiqc96Xe6wuSqviv3m76YlMkePH5/p+ZmDVwzveY9P8Eo6ohkqMSlow6Jz9/FIOdJ+gUqdAnXyN4IY8HR96HUdioeiXYhZ9wourIfrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117666; c=relaxed/simple;
	bh=SPnvySXbVUBiAbIopkMehPsgINDvwqvsmXCTbzkBPhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/mzJBBRd0cDF+Hvjaub87icUBbPGz5fvvf7CyeGT17oq2RdImoiNcWhZaW3qyxD2+CeQOiFZ1edup/uWb/VTZkOnyK73dZRuSfvRIT3ffRF9ne+SgbCdjLUrmrBL79PLZaw0zo0xL1dOHmkxDu8i4zhL5l6lacSEwyjVnde/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6uVooMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B7DC4CEE3;
	Thu,  1 May 2025 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746117665;
	bh=SPnvySXbVUBiAbIopkMehPsgINDvwqvsmXCTbzkBPhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s6uVooMG3D+msAWCrdvQ9Kd0EIAVzF978j/H8tnHnStbAifyiDCa8qY4ERti6NQEx
	 Vaq54s3KKtmHSORD5giR5M4oaz2ODVdqQaBazqM/+Hjxro8PNp85LIMIiEQ3xuJQ2K
	 klbrYzvAEgTDk6iIdaC7Q3k8Qf5vAPWNZJ0M4+LSJKKfqt9ZAVvkEG018POXRw/Kak
	 q1XyRbpLm+7ekV40P6JtOnieq21azoNJARm7TGN0t1aVwdTjkN3JTEyHHPTYZPxPXi
	 1cc2Vhp8TzW5oBSrqmi5b/zu2R2LLSFPw/h3MeDlBf+e7y7e2NEW7d+PynX6S/yc+Y
	 4+sYb1UuMauHg==
Message-ID: <0ff4819f-56af-407c-b5ab-79ecc77e4d6d@kernel.org>
Date: Thu, 1 May 2025 10:41:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: Honor "ignore_routes_with_linkdown" sysctl
 in nexthop selection
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemb@google.com
References: <20250430100240.484636-1-idosch@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250430100240.484636-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 4:02 AM, Ido Schimmel wrote:
> Commit 32607a332cfe ("ipv4: prefer multipath nexthop that matches source
> address") changed IPv4 nexthop selection to prefer a nexthop whose
> nexthop device is assigned the specified source address for locally
> generated traffic.
> 
> While the selection honors the "fib_multipath_use_neigh" sysctl and will
> not choose a nexthop with an invalid neighbour, it does not honor the
> "ignore_routes_with_linkdown" sysctl and can choose a nexthop without a
> carrier:
> 
>  $ sysctl net.ipv4.conf.all.ignore_routes_with_linkdown
>  net.ipv4.conf.all.ignore_routes_with_linkdown = 1
>  $ ip route show 198.51.100.0/24
>  198.51.100.0/24
>          nexthop via 192.0.2.2 dev dummy1 weight 1
>          nexthop via 192.0.2.18 dev dummy2 weight 1 dead linkdown
>  $ ip route get 198.51.100.1 from 192.0.2.17
>  198.51.100.1 from 192.0.2.17 via 192.0.2.18 dev dummy2 uid 0
> 
> Solve this by skipping over nexthops whose assigned hash upper bound is
> minus one, which is the value assigned to nexthops that do not have a
> carrier when the "ignore_routes_with_linkdown" sysctl is set.
> 
> In practice, this probably does not matter a lot as the initial route
> lookup for the source address would not choose a nexthop that does not
> have a carrier in the first place, but the change does make the code
> clearer.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/fib_semantics.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


