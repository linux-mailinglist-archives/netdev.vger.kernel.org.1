Return-Path: <netdev+bounces-163177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9CA2983C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D98E1631E6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67E14F9E7;
	Wed,  5 Feb 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="voMldSf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BC13D897
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778419; cv=none; b=XfD/Y78S09LFUGjDAwnGzCAqiG9o58AXGyU9ocuk62fxcKuvDoS4YeWuAI6MFEoFXVDRb5faKfQ1RLmOZKrffCzFBL6H6zD7abKBajTAI53JT9bVlyGVfI2T5x9v7iuoSBtwyNUnswWTflUSBGAMTCyXA7421mf2QKOK7XS7Fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778419; c=relaxed/simple;
	bh=s9Qgnpn6r2190v2nA4GqMwHO0j8Hw5uENz4UJ3f41uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpG+cxllb3gNKO0gug+9aj8e7g4IfOm2OoR6yVykMPEG9G0kznG7RhMnFKqFBUIEDeszisUwKlS3w488BVM4kU2QRC/LY32M+XOW98nIWNE8alriCHh6YLJ+fI5esKqI5Quz47J8CnYb2BfLIDEk/iGxNLoal0dRtoNLVr1T6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=voMldSf9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso1669955ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738778416; x=1739383216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqsLs79AAlIM073GvcgJ1TLaeDe9ty5LPGW29rzMqCA=;
        b=voMldSf9FH8iG9Mt3+dgVHtWoBL9OShH5yd1ojNegDv42TxqqS+wJ4muRzPOxEO+wv
         4cYc0IEgJDoKkDcla7GhpYXysDl1xhggV1Vi1WBtbR/4oWCzdwdlNDL2Q+iqjD24N46b
         UY3ZrMRoSiXRTtBU5ls6qZ6zL9I/N4v4wTUhoKcDKKxuCgMyEIcOA4fOgYjFvmgSubJE
         N0Rm+0c2M4EgNxnuywpENsaldZb1Yo5NvnNh1ZHkVNU9X1RJuaSOvwND8de634E9Fpzp
         2CIh0lKFgtYx7bwZrBqzhSNBAZ9jGCZT3din5fk05znT7XmXJ85hfIj/qbqhvY2mvi1/
         2c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778416; x=1739383216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqsLs79AAlIM073GvcgJ1TLaeDe9ty5LPGW29rzMqCA=;
        b=FTSdpfXC4taxv7KLSgfu2cpqNndboDmtzM/rvsduGymkfBCOaEAVZpsuGtArmITNbd
         wcbDNXI9mC9XIC2xclwudFmWPtXr732DBbVW9fmRwzwMgZJXfVYLayuXl0bhHg4/wQls
         s1Z6zWoDrWo+yZF1nps3galCk8fxHoO+o2StsZ6Q5KkFbnILbpZBHiEtkGRmLvGzqt1L
         NWZwDZhmVIZd9t9D+NgMhmrYs6pcjba3PPdcvbcqvkhzJJYyuEciK1JKQgKwxpvROqPw
         WKVXVAaM+GaDHa01CQ1oShX/UUEcjr0dZwqoQus3N3FdyJQEuvTQiBqovbgXuwy5ryAT
         PKeA==
X-Forwarded-Encrypted: i=1; AJvYcCW8dZhD6vnO2QiDk3qSqkMBsd5KFVrNNvrLPKxCHiT7Jod8R3i/gjyzQRdAtiTv44ul7tPcnqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAAkZSmsrYMOW/MCwyqfecTOUJdDYG5NZPOcce9RT4jDRoTOSk
	5a7wYbQGYdTq0fD2xODhddVUTzidn1mVaJG1ZKq3NUTE9/Wq++LmcetLdTzHn+oq2SRWlGeKBWc
	i
X-Gm-Gg: ASbGncsROfTJsEUhsUJVJ9RyGilNdgsK6h2y2TCmVJfQmLYh8tGvgIRAKkDkCmA3+Jm
	XPd/L8znE693XjZILkC+wLR/vETQN61wsGTvKlzmcGkj6bJZLXE6V7fp2n13/TDxKt/hus6DtjK
	nwOGIFbfebfoAi+xd4OM4IPO3JGdD1ENYtqLnaZBs5bsgcxRPqKGuYEXpKtHEKAG6tZ34bVmaj9
	MBjjx7ScsHDDkgxPrxQonc7we4FgUEbVM64q5wam3NNL4TI8yqAd75J8Yv2jqJNpieaQVbl8XYD
	q2vI6vUcSlHl+hrWORzFwN1hvMJHASkitZSn9NcgklQqS3KoG2kJDA==
X-Google-Smtp-Source: AGHT+IGF7V6OHvaMjbILJbRGV2cvZaodlmRVRv0KAAVr/0eb5h1phDSlYJy0QkZxavoYItjXpWGsYg==
X-Received: by 2002:a05:6a00:2886:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-7303521c6d7mr7136542b3a.24.1738778416169;
        Wed, 05 Feb 2025 10:00:16 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::6:920f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0a666ddsm10221754a12.73.2025.02.05.10.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 10:00:15 -0800 (PST)
Message-ID: <da6b478a-065a-4f02-acd2-03c6d6dea9fa@davidwei.uk>
Date: Wed, 5 Feb 2025 10:00:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250204215622.695511-1-dw@davidwei.uk>
 <aa3f85be-a7d9-4f41-9fe3-d7d711697079@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aa3f85be-a7d9-4f41-9fe3-d7d711697079@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-05 09:44, David Ahern wrote:
> On 2/4/25 2:56 PM, David Wei wrote:
>> We share netdev core infra with devmem TCP. The main difference is that
>> io_uring is used for the uAPI and the lifetime of all objects are bound
>> to an io_uring instance. Data is 'read' using a new io_uring request
>> type. When done, data is returned via a new shared refill queue. A zero
>> copy page pool refills a hw rx queue from this refill queue directly. Of
>> course, the lifetime of these data buffers are managed by io_uring
>> rather than the networking stack, with different refcounting rules.
> 
> just to make sure I understand, working with GPU memory as well as host
> memory is not a goal of this patch set?

Yes, this patchset is only for host memory.

