Return-Path: <netdev+bounces-184670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53FAA96CC7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F623BB49D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165A283CBC;
	Tue, 22 Apr 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu5Zj+eu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF476283CA4
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328464; cv=none; b=X0m2S9oJ9SpVKU3XOZyeXnMZYuUdA06zJHzuTWH8M2o8RZUe8GWVGTdjQdm1WpEDG1U5Id7m57k9/oVT4CaDCMAcuv88uz2h2Mr5MbJJ9D4Eycnd34Ilx9G4PAo69GNldIB1/hpVx3mvUn6yhm0WE1HzL2I8ih+/xcyvpxs3Y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328464; c=relaxed/simple;
	bh=EQCtPB6vig1BWXkhsUPFWKuYqQaajrFDU8o+69PjzzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHk3hIr+Y8wdUNm2MF6N85CkXMKNggC7edvcB2ms6k4KSCgMD8JXVSVbMJsXB+sPCfJ+goFIffL5H5OI+ZmNNuy2PLe/Xrrl/njAR30fUeHuY6h6iPfUAPoTv5/q66YCEske6YQeY8DKKb4ct8Z/1eAlN4RrG5yWE1fl2dpD9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uu5Zj+eu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745328461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UwdpGD0fRMaU1gXvakXekOim8TBkzbwWuAWNIFkxTA=;
	b=Uu5Zj+eulTZlBU6Goh5gmFMxcnRylfhthbImI63FAgL1hjxjvimSmFxzEJKu/DMndGWrY4
	dRMZPwdrZjdxrlG/9DoMKtcw9NlyW9hrvWOOp2pdR9EfOda3Dydsx0p1QauvkNQ/WD75zb
	fS8bD+c3Fh6Xx2GDD5hf9EUtR2/Ib4s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-y1T9KVTnM-SlaXKCl5XDtQ-1; Tue, 22 Apr 2025 09:27:39 -0400
X-MC-Unique: y1T9KVTnM-SlaXKCl5XDtQ-1
X-Mimecast-MFC-AGG-ID: y1T9KVTnM-SlaXKCl5XDtQ_1745328458
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso33362925e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 06:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328458; x=1745933258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UwdpGD0fRMaU1gXvakXekOim8TBkzbwWuAWNIFkxTA=;
        b=ItMTHTNLf1t5FVFp4LFiNd3Ej17o+DH0/YMVVqw2kZj0BK5wWO4vLvdQSUl924++bp
         Ri90xUaV3OVVPn59HfbOdxxq1rcACh621UZW7/qx46qXGcRwP82sexz6Zi2fspXhgCb1
         a5IEMnj/erGHnpsevtD2Dl9mTEcM5LsdCoOqPcmc/CWVdWdISAX/7qR3AHDOfj9Tytk8
         CWDSsQwi9N0Y/T/SozoE4S/2BiZV7MeF6fMKdBvccLR0T/EGOOAoxFokQo/OFRvkZlWx
         BAO8gkUYPeYH8vJ7iOwdtu7upkY8E5D3Cta96gdnIQlhRWwRg8Ig/q5nFqoQKmyyib6x
         tf5g==
X-Forwarded-Encrypted: i=1; AJvYcCUEu+sBoOfQM+gIWlym2nUtw/J3N98dofR9SecLCpEnNlny7i+9E5aT+d2zm8m1W9kEKGCC32Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJKIIOGKa6r0N4cphjVxIOmlbdI5F1mVA7xSkt27nV1YLhq4s
	zKolZ/SDV7JehQADhqT7Q5ysom0iTpQqtpMVXT45lv/4q4EaBFhwzukSfxQRnXJScOSYmHP6+4T
	kOwlpvIdGRX+ZUfFXSUwuUvK933KAARwGnAXbVE7koWc/hX8MK1cuWg==
