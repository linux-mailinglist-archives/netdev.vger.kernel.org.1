Return-Path: <netdev+bounces-96211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831378C4A70
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3301F23D1C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A958625;
	Tue, 14 May 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Oaqu00a2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E87F8
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646284; cv=none; b=gbY20AZqrKlmPxQ2YHiRj5MbsjO9dApEmXI9HIGidczs1Hgv8+tjlaBYnheEvb3uYNdncoDolG5iUyqHUhhrAsngWuEzfxMkeNRlorFsVh7ztRy1SJViKMLCDjQoM+AYRFpnFoMihXsrZIrQACWC5c7fKYiq4KVrbMSNNoUABc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646284; c=relaxed/simple;
	bh=t0auGNVQBeIHxq0bLd1+ULfQscoiXyCuF7VCFEwNfOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc0vP8XYZwk1sEaQqqiemplgwieuU/DAQ5AlLxpiAQDMCr/4vG2QbhUfzEfNh1WMRTW3+7EJYdhUacUaGnKSGJNIgEDh/j1jKPsAOB96v0gdl3G7hyOPJFaTdauKDasYC9KfQBN/0Rrr2VcXrzxiOzKpPYX+FKMLW8v+sVEGLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Oaqu00a2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9b07c073aso110864b6e.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715646280; x=1716251080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vv9tAk9ywvBLGmojvsSeKdtPXUn5PYoMEpo4ShJp7hM=;
        b=Oaqu00a2lAklIIbKes+bstqQQWz6bldW/LwtB2EC9PZ03xi7uWGSj2MeE55egoZVbN
         f7NwBNNqFaT5tjd84jneU/+G9te3djtFMW5LXN+KQAS7u7Ni7ooHNUMdFhm56+2/MUgB
         pxe2Ws/GENzaescGSYVMofJIpWd0VpNXR0ROFcflwhlgNE+mARL38w1HOqYGxF6y5HFZ
         Fz4M/E63uiSJOVbk0+ptERbuQX/VhbEA019JQOSxyu3i7CZrLg6Cx+BKmBuRUbei51va
         jF4K075wbTKUO4ojX0IgQJWHHaPAm8ktZUq+3VHRhVqXkJyu9fhNMB7LXwhgyxMMi6HH
         MCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715646280; x=1716251080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv9tAk9ywvBLGmojvsSeKdtPXUn5PYoMEpo4ShJp7hM=;
        b=KHI+pJAgFE9p6utReUCa5NLPA+f7niq9sDL1oRYpTfjwPitY0f61Fo9SGA606dTQ+Z
         qZcI8gd+FwllpsxfVKGledGRUvkyYQ4A5o+GPzGHKMZWGWLRAG5EZ2iKMx5MHgzO2Aii
         KRMM1nBhQ5ReUCwsjIF6L/gU/6IESIhnYUknQd7Ge5eNg7oTkCMiZUBnRfODDBSGwx4Z
         uk6wfPMrViQBAHdKtd7oZstDtIsA6xfBSnkeSZvTcQZmHEU4UK45SagRe85zchibpM3D
         u30Vjuvmzx1jhRLaJf0RS8mL/BTOfh4aekyqfsuoVVkdylEkBYufDI2lrD27ZnuMo87k
         ggrg==
X-Forwarded-Encrypted: i=1; AJvYcCVHM3iNH3YWX7U8g2/f7+xJ9U4PfBJQBJmAE6RSqw0CR9ngLyFFM8uVLtw7Oa6fWlrtuuf2Sxn6aUxt/w5svMujDiWEXU85
X-Gm-Message-State: AOJu0YxuuzOrowYaHwJoWTOXqnGpwGcNyc5BciTiWLEA78KZVdFi53dQ
	MMjvkv0mke5eJn8CS9wMmUqqJ0lWYdG3Uo7Xj4gXjQniV6G8teczV6RXUDa0gMo=
X-Google-Smtp-Source: AGHT+IE5noQE8R5HMrOb/xoqVoPsOKt6780883wcR/yNCRrEI5wnHZY8XPt1NoYg9tNtvafk6w0u0w==
X-Received: by 2002:a05:6870:9724:b0:23e:6d44:f97f with SMTP id 586e51a60fabf-24172a3d677mr13744472fac.1.1715646280135;
        Mon, 13 May 2024 17:24:40 -0700 (PDT)
Received: from [172.21.17.150] ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b53sm7936468b3a.151.2024.05.13.17.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 17:24:39 -0700 (PDT)
Message-ID: <b4bb08a5-8213-4b31-870a-f4f24f7a2c4f@kernel.dk>
Date: Mon, 13 May 2024 18:24:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC 0/4] Propagate back queue status on accept
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240509180627.204155-1-axboe@kernel.dk>
 <20240513171347.711741c7@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240513171347.711741c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 6:13 PM, Jakub Kicinski wrote:
> On Thu,  9 May 2024 12:00:25 -0600 Jens Axboe wrote:
>> With io_uring, one thing we can do is tell userspace whether or not
>> there's more data left in a socket after a receive is done. This is
>> useful for applications to now, and it also helps make multishot receive
>> requests more efficient by eliminating that last failed retry when the
>> socket has no more data left. This is propagated by setting the
>> IORING_CQE_F_SOCK_NONEMPTY flag, and is driven by setting
>> msghdr->msg_get_inq and having the protocol fill out msghdr->msg_inq in
>> that case.
>>
>> For accept, there's a similar issue in that we'd like to know if there
>> are more connections to accept after the current one has been accepted.
>> Both because we can tell userspace about it, but also to drive multishot
>> accept retries more efficiently, similar to recv/recvmsg.
>>
>> This series starts by changing the proto/proto_ops accept prototypes
>> to eliminate flags/errp/kern and replace it with a structure that
>> encompasses all of them.
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Feel free to submit for 6.10, or LMK if you want me to send the first
> 3 to Linus.

Thanks! I'll send them in later this merge window (post the net-next
changes).

-- 
Jens Axboe


