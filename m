Return-Path: <netdev+bounces-90858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C28B079E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9B92833AC
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F76159566;
	Wed, 24 Apr 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfveqtrY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E813D530;
	Wed, 24 Apr 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955642; cv=none; b=PG8LrD/M2tzuji7dGDuN8VorsjcilUzhav7qNqbATYRzNuLAUpko1M/zqOBcWAtnllRBW+/lcePkdBHvPPH0o+G5m3Kssq/kldM8GD8g/XuOwJ6ks52XKFHNWD76CfTK72Qchjio1XCX3GiuOJvukrQs2dyH7X3doZMhgXh+8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955642; c=relaxed/simple;
	bh=ndNtKsEJHrisTXsm+DPwzCduTCWbdENCeJabFAAgmzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9Ikcv+mgpshkVr+Y3xwd4VKXOziyZrnOF64TZ7Ave51RiH+PHn6pRSolqB/VlDdD0rOlkqSU9E0QLPC5BBfx31FCIKo1uryniGjhhsilYDhGiUfCb5DNdiK57zycz4V2YJo10BZgvZRQ913P4xmgLiky0IWTDFwxAadYkhx1o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfveqtrY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so51454355ad.0;
        Wed, 24 Apr 2024 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713955641; x=1714560441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bdsQTir/3MhHCM4A7qlVF2Qj2jipD2HiwXE+6sUe60=;
        b=HfveqtrYAc0a5HHWECX+Si9xh3Y4JTCwUy5mnzs4zjH3MjpB53D0BnY0yWouORezTX
         5crbbW0YiJCP6COBJ8t4xtB9k63QIQc93XCZApuFXOXqa3O3Wgb8qSWdHRKMSvYyyAOf
         7gmQVEnAPdCvItLyNclFMG1F50KCstoQ66nV33B5hNW5hR9DQco7FATW6arkZkBunffS
         0lAaYFJbr+b0wmn0LtMwQyc9h0OZSdQrWT1VrZDMs1hF9pS0PqCbNEu1TCuiDc5fbuW9
         2H1DsQ2n4a3BbcbRDKd4dYpWpKPjztZXuvFcBgLh4I4WVg9BA+vNNOw+CffS3M7WWFGm
         x+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955641; x=1714560441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bdsQTir/3MhHCM4A7qlVF2Qj2jipD2HiwXE+6sUe60=;
        b=R4+G2WDZH9ciXOExb6N2hweO+Yw3eFEpqP0SGwJFzrEGe7lE8kt/xIBSJ9w3zc8geg
         LPJdBDe5bkDncqaseZvibtuL548VXWVm0XO29PJlmEJ4Iuq+uMzJFx/duNXTDmdDPZe0
         y44CUzviI9R5ycATUSK/hozsNLMl/NPRcPrrWmjOTZl+7As4RDJrC39cOGt7G5pPXXBq
         mObnui3DBwR2jbE3UjNb809nQbv6LhzNL6P1xkLC/R0paNBUvlNuwWvkTKr8riJLERYa
         FMbHOAX8Zym1n+PDUNg5l283Fe/O3QpIX1XFz5wCyyiunpNEn2U6IO5kTmeZbvs0uQhw
         r05Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUusLQVkmkvJWSSsV6nCVCay+8tuSRuD+8+50u/jvLFykrDKSBzdFlF9MgdZZeBXgyLTFmzdj9Ns8DQB0ddUog2LpxsmZAhsd+Kdro7w30wJ8oENu+ubT1kMahwndG0W96
X-Gm-Message-State: AOJu0Yy/S1GrhuD9tdQkRljbF0ocu1sRKwCc1S+SFElNIUzIjlaNvLM2
	0WxnLB72GKJYY3hztiTb4woQGYY3eV/csVFEKP+/GTRm2Nk886wp
