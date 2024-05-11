Return-Path: <netdev+bounces-95642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1A8C2EB8
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4888D2824EF
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3511CAB;
	Sat, 11 May 2024 01:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNJ7Q1Xk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66D17588
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392358; cv=none; b=hGr8w4CUQwKvBgm6ffVdpqPN/GN5rDNy9tCKnumtqtUM19O8bBvMzblbs1sVMsjr70D4vY4EA4WiQ07tw47swNMz1aLtGA1aaqWDXLZh4o+X7J2ZAK+TP+z4oz2wugtbzLkfdD7srmQhtx3Hoo+srRxqe0ZhHSthY2JvbuIXNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392358; c=relaxed/simple;
	bh=M3ziogp3iSG0O/ilqDA/G1JvN3VJDfpFWkcDRUXJveg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2Ah10NDpOXMAjyVXjIprvLedrCzUkzJd+ausnyfda9A/MJhm2WMhe8LalBRSdM/ypTfMi2pfwYVTcYA5Ci1scLb5i7ShHwtjQcHOFbEEs2pYyakHrCwlJU4jZYgTiw5wnlJ5Oh0/kTkNge324YSp+nT0iNAJQhzNFn4vq9Mc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNJ7Q1Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E64C32783;
	Sat, 11 May 2024 01:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392357;
	bh=M3ziogp3iSG0O/ilqDA/G1JvN3VJDfpFWkcDRUXJveg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fNJ7Q1Xk7Q2Lstu5+tJczUX1omSt8NxRI/E1kOD90vl4ccfedtlmZJEVsFKP9Kw0G
	 qDFDepyd/V8srvq5ikmM1MYulaHuma9QErBcHUUCZaF357IB/HSw3dHJK1yQ6cfsOo
	 3uwl4E1ALiNpwilH6UicQhSCqfTjW1BD45l073Xaee/b8RZf/rd9tUsYMe6JWDoxAV
	 AtzzL4HKDw3VBC58krGbr7iAkOGfOgCS8V0SY4lMBfbASq/Amr/C9QAZ3xLlCAJfj4
	 IwspSgPsyQCoIGAF141YfWvMjQOco1mDmAaZGkK8O3fTOSrApa3rHgmkAOBhw3rAev
	 aP7+L3+nLjZFg==
Message-ID: <b6d0cbfe-e1cb-44f5-a392-38cad6b40b5c@kernel.org>
Date: Fri, 10 May 2024 19:52:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 3/3] ipv6: sr: fix invalid unregister error path
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vasiliy Kovalev <kovalev@altlinux.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Guillaume Nault <gnault@redhat.com>,
 Simon Horman <horms@kernel.org>, David Lebrun <david.lebrun@uclouvain.be>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-4-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240509131812.1662197-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 7:18 AM, Hangbin Liu wrote:
> The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
> is not defined. In that case if seg6_hmac_init() fails, the
> genl_unregister_family() isn't called.
> 
> This issue exist since commit 46738b1317e1 ("ipv6: sr: add option to control
> lwtunnel support"), and commit 5559cea2d5aa ("ipv6: sr: fix possible
> use-after-free and null-ptr-deref") replaced unregister_pernet_subsys()
> with genl_unregister_family() in this error path.
> 
> Fixes: 46738b1317e1 ("ipv6: sr: add option to control lwtunnel support")
> Reported-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/seg6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index c4ef96c8fdac..a31521e270f7 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -551,6 +551,8 @@ int __init seg6_init(void)
>  #endif
>  #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  out_unregister_genl:
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
>  	genl_unregister_family(&seg6_genl_family);
>  #endif
>  out_unregister_pernet:

a good example of why ifdef's create problems. It would have been
simpler if all of those init functions were defined for both cases and
this function does not need the '#if' spaghetti.

Reviewed-by: David Ahern <dsahern@kernel.org>


