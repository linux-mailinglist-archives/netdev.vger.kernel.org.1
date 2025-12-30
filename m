Return-Path: <netdev+bounces-246312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92BCE93C0
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1863E300EA19
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010229A9FA;
	Tue, 30 Dec 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WUeF32OW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032A27FD49
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087506; cv=none; b=Agq6BCv9wxJY4n6c/Vuzk7S9jvf/8S1VjF+XK+JlV+ypQlyP7xAVov8pfcIXFGVKUQ4ipCXDqge18c1vVD/ZXjdTHfE3dqNbeo/R/mCoQp3miANcPkIwGRi5tSHDNjWlZxIBI50BzJZo8Ho27jcCI5rNxnZxquOIrmlOt6+nWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087506; c=relaxed/simple;
	bh=Yx1xLepdNnWcnF+l7kx6ZMGgmQoKThZII5a1vR1Ex2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srFD2RcxvAVc/2zMjRMaELpiy3hWp+JfxndVsgvpc2KQ+aHGoC5AesT+wvA05et2lx/2VmeXCV0seamNzpkyV+1ijmipLO5DjYDXDJf0jSyFIfTsaGT+W+cCFR7zCSkV4d0lIjuUD2isIVM4Jm29uAAi5+Ga1gPZFcUOBfqP20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WUeF32OW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so74837515e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767087503; x=1767692303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oczANHKLh29brd1AFdZnRNdymyiomFSHwFPBSf2l2n4=;
        b=WUeF32OWOtuFrpVQwB69wT7UKc2Sxjo9PJAMTo0sn0j+EJe9/KhNJpKzWXQowBUenF
         ukBrxY902tS9qDebfi++gBJKT4vHLiV6LnOkxOeTFGfN83PKE3O6qzJzRn3ruQCrgQEl
         thq2BhRMKSmmglUj5WpLrXXofG8qVrGRWMtKOkwlKrF2b0q6+66sosFWF68Vu3a1s25+
         QAaQhA6/siYmh53B9gml2Z1r4D0n32h2uvNx1+UyrrtbI+inrbXi42+k8Rx2rkgKFgS/
         SyK/APLl9mqWe+y47WO/evtHXcq48AKDsTqDEgSvF1uFXTIf2fUL93ROlUMT+ZNo0E1K
         ilMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767087503; x=1767692303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oczANHKLh29brd1AFdZnRNdymyiomFSHwFPBSf2l2n4=;
        b=hM2plfwCI1jw4pomjbJCfy/0XxzIfBZ0+LQcc0rDtTK/i+fLtL7sUpHcH0l4fGz8j6
         4TpPWwZsAe8lVgeEefhyb12SKqt0jRJC89hQONfopRkHtQEVd3JOKXcyStMcdPAb9poH
         tt02wb6qbHUGDnVw8kPKs95+NqgbedwE8VUo0DukAzYkPsCRYO2H79BcLM9wAG7Wr6ys
         6mN8imZoTIG/mhiFkJhmTTeZ2dlMneIvMGjSclMtC7j/Lg9D3XoxD4sWy7AA6dDFYM4R
         n8utYRKbtfaLzEEiQb70FISKcqcwVDmZeAocVDzP2/kkL5SKXYjB5WeaZyUk+7GLFtak
         We7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo8+5HoFw6A5MhxH7lbCRAiHKKjr1pNXjpCtXX0wqQ1FFrSO2XKasJZkXe1VcufaZP2HtbCcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTl97h8dSG9gqL4JhlO1LZcmZJJWBZQgCk/i9/PqJIllAqQcPR
	9bqQ6MUuV2L2Sgr3OwdWXSRBPZlIKPbvhP3RjTBi71wH+snvvA8DWkFw76R+d0KOcoM=
