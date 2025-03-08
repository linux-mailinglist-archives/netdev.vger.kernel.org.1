Return-Path: <netdev+bounces-173164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D28A57982
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B8F18911D3
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935318C32C;
	Sat,  8 Mar 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aj1c93O7"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C682CAB
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426429; cv=none; b=brgntnw7k7iA+ZHRbQl6EiEvVPIeK9NGccFLs72OMLEFd/IposVYgWE+DGJpuEw7zSk75BPK2Jk5tx5MDIz3tJ9wh/1pc6qouIy3o1dZpyEDwAm45+1F67zYF9+T4OaadjvKOVMXRHc5E9VisrUyT63JQdHYwU+l9/tuqsGfW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426429; c=relaxed/simple;
	bh=8JRWEPkcbZU8KQBQuODDmLBLljt+c0ZfuR22i+u1KbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkUS15lTuROSYD3alEH4uO1GWHAMlayas3CgbgoyJRGt5Co2a27BE3iml0k4LEVso/3/KtNX5myEXzocxw9sdxHySIPO+bkB4lraEP+W8pWIkEvFfVQWkwXolf2boyeJLyJH+j7dpZLS8Gw6MnTBggZ7cAncxXix6m5qqFBHmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aj1c93O7; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <051c66d5-2751-4dfb-88df-3a4a1f86bb71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741426424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcLw7shfI50Q27EtBRTL5tYuszmcD8BPa3jzuj4PVWg=;
	b=Aj1c93O7sRk8dZswKp03dAiwaVDyWRxUNH46JEXG7l+hSjozmiJRw5zpy4ygt29cezv+ul
	STWQ6Hv9r93RqBSByly80mST8NWfh02kVvRubeWM2uu9RhCJPgo7HYrdtIaEYb34NBlrnX
	4Wbm1UmZIQ7CDJxRI+m8RKrryB8FRyQ=
Date: Sat, 8 Mar 2025 09:33:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: ethtool: tsinfo: Fix dump command
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307091255.463559-1-kory.maincent@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250307091255.463559-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/03/2025 09:12, Kory Maincent wrote:
> Fix missing initialization of ts_info->phc_index in the dump command,
> which could cause a netdev interface to incorrectly display a PTP provider
> at index 0 instead of "none".
> Fix it by initializing the phc_index to -1.
> 
> In the same time, restore missing initialization of ts_info.cmd for the
> IOCTL case, as it was before the transition from ethnl_default_dumpit to
> custom ethnl_tsinfo_dumpit.
> 
> Also, remove unnecessary zeroing of ts_info, as it is embedded within
> reply_data, which is fully zeroed two lines earlier.
> 
> Fixes: b9e3f7dc9ed95 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Remove useless zeroed of ts_info.
> ---
>   net/ethtool/tsinfo.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index 691be6c445b38..ad3866c5a902b 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -290,7 +290,8 @@ static void *ethnl_tsinfo_prepare_dump(struct sk_buff *skb,
>   	reply_data = ctx->reply_data;
>   	memset(reply_data, 0, sizeof(*reply_data));
>   	reply_data->base.dev = dev;
> -	memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info));
> +	reply_data->ts_info.cmd = ETHTOOL_GET_TS_INFO;
> +	reply_data->ts_info.phc_index = -1;
>   
>   	return ehdr;
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

