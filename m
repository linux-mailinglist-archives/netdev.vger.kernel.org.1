Return-Path: <netdev+bounces-93553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CB8BC4EB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB82820EA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB176138;
	Mon,  6 May 2024 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="EORnx8sr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BB3FC2
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956077; cv=none; b=mqHAFZi3/UU28hUfnSbSXCkJ9JJWYee1dTp6ZbZiLw+td5vUSMgHscjFPMiuWgFLykXPp2s3+RA7jPLdF2QWgq3tudxomYnOi/RPRHdSMDnXun2G0pqmSvVt4y7yZwq82voAgNgukPSoBtixLT7kgifhcZh9qqJ+fWNSUcElBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956077; c=relaxed/simple;
	bh=d04jIrZTdoSdrvEiivftvTOuTuW2sjnxZ4N4XVXAAwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQheQOkzjycGdbw8eemEAAfdmyJ3enW8J/dcp2wmaFn+yNcLlG6+PliAf0ud8hI/8l38VY2wtbaIAKmL2bFEpy+yh8glox68RPEbZFT4Y4dfja8BYjySLjMTvGWXOXZATPCxTiidm8yOail7yJj3Upzb9ID/G585gWU9EF/7O6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=EORnx8sr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso518553a12.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714956076; x=1715560876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKSVBIFTEbgkbqbTDR1hQ2M8fcGsmzAc8We2igOJ/jI=;
        b=EORnx8srCFcTorVPAxenDsJL0YWZcmxbVOv/YYMFUpK+dzh79W23CVjVr8MtoeWyi4
         X6wS/HjSv/BZciqbFMjbSWeCV7B2h2oJXXH/uOux2Ewbvy/PCf/PQCYPQtXs29ehEIF8
         TocBX1FoEWfjtEMilIMj5Epx7zLbMkMRmOnI8g92lDv5XuiDh0IYaQWxtPl+dtqIxDzR
         rpmhQMvE7iWVib1Wh0OhOgSJUKfXnpBMnt4YKtMm1fmBD33d7p6lifS3+9y/ZEPIqP3v
         a9mURAdC8L3RfiVCTP+0od5QojczI3aRr3QTwXTZCw9Khp6kub6pXEH5j3GjiTDvnoj3
         kN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956076; x=1715560876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKSVBIFTEbgkbqbTDR1hQ2M8fcGsmzAc8We2igOJ/jI=;
        b=dYS38YGNQw+pdMzLIfDRzoifkvYvLmxwfsvgrV3+jdso5o16V8cH2OHBqJu4xE2AeQ
         tsvYmhdfqc/o/ZcB/X5OZ50HhjTlQHgn1rZXUKM8TLHKmpqdzMfJBvo/ygnOUQEYmwgX
         wydmyyMJC5eYY7OJ3Sl+6MOOOPBVSD8DIIugFokw7TnhMY7OZmgzPeHfStwCdUmn95ef
         q62zBtU1JwrEXdALWjhi0khoGoWhYifc2Dh2kAtfekp4Tl5eS5tL/LRMk27PDJ/AC+Dk
         ZSdoNC663Dy/ZcNUmAUqD96LzFcaf6s4ik1ipwA+XX8/kyyY7VpLdUJmhodMwvoOn4GU
         LIPQ==
X-Gm-Message-State: AOJu0YxfIsFcHgYjlrZjTdDIk6G46953Uo5qp7m4D5QbMI/hUZxdxVs0
	UTQo9tGYwNccuZ4ON+H8bRQ7Yb1YVIccuRIXSnsxOlcaETv1ZKpqz/Z4Ri796q0=
X-Google-Smtp-Source: AGHT+IEyWAYNMRZNKMIu9znUf+O58EEEjFDxOOO3/LU9/Osbklsl2X/EDBQIeXa3b8TYfxKpj6BldA==
X-Received: by 2002:a05:6a20:d70f:b0:1ad:9202:2391 with SMTP id iz15-20020a056a20d70f00b001ad92022391mr9013480pzb.2.1714956075668;
        Sun, 05 May 2024 17:41:15 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id sl15-20020a17090b2e0f00b002b1116c507bsm8798500pjb.19.2024.05.05.17.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:41:15 -0700 (PDT)
Message-ID: <b1d37565-578b-455d-a73f-387d713a2893@davidwei.uk>
Date: Sun, 5 May 2024 17:41:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Mina Almasry <almasrymina@google.com>, Shailend Chand <shailend@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-4-dw@davidwei.uk>
 <20240504122007.GG3167983@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240504122007.GG3167983@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-04 05:20, Simon Horman wrote:
> On Wed, May 01, 2024 at 09:54:04PM -0700, David Wei wrote:
>> From: Mina Almasry <almasrymina@google.com>
>>
>> Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
>> taken from Mina's work in [1] with a slight modification of taking
>> rtnl_lock() during the queue stop and start ops.
>>
>> For bnxt specifically, if the firmware doesn't support
>> BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP and
>> the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
>> attempt to reset the whole device.
>>
>> [1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-almasrymina@google.com/#t
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> nit: Mina's From line is above, but there is no corresponding Signed-off-by
>      line here.

This patch isn't a clean cherry pick, I pulled the core logic of
netdev_rx_queue_restart() from the middle of another patch. In these
cases should I be manually adding Signed-off-by tag?

...

>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> new file mode 100644
>> index 000000000000..9633fb36f6d1
>> --- /dev/null
>> +++ b/net/core/netdev_rx_queue.c
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> nit: my understanding is that, as a .c file, the correct SPDX format is:
> 
> // SPDX-License-Identifier: GPL-2.0

Thanks, I will fix this.

> 
> ...

