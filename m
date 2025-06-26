Return-Path: <netdev+bounces-201544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F565AE9D58
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596AC1C268C3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E21AC88B;
	Thu, 26 Jun 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1f6c+40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E033F9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940402; cv=none; b=Q54wZ+ZrXvHnpG1DkOrt4xeI5C0EofpLwGXSejRRcr3a5D6Be4H/5rbsXlxjFDUTZOyWgvtAE+9LJGRCF+UZrLhQ+mDMs2P22GRJ+LRHUxSqFji5CTJibVQpxjzk2OWoheFhX4ytiQz6ztcZEOYQx6xUqC9LrTY0uJSL/5kQFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940402; c=relaxed/simple;
	bh=XzxjuhCs/k1M3A+5Vks7C5J8QTluBHAjR7zpLY9PeT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4OMf6VTOE79/KeKAxd4dR/OQr4qoCF9ZlT6b7NkWdwOr5iqX68Bd1M+KvDmzASVGKfLWJJUjhK9lzoqE/IRf/M3+1LSzeyn08v9W8oReQ8ywdg9CKyrQFdnHfN2kgF7GYim/YQj84UJreVQ6CEicLQVKTcEvukEfbc19rshLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1f6c+40; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so9539366d6.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750940400; x=1751545200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55pV9PkLdVLLbowt1vxoDtKkZVQBIQsno4sCRSRAaro=;
        b=K1f6c+40bM/NkxZZHnLBR5D+2ECeDUzTX77q5I6BfiH4EP7kvm9IBteRb79k7g4AP4
         iDXtNUcRASbeo/BOlX3SAE8CQx9v1k797j0UW+99Fyw3Njh1KSqTSpJe/AxzYgHsh/PL
         DW5VC+glqTl1PDGAcBH4o9EeGurIIKScNyCnIWV/9r6/OIB45n+L2kX2yWPBpNMPaXrx
         GTgJMG58qmB1Jf3tSJ7aIPqjavR/7goUemifMwkVbkPC75azynKlcCKkfAvtayE9JaK9
         C/89CkevBRGbMCxFqFkSGNGr7NaqpaIRUwKbD3eagA+++0TaUPOL7ltfGtahQ1mPZ2d+
         fvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750940400; x=1751545200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55pV9PkLdVLLbowt1vxoDtKkZVQBIQsno4sCRSRAaro=;
        b=akbwTrCE8kZ6zTKat+oVQsXF8D+XNzk274Lmu7GX+HBaDYzHWnSLnf5tLtLvCWT8/3
         TQDQN7pjhuIixBGxPf9FbAM4yzNWdlgJTb8YujMHalRmpkWLD2ojrqNk7MUvaezklk1x
         gcNzs+HbykpL0FxG2jxuqtzPpu/kScpN0imzyypxTvMbZH8wOG8JsP39oKa/G22kz4Ms
         Yqs5AMtHVGHGFWgCkDR7yh5um/osxESfjpzzZwKPP5F8SEVft8TugpVs+ROxKXDfSxv+
         QflOHtgpicNvvVr9sHs/EmXscN7dYZJWVjo5qOKEADWxfODpERxGtCgaQ7ib/cvyft2F
         MBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8TvfcouUxRv88a7KwNIHsWylJPqzb7WGi4cKm6CFPnoK7xmOwebDuxb8Rge7h/Q4rFQfPxBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgQ8rL1yflLk5rbpgDqMJi8edWisXcvsSoOSyyafAY/psrAO8
	RSS64DPUqPIHj817BfAH/EhuadNAcnfT/dpMwtfEzlrznmKm5ds9GoN7
X-Gm-Gg: ASbGncvKcGpoicwLj1WMSzfdQHgoW0cApg6PBwIGYhgG1/esMaCThnqqkyEJp/F83uu
	cz3LlfY6U3lKxfM7EdGcpyMAsMTvxjxu3iRRQodpC05BvJUXF/Bh1SfW3nXwDDVZHSp+tkdGKML
	nQpOBWjtEm9pxsz8yzxhy7TFTl5xipn6lXuwruHFsBb7CfIhYJW8SStJrF8jBL8QUv19kRXA0ZZ
	7cCkanZcQ1sKCrgCH1A3i+hRRS0WIAPTmxqdLtv1dbOwBqj3TE6cELKzF/5ixpqiI2ELQC/q/4H
	FTVFakUH0W37Oj/+OVRaLO/qOTvYv02/hDTG3vqHEon3Av6yY6v86btI+N9mXVGY1qW8ETYe2Lw
	9nEv+X195x7CSfUOLrl9MpNbg9M/6w0Yz0xvomCGT
X-Google-Smtp-Source: AGHT+IFZhzyBFLFnvua7f2bkmq22wq0ISdeLLCUt08Y9Zocqb+Apb+fdR4PI+GMBczSbilklh/bVbQ==
X-Received: by 2002:a05:6214:2f8c:b0:6fb:597f:b4d0 with SMTP id 6a1803df08f44-6fd5ef5addfmr121799346d6.6.1750940399651;
        Thu, 26 Jun 2025 05:19:59 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718e77bsm6631116d6.10.2025.06.26.05.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 05:19:59 -0700 (PDT)
Message-ID: <a6f3efcf-f820-4b0e-8d2b-9b818b58fc2f@gmail.com>
Date: Thu, 26 Jun 2025 08:19:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] psp: track generations of device key
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-11-daniel.zahka@gmail.com>
 <685c9236a44fc_2a5da429471@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <685c9236a44fc_2a5da429471@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/25/25 8:20 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> There is a (somewhat theoretical in absence of multi-host support)
>> possibility that another entity will rotate the key and we won't
>> know. This may lead to accepting packets with matching SPI but
>> which used different crypto keys than we expected. Maintain and
>> compare "key generation" per PSP spec.
> One option is for the device to include a generation id along
> with the session key and SPI.
>
> It already does, as the MSB of the SPI determines which of the two
> device keys is responsible.
>
> But this could be extended to multi-bit.

The idea behind psd->generation is that the device can give each device 
key an id, and then on rx, the device will fill out the rx metadata with 
the id for whatever key was used for decryption. The policy checking 
code in the tcp layer checks the generation from the rx metadata against 
the one in the psp_assoc from when the session key was created. In this 
way, psd->generation is opaque. It would be most intuitive for it to be 
something like additional MSBs of the spi space, though.

>
> Another option to avoid this issue is for a device to notify the host
> whenever it rotates the key. This can be due to a multi-host scenario
> where another host requested a rotation. Or it may be a device
> initiated rotation as it runs out of 31b SPI.
>   

This will need to be supported in any case. I think this is all to deal 
with any potential races against getting a spi after a rotation and 
immediately trying to use it to forge a packet targeted towards a socket 
on the same machine that may now have that same spi from a previous 
device key. I'm not sure if that is a legitimate concern, but if the 
device has the ability to provide extra device key generation bits with 
rx decryption metadata, this just uses that.

>> Since we're tracking "key generations" more explicitly now,
>> maintain different lists for associations from different generations.
>> This way we can catch stale associations (the user space should
>> listen to rotation notifications and change the keys).
>>
>> Drivers can "opt out" of generation tracking by setting
>> the generation value to 0.
> Why?

If the device doesn't support this capability of filling out rx metadata 
with additional key generation bits beyond the MSB of the spi.

