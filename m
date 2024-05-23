Return-Path: <netdev+bounces-97901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CDE8CDCCA
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 00:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BCAB245AD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FE127E2A;
	Thu, 23 May 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPJIKMde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A582D9A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501843; cv=none; b=f0RcUk6cnq5zwfoj5iPb7TIJzZv57abElrsFZIpaauGjhZ3ha14EXzmn+DtTjTj+S1UOnoxKE8yqi1CxYSoO9KuoqleXevs7KP2+3ok9YvKWo4qOu/m6viZhE/lMBc8rO+lNhD0W4q3eo+Qc/EzG/haBuUyDLMXfjGkznQ01mbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501843; c=relaxed/simple;
	bh=HTH2jakz37U4u0DaNNY7z9GvRtfz7vhS0OteA6vRWbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M41f6mtYeTc3QowLFnCnGTTZG+ZNea322lJJVwEa3Xf/SQetfY6wukO5Yv4hH36z63TmgyOPzhISasR12roMbs0oklMa6MWRhfdAv6hctnbkVmqpzrfcgONmH+dbWTRWB720+Fj763GbltTxcBBhJ1U9lD75sHvgRC6LNuCHfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPJIKMde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9073C2BD10;
	Thu, 23 May 2024 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716501842;
	bh=HTH2jakz37U4u0DaNNY7z9GvRtfz7vhS0OteA6vRWbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sPJIKMdenFPXAng75McLTwLC62HqNOVgeB44D/wlv8u+cDGL4r/oQAjSaHBHkbsic
	 fH97FnssF9yQRIzwp3F2BtIM/pLXeyex9+mZXWtSs2ZLmp3dldeAMbfPRikVC0CNbx
	 hIJCVaEYkpiD44tBDVM3fhd26uNe2mpo9ugLgr7ADa79SOtOmAtVp/B02zrKIFmImL
	 paE8r2vw9eJRM1zDBYxHlhoDkN+44xHuVwJ19HWJkijLTUfEklXEC70MCeTFwN3Ao7
	 6Gdiv5n5L6RiXghDFhxGgIoXH/LZtw+ktVMaFk/Df83ku6qEIOnCVDQjhwasm8pMOK
	 XF1TLiJGolYUA==
Message-ID: <a470cca2-4e51-484d-af42-a04684a9bd32@kernel.org>
Date: Thu, 23 May 2024 16:04:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: Fix address dump when IPv4 is disabled on an
 interface
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, cjubran@nvidia.com, ysafadi@nvidia.com
References: <20240523110257.334315-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240523110257.334315-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 5:02 AM, Ido Schimmel wrote:
> Cited commit started returning an error when user space requests to dump
> the interface's IPv4 addresses and IPv4 is disabled on the interface.
> Restore the previous behavior and do not return an error.
> 
> Before cited commit:
> 
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::e040:68ff:fe98:d018/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
> 
> After cited commit:
> 
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether 32:2d:69:f2:9c:99 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::302d:69ff:fef2:9c99/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  RTNETLINK answers: No such device
>  Dump terminated
> 
> With this patch:
> 
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether de:17:56:bb:57:c0 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::dc17:56ff:febb:57c0/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether de:17:56:bb:57:c0 brd ff:ff:ff:ff:ff:ff
> 
> I fixed the exact same issue for IPv6 in commit c04f7dfe6ec2 ("ipv6: Fix
> address dump when IPv6 is disabled on an interface"), but noted [1] that
> I am not doing the change for IPv4 because I am not aware of a way to
> disable IPv4 on an interface other than unregistering it. I clearly
> missed the above case.
> 
> [1] https://lore.kernel.org/netdev/20240321173042.2151756-1-idosch@nvidia.com/
> 
> Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
> Reported-by: Carolina Jubran <cjubran@nvidia.com>
> Reported-by: Yamen Safadi <ysafadi@nvidia.com>
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/devinet.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



