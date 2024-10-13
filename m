Return-Path: <netdev+bounces-134950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C50999BA90
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 19:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24741C20CA0
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584713E043;
	Sun, 13 Oct 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tKzHElOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A521474A2
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728840750; cv=none; b=l/FovwqeMmHYaHOrGi0GXVpEZwMZSRAl4Tgft7avYgNbqhxx0GieEH/QxJF7gTSzTU7xuggpkADayuRgqd7GnfUK8AQhYQzV1dBbjKKt27wAHyvuErfwc3YDLUWYQk3MxcFPK7r+HwoVjPS/GUU6BlYWkhiJHY79mmmrPz4Kl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728840750; c=relaxed/simple;
	bh=jf0u3XwwwYGjpyfIpwZ8pPYvyJbBdYZlull6SbeLCZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJARcGqLyUAxk6ITpa8iX7PDLMYNYCSJNekXsvzBharQZWhedRAoU++9oJfxfs7zIjB5yU8njYMes9o7OwiRZsaqyYA7aRrNiVvqxm4cZji+Q+pzcNMMakV/zg8pmvxU51j+8gcImvOUeIIxq8eGDdTRskSe8qa/C56eApRYZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tKzHElOw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-207115e3056so28677655ad.2
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728840748; x=1729445548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+AoTIRC7DeglfB0+5gUw5HhlEKInJnaHRBJUpgfzVs=;
        b=tKzHElOwsgiC16bdn/U/bEXGdtONTnD70GqvtUQSEb1owlCuWBPp0anV30yIX2gJyO
         tQWxq+dLMJULFwoZu2xLHLnHTO0e6unzZwOXd42KsVDsHBz893tADen6tfm3Lah0tdtg
         simuovL2/ghwuiriLyHuPDlo5RW5y1V+NtFFEAvOHmTqFwZZP9/fVbVKP2pHPJynW/gZ
         3I3NlHdkypv/cyO/+vzwdbIn3VqfKzJ3R0udM9dyHxlwFnOmPamOr6OyDfP5WmGaMaug
         3C6MYQ7j9w+XVz5P5kFMK20LisDn4T1vnuhUx1QoB7BDptYQoprswrOWhJ/1gLzstRjo
         BiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728840748; x=1729445548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+AoTIRC7DeglfB0+5gUw5HhlEKInJnaHRBJUpgfzVs=;
        b=UIE1BmGZxfdVk3CDA/DRCtXsox3KWPEb9hoIgez4zzK625OsZTWhkYXxXEiS+CB53u
         XNhk9dC06TYulISVB9o8vz72acLoA09SffRCRKVcyaOTwagJ3fujwX+bqW6aECZMYtAc
         qQyVr/olCc++MRj1gbTwzkyQGMyuXA47j6zss/zkLqZ96JW713vg/iHVyshJsPYdE9WP
         nOdZJLtrZQ7G0KuTGAJbqa63cxAP9aXNi3WUskDR6BMJ8Xb5q8E4QJ51gTrfR6sQzbi/
         7f4aMnrGdKJfd8FOPOmps3l+GunJeHldiD24pEQuboX4v0QN8nxIDoubWyPYOz+1P3HR
         X/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHyt0F4IT9/xihSXzjYj7ysTYikhxQJPAoCQ2bPhNnE8lbwkWx9ye8TvV6q1c2QnJbCuDvrf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkhth+PM9fZ0HTH8ilr3kFrN6JHdAQAPof279VvBlu1f2utiN
	tgSoaMjQaD9kJoKKijyv56ASVkLno4gP6LMOTwhf9MIc95Hft3xeHZtfU87YJfs=
X-Google-Smtp-Source: AGHT+IHeXafODkl0BOq1MTcEOUcgq/yVvxBsn9tGImzNC1+zJnc29XMsylbEQdfnFJGP14vnYjnnTg==
X-Received: by 2002:a17:902:e74f:b0:20c:b0c7:7f0d with SMTP id d9443c01a7336-20cb0c781d1mr129857915ad.25.1728840748497;
        Sun, 13 Oct 2024 10:32:28 -0700 (PDT)
Received: from [192.168.1.24] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad99d2sm52489545ad.31.2024.10.13.10.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 10:32:28 -0700 (PDT)
Message-ID: <5fcbed01-843d-4256-bc81-7642dc162a2d@davidwei.uk>
Date: Sun, 13 Oct 2024 10:32:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/15] io_uring/zcrx: add interface queue and refill
 queue
Content-Language: en-GB
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-10-dw@davidwei.uk>
 <8075828d-74c8-4a0c-8505-45259181f6bb@kernel.dk>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <8075828d-74c8-4a0c-8505-45259181f6bb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-09 10:50, Jens Axboe wrote:
> On 10/7/24 4:15 PM, David Wei wrote:
>> From: David Wei <davidhwei@meta.com>
>>
>> Add a new object called an interface queue (ifq) that represents a net rx queue
>> that has been configured for zero copy. Each ifq is registered using a new
>> registration opcode IORING_REGISTER_ZCRX_IFQ.
>>
>> The refill queue is allocated by the kernel and mapped by userspace using a new
>> offset IORING_OFF_RQ_RING, in a similar fashion to the main SQ/CQ. It is used
>> by userspace to return buffers that it is done with, which will then be re-used
>> by the netdev again.
>>
>> The main CQ ring is used to notify userspace of received data by using the
>> upper 16 bytes of a big CQE as a new struct io_uring_zcrx_cqe. Each entry
>> contains the offset + len to the data.
>>
>> For now, each io_uring instance only has a single ifq.
> 
> Looks pretty straight forward to me, but please wrap your commit
> messages at ~72 chars or it doesn't read so well in the git log.

Apologies, I rely on vim's text wrapping feature to format. I'll make
sure git commit messages are <72 chars in the future.

