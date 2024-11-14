Return-Path: <netdev+bounces-144821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD379C87C8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6AC284781
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6441F9EDB;
	Thu, 14 Nov 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfmWpS+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471C1F9AB6;
	Thu, 14 Nov 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580630; cv=none; b=Wmhhno+ckzOu9xMViwZZ71UkedJV/QlO40RjmgM4+SIBh9JKcrl3jdxnGIPG3ym8/BR+mn4WRurlJo0N+oJp0L3y+UbNRYyuB3QRYJxuvM3ZF3Vkk/7oBZKJ1FvgFa0DksSJAw1lzpC4x8ejKeX85sSrMQkJOW/lK+8Y6RrZajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580630; c=relaxed/simple;
	bh=B60qcVvCmwNvwGqBjCWcc59azq69ryPDNbypCI7tlqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RS/NnbpccHUKeN/JkkfPR5NvNyQQQRUA40pY5TowTbDfGZmB0rpLQ/gqxL9gAvBHMf31JSCdvo7WYZUtlVbvftQ66k+Hk9TP6zCtKjW+xZbikXTw/qPfcc3gFeYBX1gP/rU93BGSjuXjdDIVFC6sIXffGagnz+jRWft0J/GIGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfmWpS+h; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so310910b3a.0;
        Thu, 14 Nov 2024 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731580628; x=1732185428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxCwECPceHI+32nCGQVBzt4ctlKiqcdlmEpUfV19f5o=;
        b=YfmWpS+hfrhlvMUqSS2epURCmkfvqcOS4qqxY2HAmPN0txGetaXMhqGwSpRTydsrh1
         bIx/hiCK7q+wj7ojpECU+yquCtgwfoeT8A8yr6kI03aqaP1HxJw2Ty+DAiZggYj3l6Vm
         iCU2/SvUaLhtEY+pKeF7Q0Hsta0+/qQ71S+BZpLe/vbzl0mBFSFxL7Vai5HQyKqEMrPz
         cFixNlAUKjgei5noaofZy72JTXE+U26dFFj8iLiVkd9n8/TIuJf3kocJGnT9i8Yt7pcp
         frG8CmKUJrI5XIfjBjJrjdN7uUZLPZkbM3uNzhqyGon7e+M/aTLXIO0jRe5TWytRyln8
         +w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580628; x=1732185428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxCwECPceHI+32nCGQVBzt4ctlKiqcdlmEpUfV19f5o=;
        b=rxm4tnqeU9ZzoLpj1Al6waEaN3I1xerq18DtpmMzcROYBEeJLj2AB+fp83UuL8/W8d
         18go1W0XbztGIXPbT61pmG3AReU5vT0S60Ejx2yNHhF2QHteDFNBqEk+1Dbxnxnng9cW
         ds4SY0ZuZvRAHD2+3EGa8vodCWEGBBGiiLGXpAOW0ti89UqPXpXAXH2bJFuD/SxVFEcC
         hkmwA6rcPtWzW4K4HU2o5SUE59TWeOBMsIfLOJ+mtt3OhoJN6W7jASk6Yi+p6LMVJRjV
         fpO7KO+6zt5SruDkMEncpNMqg/qWqRVx7yIyusIX+F0owQFn10rd9GTQcNpFxroUd3g6
         qDyw==
X-Forwarded-Encrypted: i=1; AJvYcCVKaoLiJgJNkLLmYAzfzlzDzoJlm+gpDx9LA4NH4Hg6wEEEMeIq0ndtwvqQxU+9ajnnjYsUWgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+WxSf0wsJrTkMq0LfEnCRoE2fgk2e2yWHOZo0IhYv4KGucDi
	lspy1dMTTjZwFsPsJ5T7Kiyyo79BXnZN5Z2oyhz70Pat2R3V1hjH
X-Google-Smtp-Source: AGHT+IEr2C3b6bXXe0lVuZL16R+LbDkIQAznai7eiCeA995NLAUvJ3ONAClViloiAhZ9vkzwCDqSDw==
X-Received: by 2002:a17:90a:d643:b0:2e0:8e36:132 with SMTP id 98e67ed59e1d1-2ea062dd83cmr1786620a91.3.1731580628351;
        Thu, 14 Nov 2024 02:37:08 -0800 (PST)
Received: from ?IPV6:2409:8900:21c5:2dc0:8cd5:898c:c3fe:2f6? ([2409:8900:21c5:2dc0:8cd5:898c:c3fe:2f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02481b0dsm1109541a91.3.2024.11.14.02.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:37:07 -0800 (PST)
Message-ID: <1fcd2645-e280-4505-aa75-f5a6510b5940@gmail.com>
Date: Thu, 14 Nov 2024 18:37:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>,
 "David S. Miller" <davem@davemloft.net>, Dragos Tatulea
 <dtatulea@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20241030132352.154488-1-islituo@gmail.com>
 <55a08c90-df62-41cd-8ab9-89dc8199fbfb@web.de>
Content-Language: en-US
From: Tuo Li <islituo@gmail.com>
In-Reply-To: <55a08c90-df62-41cd-8ab9-89dc8199fbfb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/11/8 23:00, Markus Elfring wrote:
> …
>> Consider the following execution scenario:
>>
>>   chcr_ktls_cpl_act_open_rpl()   //641
>>     u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;   //686
>>     if (u_ctx) {  //687
>>     complete(&tx_info->completion);  //704
>>
>> The variable u_ctx is checked by an if statement at Line 687, which means
>> it can be NULL. Then, complete() is called at Line 704, which will wake
>> up wait_for_completion_xxx().
> …
> 
> To which software revision would you like to refer here?
> 
> How does the presented information fit to a statement like the following?
> https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c#L442
> 
> 	if (u_ctx && u_ctx->detach)
> 		goto out;

We have run our tool on Linux 6.11, and the line numbers correspond to the
code in that version.

> Would you eventually like to trace the control flow back any further
> for the data structure member “handle”?
> 

I have traced the control flow further for the data structure member
'handle,' but I have not found where the member is assigned a NULL value. I
am not sure if I might have overlooked something.

