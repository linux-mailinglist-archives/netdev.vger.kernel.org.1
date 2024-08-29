Return-Path: <netdev+bounces-123068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3ED963960
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70BEB2253C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F211139CEE;
	Thu, 29 Aug 2024 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc5zAuOE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86412D760
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905815; cv=none; b=eCsf/kcuFk5lxuW/rc3R2YK3kAQwBCLQbW1BJSH7Xy+VYuuDDAQwWbgdPrVWwLjM5+G5mROZbANEl4dJZPdH4zraNVncwPfs4DDOH+pfq9dkbCRKak7D3vUrF3W8sfKZjwjKVJEZD6kKU14/0XRojc3ZKIvdBpQYOrGdVhmHOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905815; c=relaxed/simple;
	bh=PamPyQmzB2c5+/LQXmtjOHcOoncDE3B3JoTPG+QsVoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdguQJy2Ill/N8eW1caMZVTVVqg1qKtys5CGi0lBCFMj5rERTi0u/rQZXFCM5ftvL+O6JCUwoOtZGqvmcGoJyxFHwr8i+zFLkPGJ8wKl/ZZINgt8EO0SjKelfTgssl88Q3pRwly+mENNlRusMrTto5ExVMNclcphazlQv9AUZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc5zAuOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EF4C4CEC1;
	Thu, 29 Aug 2024 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724905814;
	bh=PamPyQmzB2c5+/LQXmtjOHcOoncDE3B3JoTPG+QsVoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cc5zAuOEAzuS5S9/cMoiDqEwEcTIo83mezzTCzAapSwWGaJ99JNDVDl5uuTzDUd2w
	 FMx9abl2HSHH2pKSMJifCEoDzAYOJTi/6jaVqYPlF4Uh820abiWrEmuyfpu6K/BrBl
	 ltBCLSPWTTuD6DSc1ZR0yz93Da5kdVjlaFnjLxtoM+u5PnugRN8I4SRMu2AalNlrBG
	 nE5zGkFqny+eRzr+fOUvqwLXpOg+Ory+ZfdWuMJAVIACfKzRCLEfVt9cOmF0J+NFCI
	 EE3XJDnZ2PfeVBt4FRr0Mcs8UTYsOGVQbf/tDkJpVdYKG7xhJlvlo4aIDWVN2uiPpM
	 JO1vKKu7kFRsw==
Message-ID: <bb298d73-c1a6-4130-ac46-1380288e47c4@kernel.org>
Date: Wed, 28 Aug 2024 21:30:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] icmp: move icmp_global.credit and
 icmp_global.stamp to per netns storage
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240828193948.2692476-1-edumazet@google.com>
 <20240828193948.2692476-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240828193948.2692476-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 1:39 PM, Eric Dumazet wrote:
> Host wide ICMP ratelimiter should be per netns, to provide better isolation.
> 
> Following patch in this series makes the sysctl per netns.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h         |  4 ++--
>  include/net/netns/ipv4.h |  3 ++-
>  net/ipv4/icmp.c          | 25 ++++++++++---------------
>  net/ipv6/icmp.c          |  4 ++--
>  4 files changed, 16 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



