Return-Path: <netdev+bounces-183663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13FEA91727
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB33BE41F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF82253FB;
	Thu, 17 Apr 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdlwYOr8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA933FD
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880385; cv=none; b=ahsU+hbYpqowpzLTHY6I88AeVMJwan8MrGQ7TdoBqdgaeoVNupswnriNSBCfpNPvtY39Yz7wCYUrbm+I36tD2JkVUCBqgTqZbnMftKGcECR97vo3vMBsSrJLe35D4In2INPiDskncBYMkWqsK6h4sWph4mrH9Fj9dUqolR49IUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880385; c=relaxed/simple;
	bh=nvO8r9/9pdugNKL3LJVkkvN6BYwiPC7vTaCV4mb+Ltc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOrxSgtDKAbwFu2rPb4HN3SxWmeQRXZcAEnumSRB39xi2fA4MfKSoSVzApSdgVl9b44pMDpnhfcgMugfbuSYyG9q1Ipie1NDX+BFUB0BlP6oTiNrJ7dCq1/XPPHiCuppmbwN99Tly7jct3FHDTwMN4PiKmZgMPkh2Qik0TUidv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdlwYOr8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744880382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GfMQK4BWJGxmnVTgDrQuVVqoMNetehKp2lZCVxuF/w=;
	b=GdlwYOr8wflWSbycV4CnbwvaUgO7rkIB58TN6qhrBAG5GhYsT/jcUGimvaNlNUiWID+SKY
	Hpq2nhYqsC2kxOLCJObtUWziLuBwgB7zHP5bA37EiLuEFepw4Bo7+ZFpmk3ZtNujqzkto8
	SQdJoZXD6qj/Nktf4scw3m0FHuljrvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-CaUrHdroN_SJvGh1fxdgaw-1; Thu, 17 Apr 2025 04:59:41 -0400
X-MC-Unique: CaUrHdroN_SJvGh1fxdgaw-1
X-Mimecast-MFC-AGG-ID: CaUrHdroN_SJvGh1fxdgaw_1744880379
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so2579265e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744880379; x=1745485179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GfMQK4BWJGxmnVTgDrQuVVqoMNetehKp2lZCVxuF/w=;
        b=Z++b2xHwZ9XE6GOX6p7Vu03MPI+5p7q9mqvroQ0Aa/3HgTx8JJIUUVcmShvxFqU5ir
         50WnF8kmMZIMwbL5YfCxkvlwIv2acSf7IOPOSDT6RGCJ6dUWo69x4seWFmsQuT6p02SI
         u4aG0+z3XdANAEBZvuUuykUVWfZ1N6o73a7DV0kPK8fxNzK2ZyeH6ZVTBy31k+9OL65R
         3Nnsplc7SL0wy6EQYacdVMhEwLUym26dsC5YYEl5fhYSi/Mh9qMalJcYsh5msMH1tZXi
         GtcZLWCzpZHIUGbPPaeXqUhIRxV/TccTlDPSCo2f0zYKjlfuJRL8qCJQhDk89fBk2RfX
         Ijeg==
X-Forwarded-Encrypted: i=1; AJvYcCUSPKKrlsJ4xO0tLHVVWCQP57G8z/QHl9GEetob0fFk+UykITa71vSrK0N1BUaoPqw0N30XaQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7gb358BklofzwvanJKi4xRAEFO8Eamw8IV+artWeq+7uQYMU
	9oR3QRZH6w/v6+OKjofnDyVbc/DLNtzr+5DCYCHZkHlj3OxDNlTRZyDsS6qQ5TG9JjJ5jXRwnFw
	pZHdXK58KQ48j+S6Cwo9Ddv8owcfJinNiHXoZZAV3oY7Xq17pld69BA==
