Return-Path: <netdev+bounces-167325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1BA39C3B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920EE1892FFA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3F24634F;
	Tue, 18 Feb 2025 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5RYS5ZA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48E22E3E6
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881908; cv=none; b=hpZXs8hwCXbFecBJNxkhzm7JMp3BLiKXk1E1UiRpLvCtbCXVI7m3rcQ0LUlAXFugDynEgPtn83+JnG2cmnss5YaZt9RfdQj2cJQYDSBJN8Ui/WwejGgoyfuFBAeq0tCTFXQDJMYzpkQ4JGG/KoftLwgwxE0H0ox99C/btVdWXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881908; c=relaxed/simple;
	bh=mo8Lero/PMWKh6/jJes2kVTOcUZSoBd2IMLZN9mT3kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAMy6EK+zqNspXyRQWRyZq6lBvo3liCqAmj/hWNpNeFNVBSGYc/mkMvUhel9LgxkOeFWWa2y6eNESOZrCJ47BiW0LSUcyjr2EGuKxLNk/nP5itCZ3G9kNGDcC5KIpx1HsAsWeXnN2UpES8ZzLvbxEap8lBxy81u6aOy0TpHkgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5RYS5ZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739881905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpbns3ed9kgVrptgMa++JNWIuHOqPUJv9ijZsvk+Wfs=;
	b=J5RYS5ZACYXvIaiyI9EAzoJVDjWZ7noj4MuX7stAl9Yh7Ey81d0lYG2CmDmGp+hhbgsvVP
	vFdaESnBwjvEVDt9vJ/cNq86DJrNme+WdDj+RNNvuzoQOVzurvjjcfiYhJqI2Trt+m0UeG
	dOTve+YsZ8C9mkbAdZJF1UDe7rPvn2k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-YdOFY9iXOkWn3-wMw5Ilbw-1; Tue, 18 Feb 2025 07:31:41 -0500
X-MC-Unique: YdOFY9iXOkWn3-wMw5Ilbw-1
X-Mimecast-MFC-AGG-ID: YdOFY9iXOkWn3-wMw5Ilbw_1739881901
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so32438945e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881901; x=1740486701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vpbns3ed9kgVrptgMa++JNWIuHOqPUJv9ijZsvk+Wfs=;
        b=FYLe8r/gJzCl9bSE/motQSjmMHgAi0Q2mGWseiWamdtm0VdeJPC8NakHdyRASpdFKe
         Wj/kGstoEomINFzgEMFcepGczlnY6IxzIzo0XTQTWCGyi+4xAsvz+Ms0DITaVoxJYFWl
         dLDk2JTK4QE0kPS/EkLzLD93oi26ChFWK6aBzVRTrkwmu87KphI9OgbbKQ/xUakAK7t7
         CZmvGxePOJHjUCSc1xEonVGcuTQ5C+TtfMslBlcP4qWHN93IIR1V4ggKTW9oNBlb0IQn
         HVpuIdwBhoEt06xlXlfq+m1I3ZkWn+HvEpL//1KK5d/AeJlBDBYInb0D6eKnEr06LqA5
         TiDg==
X-Forwarded-Encrypted: i=1; AJvYcCUnOfxUKu1aEYlPSQQJSldM8GXl4k08A3Mzcz91sCde05jmVJ/CWs3X007u/MQKlLR8Q5SIE3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiWFncgfiPnlp3PLBpQTJxqbSnn83Evs/RQg7aO3m6G8bLG/W
	O9KeqbPHfyaLr0CxkTi84FNvkeP9In8EEPyNyLVo4ZESaGeVIJmZwlVt7Ac8EbH64rLBMugQWEh
	1GWYrvoKXkiGsWOqqqeB6pePWNOTqx94srWXBtTrPguAeAJMRATRY5A==
X-Gm-Gg: ASbGncuXlvBeM6V3iddPAvizrEND7FOklbFOIKhXEJLhJgsTiUh669mmj8sHUOpqBQr
	BCdRH6BtgfLnULBInDgi6uWYgYTE7Ua7zjQIjdkPlsdmlMESEcfoiB3fkAp8dCjC0FxOIhAy9tC
	AcCDwBV3vn8GiY+7bixQBIft0jSF2eJ8Pnn1hq/Rik8+51Mg9Cb8ofOJUxssX278TGTJbO0TnhC
	ZiTiQBXA5Ii8Ozq8UZAyikRAdh8205Ll59PIElQu9fEQVHgBPEutqL5ctpJghmEi59FysS0Ne3h
	3WTEHWpoNTHDZnJ4YyEnE4kZ3KprdcbXOpY=
X-Received: by 2002:a05:600c:470e:b0:439:6741:ed98 with SMTP id 5b1f17b1804b1-4396e5bbc88mr148435815e9.0.1739881900663;
        Tue, 18 Feb 2025 04:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDFKLpx8JwArBLTq7YvuKzHM9reL5OjH0AnpIyarnMelJJVplspL1UkuPUExc/hTNjjyvEUA==
X-Received: by 2002:a05:600c:470e:b0:439:6741:ed98 with SMTP id 5b1f17b1804b1-4396e5bbc88mr148435275e9.0.1739881900273;
        Tue, 18 Feb 2025 04:31:40 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984dd042fsm56283195e9.12.2025.02.18.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:31:39 -0800 (PST)
Message-ID: <6fb9612f-b049-427f-a643-e1123a7478c7@redhat.com>
Date: Tue, 18 Feb 2025 13:31:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
To: Nick Child <nnac123@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 nick.child@ibm.com, jacob.e.keller@intel.com,
 David Laight <david.laight.linux@gmail.com>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
 <20250214162436.241359-2-nnac123@linux.ibm.com>
 <20250215163612.GR1615191@kernel.org> <20250215174039.20fbbc42@pumpkin>
 <20250215174635.3640fb28@pumpkin> <20250216093204.GZ1615191@kernel.org>
 <20250216112430.29c725c5@pumpkin>
 <Z7NRLmcWJFNkyHGN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z7NRLmcWJFNkyHGN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 4:09 PM, Nick Child wrote:
> Thank you David and Simon for testing and review!
> 
> On Sun, Feb 16, 2025 at 11:24:30AM +0000, David Laight wrote:
>>
>> I just changed the prototypes (include/linux/printk.h) to make both
>> rowsize and groupsize 'unsigned int'.
>> The same change in lib/hexdump.c + changing the local 'i, linelen, remaining'
>> to unsigned int and it all compiled.
>>
>> FWIW that hexdump code is pretty horrid (especially if groupsize != 1).
>>
> 
> Given this discussion and my own head-scratching, I think I will take a
> closer look at hex_dump_to_buffer.
> 
> I was trying to avoid editing this function due the number of callers it
> has across the kernel. But I think we can get away with keeping the
> API (but change args to uint's) and editing the body of the function
> to always iterate byte-by-byte, addding space chars where necessary. At the
> cost of a few more cycles, this will allow for more dynamic values
> for rowsize and groupsize and shorten the code up a bit. This would also
> address the "Side question" in my cover letter. Will send a v3
> regardless if I can figure that out or not.
> 
> The return value of hex_dump_to_buffer on error still irks me a bit but
> I don't think that can easily be changed.

For the new versions, please:

- respect the 24h grace period:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L15

- add the target tree in the subj prefix (in this case 'net-next')

- ensure all the patches in the series have consistent subj prefix,
otherwise patchwork will be fooled.

I think it would be better to avoid modifying hex_dump_to_buffer(), if
not necessary, and I think you could do so either changing the type used
in patch 2 or even dropping such patch.

/P


