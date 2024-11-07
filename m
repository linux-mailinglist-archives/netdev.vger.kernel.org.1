Return-Path: <netdev+bounces-142712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F09C0125
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93151F22203
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6511196D8F;
	Thu,  7 Nov 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt4dsEdZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F9194AD8
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971870; cv=none; b=dRnxvVuh7SuBjjVj5lmHwbrg6a4fGkTXO4hwLhUdc/fqsOG1q9mDN2KrORnz62g6y4AW14OrHPrYDC861V/yRsB4UWhdv5e9XZ5mzg783azvlIheDxOP07EZjY2x5G7B0plMr5XJUV5bLoOKz/CZfwFxNLrvEZyIvmG3nIgPdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971870; c=relaxed/simple;
	bh=/D5syvUjOBxSlK8kvUXHUBJ8zR0FkgS2l+lKT19FiVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+GLiXyoSjXooozspsMEpOpZtoxznO2mTqQ6sANvCtZWfcrf3mt1gYHSMLIyeCMQibucpCU1wdn9iXr35yNmOndtOBaHHY/H8X0Eg2tHagYKaOiGiyR25thxOheIWP8NUZcmtvh8opuAleq/lg/rnxiGyCJR5hQ85p1jGB6EKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nt4dsEdZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730971868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueiDthDFqxwLFYf7b3aDU9CVHTSeCEaca5mg+7dcvLk=;
	b=Nt4dsEdZEvru3edeDTtCT+NEyzBjSZNh4FC7vWy0iMYi5kaCAo6CuYlf/k7/cWROqr4f35
	a/+YWCW+csG2l6fu9Mocg8KW4b24FL1WicTwX8aTyPsbPdVrO8x1NE31YwcTp3eLLNqOJr
	xNd+tg0JUSUmrLIM5gww7r+6EjE/7fw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-hHtyXNzyOJufGWLzspKfWA-1; Thu, 07 Nov 2024 04:31:06 -0500
X-MC-Unique: hHtyXNzyOJufGWLzspKfWA-1
X-Mimecast-MFC-AGG-ID: hHtyXNzyOJufGWLzspKfWA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315cefda02so5844305e9.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971865; x=1731576665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueiDthDFqxwLFYf7b3aDU9CVHTSeCEaca5mg+7dcvLk=;
        b=MUaF3Rb7gFWlcOuA3TozDzYPiGAs2CR1WKyV59Yp8Q+IkYjH2cR4SenL/9j4SSrsto
         Dsx8W8lIifk1iwnHvbzBxAcQD+QZgnZuSyRfshebVZ4QEs5N+Mq6Ma4u0BIFoWtLFEL0
         2kRC55XXEPq244RLPNGAFiIsLUrowKrnO8JnxpqC/TWTJbhkpv6xWCcKAC4jl8Im/4H2
         mjzd/rtV4TD0+rr5Nwwo4jaHKWDkXjliTHk43FtU8Fz5iwmKMcVYNkcGwqw0k0gxogvK
         NjmHdGtMHlMExKm8WCIcKc2+umrxXMNadOY9+9Aw9HUi3udi78/6741pti9sNTuwR3YC
         goTg==
X-Gm-Message-State: AOJu0YxdAqiSWEF+GLoQKnOmtsSZqu7eW1nf8uNVwBoO9zeBwtY+hQ2Z
	+biIMq1aE+1PHzmKbrVMo3FK5/R8ZNGuRc4BRLjjWf4Cf2K9mwOzWjzW9zGCy+JyPXp5BntgnvH
	MFcrf0TVeLnVLy2FRUpTTyxqBRnvExZhXGvVLtMlNTZIZu7hGfaGP9g==
X-Received: by 2002:a05:600c:524b:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-432b307b364mr5977105e9.26.1730971865632;
        Thu, 07 Nov 2024 01:31:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkmBrArrmJMdgAUuLkOLXQwa+TQTVW4TaixXP6SkrXujKRv/htZAL0smZaX2Q4QCAQ5P+uVQ==
X-Received: by 2002:a05:600c:524b:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-432b307b364mr5976915e9.26.1730971865284;
        Thu, 07 Nov 2024 01:31:05 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05673d0sm16540365e9.25.2024.11.07.01.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 01:31:04 -0800 (PST)
Message-ID: <866ca6e3-1ea4-47ad-8df3-a8ab9604d48d@redhat.com>
Date: Thu, 7 Nov 2024 10:31:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: nfc: Propagate ISO14443 type A target
 ATS to userspace via netlink
To: =?UTF-8?Q?Juraj_=C5=A0arinay?= <juraj@sarinay.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, krzk@kernel.org, kuba@kernel.org
References: <20241103124525.8392-1-juraj@sarinay.com>
 <20241106101804.GM4507@kernel.org>
 <a0d73e24863106f477abba75b996f4b9ff00d737.camel@sarinay.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a0d73e24863106f477abba75b996f4b9ff00d737.camel@sarinay.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/6/24 15:58, Juraj Šarinay wrote:
> On Wed, 2024-11-06 at 10:18 +0000, Simon Horman wrote:
>>> Add a 20-byte field ats to struct nfc_target and expose it as
>>> NFC_ATTR_TARGET_ATS via the netlink interface. The payload contains
>>> 'historical bytes' that help to distinguish cards from one another.
>>> The information is commonly used to assemble an emulated ATR similar
>>> to that reported by smart cards with contacts.
>>
>> Perhaps I misunderstand things, and perhaps there is precedence in relation
>> to ATR_RES. But I am slightly concerned that this leans towards exposing
>> internal details rather then semantics via netlink.
>>
> 
> Hi Simon
> 
> Thanks for the feedback. NFC_ATTR_TARGET_ATS would serve a similar
> purpose as the following attributes the kernel already exposes (see
> nfc.h):
> 
>  * @NFC_ATTR_TARGET_SENS_RES: NFC-A targets extra information such as NFCID
>  * @NFC_ATTR_TARGET_SEL_RES: NFC-A targets extra information (useful if the
>  *	target is not NFC-Forum compliant)
>  * @NFC_ATTR_TARGET_NFCID1: NFC-A targets identifier, max 10 bytes
>  * @NFC_ATTR_TARGET_SENSB_RES: NFC-B targets extra information, max 12 bytes
>  * @NFC_ATTR_TARGET_SENSF_RES: NFC-F targets extra information, max 18 bytes
>  * @NFC_ATTR_TARGET_ISO15693_DSFID: ISO 15693 Data Storage Format Identifier
>  * @NFC_ATTR_TARGET_ISO15693_UID: ISO 15693 Unique Identifier
> 
> The ATR I am after means "Answer To Reset" as defined in ISO 7816. It
> has little to do with ATR_RES := "Attribute Request Response" defined
> in the NFC Digital specification. I only mentioned ATR_RES as the
> source of the information handled by nci_store_general_bytes_nfc_dep(),
> the function that motivated some of the code I propose to add.
> 
> Part 3 of the PC/SC Specification, Section 3.1.3.2.3 on ATR may perhaps
> serve as a more authoritative source of motivation for the patch.
> 
> https://pcscworkgroup.com/Download/Specifications/pcsc3_v2.01.09.pdf
> 
> The goal is to access contactless identification cards via PC/SC.

Makes sense, thanks for the additional details.

Small nit: you should have retained Krzysztof tag from from v1.

No need to repost.

Thanks,

Paolo


