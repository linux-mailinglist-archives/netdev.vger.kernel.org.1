Return-Path: <netdev+bounces-194405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD09AC9458
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364693BDFD5
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6921A2C11;
	Fri, 30 May 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HM9tOlRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780481494A8
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624652; cv=none; b=V/BDCEn+9D13PXzUYUFkwnQIMQTwTOuLOZbLtSQjwhjtdG9yeNvGHj1OzaK60rlvPKTNciY0JX6Nb6PF9OIeAC8qfj7+ACgsINPE903iVJ0GBItlPWM/VFNj56BLwjUty7kxp0jmkMhZESUApWiNa9heY3HgsZJDGF1ytVjZlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624652; c=relaxed/simple;
	bh=rNCnAenY8Ad5bsIaOZF+Zf4Al/gRRnjtnKUNbK4d7OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUZVAL6Mp8RDDqAoNLojtbmJLhAa3wWwgnUOjWvgZN1yj0F6TqozK/iesHg/eO7kfpgfSFWjaSWOF+fSkL5Hug3CIjFUfuZfa10gcf7ZjKRT9yQ+oxQ5Bh7DF1jbwh/PUa73En52MstpWbeZzJB/g0/nCN1QceF8fWBhops1wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HM9tOlRV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a44b0ed780so4207631cf.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748624649; x=1749229449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24qe/xyB6X5FQMMCm8zjaCW0EV4mdf1CAxWLXZQVNAM=;
        b=HM9tOlRVgadNMihsxrhjpr6IJcZBYlMBOo9LBf8JOSjNF6wnG7UfY9EaXCbSD7KUyE
         eYVrmR9kgcJlO0G0Wc+Eg7o8L3j6iWawMVLkz5S34E/qNdJVLe6LlHYBksjptd6A1zWv
         FCxTLHO4QsyOdrg8P7lgU1Nzgkz5qNsBBvOTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748624649; x=1749229449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24qe/xyB6X5FQMMCm8zjaCW0EV4mdf1CAxWLXZQVNAM=;
        b=Jh8ovo3ml4wxxe7tw1+nSf9VkZsnNiaQxi5iCqfp9MfqNu8JpKmLzLNwuOAPWOcImv
         sihdTpZSryKRTqfnpX5XqDwXEY602cPbv4nNEPRTMN/H9Ggid6J92svRF+fV1/TWfit4
         lt3L+2Y/I/UWTDgCKtel7w5ls5inbzFfx1DADmLp6ADvQqh+hDhi/W0iQzF1Xa4lln1I
         Lu7+ARroUfTaAmyZLRC54VIj/kaRNBqyXYlFGZ6WpBkFyAhHcPNl/DbUY6joH0ok4i+0
         dnMPjP2oAIGFf+x3mCLzWtdhogai0HlJamsVRaaMkg9K3Osxtk1IGoZVMa30K+8pzt/H
         bFKg==
X-Gm-Message-State: AOJu0YwanEHv51sSbq3W35Dl6mb0tJLQl9ihXcPQ5cvKR4gnugBGfhgX
	F9qDSxqgBoYMQhQqUM0F7y2k4Be6Atel00JNmFCNrSAJ5K15IxOBxC3GbrHyiActCBtBe2treFW
	Zx8t/
X-Gm-Gg: ASbGncvfIlY5kn8BK9ArXszp6PlHlkI/ymjj6j/zhdbl+ZK48WLDIv6QYNxSSc+X8JJ
	7/HYW4R+oLuiGRdz+zbFLdpcB+JB2iKdsRKK360Erx+hbFNcM/18K1/MWDzelCBpOwDFFZGvcum
	si1bpt+MTHOwn4iCWogpSUHOQQzeAbchxmQyC6CJX7X1e35zW+QkMP7j8aV1VGfnGWS/renCsOA
	6R6x7+ePWyLQXj02w15BZtSA+xDdo1HZw0sxMfb8BrDDRlzKFmXWUxPff09blxdo+jyHSTRTGSL
	rJMxEfdEy5EP/yQEmiq0JAuv9z7+FdQwJLuF8NwvFz8YgFIutS8gjDtwf+lU+Q==
X-Google-Smtp-Source: AGHT+IH8q+FpbqaoQpSMxQv90UHs12PrJul7zhJ4Jiejs0nou04xqJn9tgyjzjILKLWZMXwJWHkp7w==
X-Received: by 2002:a05:6e02:2702:b0:3dc:90fc:282a with SMTP id e9e14a558f8ab-3dd9cbf8ce6mr33605055ab.21.1748624638251;
        Fri, 30 May 2025 10:03:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f00b7dsm530225173.130.2025.05.30.10.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 10:03:57 -0700 (PDT)
Message-ID: <46ba862e-b540-4037-a0ed-8bf5fa12b863@linuxfoundation.org>
Date: Fri, 30 May 2025 11:03:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
 rmoar@google.com, broonie@kernel.org, rf@opensource.cirrus.com,
 mic@digikod.net, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250530135800.13437-1-kuba@kernel.org>
 <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/25 10:59, Shuah Khan wrote:
> On 5/30/25 07:58, Jakub Kicinski wrote:
>> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
>>
>> The commit in question breaks kunit for older compilers:
>> > $ gcc --version
>>   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
>>
>> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
>>   Configuring KUnit Kernel ...
>>   Regenerating .config ...
>>   Populating config with:
>>   $ make ARCH=x86_64 O=.kunit olddefconfig
> 
> 
>>   ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>>   This is probably due to unsatisfied dependencies.
>>   Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
> 
> Does adding config option work for you?
> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN
> 
> 
>>
>> Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
>> Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> I'd like to take this in via netdev since it fixes our CI.
>> We'll send it to Linus next week.
>>
> 
> I am good with reverting it for now.
Meant to add Ack.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

> 
> David, Brendan,
> We will have to enable this at a later time. Also we saw this problem
> before with other configs. Anyway way to fix this for alltests case?
> 

thanks,
-- Shuah

