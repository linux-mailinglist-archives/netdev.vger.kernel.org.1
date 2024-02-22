Return-Path: <netdev+bounces-74098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C6C85FF49
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785E41F21B28
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F21552E7;
	Thu, 22 Feb 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpYYfIEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E2154C14
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622910; cv=none; b=Z3+kQtMXKafECoJ77uubj3HEsBgFxLcdLbO8N1lfu9cdKI9GMgVd0kchFpfttiJ2+sZCnErz9QqihXXQGOd1O09Zpo449C3hP0fo2PfiaYt230Ord/zWDgG6pQB/otiLUug6HlCSuBzU/IvGEcKpSkVCYlniCENgMRIAZaqNssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622910; c=relaxed/simple;
	bh=Ym0ZPLkadZ2F1bS0GhbTBsF8YtHX9N1INXsdxn0QyGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Diq1Q0dj8Hjm8C4QtT/Y7uxIM0vqPvLA7Cu3DqaGh2njQF2iJknM5CrdLNQYd9Snfpw3/YYmZG5DJqZLR1dO1sZbclOb4ghJNanDl8xyoZQerBrHDn5sREuH2EL9FwZT2cgK7ycrytoCwtNvDN/RPu/rXJsyXHG9k6PonaT48co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpYYfIEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A78C433F1;
	Thu, 22 Feb 2024 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708622910;
	bh=Ym0ZPLkadZ2F1bS0GhbTBsF8YtHX9N1INXsdxn0QyGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mpYYfIEIycFVULkYi6hOX8l0b8JPB/rj66pZqH1H2ANu9l5ghoxb7YBfGd67xG0QI
	 rLTWEIsTL1bg/yQPlt128rs3kcDwrFiOPHuMehsjYXZMuJCLco+vQPhddc6b4GroXR
	 mGg5NJhPD1Hq3VTaS2zNl9n4Y5Vdl6gkvv6jnvW5SlHT4isPJCVKQBsQ99091DWhKG
	 SzW2LZwvox+K3lWOE0HAIcTkIqGMhEj9d9d8Mrdm7VPq7M/LpfUy43mX8eVBh41BSs
	 WgWmE9LPqACQcmLDn/u+bCUXjQyh2IlSN0Ib72Vn+XT/cdJUvhU4sXy5mCHNQm63k3
	 FlBtOEx9xChdw==
Message-ID: <b053dad4-5745-4b9a-af55-f5c04beb6584@kernel.org>
Date: Thu, 22 Feb 2024 10:28:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/10] tcp: add dropreasons in
 tcp_rcv_state_process()
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
 <20240222113003.67558-9-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240222113003.67558-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/24 4:30 AM, Jason Xing wrote:
> @@ -6704,8 +6705,13 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  				  FLAG_NO_CHALLENGE_ACK);
>  
>  	if ((int)reason <= 0) {
> -		if (sk->sk_state == TCP_SYN_RECV)
> -			return 1;	/* send one RST */
> +		if (sk->sk_state == TCP_SYN_RECV) {
> +			/* send one RST */
> +			if (!reason)
> +				return SKB_DROP_REASON_TCP_OLD_ACK;
> +			else
> +				return -reason;

checkpatch should be flagging this - the `else` is not needed.

			if (!reason)
				return SKB_DROP_REASON_TCP_OLD_ACK;

			return -reason;



