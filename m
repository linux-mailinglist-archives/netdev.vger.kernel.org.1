Return-Path: <netdev+bounces-133764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D9996FCD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E111C22115
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CF188917;
	Wed,  9 Oct 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LawUZK5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DB1A256B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487631; cv=none; b=e9pnF3nGTglCLqhtsJo6hT5MU5BQQUkpBjZKh6GwykMJl6g+bWgUp5yS3jhWwjmqAh2h+euc1QXxo5tBJE4bo5VKSPgoVvYDzJ8D0791qI+FD1rtJdLGujCVP2hCseJsRFQs7UVpHJXHPTv4XTYbltknGFDep/Mm9hV081GiYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487631; c=relaxed/simple;
	bh=nHhYT90i9k8z39HqFNoz3Vmu86He0hEF2pqu8ZMAp8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KifhFxf2Kt+vU5rpWXlMjudVeVB3hQ3jafe26Y8o5Ny9jD8KoK/5+ibGo3mhseA9gZhbanYmmepOWVloQHtMlf/IituzrqPQRVwjRyyPbqJoe32TnQEAUMUlaqaS0sjygCUqHvsfgag+kym7028oQBrScfjKz1OXcOJo8dYcXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LawUZK5R; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a394418442so5039875ab.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728487629; x=1729092429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTyFpPeleynuNWUtVcj5JZexBLSzJgt3M7J02jY/6wo=;
        b=LawUZK5R0Nqaz1BQan+UifF9U8sIFM9HWDUeO62t/Wsu9ORd2fIn0YJkIz4cnIg3eq
         WJXRcet2kJDeIhHacSdjObJWwoGhJJmc7DLvB9L9HmG/bfkIpKsV8ZpdlgPUwT6YKr11
         5TDLeHEdHx8zTjnVTniDcrjQneGHTMDawQuj0eKskq2igWYBQX4f1c5tIsZrrq4S1mtD
         5fN2dKQvVUdpLJ+ZXbjZycXzuOL0Uh4CaNzK1TUC2g5lLdq7pv1Nc1rPUbYGjh225Iic
         w8cXWXHg8NbYHJoPcgcXE1d0qfbFFsrCyAM8+86juOlcLWSonPQucciUwWDOBHBVpyUR
         ln9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487629; x=1729092429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTyFpPeleynuNWUtVcj5JZexBLSzJgt3M7J02jY/6wo=;
        b=oBTiiGSrTg+1bpb6jKIvA0CuRbbSOthpw+EPsDQwd0rR+M57lXSEGLH+pxs6RtfQ/v
         3iUsPDcwAHFQLsUlrixoSYkU2GDmfBfZwQ3sFqI0YUbrR7p2SUWcWpQ1/yLsq7p+ijmf
         9PH7v3bBqoHYZnEQfO0A1He7l/+k/LO+m+VLGjClvFZC6S6ypnhpNghQZcQ34e/+i41Z
         9esO0JfA/Nh+58QSV3KIkAubSLUup1WIfLOenAV512zvCQ6Y0t8m9XA3HfntICdjgT2L
         5yKTMrb7oe/sNJI8WqwuxMfvH5H2CGoJX+iG3v2Cl0Swk9URHamWztMlxMML2iMmajpa
         H1aA==
X-Forwarded-Encrypted: i=1; AJvYcCVXfOnf9hUZKVDngvYHwX12CpAzk1N5364QNJojRCGZ/mt6tmrMJ+Uq8EBxahXOlGUjkSvz7OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3T6B2XDY87hAx8+WgjIyfiY58S3LtpPRSvhvi1p0sbsu3gj5K
	UikSBfz8YuKMEsrdU188JW307ZfpaFnVfYH0BuABb9252w5m/rW52MWE/am6f7g=
X-Google-Smtp-Source: AGHT+IESb0NCNYTlclocLPr5eVXgtgLbfc8mN+fnubYvs85sTWJT+ORAWc5diDFcdiNtnTrA+1HhzQ==
X-Received: by 2002:a92:ca4a:0:b0:3a0:97df:997e with SMTP id e9e14a558f8ab-3a397d0d0efmr29017595ab.14.1728487629165;
        Wed, 09 Oct 2024 08:27:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a39fe90428sm2390635ab.32.2024.10.09.08.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:27:08 -0700 (PDT)
Message-ID: <2e475d9f-8d39-43f4-adc5-501897c951a8@kernel.dk>
Date: Wed, 9 Oct 2024 09:27:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 4:15 PM, David Wei wrote:
> ===========
> Performance
> ===========
> 
> Test setup:
> * AMD EPYC 9454
> * Broadcom BCM957508 200G
> * Kernel v6.11 base [2]
> * liburing fork [3]
> * kperf fork [4]
> * 4K MTU
> * Single TCP flow
> 
> With application thread + net rx softirq pinned to _different_ cores:
> 
> epoll
> 82.2 Gbps
> 
> io_uring
> 116.2 Gbps (+41%)
> 
> Pinned to _same_ core:
> 
> epoll
> 62.6 Gbps
> 
> io_uring
> 80.9 Gbps (+29%)

I'll review the io_uring bits in detail, but I did take a quick look and
overall it looks really nice.

I decided to give this a spin, as I noticed that Broadcom now has a
230.x firmware release out that supports this. Hence no dependencies on
that anymore, outside of some pain getting the fw updated. Here are my
test setup details:

Receiver:
AMD EPYC 9754 (recei
Broadcom P2100G
-git + this series + the bnxt series referenced

Sender:
Intel(R) Xeon(R) Platinum 8458P
Broadcom P2100G
-git

Test:
kperf with David's patches to support io_uring zc. Eg single flow TCP,
just testing bandwidth. A single cpu/thread being used on both the
receiver and sender side.

non-zc
60.9 Gbps

io_uring + zc
97.1 Gbps

or +59% faster. There's quite a bit of IRQ side work, I'm guessing I
might need to tune it a bit. But it Works For Me, and the results look
really nice.

I did run into an issue with the bnxt driver defaulting to shared tx/rx
queues, and it not working for me in that configuration. Once I disabled
that, it worked fine. This may or may not be an issue with the flow rule
to direct the traffic, the driver queue start, or something else. Don't
know for sure, will need to check with the driver folks. Once sorted, I
didn't see any issues with the code in the patchset.

-- 
Jens Axboe

