Return-Path: <netdev+bounces-69215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885B84A2EF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 20:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E5D28B823
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B2482FE;
	Mon,  5 Feb 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyoUdjxg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132848782
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159599; cv=none; b=L3I99n5HgmzMTsLeZu6KQjqjtie2FJLUJwEaPHUjp7D7uFcjeLNXvQXS6pGRXHfUJsEz6dbuQwqGsNVKCIX4qR0pD4P0lxKbYY2buuRxVCIfiVH9/qhsnymRwjFv1886C4UDAzgkHIIIYtExe3Dxg2roUTSfmGfbZ10JBgxU6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159599; c=relaxed/simple;
	bh=msk8C3xxp1eVQ7ZfOkUTa8KjWImCq4DW+oF2gEzaPrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOxghPL/iIFRhf/qeQNIKodlGsjwNPoBmjPVJv0PTd0/cJpi1phDjMNFPQ5tjwvzFmazKNlr+IDOyVoPFU8vAMAbL+/Sjm4OfRyBdivKeCx4S6Y0AKREKNXD/9bTRqLukR+mEGyPojzWj7kMP81P8VUsV8yAa4UHk7lbcklbY0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyoUdjxg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60412866c36so46376187b3.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159597; x=1707764397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zn9IfxS9ZbbZv2zeA/kPulpLiO/0fwjtj5trKmKyQJg=;
        b=DyoUdjxggn1ioXz2mE9IM5NhTl1q+r/ydQRSx8iutcYcvre9gTA+1rgyZ5jh4l8e0f
         juwvFcFxyMvVh86eiMaxeZFIdZKzlEovGNMRlOzBuH2kEQInXpgaG1neh0XKC86+rIRL
         b5U4Du7jeD6F6SwhKWYP63gaLxvqI+I+HRmCGoaB5H6CIQRuUiW5+ZMDsFPVE0POXnhJ
         pUxWy2zjP5iSc9pDg45OaeRmKu+scpfHQQaxtmPIdVvhvqv4p8FcKx1jUhedlLb6Ktkn
         lVOs08U/l7vGrRQkPaLX+NFMOoH9rWfeetWMYA3Qxd+DvdWbNZqgC9vO0YfY6oa6BRO7
         2Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159597; x=1707764397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn9IfxS9ZbbZv2zeA/kPulpLiO/0fwjtj5trKmKyQJg=;
        b=MgqIV9AwXRf2EYBqNqxnYO942wzZk/QF1E18pxNrRNGtXF0sWBcW3Q5oYMnmGtjWEh
         5CfQqH/EseeUokRrT10t6enYpSLh0CaPyEmcn+EsgGeA45bstuUUS8xRAbsFBOQgDKwu
         h6b1bazlZftw6pKhld+BdrfHr2oXwQ4MgIJElH1yQeloR5n/FoHHXCLfY79IFAiBTVXt
         02dnm/60OXkRH5Gug0Gy4jCRoutoUBX5ny+4hpHBhTzpmptAAqFM2MO9cTkYav1ERQl7
         BevucliWGB5qoqpll8YzvnfQ2bmdoxRlHwaSRtQoSBgB5x2edYGpMUdSaS2PjIcYm2s8
         jkCg==
X-Gm-Message-State: AOJu0YwcQ8tvDndgetvbr0CiHh4k21Ob//WRGtIxRoRMwjsKO4hRQo+O
	jdI6uVNNFGHlrf+ZbQlnUFHKwYQ+U9/RHQh3Z3ovy3c1MLj4TR7z
X-Google-Smtp-Source: AGHT+IF9z2674+qhOO3Gr4UaHqQXUctHxtFVo7TmORp3rFDxbWdSXxyRqbu6H3srujSGoaBYX/+9qA==
X-Received: by 2002:a0d:e6d2:0:b0:604:4f5:f258 with SMTP id p201-20020a0de6d2000000b0060404f5f258mr524383ywe.25.1707159597238;
        Mon, 05 Feb 2024 10:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnHI+WXAu4+VcjxsIJtJfJa5onyHMJNCUh8KvFrATZ5Ulsd6IDpRycoUcUVZTookv+oqq7R5lTGh8A7aw9PntBVv0vA3ROjCMd59yRcBtSBApg8OWmd9X3KkdtO9zv/P2GER966ytygzKJBbMCvdELLfWOqiuU10ydJ9cRwoK2YUAebWgJUE5jokXZIyGpBGnAnHGvyf2XvtCu7at1M2irFX0gekQkTqpYb8IeDwTJjpyKeQ0D75mNA/g1KjKI0ZvijD3RDHG6tkrApRcwD+wr6rkEMM8pTc3EG8Hv++bhE+ykr/ySg4bEgGq9O0CnZk/NV240vY0=
Received: from ?IPV6:2600:1700:6cf8:1240:8b69:db05:cad3:f30f? ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id cd4-20020a05690c088400b0060437133f85sm81735ywb.7.2024.02.05.10.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:59:56 -0800 (PST)
Message-ID: <bf2b17fc-7638-4ddf-84da-33baad34c91d@gmail.com>
Date: Mon, 5 Feb 2024 10:59:55 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] net/ipv6: set expires in
 modify_prefix_route() if RTF_EXPIRES is set.
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-5-thinker.li@gmail.com> <ZbzdBRd4teS_4Eey@Laptop-X1>
 <536038f7-cc33-46c7-a3e9-2c9f27bc9c81@gmail.com> <Zb9kRrG_7LRl1i2W@Laptop-X1>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Zb9kRrG_7LRl1i2W@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/4/24 02:17, Hangbin Liu wrote:
> On Fri, Feb 02, 2024 at 09:57:46AM -0800, Kui-Feng Lee wrote:
>>> Hi Kui-Feng,
>>>
>>> I may missed something. But I still could not get why we shouldn't use
>>> expires for checking? If expires == 0, but RTF_EXPIRES is on,
>>> shouldn't we call fib6_clean_expires()?
>>
>>
>> The case that expires == 0 and RTF_EXPIES is on never happens since
>> inet6_addr_modify() rejects valid_lft == 0 at the beginning. This
>> patch doesn't make difference logically, but make inet6_addr_modify()
>> and modify_prefix_route() consistent.
>>
>> Does that make sense to you?
> 
> Thanks, this does make sense to me. If there will be a new version. It would
> be good to add the following sentence in the description.
> 
> """
> This patch doesn't make difference logically, but make inet6_addr_modify()
> and modify_prefix_route() consistent.
> """
> 

Sure, I will add it to the commit message.


> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Regards
> Hangbin


