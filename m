Return-Path: <netdev+bounces-68273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078C8465BF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80A11F2746D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195D8839;
	Fri,  2 Feb 2024 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEEaGbmu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B28BE1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840521; cv=none; b=taWDzEquJdBdGLCMKkPu2bj734GB23lbZ7+MFoGkUq9UCF14bHxVy+NnOJ9HJFbvukCMFto2AXYaS3zYT6X7Nw6n54LvMvWECVHKP4/EL3Q517Tu6Up6ffvzlRoqKZ4a2mnbfb8r+fgSLI0Dv5YDwzGw0+bB2TD/YmYAzdg4juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840521; c=relaxed/simple;
	bh=QVJtjMaNqC/ca8Mc941TRApky1Y+uxkV9DGdID/R0Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXsYqZJO+R5W/Weh4xhgekm7EIXyUq0WW1TVQvR1pLL+8zTQeYoxlMZDP70r0evnX1s0TuwsMCQatDZxQ2LFiyRt+XRyE9xCF29sdchOz4aCEYeFRj5DFraw7Pu4Oq7aGv6zAyi+y3eUBSHWbZylfODZ9PhmAni83H0/7cXPGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEEaGbmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE6C433F1;
	Fri,  2 Feb 2024 02:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706840521;
	bh=QVJtjMaNqC/ca8Mc941TRApky1Y+uxkV9DGdID/R0Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WEEaGbmu1K//Uzrg5jeAf1uMMnfsyiQyImaB3k9MYTayh/qLkjsKyG1zFYYlnStMM
	 vj/Pfd/zTcgSpTdkZcxdPbb8jFH4rUQJd5XB2vqlpEFbITagVHpHkVpingg5oK322G
	 R6hxZ+qQN6nfFPZLxFl2PwbcXujWsYZIhA4vHjSYvV9vPBphMrChcHRMRLBPGrvozs
	 YwogTZ+UaJ+UFRsk6YB0yCJ4X3QZMd7EYn+TLOxiabXWct4Mn6Ec0ZZ2+POtdWOFJk
	 DAMgg27Z0zdujDDD2rAghzynmyv5LYrHu7GOQjjuUSCDFLSA/6gNrMZm5phYBltXSW
	 jh4UpUD6OCqcQ==
Message-ID: <5ec6cc3d-a31e-4391-a8ee-31666650ea23@kernel.org>
Date: Thu, 1 Feb 2024 19:21:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: make addrconf_wq single threaded
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240201173031.3654257-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240201173031.3654257-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 10:30 AM, Eric Dumazet wrote:
> Both addrconf_verify_work() and addrconf_dad_work() acquire rtnl,
> there is no point trying to have one thread per cpu.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/addrconf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



