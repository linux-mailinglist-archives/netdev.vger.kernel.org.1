Return-Path: <netdev+bounces-114991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF48944D9F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD131F23A3C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD251A3BDC;
	Thu,  1 Aug 2024 14:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E361FF2;
	Thu,  1 Aug 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521210; cv=none; b=bSisHixGbukIhqD3U1x7i1TdwRREgcMLZ5cOlHPIFf1uWnmPyPhx5D1+sFnAwUHOcPGxe1CFsVB1JClGXZMUrgRlLKE4GyTrDQD2G6d3BIpIQNFFJGcOeCil8hKSTzKXD14ELNqprKDO1/YZ6GNtbz8O3AybW23HlFFGCsR2GBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521210; c=relaxed/simple;
	bh=2SY/g90szcAY8OrYEbdVRqsEVF5Yq8RbvesWbQ7ob3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih0CC+8PORKXJMGEEf4yDY7u+Y0xKZr3PYbGbHpB/Px1L1vVboZ4bUMrR69sEcHM0WoAv68yDxb3J+NN6fGJ4vRV7COUlTdjchJfU/veQRcd32jNAdHEWEcmeTnmQpWeRJyrELhcQ1t8ri8Hzz8rjHROxtXNMOyGbmQMc0MO3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sZWRt-0000qM-5i; Thu, 01 Aug 2024 16:06:33 +0200
Date: Thu, 1 Aug 2024 16:06:33 +0200
From: Florian Westphal <fw@strlen.de>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] e1000e: use ip_hdrlen() instead of bit shift
Message-ID: <20240801140633.GA2680@breakpoint.cc>
References: <20240801134709.1737190-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801134709.1737190-2-yyyynoom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Moon Yeounsu <yyyynoom@gmail.com> wrote:
> There's no reason to use bit shift to find the UDP header.
> It's not intuitive and it reinvents well-defined functions.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 360ee26557f7..07c4cf84bdf3 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5731,7 +5731,7 @@ static int e1000_transfer_dhcp_info(struct e1000_adapter *adapter,
>  		if (ip->protocol != IPPROTO_UDP)
>  			return 0;
>  
> -		udp = (struct udphdr *)((u8 *)ip + (ip->ihl << 2));
> +		udp = (struct udphdr *)((u8 *)ip + ip_hdrlen(skb));

This helper needs skb_network_header being set up correctly, are you
sure thats the case here?  ip pointer is fetched via data + 14 right
above, so it doesn't look like this would work.

