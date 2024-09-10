Return-Path: <netdev+bounces-127125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A022F974364
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7371F27068
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BD1A4F1C;
	Tue, 10 Sep 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0rmjrA50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998961A2643
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996097; cv=none; b=dErgSnhYuXfZx78ZflKaHxgRVkJc1Kn1sI1oV8EQNKfb9YK9oKrCd43NzGmfwcJV2HfG/rKAXv7Bj0CrIDScEEum66CHbo9xdiy+Nh2gnbPl+ftrF5/9KUslTAQUibtF2GCeExutjo1Aja/brrspmwaFqITzqrVEHQ+UBaGcm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996097; c=relaxed/simple;
	bh=o+isGT375rznUuyCnHiY488KhfVAUOC/5n5RbwrhNYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcNyLTZzji0w3xV/4bpXyYeIeFiDHBfeNgk/HrMxWIAnkTtxWH44TGn9McMsJCYK8LOF3V10/iJAZzSsIRVKqmBeZleXOlYyFNca2Cr7CfEs5dQ6uM+l7pt99u7sSvTHFMTv9cvbXevPq/B9VlXRJuiQlXJRGWYsh2mzF7eHy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0rmjrA50; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82ceab75c27so124423639f.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725996094; x=1726600894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOWZEzCzgSPVAG028VLnVxHUP1ia+npqcWvvmw8LBvU=;
        b=0rmjrA50jFm6i8BEBLENQfoG6dgDxxZDFAbMwcVpkFemZRPDyeVK5ejVC9WzULeZ39
         W6FLK2mB07y19E7jw8+OEVrDT4AyJSBSjY0sgGKEv5YAZKtAX59P6DKv822zFL1tYY3D
         fwzS2qUOnsJi4uHjpKTZuBEbo5b5B4umHjcElrZTEYojLGFSffifYH5z1GyTE4k7PbIF
         GBH6SvKoYyoHmF/s7xt0U4KKBd1RNqHrv5dT56KxsSFGWwRXh5fSH16SFq3M+HsXVHfm
         4vd49dSvtK+vL43EEB/F3B15v2hkKGJhX4Oiik6KinCACGvVaaQjnGRhNaaIg4nI5grh
         oP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725996094; x=1726600894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOWZEzCzgSPVAG028VLnVxHUP1ia+npqcWvvmw8LBvU=;
        b=mZ2YrlOjj+1dmM41t4v3batWw85W+0+AgdQpVNtLlCAEdOZnpNiZiqYodKjghS0FsA
         SaNF+6GUmnEZcNYa45LjeHVQuPMwFc0GJ7ZNaB5aTtyGho7jNoDasp64FOMiy6EcOxhD
         NHwIQP8nhCveVxrKsWuq6THzgdTSfZ0IU5S/AG+0JPIujdt+6p2M8+ewXOpMY5b0Gqa1
         ZRHaaMJMlFQphbgCPtdv164wydrDEXwEvHRHJxEcoeguknnQuELxj6girTnuz0oRoXhZ
         8FAGnIx1/pqQSaZWZr+BEG1a5K5rMBD03+fypRsVGTfmuXh88yTtTwA/E9pgZfuMdbky
         kJwQ==
X-Gm-Message-State: AOJu0YzGQgVs8QPKhTtsqc3bjcWU0ClLllyJHyPzYOk1u3zcP6oeGC7P
	4L3Fficv4vtktN0Qh4AOs7HHvvIX1r+s6kRMLxB4h4e7QnEO2stxLfqoBv/U5OI=
X-Google-Smtp-Source: AGHT+IGx3wAHFaAGfb07EAu2FYC+9BjFVSNQk48DQLYU5QsBhA7VsAXe5CVDKV3R7lfPiN1V9lLjRg==
X-Received: by 2002:a05:6602:6d84:b0:82c:fd75:813a with SMTP id ca18e2360f4ac-82cfd75832dmr363399439f.1.1725996094348;
        Tue, 10 Sep 2024 12:21:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dba8sm1766258173.16.2024.09.10.12.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 12:21:33 -0700 (PDT)
Message-ID: <894a9361-d232-41c5-8090-89fd61fadb28@kernel.dk>
Date: Tue, 10 Sep 2024 13:21:32 -0600
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
 kernel-team <kernel-team@cloudflare.com>
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
 <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
 <0ad933b9-9df5-4acc-aa72-d291aa7d7f4d@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0ad933b9-9df5-4acc-aa72-d291aa7d7f4d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 1:19 PM, Jesper Dangaard Brouer wrote:
> 
> 
> On 10/09/2024 20.38, Jens Axboe wrote:
>> On 9/10/24 11:53 AM, Jesper Dangaard Brouer wrote:
>>> Hi Hellwig,
>>>
>>> I bisected my boot problem down to this commit:
>>>
>>> $ git bisect good
>>> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit
>>> commit af2814149883e2c1851866ea2afcd8eadc040f79
>>> Author: Christoph Hellwig <hch@lst.de>
>>> Date:   Mon Jun 17 08:04:38 2024 +0200
>>>
>>>      block: freeze the queue in queue_attr_store
>>>
>>>      queue_attr_store updates attributes used to control generating I/O, and
>>>      can cause malformed bios if changed with I/O in flight.  Freeze the queue
>>>      in common code instead of adding it to almost every attribute.
>>>
>>>      Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>      Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>>      Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>>      Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>      Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>      Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
>>>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>>   block/blk-mq.c    | 5 +++--
>>>   block/blk-sysfs.c | 9 ++-------
>>>   2 files changed, 5 insertions(+), 9 deletions(-)
>>>
>>> git describe --contains af2814149883e2c1851866ea2afcd8eadc040f79
>>> v6.11-rc1~80^2~66^2~15
>>
>> Curious, does your init scripts attempt to load a modular scheduler
>> for your root drive?
> 
> I have no idea, this is just a standard Fedora 40.
> 
>>
>> Reference: https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b
> 
> The commit doesn't apply cleanly on top of af2814149883e2c185.
> 
> $ patch --dry-run -p1 < ../block-jens/block-jens-bootfix.patch
> checking file block/blk-sysfs.c
> Hunk #1 FAILED at 23.
> Hunk #2 succeeded at 469 (offset 56 lines).
> Hunk #3 succeeded at 484 (offset 56 lines).
> Hunk #4 succeeded at 723 with fuzz 1 (offset 45 lines).
> 1 out of 4 hunks FAILED
> checking file block/elevator.c
> Hunk #1 FAILED at 698.
> 1 out of 1 hunk FAILED
> checking file block/elevator.h
> Hunk #1 FAILED at 148.
> 1 out of 1 hunk FAILED
> 
> I will try to apply and adjust manually.

Just apply it on top of current -git, doesn't have to be your bisection
point.

-- 
Jens Axboe

