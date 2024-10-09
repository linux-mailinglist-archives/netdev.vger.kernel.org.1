Return-Path: <netdev+bounces-133841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7EE9972EE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441C71F2316D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714A1DFE13;
	Wed,  9 Oct 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm/b2v0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF01E04B3;
	Wed,  9 Oct 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494397; cv=none; b=dVUObo/cQJsfT4K8T4l4qDQchbPPCivuUEsSXl/voOYbXjw4upavXYxPoJom61NpD8ZRVnVBt31Z7te/mcdVcI54EpQ5oJ99boE40vXBcWftmQPleBPftb7BxInFTDH2bC1EdpZ07MOJb6wAZcNLkXm7DgHBojz1+K+L1f9RS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494397; c=relaxed/simple;
	bh=6XO3QHVsI2FrTm/T4grPmVZTTWhumn93WxIxXZX4PAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asRj2LjMD1BFd/sLc9IfzuPAXKUI19zrJ4SfF0+VhPHOQq1xz1XjNZwqPy6oBR5bWwMXK27qHzUPb29gc1PZrk5FwKu4p7PzK7PokBioibLYs0G45jQ4smOKSPw88I7xx7TJhaLOX012p98zKPp9JO2m+USHzkGSR+IN3UWOakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm/b2v0F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b90ab6c19so76257295ad.0;
        Wed, 09 Oct 2024 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728494396; x=1729099196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mBIl3ppuyOTFiyulZToWVK1cyteAW6nYjEsK1BP48mQ=;
        b=gm/b2v0F6UvQWrGqUI3mtWaiwkWJPrBQ2OBBjXlDRIPuO/tzv1x5JlagtrQFl2ELrv
         HscktrN4hAh17oJ7innH2V0SA3UZjJXXPg90l/eq5a42QPR0vJXuFURAH29XN5a/1N1n
         6xMzBXxJh9fh8fJ4sH5Qhx/Dh4ucLPMnNpvuIUkEw0ASfyWERObW0neA6gZpadu8wcug
         xbw6l53r2Pw7JBs2wrKPDTuURljNz49Ll45saLcSjOTJPsevt3bcZs4TSS/XRrRM3DOw
         80wJ5O/QdorkspZYzNTPxE7XSywkAvVwd+OVvU5Ul0IaSnk704a31eTl7olScVCnZie3
         dUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494396; x=1729099196;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBIl3ppuyOTFiyulZToWVK1cyteAW6nYjEsK1BP48mQ=;
        b=V+aKoxS1peO7BOlRvtVVXoPMglDTxhasTEf1+WQAE+sFkmsD0copMYcQgxBFrqw4tj
         kt3GeOoGomjPjkdAmWJCLld5EsGOLbLK5oZpwcl5fuRgTWlszmLNK7A5WsQxAwhZ8ZBr
         skvOTHb7o/MtWeEsLUGM3dpJLWIJg6HzoJBpM7LqJFZNWZlYf3FUpOVVAnZIJuoVLXjK
         ohD/wzCPtl8JxXFH6wjayt92hGtdk0TmTypI+JwkO4C85RNKk8wG3YrroXzleouhR1a1
         mpNRLRNnAQUgonCkS87t2M7sW6YUjC+nfSWZrrNZfXKJt7u6zdU3ladOuGsQPqd9H0FH
         10EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8817o5PPc5q/j/04nuMqya3yGu/onLAPsEVYA62usm3QS+EByibsoE+9dvuagqkxWUxZkhU/8b8ZI5uE=@vger.kernel.org, AJvYcCXaaIEcNUWzLZL1PONYn5Mpuff98kZAiar8wauvIjgEZjwotzXecE0dof5ffiE0iHrUxdzGNICo@vger.kernel.org
X-Gm-Message-State: AOJu0YwstjGA5urnBJjYBbVCx9hMgFC9BnLMeQ4x3r7g2WFwXaVPX9BA
	uIuxJsopALvxsQXeY+UDrJyC4mcolCXRKwZqjAmfW8LewSgk6Kw6
X-Google-Smtp-Source: AGHT+IFncdsW7+yrkVxSkHVLCowFqbtZx8qhTN/bRvczM/0qiogXC3KEuOZFaT2x9Cvi9fd5QhV80w==
X-Received: by 2002:a17:902:db0e:b0:205:709e:1949 with SMTP id d9443c01a7336-20c637963fcmr40556565ad.57.1728494395627;
        Wed, 09 Oct 2024 10:19:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939c3bsm73161265ad.151.2024.10.09.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 10:19:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e08f9ba0-66f3-488a-a6cc-b087527b2cb9@roeck-us.net>
Date: Wed, 9 Oct 2024 10:19:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 csokas.bence@prolan.hu, shenwei.wang@nxp.com, xiaoning.wang@nxp.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008061153.1977930-1-wei.fang@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241008061153.1977930-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 23:11, Wei Fang wrote:
> Some platforms (such as i.MX25 and i.MX27) do not support PTP, so on
> these platforms fec_ptp_init() is not called and the related members
> in fep are not initialized. However, fec_ptp_save_state() is called
> unconditionally, which causes the kernel to panic. Therefore, add a
> condition so that fec_ptp_save_state() is not called if PTP is not
> supported.
> 
> Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net/
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>


