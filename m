Return-Path: <netdev+bounces-190152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F98AB552C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5ED27AF5E6
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA7286439;
	Tue, 13 May 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU9V43Ii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224ED1D52B;
	Tue, 13 May 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140531; cv=none; b=tVo/jeaKXWJwDo7dH4AyMiqWfzc8zH9xdX3ObjCBSAI0RHRXLzVHOdtuCHyIdkJMFohJtIii52OYzcpyCFYyHdRiT+cvg2DGSyAmJpHFbw5NzTGN3ZznKxWEwJRMusLc9+eFgHzzawko1ZkHfQxuta6pbdcUKOzlxwfiItoxa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140531; c=relaxed/simple;
	bh=IRMm+C+NtzCnQzW5ekgvU/LsZ5ZGYQm9QCLC9PLIH7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtgY2nek0mPhiatCQJo+60EBXPXBr1uCSroiJnvYSXW5gESHXxhvYBtSLy/dPhgL0jLLpRWD9Rf63Z7MNJD+hyCorKgLF77NUim+UuHBFpxDabKe1ymRS6EKAsxK7sQKyrfWfvRtioqKHhwI68HOj5CMzJqKr6DMAjf3r0/sKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU9V43Ii; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so38896135e9.0;
        Tue, 13 May 2025 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747140528; x=1747745328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5TgOXyLSPHdmxHWX/DD9xraZLG6iwcHdcK24HBFLhk=;
        b=HU9V43IipaRy17NuU15l1HKOr9KH9cnIT8fmvYJAZ9W+8sjyNhVs42ZHa0zWT2k9ne
         YTgR2e1DMaO0CHolLi5icBnv2cQW3jv8OuE2MGOQO2bHZtG08GFAqtyBZr6r6T6Gg7PO
         B5wTTpD8jWdgF+hB+HmVB25EogTv/OnBo1Pfg3/AzjSpC0yo2rfGkTBnzKkbPF9vhQHO
         dtVYu0Vf+hGCbU0wJbcv9oIQOUdA5uQFBRKyk0CVFiTPWwBI4f2/7lEG0MTXiw6T5KtS
         stbSz5ZLdBN3S8fLcms+FegHflcgDhRmjIs7QrQy5axmoprCV2+glY1UcFgIkDbwrFjb
         LIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747140528; x=1747745328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5TgOXyLSPHdmxHWX/DD9xraZLG6iwcHdcK24HBFLhk=;
        b=fx5pZI/P7/AXLu8rj/B28RUq7ZQ6kX8XUeJrhBeW3hbQQTWwbTonFvTSyTr+iah9zL
         dyoqHeTTsPSrkn723HD/ibjUIT0iSicz21qSzJTjWX7ejfnPeXG6gUiUPtreBmafH+a4
         gro++EaBdqOTmUnyyeQDPGzYjo0iFzbvpBwIpcuHh2U2whKj3QylmTzeewyT5yDvJ25l
         KynbVVSQPwZbMo4mdHHmsaeBVqLAdEJ/6zgci6DfPc7NCSiGNW6tcBtm0hPSCLhd6HmT
         940YlezRtdzVYSpfKjjHR+MUYgdLEEN+JaZ0cU/2NamgwuckoGeD/JkqmKIA66zdqyEF
         944Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzN3f7LJ8ncFq56vKwj5XqbUGpn2EtjHX3vqRLjT+XJuS3eGvNkTb9SomXcczQRLE0xD0Wy0EeOnNujYU=@vger.kernel.org, AJvYcCXbkYUYoGBVq7D79jF3bH88RIvCqiL9DRuPeOY5ZY8yNJ2FXdYsDnriaWGxqYf8l6AQhVMU6Wjq@vger.kernel.org
X-Gm-Message-State: AOJu0YylawN83dRYNzUHqNa3klplQUb3zZuL7C6xtjPKWOQLB8ehX82A
	qR4NMoE3+BskRBlG4b10IsQfwixy4ILj0eBciPV0KwU9Lf0+sYxb
X-Gm-Gg: ASbGncsTHpH/YsFe1pmlhL1h69gUOp7MHJfB3bPlWKK4T4MljCa9q+3L/3ttd9EkWWb
	4XIeqshA8TfFOwcvSMutY1KP/80Op52Xd497Fgfiqt84/+RBKcrsyVQM8XTnIhkGaqSIIAJJSwY
	EwpVVcVzU429FQLo+LzD6aFvUnTbCX5K3zwigNoYE7T34CNDImTifkEJ2llF0mC8N+7Fo4GDfSn
	TzrmtWTIuxFG3/ECy2gSaI+HtQUM2Y435SAuLDGyyZ6+EB5K/zx0gxAAs9Cqrxv/ezVokWMVQMg
	6aksTholVGis/Il3dTWQ5A/cO1MfAroc2i42K1fupZD+XErILc+LLQOMH2RKQF53HHy/Ka2P
X-Google-Smtp-Source: AGHT+IHBreVwaNTD250MP1ZhUthvVQWAn2cvlOqmyeNmqTywxz6tsH2Gn2/fdJuks7mp7pU/Wx6dDg==
X-Received: by 2002:a5d:47a7:0:b0:3a0:9a02:565a with SMTP id ffacd0b85a97d-3a340d15421mr2730099f8f.3.1747140528111;
        Tue, 13 May 2025 05:48:48 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d6858566sm165365765e9.32.2025.05.13.05.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 05:48:47 -0700 (PDT)
Message-ID: <eae3e1a9-1d82-40b7-a835-978be4a6ef56@gmail.com>
Date: Tue, 13 May 2025 13:49:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, vishal.moola@gmail.com
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-2-byungchul@sk.com>
 <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
 <20250512132939.GF45370@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250512132939.GF45370@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 14:29, Byungchul Park wrote:
> On Mon, May 12, 2025 at 02:11:13PM +0100, Pavel Begunkov wrote:
>> On 5/9/25 12:51, Byungchul Park wrote:
>>> To simplify struct page, the page pool members of struct page should be
>>> moved to other, allowing these members to be removed from struct page.
>>>
>>> Reuse struct net_iov for also system memory, that already mirrored the
>>> page pool members.
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> ---
>>>    include/linux/skbuff.h                  |  4 +--
>>>    include/net/netmem.h                    | 20 ++++++------
>>>    include/net/page_pool/memory_provider.h |  6 ++--
>>>    io_uring/zcrx.c                         | 42 ++++++++++++-------------
>>
>> You're unnecessarily complicating it for yourself. It'll certainly
>> conflict with changes in the io_uring tree, and hence it can't
>> be taken normally through the net tree.
>>
>> Why are you renaming it in the first place? If there are good
> 
> It's because the struct should be used for not only io vetor things but
> also system memory.  Current network code uses struct page as system

Not sure what you mean by "io vector things", but it can already
point to system memory, and if anything, the use conceptually more
resembles struct pages rather than iovec. IOW, it's just a name,
neither gives a perfect understanding until you look up details,
so you could just leave it net_iov. Or follow what Mina suggested,
I like that option.

> memory descriptor but struct page fields for page pool will be gone.
> 
> So I had to reuse struct net_iov and I thought renaming it made more
> sense.  It'd be welcome if you have better idea.
-- 
Pavel Begunkov


