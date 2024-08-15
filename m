Return-Path: <netdev+bounces-118790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725B952CBB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99227B25094
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531381D3643;
	Thu, 15 Aug 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6GdOCC0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE717CA1D
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716942; cv=none; b=NQwvzHavqihxcQk32s6aycGlu51CnhmRaT05AW55vpFE4t8V65pQGaZVkmVl+ePadKT6IfQGrYix4ZF38D1Cadh00Nzzr9AP2R1oQdpBuZedvX7A67CJm8c0l/RO/q+lG9IQ7o40eB38WEpuNkNsSxebtW+B8FBsZh1TaHgP8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716942; c=relaxed/simple;
	bh=AdiUipSYIITQmujXM+dsl0/SAp0EzSVs4dl30+o3xxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE+k30gg928XbHthctRrkGp3DfoFDrkRiu2b1ewx7V4h5ijWq+53so7YnA9ZLusxVmVLI9TAgrwlnOv9QShvFUUqWjR04WeDn58dYG397QB8mUv77lHQVfanmqmVROgpbp9+E0IznEuf684UKD/6EYWsKg5GGx9tY/7CsI297ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6GdOCC0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723716939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6lfx3W6Lwtd9tothv1NiHXO8z6f8pwl7KxDOAFTg+A=;
	b=S6GdOCC0TU7+Q8SmNV0D3qxiAApo4xq+ePVaQAiQDxM+ySXFr1UYgQd2X6kzClE4avzi9H
	CyMeay1B6ZujKLIKllcOR1rIV+zkOrearNeP2lFYIfI2FUqwCHZPZ6YkRdRK8IwvkfyYNO
	RLp+OtzKpCkaFDf1fO6EslcZ+kessNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Yq3kW_ojOD2yQcrB_Y1XNA-1; Thu, 15 Aug 2024 06:15:37 -0400
X-MC-Unique: Yq3kW_ojOD2yQcrB_Y1XNA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36860dd1fe8so89435f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716936; x=1724321736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6lfx3W6Lwtd9tothv1NiHXO8z6f8pwl7KxDOAFTg+A=;
        b=gaozRlVRHcTeANgNwaHCrAG7yzKLKrLW3Nxtl8r0oCIii75T+cgTQSfvZSWj7jAKAM
         0q8v4tPjB8AjinwvCbBwNyyTdi8Uut2s6rUpMtwzkHCAXw72MKuJHP19vI5UGC8REBmr
         AQDIOyfRrLEbIzuZH178Q00oy8aTrgScfdh0NlEX4CBZcD21/F0QkcoyvCNLesPOHLZn
         GZU5g2C66VLm1dmSRBEIw3TY8eOEtJhCaA7KxFrzyRtiixocY3or6sHLquvONyC7Rj+Y
         DFsU1plod2uGASqxj3r+PFmJYifXUr7Z+zhSRyX9cdAQhOy5b54F+bNSYkGyr5kdCdZQ
         rcPw==
X-Forwarded-Encrypted: i=1; AJvYcCXmOS4UkBdBu7VHEM7WdD8g0K0mrKlMwLBQdoiMT7Swh8LLO6HKp7g7X1jJF8q5U8LIiDEZd2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjgEQChdqpgicDg+PRPsZd+Uca9tPL7WkmaMypcGmXGI3nJom
	Sb/yLM9qXDMLEHPp0TI/ab0Oj9vm9y3rVRFI/MSjEZ3Nk0sXOqpa4eSE1lvL4lDxaYSC/upZFg+
	bm/TmLvSj4ZzAzX2AhgC0CrNNhegqJaHOa3ukmWaJO024Xtbr+FyYHA==
X-Received: by 2002:a05:600c:3ca8:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-429e6b7d04fmr8185795e9.6.1723716936648;
        Thu, 15 Aug 2024 03:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRrTwDphN4E7O+3WrfKLMR0jDf6LMLrDL1gibBbR02UI9lUcb+TUehl+mDIfUvS6ndo6dmhw==
X-Received: by 2002:a05:600c:3ca8:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-429e6b7d04fmr8185615e9.6.1723716936106;
        Thu, 15 Aug 2024 03:15:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7c03d53sm14826355e9.19.2024.08.15.03.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:15:35 -0700 (PDT)
Message-ID: <f7fdecaf-c3c4-4770-9e03-d1f15fd093fa@redhat.com>
Date: Thu, 15 Aug 2024 12:15:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: przemyslaw.kitszel@intel.com, andrew@lunn.ch, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
References: <E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 12:30, Mengyuan Lou wrote:
> The MAC only has add the TX delay and it can not be modified.
> MAC and PHY are both set the TX delay cause transmission problems.
> So just disable TX delay in PHY, when use rgmii to attach to
> external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> And it is does not matter to internal phy.
> 
> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
> v2:
> -Add a comment for the code modification.
> -Add the problem in commit messages.
> v1:
> https://lore.kernel.org/netdev/C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com/
> 
>   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> index ba33a57b42c2..0876b2e810c0 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> @@ -215,10 +215,14 @@ int ngbe_phy_connect(struct wx *wx)
>   {
>   	int ret;
>   
> +	/* The MAC only has add the Tx delay and it can not be modified.
> +	 * So just disable TX delay in PHY, and it is does not matter to
> +	 * internal phy.
> +	 */
>   	ret = phy_connect_direct(wx->netdev,
>   				 wx->phydev,
>   				 ngbe_handle_link_change,
> -				 PHY_INTERFACE_MODE_RGMII_ID);
> +				 PHY_INTERFACE_MODE_RGMII_RXID);
>   	if (ret) {
>   		wx_err(wx, "PHY connect failed.\n");
>   		return ret;

Does not apply cleanly to net since:

commit bc2426d74aa35cd8ec9c97a253ef57c2c5cd730c
Author: Jiawen Wu <jiawenwu@trustnetic.com>
Date:   Wed Jan 3 10:08:49 2024 +0800

     net: ngbe: convert phylib to phylink

Please rebase

Thanks,

Paolo


