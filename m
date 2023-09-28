Return-Path: <netdev+bounces-36796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F157B1C95
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 50A0DB207DD
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FCE8BF7;
	Thu, 28 Sep 2023 12:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A51118
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 12:36:00 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6274198
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 05:35:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317c3ac7339so12317696f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695904556; x=1696509356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPk2ZzrID8Ruy/e6ubyOdQXDCXqUez+jUlvGZE9CHoc=;
        b=DI6SzCmC+ik1/3gGJtZaaEQEZeBEH2IzH7xEn3xfdfCkGFJnUqILygvEr79HM2pY6W
         n0ATXu30vKju6aYcfvas+ex9CBs/pyIN90PELqPIYlKxbx12rqdqFSJ2nJFM7aiHCNYX
         ld/UMYHGLcsR2veCA1tEFrzC1YBJyn/nxygpi/vmC3sAdVtyyzNwydlxlZdrd4JNdYXB
         uRapu+NpaTRv7Zu2FRiMV1Xwess9RIjl9oIGvWlsyWA32PJVa2ScA+KDlqjOd0wk8+Lc
         sswWC1nEhS0ZmnKdMj83SoMJRbMjdTnxC9rDg0BUB0forlhaNErN7d2+kuOvIteyFuVq
         qrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904556; x=1696509356;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPk2ZzrID8Ruy/e6ubyOdQXDCXqUez+jUlvGZE9CHoc=;
        b=HdPm4wZl1Mg9/ofvvKyHogDa7PJxkAjfRv9X/l6a7TKAr0sA12T5mf48ei7xBZKAgZ
         HeloeLa12zPffAzU7OE6UEc6sLte91GGoHDDxSSPJZ6oEm0KN9t3yVBEOPd7r8KhXt1V
         Wq9sbu4Y06QbXTMZ+/7gfi7a404AbjL/R9DKBuVtkZ/KLoRZMyr8IZcgl+S749ldCply
         VER7kP3U9aQHb105xHTm3IcZP6iCYGRljTLium8XaqU91EV6wdxiIaNYEKq78fHT0AXp
         N85r5K6UgsdhhvotPlwS7k2exw1zkFengq6OGeuYtVMr436LzTyENTtkccp9CUIWc7tK
         baaw==
X-Gm-Message-State: AOJu0YwzDmn3pZPfx1fkEcci5Z1yRbl5hCfwRdwsnWqp54SwxKZ8SD+C
	jSM4g4QTVYLXgvYOe0imwl1yLw==
X-Google-Smtp-Source: AGHT+IG+ptZJRlwen4reypsH0+PwYcAGCXwddHDZkmlJP4KAaSG4l2LCo5phyY7HK5it2f8kKzCUsw==
X-Received: by 2002:a05:6000:985:b0:320:9e7:d525 with SMTP id by5-20020a056000098500b0032009e7d525mr1391079wrb.46.1695904555860;
        Thu, 28 Sep 2023 05:35:55 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b003fc16ee2864sm18319287wmb.48.2023.09.28.05.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:35:55 -0700 (PDT)
Message-ID: <2c985516-88a3-9fee-dbd1-134aecd323e5@blackwall.org>
Date: Thu, 28 Sep 2023 15:35:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] bridge: MTU auto tuning ignores IFLA_MTU on NEWLINK
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Trent Lloyd <trent.lloyd@canonical.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
 <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
In-Reply-To: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 11:10, Nikolay Aleksandrov wrote:
> On 9/27/23 10:57, Trent Lloyd wrote:
>> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
>> was set manually") disabled auto-tuning of the bridge MTU when the MTU
>> was explicitly set by the user, however that would only happen when the
>> MTU was set after creation. This commit ensures auto-tuning is also
>> disabled when the MTU is set during bridge creation.
>>
>> Currently when the br_netdev_ops br_change_mtu function is called, the
>> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
>> when the MTU is changed after interface creation and is not called if
>> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
>>
>> br_change_mtu also does not get called if the MTU is set to the same
>> value it currently has, which makes it difficult to work around this
>> issue (especially for the default MTU of 1500) as you have to first
>> change the MTU to some other value and then back to the desired value.
>>
> 
> Yep, I think I also described this in the commit message of my patch.
> 
>> Add new selftests to ensure the bridge MTU is handled correctly:
>>   - Bridge created with user-specified MTU (1500)
>>   - Bridge created with user-specified MTU (2000)
>>   - Bridge created without user-specified MTU
>>   - Bridge created with user-specified MTU set after creation (2000)
>>
>> Regression risk: Any workload which erroneously specified an MTU during
>> creation but accidentally relied upon auto-tuning to a different value
>> may be broken by this change.
>>
> 
> Hmm, you're right. There's a risk of regression. Also it acts 
> differently when set to 1500 as you've mentioned. I think they should 
> act the same, also bridge's fake rtable RTAX_MTU is not set.
> 
>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
>> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if 
>> it was set manually")
>> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
>> ---
> 

So I've been thinking about this and to elaborate - my concerns are two
first is inconsistency between setting MTU at create vs later when it's 
the default (i.e. this way disables auto-tuning, while later it doesn't)
and second is potential breakage as some network managers always set the 
mtu when creating devices. That would suddenly start disabling 
auto-tuning and that will surprise some people which expect it to work.

I think if you make them both act the same and leave out that case with 
a big comment why, this would be good for -net. To fully solve the 
problem without breaking anyone I think we should add control over the 
autotuning flag so it can be turned on/off by the users. That would be 
explicit and will work for all cases, but that is net-next material.

Thanks,
  Nik