X-Gm-Gg: AY/fxX7O/Wqmkvznc1qsrAdJqhaz33Pa9QiK41huVqnD1JGcKqhK4KNcbXBrk1bh7US
	+grjwB3DRyyi9A7Q3em5GaCPFs0Ub++Gi5cHtJ9n/GTWxgz0KO73l3VRCAv/m6ujcIAhwaoAb7z
	568r6y/bnclqZcsz77NvP2PNiprsfhGF5vaIS8dGXdQUqmiiaYtErXaDkfFuHqxJvNd/oyc4zU5
	zprMgN+LxDRLG0n+WKHl979zs6KSBonl8CDAYNn2/qu6GLPqhUBWbJQa3nwHTN+yc/YGAw6YACt
	Uuv2C0sB3WJlFO+N2CCHiSJfvbpjn2H/eDmbAXhARdG27OF0jOJATbo63khdefIpY4FcFgVAE6e
	qkVTU0XiPLHz0nfRjNqSEsLjDE+JhPGO7hQg/sYVSSnkWTR2BRgB8cTbRVBsr5FvhNGKy4tP92G
	YQoY2xKewM24g4oMeExWo2s2SlaWG0hzYE9nzmC6nUHA==
X-Google-Smtp-Source: AGHT+IGLOTUR1No0HXhIWRdfwPN90clv38Ue1E8+AEavm5rVD3TJcq6J0g5GX9Ob16q2RxRWFQzMtA==
X-Received: by 2002:a05:600c:1914:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47d1955b79amr354642695e9.7.1767087502228;
        Tue, 30 Dec 2025 01:38:22 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm579122265e9.0.2025.12.30.01.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 01:38:21 -0800 (PST)
Message-ID: <7cde982c-a9c1-4b9e-8d73-458ebede9bcc@blackwall.org>
Date: Tue, 30 Dec 2025 11:38:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad
 vlan_tunnel egress
To: Alexandre Knecht <knecht.alexandre@gmail.com>, netdev@vger.kernel.org
Cc: roopa@nvidia.com
References: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/12/2025 04:00, Alexandre Knecht wrote:
> When using an 802.1ad bridge with vlan_tunnel, the C-VLAN tag is
> incorrectly stripped from frames during egress processing.
> 
> br_handle_egress_vlan_tunnel() uses skb_vlan_pop() to remove the S-VLAN
> from hwaccel before VXLAN encapsulation. However, skb_vlan_pop() also
> moves any "next" VLAN from the payload into hwaccel:
> 
>      /* move next vlan tag to hw accel tag */
>      __skb_vlan_pop(skb, &vlan_tci);
>      __vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
> 
> For QinQ frames where the C-VLAN sits in the payload, this moves it to
> hwaccel where it gets lost during VXLAN encapsulation.
> 
> Fix by calling __vlan_hwaccel_clear_tag() directly, which clears only
> the hwaccel S-VLAN and leaves the payload untouched.
> 
> This path is only taken when vlan_tunnel is enabled and tunnel_info
> is configured, so 802.1Q bridges are unaffected.
> 
> Tested with 802.1ad bridge + VXLAN vlan_tunnel, verified C-VLAN
> preserved in VXLAN payload via tcpdump.
> 
> Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")
> Signed-off-by: Alexandre Knecht <knecht.alexandre@gmail.com>
> ---
>   net/bridge/br_vlan_tunnel.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
> index 12de0d1df0bc..a1b62507e521 100644
> --- a/net/bridge/br_vlan_tunnel.c
> +++ b/net/bridge/br_vlan_tunnel.c
> @@ -189,7 +189,6 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
>   	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
>   	struct metadata_dst *tunnel_dst;
>   	__be64 tunnel_id;
> -	int err;
> 
>   	if (!vlan)
>   		return 0;
> @@ -199,9 +198,13 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
>   		return 0;
> 
>   	skb_dst_drop(skb);
> -	err = skb_vlan_pop(skb);
> -	if (err)
> -		return err;
> +	/* For 802.1ad (QinQ), skb_vlan_pop() incorrectly moves the C-VLAN
> +	 * from payload to hwaccel after clearing S-VLAN. We only need to
> +	 * clear the hwaccel S-VLAN; the C-VLAN must stay in payload for
> +	 * correct VXLAN encapsulation. This is also correct for 802.1Q
> +	 * where no C-VLAN exists in payload.
> +	 */
> +	__vlan_hwaccel_clear_tag(skb);
> 
>   	if (BR_INPUT_SKB_CB(skb)->backup_nhid) {
>   		__set_bit(IP_TUNNEL_KEY_BIT, flags);
> --
> 2.43.0
> 

Nice catch. As Ido said, please use get_maintainer.pl next time.
The change looks good to me as well. Thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




