Return-Path: <netdev+bounces-243318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70768C9CEDF
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3C404E3E13
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB22DCBFD;
	Tue,  2 Dec 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bijE3g/z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiPmaYCm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470C21883E
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707683; cv=none; b=ThPsSUIEVgrFXNSkmG+HZfANz/3oRHIPAtCyrJNzZKOi6E9l0mSb+PDs1QuakBh7+/k/Ir6zXuWxnEowi9XBHzcV+j8JkwZ9orMYp6IKoOax6BAKPguXTa2uQ3pTnr8t1B5zxaUEGauQi+VoGv0bptxjzp5YAv1dLEu49T7hJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707683; c=relaxed/simple;
	bh=thpHsB3JjMWlOg4sZRd9fcI/3fT09Gmu9ZPXxHy6duY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MFkj6RGdwJFHOaAlydbp00eiolXatJDauQZq3XvTpXcuFbUxCd6zyhqK4LN9V54pVJeIZik7eRvrTNoj7l1LjXq5KNC1k4BuX9rOrCwIB2yztx19QhW8ysEeqNXUm/eG496yXVFRamlPbBAz6nYuO8FWap8MguyGHO0uCGDnoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bijE3g/z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiPmaYCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764707680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbUR/D3fA3sNv8mYijF5JPhsQPCkivHxnTpgw4bqPyA=;
	b=bijE3g/zwq4aLXRfdnOx7qYC+d2MhhGqvNENyYDxv8GIIdLOqYLmdNPuMuXWFyerJcGoy4
	Tkh+fpLtvDK0PdgfsSvpw8+FoZ4ddH5IdUDg4C6zGdsl+mx0hcHQCob7GxA+Ar7qxE7mkS
	Hv+4qCYi4XyLqHyfQm+u0H4yDASZlM8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492--ncDwUGbMpSPMdIfN1-fXQ-1; Tue, 02 Dec 2025 15:34:39 -0500
X-MC-Unique: -ncDwUGbMpSPMdIfN1-fXQ-1
X-Mimecast-MFC-AGG-ID: -ncDwUGbMpSPMdIfN1-fXQ_1764707678
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3086a055so4398475f8f.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764707678; x=1765312478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbUR/D3fA3sNv8mYijF5JPhsQPCkivHxnTpgw4bqPyA=;
        b=SiPmaYCmJaljpw2vZ9ddgvcqBbyY9B5Nvxc3cabdck/iKAVE3MEws4qxyp689P8qyi
         8Ms7WsJe79wUoDD2a+yGk2tuKtpFoDr2blY8gK5NUI+iMBHyMNg41MkK3goROpFwPC9Y
         LDd5H28lYmjKqNSofKh4bLjIr6s61MEqKJuIi2xxo1o24NlgNxCnyZi/Bvqhyh6PreRK
         8y7qQaxrvI02iSbJxNBftDFhYyYqhkBhpXBwArIuY28A+r947QdM94KDxC2ldo292n+q
         dSpm7sETZi9x5CiCf5KFgaJ40StcNH2jyo7KGQdPFxyBjZDNNZTipTIh8Erpz7F5dr8C
         GYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764707678; x=1765312478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbUR/D3fA3sNv8mYijF5JPhsQPCkivHxnTpgw4bqPyA=;
        b=B9CYlW4kykEy+cKCLBaGyydBuavetKGTr9SS2sdbEEaG7KoooJs9G1IIy53+opS85v
         t4u5K8WrVlqrkKt3GYs8KdO7C+A87esN1avMDSawhVHs/9xsbVqownNdL0QLh3UVjZNM
         dhcG7KJyPfZiQafqkoP39c5phEwmDyftCr1CSKEnHu9ThhSXEEuvEKzzPZDqKa5cGPZr
         0tvXM7AgRR5oEEJStWP081KR2fRf6fwldDiBKrXr258e/uJK/dWiWbGzlCE18v7uKzV8
         fQv3DKLpD6Uut2VOElitxgduDPsJV1Ishcqd9buCTb89BOYW05dNabsRFiuGPGPOHnWp
         JfHg==
