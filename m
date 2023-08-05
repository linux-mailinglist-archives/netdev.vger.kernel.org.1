Return-Path: <netdev+bounces-24630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93368770E46
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965261C20B15
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51213D82;
	Sat,  5 Aug 2023 07:07:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289620F9
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21463C433C7;
	Sat,  5 Aug 2023 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691219254;
	bh=l/hkjP/u+NI/cILXTP4zyOL3JgMXsdwmGgFmfGGWzNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8Vto4rzERi1ASF1y/RMcGP14YgUfPTN4iFuHpvpRLQtrnsospzAZf9XoYWznQGqI
	 f1el3XQOcJ5/8dLOYzMdmx9rAYgchZW/Um1kUI4CYvTcrQ4hXbER4uC9csq19aC3G9
	 +8E5x/HSEOSRAG3PkAoFGirCrOZN8maR61XOUEMsUqnTXia621/Cx6lCopX2wGZNMy
	 4DEK0vFddVCgzavu/AF1kIxF2wDHH4G4iNeFKTNM8YaGGi172pRo5mtK7F7r1EONZQ
	 VH16+U48jiSeE1sCzhoj8HIwCYTS6rTxYrUQCDjV3B4KKyDJy/NR8VyP7zXlACCI54
	 RBxCYA0CcIgnA==
Date: Sat, 5 Aug 2023 09:07:30 +0200
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, sbrivio@redhat.com,
	"David S. Miller" <davem@davemloft.net>, dsahern@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	shuah@kernel.org
Subject: Re: [PATCH net 1/2] tunnels: fix kasan splat when generating ipv4
 pmtu error
Message-ID: <ZM31Mnl3yhYLMouc@vergenet.net>
References: <20230803152653.29535-1-fw@strlen.de>
 <20230803152653.29535-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803152653.29535-2-fw@strlen.de>

On Thu, Aug 03, 2023 at 05:26:49PM +0200, Florian Westphal wrote:
> If we try to emit an icmp error in response to a nonliner skb, we get
> 
> BUG: KASAN: slab-out-of-bounds in ip_compute_csum+0x134/0x220
> Read of size 4 at addr ffff88811c50db00 by task iperf3/1691
> CPU: 2 PID: 1691 Comm: iperf3 Not tainted 6.5.0-rc3+ #309
> [..]
>  kasan_report+0x105/0x140
>  ip_compute_csum+0x134/0x220
>  iptunnel_pmtud_build_icmp+0x554/0x1020
>  skb_tunnel_check_pmtu+0x513/0xb80
>  vxlan_xmit_one+0x139e/0x2ef0
>  vxlan_xmit+0x1867/0x2760
>  dev_hard_start_xmit+0x1ee/0x4f0
>  br_dev_queue_push_xmit+0x4d1/0x660
>  [..]
> 
> ip_compute_csum() cannot deal with nonlinear skbs, so avoid it.
> After this change, splat is gone and iperf3 is no longer stuck.

Hi Florian,

I wonder if there are other cases lurking elsewhere.
Did you happen to take a look at that?

> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/ipv4/ip_tunnel_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index 92c02c886fe7..586b1b3e35b8 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -224,7 +224,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
>  		.un.frag.__unused	= 0,
>  		.un.frag.mtu		= htons(mtu),
>  	};
> -	icmph->checksum = ip_compute_csum(icmph, len);
> +	icmph->checksum = csum_fold(skb_checksum(skb, 0, len, 0));
>  	skb_reset_transport_header(skb);
>  
>  	niph = skb_push(skb, sizeof(*niph));
> -- 
> 2.41.0
> 
> 

