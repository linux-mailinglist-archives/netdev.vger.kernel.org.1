Return-Path: <netdev+bounces-245153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89ACC8DB6
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 17:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE1030CE6B6
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA7267B92;
	Wed, 17 Dec 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPq914Dk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB821CA03
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977342; cv=none; b=VQ507DBHNdmWdfpN8dRQ5hqG7TgiTzKpRS+9S1fqVkQWfEQ7bB41D2QxA1ZPqArxj2DUP2DncY0tnYnIOx3r4RrQWAZvTUBIGOVRF8XYRIm2CU11mazuuDS8KAbKU/LDPxeu2BIqGo7M44jXeV6BI/Y6v0BYFcS7ZIBWEeNmyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977342; c=relaxed/simple;
	bh=f96S71trim0g+HPpzGDMkG7axZcuaPQwx800ipbJaSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFj6JE1xnckwdOJgiS6uuMbZhGvkgZXGcP3YZfXFLkfLRhz5F55lG/vG/jXtrHCrIH2vlcbK59odB+MhfWHtK+y8y2x8CoX68X/EV7zNere3DTIhk3z4lD6zUu/HcZAL10dvZeJun/4NEAOLm2h1JU8J/Km8G2NbbhY2WM8OC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPq914Dk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b73161849e1so1350559866b.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765977339; x=1766582139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F+XhGDyzhWPwRMa7bHo6bLqb91juDMIm0R67eyz4L0=;
        b=jPq914DkYP6Sycf42AySdvrVjrqxGBhy+WT6FQ6x+tLPRE3+C5tWjfw9ixFG0ExCoo
         blnI0xMc/mbfL86GwJ/xQg6auTy31FzGJO6QR6AbBm4dycH3c8zUv9W8ZV4q6Lmuftfr
         TxPdUwe/uDSd8c0DflMAY5ceKtCfJPoGcNnKE84Z4+X1T/BAF4g0bOg5xxJT120129cu
         EcyAqaW60EUt8ph6jpvySuqRriCrwwm+tCP7iCa9k/6g1FCppHesxzdvvgOq2DoMsmkm
         kN6KVdtrao1H74IQMKEVrWSEO1V47FEJecPhh0HDQf5Tz/MoQ3I2dQmhSW/E1wX3igvI
         sGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765977339; x=1766582139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F+XhGDyzhWPwRMa7bHo6bLqb91juDMIm0R67eyz4L0=;
        b=GfFxvOCLVpKJ1efp/Y7U3/1dXOHa329Cq86D8NabXxW4CN6mGpozAXdimpx+Yw9bRp
         pcxGEmHWFUYT2g8nRdMYV4hshczjPt78Yz3xwauv1PL324s6li2rXASXS7OvAJM92yqt
         kvd8LFwSspOjYjc4DUtWjUYspsw+JfYsBjvlDKMw+vtvO1H04DCOFbVL+jOMCZZdrJ5y
         X3bfjniN8RfLO0Lt6VFxAj0/euNKJTsROeChRwxKJMqSDAXWZqd7zznYWzaQVFfPmJLI
         lNJOIH6yp4VV10nyqV/44mI1kn/QJ7zYE5041l3LCUA39ZCxOz3KGJFYgukx0BSZxjGd
         jHEw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbHVMg3SWibluBPo0ZygFS/PWuui72DCAzLwfaQRo4h1hc1ld7H0kfwaMRdOWJGK0WyjHMsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2tn+19YV4zsx4+2tSEgzcUI1Ike9RXRnR2R5+Ob1FOzrMcGH
	dPziY2x3Oz6UNOopwdVm3KeAaCQ3RCb1hfe0BBgz9CBg0vArHdCNFTL7
