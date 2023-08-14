Return-Path: <netdev+bounces-27255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE277B2EA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483C42810B9
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083299475;
	Mon, 14 Aug 2023 07:47:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921A1842
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D984DC433C9;
	Mon, 14 Aug 2023 07:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691999258;
	bh=0y793H3I4BK8p+u3GKMRtNRtgi9gKBbMk/M+EqYlum0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpu8LQxO5OwxGIZW+gMqCKaU07BKlk37pK+F/rgP99SpGk6xmwEuTO4hHuCxW2anX
	 1siPAZfVVDtJ2BVm/aI4na/NUW7LWUlSCuVWatkNSqA+umf13xsR8DITR+DpHTIJXA
	 Yzuu66V+JjrIcZam2oMtIBjmoGzhXNEnTqLVjAsdLCujlIaJ+cDQ6LAOfku+ISxKFb
	 6Uc2kZ3ZBbpS5NftuqIs2PccVloA36a8Pw0UGstbzm9IH92iJiPZD8maR562ilTjcI
	 1ty79yPCG8JOorYUzSZa5lvXSl2jc+58/5iE2UZH1WfWbc+l3qnIfnKRmXC3B+H5ww
	 vDnazbhK2hKIA==
Date: Mon, 14 Aug 2023 09:47:34 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ethernet: rocker: Use is_broadcast_ether_addr()
 and is_multicast_ether_addr() instead of ether_addr_equal()
Message-ID: <ZNncFhibJLTLr5Q6@vergenet.net>
References: <20230814022948.2019698-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814022948.2019698-1-ruanjinjie@huawei.com>

On Mon, Aug 14, 2023 at 10:29:48AM +0800, Ruan Jinjie wrote:
> Use is_broadcast_ether_addr() and is_multicast_ether_addr() instead of
> ether_addr_equal() to check if the ethernet address is broadcast
> and multicast address separately.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Hi,

Perhaps we could go for a more concise prefix and subject, as the current one
is rather long. Maybe something like:

Subject: [PATCH net-next]: rocker: Use helpers to check broadcast and multicast Ether addresses

> ---
>  drivers/net/ethernet/rocker/rocker_ofdpa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> index 826990459fa4..7f389f3adbf4 100644
> --- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
> +++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> @@ -208,7 +208,6 @@ static const u8 zero_mac[ETH_ALEN]   = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>  static const u8 ff_mac[ETH_ALEN]     = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
>  static const u8 ll_mac[ETH_ALEN]     = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
>  static const u8 ll_mask[ETH_ALEN]    = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xf0 };
> -static const u8 mcast_mac[ETH_ALEN]  = { 0x01, 0x00, 0x00, 0x00, 0x00, 0x00 };
>  static const u8 ipv4_mcast[ETH_ALEN] = { 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
>  static const u8 ipv4_mask[ETH_ALEN]  = { 0xff, 0xff, 0xff, 0x80, 0x00, 0x00 };
>  static const u8 ipv6_mcast[ETH_ALEN] = { 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
> @@ -939,7 +938,7 @@ static int ofdpa_flow_tbl_bridge(struct ofdpa_port *ofdpa_port,
>  	if (eth_dst_mask) {
>  		entry->key.bridge.has_eth_dst_mask = 1;
>  		ether_addr_copy(entry->key.bridge.eth_dst_mask, eth_dst_mask);
> -		if (!ether_addr_equal(eth_dst_mask, ff_mac))
> +		if (!is_broadcast_ether_addr(eth_dst_mask))

Probably it is ok, but is_broadcast_ether_addr()
covers a set of addresses that includes ff_mac.

>  			wild = true;
>  	}
>  
> @@ -1012,7 +1011,7 @@ static int ofdpa_flow_tbl_acl(struct ofdpa_port *ofdpa_port, int flags,
>  
>  	priority = OFDPA_PRIORITY_ACL_NORMAL;
>  	if (eth_dst && eth_dst_mask) {
> -		if (ether_addr_equal(eth_dst_mask, mcast_mac))
> +		if (is_multicast_ether_addr(eth_dst_mask))

Likewise, is_multicast_ether_addr()
covers a set of addresses that includes mcast_mac.

>  			priority = OFDPA_PRIORITY_ACL_DFLT;
>  		else if (is_link_local_ether_addr(eth_dst))
>  			priority = OFDPA_PRIORITY_ACL_CTRL;
> -- 
> 2.34.1
> 
> 

