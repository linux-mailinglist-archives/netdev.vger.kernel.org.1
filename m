Return-Path: <netdev+bounces-174194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D9A5DD23
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8528189BD11
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EA024293B;
	Wed, 12 Mar 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNjUfhpx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098923E229
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784110; cv=none; b=eqbxSoxIF8+72xJJlDREhOBZGRK1BJUmvxEIx5MDKuEk1IiakiyUIvMTO5tRRGWE00kkaTwLFgBt99Hwy25v514FIrfjzRkWhrz9PrJDSbTFDgR3nsrbNHy9SBCaRGj8QgCFivQvW/cyBC9wUhAlIJrloEjVQpOCEdNVQHJnI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784110; c=relaxed/simple;
	bh=ogYoO5mj7hS6zBV+JMeyKxyGKUngXB8aWvZ8X+pSaZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFdIDEa4jj6cQyDrAQhjwP44QIgrDSaKc/D3TPFlVc1yHJmHVUvleLs2d3dSGYeZHj+Tnm+/FKKvdkhmcnqBkPs4Vm2E+ePc5ezGHPbRq/C3hMee/anxkNHVT3GwUG/g5AhxZecV8sdGCLCEYVADViZtLSHMdTWx6HjuLIHYYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNjUfhpx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913d129c1aso625521f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784107; x=1742388907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4gPyi4FZZFwvRtlGe5MzJLQjJpIeYPB9yg885XBwy0=;
        b=bNjUfhpxvaL4qKPZqSwK86QB57IbJmWbpbg9jCm1zBZeeob2O392F6kz/l1XGGfH5p
         s/E96zT+NOYIw2md+hHVGLQjPX98WxCaQaom5gKHPiF6ZkxUg2pHPEMsV7qK3PC6SKxP
         uHWKM7AF2JEQyPXLAyf+LK2W1STk0WKUBtbEFb3XbQV2fKxjSMr3/dDwKTFvCq48mfOJ
         l7G6+SOf+AcbidQI4AfKdscbJQI25BDxNdHjfQ8QbaehlTI8h5wh8rR5+DQDcFiXMBQn
         6mY/nkWkbWHnb/0NaoTs7HwcCOmhRDRqgCYoPNnWJx6O5OTU1k7lr56iiAPT4Nmygu2T
         rG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784107; x=1742388907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4gPyi4FZZFwvRtlGe5MzJLQjJpIeYPB9yg885XBwy0=;
        b=d/Zm1VUJqumqrcasd3DPtZnI/x2PaonCJaqGdz+G9JdDtMIQpfzq3to6mwcl1qG4xE
         BRP+Ai53+xn4yyOGD09Vyg+O6Q1sS+kzrEu+9pgVxHKQd8w1MFi9RzUw4BXdgWqmV+9i
         dfmF/4Tsy8GQ5uCkuVKOVNOkicY2xt0U/kuayiTj/8BQqeIbkQF6HT78fB6OLFuYCGdi
         As+GMezKoLEDfvz7znn1vU7xlajSdytiQZIBp88E1tdkk5xUf/tHGiDUK08xzNy6QuvU
         IKxOhyNK5+l1IOffzT+fIe4rTNmBAO15QfewVZzYpF/p0cItLVZEysNmMCb+5gSF+Z6T
         wtPA==
X-Forwarded-Encrypted: i=1; AJvYcCVnRvYuWG7t7xXOxNv5vBy7wve4eQArzMvY1SJrruqcD0Uj2/GuMHNP5SuDH690DMtJ9ocubcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoSmP641MZKOfYN7tt/RfmEDQMBZqOG7suqzf+/2orHhGAzP0
	fnntgquvEKZBykukCCe0EasgIEjaO17ZRfn2W+/LM7ETYpEO4kNY
X-Gm-Gg: ASbGncuIvrgAPTGQSQjq5pXgQsnuGrpDadp3rxTQC5M8zAseL6Cqdc7hnfGrVOE+LOM
	xKza4ko+y9/xhF4INFp3sii9Zg6HPAViCwWp+tgHtNm9SywbLDz7ziY9ANEO7pPhF676DxUXFTo
	MpYf/zEHTVO9WgcGvB7rJGoPCd8S+WSC0v+olh+dtNDm8opu0YWgojYP4UcnmGmPh/jMRVjKeKy
	IB7/bW9dq4RWY4fn4kUOV0iwaETtjyWdcEF1K030oEVtmprmjmg4EWxsPmsu/OQnRK5WcCF100I
	fpJgysTbozBRt50yZKIDPNf5GyLyLuuJ1dP639fXyvO2HExBzxycQpwtSQ==
X-Google-Smtp-Source: AGHT+IFR3Rb2grZMDNG/FG7ThrCX73kNYbrZrm3oOz4rnrivx9Eh09Z0OPa03401c9Z37iby/jGepg==
X-Received: by 2002:a5d:6487:0:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-3926bdf5c18mr7406230f8f.1.1741784107046;
        Wed, 12 Mar 2025 05:55:07 -0700 (PDT)
Received: from [192.168.116.141] ([148.252.129.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbab43sm21390829f8f.15.2025.03.12.05.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:55:06 -0700 (PDT)
Message-ID: <ff346763-07ad-4323-a46c-974adc71c121@gmail.com>
Date: Wed, 12 Mar 2025 12:55:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk> <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
 <87tt7ziswg.fsf@toke.dk> <Z9Bo9osGdjTWct98@casper.infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Z9Bo9osGdjTWct98@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 16:46, Matthew Wilcox wrote:
> On Tue, Mar 11, 2025 at 02:44:15PM +0100, Toke Høiland-Jørgensen wrote:
>> Pavel Begunkov <asml.silence@gmail.com> writes:
>>> If we're out of space in the page, why can't we use struct page *
>>> as indices into the xarray? Ala
>>>
>>> struct page *p = ...;
>>> xa_store(xarray, index=(unsigned long)p, p);
>>>
>>> Indices wouldn't be nicely packed, but it's still a map. Is there
>>> a problem with that I didn't consider?
>>
>> Huh. As I just replied to Yunsheng, I was under the impression that this
>> was not supported. But since you're now the second person to suggest
>> this, I looked again, and it looks like I was wrong. There does indeed
>> seem to be other places in the kernel that does this.
>>
>> As you say the indices won't be as densely packed, though. So I'm
>> wondering if using the bits in pp_magic would be better in any case to
>> get the better packing? I guess we can try benchmarking both approaches
>> and see if there's a measurable difference.
> 
> This is an absolutely terrible idea, only proposed by those who have no
> understanding of how the XArray works.  It could not be more wasteful.

Which is why it's so great we have you here, not every one is
developing xarray. So maybe it is useless for this case then.

-- 
Pavel Begunkov