X-Gm-Gg: AY/fxX7aLo822BiYZYnAMAtUfbczEOEQf33Wd1VllYRuoq/kCOdavsvUq8C0VbL9D2P
	UKe3hg9w6ZSGNsdietyzcLrl/KLn4uB3gNfBtJ1JFfKRgDR1AhEIlVoaDa5bi5KhPfQnhfsvg5F
	paspT8ykpbPLqsbbedY/fac3WhKROT5apiL4m6qtfsqDXFEK4WiGymyrCbAJ7J1PcZdAgWhHpF1
	shK8UnKa8HJq8CvjREWKWxyZ7XCVW43ymLpSt2YlslLAKLWWl2AT9CtUWfXD5mblVbdcPnvGHDT
	Ep8oaXSM5xDGdRGZQjqsezwh2HDMOYYleYszirgler/gMhBE+BoIDuoTVAMEW1vlh3vTvq3SLXa
	lbZVEtkHgvJD8fNApjQOsP6kS7CoG3GgM+nwVW9aiIt89mHcO2HA8F+I32E0G5A40Oo6zBFDtK+
	BswlMD0Q/qFQG20EkSdjrJlDhZUY9dj82kS3ES6GCapG3YKRiCiE5N+r06ouMRFdRDstPMPwmVs
	V7QHkgZI7a6pXGikIh/39lM/mFp/WmFt4zY0cFj32WLtkHCIgti96TxmYHtXLplA6+E+A95ox8=
X-Google-Smtp-Source: AGHT+IFJFc+tAj9+1ZWQ33lxgGX+8wQEs7FAeIC0HBzWXEDQ1X33lh9OIi5obJ3o1fl/Fh8XvLSyBw==
X-Received: by 2002:a17:907:3d92:b0:b7a:2ba7:197f with SMTP id a640c23a62f3a-b7d23a63a2emr1945186566b.52.1765977338934;
        Wed, 17 Dec 2025 05:15:38 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29f51esm1970726066b.14.2025.12.17.05.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 05:15:38 -0800 (PST)
Message-ID: <39e285e0-81b7-47b2-b36f-50de7e51f95b@gmail.com>
Date: Wed, 17 Dec 2025 13:15:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: access @pp through
 netmem_desc instead of page
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Byungchul Park <byungchul@sk.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
 "harry.yoo@oracle.com" <harry.yoo@oracle.com>,
 "david@redhat.com" <david@redhat.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "toke@redhat.com" <toke@redhat.com>,
 "almasrymina@google.com" <almasrymina@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20251216040723.10545-1-byungchul@sk.com>
 <IA3PR11MB898618246F68FA71AF695B3DE5ABA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <IA3PR11MB898618246F68FA71AF695B3DE5ABA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 11:46, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Byungchul Park
>> Sent: Tuesday, December 16, 2025 5:07 AM
>> To: netdev@vger.kernel.org; kuba@kernel.org
>> Cc: linux-kernel@vger.kernel.org; kernel_team@skhynix.com;
>> harry.yoo@oracle.com; david@redhat.com; willy@infradead.org;
>> toke@redhat.com; asml.silence@gmail.com; almasrymina@google.com;
>> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; intel-
>> wired-lan@lists.osuosl.org
>> Subject: [Intel-wired-lan] [PATCH net-next] ice: access @pp through
>> netmem_desc instead of page
>>
>> To eliminate the use of struct page in page pool, the page pool users
>> should use netmem descriptor and APIs instead.
>>
>> Make ice driver access @pp through netmem_desc instead of page.
>>
> Please add test info: HW/ASIC + PF/VF/SR-IOV, kernel version/branch, exact repro steps, before/after results (expected vs. observed).
> 
>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> index 969d4f8f9c02..ae8a4e35cb10 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct
>> ice_rx_ring *rx_ring)
>>   		rx_buf = &rx_ring->rx_fqes[i];
>>   		page = __netmem_to_page(rx_buf->netmem);
>>   		received_buf = page_address(page) + rx_buf->offset +
>> -			       page->pp->p.offset;
>> +			       pp_page_to_nmdesc(page)->pp->p.offset;
> If rx_buf->netmem is not backed by a page pool (e.g., fallback allocation), pp will be NULL and this dereferences NULL.
> I think the loopback test runs in a controlled environment, but the code must verify pp is valid before dereferencing.
> Isn't it?

Considering "page->pp->p.offset" poking into the pool, if that can
happen it's a pre-existing problem, which should be fixed first.

-- 
Pavel Begunkov


