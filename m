Return-Path: <netdev+bounces-73809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF47D85E8A4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 21:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6B82831E1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DD1474A3;
	Wed, 21 Feb 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFNle7rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E247FBBC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545325; cv=none; b=dz8aWODRlWaf2t74oUlaieplPnYweNHaR7DqCGMEqySOdAeBKOIBPTJcjrnaHOLyLifM25rjr76rVsIl9GTamnaZMfuFT4GhuJHxBVJTklRs+LnW0s3pbFfW+Ggfox+eDuw+EB9haf/ndexUW+UTbusW6yvxT1R9KStLEVXz/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545325; c=relaxed/simple;
	bh=n4UA237SCAuK8IDIk1jzAI+HZEIvbDKsAigWdh+jq/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MocPd39kvXvRhTwX+OEjEaLrt4Km/bmrmy6UT7qSYWDOkfSogQJu387kvjv1w797YUssNOMtVfMW50Dr+6Vgg4BihWTQN3ka8dAzFAhxtjxoMz2zh5wLwLzJbbjkPAo1W6x925wJ5xYntZQ9lV6w+BgATbD7J4apbx8Dt6uLpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFNle7rk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4127a0d8ae1so3419905e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708545322; x=1709150122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2so2dHSthWjUZ0zTVwPG6bHAOKdGz+QA7dPxBF2PAY=;
        b=CFNle7rk+RXDM0DjywWw47ZfWr/IrpGwZ8ORPrGFzPOAqdqOemXkuxioDU1bpyJYql
         UNWgKVLMoOinKVOSO2GSE3yTX8DMsxT0EXv42JZ/jk+/Q/DB9O8bgyKi+5bjbjL89zx7
         nrLLJsvXgvh/rXBUj9RyGoZ21/aSBJrflfulM9cs1y9D3+fyCUf775o/BBzozAHnEhWq
         ZG4LybwXsc3kb4uzhGtSYrhQ6be+cqgmbOsVkL2mAlQHoM3vRPUxVqyDpNF4fA4wdewR
         wdd7khxmKDq5e+hlwWiO+PFuQjcY0r53PxUGPBrXofEfwQyqNfuCUU2LmcsF3e5NyAFY
         yuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708545322; x=1709150122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2so2dHSthWjUZ0zTVwPG6bHAOKdGz+QA7dPxBF2PAY=;
        b=foLqw+DMkEu97Cv3PtxF7Wlj16PmwNXm/BiWhSC/9e1KDjpAqGif4+Nb1K3QUnpiqH
         CJWatwGpivbbpWsfycxfymCalNAJNWuTtBQcarOu6Z7Xxz5JXoQC6aMK+/u8vr7BSnVE
         EPOLy2fWP4JxUBZ4LTn8IbXQVXXDvr4euPP6yo9+t9Q/P3uodEx1jJsZsaat1M1vmXh/
         6rRIk931vpxXCb1d2lWeilHGF5yCrbb3nlgHXLcAH0yiankqW9gzfd4VAajmGGbPn/n5
         yV0GE0GXP+PG9Q6oekexVxe9dV5U5RlqA4nqfaWB6AfcFz1ny/pjn4LbWXJ81E2Q/GuX
         hlGA==
X-Forwarded-Encrypted: i=1; AJvYcCWKqpFaNZVoUkGX49tue/oK/n9ar1c9e28lvMypxRw53wUz61PPC9TGJHdjZ9Arh6c4OFZ8ds2gQQshGkImU44sPRBMzASm
X-Gm-Message-State: AOJu0YzXJs5U6rKr11XASyWLlDf6BsbWfLWSzrGT0Llidok/LDkn8xPi
	Z2DM5ZVkBBH/Lt7rw9uBKQ15e9X8H4CIvn/6HxtbGjcwu/tZGLfe58ywH40G
X-Google-Smtp-Source: AGHT+IECUgOsgHvQ1YbU9n/b+Nl48+uWVQsqGt0g333vhy80K6RUfIOvi2a3O81wsBust67r6ugl5g==
X-Received: by 2002:a05:600c:3b18:b0:412:7723:c754 with SMTP id m24-20020a05600c3b1800b004127723c754mr1761603wms.10.1708545322207;
        Wed, 21 Feb 2024 11:55:22 -0800 (PST)
Received: from [172.27.61.253] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c0b5900b00410dd253008sm3521278wmr.42.2024.02.21.11.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:55:21 -0800 (PST)
Message-ID: <dd5fafee-2cb4-4169-9bf0-6b9b66fb70fc@gmail.com>
Date: Wed, 21 Feb 2024 21:55:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net 08/10] net/mlx5e: RSS, Unconfigure RXFH after changing
 channels number
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <20240219182320.8914-1-saeed@kernel.org>
 <20240220032948.35305-3-saeed@kernel.org>
 <20240220184617.41b7de4f@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240220184617.41b7de4f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/02/2024 4:46, Jakub Kicinski wrote:
> On Mon, 19 Feb 2024 19:29:46 -0800 Saeed Mahameed wrote:
>> +	/* Changing the channels number can affect the size of the RXFH indir table.
>> +	 * Therefore, if the RXFH was previously configured,
>> +	 * unconfigure it to ensure that the RXFH is reverted to a uniform table.
>> +	 */
>> +	rxfh_configured = netif_is_rxfh_configured(priv->netdev);
>> +	if (rxfh_configured)
>> +		priv->netdev->priv_flags &= ~IFF_RXFH_CONFIGURED;
> 
> The sole purpose of this flag is to prevent drivers from resetting
> configuration set by the user. The user can:
> 
> 	ethtool -X $ifc default
> 
> if they no longer care.
> 

Thanks Jakub, somehow I missed this ethtool option.
We will definitely send a modified solution.