X-Forwarded-Encrypted: i=1; AJvYcCViOpvM526hZoZzHVp4iIJeXRvd1kWpjddVFFQUeTt0STMDAAvPPtsvg7tHPBJ+dhSq27kaZLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZmGk28nofQHyHHU1mN3Y3SkZ8v9fHDY7g5xraCqbgSlAdoD5
	Opg6cxSJSf2pAc/jqCwsA1asI8VD6R5bicqfP1eK+YrZcOKrxkEHwsMTwm6d5Vov1fe7nzkGZMz
	xNoLGT1m5PUyyaj3av184Dcu3qamnHBNZouL6bCy+1Wei6+UKorMwKSFqXg==
X-Gm-Gg: ASbGncuokC+SZgCIT10e/bRDoi70km55C6V3ld/0r1dZwmyIiL21r2KYELuZwUxF7SH
	y8b9xzPHyjML0GSkoNRVMJJvA0xGAeqIPztNC4Dv+a1FcPVCmspcmdetDAgPoD7IHS5ZKRe9Snz
	/WIFcZAKHbwKdB4oZxf0kjzpQrPduDXTapmg3gwRrR7zWvP22e9WTlwVam/3Dh/+1vlJrmsZfpD
	+E3pB7V0oNAolmopD2F7mdRNW76HmDEchSAOKQXvNTasaWWXVkAI/R8qjD/Q7fonbKz+RmMMrn6
	t7d3sG+V2z5JnUMgx87TZGUgODT9f3YvBzOEkXMVYPcBIdUalgN3UGz+2BCrXAeNV8G/gAqQEL7
	cuLgw4PGcBH+0Hw==
X-Received: by 2002:a05:6000:2902:b0:42b:3302:f7d4 with SMTP id ffacd0b85a97d-42e0f21e95emr32534248f8f.22.1764707677994;
        Tue, 02 Dec 2025 12:34:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCyc6lQUGvpJgau4DGFTjlH430/9UVRhi3imtNoOw0B8iZ5oBNNHjJSSuMOr7ztA373HOxvA==
X-Received: by 2002:a05:6000:2902:b0:42b:3302:f7d4 with SMTP id ffacd0b85a97d-42e0f21e95emr32534227f8f.22.1764707677562;
        Tue, 02 Dec 2025 12:34:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d6181sm34941356f8f.18.2025.12.02.12.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 12:34:36 -0800 (PST)
Message-ID: <03484f2a-9429-4680-9172-0859e21e2994@redhat.com>
Date: Tue, 2 Dec 2025 21:34:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-2-maklimek97@gmail.com>
 <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
 <3428eb6d-2698-4a08-bbb8-336c633752e9@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3428eb6d-2698-4a08-bbb8-336c633752e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 5:41 PM, Mariusz Klimek wrote:
> On 12/2/25 12:36, Paolo Abeni wrote:
>> On 11/27/25 10:13 AM, Mariusz Klimek wrote:
>>> This patch fixes an issue in skb_gso_network_seglen where the calculated
>>> segment length includes the HBH headers of BIG TCP jumbograms despite these
>>> headers being removed before segmentation. These headers are added by GRO
>>> or by ip6_xmit for BIG TCP packets and are later removed by GSO. This bug
>>> causes MTU validation of BIG TCP jumbograms to fail.
>>>
>>> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
>>> ---
>>>  net/core/gso.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/core/gso.c b/net/core/gso.c
>>> index bcd156372f4d..251a49181031 100644
>>> --- a/net/core/gso.c
>>> +++ b/net/core/gso.c
>>> @@ -180,6 +180,10 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>>>  	unsigned int hdr_len = skb_transport_header(skb) -
>>>  			       skb_network_header(skb);
>>>  
>>> +	/* Jumbogram HBH header is removed upon segmentation. */
>>> +	if (skb->protocol == htons(ETH_P_IPV6) && skb->len > IPV6_MAXPLEN)
>>> +		hdr_len -= sizeof(struct hop_jumbo_hdr);
>>
>> Isn't the above condition a bit too course-grain? Specifically, can
>> UDP-encapsulated GSO packets wrongly hit it?
> 
> You're right. Also, It should actually be skb->len - nhdr_len where nhdr_len is
> the length from the beginning of the packet up to right after the network header.
> 
> Should I send a new version or wait for net-next to re-open?

You need to wait for net-next to re-open. Please note that due to the
unfortunated calendar (conferences and EoY) this could be longer than usual.

All the information will be shared on the ML, as usual.

/P


