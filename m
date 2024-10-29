Return-Path: <netdev+bounces-139874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5909B47C3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2283D1F242CA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13B204F90;
	Tue, 29 Oct 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVWfOZc4"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C220492B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199531; cv=none; b=nXbSWzHwZe0SPwn6SovSEWYyJwFYniHhYaGZXnJZANOFyt6uC1TozCnnvlHGUIFPJr4skorzMlp1FIS9vj+U1cHKQ2m7N6yQYGhKHZaHvZ205KWhtdPEw17hK7DATv4viCIsdYPtBHbiO1I+G2Ro3TDhEP6GwGfB8ep1Vw8PbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199531; c=relaxed/simple;
	bh=jE775orIHl/zy2s+k5hOgL2vYd8qb4FFjQtfxIEvjnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkvQHOG29R082UttI9+46Hy8m5wm0mgX5nYpndDide61baMFK7ntKfvNHdONk+8D2CDyiM92tp63ll3Zv3y/rYCqUh+dmksIYeS9ZkTLZsmkXEfesugcaE/3XnQLLsrEpMN5TZctR2b14DZ7Bk76zlMiBerWAs0G5ZgD9Ky15eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVWfOZc4; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f4668e71-796d-4fcf-994a-db032c6c43b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730199526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ub5FWCH7w+9in2TZ/Sldo0RcMQcoiIkY60kZ41MTpU0=;
	b=LVWfOZc49els2x+SgiBbh6tp0JJjRzY4ow7ACbe79uGPAY2QBo1i31+KXH42R1vb8Fdic+
	AkH9FWi+QSZSMAke80T+Be8nnDHLyrJVw4zFLoWMA2P1giO0OA1u2GOyDrjwlZxPt5R1HB
	7mKwjnfTO7ANo4gZ7SYhjK9WV3Ujzt0=
Date: Tue, 29 Oct 2024 10:58:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/3] net: ipv6: ioam6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
References: <20241028223611.26599-1-justin.iurman@uliege.be>
 <20241028223611.26599-2-justin.iurman@uliege.be>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241028223611.26599-2-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/10/2024 22:36, Justin Iurman wrote:
> This patch mitigates the two-reallocations issue with ioam6_iptunnel by
> providing the dst_entry (in the cache) to the first call to
> skb_cow_head(). As a result, the very first iteration would still
> trigger two reallocations (i.e., empty cache), while next iterations
> would only trigger a single reallocation.
> 
> Performance tests before/after applying this patch, which clearly shows
> the improvement:
> - inline mode:
>    - before: https://ibb.co/LhQ8V63
>    - after: https://ibb.co/x5YT2bS
> - encap mode:
>    - before: https://ibb.co/3Cjm5m0
>    - after: https://ibb.co/TwpsxTC
> - encap mode with tunsrc:
>    - before: https://ibb.co/Gpy9QPg
>    - after: https://ibb.co/PW1bZFT
> 
> This patch also fixes an incorrect behavior: after the insertion, the
> second call to skb_cow_head() makes sure that the dev has enough
> headroom in the skb for layer 2 and stuff. In that case, the "old"
> dst_entry was used, which is now fixed. After discussing with Paolo, it
> appears that both patches can be merged into a single one -this one-
> (for the sake of readability) and target net-next.
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   net/ipv6/ioam6_iptunnel.c | 90 +++++++++++++++++++++------------------
>   1 file changed, 49 insertions(+), 41 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index beb6b4cfc551..07bfd557e08a 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -254,15 +254,24 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
>   	return 0;
>   }
>   
> +static inline int dev_overhead(struct dst_entry *dst, struct sk_buff *skb)
> +{
> +	if (likely(dst))
> +		return LL_RESERVED_SPACE(dst->dev);
> +
> +	return skb->mac_len;
> +}

static inline functions in .c files are not welcome.
consider to move this helper to some header, probably dev.h or dst.h
and reuse it in other tunnels.

And please honor 24h rule before the next submission.


>   static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
> -			   struct ioam6_lwt_encap *tuninfo)
> +			   struct ioam6_lwt_encap *tuninfo,
> +			   struct dst_entry *dst)
>   {
>   	struct ipv6hdr *oldhdr, *hdr;
>   	int hdrlen, err;
>   
>   	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>   
> -	err = skb_cow_head(skb, hdrlen + skb->mac_len);
> +	err = skb_cow_head(skb, hdrlen + dev_overhead(dst, skb));
>   	if (unlikely(err))
>   		return err;
>   
[.. snip ..]

