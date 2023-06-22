Return-Path: <netdev+bounces-12871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B192C7393B5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A47281679
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9A19D;
	Thu, 22 Jun 2023 00:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D60196
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:23:20 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80364A1;
	Wed, 21 Jun 2023 17:23:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-657c4bcad0bso1598693b3a.1;
        Wed, 21 Jun 2023 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687393399; x=1689985399;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+SyUgzGB3mWJS7l236nr6y56NCbONZN5vqM0ptmOx4=;
        b=VqI5lK0XjRaD0jse/zS0aVtbiazyqAp8UOkagwsVz+ae/qwW35dmn7uDsu6IAOO+IQ
         uQUq87JQ4hIDFKXtRVx5UxYENkyqYWvJA1OQ+wB6r0sQClQRoWoyLzL1N53vgKH5+swD
         R5iz1PnYLz5JRpyFI6CsYOG8nhAb3bGqns88TngMtUfFd72Bz9szVOyzuBehfh8YaoEB
         Q9UHlo2IVKL713PJnGZKKi+m91Kj0peqrI6VaCqRmd5q7b87KN7Absuy788rss5eqoxZ
         Uet6RvTLLJT0EA2TNoQe9n1FkRrrSyE6uE826r6+DD1SSAYtCqpe0oOGtjEN/JlBDAy4
         E3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687393399; x=1689985399;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+SyUgzGB3mWJS7l236nr6y56NCbONZN5vqM0ptmOx4=;
        b=DOkM0ROcA6vcbxbomjAPVo8MPErHs61Jnu3UYS8BXCTflujXvEgw6qkQWAGeDIlTdf
         qQEHmkbwuORDG+UeReJAft8sWGyeW7w2HvbsvGpqY5Jqj29u8Pn7St7oysFetsupqmGm
         Rr36/sFP6AetUzvrv27Vdjj1kkyur7zHu0twbN8JGcDvowiJqARJhF6vFkLBsPgrBr14
         VLhIdFMg0PIzTDlRZWQQg2b4zkQFm0Gh/nzhnjKZZRq00psYpGsIsq7Rgf8MPOJ1Zj0Z
         RNSW+P417HNPhsclyigyLJv/KKi5XBbNn/N23Ako6iIlv1bPUns1+8VrHgnf2XPMIjae
         9c9w==
X-Gm-Message-State: AC+VfDy/cbMD7/5m5M9fcPlLP53ItAU8zSvEkKWU/AMJ5M/vcFj9ODy0
	Q0Ms7SKj7X3T9Vy25e8YWAE=
X-Google-Smtp-Source: ACHHUZ51CwqHJRVtSYTM210Buw03NyPGwU+sPPyMBBAv7DNs+7wzBf9WR3AM6fKrSoPcIrdp5NRy5g==
X-Received: by 2002:a05:6a21:7899:b0:11f:c8f4:8418 with SMTP id bf25-20020a056a21789900b0011fc8f48418mr16267156pzc.4.1687393398807;
        Wed, 21 Jun 2023 17:23:18 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id j17-20020aa79291000000b0065dd1e7c3c2sm3391036pfa.184.2023.06.21.17.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:23:18 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:23:17 +0900 (JST)
Message-Id: <20230622.092317.16533968095240853.ubuntu@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, aliceryhl@google.com, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 5/5] samples: rust: add dummy network driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZqzvqDuQL9fAxnW0HxgDhqabk6lZsM9OGjV0ejb3dk52fhgAyMH-eIUnRCfPxRgnGYTOVavnKlsrABIWQk_Mwu5K0_lc8W-gA_0xE3No-PI=@proton.me>
References: <20230613045326.3938283-1-fujita.tomonori@gmail.com>
	<20230613045326.3938283-6-fujita.tomonori@gmail.com>
	<ZqzvqDuQL9fAxnW0HxgDhqabk6lZsM9OGjV0ejb3dk52fhgAyMH-eIUnRCfPxRgnGYTOVavnKlsrABIWQk_Mwu5K0_lc8W-gA_0xE3No-PI=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Thu, 15 Jun 2023 13:08:39 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 6/13/23 06:53, FUJITA Tomonori wrote:
>> This is a simpler version of drivers/net/dummy.c.
>> 
>> This demonstrates the usage of abstractions for network device drivers.
>> 
>> Allows allocator_api feature for Box::try_new();
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  samples/rust/Kconfig           | 12 +++++
>>  samples/rust/Makefile          |  1 +
>>  samples/rust/rust_net_dummy.rs | 81 ++++++++++++++++++++++++++++++++++
>>  scripts/Makefile.build         |  2 +-
>>  4 files changed, 95 insertions(+), 1 deletion(-)
>>  create mode 100644 samples/rust/rust_net_dummy.rs
>> 
>> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>> index b0f74a81c8f9..8b52ba620ae3 100644
>> --- a/samples/rust/Kconfig
>> +++ b/samples/rust/Kconfig
>> @@ -30,6 +30,18 @@ config SAMPLE_RUST_PRINT
>> 
>>  	 If unsure, say N.
>> 
>> +config SAMPLE_RUST_NET_DUMMY
>> +	tristate "Dummy network driver"
>> +	depends on NET
>> +	help
>> +	 This is the simpler version of drivers/net/dummy.c. No intention to replace it.
>> +	 This provides educational information for Rust abstractions for network drivers.
>> +
>> +	 To compile this as a module, choose M here:
>> +	 the module will be called rust_minimal.
> 
> The module is not called `rust_minimal` :)

Oops, I'll fix it in the next version.

thanks,

