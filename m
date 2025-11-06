Return-Path: <netdev+bounces-236262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B548C3A7AD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 532424FF39A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24430BBA5;
	Thu,  6 Nov 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFsaGLaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF172E8B7D
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427285; cv=none; b=KPYl0+qHMVGz0/3kx+PpdLxIol/gR2rTUPRoMq6NJ032HvsVp5z+TF3Otf72SANXCl+0jDP/bARDJ8gfOf/GqcyUvAONIrfDhxhhMfVuJ1woK0+iHL6EZbBlM9PusTZw4xpYCkaIFnfq5Aqx33i5QBRBUe4eF2jz77Ouy9wZdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427285; c=relaxed/simple;
	bh=iflFF8uGA+JQqg5PeOnkh0xBZA/LPV6uIzaa7UsyVRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG+NHAqxsRMSrM5/L/YbSMqeQopZzKEjUL2teiwaLYnkhEyY91/uRC1atzTTKKryA7JbMlcHIKB+ZTX5srMH4VnxPXmFSmzT+MtSzsf7kYAQ2Ga78ZLl0WbphKtO618S7PWvAkRz+vMEbfMaIywyX1jUSXK0EV7Ii4/22M0gQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFsaGLaa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c82bf86bso589439f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427281; x=1763032081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=lFsaGLaav2Wzq+kdJsJU1Wb4wW+hsZE5/nqsyi2eb0dBlUw0xGSjTlzzn4Sa1cJnLz
         qOyyIeD4YWjmrVzmwvu8aLSvJiCrNWiWtPu3V2gOXZd2hOq/2CFDkuqVKsyHc8xWaV+2
         UnIEinVpCzCm1HQ4R8dAMK+BQyH5QFyCxuMW0Wu90+6fKHiCDqa85zysgdJoHRrOgGTY
         4TuJETudPaQ70g6dro3pDcNu6mNd5AGjgpMzdSEf+ANdVpng/0xQwNfcTBWXI4fgmKma
         Gx1wfD/x+CU3EW9C3Q90NaljRbG7J9kS+1tSE2oTZqfxywlZzb1JbKbJFTSXG8MyWUxe
         SNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427281; x=1763032081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=w0nMuBLrN0AAHT8DcaRB+KFGWzCmOcec75FsaW1pTtliPGKraVwgIBxS6H++mD8E5n
         IFz1N7LS2CDrVfcWcn7EdMxkW969WyQ/Y4gIWWODmHGAnGS0IFcOt8wViwCzEHq7yoKK
         ouv1BBKZHb1Av8L0iG80LLIrX/ZWqlmXlf3w7QeMK5Fr72IbP4Fx9891jugKA5lRHhkY
         m8DtLf4EuTSKik3n75H8EKR0ZM9qAKudwh4JhjQzL/hfhK1Fmzepch6hpYWi5TmIQCUq
         VJVFOC1odXwUOxp50yGdPRRUmFE+7AAoW6rfUEddKzJR6usH5qhuPz5oLB6V5FwH8SD0
         nEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVqGJeKPLotyolsB+nAwjfHDhgCp1F6BaC7P8FurIGbf0F8BM6k+lx4ZJgFGz9aHgUxzJnSxk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZmnkzE4VLvwQ4Hw/WupcCf8yimmweohZsHHkz38Q72O+vnyW
	q7bDC0vDi9r+4M/w1Gc+2gD6R+B+Zi/0gpWJP1PSUgYru89OpggOFNu7
X-Gm-Gg: ASbGncsxwif0E3ZlCh0EIxEFGjs7xwRAXBcAY8mLK0O5V3mqzkTLnlnCFdJ8m2i6HHh
	iWZ8XYvFKsTuXna1S+yC+NObx1KEja/CrWrutvRoK2hCzrs4xPgfvpoYXY43rl4+5IqtBtrve48
	FKYgKQyd/BSKaxEManOiNIVmlKB/iBZHmYM2qhZ9aU4D2dwVBTQzvVaI9HOhTFkIS0xXwxtvNfp
	eOT9jWkkAg3qqtXreuw06NIxmxWr4LWo7jWE56hyyjGK6hVXvEq2lSdg0FW3B9G0JYh7l4W228Q
	GjBJwWtGs7XqYRC+fLNZZvnBLwCQKqsytq0pCq+bHDOwfZ/57z8KZvPReN8mCl0WDLyf1JfkVk4
	6Bt5jme+7mSjyevI4ULOBDIVMLGAIZsYRUpewNZ62/zYr4r3TdA7gYiwu0OiFDBM/JQgF52NKoh
	oncoiiwgYaijsJgS+oCNM71hN/Hv9YZiRx+aQ9k0SDdvrx3FOmr+Q=
X-Google-Smtp-Source: AGHT+IG/WPvgkkz5ima282cKyz2di1ByWQE6/QNBfZEdI+atynO653MZ5MMOXdVnpoH97C2BXp1trA==
X-Received: by 2002:a05:6000:250a:b0:426:ee44:6d9 with SMTP id ffacd0b85a97d-429e32e3595mr5318368f8f.21.1762427280858;
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403849sm4648357f8f.1.2025.11.06.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Message-ID: <785c9d27-23e7-4ecf-ad2e-202ba506f2e0@gmail.com>
Date: Thu, 6 Nov 2025 11:07:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
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
 <20251103075108.26437-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we will instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
> 
> That works for page-backed network memory.  However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.
> 
> For net_iov not page-backed, initialize it using nmdesc->pp = NULL in
> net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
> io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
> !NULL to confirm its usage as page pool.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


