Return-Path: <netdev+bounces-213793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D933AB26AC2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1272060356B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C1199FB2;
	Thu, 14 Aug 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTxpsFu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387331862
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184476; cv=none; b=rydCjvBRfKGyj0YP3msUiPorMhH6bG3jfmUoaMQcWUtw66e2a1DK6N0azxK0cImm8/CVYr1zCRIai3SOeSjNJlWphZc6cwzM8ZE76LZz769w8dFyUCVVZ8YcVjoNqHUyLHgUK/Y0LOi/OvdPJGcU2CMrCyDpCB+hx8tOK/LvkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184476; c=relaxed/simple;
	bh=wEQ98Xg7/ngOI2+zmmfh2IC6Hd4m4oE8jFwu+aJROog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVyl7a5HtngBIHLymLo9NJ8IHHiCcc2vxtXjfX9H92+bvA5JTSExeA25mI8xc6OhO9ANFDr20WGURi5g4sIbD04mjSVsiM2EytgsdvpboEa8Uda6A6kWgKvmYW1vNuWLqvh2GCI3/6d/esd0Z3GczVQpYc8skvvurBGjzA1f66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTxpsFu8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e870621163so68888485a.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755184474; x=1755789274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdBdX4f+HG/kOuoIKWAD0QeQ6k58YKzKTJc6tSgaET0=;
        b=QTxpsFu8VbQEDwQdLo/EeIHFz0Z0W0NLT97LY74OQHnsXn8jV0jPoIedWA2uIgR+JZ
         G9mZ2SCXN+BJCOhzcEz8KfS1H/jUPUjNBBi+SAm52kbxe5jveiXVlAycC7yl++FNwNmA
         +RwMHSmCxtQkO1T82IxBQGe+wxko8Oyna3MDJY11Y8B3M61t6Cg3zFcxxvb9XF2gA40g
         QtHt104fRAnPt+Q95znzMA4Pfy9rLMn0AsVvZS0IgK4Cz7+mWlQKofuYhqDzF/XIpk26
         LzqHA8fOM8lpEHJK5BG2kfIsg111i3quVNjbY9ENTJv6Ri75AzHgTcQJYvH5TyAof1h7
         0ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184474; x=1755789274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdBdX4f+HG/kOuoIKWAD0QeQ6k58YKzKTJc6tSgaET0=;
        b=VXW+ml8KuMiYXELwsjGgGT1Z5texIDj9oSdB2SXYu2r2eqV89ce9jQsk15ZzrFYIDY
         IUrm5JNfhsKoTG9eo/C1KdpZThK6AAOmId1oPoNOuz6FbQ5wmf4+HuAmjBfY9Jdie+MM
         2imYM366SN1yJ8UzfRSsDDXOpz6ln27XVeqpSOuy7hirewlTL75lyC7GT99aWzBJz3D9
         Fta7oD3uCi8woFRsu2uL9PIlQJSTPLF4gnD2zdB7eCtNXwocltclj8GbsXiAC9mfvAnQ
         I66afAg7Yb7CX6Yd8lpCdQA5zWxvD4r8qG/Qx1OY9UC8N3F+fr62+rBahmFJSe9Luh4E
         ayVg==
X-Forwarded-Encrypted: i=1; AJvYcCXIDW+fYBXklREjVvCfPGceL12W1clsqH8vFDXxcWmkf0KQGWhBf/AZBmqEs31LKprfuE0yOF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpA6qJmyao4IZ21eGWyD1EcgAg5yzsHuGU0IsAbtFgg54h17Mo
	a/D6uP+ZAEphzOsfZXwgIsgcgpJoxy5oX6HzIwtz0UBiQSuJefcXo3fU
X-Gm-Gg: ASbGncthIvyS8Wi5ON2B8qg9rG72/BFM2b876umt0PFGOXqQJeH6Up3olT241mwPtuO
	kwB9bbtlPPR4J/eWi/mp5vOqjnr2eYN3ZbbHbOxyl15fDOnpZzYh+LEXq1FGbFfSBVAUrYeROAr
	sw0uEjUP2vsp/Hq/4FdaMAd9qR+0xfQrQNvvYqzBk5WT2jdxIch2dtQ68RuOwHH6UIcwYe7KNCZ
	kxpsyDCv/xPjhVEizJJYJPb3IxhHtJmOEbzR14MPKCfZiIBybGfvAd7uQU8+wG7fC0gRlbkpm7l
	o0btqoQ0fhF5CpIhCmw85Pa9SpU/dV4KB6vPnfT7h848t3Yi5qC0CUkXGdi9Tfj8YpapqyOcCgJ
	OSCghJMcveSJ3xDW0Q+rG7XmuxjNDGQxPBlOmaKeamtwmAdMMAA+dAgcQ9LTVvqzKFBva5wL3ai
	oU
X-Google-Smtp-Source: AGHT+IGHTECZYCOBd+tNxqxQnyjcbXxKJzZe6uiKq5WNwmrfQuIWcdgeod5kI3kXK3M3lWtEenOPSw==
X-Received: by 2002:a05:620a:40c8:b0:7e8:70d7:9e6 with SMTP id af79cd13be357-7e870d70abemr540696485a.55.1755184473930;
        Thu, 14 Aug 2025 08:14:33 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83e5d6a1bsm942462685a.13.2025.08.14.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:14:33 -0700 (PDT)
Message-ID: <08961621-6a13-49ee-9964-4fd13faf2e6e@gmail.com>
Date: Thu, 14 Aug 2025 11:14:31 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/19] psp: base PSP device support
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-3-daniel.zahka@gmail.com>
 <67a52aff-6f78-48ce-b407-d293fdf86210@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <67a52aff-6f78-48ce-b407-d293fdf86210@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/25 10:21 AM, Paolo Abeni wrote:
> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>> +/**
>> + * psp_dev_unregister() - unregister PSP device
>> + * @psd:	PSP device structure
>> + */
>> +void psp_dev_unregister(struct psp_dev *psd)
>> +{
>> +	mutex_lock(&psp_devs_lock);
>> +	mutex_lock(&psd->lock);
>> +
>> +	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
>> +	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
> It's not 110% obvious to me that the above is equivalent to xa_clear(),
> given the XA_FLAGS_ALLOC1 init flag. If you have to re-submit, please
> consider using xa_clear() instead.

This was actually a deliberate decision to use xa_store() with NULL in 
psp_dev_unregister(), and then call xa_erase() after from 
psp_dev_destroy(). psp_dev_unregister() is called synchronously by 
drivers to uniniatialize psp, whereas psp_dev_destroy() is called once 
the refcount of a psp_dev goes to 0. A system could have multiple psp 
NICs, in which case policy checks at the socket layer need to compare 
the pair of (spi, psp dev id), as opposed to just the spi.

What we were going for with this decision was to try and prevent an 
attacker from trying to quickly trigger or wait for 
psp_dev_unregister(), and then try to bring up a new psp device with the 
same psp_dev id, while a socket may still be holding a reference to the 
old psp device. So we delay calling xa_erase() until after all 
references to the old psp_dev are gone to release the id (xa_array slot).

Perhaps I can add a comment, because I can see how that would trip up 
readers.

