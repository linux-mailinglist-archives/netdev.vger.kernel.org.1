Return-Path: <netdev+bounces-87075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C718A1A55
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520DF1C20B10
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F333D0D0;
	Thu, 11 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5P7Wdew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9D3AC08
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849996; cv=none; b=i3Z0QTuQwGhMZRICUj4o1lcf6VemyLY0QQB+N4KP6xaKlb2e2JwDymTjMdkA90SmwvLIBHQtnPVdg+RR0DL3qXxqlE7/k/1Vt0lyhjfRsADuoD/oRCycSRnGwyk/eJZYxNW7kiWj7Kmm4dnbOIi/bnPzG53NooHgbcPHJf0wFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849996; c=relaxed/simple;
	bh=+dIOhnXdZMivf9yHQiNjzMOYQKiyOEfSPURQwl4H4dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnNpBgqTwE5dx5mUYJATwUOMyqQwhsfAiDijcIHp6JSlX13I/8ERFBaug96rpbp38O8eLcyZRuntyfe2UJq31ChbB2BfpSAUwuEU1XY7IaNV45b6/2t6K4+zAwfsr8E5MvOumLyAJlqanSsrYWe84sHWHI9dpYmL5MdnaX87jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5P7Wdew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9155C072AA;
	Thu, 11 Apr 2024 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849996;
	bh=+dIOhnXdZMivf9yHQiNjzMOYQKiyOEfSPURQwl4H4dc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y5P7WdewMtMulgJoPzrG+mFjffgVO7RiO48BlgjauxlYgOuDHDdOF1oy6WAEz2Ldq
	 ga0rtBKJAlkHEsYl/5hkYR/7ntsrc6IUhLjjO5AfRpL+AxDMGVj4hASI7UoKkuyHmg
	 7vn5/mrFo1JK+v+sG1RRosoUy/KBubSRDdeh7yB/7FGvxJuML/zVgwNKbBOvhL5cR0
	 aDUnbe3QMxFqSi5w7aipR82F9btcuyiZM5y3Y1WrRlvolEIPXySVThaetovH/uJ3vF
	 YVxp9MECXvTdU/XsvqCSdntxTXrMg1RVvjIT1ygmNQtzNvWEcK4IXFsLyFFY22LGpA
	 5QnW8F07FBLyg==
Message-ID: <4a292f3c-a780-4e3b-825d-107e7e20e2bb@kernel.org>
Date: Thu, 11 Apr 2024 09:39:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] fib: rules: no longer hold RTNL in
 fib_nl_dumprule()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240411133340.1332796-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240411133340.1332796-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 7:33 AM, Eric Dumazet wrote:
> - fib rules are already RCU protected, RTNL is not needed
>   to get them.
> 
> - Fix return value at the end of a dump,
>   so that NLMSG_DONE can be appended to current skb,
>   saving one recvmsg() system call.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/fib_rules.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



