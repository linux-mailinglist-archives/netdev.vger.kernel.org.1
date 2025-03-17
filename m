Return-Path: <netdev+bounces-175255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B163FA649DB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A743ACEA7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465472343B6;
	Mon, 17 Mar 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MbHgl9ZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411522CBE3
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207036; cv=none; b=XSq67nXUqYIVfnbA/WyKMWvMGd52L0UChC+JIcmdv2QktbixJFN/3LoxuSYIFn3fD9Y8gldfJLtPSnGmS0TXElZor8tVKc6iVU46jcugLTkaNCgbxhAtaZ+fpaJ2wu4v6pjB0fFm9tzkssVKzjYin1Jr0cKaH8D4ptJF8eMCAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207036; c=relaxed/simple;
	bh=hQVevsPun2k4OhyGxK6ojfHybwz34faUfbgawDCGPbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pK2inVieoO9M5l6k/5v+pDenyLT6loYzaUPO6u+TgPRYY4K5Kg/3kkJMl6jGnyLrAxwUwEWadJPFgBlSQbGJYlQAfGIBwdLuPPEPsKyQ6MIcZn7UOq8WCsYpJNNJFaJ0WbXSf7TEbNKr+HqfhVVO/pF6GuAoTrkvisQWgDsjd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MbHgl9ZP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so656969166b.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742207032; x=1742811832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ei5Q1Uq7iZNEXlK4IXQpSEeLrrdIHuZ+VdKd1lHY1oE=;
        b=MbHgl9ZPs6Riw5e6Ajc/HCP/Kbkne2Uws5HDBlgcFTU9C33Mvjg5gbznh/Ljhrr6qn
         dqv7kE+d5ARXC+GCIvQ4EtiwmYSZm86u7iRkf3SXC4NFjKuQnG4CRm9tBa8QjF2aN8N2
         JewXN5b93o5RSQ+vuiefnU3eNBn0NqjtYLslBi2RewsytmGMJTCXq+MD9PFKjX8CqGhb
         nTgCVe11/BMGjX5KoZS/y6MQpztA03OnfSKUUWMJ4gNOxjxS4hnlYajBwRkSkCJ8Dq9P
         iyoVVq4u9CLhazHaXiXwDDlXgU0kb04ubd+iCumjYtlrfM+M8fuzvx7Nzl9pa7tAh37f
         DDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207032; x=1742811832;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei5Q1Uq7iZNEXlK4IXQpSEeLrrdIHuZ+VdKd1lHY1oE=;
        b=gI/a8f6imiaDrA96pLrcEkmUi06iwfpi15PjrqijuV8cC/fdOOOCwB2LYkHokpm6yy
         5JxRPFK7YqVtvg4ZszjSyeOnB3cOcewyWrZtto1SONamVjDfbULiS8pGgsr5Y+UgT3BK
         PmN4Q1QDJmbxsUJ9asGxT+v5j46ZO/lJ3Cczjw1w5zTXkQaPGKWz3EDmTDRwPirhyAwd
         hb/SuyanVKD35CquwtkNxWzx3uk8uAcSs8nZ/4MsEDCjFszNdpiUQBQL/4yhRwSveBWD
         dKmOFEUkJpjqoE+8abcnW9zn9vy063L8enwb/Dufz2tuxS1zoTVut/jkQUQ/lZnF3ceN
         uAlg==
X-Forwarded-Encrypted: i=1; AJvYcCWvVzmJRW72sPb+uVB12/qieVz/j4r2O6eBGDMEXsnI8wgJrXXs9lw0U0ub4TQTQgEVeK+Hlw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLkGd3kY1s9cwz98wloC9EyddQvsBleGnS/qpUDzO6bBvy7y9
	/Q50v+oGGKOD+UGqQWkCgk40DaDRlQvBd+9yaUu0NZ2cd1zgtxCD71QC6zPXIMPOIuXg6UXFFW0
	Z2twaDpFVx/blbxlBbPhpFYrL5JY5s3LMyBlMKNuySOzXJbM=