X-Gm-Gg: ASbGncsAhQdjFsDbpfJnjtE/jFww6VT4wk9a2/1YudMPd1cbPaOXIQL0bup7CI1FWTY
	oH0ZZruF9zXgnhuibmEJyaiFl+QhcpxfKm6yztDvAu958aII+Tt6CKO5x+ArOP5xWFAo/J5IavA
	+Qz2UYKrB//rt9gRNrQcY12nMcYyiAfam+nXc2UKyPGnqG3NoLqcLv/mQjK2ueq/KcffocWDO1L
	neHZX8Wwk7NCXHj3PpMKEucVaExhWO5E3rfZtfrX2CkZPgVrpDFfjfzZ2H3i6TBIFKRPg/vzauy
	M2J6J2EcWFj9uksBeesZBeym6hVIuyPeZPDA5FLzqQ==
X-Received: by 2002:a05:600c:c89:b0:440:5997:681c with SMTP id 5b1f17b1804b1-4405d5fd8fcmr57027535e9.3.1744880379534;
        Thu, 17 Apr 2025 01:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6wnoEhMMEIcc2dVSD2Mi0/kYEuwxhffSm8Wyq9VeUY0iDYrT0ML62tAYo917pqBiSRXl7IA==
X-Received: by 2002:a05:600c:c89:b0:440:5997:681c with SMTP id 5b1f17b1804b1-4405d5fd8fcmr57027275e9.3.1744880379179;
        Thu, 17 Apr 2025 01:59:39 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c817dsm45422165e9.4.2025.04.17.01.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:59:38 -0700 (PDT)
Message-ID: <ba5b4313-6e42-4340-8301-239dac046424@redhat.com>
Date: Thu, 17 Apr 2025 10:59:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: airoha: Add missing filed to ppe_mbox_data
 struct
To: Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org>
 <20250416154144.GT395307@horms.kernel.org> <Z__S_m9fBEKmoos1@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z__S_m9fBEKmoos1@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 5:55 PM, Lorenzo Bianconi wrote:
>> On Tue, Apr 15, 2025 at 09:27:21AM +0200, Lorenzo Bianconi wrote:
>>> The official Airoha EN7581 firmware requires adding max_packet filed in
>>> ppe_mbox_data struct while the unofficial one used to develop the Airoha
>>> EN7581 flowtable offload does not require this field. This patch fixes
>>> just a theoretical bug since the Airoha EN7581 firmware is not posted to
>>> linux-firware or other repositories (e.g. OpenWrt) yet.
>>>
>>> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  drivers/net/ethernet/airoha/airoha_npu.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
>>> index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f27866896226c3611b4a154d19bc2c 100644
>>> --- a/drivers/net/ethernet/airoha/airoha_npu.c
>>> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
>>> @@ -104,6 +104,7 @@ struct ppe_mbox_data {
>>>  			u8 xpon_hal_api;
>>>  			u8 wan_xsi;
>>>  			u8 ct_joyme4;
>>> +			u8 max_packet;
>>>  			int ppe_type;
>>>  			int wan_mode;
>>>  			int wan_sel;
>>
>> Hi Lorenzo,
>>
>> I'm a little confused by this.
>>
>> As I understand it ppe_mbox_data is sent as the data of a mailbox message
>> send to the device.  But by adding the max_packet field the layout is
>> changed. The size of the structure changes. And perhaps more importantly
>> the offset of fields after max_packet, e.g.  wan_mode, change.
>>
>> Looking at how this is used, f.e. in the following code, I'm unclear on
>> how this change is backwards compatible.
> 
> you are right Simon, this change is not backwards compatible but the fw is
> not publicly available yet and the official fw version will use this new layout
> (the previous one was just a private version I used to develop the driver).
> Can we use this simple approach or do you think we should differentiate the two
> firmware version in some way? (even if the previous one will never be used).

I think it's better if you clarify the commit message. I read the above
as the current (unpatched) code will not work with the official
firmware, so bug addressed here does not look theoretical.

Thanks,

Paolo


