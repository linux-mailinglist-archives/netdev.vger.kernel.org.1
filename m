Return-Path: <netdev+bounces-223214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E8B58564
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A461317004A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E650283C9C;
	Mon, 15 Sep 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XwzDcp8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2427C842
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964995; cv=none; b=XYbOX2kiMveU9lSelE/1WrqOpTCsGP29VFFiR4zcj3q/3xXaF2y7YAP8Hlw9q/HvxPR4gcMWzb7eVfiBMZZJ2TUtxQ5xG2oJvXO35fZvzqpQIB7+DteuX5G0sEcb+6JA6r8tu+/IZ/ENN04dy/3f8v3i0I1fsUo6N/mazY/Xn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964995; c=relaxed/simple;
	bh=uEAC5p+AjUNa10foDlmnZ/iJXlzmcT/Zp18GyN1xzQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2Zv7yrszAP6/cvRH9/iv6J+6ygwhVnANk6hRe70lrTKHgqs8n3jUGV566CmDLJOvYy2enNwY2qYYi56b+xuN4hvj2tQWFF/5Qti25FyfrxA55yYWgnDunQJJ4qv2umQI3egSxOTkLnGUvi1E9s7wn9NcbgUY1s4XNCPnS8WjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XwzDcp8p; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42403c64164so19736235ab.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757964991; x=1758569791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QRhMXbwN6ZOtvgpddJaVy3QSoQt+zsOVvdVieAZwxg=;
        b=XwzDcp8pXiwXK+G7p1rIal7nBp0ZsMVgd1uOBSdOo+IY7lhbwEHGgQvF/dvDAey8ed
         l/fuzHlfd8iFFAME6wZ7xjIdaXZcZ8tih4BQ2e78fqT44a+70Cj/piU9xTxOqzMFpo/I
         gW+RkI9Y/bMizSQvggvMnmtVVMCMNCDbXGsFXdJqHhaCE0+JrWTrtr/ZWbVvf8L77WL9
         hnSZphFz8WcFyhFOUh8byfMZKLg8jRh1B9wqURvbzJM0mcc6ToXl69TvJgzRrosYqV8C
         4feT7Mx/KuSEet/h1TTtSLQjP4JPGVEboyvZia26xjInOQ3/BtWyV5mtj8AqYIZaWjMp
         0DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964991; x=1758569791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QRhMXbwN6ZOtvgpddJaVy3QSoQt+zsOVvdVieAZwxg=;
        b=nHYmps1KYXPQrepeYsrYKKzWiFBIBqap13qC2UnowviDz5LPim3baaMnvU+NoZqED1
         UV+g/V61MAd7zMY9/Psa3JKAVKYpg4z2dEt5U8qyF8BFLBhAd6gnWXEWpEecD3Xljbfr
         DueIIDVWXwmyA/vkuPB9gGJYPOIL1mSiWfKlETlDwBlUgAPJpfMHlaip52RzNzhDUyh7
         Kd65C29AOzdAnfh8hNTtOOpafXXOaPLrHe5QyuVsUzH1TUA2Yux4PSaVDrEVG5ex8XNc
         Cx/atyECMM51dgIEzakncqRuw5UEocZIKG/T2VBZcSYtUIAqSOjOU+QwGpBSq53p66qf
         /kBw==
X-Gm-Message-State: AOJu0YwXP7npmnLfE2ix3uWFOzMa63Hz/2NE11lzTHvK54bg+rv3tRPf
	TWPLRE5K0xSAREBevaGwVxokunINyj12vMxXHLNbTBi97v+3rmdhxKPSeJldWdzekmo=
X-Gm-Gg: ASbGncvbWn++ljJ1hMjQk+OTSuy8o9herwar7HJkvRo4UFK0lZr+R3mSlK7zUvhpUat
	tQPu2QVFupAntV6N/IFYPEN01gJ/sVBqLT73ZSGjtnl8SkmsNGqcNlQRh3vjKLGSeWqCYeCSexp
	RQuwuQi1xOM+k7r0la+z8nKVOnD2kMTF/9IpKd+o6Qi43e0yjxgBXUjWfUU4zEE508qLs444TnJ
	p5Qf4Jgz105bsNk5Q0+VWl7r8nIebxdCdFSv+7FCVyd4AaV7tTjEBkB0gChLbGPPS5KLjD8J49f
	d+v9/+0hU39yWD/KD07KbmUaa/pE8BOKwnCf95VWs/Ohx8zl0p2lJxKeToFusC0fPQhhLEMT9iw
	Ir+eKbNY4ZBBsyOGZOyBs8qEoGXMfUw==
X-Google-Smtp-Source: AGHT+IFEYX/oPDGLIujkgUjpKHkd+AJzUSAlzQhNdyXjqsuLxj3O8GToO+/Ue90TwQzp6EYj8c6BCw==
X-Received: by 2002:a05:6e02:18cd:b0:424:71:32e5 with SMTP id e9e14a558f8ab-42400713e12mr52694585ab.31.1757964991321;
        Mon, 15 Sep 2025 12:36:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5191117917bsm1281543173.10.2025.09.15.12.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:36:30 -0700 (PDT)
Message-ID: <a58fee04-db3d-4c53-ae27-2e39b53e5e84@kernel.dk>
Date: Mon, 15 Sep 2025 13:36:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is -1, get
 dma_dev is NULL
To: Feng zhou <zhoufeng.zf@bytedance.com>, asml.silence@gmail.com,
 almasrymina@google.com, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com, tariqt@nvidia.co,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 dtatulea@nvidia.com
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20250912140133.97741-1-zhoufeng.zf@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250912140133.97741-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 8:01 AM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> ifq->if_rxq has not been assigned, is -1, the correct value is
> in reg.if_rxq.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


