Return-Path: <netdev+bounces-66820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C9840C7F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D07D1F25BE9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E715703B;
	Mon, 29 Jan 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW+Xt5Ls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22907155A50
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547288; cv=none; b=nHqmUCt4nJEQNjKPpOwqtzYtd6vk/dnlGKi7eQLnEUazaRPNenCZZYqC85sjv6rr1gqUkECGrSCs8KxdDlnL5f2sCTSkAE226SOzFOWqOvLlFOa1KyeKBDuNYz759ZtMT9dnGgtXQ0jffBrXjnQQDrip7AdUWuKnfRAoRNbD3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547288; c=relaxed/simple;
	bh=hLjtGCV5JyMuycMLDJHzfFdq2xm0YURG8s8IQNoCkO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohZfKcB916p3pzesaFdz6Y0HpeMqd471SMh10ujnUIp49CPWwu6GlI9ccdEHnOSH46vRSZ9tXhtMdRhXLb6qnHI4M0MxjrcSzhNAuY33imO69IGupbEz6+b0Ql25NJCgB7Xu8++st08zKn7uzbhdND3nhpOiVN4MvSJoDGS7qE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW+Xt5Ls; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9d54575cso2348951b6e.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706547286; x=1707152086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpimcKrfFKvKR+l1BzZvjvqrU8qhA7vlHIvdh4WBFMU=;
        b=UW+Xt5LscQH3AsjxuX0YwW/TVrpcN4c3EJ5+9c5sM528dAOy+2yM3jrnidpmVViMrm
         LZvsDHIazA02JOFuQZSHMoJCBhqLngA1Q5bQmyLo8f50c92GpDypdLbSfEVovfS3XqBH
         f71YKMhSSLj476AAG+W/H7Z8YC0+BqiCdQXIwCiEdwqUys2hInT1AVUnsW7jw7Lyi3Y9
         F9XFPEMDwzI8Pk3gfHn6GJfvbFDuHzobRARKEpUb67iylv2kYUt+oKaX/6+HP8+QLfIE
         9t8iHl3L2CXetGmSDfKDRLafccaIrV5K8QDqWQJGyqAZNmAXqjeJeM74tt3mQ10hm5NZ
         ZPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547286; x=1707152086;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpimcKrfFKvKR+l1BzZvjvqrU8qhA7vlHIvdh4WBFMU=;
        b=EcfMiXqq61B00f28xGwf4zUVOMCpvK3/0mPLfG16gvAb6M8sMvjXKy9xAAQBVPttoV
         cUJM4yfLXer7rZo4apcR+wOfJNqtxYin8GFn00RdufRrhXCBKUCggCHyYlgPlXCUd8sM
         C7WITC0wG3UbD7xeQUwyxI34xj8yEW3PDXscdD7Seg53QYgGkV8MchAZh7Qua8kwOPPV
         6bHMNwCIzWxOZNmnhVOvkIwmOdCCIIyXX3y2N/+9GaANMojLQA4bqUZaiJ9n60be2ios
         4LQ/vTp5o5lnJUjuCOxORWrUxQAYydYoqCkJo1uECGwnsZox75UUZP+2sV3CGLg4CboY
         lMAA==
X-Gm-Message-State: AOJu0YxRGOLqndf240G78J6KuprfSRjILr0xaRFGu0anZHLAAP3v50Gu
	4QG1PM1desaxkW4nOxa/IgxtCjeBYi+IBqQv/JCbiWgS99Cr5hoQ
X-Google-Smtp-Source: AGHT+IHXawAS9ZrjFj4+Am+1OD10DISHN+9LaG50udloYbUL5jrkNT9cxL+IMefgOJHHSliyvlovyw==
X-Received: by 2002:a05:6808:1154:b0:3bd:c08d:91f6 with SMTP id u20-20020a056808115400b003bdc08d91f6mr7776933oiu.29.1706547286020;
        Mon, 29 Jan 2024 08:54:46 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006ddd31aae37sm6057246pfl.33.2024.01.29.08.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:54:45 -0800 (PST)
Message-ID: <9f02c173-05db-4607-8caf-13c86035c769@gmail.com>
Date: Mon, 29 Jan 2024 08:54:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arinc.unal@arinc9.com, ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
 <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
 <20240129161532.sub4yfbjkpfgqfwh@skbuf>
 <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
 <20240129164349.rcuj5hvmoqtzsuxr@skbuf>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240129164349.rcuj5hvmoqtzsuxr@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/2024 8:43 AM, Vladimir Oltean wrote:
> On Mon, Jan 29, 2024 at 08:22:47AM -0800, Florian Fainelli wrote:
>> It does seem however universally acceptable to stop any DMAs and
>> packets from flowing as a default and safe implementation to the
>> upstream kernel.
> 
> DMA I can understand, because you wouldn't want the hardware to notify
> you of a buffer you have no idea about. But DSA doesn't assume that
> switches have DMA, and generally speaking, stopping the offloaded
> traffic path seems unnecessary. It will be stopped when the new kernel
> sets up the interfaces as standalone, renegotiates the link, etc.

Very true, I suppose most driver writers might want to stop the packet 
flow from the source however and simply disable switch ports. There are 
also power management considerations at least there were for some of the 
products I worked with.
-- 
Florian

