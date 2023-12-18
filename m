Return-Path: <netdev+bounces-58504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8412816AA1
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176DA1C22A3D
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3513AC3;
	Mon, 18 Dec 2023 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="aUQ0bZoT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3F14F68
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bce78f145so2922430e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894318; x=1703499118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wnw+qbk0VP/BP6lvQ4oZ3vUOazKKIyCaxjztZbrET5M=;
        b=aUQ0bZoTrmFWgswGjrNPgd7zk8dsEMX/69NgHb4gIH4CpuLP0v5IQyDmjTR6EE65NH
         ZkrdiimhBLcx/khhm1b+iSEnL88UBrVk/5/yrb7bzYBqpg98DzJXYnQvYgAAHeMITbUD
         buLj/w3r1Y154JhBDU11BW2LR1CBjVXvhtlme2kThV+AGyvab9zlhOGrTUdxQf1WFxf9
         v1xw2tF15STedl3KZ1hMcg7wHQpNoSRv21f/AlYczWX1XCrLwFo2gCOlvvm2flmX7onZ
         /EC4gXHOos2NkxVpGvjpRHiuJoHENXvaydJmhEn6IuFtBjIB/lJHpj5tD6+QXIjTqdCk
         +GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894318; x=1703499118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnw+qbk0VP/BP6lvQ4oZ3vUOazKKIyCaxjztZbrET5M=;
        b=wVSGcdPUgpr0X52iFGTmXZEKeDHUYVjgfPXJToun3oBUom3lSSdjHEGYUX7k/sFWQm
         BObbO8fRLsIgYplhyH26KoX2POE6CxqcPhwX8VSc2HFQSMEdJpQi5H4V8XgOB8SLg/0M
         tEjLFEWJZ3P1SJOawzDPFOKTGY286/7tKjtWSbwxCTsGuDTFz/H4kVpVcU2KOZSpyWor
         JScjWmvSvgwx8g2wFlrAGqO/z98Ow7jySKXBejsseLbPk5I/KXa07xZ8Z9nDSHXNOUki
         sIEIaMBuyTClPCFYB0BG4eeSSMFLwKT591VoVm4dWGm7Bp9WHHJGcqHFQ+ZLcDtwOmaQ
         bPwg==
X-Gm-Message-State: AOJu0Yw625cnvEfdzFvS03x2FVR8Y5+jaKPL66VX4gnVMYkXLtFFZzYW
	M/hDVUsxAzx9+y1/p2vq/rbudq6TwU8fhm+Kr84=
X-Google-Smtp-Source: AGHT+IEOP30S4bcfVGOUNvJcKtWrnryg+mvVN3DzpEsX8J1CAg1+0/WqWVH8QvtR47BNvhMCBRj1Gw==
X-Received: by 2002:ac2:538c:0:b0:50e:da7:d4f9 with SMTP id g12-20020ac2538c000000b0050e0da7d4f9mr2078466lfh.209.1702894317762;
        Mon, 18 Dec 2023 02:11:57 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h7-20020adff187000000b003366d79edbfsm551862wro.67.2023.12.18.02.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:11:57 -0800 (PST)
Message-ID: <761761fe-d69c-4b38-ae3e-34e7d1854a1e@blackwall.org>
Date: Mon, 18 Dec 2023 12:11:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] bridge: mdb: Add MDB bulk deletion support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Implement MDB bulk deletion support in the bridge driver, allowing MDB
> entries to be deleted in bulk according to provided parameters.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_device.c  |   1 +
>   net/bridge/br_mdb.c     | 133 ++++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_private.h |   8 +++
>   3 files changed, 142 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>





