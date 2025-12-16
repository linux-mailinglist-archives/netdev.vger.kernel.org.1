Return-Path: <netdev+bounces-244906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626BCC16A8
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 883E03007A97
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52848339B3B;
	Tue, 16 Dec 2025 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IGe0nUns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5805339708
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871921; cv=none; b=fgebpJvgpzc11nIsf3uPOhoXHs0voXDCZiCSIVzK8mr7P8jxUEEcYQgfZxPzOrE5Kknsf7RWnF9odFUXYmAPMimapfj/GrVx49fQIVKZ8uxbQmOItdZxUMlWCXARH0fr8qhTkbHjuiZSfxEcipoTYQF427gzf12bl+BiPUHWEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871921; c=relaxed/simple;
	bh=DK7icG0xbloyzh33AbYb45dyPUaU85bnSKimNzCLxKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bupuvI22X/qRTSAPpec1oK/v+F9FQKGGwub9aScxBoF2hulIoR5AyVxZUZ341V2myBDQ/FMPHMxIbAfS9bI4wGQmnc9dGB4naaa1ocWm6+BtAzb6g5RLrCVjTyXe8KNSVilkN/Gn5SsK5TK7Pc2xj4PiQSbk28olS5br1AswhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IGe0nUns; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso1702644f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1765871916; x=1766476716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97+Mtmy/QOkXKgRJz1EGvFd6epy5X9AZxAMhh0WtV8U=;
        b=IGe0nUnsSuWnV3zyqWB0qcX/PmA1RfbpFMJRu0X4cDcloynKidt51EEqdmBUc2OHwN
         bFrLIrlpEbYP9MIHyvuqKQFTDFj3Hru4WebMAykE6Drqu2jG6FEkRabb50B6ios3lZUP
         9yQ2vQ+TdJQ/FalKU/GWHHw8joi/89CnU3kKR+61V0DdrDpvRDDh7B/Jp+n81hR2f6D0
         QWOKtN9xcNHEu7xUe6+ty7ovUZi219wYsYquLAfaWN2LfiTooCed3kaUkmpU4/8yilQ7
         8Q1GDGGriXWSAM7Eh32HB+3njL94FhQp1CHHqiSaW+lEiqZ/2yPEo849V1LfBaG8Y/nD
         VN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765871916; x=1766476716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97+Mtmy/QOkXKgRJz1EGvFd6epy5X9AZxAMhh0WtV8U=;
        b=oQZgHmdtoVSknfLVO8QYGj85h0e8/5jV1HKKCnlFf/I54S3t7mdWml1WIKD/bBN+GH
         sKfiVGVeMF+Lxge67dIbrsUeBVSGe0GMM82MpvLtripTzvA7CAu0cRs+BjwoCOIl3xhU
         R0oz4U1+W0ma3belxZJBa68akT1p8BXmDUjCESTuiUHEpPSil2Hmk/+s4UFzWEkSyZ2b
         OSP6qoZSwpzMMlHTYZruR4AoXxiTgynuWhN9pZjRdi1c052HPPsrV4pC0+mUPIhDX673
         Zz9bMrV7jgXkznMSGvfgLXwK16dTdqj1CFwNbFizBH61eFSzz/AgtfW1bVepDrRO28yM
         NuUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfs7lTQEZIawBxa+3oyHMm0Bwspu+2o60Lpp7bb03sftbYoB6w4e4Fa7sHI8jQ0vlzjXJ7kDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpeIbgKH8rJfIudI4zBrtWtDabNU0ExpKh5tlWHJJyIVs6sdn
	QDSfazK6NktgPpHB5yfEJR+8pOItGsfVLYnvFja191KsdpnuZqkyyER7pFCmuc/7/EI=
X-Gm-Gg: AY/fxX6GRmdu6lHAsTf+T8dlOM+rx1duIY1oPlqp8OVqCGPGuOVhKdU8nU5GnRKA3na
	Rbydk8wmFTIYPnG9OuuDaPwPUtAVcNBJnT3j+6tz/Wa0xiQxPX2qU0ZFeLoSFHbRP+1uLaBXoy5
	/rg7zd6JFAc0mdkD6B6XqtchkUzryrMS6L5BCJO5WzhvOLlElfBKVlAXeYlnpQFbT8FgsGuV6Kw
	MgeEcABVvIpiRyiT9NzF23yDeFkSrSc4waTNYRLDFEgv0cb4GStsvvTS82nEH7HVWTn42LtEjPM
	MusOQNH99Bqo+VQ0Y9O0YGWvvEQ1ckt0qeFM0nXvpmjKezxsYjZ0FZhg6XodGZF6qiOXpX90ikO
	99zSpuBN/mYz4BoMgVm2wEZ10Sgb2k8AB/vNGcf92A5BdaaxblMH7fXuOJ9eRwAVe5E5PYr74GJ
	icrqT/li8PSCDYUmBqGQW/+Z+9bDiE9OjvMWvtA+OLrg==
X-Google-Smtp-Source: AGHT+IH3fMt96wP9+5/cjnguTDIZz8YgGHxMBC46sU92EVfEEwlbtcITHEH6mygiqdo5JACpONinJA==
X-Received: by 2002:a05:6000:4201:b0:431:74:cca with SMTP id ffacd0b85a97d-43100740d6cmr4977272f8f.44.1765871916089;
        Mon, 15 Dec 2025 23:58:36 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430fa5f6ab7sm14452090f8f.25.2025.12.15.23.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 23:58:35 -0800 (PST)
Message-ID: <32b3de64-93d5-4342-8255-6e6f991b933a@blackwall.org>
Date: Tue, 16 Dec 2025 09:58:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vxlan: fix dst ref count leak in the vxlan_xmit_one()
 error path
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: petrm@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251216033647.1792250-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251216033647.1792250-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2025 05:36, Wentao Liang wrote:
> In the vxlan_xmit_one(), when the encap_bypass_if_local() returns an
> error, the function jumps to out_unlock without releasing the dst
> reference obtained from the udp_tunnel_dst_lookup(). This causes a
> reference count leak in both IPv4 and IPv6 paths.
> 
> Fix by calling the dst_release() before goto out_unlock in both error
> paths:
> - For IPv4: release &rt->dst
> - For IPv6: release ndst
> 
> Fixes: 56de859e9967 ("vxlan: lock RCU on TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/vxlan/vxlan_core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index dab864bc733c..41bbc92cc234 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2479,8 +2479,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>   			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
>   						    dst_port, ifindex, vni,
>   						    &rt->dst, rt->rt_flags);
> -			if (err)
> +			if (err) {
> +				dst_release(&rt->dst);
>   				goto out_unlock;
> +			}
>   
>   			if (vxlan->cfg.df == VXLAN_DF_SET) {
>   				df = htons(IP_DF);
> @@ -2560,8 +2562,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>   			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
>   						    dst_port, ifindex, vni,
>   						    ndst, rt6i_flags);
> -			if (err)
> +			if (err) {
> +				dst_release(ndst);
>   				goto out_unlock;
> +			}
>   		}
>   
>   		err = skb_tunnel_check_pmtu(skb, ndst,

Did you check what encap_bypass_if_local() does at all?

There is a reason why the code jumps to out_unlock on error,
encap_bypass_if_local handles that case itself. Don't blindly
change code, first check what it does.

Cheers,
  Nik




