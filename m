Return-Path: <netdev+bounces-87170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A378A1F8C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFEB286119
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654014286;
	Thu, 11 Apr 2024 19:34:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1A17BB6
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864087; cv=none; b=CqouY0ctP1UFJsSPattlvP43co+KnraIB2X3lqwjf5tQKOIaSc+7xbZoyI997/n0Qhi3ax46z5C/fq8s4jg8f1RUP5htJ69jH8q+JoK5hfbFkxd9/Ekff2zfgxbiaDMIt8PR1ArSCm1wbOBlOWuXUSBriNQZoddWoOZKBknQPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864087; c=relaxed/simple;
	bh=01fHhXgwQN2aTJ3a+itVgYQdpHM/2C4417f7GUbjYEA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dy1Bg0uJW0DT2KNt93pCWkK2UVLPxKqWyrf/lyzQqez39un9xUbqcFodhvosIBcNtm1tt9mDHxo2qYQB6YtjGITVp2miBXy1dsJq5KsahSigFRjT1GLhy2sjU8YdUfiOvyos9I0iYw2cle99fhSwD9fpBlU6nPrCCI2cu8xIWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD57E1C0003;
	Thu, 11 Apr 2024 19:34:40 +0000 (UTC)
Message-ID: <a25fa200-090f-456e-9885-fe25701dbd94@ovn.org>
Date: Thu, 11 Apr 2024 21:35:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Stefano Brivio <sbrivio@redhat.com>, dsahern@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
References: <20240411180202.399246-1-kuba@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmP+Y/MFCQjFXhAACgkQuffsd8gpv5Yg
 OA//eEakvE7xTHNIMdLW5r3XnWSEY44dFDEWTLnS7FbZLLHxPNFXN0GSAA8ZsJ3fE26O5Pxe
 EEFTf7R/W6hHcSXNK4c6S8wR4CkTJC3XOFJchXCdgSc7xS040fLZwGBuO55WT2ZhQvZj1PzT
 8Fco8QKvUXr07saHUaYk2Lv2mRhEPP9zsyy7C2T9zUzG04a3SGdP55tB5Adi0r/Ea+6VJoLI
 ctN8OaF6BwXpag8s76WAyDx8uCCNBF3cnNkQrCsfKrSE2jrvrJBmvlR3/lJ0OYv6bbzfkKvo
 0W383EdxevzAO6OBaI2w+wxBK92SMKQB3R0ZI8/gqCokrAFKI7gtnyPGEKz6jtvLgS3PeOtf
 5D7PTz+76F/X6rJGTOxR3bup+w1bP/TPHEPa2s7RyJISC07XDe24n9ZUlpG5ijRvfjbCCHb6
 pOEijIj2evcIsniTKER2pL+nkYtx0bp7dZEK1trbcfglzte31ZSOsfme74u5HDxq8/rUHT01
 51k/vvUAZ1KOdkPrVEl56AYUEsFLlwF1/j9mkd7rUyY3ZV6oyqxV1NKQw4qnO83XiaiVjQus
 K96X5Ea+XoNEjV4RdxTxOXdDcXqXtDJBC6fmNPzj4QcxxyzxQUVHJv67kJOkF4E+tJza+dNs
 8SF0LHnPfHaSPBFrc7yQI9vpk1XBxQWhw6oJgy3OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Y/5kJAUJCMVeQQAKCRC59+x3yCm/lpF7D/9Lolx00uxqXz2vt/u9flvQvLsOWa+UBmWPGX9u
 oWhQ26GjtbVvIf6SECcnNWlu/y+MHhmYkz+h2VLhWYVGJ0q03XkktFCNwUvHp3bTXG3IcPIC
 eDJUVMMIHXFp7TcuRJhrGqnlzqKverlY6+2CqtCpGMEmPVahMDGunwqFfG65QubZySCHVYvX
 T9SNga0Ay/L71+eVwcuGChGyxEWhVkpMVK5cSWVzZe7C+gb6N1aTNrhu2dhpgcwe1Xsg4dYv
 dYzTNu19FRpfc+nVRdVnOto8won1SHGgYSVJA+QPv1x8lMYqKESOHAFE/DJJKU8MRkCeSfqs
 izFVqTxTk3VXOCMUR4t2cbZ9E7Qb/ZZigmmSgilSrOPgDO5TtT811SzheAN0PvgT+L1Gsztc
 Q3BvfofFv3OLF778JyVfpXRHsn9rFqxG/QYWMqJWi+vdPJ5RhDl1QUEFyH7ok/ZY60/85FW3
 o9OQwoMf2+pKNG3J+EMuU4g4ZHGzxI0isyww7PpEHx6sxFEvMhsOp7qnjPsQUcnGIIiqKlTj
 H7i86580VndsKrRK99zJrm4s9Tg/7OFP1SpVvNvSM4TRXSzVF25WVfLgeloN1yHC5Wsqk33X
 XNtNovqA0TLFjhfyyetBsIOgpGakgBNieC9GnY7tC3AG+BqG5jnVuGqSTO+iM/d+lsoa+w==
In-Reply-To: <20240411180202.399246-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 4/11/24 20:02, Jakub Kicinski wrote:
> Commit under Fixes optimized the number of recv() calls
> needed during RTM_GETROUTE dumps, but we got multiple
> reports of applications hanging on recv() calls.
> Applications expect that a route dump will be terminated
> with a recv() reading an individual NLM_DONE message.
> 
> Coalescing NLM_DONE is perfectly legal in netlink,
> but even tho reporters fixed the code in respective
> projects, chances are it will take time for those
> applications to get updated. So revert to old behavior
> (for now)?
> 
> Old kernel (5.19):
> 
>  $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>             --dump getroute --json '{"rtm-family": 2}'
>  Recv: read 692 bytes, 11 messages
>    nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
>  ...
>    nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
>  Recv: read 20 bytes, 1 messages
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
> 
> Before (6.9-rc2):
> 
>  $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>             --dump getroute --json '{"rtm-family": 2}'
>  Recv: read 712 bytes, 12 messages
>    nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
>  ...
>    nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
> 
> After:
> 
>  $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>             --dump getroute --json '{"rtm-family": 2}'
>  Recv: read 692 bytes, 11 messages
>    nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
>  ...
>    nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
>  Recv: read 20 bytes, 1 messages
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
> 
> Reported-by: Stefano Brivio <sbrivio@redhat.com>
> Link: https://lore.kernel.org/all/20240315124808.033ff58d@elisabeth
> Reported-by: Ilya Maximets <i.maximets@ovn.org>
> Link: https://lore.kernel.org/all/02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org
> Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: donald.hunter@gmail.com
> ---
>  net/ipv4/fib_frontend.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index 48741352a88a..c484b1c0fc00 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1050,6 +1050,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  			e++;
>  		}
>  	}
> +
> +	/* Don't let NLM_DONE coalesce into a message, even if it could.
> +	 * Some user space expects NLM_DONE in a separate recv().
> +	 */
> +	err = skb->len;
>  out:
>  
>  	cb->args[1] = e;

FWIW, on current net-next this fixes the issue with Libreswan and IPv4
(IPv6 issue remains, obviously).  I also did a round of other OVS system
tests and they worked fine.

Tested-by: Ilya Maximets <i.maximets@ovn.org>

