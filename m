Return-Path: <netdev+bounces-127128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E79743A1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B841C24E8C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2C1A76C1;
	Tue, 10 Sep 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oDDJlilN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2F1A7061
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997410; cv=none; b=XuFsXDNksSEslvJX1EWEF8nP1cCMq0RZLqrA3on0faDAHQDFjUaXOec1rowMjjXtDDt8lsYUDhZgfWKVIakOEiGvb6NMW5NcCObizXGoJCA6FFMd7zAcQk6QSBi+h4ugejG3/uyo9umBOIwtoxnnm6SMSofs5TyUDFAnMxYWj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997410; c=relaxed/simple;
	bh=fUauvFk9xm6PdY0fYMcea9vaRdvrdV/33sTG48bpAVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI59ngJT5DigaCbYFmIo+2IqndMd8ZED9PsAk74c6nDLb/SUzF7nSTVvmojJSLVoXbjDqdYSvoDuRlAIg4T1Mwa9ZCNlONHRSIX7mp835Z9KYkExvYC/lAqbSpMF7I6q/SP2VN4KdzsM+cXQeL9Rgjwnw1xjrF9i9kzoQUeO5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oDDJlilN; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa6be8457so6953839f.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725997407; x=1726602207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIUkVijX/obmO81YZ0hDppAp+m8ygO6cINoJy3iHW4A=;
        b=oDDJlilNWhQos8DgLZzfwFFfZliEMS9G0zVBFIVf5JBENN0hSdM9+lBRtesczg2x8B
         2ga3OOK8Arf4/R2VOXodZ9XsT4U3XeFmjgsdsVOwLyDJonvu8pHKfKd5Ow/7rA4F1mcp
         dqDWvWOHu4js2EahTbwUYLebEBtVj9gt2xBic4xAklbRgoTEssjdQVkyz8H2huG48N3V
         zEBE2cX2J1fotidfKE7GJcnjEizTtpC/o+6Gxd9a5ao2y4RDxGsEAJRn9Pc2lvDG8EE0
         +4xMYQK4JXHimR4VLU8+WvinveIZXBNflattqZntklrumlkgaexc+SJgib8wqJZ67h4H
         QKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725997407; x=1726602207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIUkVijX/obmO81YZ0hDppAp+m8ygO6cINoJy3iHW4A=;
        b=gGaHto/qJ+4U0IQ0KBKANS83PEyz37XxnRipiu+7z0lJIluIUTJqIth2pmd8jxTToP
         pB3tix6JSLWsFjfDh4hVG9FaXLFQO4KyXlQUquRBQjpmYy0vGoLQ+yRWTgDItbTXukfG
         w1/tVUxZzde5WddLqmDKHjhqsXx+MUtWE5xoIbcSBQInwczJkc9xXOVuGvyk3Get/EdR
         OYAoXRf7ZkmdlDd+7zNzeZnvP9GwcyowKuIhTvHP/G9+KPAJwrKWOLxAD64wq8MrzWwW
         +Le6R5CHlhMh8mf5V9aVUdvuo/0rJRBSdU3BOqQ4pGC/Ua4RVvm9sX3vs5whqVhYtJuZ
         ZV7A==
X-Gm-Message-State: AOJu0YwGbl1tE4Ox3nFiCMIZeUAjp05H1o+wa5a0vAEvNo1gPOc3go1W
	1UMHPSxBRa7yHVlV/xchr/VVzBmMR+r3ohTy0RG6U0fGXE8LxpgunTe03GhCMiM=
X-Google-Smtp-Source: AGHT+IHIko6wrr+sFUfNKE96zD/bA6pVDBoyLufvdJCHIMMC8sNiJfBBEk0IrGQr8l+j/w6VextyQA==
X-Received: by 2002:a6b:7843:0:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-82cfb078a0dmr393887839f.4.1725997407264;
        Tue, 10 Sep 2024 12:43:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dc68sm1742786173.3.2024.09.10.12.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 12:43:26 -0700 (PDT)
Message-ID: <64ab096c-c493-42b1-945e-ba3547723720@kernel.dk>
Date: Tue, 10 Sep 2024 13:43:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org,
 cassel@kernel.org, handan.babu@oracle.com, djwong@kernel.org,
 Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>, rjones@redhat.com
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
 <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
 <0ad933b9-9df5-4acc-aa72-d291aa7d7f4d@kernel.org>
 <894a9361-d232-41c5-8090-89fd61fadb28@kernel.dk>
 <3d87bdde-4800-4a8b-9b34-ba7998f503c3@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3d87bdde-4800-4a8b-9b34-ba7998f503c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 1:40 PM, Jesper Dangaard Brouer wrote:
> 
> 
> On 10/09/2024 21.21, Jens Axboe wrote:
>> On 9/10/24 1:19 PM, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 10/09/2024 20.38, Jens Axboe wrote:
>>>> On 9/10/24 11:53 AM, Jesper Dangaard Brouer wrote:
>>>>> Hi Hellwig,
>>>>>
>>>>> I bisected my boot problem down to this commit:
>>>>>
>>>>> $ git bisect good
>>>>> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit
>>>>> commit af2814149883e2c1851866ea2afcd8eadc040f79
>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>> Date:   Mon Jun 17 08:04:38 2024 +0200
>>>>>
>>>>>       block: freeze the queue in queue_attr_store
>>>>>
>>>>>       queue_attr_store updates attributes used to control generating I/O, and
>>>>>       can cause malformed bios if changed with I/O in flight.  Freeze the queue
>>>>>       in common code instead of adding it to almost every attribute.
>>>>>
>>>>>       Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>       Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>>>>       Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>>>>       Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>>       Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>>>       Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
>>>>>       Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>>    block/blk-mq.c    | 5 +++--
>>>>>    block/blk-sysfs.c | 9 ++-------
>>>>>    2 files changed, 5 insertions(+), 9 deletions(-)
>>>>>
>>>>> git describe --contains af2814149883e2c1851866ea2afcd8eadc040f79
>>>>> v6.11-rc1~80^2~66^2~15
>>>>
>>>> Curious, does your init scripts attempt to load a modular scheduler
>>>> for your root drive?
>>>
>>> I have no idea, this is just a standard Fedora 40.
>>>
>>>>
>>>> Reference: https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b
>>>
> 
> [1] https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b
> 
>>> The commit doesn't apply cleanly on top of af2814149883e2c185.
>>>
>>> $ patch --dry-run -p1 < ../block-jens/block-jens-bootfix.patch
>>> checking file block/blk-sysfs.c
>>> Hunk #1 FAILED at 23.
>>> Hunk #2 succeeded at 469 (offset 56 lines).
>>> Hunk #3 succeeded at 484 (offset 56 lines).
>>> Hunk #4 succeeded at 723 with fuzz 1 (offset 45 lines).
>>> 1 out of 4 hunks FAILED
>>> checking file block/elevator.c
>>> Hunk #1 FAILED at 698.
>>> 1 out of 1 hunk FAILED
>>> checking file block/elevator.h
>>> Hunk #1 FAILED at 148.
>>> 1 out of 1 hunk FAILED
>>>
>>> I will try to apply and adjust manually.
>>
>> Just apply it on top of current -git, doesn't have to be your bisection
>> point.
>>
> 
> I applied it manually and now my testlab server boots :-)

Excellent! I'll get it staged for 6.11 instead. Thank for reporting and
testing.

> Just with the patch[1] on top of bisection point
> ... as it was faster to recompile this way ;-)

That's a pathetic excuse for a test box then ;-)

-- 
Jens Axboe

