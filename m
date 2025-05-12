Return-Path: <netdev+bounces-189758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D9AB381E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901607A20A0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634B28D857;
	Mon, 12 May 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxFX1Lnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD925393A;
	Mon, 12 May 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055407; cv=none; b=nWQO3fRs+amfeuZ10NvFoftg4nQGRg+gFdsvcKZfJYXm80z+rZUJFaYYJN8tLba1o07w8nZjTc+Q/F1MsECQGgKFVKP0F6/MmPmbU8N0WO4uVDdXS/zqMsS8/eCsq/0OqqPp7lIW/LEHWhuizhbnXtmcd0wZzs2j4fCt1bBYTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055407; c=relaxed/simple;
	bh=Ni5cL+XJpw8vY15iBnDFlBjmRlHAnS6aw8O7XOdlcOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKNcSJ826K/K2ncbMzwb39jxf8SDn/idRgUAsI4sl6R3ACBSGB0NCg5Yl2sb13BwmsJZeX7wQ2TuQbnfF0pEQQd12rUqWJiruvt06lind6t9GHh7XZDQ4utpP3Zq6co6gwMdkpgpTVAxNTXHDsSqwOt4E38bw7JxiJ2OVlPO4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxFX1Lnk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442ea341570so480845e9.1;
        Mon, 12 May 2025 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747055404; x=1747660204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IY2m0GqQSOITuTvG/dP0HT4pwHEgB9sgpCG5AtHDLbM=;
        b=TxFX1LnkfMpirw7CqmkOk6NpbNKDIj/7Xdr2+/feLsiLO7uq3tn8kQdZYlPn4RX221
         OILIW7Dhe6GaCRfHGyRxnIo8YoyXrXVBm59cKClm6tnNLk3Y8Gh/FU0YGxKANiWtYR3D
         LjxbF0KKxtELqHmZISizoT3cmJZ0F0V3U4R9rj4F5o++3d6+LOxEKXqQY42t5K9ZA43u
         7pNNtbCPFre6sTuqYy/EwnBNXWMGrPUYaXx9gCS9q1oJ+hJKADMnTvJ9dAVzxsOB+WWz
         XYMxFN09ongM1qTFDUUz4kSK2KzAd5tIKxbQNJUizt1tMzV4bc2RW5MDwY+/ROmAnm7G
         ztMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055404; x=1747660204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IY2m0GqQSOITuTvG/dP0HT4pwHEgB9sgpCG5AtHDLbM=;
        b=IDDlk1aC/vgF5HrU0dOMo1M5NU6N9reEFDxCxpqFet+pqnBLFx00RYdXsxH82Y6WE1
         dzDTjYKWa2O0bcX7GDFkPBpByiln7kEeptLD1WLKLifmxayLAW1CxAA8NqfiBJGm+CyT
         vG/XyRjAJOC/g4aOXyp+PbCFtJHVR7ks3gT3Etots+nlQ8Vri88Y25zjf2xJhogv1aSC
         NcB3EikKt7z+GUdJik5e6HSqtYFQ4c/SBJrPhnuj5yX0UE+FRU3P3EEgPYY//F4qX6Qn
         N4MeC4WdBVq+oDgG/hkOTT2L7nGyQRuhuJmOsA3M+Eq3YjRRa1RYwqH2jogkFsmMTQg8
         19iA==
X-Forwarded-Encrypted: i=1; AJvYcCXsLUehUjSSfVkVzORKa21ng3Q5SpavrRpaqg0R+27zFPddwxcR65L2rYy67BDeptjOeALT/aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwqr0Rgm327FwML2HDMDVYTJ1ZwWieWxaeA2P79xKAzVSfAjVz
	PCX8DDKCxjHmP+zF12fvo89ig7emG+IlA0Nfmy24WNsmkLhOwjCi
X-Gm-Gg: ASbGncsCGXtAb4nr6CkQrYGT2Pxt7UhuWZFjVukBUBT+KuwmzTRxRfkHqU1j7ai01YW
	3i9Yc9yhd1cdq3idi/eWiu4r8WBoD9mg9HgvMugfiuSDK6C5JlFAqAwg0NVDmLfwMqeVm5mY9Cl
	Jduz3zYpimSGp2R560kue6GNM+8BKNeTp7oKo6eMf0XWvXVMcRYpKXvQ1KbHTdIbrpnyXQHE4yx
	F/tuwBWyaGk9I5VjUjLPTwBYB57SRmAbxkv702tqAwLfvw2ENkbJ2V5Du9WPctqf4867bTk47ki
	57jy9jVQeUBylNk9Nhk/PWrVBPy+ArY1vse60A6Byn+L6bZTSBXhFM/KA6L2Eg==
X-Google-Smtp-Source: AGHT+IG8LzaCUnCFaL0QXI6cC07KregUkp2uAZHkmluC00AMh0WUsjnsDUWnXZTRgi/pvFAAjvNlPA==
X-Received: by 2002:a05:600c:c04a:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-442d89ca284mr78221485e9.7.1747055403514;
        Mon, 12 May 2025 06:10:03 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442e9f1d1bbsm5872215e9.25.2025.05.12.06.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:10:02 -0700 (PDT)
Message-ID: <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
Date: Mon, 12 May 2025 14:11:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250509115126.63190-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/25 12:51, Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Reuse struct net_iov for also system memory, that already mirrored the
> page pool members.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>   include/linux/skbuff.h                  |  4 +--
>   include/net/netmem.h                    | 20 ++++++------
>   include/net/page_pool/memory_provider.h |  6 ++--
>   io_uring/zcrx.c                         | 42 ++++++++++++-------------

You're unnecessarily complicating it for yourself. It'll certainly
conflict with changes in the io_uring tree, and hence it can't
be taken normally through the net tree.

Why are you renaming it in the first place? If there are good
reasons, maybe you can try adding a temporary alias of the struct
and patch io_uring later separately.

-- 
Pavel Begunkov


