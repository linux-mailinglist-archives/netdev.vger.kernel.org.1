Return-Path: <netdev+bounces-69623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4684BE0B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5AF2856B1
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C181426B;
	Tue,  6 Feb 2024 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpH5cwRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3334182AE
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247450; cv=none; b=KoIW/jcA35H9gkC8HAO4FnN4xBzCNLMf7KHy15kW3EP0Bi070dIdADBL0zsatfIRDYws51kRDXqOdcb9o+NA8XL8WSukfnCrnHBabAsmhsCV4R4g4FUhgZo1WP3CapTncW60wp9T0S2ctyXeuSVV3sxIquZZod9s3OqUxdqPNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247450; c=relaxed/simple;
	bh=3fDDvHVyGe8nQJ32cFaqDjBf2LcuYahBc1xocu25lIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrjEF6bJRZXSta47B3C6f6PZF3erEQegQAfpVP/7k0CktYoEb2hvicTPpzDt7R8XnwGRveBr/EM16HYATPbDmlnK7CoelupZPy0jhyX2MPeeh4bPzUQTC82GUMg0aYWl6E5t8nLsevdqAY8NogLesOV3MXcKGnmSN/hVPKyu1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpH5cwRf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so4159462b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 11:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707247445; x=1707852245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m/uRC4p37+EtimrNnsDK4eSmm5+RjmVno/13/ietU2U=;
        b=gpH5cwRfVvivHmw5yNPxr5Vo0/kX5uPPMKC2zpOFRYxgXW3wy4k+1H4/80rGDewHpy
         QDgUu2U6EodIdeO/s2DZmwWlB4b8YGf9GcFXC1tJXspLoOvWNX3zg7QD8q4sU+kMtBKS
         GOQGRXG9Nb8c+d/+H7dGOiTJOMd0iVwAzSJutkP6u2syjpol00E4Fc7C5eYHeZmlKnd4
         bEoqNtcbtzW+zTMKJMVTsargFbd54wX8+wjD0lPIPKXvWbDrA5e7tOaAhuL7skSsVV7o
         y0aiGMTcGelDPfPynNTv0eEyymX7xYEQTLPxHbycdFQTmJ4voPy6UyGqce2PVs5CEKd8
         2aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707247445; x=1707852245;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/uRC4p37+EtimrNnsDK4eSmm5+RjmVno/13/ietU2U=;
        b=Ef1z+0O+xtkU4LuPFB5nuoiuuldtY5J1y28O0uqfmJI0OOHBK1vRt3RxdwvNgDlDjR
         /ojcu/YV8oNlQRODXpYjGx65EDitRs4Jx/D+ldZiASMY735NIm0eXnJRECkMbJwZ0VJQ
         4XqeOhnbSMhfd7+cc8PfbyTThArQ/fKSMoJ+8VvRKb8syfyv60ezcvorkDtRK68NScs4
         l8iFFT5XQbV3tTFT5HcLu/b95ldYXxoXbL+u7g7j0LZgW/QZVyRzD6/xFEpy2BqQLGvv
         +oZgMaBwy5wWj0xoSRPcUPMSIOstaawL1OHyOMHWIDQ4U1qxEJT+/J4GXmLDzW4SfHoO
         m0og==
X-Gm-Message-State: AOJu0YxgUlmLBowmOAavJF4W+tMrdifBCmWzS7rytqZIgBwLrtufOdDG
	M2pDjyNewqyexwgx5BQO88k5JVUJWYeOuZCzAfh/TI3fl45Jwguwt8frPEAL
X-Google-Smtp-Source: AGHT+IEav+UuH6kjgGPcZEuP/kpAxHwH2Tw9YufkT29pcUr8924e3pkDTwrGysCfoQDzg/S85DL7FA==
X-Received: by 2002:a62:d445:0:b0:6e0:2e81:89f with SMTP id u5-20020a62d445000000b006e02e81089fmr506916pfl.33.1707247445409;
        Tue, 06 Feb 2024 11:24:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFv+C4S/gG+JeSf+CNzPGmtp3VkkUoG0uJDngft2UayUHrOKEQceJkbVdwzEvOJX8Vyqzb0qXe/WSaylMRLhYVpC+3qysZ
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020a63e64f000000b005cfb6e7b0c7sm2555435pgj.39.2024.02.06.11.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:24:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41362a3c-6fa5-4567-9c31-5bc2d8542630@roeck-us.net>
Date: Tue, 6 Feb 2024 11:24:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Persistent problem with handshake unit tests
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <ZcJihCDh30LD4NPy@tissot.1015granger.net>
 <6904162b-5ac1-4f2c-a48a-02c104f6fe4c@roeck-us.net>
 <e6e235a2-85d9-4e3d-9ee4-3a9f00aaf1a5@roeck-us.net>
 <ZcKDd1to4MPANCrn@tissot.1015granger.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcKDd1to4MPANCrn@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 11:07, Chuck Lever wrote:
> On Tue, Feb 06, 2024 at 11:05:36AM -0800, Guenter Roeck wrote:
>> On 2/6/24 09:55, Guenter Roeck wrote:
>> [ ...]
>>
>>>
>>> Since the destroy function runs asynchronously, the best I could come up with
>>> was to use completion handling. The following patch fixes the problem for me.
>>>
>>
>> I don't know if it is a proper fix, but I no longer see the problem with
>> the patch below applied on top of v6.8-rc3.
> 
> I've got something similar but simpler that I will post with a full
> patch description, root cause, and rationale. Stand by.
> 

Excellent.

Thanks!
Guenter


