Return-Path: <netdev+bounces-120310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8B958E55
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DDA1C21AE6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64AD1547C9;
	Tue, 20 Aug 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLz9UX7K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931631CAB8
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180315; cv=none; b=U7byW5LjERLRdSTspluO7Q/3f029diV9Bj7+WqMju2byyVy1AQo6pIUPNgRcXG36G8k2wCW0S9Wak6T8nagKpnCcISnVjMrB30Qwnj/DWvteHYacPVOM0AAB8E+vHjbcRkf18T1+7+ixKlCE4h2NmwGDNQA2Z19SHol3pOJq1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180315; c=relaxed/simple;
	bh=a7mWk32npP36aHg2dYRK/EMEaTpICYgAV00BjICANkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGJw1/Gltr0+HCqFSdqwurL/gMXKK3ReV5cGlmVCjU+mqN/I4eQwOYya8oqHCqiJq0OG3X+NJdaFdzBCqrdFCQGsy2DqRjG0MvfhPk7QXm7bTUIoCR+gCau8V5wulvnCDpcLiGj25oCZVpx5cPet10SwGHMfwr6JUr1jCemCrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLz9UX7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2362C4AF09;
	Tue, 20 Aug 2024 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724180315;
	bh=a7mWk32npP36aHg2dYRK/EMEaTpICYgAV00BjICANkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GLz9UX7K0O3zO5OIdKxYGQINZiKWEed+WcLtpJJmOCQJ3DpgdiCuA/HtoZr2UdCV+
	 3NfxgBJ5a1UUK3Nq+aIF39STn4/kV3D7uIuktc0YnPtpzAQIaBR5RasqfxgnCjNa99
	 ViJZzVKyrnIPRdgYWUNWyJptq8OXG8yOqbfoVyGA7xpyaimCcEj1pAioUz8BMIfNaC
	 QQQJrSWiVc2X3FFitECgwKFhspxQF2WxxYEU/wQ2ACsL0nkv4fRlYHsYucI99LIwlg
	 dEM8CigB68oCc6TQ6392uwhnx67vpewPQbQxVck1U5Fjc1iEU6hEnwdMuhpeg7Ur+X
	 RkITjQysVoyqA==
Message-ID: <d2d6d518-b67d-4b5b-a0ba-13b506e27737@kernel.org>
Date: Tue, 20 Aug 2024 12:58:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 3/3] ipv6: prevent possible UAF in ip6_xmit()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Vasily Averin <vasily.averin@linux.dev>
References: <20240820160859.3786976-1-edumazet@google.com>
 <20240820160859.3786976-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240820160859.3786976-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 10:08 AM, Eric Dumazet wrote:
> If skb_expand_head() returns NULL, skb has been freed
> and the associated dst/idev could also have been freed.
> 
> We must use rcu_read_lock() to prevent a possible UAF.
> 
> Fixes: 0c9f227bee11 ("ipv6: use skb_expand_head in ip6_xmit")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vasily Averin <vasily.averin@linux.dev>
> ---
>  net/ipv6/ip6_output.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



