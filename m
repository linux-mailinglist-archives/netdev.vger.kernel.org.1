Return-Path: <netdev+bounces-74099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EA85FF6A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FF41C23B6D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357539FC7;
	Thu, 22 Feb 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0eswc7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F912153BFD
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623063; cv=none; b=rlWWbslu26tor12Kr9TsA8IHT7rsi7ZBkvIo2RiI11njtS0AmHfKXw62T/Z4mm8/M/yQP967ClG9OOMABRWMuDMVuvJCtrqUI82I3Fsg3uu98fn94fsDgbaOOl5N5nuhIn5cOoWVD4KM1Q1D26EhPlWlMJtw9MLlsz0005cRBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623063; c=relaxed/simple;
	bh=t0dPsjBT42poZB4cc95SyxOcv7q9yN0LgpcHLYTiW7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBYZQcj1j9YdIKYqmbC8GgVqhe8aNPb+l1ILQaQF8PFfnZIOdkIwLz8L7wQAeGF/qaVlX6KJzB896CyL+CtZSoTKgRrSpcGYSlxtfmXMvSVNaBQz9P48EuYskwbePhP4X2gOzc1xDy234B/oW1jKVV0NxZINLuVc19ID8zpFYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0eswc7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3530C433F1;
	Thu, 22 Feb 2024 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708623063;
	bh=t0dPsjBT42poZB4cc95SyxOcv7q9yN0LgpcHLYTiW7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r0eswc7dAO8MNHjRuAaTCPRv6eg+eCztU+235WOEOI1czme15efe0QdbYVtmA7ITf
	 Rrc7TTUu7jl7hOG/WRugyUGVJfn9gD/L7Vs7c5M1uzzirv2BThWxUCpvzEg6NHT5tP
	 /4+aqa04miFiLuPays4T1O701UoNVETl4Zk7HD4FiBm21xX5MrhdRqa19jmU349/TC
	 lmiBQgexeRkNqik+u6NZRHptw9KBnSM5yTSEs9AXlGj/KrdlEDCnQYDx2Qgm29TKHa
	 4jph0wvYKnwy+l6wYHv6TwrcZ9roUX9MZJEdduLjMPlpBGofgdEaHvT05e+NcQHnI3
	 dlK6fc7VafJ4A==
Message-ID: <c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org>
Date: Thu, 22 Feb 2024 10:31:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/10] introduce drop reasons for tcp receive
 path
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/24 4:29 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I was debugging the reason about why the skb should be dropped in
> syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> general. Thus I decided to refine it.
> 
> v8
> Link: https://lore.kernel.org/netdev/20240221025732.68157-1-kerneljasonxing@gmail.com/
> 1. refine part of codes in patch [03/10] and patch [10/10] (Eric)
> 2. squash patch [11/11] in the last version into patch [10/11] (Eric)
> 3. add reviewed-by tags (Eric)
> 
>


besides the one nit in patch 8, LGTM

Reviewed-by: David Ahern <dsahern@kernel.org>