X-Gm-Gg: ASbGnctVu+9mHaE68S5KraZfhf2/MdxAtq2e1Dz2ChvoziBVXieLpPDnFdXKvyd9BBQ
	BBFAo3G8l6MbhN4OrfWs8q6yUcDh4Gsvskwy2gyuTD2ENpL+sQnskCyVdPSV4N3o2ZGAibKpP33
	3v60SW5Rcc+zbQ6YNGuZnPoRxL2OsmG5SIAQoo0T64wE09u0VhtsC6DlLGBrhOFNZP6G+2z0vtU
	qgRd/pgOioF+uY6N6dAnL+lU0nWYKlUJ8rFlJJUPpsovdUtYuTxMNAHIZHcThr3xOZl6nZ/ozw1
	tvN6y3jHH2oVJsayiMhW/Q5W1sVn6T9p4Jbr/5Vi0TxNxHhrKCbrKwIhir8f9fJv/n5nzbgKm5W
	GnxPMweQ=
X-Google-Smtp-Source: AGHT+IEuoWp/V+oU0hSk2OtYEyy9iWN/u33KlCZ/YdLr7dfG2Cq9xaFU4lEX3PuSL1/VvHM04q1FhA==
X-Received: by 2002:a17:906:4795:b0:ac3:17d3:eba1 with SMTP id a640c23a62f3a-ac3301df227mr1244768666b.9.1742207032103;
        Mon, 17 Mar 2025 03:23:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:23e9:a6ad:805e:ca75? ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0cd3sm640554366b.70.2025.03.17.03.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:23:51 -0700 (PDT)
Message-ID: <ab583ad2-d9b4-49ec-88a5-74b66e63839c@openvpn.net>
Date: Mon, 17 Mar 2025 11:23:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 03/23] ovpn: add basic interface
 creation/destruction/management routines
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, sd@queasysnail.net, shaw.leon@gmail.com,
 shuah@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
 <20250317060947.2368390-1-dqfext@gmail.com>
 <f4c9a29f-a5c6-464a-a659-c7ffeaf123c1@openvpn.net>
 <CALW65jZe3JQGNcWsZtqU-B4-V-JZ6ocninxvoqMGeusMaU7C=A@mail.gmail.com>
 <0d8a8602-2db4-4c19-ab1c-51efef42cef6@openvpn.net>
 <CALW65jYaMBuMqzCFYwUJfLBg8+epQEjCg0MOpssGCwXqxbFP9w@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CALW65jYaMBuMqzCFYwUJfLBg8+epQEjCg0MOpssGCwXqxbFP9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/03/2025 11:10, Qingfang Deng wrote:
> On Mon, Mar 17, 2025 at 6:00 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> On 17/03/2025 10:41, Qingfang Deng wrote:
>>> Hi Antonio,
>>>
>>> On Mon, Mar 17, 2025 at 5:23 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>>>> +static void ovpn_setup(struct net_device *dev)
>>>>>> +{
>>>>>> +    netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>>>>>
>>>>> Do not advertise NETIF_F_HW_CSUM or NETIF_F_RXCSUM, as TX/RX checksum is
>>>>> not handled in hardware.
>>>>
>>>> The idea behind these flags was that the OpenVPN protocol will take care
>>>> of authenticating packets, thus substituting what the CSUM would do here.
>>>> For this I wanted to avoid the stack to spend time computing the CSUM in
>>>> software.
>>>
>>> For the RX part (NETIF_F_RXCSUM), you might be correct, but in patch
>>> 08 you wrote:
>>>> /* we can't guarantee the packet wasn't corrupted before entering the
>>>> * VPN, therefore we give other layers a chance to check that
>>>> */
>>>> skb->ip_summed = CHECKSUM_NONE;
>>
>> Right. This was the result after a lengthy discussion with Sabrina.
>> Despite authenticating what enters the tunnel, we indeed concluded it is
>> better to let the stack verify that what entered was not corrupted.
>>
>>>
>>> So NETIF_F_RXCSUM has no effect.
>>
>> Does it mean I can drop NETIF_F_RXCSUM and also the line
>>
>> skb->ip_summed = CHECKSUM_NONE;
>>
>> at the same time?
> 
> I don't think so. skb->ip_summed might have been set to
> CHECKSUM_UNNECESSARY on the lower layer with UDP/TCP RX checksum.

Makes sense.

Ok, thanks!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


