Return-Path: <netdev+bounces-172413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE0A5480C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D91173971
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D920A5C2;
	Thu,  6 Mar 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tzM5r4HY"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FB18A6B5
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257555; cv=none; b=n26XhwNwrSTEia6c//sCygEEoYfyDctBR81fPudJhyD/HTwKWTsCU35ZBvLxWpa//QoHIXr2al3ceJAWljksm5Ap1x7aY6dEUYg95/8fsXTD+0RMbCVHEJBYZM82ByJ7FHJvUuQr+2NQo73/EC0bRecMG2vo1fsN0PKfOg0np7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257555; c=relaxed/simple;
	bh=XoEY1soOodVF6JjtM1YA01cLzG6rbE6ImGLVAFhBFMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0cKccGalMiIRXpTSLvCvOWF36JYgOKD9rsiQhiwZxtWd3v9NRF+IW0OgHtGkEyJfkq92N9bbQZw1OsLQPTI0/jUG90HAtjxt/sgga6po6KGEuxSFOyTgS37TsSnPOPesETIpHztwrura3g2YgIW4LTXdYTxSTCcT/1mfp+hTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tzM5r4HY; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb1ee266-4b2f-4c6f-a728-2d39469a7855@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741257540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzZ1/UTKo+vdwqq530EncHXy2nYHETwmi3muumMefWw=;
	b=tzM5r4HYSMpcv81tduO3Z1Ky51f7J1lwPAMf4w32lUOV/+KLNY54jeAu9z3tN87akAZ+Us
	mtNJYB/88YIojOqHdlxV2OTkjrEBOo9GZE5g0CJo4T6by6QYigWaGof8ii08Zb/GHbRQ7E
	Qu2vGvOVM+9aezwlYvM00rKdabZ1xQE=
Date: Thu, 6 Mar 2025 10:38:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ethtool: tsinfo: Fix dump command
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250305140352.1624543-1-kory.maincent@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250305140352.1624543-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/03/2025 14:03, Kory Maincent wrote:
> Fix missing initialization of ts_info->phc_index in the dump command,
> which could cause a netdev interface to incorrectly display a PTP provider
> at index 0 instead of "none".
> Fix it by initializing the phc_index to -1.
> 
> In the same time, restore missing initialization of ts_info.cmd for the
> IOCTL case, as it was before the transition from ethnl_default_dumpit to
> custom ethnl_tsinfo_dumpit.
> 
> Fixes: b9e3f7dc9ed95 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>   net/ethtool/tsinfo.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index 691be6c445b38..9edc5dc30de88 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -291,6 +291,8 @@ static void *ethnl_tsinfo_prepare_dump(struct sk_buff *skb,
>   	memset(reply_data, 0, sizeof(*reply_data));
>   	reply_data->base.dev = dev;
>   	memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info));
> +	reply_data->ts_info.cmd = ETHTOOL_GET_TS_INFO;
> +	reply_data->ts_info.phc_index = -1;

This change makes sense, but I'm curious why do we need
memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info))
at all? ts_info is embedded into reply_data which fully zeroed 2 lines
before.

>   
>   	return ehdr;
>   }


