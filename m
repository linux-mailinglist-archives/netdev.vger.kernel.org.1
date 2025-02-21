Return-Path: <netdev+bounces-168510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84715A3F341
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EC13AD9E3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12F2036E0;
	Fri, 21 Feb 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGa4xxrR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572141E9B01;
	Fri, 21 Feb 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138358; cv=none; b=hNvGLXdyia/8y1OplsBLJpyNfOLFqA6evpvBwJDVv5cH9AK77jHI78wnblUHQDhGGwIDJW4prxxhCea7EzUgxZHv7uPX4l8Ukq2glmWSl/xL07HjTn4IUGiSIU7zO3iyvBiHN+ZFnIGaWdGkNJ+A6h5TsPshuAO3fTVXI4gDN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138358; c=relaxed/simple;
	bh=ZSod0JSXClAnVodb7sY5zxmKd1Vxxty+5PRsmtu+3G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jT2JSMq1Pxfmx8Q1MTBA5jPZjGMRw/1cMm8nF64Oi5doMeUj8pCgMrhmLRB16oStzzD4JE7Puqxwx0jUdp5jfSVoL2YaIOzCKDMrwsJji8x3VtiuxiBmOJ9HeVBNm0WXiSHaRm2YhRSUGzMaz+8AwHVwwxwidKqPWbw76HAqo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGa4xxrR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22104c4de96so32889325ad.3;
        Fri, 21 Feb 2025 03:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740138356; x=1740743156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqVrVtqhHGV46+pvkCL/SfPhRn3JfHdmD86m4b6YRJw=;
        b=CGa4xxrRc2LI55pNFC3SdNbw0/7SDTlGcw8YQt21UNIqi8xk7n2RXVnwTwvyIH8Jvo
         cl7i8ZqXSMLxAtTzMnI/MOEbCf3ekDYmVeSK9DI1yMzli3n+xiVpbmy2bz/3v6/A02Ud
         6lqKdkG07hxbb2EtRtYocYrdMhpk9IKmOK75qGRbacJPkxXPFcsV8Vt43eCRk7zsICG8
         VEIS0QEIPOf8Bb1KW+jmamA1jUsLLFet80lQX5oDmJIL6mXTDY6ogMJgjRrJ9p59f/L5
         QCIXxAAurJO6NVo2WWETig36mNoBDIS/TvsU/c60+AoIn54Ee78vJFItMAhSeOVPsMtk
         FiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138356; x=1740743156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqVrVtqhHGV46+pvkCL/SfPhRn3JfHdmD86m4b6YRJw=;
        b=UUySknuENW3stsdfNltW+T6M4YQSYL7KWvEAwKP7p38OdIRvvD0oxBTZLG2jdEnnMV
         TU37DZF4+jrOcDutgQYOclutIbq9Key57kTP4sokPYBo9JzoOr3kj3Ib/ScpcI9w537m
         l/1sG9OP+Ujh7Y1OYPk54QtlxGxcDxk5lA1FPCpYj7l+bEKo3+MeFTczxWB0+Qoibhs6
         9lFHwRX5eXmki+MzPqR+WdbUIUdHqwRchskSh/8kFbrU0KWZGLrhccyv6TdYf6BtDpcn
         IPDslp9HKuoy3M9u9s/8Asx89tD7SB2fAd35GSLTvGbe5cLn46Kvi6azT8errZ8rUfN9
         +8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX6WqPgnODAyz2sCYsal6AkcB1cxvRVHXnS+ukcJinDsUhzR4XR6SpR/qYCV8mnq3Tp6jYXk9gQz/NR3ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym11e280ltPtvlWgg8H1SKinHozDUbNsVGcxBj0nr34BH2A6hn
	Oq31GvEs3T1v2glu42KZPzp5/8uesfMkRU1I95Vm1zCTUKBuxU33iOaZZZ3S
X-Gm-Gg: ASbGnctYT5iJRZ/TnPfEOOaiUgyI26IGC0nPYJ9X9qZhhGsf2aubIJS6cnvsChsXAGa
	w/x2QA65J3i8WzsQWkbqF3IFXYeMTZ3+TaQnJfV4m/ZYHDAlDPmK0Ze9dIUuQ5p6WhcSLN2UCkD
	42f0RSYNWqElTNwCEcFpcLGUeDtMg9rVAta6wk0btXCYz3GLcrmX1pIJWEvLaWOQ9LKSk5UKsrk
	7IoPFRS9bsEBOWHwXQlGpA+BHuor0gXmpM4OkVNJNwobgHX17i+aNkjUWukm2BSpNKIeqPbff8+
	aVAeQLrEcyfKA8h4K/xLj2M+BPsfumYlFRPt
X-Google-Smtp-Source: AGHT+IFcAfVUWAqeDB8YofqpO3R7cRi4WO/5R4DpHpuIcnB7ZsVIk/FckbktqkoiUypWAZ6+6Hsy+w==
X-Received: by 2002:a05:6a21:99aa:b0:1ee:d7b1:38b2 with SMTP id adf61e73a8af0-1eef3c56982mr5653689637.3.1740138356324;
        Fri, 21 Feb 2025 03:45:56 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade083277b3sm10693310a12.27.2025.02.21.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 03:45:55 -0800 (PST)
Message-ID: <2f44710b-5f4d-4edb-8b1e-ced6636e2957@gmail.com>
Date: Fri, 21 Feb 2025 20:45:51 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Null-pointer-dereference in ef100_process_design_param()
To: Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <CAHiwTZ=O=sHBD1RCZgAWRRo3Kb-DQvWdu_7FSws=Zxg+TM4Dyw@mail.gmail.com>
 <92115b07-a0ba-1881-cbca-3798510c3f16@gmail.com>
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
In-Reply-To: <92115b07-a0ba-1881-cbca-3798510c3f16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Edward,

Thank you for your reply.

On 25. 2. 21. 00:35, Edward Cree wrote:
> On 19/02/2025 10:04, Kyungwook Boo wrote:
> > It seems that a null pointer dereference issue in ef100_process_design_param()
> > can occur due to an uninitialized pointer efx->net_dev.
> 
> Yes, your diagnosis looks correct to me.
> Moreover, besides the calls you identify, the function also has calls to
>  netif_err() using the same efx->net_dev pointer.

I agree with your finding--I missed that one.

> My preferred solution is to keep ef100_check_design_params() where it is,
>  but move the netif_set_tso_max_{size,segs}() calls into
>  ef100_probe_netdev(), after the netdevice is allocated, and using the
>  values stashed in nic_data; also to replace the netif_err() calls with
>  pci_err().  I will develop a patch accordingly.

I was wondering whether the calling condition will be properly maintained when
relocating netif_set_tso_max_{size,segs}().

I’m not entirely sure, but if maintaining this condition is unnecessary or has
already been considered, then your suggestion seems to be the better approach.

Best regards,
Kyungwook Boo

