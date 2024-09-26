Return-Path: <netdev+bounces-129901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BD986F4F
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F8EB21A11
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464C1A7254;
	Thu, 26 Sep 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9vnhjzP"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA218E37C
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340661; cv=none; b=Jpaxt9UbArlIuGND1YhGlrVY9W3S+/BWSN/QBtnQ+QusrBFjbCGNp9buFx1rrmODVUmEEi0ikDgwQh84nlQGQymPqx1POtzyZsSiNOdH+yIcyC0z/CSya2Hpuew2sG8L7TkdKr+tGbQOyBt3Wl1qyqQe9r44FCZbR/bx0+JIiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340661; c=relaxed/simple;
	bh=yETufZoS0lRHCNMnbOu73O3jdm0VL2jpK1Sf5cEA47A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWsT0G6orB9atx7mSYiCwqWGEANE/lRTyM35HGcOEelCshdMGAD6WkSTo9r/BWjaFEPOQbQ/cVEEHDfJjIOnIbBCD4/9mPgG0oCwaAjRf96pavNsZsyFRfaMgBrfEWl5Fku87Qo5N819l/ql7mBPSn3LuL9j1eQkrUT2n//oa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9vnhjzP; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0aab72d9-1bb2-4ac7-b66f-2a337fb9cd1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727340657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+rnWrZWAWlC75h2sJyhYvkZZruzDFMIY7aTo2ro+yk=;
	b=l9vnhjzPHKFQ2FhUiZBAfGoi32jGnh0vPcS5EqNJ+DKr9/LRBPK1D3lvLUlKLojtUCvFX8
	2zOtT2SgaU8xhZ1F7ocGrnSNxVxRaTYY8yzwXZcI+hkUXLhKC/qANX0ogCPAF7wBg7mRWd
	e7/NinIYjmoynFMIN9W77tlCd52YZJ0=
Date: Thu, 26 Sep 2024 09:50:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] tcp: check if skb is true to avoid crash
To: Lena Wang <lena.wang@mediatek.com>, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240926075646.15592-1-lena.wang@mediatek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240926075646.15592-1-lena.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/09/2024 08:56, Lena Wang wrote:
> A kernel NULL pointer dereference reported.
> Backtrace:
> vmlinux tcp_can_coalesce_send_queue_head(sk=0xFFFFFF80316D9400, len=755)
> + 28 </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2315>
> vmlinux  tcp_mtu_probe(sk=0xFFFFFF80316D9400) + 3196
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2452>
> vmlinux  tcp_write_xmit(sk=0xFFFFFF80316D9400, mss_now=128,
> nonagle=-2145862684, push_one=0, gfp=2080) + 3296
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2689>
> vmlinux  tcp_tsq_write() + 172
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1033>
> vmlinux  tcp_tsq_handler() + 104
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1042>
> vmlinux  tcp_tasklet_func() + 208
> 
> When there is no pending skb in sk->sk_write_queue, tcp_send_head
> returns NULL. Directly dereference of skb->len will result crash.
> So it is necessary to evaluate the skb to be true here.
> 
> Fixes: 808cf9e38cd7 ("tcp: Honor the eor bit in tcp_mtu_probe")
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>   net/ipv4/tcp_output.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746bd4d54..12cde5d879c5 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2338,17 +2338,19 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
>   	struct sk_buff *skb, *next;
>   
>   	skb = tcp_send_head(sk);
> -	tcp_for_write_queue_from_safe(skb, next, sk) {
> -		if (len <= skb->len)
> -			break;
> +	if (skb) {
> +		tcp_for_write_queue_from_safe(skb, next, sk) {
> +			if (len <= skb->len)
> +				break;

Hi Lena!

I believe the patch can be simplified by using "fast return"

if (!skb)
	return true;

This will make less changes and can simplify further bisecting.

Thanks,
Vadim

> -		if (unlikely(TCP_SKB_CB(skb)->eor) ||
> -		    tcp_has_tx_tstamp(skb) ||
> -		    !skb_pure_zcopy_same(skb, next) ||
> -		    skb_frags_readable(skb) != skb_frags_readable(next))
> -			return false;
> +			if (unlikely(TCP_SKB_CB(skb)->eor) ||
> +			    tcp_has_tx_tstamp(skb) ||
> +			    !skb_pure_zcopy_same(skb, next) ||
> +			    skb_frags_readable(skb) != skb_frags_readable(next))
> +				return false;
>   
> -		len -= skb->len;
> +			len -= skb->len;
> +		}
>   	}
>   
>   	return true;


