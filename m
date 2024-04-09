Return-Path: <netdev+bounces-85955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0F89D04B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AF11C23DD7
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F44EB5E;
	Tue,  9 Apr 2024 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRaSbQDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB44E1DA
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628937; cv=none; b=oKmgmqW1DFfJ28y/Vtsc60vS/WtueIr3D51lwsbBIBDZK50vAVkVWwfLpWEbVZp/wcVsJ/wsK4Kt4kM0sX7Hyg+0Y5BuNawjyf3So//3fG+gVmPQlz4bc1neZdvkHsXpO1gSDKv3gpACrtiNAZSCU/Sb3X389wV4GHbXaS0HAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628937; c=relaxed/simple;
	bh=2dmZqWjVOEeA0AD6yQ2XB6p7k0GFdbWMB2e/ounow+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axIIzS9GBNZBhxuP0aI6yD8k7JAjkJtD84o5mLSEGrZGi2A6P1aJdvf/787wPv2fCp9O6UTQnwq9MIWBV9ZqDC718rZHnfEgmz/pB/a1rA4Jcnj/RYVZPTlNh2EwF5LcLZcSAX7sdmhvydnff49mAuleoUez70JKRM84V2VFeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRaSbQDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A0CC433C7;
	Tue,  9 Apr 2024 02:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712628936;
	bh=2dmZqWjVOEeA0AD6yQ2XB6p7k0GFdbWMB2e/ounow+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRaSbQDTNnQCTKnNoPyMs73zKn+yaxL7dTZE40/9W+nJqcwF+WWS4m+wvbv3Tclq1
	 eVe3ZdZjFlh6wsJuR26845iKHauQW/YLSfsKd44jTX5xmDzt99ebkMHZPC4r3M2Asm
	 XlFUFg1SZ5CtDtKSmnOyaYZRtIyaZlQOjhVERid+zYMAcpKnlMJgM7EY+7XIKgxmjM
	 Wj4ZLkmTVj6fJS//KzpuScb+c3C2MsccROD2F0Bla+9W5oaTXQEqJ8YQpRsSNAjG5k
	 aSlom4+sEpVOZ196y4YCoDE+xYiK+YJxNmq5hquffavnXY4NGJ9Fi0Rs9Yun6cQqZo
	 2S4guFW+BuBCg==
Date: Mon, 8 Apr 2024 19:15:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 <devel@linux-ipsec.org>, Tobias Brunner <tobias@strongswan.org>
Subject: Re: [PATCH net 1/1] xfrm: fix source address in icmp error
 generation from IPsec gateway
Message-ID: <20240408191534.2dd7892d@kernel.org>
In-Reply-To: <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
References: <cover.1712226175.git.antony.antony@secunet.com>
	<20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 12:31:56 +0200 Antony Antony wrote:
> export AB="10.1"
> for i in 1 2 3 4 5; do
>         h="host${i}"
>         ip netns add ${h}
>         ip -netns ${h} link set lo up
>         ip netns exec ${h} sysctl -wq net.ipv4.ip_forward=1
>         if [ $i -lt 5 ]; then
>                 ip -netns ${h} link add eth0 type veth peer name eth10${i}
>                 ip -netns ${h} addr add "${AB}.${i}.1/24" dev eth0
>                 ip -netns ${h} link set up dev eth0
>         fi
> done
> 
> for i in 1 2 3 4 5; do
>         h="host${i}"
>         p=$((i - 1))
>         ph="host${p}"
>         # connect to previous host
>         if [ $i -gt 1 ]; then
>                 ip -netns ${ph} link set eth10${p} netns ${h}
>                 ip -netns ${h} link set eth10${p} name eth1
>                 ip -netns ${h} link set up dev eth1
>                 ip -netns ${h} addr add "${AB}.${p}.2/24" dev eth1
>         fi
>         # add forward routes
>         for k in $(seq ${i} $((5 - 1))); do
>                 ip -netns ${h} route 2>/dev/null | (grep "${AB}.${k}.0" 2>/dev/null) || \
>                 ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${i}.2" 2>/dev/nul
>         done
> 
>         # add reverse routes
>         for k in $(seq 1 $((i - 2))); do
>                 ip -netns ${h} route 2>/dev/null | grep "${AB}.${k}.0" 2>/dev/null || \
>                 ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${p}.1" 2>/dev/nul
>         done
> done
> 
> ip netns exec host1 ping -q -W 2 -w 1 -c 1 10.1.4.2 2>&1>/dev/null && echo "success 10.1.4.2 reachable" || echo "ERROR"
> ip netns exec host1 ping -W 9 -w 5 -c 1 10.1.4.3 || echo  "note the source address of unreachble of gateway"
> ip -netns host1 route flush cache
> 
> ip netns exec host3 nft add table inet filter
> ip netns exec host3 nft add chain inet filter FORWARD { type filter hook forward priority filter\; policy drop \; }
> ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol icmp drop
> ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol esp accept
> ip netns exec host3 nft add rule inet filter FORWARD counter drop
> 
> ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
>         flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel
> 
> ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir in \
>         tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel
> 
> ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir fwd \
>         flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel
> 
> ip -netns host2 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
>         reqid 1 replay-window 1  mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x1111111111111111111111111111111111111111 96 \
>         sel src 10.1.1.0/24 dst 10.1.4.0/24
> 
> ip -netns host2 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
>         flag icmp reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x2222222222222222222222222222222222222222 96
> 
> ip -netns host4 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir out \
>         flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 1 mode tunnel
> 
> ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir in \
>         tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2  mode tunnel
> 
> ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir fwd \
>                 flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2 mode tunnel
> 
> ip -netns host4 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
>         reqid 1 replay-window 1 mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x2222222222222222222222222222222222222222 96
> 
> ip -netns host4 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
>         reqid 2 replay-window 20 flag icmp  mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x1111111111111111111111111111111111111111 96 \
>         sel src 10.1.1.0/24 dst 10.1.4.0/24
> 
> ip netns exec host1 ping -W 5 -c 1 10.1.4.2 2>&1 > /dev/null && echo ""
> ip netns exec host1 ping -W 5 -c 1 10.1.4.3 || echo "note source address of gateway 10.1.3.2"

Could you turn this into a selftest?

