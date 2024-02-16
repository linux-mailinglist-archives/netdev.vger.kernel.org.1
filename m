Return-Path: <netdev+bounces-72307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC98577A7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE094281614
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94117C76;
	Fri, 16 Feb 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7vxQ5xI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1D18B1B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072007; cv=none; b=IgRSrpb7tjp2H/0eIwc8DLVOF1OkRW8F25pIbUKaywA+KXGdAHhYwyG6Iz9ei9vgj+9rsG6rwZHggXrwcxJ1BRs8N5EvJfe7CgHoIcWygPS9f975oV3VuK3n4kGJYJeVso3xDIPL+MGeC455iAfUhnUpSjrddYuYYYxGHu40yFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072007; c=relaxed/simple;
	bh=d8ITzOV2En/D6OHhB7+vXjklnG93i0n5W26sz5HKW9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W52q6199QMWdfOoIgUGPGQvrdrcU9UmrSGKCwvxXVDPQ0htDT200sWvlvHJu91/jYzr2qqjQyThkW/Q1N/eAK1QwrgaknNYNC3ZtBvWoYLUZ6Ybm1hTG2EtGMunCsuQDRlgbq4ugp6I0LfAr5x090q82LqsTe8SINSLmNtnqQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7vxQ5xI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3deb3f563bso19373666b.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708072004; x=1708676804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WAeqAPxibxxRq/h+JRwkxgNp/YZEgtvVqoDwz03RZEY=;
        b=h7vxQ5xIT90O4qJGSpAq8dBq45eXn6kehv0luZWJS3SKY4yR7HV+Zk1pVIxvnz2c3Z
         wQVfUUGWxjcWOopJBaUIN2Jkq73QpAHnShXugWz1JExalPKHgisUFAk4WWy1dpNxGsLC
         HBdpYlnoQIzXKTC3u6Ad7LzKmPFzmW8e2VgvbykfRLzA0ci873WtGBQF89np/weir2GL
         AV5JrhilFebuC9dONQxTBHUcqCsdvSc5DyrAVXQ5n6GgW65FdzRPWy5yxYiUFC9SZCV6
         ZpaILuJL3U22vZdD5AKPLT3Mqha524Q/K0+lrLaoPlPgVUqXezcbIsjP+IZjVdFxAEZf
         8HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708072004; x=1708676804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAeqAPxibxxRq/h+JRwkxgNp/YZEgtvVqoDwz03RZEY=;
        b=ic6EHNK4UdzY++eicresKSeTboDUHR9myQYfBoSINvKQos5uaUqhKe8uvgVy4kcsXU
         13AoihERSLh2Nzt/XKrcpDGU8NrpAiqmYU6715MysL8LfRXqEDruSZYApJOnJjFcxELm
         9Tpdhx924QV6hJXA4S/2ohdT7pRpLA1QTidoJQD43A3KTPKTEet/m78pPq3eVEO8WRfp
         IIcBShuggcfvbE2Cr1pHhpgyhQmVNNXPDz1dDUYEUquDe24AvEU20EjATMTOvov3LlKy
         oQq5EjoNpRyphSDA9r+ZN8QB6G9dE7fwLM1XFxyybpJl/B4UzwZgBHP+IRx+hIgivnCQ
         JGyA==
X-Gm-Message-State: AOJu0YzCwbmz9iKa1Jv/RVx7pBLWLbihUZypiGn8rt+jJ71UgbFJx0yr
	RJB2ScJcq6ozhbM+bIbOZh/Y/8R5SvtTtBzDHz44hmG0DNCzsEjFVL07NMpxyjg=
X-Google-Smtp-Source: AGHT+IHJTnxShsG5u7QLqZGNtK7dvkKWkY8/CjMheJRB68tWDN4021Cuiiw/3kxOQeAsYnSaEx+vKQ==
X-Received: by 2002:a17:906:e4f:b0:a3d:63b:c43 with SMTP id q15-20020a1709060e4f00b00a3d063b0c43mr2789303eji.17.1708072004333;
        Fri, 16 Feb 2024 00:26:44 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b00a3c5d10bcdbsm1310341ejc.114.2024.02.16.00.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:26:43 -0800 (PST)
Message-ID: <d77faffc-5bde-41f1-b6a2-ddd665c3ee08@linaro.org>
Date: Fri, 16 Feb 2024 09:26:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-2-e0ad972cda99@outlook.com>
 <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
 <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 09:21, Yang Xiwen wrote:
> On 2/16/2024 3:20 PM, Krzysztof Kozlowski wrote:
>> On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> These compatible strings are not found in any mainline dts, remove them.
>> That's not a real reason. What about all other users?
> The people who want their devices being supported should post a working 
> dts first. Having found the dts missing is strongly telling me that this 

Considering how poor HiSilicon contributions were - in numbers and
quality - that's kind of expected. :(


> SoC(Hi3516) is orphan and EOL already. I can't even find it in git 
> commit logs. I'll argue that the old binding is simply wrong, and does 
> not describe the hardware properly. Who knows? Could anyone tell me if 
> the driver is still working for Hi3516 or not? I'm very willing to keep 
> the backward compatibility if someone can tell me the effort i paid to 
> maintain the old binding really makes sense. But the only things i found 
> in mainline kernel about Hi3516 is an CRG(clock) driver and this femac 
> driver. And it's been 8 years since last update for this SoC.

OK, that's fine with me, but please add parts of this explanation to the
commit msg (SoC is EOL, driver looks buggy and might not even work,
platform was upstreamed 8 years ago and no maintenance work happened on
it, thus it looks abandoned etc.).

Best regards,
Krzysztof


