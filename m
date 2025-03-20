Return-Path: <netdev+bounces-176484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF8EA6A854
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592758A5DD5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE47D224B08;
	Thu, 20 Mar 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m86pC5+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9254224AFA
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480428; cv=none; b=FeX+oLY8k4rnA3HlFrLzx0+sD7xidtQAth/IFvRn5ljkyCQpGkOp/I9DQ0gP4GKWmKIM7s2axRcMLJk4doMUdM7eZac02ZVE0HJujcdGFKAE3H3it1Ha0jQSwAWPpqQ5aNNT9+5OevJavLbJWBUrbR4io6ZwD7jlpIDgLiQI/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480428; c=relaxed/simple;
	bh=SQ0smgJRqur3lcIOPt1ZS2IR4uA3vd59iRnBPQ+egxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHeusLUUnaRrdur5bDt3Qnu+X3fKmRjDV+rWuRPrbpYI0nToTDBT4IrJY4OTqK4jjVDyBJ6A2e9zkmFZNL1g0KXjaWJRfWRBuFYUKzd727pkDTaraSiHtPExHq4hn8dKmzvhYBDsUp0RtmdesDiDkMKrzhJB/SNQ3VuZlIvKO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m86pC5+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE82C4CEE8;
	Thu, 20 Mar 2025 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480428;
	bh=SQ0smgJRqur3lcIOPt1ZS2IR4uA3vd59iRnBPQ+egxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m86pC5+0ATFI1hU0xy8dSMvMkD8YiiqwZOHZAAwD1JKKIT7pEVZkfODgo6Wxhpoot
	 AWDoTj0NGOz/OxjRNtSvs6ncSdGIElEH0D3n6Q656TDKXu/k14pEVm+Yw54etyDgYR
	 +8PmfezyIdwFcflHsf/Me+QUNUcxiCxXh3QcoAdcyrxwwrOSjaip9bMT/z6He2j8m7
	 rylvIZgXrZdCuVtf2akFH6zSI9s1w4DcR32bXZo1gKP/tHjMn2ETZsLYnJvt1HgDXR
	 33sTapxToqG/8pKd9Rgizak9mZ4A92yEV7uM3InJAo7+0Na5gr0sLvOJ+orSLuaHDA
	 OIm4D5o9oj2IQ==
Message-ID: <ba5f2eac-8151-4257-910b-e18b9716362b@kernel.org>
Date: Thu, 20 Mar 2025 08:20:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/7] nexthop: Move NHA_OIF validation to
 rtm_to_nh_config_rtnl().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-4-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> NHA_OIF needs to look up a device by __dev_get_by_index(),
> which requires RTNL.
> 
> Let's move NHA_OIF validation to rtm_to_nh_config_rtnl().
> 
> Note that the proceeding checks made the original !cfg->nh_fdb
> check redundant.
> 
>   NHA_FDB is set           -> NHA_OIF cannot be set
>   NHA_FDB is set but false -> NHA_OIF must be set
>   NHA_FDB is not set       -> NHA_OIF must be set
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



