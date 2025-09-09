Return-Path: <netdev+bounces-221359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49219B504A5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BC73B5D0C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE3D31C587;
	Tue,  9 Sep 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLKZtB7a"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474F17A300
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440066; cv=none; b=ld+aEp5n6vqIiwhZtmK2nobBVPEg80fX0tz5BSRUmd3zkTGV1OyHwnuHgAhm1cCMsBgQqBwhAqBvTm7U1jeTrtfUzSH8/3iY55794oWusiP0sz/Idy0lYI2Q+x2BfuHZUeN4xJSizpeqjRgjz9o8McZq+bTEh5Pn9nBgmgRL/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440066; c=relaxed/simple;
	bh=Mj/3qD80kpBpCdG432x6WzYa9daR72pLSMUczhnpzGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNxtUcPBtpb1QUZK1j0lTJLqCEaSC2jKkV3gtI1hc2P87fsZpcQPyDmmkCIXKoiZxJ7COYW0myZwsd2/+MnUjwTPMCpxgC/iXHa0zUK/B5PGq9gMK5Ih3k6q66FxCoahOQO+JC2IDbCI7Pauq3HAdVb6e0qiZ4iGzTdrsE/nGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLKZtB7a; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8d870d3-fec8-4e1d-a54e-3ced427bf55b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757440060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYfq2OcNr1565up+43sEyltVeF93Ja3jqCk+Ftve/6E=;
	b=JLKZtB7aMPzldGwjJhQingJa5WAH+hv+uAddSnW7zLsQR2S1t75hSa0o4RsRbz5DqUZeri
	EyJlH4QeDnQsk32B0WUAlEr3KLMtIaiYT9hAKAoMsG7duoiUEex4CMvQcf8EqlEGfz/mAA
	42Q7aBoFhTIMUTGJMMNov4UfhWZ9Z6o=
Date: Tue, 9 Sep 2025 10:47:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>, Xiumei Mu <xmu@redhat.com>
References: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/25/25 5:50 AM, Sabrina Dubroca wrote:
> Xiumei reported a regression in IPsec offload tests over xfrmi, where
> IPv6 over IPv4 tunnels are no longer offloaded after commit
> cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> implementation").
>
> Commit cc18f482e8b6 added a generic version of existing checks
> attempting to prevent packets with IPv4 options or IPv6 extension
> headers from being sent to HW that doesn't support offloading such
> packets. The check mistakenly uses x->props.family (the outer family)
> to determine the inner packet's family and verify if
> options/extensions are present.
>
> In the case of IPv6 over IPv4, the check compares some of the traffic
> class bits to the expected no-options ihl value (5). The original
> check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
> Innova IPSec offload TX data path"), and then duplicated in the other
> drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
> because those traffic class bits were not set to a value that
> triggered the no-offload codepath. Packets with options/extension
> headers that should have been handled in SW went through the offload
> path, and were likely dropped by the NIC or incorrectly
> processed. Since commit cc18f482e8b6, the check is now strict (ihl !=
> 5), and in a basic setup (no traffic class configured), all packets go
> through the no-offload codepath.
>
> The commits that introduced the incorrect family checks in each driver
> are:
> 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> 8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
> 859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
> 32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
> [ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
> mode, thus no cross-family setups are possible]
>
> Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks. I applied this commit and made tests in my local hosts. I can 
confirm that ipv6 over ipv4 packets can be offloaded into HW. About 
replacing props with inner_mode, I am fine with it.

Thus,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   net/xfrm/xfrm_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index c7a1f080d2de..44b9de6e4e77 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>   
>   	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
>   			    x->props.mode == XFRM_MODE_TUNNEL;
> -	switch (x->props.family) {
> +	switch (x->inner_mode.family) {
>   	case AF_INET:
>   		/* Check for IPv4 options */
>   		if (ip_hdr(skb)->ihl != 5)

