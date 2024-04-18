Return-Path: <netdev+bounces-89139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15D8A9867
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54CF1C20F2D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C2615E5CF;
	Thu, 18 Apr 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W99gcOUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED48215E211
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439077; cv=none; b=SWS8TSpGvuJ5xHQ/NW/6upmS1n2mLUsiC38VbHqo8RNym2lsHoN9+++DXEzevMzpwCVkt//VZiVtOpKSGrFpenEQ5Y/UPUXtpmaJwSkaC+RtITKi2cBa2B+hrQEoAxUAh4ZrBTBcSsnAlsD1e2NLOnThYavapQMkqDZHpNAhibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439077; c=relaxed/simple;
	bh=dadbVw0ZN8KGcZgqWT52RSFUotZfDdsINMbi0GWd0pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6rT0KWG4rGakUZ2Fh8QmCclAhjTzPNCr9pSYT8f0/GbDQw+ZYMJmB/5Xo8vLsHT/p1bH5B2/O6wJCo4SqwzUI3/y5VcV3SZ6RqH1ld8Gqsj2r/7VYp/TJ72vIbJLAodHpn4cg0scc9cO9hMK2FVOCr1DKAtziW9W2WE+BWYyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W99gcOUK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200202c1bso87404566b.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713439073; x=1714043873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dadbVw0ZN8KGcZgqWT52RSFUotZfDdsINMbi0GWd0pk=;
        b=W99gcOUKyl2+fZdSBGJVqDttq0TutTfo/6hILA47OiK9Q5NGpLWd82kINRtwvJ0lvR
         kyatA9B4IM0952YAX0i+2pg8VMETeswm4xNnuUz9EWIlyhq9xMakmTSZ5AwqcQ8cjJ+a
         Jjdy1rSJ+S00Jp4QIy/vkmnAVLvtO4/Y+EsgYF9ZQ6lY/XoE7cnnQXZmm/IqsUdYlKrH
         zGP72ch7jLJfnopA6zORpfzvDwgsEgWmUCk3W4iqYxYHimEHHsqxyh0+bN1S2ixRP5Hc
         G7+S1tuV3fZPUQLfZKwtAnv4NswetcDsj+f/aA1Er605BpFnIxdV3Ee8DsemNttK6gi5
         +pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713439073; x=1714043873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dadbVw0ZN8KGcZgqWT52RSFUotZfDdsINMbi0GWd0pk=;
        b=HBSvJPRYtdOsoZqqr6aOCDuKp5Ocqr5EwmLt6dgi6bVssfelU5otTzaFq+QCX+VwCd
         jbY5Vf2L3B7km+znN7tIny3Q+A7WKxApbAwTzBMPV1gH8eFeYd9oVks4+Fl1rlPPgQ2X
         jKRC9Emm8UnXe0PeAhjJjfmsfkjcaTRLiyMveIAoACOmwSnFgRWreUs9s1UHvjLFhR/j
         CEwqpiqbdgTmsvKtHN34LGpqMNTXr6p0ilC3w0xIWyBeMdHAkJfbjhpYxWD9Iio9sa/6
         VplfI/+iLoKG2XPReZg4hVlzWylN2QmO05Ok6xUy5CU0Kd0wIswVYclCOgIN5sv+VOop
         awiw==
X-Forwarded-Encrypted: i=1; AJvYcCX+xuKQ2D/6FrzvAmQcc620RjOlbPOPRqbpqXt8B6NHhnSmXoBox2U4mfbTwY8+JYK5scw5b0Iiu/xxzKD97ymHjFYVPuLb
X-Gm-Message-State: AOJu0YzcsFFRCMXswgxV44MHTEmQxJB2gHBKxtUw6ul7F0npGtC97VtQ
	yL4n+y7XX//EtV8fPDPdOe3eXv0Ch9+ye1gnkYzJ+AC4BRPXU9p3HaY4Z+FkGbA=
X-Google-Smtp-Source: AGHT+IHmqSTkMUPGya8bnbl4tVCYR5pgohc+bRojwZq6H6mlk6lXfXDEJpU5L7fvxPN2Mb70UrGa9g==
X-Received: by 2002:a17:906:1156:b0:a55:54ec:a2fe with SMTP id i22-20020a170906115600b00a5554eca2femr1963102eja.29.1713439073194;
        Thu, 18 Apr 2024 04:17:53 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906431500b00a521e5856f6sm747685ejm.51.2024.04.18.04.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:17:52 -0700 (PDT)
Message-ID: <08319f88-36a9-445a-9920-ad1fba666b6a@baylibre.com>
Date: Thu, 18 Apr 2024 13:17:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
 <260d258f-87a1-4aac-8883-aab4746b32d8@ti.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <260d258f-87a1-4aac-8883-aab4746b32d8@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/18/24 13:00, Siddharth Vadapalli wrote:
> On 12-04-2024 21:08, Julien Panis wrote:
>> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
>>
>> The following features are implemented: NETDEV_XDP_ACT_BASIC,
>> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
>>
>> Zero-copy and non-linear XDP buffer supports are NOT implemented.
>>
>> Besides, the page pool memory model is used to get better performance.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Hello Julien,
>
> This series crashes Linux on AM62ax SoC which also uses the
> AM65-CPSW-NUSS driver:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/5ed0e436606001c247a7da664f75edee
>
> Regards,
> Siddharth.

Hello Siddharth.

Thanks for the log. I can read:
[    1.966094] Missing net_device from driver

Did you check that nodes exist in the device tree for the net devices ?

Julien


