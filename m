Return-Path: <netdev+bounces-162578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC3A27444
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A0F1883ACA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974121322F;
	Tue,  4 Feb 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEnSuUvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EE20A5E0;
	Tue,  4 Feb 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679034; cv=none; b=plLNUz9QjJwMEqLFoWOjTjS2T7lsQtqii5hMYSGBm2ejob5xo3LQ29JUBocI5YVfUW5tkWMbBld5M84RAumR2rn8rRqBt4nsk+gsMeA2d1E7/KbrfB/C2Rs6A4y1X6S1vWrnLAPg8pJPpNdacH56pAbbNqpc3ZJZOadx1yQXDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679034; c=relaxed/simple;
	bh=GkanHTg8YJfOIYZPl5qFaUDX3s4sbctMSazV6gA65H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bx/UDXWSQqb1VtZZ4hQ+eLnvaiKgfiCqSMf3hiYQM0CMk8i4MncXUk42WXdT/BD6d0BjzTFPiSIBsFJeJcbpxsDXuzBN+/8IEK1q0gv7KH+LxqWsPMMi/PggR4/3lMLun3v/u2BYlmIcV9z98NlcpmKA6QpURgUNJZSAk5jrkxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEnSuUvW; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2f9d74037a7so379057a91.2;
        Tue, 04 Feb 2025 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738679032; x=1739283832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyhfawIW6BL9ao0Gk2vDilOwFrFbnNBUuoOSGGmZbwg=;
        b=aEnSuUvWlraNL4NLtZs/XCTtHdjUA1ZapQ30UpRHw6HhwQGQZbBgH2hWj25A16N4+Q
         O2P8LQDh1pk0HvkKU/GkJVeB6/o2xGxeBck/RiOP276IAc8jEiPpTCAzT2Hv2RAoMqTv
         jUkateTOQgNirim1elRNfx7h5TJAVp7XImQUFF/nHIBzgQgTevq8hJCfNFzS7n4uiqaR
         zZcJcGTR1/7pyUrWnLZPEjpw0YqD7rGwDsk66eRxewdYew1dLzmNC9j3G/eGsSvYiYhF
         hwGiIOIKfDD4Of68btSenw/Sn1mJVXhhvtdQtwe2UzulnbJyAAUkyArPVhTYnvuNTCGX
         W6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738679032; x=1739283832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyhfawIW6BL9ao0Gk2vDilOwFrFbnNBUuoOSGGmZbwg=;
        b=X2b/kUeEQaR+4UHQwmiFCiYGrgjNbbKSy22rVu3ebClMtVHtVDZPS2L8dQVARWNcs+
         2ssdHEsHkJDReBIF8qPAxMc1kicCYODT8FHz7q/0Ipg1UNlztFn6KCa7srb3IXWIyNtB
         q9hlNxdl8TuI2DDanxEKbi9pb/bahQlq4JbXIxGKB6DlNMwyDc85fiCchIyt2NTzIwxa
         320QTNjBghP32krOI/XAbEwFFTIzvfiZ1EfG5KeI5uLpObvUqFq1i9SlAd7AbPy9Trxv
         qjBjvDC+JcKhSP0M8Wrj/+nMceEp+tOV36Bh4sLo+ENHN/CD/gh8XxuDiWGy8CzDLcJ6
         IWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ALcW1lgJt5xBKT9ig3Q+G3mx9sBjwtT0rFWCWvq5bmfFb4xVCm7YYPyWWbrn5NuL0pmIyNYfvksCvoo=@vger.kernel.org, AJvYcCXMsjUyQfPIqQagUTD91LqHDUoV3J0+Bs3oczzFGLZ42LePo4m1EpH60xYUzFfX1Yzk2QQA62Uu@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHHY8MieSCdIfYqHxNmwyOIF62Sh+Lh+S7Svl+cIEg90J20PA
	j05Yi/XELiLRcGixCegR3nNUaamOcEd8HwLBwyy8hL1eOeSecwu4
X-Gm-Gg: ASbGncsKhO5J9QSXM0iWmk4FUjpPeaipst/NJp81B3oc+BzOC4nrBpPY83ALtEpRhgI
	UOU5mZC49r0OrHu+DVXkOdXNai+e1Sr4Kfoe99mVY7ZbJkPGM3CNbWLvr4rhFTt0+J8i2FqNyHc
	y1cDJsJqggISCOoAyv2O7kjQHQ3vKxCc8cK45nbPD7pO43z9vwu09AOCAgVjvzTkuyCQyXPTrBQ
	4rTZzhbUmWOBm1z5IaCpcbbXy83sNJYWFBfA5AtrERHXhq8pmwqf69LbAJ9eEccFziRgLePS38r
	n2pYE0XTRV7cTwBzljotGO8FMZAc4p70URVJh1DzEj8b0bhiOn/AsEgk32OiqYOTQQfCTIZEYrs
	XstU=
X-Google-Smtp-Source: AGHT+IF0T9oZQc1Tw7DdE7b1zk1AYdK5JS5KIXLtSzoJadaSG6bKYNHl/8toZwcR/pyHhtDXi9GUPQ==
X-Received: by 2002:a17:90a:1189:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-2f9c56b6fb0mr3538171a91.10.1738679032080;
        Tue, 04 Feb 2025 06:23:52 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:3936:dcf4:dc64:c1b9? ([2409:8a55:301b:e120:3936:dcf4:dc64:c1b9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d95sm14927006a91.8.2025.02.04.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 06:23:51 -0800 (PST)
Message-ID: <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
Date: Tue, 4 Feb 2025 22:23:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/5] page_pool: fix IOMMU crash when driver has already
 unbound
To: Christoph Hellwig <hch@infradead.org>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
 <20250127025734.3406167-4-linyunsheng@huawei.com>
 <Z5h1OMgcHuPSMaHM@infradead.org>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <Z5h1OMgcHuPSMaHM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/2025 2:12 PM, Christoph Hellwig wrote:
> On Mon, Jan 27, 2025 at 10:57:32AM +0800, Yunsheng Lin wrote:
>> Note, the devmem patchset seems to make the bug harder to fix,
>> and may make backporting harder too. As there is no actual user
>> for the devmem and the fixing for devmem is unclear for now,
>> this patch does not consider fixing the case for devmem yet.
> 
> Is there another outstanding patchet?  Or do you mean the existing
> devmem code already merged?  If that isn't actually used it should
> be removed, but otherwise you need to fix it.

The last time I checked, only the code for networking stack supporting
the devmem had been merged.

The first driver suppporting seems to be bnxt, which seems to be under
review:
https://lore.kernel.org/all/20241022162359.2713094-1-ap420073@gmail.com/

As my understanding, this should work for the devmem too if the devmem
provide a ops to do the per-netmem dma unmapping
It would be good that devmem people can have a look at it and see if
this fix works for the specific page_pool mp provider.

