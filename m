Return-Path: <netdev+bounces-111769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8AF932807
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF3D1C2244D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E68119B3CC;
	Tue, 16 Jul 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/Ym4Ylk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0419AD67
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139105; cv=none; b=k+WRLbEkr8rAIepVRpsXhmDeL6hsTUFJCp7HEEnPP9Lm/qjPYrAfKa4McRI9CInsFoYSRv4sfJw8wuOSWVAd76g1tFbh04fxuNbkR7tpvkFiwR7HFF4LNIe5dIBN3SPyHMqPSB1vdm1qA7OLBEz3ekENTRhtlt4GYhO4zOi/mFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139105; c=relaxed/simple;
	bh=5P82QCEA1QgMOfNRLxrVjNuUg5+vM9KHPqwkxkeFHv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwTKxbNUUFAJO6100XMkEFa4ozcJhr2QvPmKJ/LtYmJ/SD+hwyPanS9fSETrIY/hyzZqZi7uKlWLa5ZmMp3C1+LpYnLiGFTR7NdryB53kK3GESBaHucEKBtdNEmUF2QsHHBKkXbvb+0lb9heEoL8hkwwq8N387YmHVrY914hQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/Ym4Ylk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721139102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4E55ukJvZi2AfCTEU0jeudlb3F/r/yjzt5Nm4mz7yo=;
	b=g/Ym4YlkCp0ND986LVHf50Ub9l1YPRQ7d20HfQouClWrgVIV/4YX2LtbhWFa+vh8lpY9SG
	yB9sscSZFYYheApiCfej4CJfI58tSIApE9vgTx8IXmgbNpv8LQnqoaDe9GpkeOtWnpRU/v
	/tH/XcL2y4vLcIWJSAQrIaNbD7/VDsA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-tyfFzXGVPIWcCA3o6hEhGA-1; Tue, 16 Jul 2024 10:11:40 -0400
X-MC-Unique: tyfFzXGVPIWcCA3o6hEhGA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42669213f26so10380935e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 07:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721139099; x=1721743899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4E55ukJvZi2AfCTEU0jeudlb3F/r/yjzt5Nm4mz7yo=;
        b=GRzUXH9Nr4hKo8Y/nHjINrvJqDlywwjGKYE6dF83x8utUwrJXQjuXUY04UoEKpxtiB
         sUwN6K7TdIgdYf104FxVTwTCks/Rhg1HWLt83DFW+P5vaIaP9MFXFmlnZnUeJ8EUsXyr
         zQ6M8eeeqVdtNVnzcp9VAbJvskA0IZQV9MTmrltdJc32YNyXsR5wXW5BC/EGcbHgJOZY
         ADjtNLxsZNSYvoeuz2D57hNvsSGMhXDdi+YCiDNdN0hCE+Z5KkxKHes0U/E3CweZeE85
         6/xq4y24R3ec5I/Pbfk/EM4BX/n3IZrsHGPMaXL2JdxKZMVkfje4CRa3xILO4qG0UtLt
         yrgw==
X-Forwarded-Encrypted: i=1; AJvYcCVrlDDZjHbQeaZPJ4wn0OSb43HpBqFAPFVxSVc1TiQ0nJeyc2wHlFJGjZJ/ScW30lR7rz8qQzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypyx7ho7shy3UFrQ9zw7LIPJxvkx87jkKcsKir7qCzVdkjJxcU
	fmVjYFJCJBzgiVcDXcKjD600/xy2iGHfkj9XpMELQHsIBJcXz6dX5A7bgOaF91UMfCQZSvfPBmY
	dlzQeHNoqTMI03Q/VVZ4EsjUJdvmTrMmZAXfrOk4mJMJKnT30wQYrPg==
X-Received: by 2002:a05:6000:178c:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-36823e5933bmr1404479f8f.0.1721139099048;
        Tue, 16 Jul 2024 07:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzXeJwZ/ZNaq+GxYF4/gYYba0c9mNQjn1rw0lUskXRQRo9+weQB7LDATIGB5EApqxIOvUDHg==
X-Received: by 2002:a05:6000:178c:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-36823e5933bmr1404463f8f.0.1721139098706;
        Tue, 16 Jul 2024 07:11:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf128sm9144812f8f.40.2024.07.16.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 07:11:38 -0700 (PDT)
Message-ID: <23e63003-5c85-442a-9489-68125664b479@redhat.com>
Date: Tue, 16 Jul 2024 16:11:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath12k: fix build vs old compiler
To: Jeff Johnson <quic_jjohnson@quicinc.com>, netdev@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
 <a7950e7b-2275-4b6d-b8e1-4f50d0bc28e6@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a7950e7b-2275-4b6d-b8e1-4f50d0bc28e6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/16/24 16:00, Jeff Johnson wrote:
> On 7/16/2024 4:06 AM, Paolo Abeni wrote:
>> gcc 11.4.1-3 warns about memcpy() with overlapping pointers:
>>
>> drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
>>    114 | #define __underlying_memcpy     __builtin_memcpy
>>        |                                 ^
>> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>>    637 |         __underlying_##op(p, q, __fortify_size);                        \
>>        |         ^~~~~~~~~~~~~
>> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>>    682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>>        |                          ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
>>    190 |                         memcpy(pat, eth_pat, eth_pat_len);
>>        |                         ^~~~~~
>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
>>    114 | #define __underlying_memcpy     __builtin_memcpy
>>        |                                 ^
>> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>>    637 |         __underlying_##op(p, q, __fortify_size);                        \
>>        |         ^~~~~~~~~~~~~
>> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>>    682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>>        |                          ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
>>    232 |                         memcpy(pat, eth_pat, eth_pat_len);
>>        |                         ^~~~~~
>>
>> The sum of size_t operands can overflow SIZE_MAX, triggering the
>> warning.
>> Address the issue using the suitable helper.
>>
>> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Only built tested. Sending directly to net to reduce the RTT, but no
>> objections to go through the WiFi tree first
>> ---
>>   drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
>> index c5cba825a84a..bead19db2c9a 100644
>> --- a/drivers/net/wireless/ath/ath12k/wow.c
>> +++ b/drivers/net/wireless/ath/ath12k/wow.c
>> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>>   	if (eth_pkt_ofs < ETH_ALEN) {
>>   		pkt_ofs = eth_pkt_ofs + a1_ofs;
>>   
>> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
>> +		if (size_add(eth_pkt_ofs, eth_pat_len) < ETH_ALEN) {
>>   			memcpy(pat, eth_pat, eth_pat_len);
>>   			memcpy(bytemask, eth_bytemask, eth_pat_len);
>>   
>> @@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>>   	} else if (eth_pkt_ofs < prot_ofs) {
>>   		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
>>   
>> -		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
>> +		if (size_add(eth_pkt_ofs, eth_pat_len) < prot_ofs) {
>>   			memcpy(pat, eth_pat, eth_pat_len);
>>   			memcpy(bytemask, eth_bytemask, eth_pat_len);
>>   
> 
> Duplicate of https://msgid.link/20240704144341.207317-1-kvalo@kernel.org ??

Indeed. Anything addressing the issue WFM.

Thanks,

Paolo


