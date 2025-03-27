Return-Path: <netdev+bounces-178030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55A6A74109
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DF8168D53
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200E1B6D08;
	Thu, 27 Mar 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wQyc2Qeg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E44125B2
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115542; cv=none; b=cS08FOf0q7YT9yrf+aQty9myuxbXBkdagxxuUncBZBHdL1d2Ode6SrnpwK62gGjKkyWiYQhHoOCae5GvQS9E3lHISIbJ8k4ZtyOCNaCOUAq/Wgz8xfji3qOHMkdXoDInDX77wK8ztNrpWeoijb8rN4Jo+fbW5wbynV9xo/JP4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115542; c=relaxed/simple;
	bh=rFD2038oSmfRL/o5UroxR35DdxxjZH24ChwRQngmNXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuSd4oYtxQ2ruRIuatYtv8uEQSK9aQs/JeX8UsZt2DLYnONhggHhg2YMhFQRkdae8g+i6X2K331cvMRnCB2aObWcQHVP1O1ojaeLJLYVVpH6AdByFLvjxdq1UE/O9jbyGyFTYhyBv5CWU2RxiSIautZhqLEgnWjpN6IIC7SKK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wQyc2Qeg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso260488566b.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743115538; x=1743720338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tj6ciWOlt5kGG5xdV8VuXH1Me4APKwNx0YShqVsUWxk=;
        b=wQyc2Qeg5PQMLOTidIrh6IGlxIgOgxEJh8Qr/yUgX2qRaTSJmYweH2kLECepw2hkOt
         X7EL0f1qnWvjGH2nSEPR4smDOn1xoCe7PZNeUfMdtlPZ/ghp0j6f/o9ovhrmA3oUlJ+c
         GTEkin5pbb4hwy+1dijzWML6xZH8eCZWXlgJa2nR4KJS3xn0L/LkJcQgQ2pO5iaTsuLJ
         IVBTeKksR3o5eFuPaI+JFMobqNxcv7drJrgyaSAdl88szxd5wXyaON51SPEcUDpBnPLh
         1dmx+VCD5a/mmZWqTU5VoFpBtoU9aO1L+4NBkj66UIu2e1dUYj7jY5bZqGAWEz/0I2KA
         m+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115538; x=1743720338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj6ciWOlt5kGG5xdV8VuXH1Me4APKwNx0YShqVsUWxk=;
        b=n7d1CoRKU9U1xurdcELovchN4h7me/rl/vMHv4uujZNYPxz4Lr81oW797mnYmFG3gm
         ZkABtMi2olL7OzsA4lMwnPrVgiPQffuPJ1aLmoE2h/W37tDPWczLNeslTD7VxO+jp+iO
         BID637jOjkb00uCSU18BpTeYrsXUuvTpQ5IWOrOJcqL9A7Xfu7vSwDa/dKPwA/6xqaaX
         VyydPzeUnlijoah44URvDtaU0Kt9siKm3a+K/OvLehzBatMBVVldW+pvmzFzSpDhki1G
         xeRYR0Xph4GVQlpyxz98t/a+srJQrxyOIPihIC++Wd5B1GcbNVqGJPc3px6vO7ySchRK
         QctA==
X-Gm-Message-State: AOJu0Yy0T40oL9ikjmhpzY7F41dcvXRgHNgdlOBm6CI3YTPI7MI5n437
	ijKqWbf1Z2Zpaad6nYS6cD9HDcAJ2kPo/QejHbZeo/WeLKrDVLuus/BYl+kfVdc=
X-Gm-Gg: ASbGncvDzMegeQi3ar9kGUaSduIHxOfHjCK8EW2VHvauCRKv3ZifMr23kL36K1NrUWq
	3b3UW4UAm66WQbJANClUjdMHq/yT6ennjyjkU3qkfHjXWL2knqC4nuL/wmzsrCoi7orGdIV5WkM
	covlJlpk66OISMWSVkbRQ8PI8ulC07XmxIndRDzRuJlgF5QLR9TwQzlQFkP3jj/mn7pJayNgGqw
	6PtVsJrjtlQTMVBgtxT7oVgly/g1jDWVT9D3TG8/CHZ7cgygIYBam29/chpJlEe3HNg95Y2sTxE
	4ElE46jIX0Riow0uRAKerFl8dvJhswemsXu1eiqx437z/hjQsh8=
X-Google-Smtp-Source: AGHT+IHwTbd8wqwGflE+/l8QLV4zYq2nasQtO/eu8493RQYDi8+P7mGbK4Y9sngIRgO/EYydTV0feA==
X-Received: by 2002:a17:907:7295:b0:ac3:b115:21b8 with SMTP id a640c23a62f3a-ac6fb13f5c0mr551708366b.47.1743115538218;
        Thu, 27 Mar 2025 15:45:38 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.74.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922b965sm62396566b.20.2025.03.27.15.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 15:45:37 -0700 (PDT)
Message-ID: <190cbaa8-1223-4e64-a583-daf9dfe608f5@blackwall.org>
Date: Fri, 28 Mar 2025 00:45:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: set skb->protocol for 802.1Q VLAN packets
To: inuc@qq.com, bridge@lists.linux.dev
Cc: netdev@vger.kernel.org, roopa@nvidia.com
References: <tencent_4B358ADB8A54F04A32CD9933114B8B383606@qq.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_4B358ADB8A54F04A32CD9933114B8B383606@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 20:11, inuc@qq.com wrote:
> From: Liu Jie <inuc@qq.com>
> 
> When bridging locally originated VLAN-tagged packets, we must ensure
> skb->protocol is properly set to ETH_P_8021Q. Currently, if this field
> remains unset, br_allowed_ingress() may incorrectly drop valid VLAN
> packets during the bridge transmission path.
> 
> Fix this by explicitly checking eth_hdr(skb)->h_proto for VLAN tags when
> handling locally generated packets.
> 
> Signed-off-by: Liu Jie <inuc@qq.com>
> ---
>   net/bridge/br_device.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 0ab4613aa..9094ba7e4 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -63,6 +63,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>   	skb_reset_mac_header(skb);
>   	skb_pull(skb, ETH_HLEN);
>   
> +	if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
> +		skb->protocol = htons(ETH_P_8021Q);
> +
>   	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid,
>   				&state, &vlan))
>   		goto out;

Why do you think the protocol is incorrect? Did you see a problem with
some particular setup?


