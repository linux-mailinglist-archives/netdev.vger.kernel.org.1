Return-Path: <netdev+bounces-133758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C991996F8D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761F4283EFE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693719F113;
	Wed,  9 Oct 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhfX5C4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226D1990C8
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486780; cv=none; b=T0r/uZo/1cUTDpiC4zLHE57LBg5OyFjHGeP7hVDkYmnxb1xFSnNc3IBks7V6F/PqjkaLUBUIEXY8ZEmPPp/62qNrfVHbZGgMAmVZbV6CtxoYTBfTkyTaLux1MnhcUNwOBV3VYyr8eLl6QkSAjoLMGjH76klqzUiS0S1IIopaTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486780; c=relaxed/simple;
	bh=zdSphCSZipCi8uIqyeJNwy4vicuODOk4mqoVP4x4TXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYm28AE5WjflVcIwGVtHPOygMnj6VffaSM49rGZV12YFAlpVUwXgamzMiC4mdGF7B6kNNcDwbW9pC3ybStwyabcCeCc+PTa82v8KD01k+PUuunNQcmEyA+xPTTidToqUli3q2HQKVzQKy9Ce44Py0YUb1QFvwhO6lOqd4UskKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhfX5C4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2330DC4CEC5;
	Wed,  9 Oct 2024 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486780;
	bh=zdSphCSZipCi8uIqyeJNwy4vicuODOk4mqoVP4x4TXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DhfX5C4L4geb3xZJo54ldwzsULzerjve9dC//GwhnpdkUfJ40XC+hp5UUmlWw9uj9
	 DKy6ZPMaD2yyiOn9W92OpEfv51ne+vakcbQCKobT1JtLojMxp8XR21ULUlBxQVcvok
	 zY5UJ8+YA10vgLrld8MWmBdwwbHqOqDTdtNEgj2Xz2GCi30Nil351pfn9WCh98w6PW
	 WxJE0qTAGtGm28zv28ZKdyYkvKYRx6gxQprAS9nPnYDgPXzDdSfL5KWFGz01g05JZ8
	 lDkI2b4t+i01Ic2ywkCwMotJJGHrmCIqV5/raWC/TKItC+7kB790yghk9AcxkEUOS7
	 HNactBxuK5U1A==
Message-ID: <8b946bb4-4918-4072-9f6c-d7cfc96f1f48@kernel.org>
Date: Wed, 9 Oct 2024 09:12:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: move sysctl_tcp_l3mdev_accept to
 netns_ipv4_read_rx
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Wei Wang <weiwan@google.com>, Coco Li <lixiaoyan@google.com>
References: <20241009150504.2871093-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241009150504.2871093-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 9:05 AM, Eric Dumazet wrote:
> sysctl_tcp_l3mdev_accept is read from TCP receive fast path from
> tcp_v6_early_demux(),
>  __inet6_lookup_established,
>   inet_request_bound_dev_if().
> 
> Move it to netns_ipv4_read_rx.
> 
> Remove the '#ifdef CONFIG_NET_L3_MASTER_DEV' that was guarding
> its definition.
> 
> Note this adds a hole of three bytes that could be filled later.
> 
> Fixes: 18fd64d25422 ("netns-ipv4: reorganize netns_ipv4 fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Wei Wang <weiwan@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> ---
>  .../networking/net_cachelines/netns_ipv4_sysctl.rst          | 2 +-
>  include/net/netns/ipv4.h                                     | 5 ++---
>  net/core/net_namespace.c                                     | 4 +++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