X-Google-Smtp-Source: AGHT+IHLHh1TLtVl6/+bXuUaYJEj8Pm/FGfne9gHG3Xf03d902lyDFu59iUFDx1ucdKsT/dldtFtkg==
X-Received: by 2002:a17:903:44d:b0:1e5:a025:12f9 with SMTP id iw13-20020a170903044d00b001e5a02512f9mr2302997plb.28.1713955640728;
        Wed, 24 Apr 2024 03:47:20 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e45572a253sm11845146plb.14.2024.04.24.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 03:47:20 -0700 (PDT)
Message-ID: <f759d33f-860c-454b-8553-3b840ed6da8d@gmail.com>
Date: Wed, 24 Apr 2024 17:47:15 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] ice: Document tx_scheduling_layers parameter
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Michal Wilczynski <michal.wilczynski@intel.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-7-anthony.l.nguyen@intel.com>
 <ZierbWCemdgRNIuc@archie.me> <263b96d6-692e-4e2b-87dd-cf70a8818cbb@intel.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <263b96d6-692e-4e2b-87dd-cf70a8818cbb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/24/24 16:54, Mateusz Polchlopek wrote:
> 
> 
> On 4/23/2024 2:37 PM, Bagas Sanjaya wrote:
>> On Mon, Apr 22, 2024 at 01:39:11PM -0700, Tony Nguyen wrote:
>>> +       The default 9-layer tree topology was deemed best for most workloads,
>>> +       as it gives an optimal ratio of performance to configurability. However,
>>> +       for some specific cases, this 9-layer topology might not be desired.
>>> +       One example would be sending traffic to queues that are not a multiple
>>> +       of 8. Because the maximum radix is limited to 8 in 9-layer topology,
>>> +       the 9th queue has a different parent than the rest, and it's given
>>> +       more bandwidth credits. This causes a problem when the system is
>>> +       sending traffic to 9 queues:
>>> +
>>> +       | tx_queue_0_packets: 24163396
>>> +       | tx_queue_1_packets: 24164623
>>> +       | tx_queue_2_packets: 24163188
>>> +       | tx_queue_3_packets: 24163701
>>> +       | tx_queue_4_packets: 24163683
>>> +       | tx_queue_5_packets: 24164668
>>> +       | tx_queue_6_packets: 23327200
>>> +       | tx_queue_7_packets: 24163853
>>> +       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
>>> +
>>> <snipped>...
>>> +       To verify that value has been set:
>>> +       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
>>>   
>>
>> For consistency with other code blocks, format above as such:
>>
>> ---- >8 ----
>> diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
>> index 830c04354222f8..0039ca45782400 100644
>> --- a/Documentation/networking/devlink/ice.rst
>> +++ b/Documentation/networking/devlink/ice.rst
>> @@ -41,15 +41,17 @@ Parameters
>>          more bandwidth credits. This causes a problem when the system is
>>          sending traffic to 9 queues:
>>   -       | tx_queue_0_packets: 24163396
>> -       | tx_queue_1_packets: 24164623
>> -       | tx_queue_2_packets: 24163188
>> -       | tx_queue_3_packets: 24163701
>> -       | tx_queue_4_packets: 24163683
>> -       | tx_queue_5_packets: 24164668
>> -       | tx_queue_6_packets: 23327200
>> -       | tx_queue_7_packets: 24163853
>> -       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
>> +       .. code-block:: shell
>> +
>> +         tx_queue_0_packets: 24163396
>> +         tx_queue_1_packets: 24164623
>> +         tx_queue_2_packets: 24163188
>> +         tx_queue_3_packets: 24163701
>> +         tx_queue_4_packets: 24163683
>> +         tx_queue_5_packets: 24164668
>> +         tx_queue_6_packets: 23327200
>> +         tx_queue_7_packets: 24163853
>> +         tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
>>            To address this need, you can switch to a 5-layer topology, which
>>          changes the maximum topology radix to 512. With this enhancement,
>> @@ -67,7 +69,10 @@ Parameters
>>          You must do PCI slot powercycle for the selected topology to take effect.
>>            To verify that value has been set:
>> -       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
>> +
>> +       .. code-block:: shell
>> +
>> +         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
>>     Info versions
>>   =============
>>
>> Thanks.
>>
> 
> Thank You for reporting that. I will verify this issue soon.

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara


