Return-Path: <netdev+bounces-95639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71C8C2E80
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7951C212BB
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A211184;
	Sat, 11 May 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwcQ2xUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C91078B
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392030; cv=none; b=CkmsSga7v7y8xeVQsJYJSyrT2d77/l2O3A4fYdE+L6gy/JsOpXzqmgpMvXb715lleDiQF5ODOY+ja2GhGt3VdU+3Yyanho7L80hu5tX7XnjBuIj+vysR7oVNrgxC+SYLaF/9Nw098I6JbWmQvDaR1/mHRDh/K+ussBoA6/2IY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392030; c=relaxed/simple;
	bh=FHOmy05TxLt2AA9depzhqhqVoaDRC2+USdDFX1yA+rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzcCfcmA18O8QxlJIeiDZ2l9ba7EPCiGk6ezMBVdhyeZyBownl3uZIjWIr5GLDHw5ZkgEeGr/7D9pW5yvJyoysv2WgfnJ7GJgyPAFCMN7VvLEwDQxklxVhJYVnqy4NgYNhUEmISxM8MzXBqYvlu4CwVxqmipfiuwkDPFbSv2tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwcQ2xUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6786C2BBFC;
	Sat, 11 May 2024 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392030;
	bh=FHOmy05TxLt2AA9depzhqhqVoaDRC2+USdDFX1yA+rU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QwcQ2xUy4Vex+2VqVC4e8IC+Xk3K4otDuD0ChkK3bWkO05rF+PyM10AC+HMlhBI9c
	 mnmer0Jc85pp62H4Q8/6x7MITvqOV8CXOhuZ03LteaKQETLIzWqp0gMycLBK08/qaC
	 VdfnYeHcfPztbMrnCDszY56HI0TZu4ajMs6fcs1oGy80ni4RVxOgFbqJ/rXznqxLR/
	 12SV+MjRUI77mYpeR9lj5hUdyG5+ocHu/IssRlCS9pwARVcdhlmBE8pVAhl79xvhB4
	 RA94whqdbEkWmU4NToxd1Gxh7slHxCdJasJo5SGNjsgeUpXSpyopFvyndHX99jH3+7
	 YUXMhjEhDokeQ==
Message-ID: <e5c07c0b-306f-4b06-acbc-fed7dca68238@kernel.org>
Date: Fri, 10 May 2024 19:47:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: fix inet_fill_ifaddr() flags truncation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Yu Watanabe <watanabe.yu@gmail.com>
References: <20240510072932.2678952-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240510072932.2678952-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 1:29 AM, Eric Dumazet wrote:
> I missed that (struct ifaddrmsg)->ifa_flags was only 8bits,
> while (struct in_ifaddr)->ifa_flags is 32bits.
> 
> Use a temporary 32bit variable as I did in set_ifa_lifetime()
> and check_lifetime().
> 
> Fixes: 3ddc2231c810 ("inet: annotate data-races around ifa->ifa_flags")
> Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
> Dianosed-by: Yu Watanabe <watanabe.yu@gmail.com>
> Closes: https://github.com/systemd/systemd/pull/32666#issuecomment-2103977928
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/devinet.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