X-Gm-Gg: ASbGncuasKBs3OztrWG5FSyNEAdfjBcEFvoR3o78E84Yyk9jz+nP6KEx2aVlt1AMBp2
	yPMU1uo7byFF1+IGxfxyeDEuXRR/qPDh6fNB84hjXnksdyeUZNSqC/L7DZUXRRo7l7CcX84ZM1x
	GW25A3ISDrLKdZijgvTXk+YoNyzzBT+RbKlley+6o9TOxw/v11mu5mK0A7tNmLI01fD6rtcqFyq
	8MQHHxrS2XMkvjRy1u9wpCUtsS0kCPUlKKBClscn1PEt37x/rb8/4MMsgja8n1Zm1RgHsvZB/ea
	6V/7Hkxcc+LddmQ/PaLxdTBBjIh8GYHarcRr
X-Received: by 2002:a05:6000:401f:b0:39a:c9fe:f069 with SMTP id ffacd0b85a97d-39efba5c445mr11588019f8f.30.1745328458283;
        Tue, 22 Apr 2025 06:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMFkPqpRqcNuzcFnHj6Skl43ARpjqnMI6BNLMea1wY6RizjcHM5ktMU4nEoG/0S/ogkDjhNA==
X-Received: by 2002:a05:6000:401f:b0:39a:c9fe:f069 with SMTP id ffacd0b85a97d-39efba5c445mr11587993f8f.30.1745328457846;
        Tue, 22 Apr 2025 06:27:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbc13sm172207495e9.17.2025.04.22.06.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 06:27:37 -0700 (PDT)
Message-ID: <845bd2b4-a714-4ddd-8ace-a45dcdbd486c@redhat.com>
Date: Tue, 22 Apr 2025 15:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/3] net: stmmac: dwmac-loongson: Add new
 multi-chan IP core support
To: Yanteng Si <si.yanteng@linux.dev>, Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Henry Chen <chenx97@aosc.io>,
 Biao Dong <dongbiao@loongson.cn>, Baoqi Zhang <zhangbaoqi@loongson.cn>
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
 <20250416144132.3857990-3-chenhuacai@loongson.cn>
 <fe0a5e7a-6bb2-45ef-8172-c06684885b36@linux.dev>
 <CAAhV-H5ELoqM8n5A-DD7LOzjb2mkRDR+pM-CAOcfGwZYcVQQ-A@mail.gmail.com>
 <99ae096a-e14f-44bc-a520-a3198e7c0671@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <99ae096a-e14f-44bc-a520-a3198e7c0671@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 4:29 AM, Yanteng Si wrote:
> 在 4/21/25 12:20 PM, Huacai Chen 写道:
>> On Mon, Apr 21, 2025 at 10:04 AM Yanteng Si <si.yanteng@linux.dev> wrote:
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> index 2fb7a137b312..57917f26ab4d 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> @@ -68,10 +68,11 @@
>>>>
>>>>    #define PCI_DEVICE_ID_LOONGSON_GMAC 0x7a03
>>>>    #define PCI_DEVICE_ID_LOONGSON_GNET 0x7a13
>>>> -#define DWMAC_CORE_LS_MULTICHAN      0x10    /* Loongson custom ID */
>>>> -#define CHANNEL_NUM                  8
>>>> +#define DWMAC_CORE_MULTICHAN_V1      0x10    /* Loongson custom ID 0x10 */
>>>> +#define DWMAC_CORE_MULTICHAN_V2      0x12    /* Loongson custom ID 0x12 */
>>>>
>>>>    struct loongson_data {
>>>> +     u32 multichan;
>>> In order to make the logic clearer, I suggest splitting this patch.：
>>>
>>>
>>> 2/4  Add multichan for loongson_data
>>>
>>> 3/4 Add new multi-chan IP core support
>> I don't think the patch is unclear now, the multichan flag is really a
>> combination of DWMAC_CORE_MULTICHAN_V1 and DWMAC_CORE_MULTICHAN_V2.
> OK, please describe this code modification in the commit message.

@Huacai, please extend the commit message, as per Yanteng's request.

Thanks,

Paolo


