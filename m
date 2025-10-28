Return-Path: <netdev+bounces-233534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99BC152CD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF645824E5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71232ABC3;
	Tue, 28 Oct 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EEJhAqup"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147432FFDC2
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661665; cv=none; b=cO8fhm1nQJospGsIdGP1FOCESClgn6ZQr8sF+Pcrku0crCbMQM3dwbAwZYHss50xPtMvW69m73XepQRHJGSMUGgRLFoctCRCbphKCiYskyIxOHX5Nbcnz4gaooDI5kH2eqxG0m3fiyMeMkVu0CQ/sYyVHpzfRNjjZ8qPNxwnAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661665; c=relaxed/simple;
	bh=wIpOHx9wXqfE+nMCB386FF93OASZcscl5qRTfZCgkUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CugxNikM4tquo454fSoLVv7UncTJwp79A8OFj139fHFdQzNP4Snr4uWAwCfJPXT5YOCXYyIoLJAFjsgdUSinupSaRiTtrmk4KvE7n/Pnn4KelNjXByVfSH0JYMsFTJeqMw5z/8wHLP0VVddoTkGKSb2cZuasvtUDQHrJj2dwzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EEJhAqup; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4e528ea-f641-4ab9-bdde-5bd6beb65b8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761661661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBEHPJdb/QvpxdS/JR+fDEp1zAvCfYjRdkyxYCfFyKE=;
	b=EEJhAqup00uoOtKmh4ttbv8nil35vumAUP34rxGjRJ8IL23P2uXkfTMhqT1Ne/XPufcJyj
	T0QN+3i2mNLL5QxZEcyC8/odlQ7s/P/xf7OnUsMM1UmS3U8+DhVAojynFnF92nweGAfuTA
	udNMz3qGCKcaGKCRtZ0sUQj7l7z1ioE=
Date: Tue, 28 Oct 2025 07:27:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec v3 1/2] xfrm: Check inner packet family directly
 from skb_dst
To: Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, steffen.klassert@secunet.com,
 sd@queasysnail.net
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Raed Salem <raeds@nvidia.com>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-2-jianbol@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251028023013.9836-2-jianbol@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/27 19:22, Jianbo Liu 写道:
> In the output path, xfrm_dev_offload_ok and xfrm_get_inner_ipproto
> need to determine the protocol family of the inner packet (skb) before
> it gets encapsulated.
>
> In xfrm_dev_offload_ok, the code checked x->inner_mode.family. This is
> unreliable because, for states handling both IPv4 and IPv6, the
> relevant inner family could be either x->inner_mode.family or
> x->inner_mode_iaf.family. Checking only the former can lead to a
> mismatch with the actual packet being processed.
>
> In xfrm_get_inner_ipproto, the code checked x->outer_mode.family. This
> is also incorrect for tunnel mode, as the inner packet's family can be
> different from the outer header's family.
>
> At both of these call sites, the skb variable holds the original inner
> packet. The most direct and reliable source of truth for its protocol
> family is its destination entry. This patch fixes the issue by using
> skb_dst(skb)->ops->family to ensure protocol-specific headers are only
> accessed for the correct packet type.
>
> Fixes: 91d8a53db219 ("xfrm: fix offloading of cross-family tunnels")
> Fixes: 45a98ef4922d ("net/xfrm: IPsec tunnel mode fix inner_ipproto setting in sec_path")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Thanks a lot. I am fine with this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
> V2:
>   - Change subject prefix, and send to "ipsec".
>   - Update commit msg.
>   - Add Fixes tag.
>
>   net/xfrm/xfrm_device.c | 2 +-
>   net/xfrm/xfrm_output.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 44b9de6e4e77..52ae0e034d29 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>   
>   	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
>   			    x->props.mode == XFRM_MODE_TUNNEL;
> -	switch (x->inner_mode.family) {
> +	switch (skb_dst(skb)->ops->family) {
>   	case AF_INET:
>   		/* Check for IPv4 options */
>   		if (ip_hdr(skb)->ihl != 5)
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index 9077730ff7d0..a98b5bf55ac3 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -698,7 +698,7 @@ static void xfrm_get_inner_ipproto(struct sk_buff *skb, struct xfrm_state *x)
>   		return;
>   
>   	if (x->outer_mode.encap == XFRM_MODE_TUNNEL) {
> -		switch (x->outer_mode.family) {
> +		switch (skb_dst(skb)->ops->family) {
>   		case AF_INET:
>   			xo->inner_ipproto = ip_hdr(skb)->protocol;
>   			break;

-- 
Best Regards,
Yanjun.Zhu


