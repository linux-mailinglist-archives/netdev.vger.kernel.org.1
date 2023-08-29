Return-Path: <netdev+bounces-31134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358478BCFC
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 04:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30601C20994
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A22A44;
	Tue, 29 Aug 2023 02:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14997EC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 02:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE258C433C7;
	Tue, 29 Aug 2023 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693277066;
	bh=12Tjw7tG7dL1mz2s20vN7qBFSnVgo76Z5LvZt0hGtSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZSMm8RofdIq9mhsJ4nBFA3VO46K+Kb/tLOL8vqVTu6ZCFb+V5o4/B4/pmN6Wwu4h1
	 QcuriqL5B7mrKKIftPgk1dck+tRE3c2GwlPoIpvWeBpP0507TiIyGeC6DZZhfvaZ+K
	 JOmLB5BUFh26YzOWt4w4Br0XmgAxEbCblUXkjHjbLcYZ7B6/nNKjRalOczoqGuNrOo
	 Hf11xBqLN/pID9HvJICo5Dnes3FkTwum/HKLtzp31rSBTMwEb2iDzDESBdgw0LaotF
	 jHRZeaBageTAfmIs0euZi+CdB0zv0iOnkTaN1lgXDrZz8zdPNSDK2v5mPemadn8zwe
	 MuWlSYbRsuy1A==
Message-ID: <cdc2183a-c79a-b4bd-2726-bd3a2d6d5440@kernel.org>
Date: Mon, 28 Aug 2023 20:44:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] ipv6: mcast: Remove redundant comparison in
 igmp6_mcf_get_next()
Content-Language: en-US
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
 "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230828111604.583371-1-Ilia.Gavrilov@infotecs.ru>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828111604.583371-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 5:18 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
>  net/ipv6/mcast.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 714cdc9e2b8e..9696343d0aa9 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -3013,8 +3013,6 @@ static struct ip6_sf_list *igmp6_mcf_get_next(struct seq_file *seq, struct ip6_s
>  				continue;
>  			state->im = rcu_dereference(state->idev->mc_list);
>  		}
> -		if (!state->im)
> -			break;
>  		psf = rcu_dereference(state->im->mca_sources);
>  	}
>  out:

agree the check is not needed, but I also believe it does not need to be
backported. Since net-next is closed, resubmit after 9/11.

--
pw-bot: defer

