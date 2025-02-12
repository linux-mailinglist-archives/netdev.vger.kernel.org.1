Return-Path: <netdev+bounces-165632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB276A32E0F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B6418868CE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4625C6E7;
	Wed, 12 Feb 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9EYUZ8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FE2586F7
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383237; cv=none; b=EyhlznGxi5XFmRqCpVcO56Xsxen8kXkGrpL7j6iAZx/ZStuH6qI2lLK9kaFVGBh/oqj6F4pyY7C3SRWBZq6Lx6VlHLH+nkB7XF8l65a6CEEeFLPyhWAcAttms5qlNB3Vnwnz8GWUks0Np5G0UkBo1I9G9IEMFdEIbr0nEzgP5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383237; c=relaxed/simple;
	bh=IJ3nzlRVdkiWr6YMSENi6llmtBFJZ6SOufyyGtWvIOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuOdxgtfHrQ/3FAMBH8JaMBlgcDVTvKJd/yj5TS0pmtKHaZKzsuxGzYL7AMGGR0HtaDbsUXUVaA1XUi0jpxjdmd5tD3WFl5vKZ11glHZI0SzSBBjQzRt3xQObYxwQFAr+AsOawfbmKENSaDj89jPu53qpWoJXCsMbyVqO+c+mIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9EYUZ8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BDEC4CEDF;
	Wed, 12 Feb 2025 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383237;
	bh=IJ3nzlRVdkiWr6YMSENi6llmtBFJZ6SOufyyGtWvIOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H9EYUZ8nUlB6A10+zVYSZ6yEgjMX1JHi0NfR8G/DPZSWecXpOGz2GL4Cect+C0WdA
	 VkGAj6CZiRbgFyLpV9wTP734OUniuxSMk/diO1yTxMspaUqJh8Oz/y0bH9T1yUaQl3
	 JA++bxCJfBs6MJWGTDKcoLuVelTLc7j9Rq8yLiOdk+oUGga4pVJTGx30mESgcHePcI
	 WK1GBvTqnGIkVxeMCNPEwb7zGKFjJ4bvAJvNNQEXbZxRZuvi2eU1nU0eBu0qIZuV/1
	 Wn36hoZaTOo4+v3HxjHYtnRxYUIxUHt6sDWP5tHytKAOBLEILZcb8z6Ztot2E9DJdO
	 qCarvNWplt6TQ==
Message-ID: <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
Date: Wed, 12 Feb 2025 11:00:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ipv6: fix blackhole routes
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Paul Ripke <stix@google.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250212164323.2183023-1-edumazet@google.com>
 <20250212164323.2183023-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250212164323.2183023-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 9:43 AM, Eric Dumazet wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 78362822b9070df138a0724dc76003b63026f9e2..335cdbfe621e2fc4a71badf4ff834870638d5e13 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1048,7 +1048,7 @@ static const int fib6_prop[RTN_MAX + 1] = {
>  	[RTN_BROADCAST]	= 0,
>  	[RTN_ANYCAST]	= 0,
>  	[RTN_MULTICAST]	= 0,
> -	[RTN_BLACKHOLE]	= -EINVAL,
> +	[RTN_BLACKHOLE]	= 0,
>  	[RTN_UNREACHABLE] = -EHOSTUNREACH,
>  	[RTN_PROHIBIT]	= -EACCES,
>  	[RTN_THROW]	= -EAGAIN,

EINVAL goes back to ef2c7d7b59708 in 2012, so this is a change in user
visible behavior. Also this will make ipv6 deviate from ipv4:

        [RTN_BLACKHOLE] = {
                .error  = -EINVAL,
                .scope  = RT_SCOPE_UNIVERSE,
        },



