Return-Path: <netdev+bounces-123025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656979637AA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8791F21E26
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6918E20;
	Thu, 29 Aug 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="FdJMWzzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10D17753
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894682; cv=none; b=Pg4TrOUFN+LKHyg2Lqwd32mFkQ0s1+s+YUnaho0ozpswSOLM9BxOOQi3S8Vi/NnoZvVGRhxjd2aDnqV6mDcS5JA/FeC9cVss9pzBDnVVmhEn9jps5kzrWW06fYtU0MmNnDjiMJco6cH5E2dZ4bnUDnIwigN1XyHWamc21Z4o54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894682; c=relaxed/simple;
	bh=XgeREWHRuiqTR+ZlXfIFi+cI7njGT6IJRiY7NdQKYHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLMk+aeedzKCzVR74G1Q84JXPVdGwVsa3XcJ+2V5SF6W6zv96TssgvU2hzlTA6CzZM0lUBXx6l1nwlvVMIB5rSd2wpoVwwu7dX5ws4rxQYfsTTVBG3fDZQKm2zKbO2HMCrSZcN+u353pIcAAc7Jo5Ih62pZbvf/9lCARe8aZ9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=FdJMWzzn; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fe38c7255so11866839f.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1724894679; x=1725499479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4602eoQt/s+125QmPR7iwEJsjffvNIMKQir7NGd7id8=;
        b=FdJMWzznLndMCOy6I6FSpDWHZYaAxcmjz0McAvV6iSmsR5RfSEqEzbPEii5P7QP9Ag
         L9I7oO6hRmtKRSNvE+KnUxxybdtwtaEFO+Q35TMo+hdJG2A5JHnON0iDDpn1nvB1DQRM
         HEb0HN+noZ6g0hoozoihqFoHHFanxGKVIQ/YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894679; x=1725499479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4602eoQt/s+125QmPR7iwEJsjffvNIMKQir7NGd7id8=;
        b=XMfVL+L3tfiUnCzUvzSUR6pQ984c4SjBbtlYzV9xNuNB6AIo1cU0AypqbLkXK5M5z8
         aS7dNuupG8lKPKG0O9KE8lqyhO4kzJHrRhguS0OYEmmYo0HsbllAlaP8KOVr37MRvCq9
         Tx2fsX/3QcJG6Vn2GXOmcuZGaHQanChd1MJjKX/HcgzULldpiLOPf0EGUcsdtZCFYAjP
         bkz47LdRHKpTMcMRzLz0ohqgUA3PVktsZ7yEMKY0ZFlG2oLWcsSSe0Egcudmb0x6f4su
         WCLHTAPjdKFovawYAHwRy/JwYbmA8DMrEPSwkYd/2Nt95kf3SX2ujrdAdipR9yRrhbWz
         8wcw==
X-Gm-Message-State: AOJu0YzrgWHmklIeLfZgGp6+FfIBgMXRFH+o2fnEtlxwU8klhvYnTXrt
	uffw8FKJZs8WxmL1fEhcrxqs4KfnyEOqWdQJU+tYpa/pj/AtpoUStf/8CkwSIQ==
X-Google-Smtp-Source: AGHT+IGDy79LRhQxFBS4gO7+Dae7DlrtxwUBZUldOvFlPjvgUWzBlgBeP0c/8/PJnP6RLMziWT1HEA==
X-Received: by 2002:a05:6602:1483:b0:825:2f0:9f74 with SMTP id ca18e2360f4ac-82a1108d3acmr162421839f.16.1724894679000;
        Wed, 28 Aug 2024 18:24:39 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-82a1a498a75sm4122739f.42.2024.08.28.18.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 18:24:38 -0700 (PDT)
Message-ID: <cc975da7-c2cc-4ed1-8931-0260c0023145@ieee.org>
Date: Wed, 28 Aug 2024 20:24:37 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: ipa: make use of dev_err_cast_probe()
To: Yuesong Li <liyuesong@vivo.com>, elder@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240828084115.967960-1-liyuesong@vivo.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240828084115.967960-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 3:41 AM, Yuesong Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>   drivers/net/ipa/ipa_power.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 65fd14da0f86..248bcc0b661e 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -243,9 +243,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
>   
>   	clk = clk_get(dev, "core");
>   	if (IS_ERR(clk)) {
> -		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
> -
> -		return ERR_CAST(clk);
> +		return dev_err_cast_probe(dev, clk,
> +				"error getting core clock\n");

This looks to me like a simple replacement with equivalent code.

Reviewed-by: Alex Elder <elder@kernel.org>


>   	}
>   
>   	ret = clk_set_rate(clk, data->core_clock_rate);


