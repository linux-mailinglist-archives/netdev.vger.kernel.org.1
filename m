Return-Path: <netdev+bounces-235478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 744CEC3135C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A49E54F1C0C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41137320387;
	Tue,  4 Nov 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLs1+YSm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED421531C1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262383; cv=none; b=kTRaZiZkaByQ/fIMKnSRBtXmqi/HiwlkebEK3TeHytERF3ECo6uw9TXL66sHt2cQ6CPzDc965NaG4CbiDfi/gC+qLTJCiy7kURE3c7UdXRDJDTYT/3ImDi75LZKfuT7O4cqvSjZJ1Hl6m7PB2B5DEDrrtkZK8k5eCbYk8SVlSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262383; c=relaxed/simple;
	bh=h9hk75rxVl7d0Zh2++Rd24Sz7+AJRBhDgJpdTCPn/9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNZMVn5wed7EzplYU3dDYzcQLifaruP3/TtFEGpKoyIaWKijNeEejSaOb6EzUTnUFmYRgHlPepg48zvjZSQ0BPiRIOP2JxTXvXkWI4luCZifCPCF05PpUWpZALQB0UJ9S0tcUyHB/hh7U5ANV5e8ckBuThzcosDU2Mx86KAQRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLs1+YSm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so41129445e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762262380; x=1762867180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWOHovOvm9zqFX95kWhz8f8ZSaWj90AXODW0xg1GYJo=;
        b=iLs1+YSmBqcvgTkLGGPA/F2VB/0aYTAJDGykD/kQgjSOxOgDSHQPQYycZuDiiTyydV
         QWsv1N3rhJXUDF67wAOBLc45m0tmUuCoIyCpIA0aeQtXfAlQhZRqkS3ejXTYQUbGEheJ
         9a4V+RVrkF05Joe4uUSbXV1BSSC47Iz81IlWqyTTWmYHHXpKZltH0Y6DtOZFSHpjHlmy
         qN7OtS29XgWHttdd3w+wTAB9fLin+tT9jouf9ku6vAbPcYL0BFZt+dz8mzoaH2E27V9H
         5lI8fWl108Qa2jgVvbja1ZOwwkKG6Ho95UEmeZFKoEE1VvXTBjW12EMuwf6TzUb+ElJV
         hohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262380; x=1762867180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWOHovOvm9zqFX95kWhz8f8ZSaWj90AXODW0xg1GYJo=;
        b=HJJH41xeXfV/F7MIT5E26PSBpR6ny1YtXjZL7YjMx7o0XPhRowUKw+7q5eympLC+j9
         9RdCMLMPFU7PvcTt6a7LbTEG7z7dAmzUC58WimRDnx9xlUw2Ol1Y6dGYalk3ctza5oho
         u/tw3FUQFhdRudslq7naatCTUpnUIVyrtmVPzHucfaDE95VKyGQWJ+KJC/hzV1hmj6mG
         U81NqEzOMj3lKqXGEYLfHtZ/n9VibLhg6Iizl6RVrw3rbxYuYEAVQ3olJ4uhSfJOcp2l
         ME9gXpR8M1v8ikk7FqvJvXLJvmBQgS6+LnKegLjBhqZrzIgvsFZACQ2dUzi00LT3ydQZ
         LUsg==
X-Forwarded-Encrypted: i=1; AJvYcCUJaw0FGLrTlIZW99zudUrOk/v4lozuIhf5xIqgIzhrNjdpAN6WgBNdf/PDE+CS8vuOusZL7sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlInO1MIoy+b8uBdAF50VumycSaVkr7AxjPF4xRFnh9fo2z/12
	AnaR/y5LB4o1plvYf6PlCQaB4ZY0P490LNPhBQiwXx6Nd4pfg3jEN+TI
X-Gm-Gg: ASbGncvAO0dek7AQARu+VgVcF2oBQCAJc/2wVFCLV8hZpdQyN7pNiPkfZhyDvs+1K7R
	Lri4ldrle2SpSQOAiUvV2iurNFk+hUxu5wy/5DCU4XfsnUT8qib71jHYF6DEv/GNqZ2s+inzVVK
	v7d11xHoJmxrw8TwJnAY7lInm2P6DPbWBHBCci6XbHFXabIKRr7bCfqaYsiH/CCNoJtjEjmVzA+
	dJCRGdbr8KzMeJoDGQ9YOu93JvOqU08CTYFX70OIqAsHPEdDNBzH95jMSi9YQpbGY7gu/IIL9qs
	vm1+fBXnUFcjM68iw9qrcWNbUB2EqW3p5yMp+TGrLFTUxtgKpd8KrEdj406hzpJ0kcsYbugGqPQ
	g4PVSjk8SNj8Nh5L6ETQ51PtWOnaoYxeHRGz6qutpTk959aGRWacM4GdyCKMpy4iWmglL3OwQsq
	2jaLZs98IzYtx00qR6KzcPrH+10A/LEkqa6O7B/IPRHQPHs9Z62cc=
X-Google-Smtp-Source: AGHT+IHY8BjfLUPxtJgLBAwz+rsEl/G+IGO6c30HiqIKn2EWKt9/FnBvS1WTFD1OB0TOWNUZhf4QTg==
X-Received: by 2002:a05:600c:1d9d:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-477308cb9e0mr139708735e9.40.1762262379521;
        Tue, 04 Nov 2025 05:19:39 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff714sm212287655e9.8.2025.11.04.05.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:19:38 -0800 (PST)
Message-ID: <bec690dd-8163-487a-8db5-0252bccde635@gmail.com>
Date: Tue, 4 Nov 2025 13:19:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] io_uring/zcrx: remove sync refill uapi
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251103234110.127790-1-dw@davidwei.uk>
 <20251103234110.127790-2-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103234110.127790-2-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 23:40, David Wei wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> There is a better way to handle the problem IORING_REGISTER_ZCRX_REFILL
> solves. Disable it for now and remove relevant uapi, it'll be reworked
> for next release.

You don't need to carry the first two patches. I sent it out properly,
and once it's propagated to for-6.19, this set would need to be
rebased on top.

In the meantime, can you send 3-9 separately? They solve a real
problem, and it'll be easier to merge the rest after as well.

-- 
Pavel Begunkov


