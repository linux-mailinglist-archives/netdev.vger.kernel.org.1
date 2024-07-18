Return-Path: <netdev+bounces-112045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC2C934B8D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296CB1C21B64
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2881720;
	Thu, 18 Jul 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dzA1xiOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEE8C06
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297654; cv=none; b=iMegWry7OhisCP50MrVcbafBPYMZX8KKgWMbS33mto/aZK3U5sGTGlwOZMUEKHwh6E6GCKSsN6E3r96QjoREXokECSkQ52bzjR90GwcQ07WgvBcZfGa4YJdqDeVxFu7tcSlBQAyRtugNHV8sns/Ow1anpuOcnIAvxbh59kjKE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297654; c=relaxed/simple;
	bh=jxAM+SA0YAuKpHKisBUsTYoV8Na9dbZWkNUzYC4qSQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfw1VkYFgMMvschhU37vAxyyOsJW25WUK656KebQ0b6vWhlQDMhdLYwmLbym++tMHqQf50a3pNfnH6osTUk4gJztiOAx6z2oQ9VyFXXspyZ+dKgRhXpP4V5z1W02vWbLjEmT6YAv0G3KOooQENfSTxWovG/hCapBLFgIDS47B00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dzA1xiOC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427d2cc1c4eso709175e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721297650; x=1721902450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvL7nGHnEn57gsrqHSh6JrJ7binZ09WqUem8VKtV3Eo=;
        b=dzA1xiOCwYIN/2SPgqoTuvczz3UopgLl/xV+fBYog8Mn1FhsXGqHWYmyQLX6EbCjzL
         o01N1O1jtq0eaVw4hZK4s5ZgqKcaBS2GWTfmYB1qlSIy0QHH4kL2qt1K7sU5U+7fkAQO
         GMvlFiDJ/mXa8tf6kmwPDefSr13CHj9J/3TKmyhaK2y4Tm7Kk40ms/DaahjLjkZV/y5D
         HvBqhtcoLGk3SO+IcDAMltehtlp3WY01SM4rsa3GtxlPKHyP9bPGCZTlWjfRzAr9B/Yj
         YLcJgwOtK2AqE9vutpX0AAwWeajbjFsTC3y7GNVr/TvfHjKLLSEYjWe3zGtgKRFYPw55
         Kllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721297650; x=1721902450;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvL7nGHnEn57gsrqHSh6JrJ7binZ09WqUem8VKtV3Eo=;
        b=amo6dal4D+rwajDrtK3DUG7iCx5kiknP6RMpT9j3UC3ex5w8t0gVPARUHymdW0fLzk
         PAwWvMwMBBDWqnLzbNE6gvUxvug0OCI2c1/N78z4zSmrrB6xnSwBqiV6IsbOEQ16etaD
         Z5m0xJvtveN+PtM0/1zGC2eUZPq6gWHJHxQjqoyuRGvnOycrjI+1JWu/dnrgwfvTjifv
         cfrmJD31f+0+16U8vnjwjtTJCDwiIas74giQFogiy65B6Hxqsp0cLCUvx/ewgLnR72eX
         PdyAp7c1mHb6+YihtaWFKseEGIy8m47eYe2yJuTdwsw2n/RiveeMDXhqeO9eePDVIFqy
         GBOg==
X-Gm-Message-State: AOJu0YxBKPl6RRKKT4Kymyw0tsb4eQgGLJkI2m8wkfVmOV0KkRMgaLE4
	JEcQrTA1fFej/pqVfORgSGqsJtJViNOLdDb9SiV4FsEIYy1q4v07TXRpIYWfmJk=
X-Google-Smtp-Source: AGHT+IGJ1hUlu0wmrD2MyXah5xqKGk+ZUg26pj6frcIH/tsAz2GZID6VVuUMrfSzfOYrFhGKB3eXrw==
X-Received: by 2002:a05:600c:4f82:b0:426:61b4:a2eb with SMTP id 5b1f17b1804b1-427c2cc0eb3mr32473785e9.19.1721297650097;
        Thu, 18 Jul 2024 03:14:10 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b18298sm4857365e9.14.2024.07.18.03.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 03:14:09 -0700 (PDT)
Message-ID: <9b49004d-709a-4ce0-86f6-99ba1e782533@openvpn.net>
Date: Thu, 18 Jul 2024 12:16:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 10/25] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-11-antonio@openvpn.net> <ZpjpaxKtiYG0AXFa@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpjpaxKtiYG0AXFa@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2024 12:07, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:28 +0200, Antonio Quartulli wrote:
>> +static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	ovpn_skb_cb(skb)->peer = peer;
>> +
>> +	/* take a reference to the peer because the crypto code may run async.
>> +	 * ovpn_encrypt_post() will release it upon completion
>> +	 */
>> +	DEBUG_NET_WARN_ON_ONCE(!ovpn_peer_hold(peer));
> 
> Shouldn't we abort if this fails? This should not really happen, but
> if it did, we would proceed (possibly with async crypto) without a ref
> on the peer.

Yap, better bail out.


> 
>> +	ovpn_encrypt_post(skb, 0);
>> +	return true;
>> +}
>> +
> 
> [...]
>> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
>> index aa259be66441..95568671d5ae 100644
>> --- a/drivers/net/ovpn/io.h
>> +++ b/drivers/net/ovpn/io.h
>> @@ -12,4 +12,6 @@
>>   
>>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
>>   
>> +void ovpn_encrypt_work(struct work_struct *work);
> 
> leftover from the old implementation I think?

ops, you're right.

Thanks

> 

-- 
Antonio Quartulli
OpenVPN Inc.

