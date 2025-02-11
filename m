Return-Path: <netdev+bounces-165269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4EA31582
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865D93A63D3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12E26E629;
	Tue, 11 Feb 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHZskN3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF226E621
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302703; cv=none; b=MJoZnAyBeqo2cD85Yv6WM3ysc3OlNkEpUwurHKnbLRTnduRmhMv9/b0BcJiCkWSRZwQsTqTtOMCemXsfuxM7m7Mo483STjI+Qebhknow2tTVVoMI9+0F84UIsNAGAY1bo0H0mIifyRopkOOdatV/JDqZpdhlaPZN//ISj4aZex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302703; c=relaxed/simple;
	bh=k1QSfAWnbCOLgn760SbafDIY3Rviuoxegxo0KNRF6pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL3mdd+eBLdKJ3KldBCuYuKrUxm+NhBpmuIZ9VE9QJ6U1JMs0L/QxMa1W5UqA+sWPc230UIX3T7HNvB02Z5XoTKukOzl+zvuGDPfyWD5bTfSZEq4YcVjfDpKwizLqUiB8MG1XRHhjuNUSpwUgblHpTdwTZf+N6tuf4T/+M4CLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHZskN3+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439566c991dso5416925e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302700; x=1739907500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZrtBMffe9e0Zwvjl95eVJSN3NyPnhnMJlXXCdakls0=;
        b=HHZskN3+JkMA+iZooogfyKD3aoHYCuG8k7rNraMS24vnBo7Mbm4sMVWlOC6pdcDWLr
         H91muRv3DsWGMYTCW2IuLPpnwFxYHwUDDw+uT55pPpdVnFeo2cNr/+no1IsZ4TIE4GQL
         pKAAwTbAMHMHPkLLuR0XtKcDJNNOmM7txBz9+csZT/b6ezzFX8CyCZO7wUqx8QXtVrsE
         x4s2sQH/Sn/G4Py3Bz7WuQUSKM4IGAtubSCb1oLYMhQh+iIs7SFe1RYerOSC7/hF3H4I
         0Ce9aEJRQAaECIzvV/i1cOt5wzR0I8dw1G+2ASY5+z35Q4SQSDVWEDhR+doqO436fN0E
         PI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302700; x=1739907500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZrtBMffe9e0Zwvjl95eVJSN3NyPnhnMJlXXCdakls0=;
        b=V0j+CpJzxQ5jt0grNjiBtutIFs4/mYeGZz7bsIq6UKZHMzao69YyHjCNq4RuW78ebh
         gYQo+qtqJXyfUKtA6WqudLBmcme8j7hIPo7SylZVTHgoPlKy+y3gRWnTz2LA/quIzpGC
         WV0vLWvMQuyE/o6jZ9iZykj0fUyAMG37CbIpbx5bwmD0+oAzZ8L+FlTEcN1QNfTH6E5t
         Fpi33EwRqQW6aJ5byQN1NB6UWBCsE49caD2u3swPTtK6cDhNTvtIAVWBqLNKHdVazdLJ
         /3VuFfqCcUmb1txbImm9p8TGfBYoPwCvawCR555gSXPC5kkYm//1/e9zj6wT4WnCZgL5
         Taaw==
X-Forwarded-Encrypted: i=1; AJvYcCWb5pWLE5YCaCHD6+dKyZLqObQxZsN1cchhdMgMQ4z6vBbrxuC4QsNO8KFVi02anjMSD/d2R6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmxavNTludaiLmw4dNp3U87lStaP1Ei+219iqpzlNm9rUhmEpg
	aggRlDYxFTUyjtC9nHiqU12xvmRQ12JZzRqmXvYPHVF4/5bl/tWj
X-Gm-Gg: ASbGncsjuOZRA5tw3Mtl5sgRz8XO2TPM1HhKGYW/gvv+vTKt2hegQCEKEjkPbGZ+7qi
	THURi1qof9WbEk5maiHq89W0hOeqCood4jTyOS8pWdCwhKbDvIaX+YvAUNtV2FRmo9Jc7VyRRI4
	N0q27EBOWFakwXNAK6r7d+ToaS6BvZmfcfkLgn+8aAT+DajYuJiaQTWfHZuaEu20UCjbELfb2lc
	RF+fMTzZhteCa+wQgc5pIM/qvWo80id7hsuK8m9mn5yUHKpCo58Fe9a+ukCfSocU0rHyC2YAcYX
	FYifyNHXXys0xu60a5UG46c6SEX7EHvK12sY
X-Google-Smtp-Source: AGHT+IGlgPxfd4QBNZbT7SuDxwMCO/QChVlyMshXdkN/Vf18D7DdT630K9yS+hOLzN7AzSBNfPH/RA==
X-Received: by 2002:a05:600c:1c0b:b0:439:54f2:70c4 with SMTP id 5b1f17b1804b1-4395817691amr4476865e9.9.1739302699935;
        Tue, 11 Feb 2025 11:38:19 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4393b66f3e3sm97409265e9.19.2025.02.11.11.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 11:38:19 -0800 (PST)
Message-ID: <634d145e-52d8-4c29-affc-f4233c28d322@gmail.com>
Date: Tue, 11 Feb 2025 21:38:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-2-kuba@kernel.org>
 <76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
 <20250206150434.4aff906b@kernel.org>
 <18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
 <20250211110635.16a43562@kernel.org>
 <ed868c30-d5e5-4496-8ea2-b40f6111f8ad@gmail.com>
 <587688ee-2e81-49f5-a1a2-4198c14ac184@gmail.com>
 <20250211112340.619ae409@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250211112340.619ae409@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/02/2025 21:23, Jakub Kicinski wrote:
> On Tue, 11 Feb 2025 21:21:13 +0200 Tariq Toukan wrote:
>>>> The ring size is in *pages*. Frag is also somewhat irrelevant, given
>>>> that we're talking about full pages here, not 2k frags. So I think
>>>> I'll go with:
>>>>
>>>>      pp.pool_size =
>>>>          size * DIV_ROUND_UP(MLX4_EN_EFF_MTU(dev->mtu), PAGE_SIZE);
>>>    
>>
>> Can use priv->rx_skb_size as well, it hosts the eff mtu value.
> 
> Missed this before hitting send, I'll repost tomorrow, I guess.

Sorry for posting them a bit late.

This one is a nit, I want to make sure you noticed my other comment 
regarding pp.dma_dir.



