Return-Path: <netdev+bounces-94270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0D8BEE9A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8DD2827B0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18F71B4C;
	Tue,  7 May 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="H2inJMP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4E6EB65
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115983; cv=none; b=BDQRoC6ICzRCfv3sckuxhl235Gxy8ncTX8n69FhYDOVuCaBn2V76Hbba+tzbyZK1YVKSJxZM3HUaFu2wxLJgsKnXM9Z0Oxu+hAO0YMA/gcYLy64SvQwffR49xY1RLE7Zv+mKUv0y0Nh9YsyPAzl2FGOf0QyXsUEJW/dN19avMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115983; c=relaxed/simple;
	bh=3E+RaHvgh0wtOZYA1eofaUB27pgrScpVRRswuvwIfbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGX7ViwAemuTjzCQoCCyZ9FFcxW2eYWu0Eej/LDA2/zONongZnCOz8Sr/znVXM9g8VFOeKo19ROkBorsDtSGqdb3ZuJFcPBa1n+nR7q8lllee9kqJRa2gAbVl31b8liy33KKL83ieySD1Nef+E+LrWVVZUjvH+SpAdYtxJpZ3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=H2inJMP/; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d9e70f388fso187620139f.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715115981; x=1715720781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnTihezNjC3DTG4MO9rAUXMKgY7lkfWjEnFRPQevl0A=;
        b=H2inJMP/3/NWPtQWwBNlsOHxVk0HtQLr4CrLPwQtbzOjgPJC2YTyslP3q8w/g3X0rT
         07o7JS3fNSlCPuR2ujjVtBFnvvSdSpB2F+SAPtxlKVUdsBwtmtifuc6kN2rprGaBA2vX
         /24sCUimMBIj2bdTJUejN1UfKgQiXDhwewVhD+7jVt9UpJsgMin0LNO8WAJqN7tR4vxv
         fQA/E9csPHAEDuJwpTXVlP3EuQMZQ54ZGKHbc10PMUquLHmmrUk93tNlTONfUtv0CyDW
         vGBAwjlY8VOd4aZukBxhnbB42cInRzCEIFAC7C8OcD1/sHJsWInPdV5+vhoGyxP3bCBk
         wJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115981; x=1715720781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnTihezNjC3DTG4MO9rAUXMKgY7lkfWjEnFRPQevl0A=;
        b=u2uaLOR8c06x6v+BSabO6+SGTnFPJxmUBVELf0aZPl/P3eP57QI5J9Z+YzIlOxjfNE
         2UNwlRUivH12oA3xTbmP5CKLHnCoaoMAUDtkp6mu/J/PjDCU/epv7jl/K5lx+DPIKKUS
         tzKiPvOYyj04IvBTmbEX23MTZHHd2slTspvGOPbygvRM999mINC9h4NQqDsuhnNCZELb
         XagC1U/O9qQlePE643edsHaOftdrdojDNupO4InbINI3b/GHh+SD32mIdf+a4L5gPXw7
         TKhfZ9Vrq1Cg6HGvQgN4WywjWDO8lKsUdroo7aka7GPcG+sOv3jz3DbaYeaT678GMcqD
         CuRw==
X-Forwarded-Encrypted: i=1; AJvYcCVuBNw1IIrdBF4+xM1ZOitJ+n5r7gZdhdq4VTG4ibttOqUqeDUqeg4vqhVq/1+wB/6XsQWSr33OpMJm84Pc0GVUk0QSUqjR
X-Gm-Message-State: AOJu0Yw7apd0/PhEXAFmkCokEqFrWjiDAHUb0+ycrr2PLbYFBGsJjqR7
	o4gDcxIwxZoIclbqnUd9Z91sIfIXY5FvReRN8oNvloXU2Dogn5KP8YlyVm7E/WU=
X-Google-Smtp-Source: AGHT+IFtLPHM5WZkIoKyPGevpHa9Wd+AXtNQYBb+XclIho8AlJd/6+keI++W7oaFm3rnRTTTFstmCQ==
X-Received: by 2002:a05:6e02:1a48:b0:36c:7bdb:c86d with SMTP id e9e14a558f8ab-36caed080a8mr7634975ab.11.1715115980632;
        Tue, 07 May 2024 14:06:20 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::7:f61c])
        by smtp.gmail.com with ESMTPSA id b18-20020a6567d2000000b005f05c88c149sm8875558pgs.71.2024.05.07.14.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 14:06:20 -0700 (PDT)
Message-ID: <320a7d5f-f932-467b-a874-dbd2d8319b9f@davidwei.uk>
Date: Tue, 7 May 2024 14:06:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/10] gve: Implement queue api
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, hramamurthy@google.com,
 jeroendb@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, rushilg@google.com, willemb@google.com,
 ziweixiao@google.com
References: <20240501232549.1327174-1-shailend@google.com>
 <20240501232549.1327174-11-shailend@google.com>
 <43d7196e-e2f5-4568-b88b-c66e51218b2b@davidwei.uk>
 <CAHS8izOYj-_KKgpPm7Tn3SkcqAjkU1b4h9nkRpPj+wMyQ23JqA@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izOYj-_KKgpPm7Tn3SkcqAjkU1b4h9nkRpPj+wMyQ23JqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-05-06 11:47, Mina Almasry wrote:
> On Mon, May 6, 2024 at 11:09 AM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-05-01 16:25, Shailend Chand wrote:
>>> The new netdev queue api is implemented for gve.
>>>
>>> Tested-by: Mina Almasry <almasrymina@google.com>
>>> Reviewed-by:  Mina Almasry <almasrymina@google.com>
>>> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
>>> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
>>> Signed-off-by: Shailend Chand <shailend@google.com>
>>> ---
>>>  drivers/net/ethernet/google/gve/gve.h        |   6 +
>>>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
>>>  drivers/net/ethernet/google/gve/gve_main.c   | 177 +++++++++++++++++--
>>>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
>>>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
>>>  5 files changed, 189 insertions(+), 24 deletions(-)
>>>
>>
>> [...]
>>
>>> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
>>> +     .ndo_queue_mem_size     =       sizeof(struct gve_rx_ring),
>>> +     .ndo_queue_mem_alloc    =       gve_rx_queue_mem_alloc,
>>> +     .ndo_queue_mem_free     =       gve_rx_queue_mem_free,
>>> +     .ndo_queue_start        =       gve_rx_queue_start,
>>> +     .ndo_queue_stop         =       gve_rx_queue_stop,
>>> +};
>>
>> Shailend, Mina, do you have code that calls the ndos somewhere?
> 
> I plan to rebase the devmem TCP series on top of these ndos and submit
> that, likely sometime this week. The ndos should be used from an
> updated version of [RFC,net-next,v8,04/14] netdev: support binding
> dma-buf to netdevice

Now that queue API ndos have merged, could you please send this as a
separate series and put it somewhere where it can be re-used e.g.
netdev_rx_queue.c?

Happy to do that as well if you don't want to/mind.

> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=840819&state=*
> 
> 

