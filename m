Return-Path: <netdev+bounces-197733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB8AD9B2E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64E87AD24B
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7761C1A2622;
	Sat, 14 Jun 2025 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJmyjqOP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CF17D7
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888271; cv=none; b=csQSlk8ughJiAQSAjiAoCcTdv8iZ+mx4JTh9uIEM0IO7zOh7dRAZuCMmXvwwLolsaDAgRUDaxvWgz2j/NucOcaMt9zi222I+fdoU2M9jgGysorzK3ZNjT4DepVWCzWOpSlim6FehGUCA/5smbYLl/+Kw84UrhQxAPN4tyfcSWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888271; c=relaxed/simple;
	bh=zzmibGdCsxOa4m/m56xM8PSnA7HSBEtfuDqFI+ShFBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ry/JMwPTwncyIcfHjtYu85L8DGufoMHxJ+KetjvN4ARReMSCQ0doOmz4a3dNANZCdCFe3iSbMd9oiJ5AxKqg4KwCTCgK4/RrOcwpd/fTxzc49nuu6PMrGcOTb8GPaVBd86RryLfo0ulQjWc95sfnmJAiQNRVN2umyy2nJcScqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJmyjqOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749888268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVokNRqP6aO5yLUSRdwJYksPy+B5cEflV2xVFSxRaiE=;
	b=jJmyjqOPlZu1FeeCqudVTfcSweO6OP3WHZ2OznUA7VSw1u8AS3pv9+R8P+DmAQHBNTw86b
	fdrkOb0+cjQ0BLlhZGwmamTuwV6AI9KYpM3az5wESWn2RbLB8fKcnHWN0oYhH6NWJTWseC
	uEiitc4KjqkXmNUa4CJ5vusW8ineP/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-vO-ul-BdNl6GVeECzJo8DQ-1; Sat, 14 Jun 2025 04:04:26 -0400
X-MC-Unique: vO-ul-BdNl6GVeECzJo8DQ-1
X-Mimecast-MFC-AGG-ID: vO-ul-BdNl6GVeECzJo8DQ_1749888265
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450de98b28eso21268535e9.0
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888265; x=1750493065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVokNRqP6aO5yLUSRdwJYksPy+B5cEflV2xVFSxRaiE=;
        b=i1EcUoYmHkCJd2SMuSumP44yVzO0FjVTnE6jn7ZbkZdaHlQ/OkiWK0RdsvRK9kCyky
         WzeIMALVaZv1Ym8QeO5PZQU3dQRwS2/2FVrCNnb3Jly+7i66CWBmtFOZZLUmsSF9zji2
         zQUMH7jARx6TxhS31YwTvyO1clZBVIo6n2qDqno6OwaQyggHaiL1y+LTem/NvbO65N2e
         eAMe/QOe+j8pWQymGKuvFQ97YXkuUoFHKLCceYTTQk5Hp9RhRHuw7jMWKw6Jm457ZKbr
         K4B1AUwRO7wxbE8M7scPNNZ6jQkHx5Fd2kRCqtQj3HxeicGMJ4hn5sHRVj7rY7fFaegU
         +Uqw==
X-Gm-Message-State: AOJu0YyI90UFD+FDgwNbXWpqtYWbQWIAA61vhW3T7zsPjJBRZUCw2UvU
	RJKlWqPwBU3aBkNtmvvwqbyXytuG7zoBvXshoXmFFwUDzoRxTMl9ePLldeC2ea9ZFFt20zPP5sT
	rR9wJJowWXaR1tAww2kBhTrGtPkiok+8Td5IGhzxmslx+gt1P96UVx6EwHQ==
X-Gm-Gg: ASbGncvZ1++2cSigVDeXetkRAwsnKNtRU5EEitLDyPUwvx8y2iSlImAkiRRFhO+7rjA
	phPRu5F7WJSisoyrzaXSbTCDZXbDPgjfRPKliDuVWjHyqz5IV9MrYKHItUTd9xBg7F0cVsQswEk
	WVnhXkUmdslPfXh7XEtlY7YSHBI7odQwyqv6sv5VzDwj7WySyB0dpu4yLtb4hXlXfZJHt82m8NO
	JH2XCDTAVfuGGir2xX1nHW+4P8hJEpOAgTPjfHVliKyFWcZZX3UdfcWRMtacR0xtK3Tw32o1mAE
	5Xf+iTVBpgYjWJsXO/cfXX+BDX8D2IubKhL3Sydh4BBy/gFMuQltcE76
X-Received: by 2002:a05:600c:8b45:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-4533c92e57bmr25131085e9.10.1749888265502;
        Sat, 14 Jun 2025 01:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+OZEVUNr0txXx5dctnsYMYWB7E4o4jwUdJ1BSHiLUl0SyZhTJWLJRWE7WiuMog3UHOLxz2A==
X-Received: by 2002:a05:600c:8b45:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-4533c92e57bmr25130685e9.10.1749888265088;
        Sat, 14 Jun 2025 01:04:25 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13cfbesm76415655e9.22.2025.06.14.01.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 01:04:24 -0700 (PDT)
Message-ID: <3da348e2-9404-4c6f-8b94-1c831ff7e6f9@redhat.com>
Date: Sat, 14 Jun 2025 10:04:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 6:55 AM, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index 287cdc81c939..79d53c7a1ebd 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -93,6 +93,15 @@
>>  #define TUN_F_USO4     0x20    /* I can handle USO for IPv4 packets */
>>  #define TUN_F_USO6     0x40    /* I can handle USO for IPv6 packets */
>>
>> +/* I can handle TSO/USO for UDP tunneled packets */
>> +#define TUN_F_UDP_TUNNEL_GSO           0x080
>> +
>> +/*
>> + * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
>> + * the outer header
>> + */
>> +#define TUN_F_UDP_TUNNEL_GSO_CSUM      0x100
>> +
> 
> Any reason we don't choose to use 0x40 and 0x60?

I just noticed I forgot to answer this one, I'm sorry.

0x40 is already in use (for TUN_F_USO6, as you can see above), and 0x60
is a bitmask, not a single bit. I used the lowest available free bits.

/P


