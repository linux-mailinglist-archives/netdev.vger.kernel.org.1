Return-Path: <netdev+bounces-289776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG4OAShXDWp4wQUAu9opvQ
	(envelope-from <netdev+bounces-289776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:39:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49458841D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEAB13025294
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7793264D5;
	Wed, 20 May 2026 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVFK+2oo"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB12772E
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259172; cv=none; b=c46eIv/ysVOygsndhbCe/NYYhodWPR1CtRRQyORx+P1z4K+0djnT/RzCFz+0ZMrSK3GY8FviBPz+tJwbSat3fQ3mvnFsxhShwd00/IzeNdT6G8fy6otib2lYEmqFnCBFx1C8jAMebEVhlGS4OWqLw3y+JTTtr86XIN9aWWxW3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259172; c=relaxed/simple;
	bh=G9YObRbn7FyUP+d8PJ+dI4Tvdp/EUY0J8aKHGnzu3f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZsxN8FqrdswHOyJl82WPUSF1aB5G78Pf8givCnK9OgF1yc643Bjo2YDxext6IfDFc5jf0uWoVLlIETf+QZvprKL0oPd4Vly814/NVxoLdRfhswQt3tZLKLQd3+ghsB756AKwC64lIE5smjtQ/zsDPpfu5mbN+RY/dUGYgrvcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVFK+2oo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7cf35e75-28a6-40b4-86d5-82b0aa9773bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779259168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VS63f0SQXp0YYrkvpu+Ut5OR4TyOTvu00sYK25+llw=;
	b=rVFK+2ooCe+s1qUlIqsyYfg2l3g7T249B6Cw4prECA3od3StnQ8H4g3q64UorzEj8SsiKJ
	jEboaAeRQ0x7mIzvJQ181P0LJOfsKCNsacEX331SnKe5aIrdGEhlOHMZuo1q/zzfAQpNf2
	lpumkI0Z0bvtgPDkxGE9xtBz/Qo1WTo=
Date: Wed, 20 May 2026 14:39:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv4: use WARN_ON_ONCE() in ip_rt_bug()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260519193248.4018872-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260519193248.4018872-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-289776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B49458841D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/26 3:32 AM, Eric Dumazet wrote:
> It turns out ip_rt_bug() can be called more than expected.
>
> syzbot will still panic (because of panic_on_warn=1), but non debug
> kernels will no longer die while repeating stack traces on the console.
>
> Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/ipv4/route.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index bc1296f0ea69b0705e00e547a0d550129e03326a..3d62d45d84bda986db8b3592c0c7f5c81da3fb7e 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1272,7 +1272,7 @@ static int ip_rt_bug(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		 __func__, &ip_hdr(skb)->saddr, &ip_hdr(skb)->daddr,
>   		 skb->dev ? skb->dev->name : "?");
>   	kfree_skb(skb);
> -	WARN_ON(1);
> +	WARN_ON_ONCE(1);
>   	return 0;
>   }
>   


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Recently I backported one missing patch to stable because of excessive
ip_rt_bug() prints. So I think it is reasonable to carry a Fixes tag for 
backporting.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=da54b3039d436227deebbc202cefea63bd318a38


