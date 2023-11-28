Return-Path: <netdev+bounces-51637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E057FB851
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF15B20CAA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F2341A8;
	Tue, 28 Nov 2023 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155F1988
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:44:23 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b2e763b83so6973455e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168261; x=1701773061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=g4n+k76i6lFof4aE1p73jkPDuNsgbFp5A9CzB2fEHLRPJaq4t0Rx9Bs+XQrRMqTaFz
         imoDN5AFnK1sqxcJR6pwT7x/aNH5ueD0cTc0wYitxAG3DGYHrPA5eGjscbJYNmxPaIFU
         k96L5OzTSx637tABWU9Gu8Ux0owrF7Ib1El9WDY5wBHkVLLK48qp0ilKYj/m4LN+gFog
         DiCWz/bHktGpRjwztbNXCS6icNuVCy5udaYd70AbuKWsSuhcd9mN0IqXojR5c0Y03MCp
         ATriFm4YDSDxez7yYAFXXExD+ZKkYEn8o878Jda2E9bY1/gq/p99hz4ih65hfBWmFCj3
         VHBg==
X-Gm-Message-State: AOJu0YzcDSTUgTwwvul8/E75R7pcMmFQyTSYLqlAbVF/YstfulIlxuF1
	z1By35jW9eKLqnsKgegvUXk=
X-Google-Smtp-Source: AGHT+IH9pcr+AjMGGxZpegopotNjp2DUbGPgQAokhxw9PYt9f1SML+YpUF72waU3nnlYi7OixZLtrA==
X-Received: by 2002:a05:600c:5024:b0:40a:771f:6a56 with SMTP id n36-20020a05600c502400b0040a771f6a56mr10200090wmr.4.1701168261208;
        Tue, 28 Nov 2023 02:44:21 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm17643343wmq.12.2023.11.28.02.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:44:20 -0800 (PST)
Message-ID: <9824d265-d767-465c-b744-c2f9408f83d4@grimberg.me>
Date: Tue, 28 Nov 2023 12:44:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 08/20] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-9-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-9-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

