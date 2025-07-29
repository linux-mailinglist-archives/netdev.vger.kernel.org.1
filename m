Return-Path: <netdev+bounces-210839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14EB150D5
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC981161183
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FCD199934;
	Tue, 29 Jul 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HqtHokrh"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F0288CC
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805217; cv=none; b=VcNyTbyFgDVQlXdGYTdzM7NVNnsqvlXpi4L1pp4Ab7ejJqm3tut5sPNhPdDLl7zZfekSc7X0nUykHrjHorwAQS+FbDXQ94m/rOwCqlaFr3DEQQVF1XV6A860BnsLmEjXODNwtSioxiAcAHeZkH9m6JDep6vWtDgHgIm9gWJ1m1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805217; c=relaxed/simple;
	bh=kW3PkXtwPAtY4fOiKgAs/Qq/x6VAMIjsmzJuBCwSDDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLH0Cwu3NivmtQf2fcUVnKTFM1uM1A+iLO9wf4A+uLV6HDMsa8a9uyruzFzTteSlXOva3pd08BNA3I7pUDA8++Ojas6vQpLJQx9DaOCuFTUJ7Dw2bX1Mo6+q6SmHYvnyMRxhcOnX+0Al30zwepr2GoXP4LReYRLk9erqxQgVLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HqtHokrh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f86f5c83-0fc2-4c40-b8f9-f20f5b755cb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753805214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Q71nj4y2C8OlFpn2rtu/5OnUh3Mr7aN069iljhmzkg=;
	b=HqtHokrhSTp79hgxAXsEtlgJ2XdP0Nfibjy7HkQpQH0S550dEbK3eQ+dlCblZ/d6ldyRlI
	0dcJwCKFeNgW7DCmjeMLiWyvbAftmZWVkpoa1XATyyPyBQqgCt69T3pO+nZYEWz+nojZK7
	15Okl8ZqEXjJevEe//Bq92SknCjCvD0=
Date: Tue, 29 Jul 2025 09:06:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec 1/3] xfrm: restore GSO for SW crypto
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <cover.1753631391.git.sd@queasysnail.net>
 <b5c3f4e2623d940ed51df2b79a2af4cc55b40a55.1753631391.git.sd@queasysnail.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <b5c3f4e2623d940ed51df2b79a2af4cc55b40a55.1753631391.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/7/28 8:17, Sabrina Dubroca 写道:
> Commit 49431af6c4ef incorrectly assumes that the GSO path is only used
> by HW offload, but it's also useful for SW crypto.
>
> This patch re-enables GSO for SW crypto. It's not an exact revert to
> preserve the other changes made to xfrm_dev_offload_ok afterwards, but
> it reverts all of its effects.
>
> Fixes: 49431af6c4ef ("xfrm: rely on XFRM offload")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   net/xfrm/xfrm_device.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index d2819baea414..1f88472aaac0 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -415,10 +415,12 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>   	struct net_device *dev = x->xso.dev;
>   	bool check_tunnel_size;
>   
> -	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
> +	if (!x->type_offload ||
> +	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
>   		return false;
>   
> -	if ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
> +	if ((!dev || dev == xfrm_dst_path(dst)->dev) &&
> +	    !xdst->child->xfrm) {
>   		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
>   		if (skb->len <= mtu)
>   			goto ok;
> @@ -430,6 +432,9 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>   	return false;
>   
>   ok:
> +	if (!dev)
> +		return true;
> +
>   	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
>   			    x->props.mode == XFRM_MODE_TUNNEL;
>   	switch (x->props.family) {

-- 
Best Regards,
Yanjun.Zhu


