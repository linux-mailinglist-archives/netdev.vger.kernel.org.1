Return-Path: <netdev+bounces-96386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591818C5888
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB771F22287
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7C17EB81;
	Tue, 14 May 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNl5I8Oc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F712B177;
	Tue, 14 May 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699623; cv=none; b=HYTB6EvyeiCZ7OK8+MnFLtMJkYyu0Wz7bxCljpf46VOolGvrT/oTtiikwJdWnXvbK7gY6EPd7p/+j93F7QwwPdFfCfKcUWVvloBKylb1ly3TsJr4SiiEB5x5tbgDOsn0YPUW/z44bDCGiA+HNIqPnJPUkN9VK2bqMG/dId3IV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699623; c=relaxed/simple;
	bh=EihJtzlA6mfpqd02t2ulG1Tfdp9EZ0d2PsknBA2nYeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZ34IaICP0RWLbT+GQHBPaYUyi5sF8GVuV7+BdzwIUz4mEU7gSheR7pL5kpU+s54qnyYSNUxoGTEx40KHUZCV5dLZLCp+JAV6M/vcFLK3bgyr7VM8ACWd7PYZEhIhCOdkKy7eclYbK9cRf3mXZEmRHXsQxnZSNnnFcut3yM28+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNl5I8Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFFCC2BD10;
	Tue, 14 May 2024 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715699622;
	bh=EihJtzlA6mfpqd02t2ulG1Tfdp9EZ0d2PsknBA2nYeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iNl5I8OcMQjKzC1YkTBVimMVAaoVqxl50Zp7lNiMsX3ntRIXrwfMf9JENhj9D9r+q
	 BH06AV26INRmzeIhnbmfiVzw+wp/fAUohvq684oH3V4oUeop8WuhcRQK1mSKJU/ac2
	 1beOPn2F5J5zBH8LU0rsb7VzYD+jUm4Vw0/wbwy9lYmIG3QWQnR0LDGf1h4xdVBke4
	 q8G2ZgsTDAdiCuZxrBHWFM+mlbHoOis0BM/YBmPqHVuVbiJvoKG0AzXQK+4YEkPDFg
	 8OfPOgME0+sdsLWERAXQbkaeZBRT2uF8pMMMuV604fcxs1fMBYl/y+zt6rr3nlAE2c
	 m8VpEsEr+/Pyw==
Message-ID: <3e9595ec-f233-4d93-84ff-77e0183c73a7@kernel.org>
Date: Tue, 14 May 2024 09:13:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: Fix route deleting failure when metric equals 0
To: xu.xin16@zte.com.cn, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
 fan.yu9@zte.com.cn, yang.yang29@zte.com.cn, si.hao@zte.com.cn,
 zhang.yunkai@zte.com.cn, he.peilin@zte.com.cn
References: <20240514201102055dD2Ba45qKbLlUMxu_DTHP@zte.com.cn>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240514201102055dD2Ba45qKbLlUMxu_DTHP@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/24 6:11 AM, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Problem
> =========
> After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
> we noticed that the logic of assigning the default value of fc_metirc
> changed in the ioctl process. That is, when users use ioctl(fd, SIOCADDRT,
> rt) with a non-zero metric to add a route,  then they may fail to delete a
> route with passing in a metric value of 0 to the kernel by ioctl(fd,
> SIOCDELRT, rt). But iproute can succeed in deleting it.
> 
> As a reference, when using iproute tools by netlink to delete routes with
> a metric parameter equals 0, like the command as follows:
> 
> 	ip -6 route del fe80::/64 via fe81::5054:ff:fe11:3451 dev eth0 metric 0
> 
> the user can still succeed in deleting the route entry with the smallest
> metric.
> 
> Root Reason
> ===========
> After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
> When ioctl() pass in SIOCDELRT with a zero metric, rtmsg_to_fib6_config()
> will set a defalut value (1024) to cfg->fc_metric in kernel, and in
> ip6_route_del() and the line 4074 at net/ipv3/route.c, it will check by
> 
> 	if (cfg->fc_metric && cfg->fc_metric != rt->fib6_metric)
> 		continue;
> 
> and the condition is true and skip the later procedure (deleting route)
> because cfg->fc_metric != rt->fib6_metric. But before that commit,
> cfg->fc_metric is still zero there, so the condition is false and it
> will do the following procedure (deleting).
> 
> Solution
> ========
> In order to keep a consistent behaviour across netlink() and ioctl(), we
> should allow to delete a route with a metric value of 0. So we only do
> the default setting of fc_metric in route adding.
> 
> CC: stable@vger.kernel.org # 5.4+
> Fixes: 67f695134703 ("ipv6: Move setting default metric for routes")
> Co-developed-by: Fan Yu <fan.yu9@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  net/ipv6/route.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



