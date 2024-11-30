Return-Path: <netdev+bounces-147947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF199DF392
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C271162522
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9601547EF;
	Sat, 30 Nov 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AGXkX1Dl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70712B93
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733007137; cv=none; b=CwRp7dyk4tjNwfrlDUMqYfSI6k6wlhnJYwWjPAdA4b8+CjVcdyiibvCPpXJBVSKVFOIcOEM5iIGbFZIRH8Gfz4nx2cXakVoHgQfLpUokkHc4NEhQynDzmwOczt9fxnZvuzr52puGTgb67ML/DPdHAA0EsO6ysEr81XIdl0jRFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733007137; c=relaxed/simple;
	bh=3/A61l6u6KKwu56sHmEF6GjtOoJLPkDCA2s2wa0kVF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOqcJ21OAgeEGmY7Hflph2qCvIpZpBunBHiO0xwX6HyoxPoFPDq8fLQ3i2rI+CPBe4h//gk076aY34nHSMnYIUW3BoC4mRjpl8z0ub1BhB+lsdjpFEbY9jIHFypsAUWlI/j6uY9QsOnqhbbCpCOpj5vBbQHjtkDXb6bYfWZsdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AGXkX1Dl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215348d1977so20099455ad.3
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733007135; x=1733611935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GctjhqWclCrwErjveYFBB3+ZWcWFvGKXf8HoKCKMZ6A=;
        b=AGXkX1DlUncCkaxOnZtrvGkAJLqhiDZrPA1Puvdodqj6ZNYGFMs8IwgPkbtF3uYTGG
         Yu6Z/T0VmpKHBcckINCG+fLHsRxiVzfH7NpobgJydydFnem4q5PABS45SsfoFfKqVYZY
         3WHzkI8lwslyy/OxWGCW8YpuVYORx99qBwx0UpA2cakd0mlWGB423gkBzlA8LUy7FdGT
         4AaaUcBgdma2jGdjs4ptZ0xWCtfg6ZBaoFlljsLulaiRk7cSnN11Fjw5M6ZBIixi+4ZS
         tbtcCPjz+rN8frZFWaNWt237PZYEFCXUqAr8jjkNyGXLoKaEv+p8WR7NFpjoeto2lXu3
         FPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733007135; x=1733611935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GctjhqWclCrwErjveYFBB3+ZWcWFvGKXf8HoKCKMZ6A=;
        b=VBC54xQ9zUx/f3mK9/so1mwyWWtNKptds+GmT6nG++Zpr4sXEKeEgyhG73amDtsZCJ
         EWS8poGePtCzPMwnwMkbK8HE+UggRPAkmQ2qTfI99+zAF9LRAlF/eEpNrUV+4U3Pdj0f
         XxNdmvHGuW//6jnl4anPgpP0O+KEftWn7RcZQQPDIJnUim0foMO9w0mjJ29nq9rALTNq
         6ZAbuAF8CnD6oaMajM/bXAQ4HXOwLQWfM9gy4LYMbqU7XsfwBtaZa2OGb4lLJ7e3oorI
         3IG8K57rGgzJpWnZCXEseM4O/iiTNJlyeFQDtuttUAh/BdqpU8NuwqROpkJTqQTt+U1Q
         hbNg==
X-Forwarded-Encrypted: i=1; AJvYcCWzWVkJ4TZ1mNKnoh5b9MmHiQsV/ZMWkm5wcZnZgJdRx80vr9vYcRvFhgXK+1qKKwGZ3eePtJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8tTAxWNhkuq9QNh+ZlX4qcwEVMqaM8Ml+DEr1uaN4NFutgVS
	QLvfPBKPHVTSIEjQLbyFooKp+8TZAytB5PDy5DCZYWj9bQtUz2lNpfT2Vjjx6gM=
X-Gm-Gg: ASbGncvrgXilKfSTG0BWT/HJEvdpWo1D/WytWeW7WH/DqMLZVQdIeJX/QUeaZ3n+LU+
	RiRgbR6Bm2AnhB1wIKJyDPO4nTsz6hUr5Zh/d9cL2o8LMt8OTEPwLxazysmntHB+c418mZs3Fd/
	fWBtQJkUHpblBmSlViUfb3DSPZhZVtqQ8sjSlM86hRasWw7+O7BeymV/9MdkHF6zP2zkDsqEiFK
	E/PtZMUF6ZeLauJCk+ZMzxdCLl/zAskntydsxd2d7BGCg0pT5UPbj9j
X-Google-Smtp-Source: AGHT+IEIGkKaZT5XlW+P8y4rgXsp4M30OqRgZlTXW8MCzow5z7aRB6zAvvYxo6PMEItucNwiLF+oQQ==
X-Received: by 2002:a17:902:e5c4:b0:215:431f:268a with SMTP id d9443c01a7336-215431f3acemr124545605ad.31.1733007135021;
        Sat, 30 Nov 2024 14:52:15 -0800 (PST)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152191ba31sm51193495ad.110.2024.11.30.14.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 14:52:14 -0800 (PST)
Message-ID: <836ecdec-fe6e-41c7-a388-cd63ac884c05@davidwei.uk>
Date: Sat, 30 Nov 2024 14:52:12 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20241127223855.3496785-1-dw@davidwei.uk>
 <20241127223855.3496785-4-dw@davidwei.uk>
 <CAOBf=muU_fTz-qN=BvNFoGT+h8pykmWe0WX-7tw0ska=hEk=og@mail.gmail.com>
 <c84c5177-2d1b-467f-805b-5cb979edc30a@davidwei.uk>
 <20241130141416.3c703eb5@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241130141416.3c703eb5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-30 14:14, Jakub Kicinski wrote:
> On Thu, 28 Nov 2024 16:43:40 -0800 David Wei wrote:
>>> Just curious, why is this check needed everywhere? Is there a case
>>> where the 2 page pools can be the same ? I thought either there is a
>>> page_pool for the header frags or none at all ?  
>>
>> Yes, frags are always allocated now from head_pool, which is by default
>> the same as page_pool.
>>
>> If bnxt_separate_head_pool() then they are different.
> 
> Let's factor it out? We have 3 copies.

Sounds good. Will refactor into a helper.

