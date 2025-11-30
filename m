Return-Path: <netdev+bounces-242845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C7C95552
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 23:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A515C34125F
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99723EAA5;
	Sun, 30 Nov 2025 22:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDAF21B9DA
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764541320; cv=none; b=gmAZa60d+P+Aw24vZ4JnUrxAZ3S8YP8qiY8/WvxoPqFnSZCQ8cDUi1C5o3HONP7m8m8osGju6m6pqh8wKEvuDs/pAA5rl9dO1XH0oR7f8Fhyg7nstjBTsn+yg70ku3RYB0TJ5VlwpPaWt9FPYECozUer0RboLlfcRVZk218NNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764541320; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW1E2YHqNGZpwAVsvwYxx5eNhpK5Q1qwcheifdNSKBOskti5QSvOEwTjXq1ciywGZMqgHQWMcRpql654oOQBxg6GvKgsuR8SnJRmf+YsNhCcWm7YpDgnruvOrCOawqo0PyCfpkropgqAhdG1JSi1BCtr7KT2Iaqb2o3I3GcEh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a1c28778so40371485e9.3
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 14:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764541318; x=1765146118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Cf6qpvAB3+qiPzMoc1G2+KD0KGZaHemfDmsAqga00ne029cjTT0FkM18ism25hCqvr
         CkJtIWhAk4MwSLtb5PkFwDRo5bScaizlusDtay+NtK2J0bg6N62qecdrScsfCFsXbTJf
         KuvLQLi5NBApewiJS0grrLz776p4GRlXxnIEbGsx6DrcVwlSgLVbq/wKLQ+gPnZookPp
         wZZFeREme+nwtTCmJFm+KDWPHn5fV/bt+/65LewXHh46v5PK35HORPLOva6EUnvn1K6y
         U0ObHfs4r996pUty6h9txk58JMh0bbamUrm6w+qGbZTfdYvKlncPtP5Df48aNUR2PWzt
         BUrA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Hi01ILl3J/ldxJkrYPQ9XAhUDEoDqSFw/A8UGEN85SCiZ4N4pGt2adB+4wt93sbG411zDl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbfOCgg6xjawF2OIZbDicZfyDvrO21t4F4Pllg/icsmsnZr9E
	FJ+NH6/ySCiA5VCdSDZ6qFVC7QV5WmLIwTlldrY2kXlB72nx4xCYg0qX
X-Gm-Gg: ASbGnctN7d/wHjYVYt5KIFJzD4OzeU5ge3JGi8VW3eQykDsbgXX7N6iT5FU6hbzlwBo
	fGbMr8oNii0HecA0/4XJ+BjKqMBEsKRIgIBRfWI1mSkhTNoLoyiNrE9udkVUUR32608QeY4dSEq
	WIo83iERi6KlkNrWFDTjG4BW88LUZWMo/1w+LXU6HKR7eCTIXsYHmOxsMKUJY4yUa9dtUDPbJs0
	1cFHnTu429Pg6P+o0BdRUYvS5iikl1J4aHvcwqJPh+M+h0+/b/1jmFa+15i0psMD6Q8gXMGTGZh
	jaxmKqu/WR5UgkZGVa+s+Y8kMiV3vSvOWdpPoA/jnbDkNebiK6PE8xEGw7ZXrl5PCtM3rHGi24H
	SNQ8baSf+9YfvBPQH5OPlFBdeGT/noIRLgcyqBHVOuHf1+5K7B0PeKLBPkBWCwik3zE/6jvw344
	XmdesUgNqU8Hf+YYoIyuNI7brfnqUwDjcIM6XaHkRh
X-Google-Smtp-Source: AGHT+IEaDq7D6ajMDVwbhmEysEzsY+1ogXGwoywM0VuEEVuoRMtFYjkQRVWQHiyxGuNw2ezMfnKldQ==
X-Received: by 2002:a05:600c:1c1b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47904aebebdmr256111855e9.14.1764541317764;
        Sun, 30 Nov 2025 14:21:57 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790530f0a4sm142367985e9.8.2025.11.30.14.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:21:57 -0800 (PST)
Message-ID: <93c631e9-a07e-4293-a59e-81be85270687@grimberg.me>
Date: Mon, 1 Dec 2025 00:21:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
 hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

