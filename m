Return-Path: <netdev+bounces-185456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064CA9A720
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E099C7B27ED
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28644224251;
	Thu, 24 Apr 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCbAHyCz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56656221DB2
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484855; cv=none; b=BodXWR6a9j2xVd9aH49XPzr9LxMlko/iDuUYCAZYeh4p9HH+KNa9KUV2ND7EoUWGwsS0WcPXj67PUXxbQzzqToL+LlpH8S69/zcuZP7A5P5EYRl1mTPiOuhqdbYbNXxU4845ocA1Cw81e3LkyQ5SgbRDB1rRHATua27j4TV5NH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484855; c=relaxed/simple;
	bh=paGGoyoZnRW1m7g7h1F3XFqoQ0+nQRGX9p7YkqYjVWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o56WQxNwopsPRmApBBCXroQOKp62J7g1er5HhBrWV6m1v3U0j27mGUdyvBAEvmz77k2muYOqNLP+MUy7VF/BaNMEsQm/l6t6GTUy6UNFFgypZC9GUHq8jNCT1Q1TJZtiBaM7P1Lewtzt3/GLEkRhCAIFlji6DFEgD+mq7PytRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCbAHyCz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745484852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pftB6zmblfz1vCxU5fqCKgvx+TE18dKtjoYVArm5R6Q=;
	b=WCbAHyCznq/5vYkE6Zw5Pmta0D8S0F5DN04arSGb7maUmovyDNGEl+In4jzfF/geEmxfxP
	Lt1Ey1xtVhrDtWsZcVuIMpG8jmb3fk82sxf6RBhe+W57YSLf2AsluiEd7KZfK8imvcQPHo
	fYlrHUFh5pjrv+CmROmIzXfkNSjApZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-KqcNtw-ZPHGlk3jDj33S2w-1; Thu, 24 Apr 2025 04:54:10 -0400
X-MC-Unique: KqcNtw-ZPHGlk3jDj33S2w-1
X-Mimecast-MFC-AGG-ID: KqcNtw-ZPHGlk3jDj33S2w_1745484849
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf446681cso3879935e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484849; x=1746089649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pftB6zmblfz1vCxU5fqCKgvx+TE18dKtjoYVArm5R6Q=;
        b=qb5yzPJC41HIoWsbnW8WvSe+B3O1pAJR8pS6NYtBenb3oWjgssiIGgLflXKJS84PO4
         TGOR+VJXDzwuacJObc3x2+uZFHtGOM/6C9gfm8lNFGrqsOlaVtHzUR4Sdx6XX4yy96zR
         TXebu3aoWdtD0/8gTZ/nhMOSePC+ILK1VkrDRe+UE3EybjVa8iJfHucr87oXSYlmPF2M
         IRKt6BrPKV9eOFpRDO8mrkaHAmKcu6r9qCSF+zZ1/dqH1LdUncDkRiVvzbywgiYxjOtO
         JF9MPAvQ/kREPObdZUeCjz6iAahO6u6hXz00Y75Qh02d76nYmvoMxAZrjJbrjn9sok9q
         +sSw==
X-Forwarded-Encrypted: i=1; AJvYcCVk/lpG8AZ2D0Oy9HADUa1p8HUGopQwvr3w3OnyWaY/6C81zk3p4wNugcaRudyoGl/BW0e+5hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2fDX5pYKlRXd32xEb3VCQP8+vUKJcfk80uVHSMvS58/WEBxq
	xj7j2feuVsyM1q8DfXj6HiOT2hLKNXpMYeFjvasw2+lPHd6WZNUfMbJDFwwSZ21YWNyLYPZ+sVW
	YKrjVMf4v3CXLSms/AYXmIqBJFEMRB43y/PdDJondbrDemSpsWL07vw==
X-Gm-Gg: ASbGncv5iZBDTT7SxRg4f+fL1+ValV0iKyus2Wo+60YG6iOnCcTme4DXhRLuX8NEq8S
	fwyJoj7q2xO4xYzsQtouUj8vNwKQJp1IJggVEpevxT9WJDsJbbeLenc/dDpCIY+mGrT7RIXR+EE
	0rIVCw6ck8s6nzjwU9EtiXrKNt+qhAYktWRiFMSLGzn5qUw4vitx4xsAStFI8Kns2JlqDvJNFkz
	oSVXl59SakXIlrOlSJbLR+dbL9T3jYyPxMlLPuM/ZBPBZPrKSykguDChVvkyQcgcTSwYgpjZWhq
	Gk0GiQmVe2qUB0vCxJFgoARvNBTxIbh0IMpfrfk=
X-Received: by 2002:a05:600c:4e0c:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-4409bd86819mr13058205e9.25.1745484849210;
        Thu, 24 Apr 2025 01:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqstuVMKXRfIfjVGAhmeakWqDfpmADfftb5xQky926OxvT8IMDcEdyz8TdVKcbRypTiAhDLA==
X-Received: by 2002:a05:600c:4e0c:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-4409bd86819mr13057925e9.25.1745484848793;
        Thu, 24 Apr 2025 01:54:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a3afbsm11871335e9.16.2025.04.24.01.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 01:54:08 -0700 (PDT)
Message-ID: <d5114fb3-4ca8-4ab8-acb2-120a7b940d6f@redhat.com>
Date: Thu, 24 Apr 2025 10:54:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
To: "Badole, Vishal" <vishal.badole@amd.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, Thomas.Lendacky@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Raju.Rangoju@amd.com
References: <20250421140438.2751080-1-Vishal.Badole@amd.com>
 <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
 <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 9:57 AM, Badole, Vishal wrote:
> On 4/23/2025 3:50 AM, Jacob Keller wrote:
>> On 4/21/2025 7:04 AM, Vishal Badole wrote:
>>> According to the XGMAC specification, enabling features such as Layer 3
>>> and Layer 4 Packet Filtering, Split Header, Receive Side Scaling (RSS),
>>> and Virtualized Network support automatically selects the IPC Full
>>> Checksum Offload Engine on the receive side.
>>>
>>> When RX checksum offload is disabled, these dependent features must also
>>> be disabled to prevent abnormal behavior caused by mismatched feature
>>> dependencies.
>>>
>>> Ensure that toggling RX checksum offload (disabling or enabling) properly
>>> disables or enables all dependent features, maintaining consistent and
>>> expected behavior in the network device.
>>>
>>
>> My understanding based on previous changes I've made to Intel drivers,
>> the netdev community opinion here is that the driver shouldn't
>> automatically change user configuration like this. Instead, it should
>> reject requests to disable a feature if that isn't possible due to the
>> other requirements.
>>
>> In this case, that means checking and rejecting disable of Rx checksum
>> offload whenever the features which depend on it are enabled, and reject
>> requests to enable the features when Rx checksum is disabled.
> 
> Thank you for sharing your perspective and experience with Intel 
> drivers. From my understanding, the fix_features() callback in ethtool 
> handles enabling and disabling the dependent features required for the 
> requested feature to function correctly. It also ensures that the 
> correct status is reflected in ethtool and notifies the user.
> 
> However, if the user wishes to enable or disable those dependent 
> features again, they can do so using the appropriate ethtool settings.

AFAICS there are two different things here:

- automatic update of NETIF_F_RXHASH according to NETIF_F_RXCSUM value:
that should be avoid and instead incompatible changes should be rejected
with a suitable error message.

- automatic update of header split and vxlan depending on NETIF_F_RXCSUM
value: that could be allowed as AFAICS the driver does not currently
offer any other method to flip modify configuration (and make the state
consistent).

Thanks,

Paolo



