Return-Path: <netdev+bounces-161659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9DA23165
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E453A5D97
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486091E9B32;
	Thu, 30 Jan 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IRqJGuea"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B071922FB
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252941; cv=none; b=MSQ/mNMWUnOx9XM4IwWXwTNvmWyNH6IjF5VaCLx8f0SQDNrWDsy6zJuqAyE0E3POOk5ioZrgM/1MRmTavj0CKdogi3J0iGVGyOlL9Nyqg7hOSFp874Z6teFfpi1pnjFNIKRH5GyZiBekPMjGPnt02a7qM0GIk5ORLc1oPPJBcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252941; c=relaxed/simple;
	bh=7MBdSk1BwpNy2hET1MIgRuFKrd5FE+flA5d+9r0ciIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B19rJxFpDt/1vK23XRoMynpJX+gf7i21YUI/6htHXU0SbfZbAnyReF5FXQTfACB1SILTa0OktbyXY+HCBqGj5yeJMgFi/qkYiBeicCp5D4zAh1woYiRP0msjqUaD56ehA8zVU69XQVyM/CJhq3OA/jpGPEnsxXstBIfiM94yDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IRqJGuea; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so2441705ab.2
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 08:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738252938; x=1738857738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltspuTTT7wImpABc2X8tmjQrqpC9O8a4ARLx4Ty4zio=;
        b=IRqJGueao5qD+6ixAouFt+o9SWa52+dH87GtKc7qCVMzTaC8sK1B8yhhAL0po7iHlp
         usceISkwJLFDEReA2UcCPLmBP9Dn98TJSmof8AlkgGDyWE4msYarFU7B2l85WqjoLOhT
         zu99jC2HV9gjRGjLcVsc9kKiO43KuTtvFyRLI7bZigRyy2iesnlorg0z9T22Q4+lAYSA
         +jH82qE4gUH/xJPPIdQOLSyHC4CsyttFgP3KYob/5mOCvKbFmLfnmDUw6agdBb3pXgrB
         gEwCgnykkJdxFQXAsc+cAT0J01PvDdXA9lOnd90MeAA8KdOJ6UwLziMuAesH38t7dXZC
         3jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738252938; x=1738857738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltspuTTT7wImpABc2X8tmjQrqpC9O8a4ARLx4Ty4zio=;
        b=Wh+nvXOpb1VsPrA5XEfZKCOvK9XWPDrKngGdXhThrFRBOf3kcOQOhCObkrmLz9tLOo
         VlHXezlKD3GnunlRvmczGXvmt6204bq0rjRWkieJ7+REzk4jjAn/uOdWE/0yAeEHDILn
         0wbSovFnp6iccbCZ4gJVNU7EhLSx5dVeZ8YpZ4Wl8kOuhsy+QR8XYvOe3JKqR4zHXRRN
         37xMRy2eD55sgZPlF1VQOlxVfTiu/pFNJjIUOaGW5LOHTGoaPereLcygUqBs0+gEJD0y
         QRAhvtPuvCj87jHDFC1yQ4MHWqI2EvbqPhv2yfJG2uJJSv6QLuomxAAeccMRG0FtzPc+
         cghQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjAzJweD6h++QstSrnZFXinb9sSHwhfzK8DTII8BydSfA9EhFGW6GDPXTF6t8Jj5ishBUfowU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaN1zw+IyM5oiT+wqagAskudpL//DUJLwH3yLWg899iX78VV6N
	YcoCVSolf1gWYZayDHNR/F9knRxgZ5Q3uma5l7ZY/27uMzcUDm6EhHl3g4fUvvs=
X-Gm-Gg: ASbGncvXJaTstmwpq+9ZJ4r1Qac/J8hUsJ4g4MNYTM5i88crx2hSWtLta2Zb+JcLbuM
	LwczU+nmMAAI0zrOHPXWZ3SYklWKcsQBR6HdRpqKtAz3YtAsle/M6zNAy/j8Q8kqCOelLO27k7p
	MJ4yGric2O70RmlV+OEy2SNoJhPPiwtRruMHutatUW7KidMQEfNdCJRLb68sUAZjrwBY19lNZtI
	4NqDSGeRIA/m75KKMABI7cthe61N+loiprfy0Zv1xqyKmOS7kYDQTE/MOiUCYfm0eMIr4OBxAxO
	3dB3oODXIg0=
X-Google-Smtp-Source: AGHT+IEyfjBLFtwVqhDL1I53GZ/4BxHmuOhR1GSFC1bm0nbAYhWgUJncLJfkZcCqVW2Vcnd1wsa9Jw==
X-Received: by 2002:a05:6e02:17c7:b0:3cf:ba21:8a20 with SMTP id e9e14a558f8ab-3cffe470222mr76274605ab.18.1738252938099;
        Thu, 30 Jan 2025 08:02:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec7469f02esm396436173.90.2025.01.30.08.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 08:02:17 -0800 (PST)
Message-ID: <04ca477d-36f8-4b5a-b4b8-a33afc75d144@kernel.dk>
Date: Thu, 30 Jan 2025 09:02:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan, mempool: don't store free stacktrace in
 io_alloc_cache objects.
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, io-uring@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 juntong.deng@outlook.com, lizetao1@huawei.com, stable@vger.kernel.org,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20250122160645.28926-1-ryabinin.a.a@gmail.com>
 <20250127150357.13565-1-ryabinin.a.a@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250127150357.13565-1-ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I don't think we need this with the recent cleanup of the io_uring
struct caching. That should go into 6.14-rc1, it's queued up. So I think
let's defer on this one for now? It'll conflict with those changes too.

-- 
Jens Axboe

