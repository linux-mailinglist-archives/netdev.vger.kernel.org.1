Return-Path: <netdev+bounces-236265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFBC3A7C2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44E9A501A8F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734430C610;
	Thu,  6 Nov 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHL+/B5m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D312E973A
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427321; cv=none; b=CUNL1wFE7rkXRzSasI+YoN9HlSPJJax7ySsFExZvO44Nvb3y8aMJyisphnVh75T97HjlbyrUu+W9qU7zzELtoIvNL8m0hVNBhCZaGyQNmbwNrx+6tp0tnnsTcapEePy1+HsHXMv3qfBD89jYFY+x5pZhB17frQbWVmE3+DNE/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427321; c=relaxed/simple;
	bh=PXhPi+1hjJwewKP9F5q/Fq4A6lOFuf7yfuMD/xspVc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHYQXVeL81tcNLlnqSRMYuoxbVG1j3+fUA/NGTXugCLHIz9kLc3l7fyg6lW0A8QUHmwNkRKdwkqkINBN5awb95pCTtdWLA/FY7LtpPWm7SRPg2arQLKOrO74YYxlhLz5ZuRZ6q5eMQbS6+QhaQBxlZrpdgDE5GLCuTxK5cR5JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHL+/B5m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710683a644so5712565e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427318; x=1763032118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3smk6GeMQLyg2bWpqf+opFvd8OFCVzmfS4zTn2VVngo=;
        b=NHL+/B5mvjXpeuKKe4fkmjixR7Nm80lIkURNcityRDYr+D5pkL1GNX9f+cIT1HbnK5
         fIpG8yLJ5JAhuBaLZAISDF9jIzv6un2EbKUyjcAEiUie88cyD1+cfzRlegYGxW5bjGWG
         vAA5/sWSADsQY596hceHBxGsqR6UOR1ApH5S7ukBdPOitdjqWuUuL+pFYFPKJjtnssIj
         wIdLP2Z2lJRhPm59pJ3E6evFOghju2DEVWiLc8wecJqLLrrF57AQnsbEhuIbmbwqqNrI
         s0f9K2HaUHtBkAtHEGmPWowo2jTfaoyTAvpKsgyIGhq6Hn0qUDbmks5YZTK3Qs9DW8Lw
         L0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427318; x=1763032118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3smk6GeMQLyg2bWpqf+opFvd8OFCVzmfS4zTn2VVngo=;
        b=LRwuvMgN1FHEW+K1k/tNu66ra6dNaYgYFwARVDDY7vPp1Tf+QquWR18v+MzszqtF3j
         pcOqoj8d2EJw4VlvDXUPYnPvM8j+UUWxhHhlrIvyUzrh8vBTcmJfgOGJVXz8JSjdhab6
         fCc49PDflwrv730ZY5Y8FApli712JxfEZXTpWbVbxYRIfKFExKcd5utvs0tIR66wG+Qq
         5jGe2vBfA5O11KQ+RJqv7BwCksZJkDa+K28ndcW0m3QYUhwqVhyc3AirJgytWaLv6Wbz
         0kg43l03/f27/XTk+QKEoUqHaajjiMkdA3rEp1Hx9zVvVaahzl0+MBJ4HX+NaX7HdlKt
         igFA==
X-Forwarded-Encrypted: i=1; AJvYcCXKKJ07S8KPkUgEd5SRblMzcXsb2p/fILws7rmwmKlkbMGsG/RfvthXmOwPIBU4mzV8lNlYal8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmB9gsTgwZ4KrhLo+ri45F4kGQNHmB2ye6AZGnVu0tV00cxGn
	HxQ6gKuKkoHtM82LaZ0BnFQ5og/hbUdEeicjIInNKe9SNVxaLblbsqL9
X-Gm-Gg: ASbGncviBX7pfbUn2ic9JE6SMesgs2L8srZ7mkPuuUdtANCm78o6aeKMZoNMCCdrd0F
	xhFta1fij6RlRz0i8jLLyxYdzZwBpEqCBEysHyqXbuvVB5/7ywnszKczejmNKoIdBsW6lpaMQah
	5LdDotDLAc1nkr3HP7KeMNGCSNG/41qHl79rNn6lG2QGtaFanh4sG/e1xbNpXMdEBwtmuRWBHsm
	+NQ4dgk5okvCnIV1XgQKvg8YxN6MwQqaweQmzHt6hXm7k5Fr/XtUh3LogxZKYvHTuY5MUyWoyfZ
	+vkY0XDNh094wqTnYwDWg1OihAj+cEYu4mcouZ4WnsvBPZ6DoDcecd/9W4ERps0lligGsquRQb4
	J5Q2tcxug7nS8cf6f2mVsvJ98iNrrGLGBkSjI8+I2kL3sdUtz1txYEc1vaAGyx3/CyXk9MXH+25
	kA3xHecqtlcQ8djozIX18/ou8VzxBzoZLacbzBxtqKCsAInK8EfyPfvWtRCDqVBw==
X-Google-Smtp-Source: AGHT+IFUsWMoUQp2LAQBvEqelZeh8+i2mx6qm6o3gPPvtfcki9Q9yd5em3sUzeuAg53ANmu2/8izdQ==
X-Received: by 2002:a05:600c:4c27:b0:477:14ba:28da with SMTP id 5b1f17b1804b1-4776201cbb8mr15583175e9.5.1762427318220;
        Thu, 06 Nov 2025 03:08:38 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm102571845e9.15.2025.11.06.03.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:37 -0800 (PST)
Message-ID: <4ab9d277-97ef-414d-bb5d-910fd8964c2b@gmail.com>
Date: Thu, 6 Nov 2025 11:08:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we should instead leverage the page_type in
> struct page, such as PGTY_netpp, for this purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> This work was inspired by the following link:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on free.

Looks good to me

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


