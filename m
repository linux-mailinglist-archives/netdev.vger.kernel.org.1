Return-Path: <netdev+bounces-151373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2679EE71C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F90166195
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF02139A1;
	Thu, 12 Dec 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5qVsF9A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F051714D7
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007945; cv=none; b=UTGMAWApDozozgcWE3K1/vETIzYWDUqNjyS8SDBGePrlyzhsiETzwAlMIgcDmjI7xEZbM2LyGdIgkOMf+GbDjNMzZQWqferwjAXdiH0+nWPhSzOPFH8Ks58+L9zxmy9cr1iPqhLjcpI4tTmrKcLA2ZLEgUcT1pBIyUodK1sCKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007945; c=relaxed/simple;
	bh=yO8+vjxRHNbXu5VtK6DdP3cfRRnmZLWmqBMtLh3BuFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHD0Z3CPIJwOWL5UoaIiD9CaQYmylyFFm1JF2UkBHi8vLsCaIiOQMSpUZT9Qk9jF/jpJUx/8ZFnrmqzQm2JEV6LooCcXCVa3GrsUmqYF9z1rOPhv813fXKuTy59pvliRc1bVfw4YDyuEByq6CKyM0Xj86kNDULxbPFRmee9nOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5qVsF9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734007943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2U8bkLyFY0VG17PM3STLGJocxPEcgK3UJa/VywLtKw=;
	b=h5qVsF9A9HN16qEzktoy784tBYVLhgMxNEnnPqy+EmvTfTjIcIztuN5Hq+X/eY4CwXdFcS
	WUNa6m7Di6vpcylYJ1rLVnyzvJpHpjfrnkFdpkgUgUu6jX5VXmMmknGOJThq4yiVpELrZO
	2P8RUymT0omoDjg3VZS4ClOfaVYPKV8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-0fcSeZbYOWi8q0LbD8ykNg-1; Thu, 12 Dec 2024 07:52:21 -0500
X-MC-Unique: 0fcSeZbYOWi8q0LbD8ykNg-1
X-Mimecast-MFC-AGG-ID: 0fcSeZbYOWi8q0LbD8ykNg
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-46751b2b92cso13080601cf.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007941; x=1734612741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2U8bkLyFY0VG17PM3STLGJocxPEcgK3UJa/VywLtKw=;
        b=JflRgRdSvsH05tRVZxgPA/ciKKObjW4EC57+JeK9Yvbpp+06vJVAQ9Cgu0AV/ES9us
         pxR+AUtW8iTua8Mc+Zof+OUY0VPX5txl88Q9eyhE+uzrqlkPV+3YWMGoj5DaSNSkIsFX
         NeIie9gsNSRIY95F/oWtW4DuQxEieDs8m8UQGUK4f/tpzGqSJqi3ISUO98QaBRNtDtAH
         NdTy9K5sUx3k6C9UX5d9lcbBK4V4K5AZA5RGhxf0kstzdPExhJOtNACeIZBneb38mG1g
         Q3ZSQul6KqpNVhYKnCWGcAIpB2+j3nX3JJOrHbqBT+6LRASnjiJdjcQ4DZRZFJzpY3t0
         8azA==
X-Gm-Message-State: AOJu0YxF7+evNnGxjqarcyd5qIOC6t5EZT4hbBXRBEOzSZ5QtJ9Qa+1h
	oZYx6NEzAGJIKD7YwOxH2OCEyRTfQzl+r7gP+DLn+ilncUibjekLsbjb2M92gMUotNMsrhjUViK
	Zssoc+JZd4SX0ZbIx8aF0PRPbj8YyQ4Ma6QbyUgbHtE88wcuuZiESdw==
X-Gm-Gg: ASbGnctsIc1R5ZNagZ9CR5f9gR9/9UfN3JlvdzvE9ZARBt58bzfKr8Nbj0PlxHpGBVm
	W9XC1JyqflfZxi061retfoZh+ohB4Y8810ps4AieKhezbLRq0B7AV2mKYIx8PcIctDWXukQ2bfX
	0DBMs4lXlclytgFfchHuTvBiVA9nmYxJIhgbsznJzB6RhmV7yTL018npAmyMnHBK6OnCyDywqxH
	fqDK5WncOiTRFT1vcFgTdtahMVHyzHu0CRnMyBL3oBgRIIFmeNsIsd0HKl9QZgwAiR2QBZCKNH7
	v4Bw/yk=
X-Received: by 2002:ac8:5d07:0:b0:467:6c95:19e5 with SMTP id d75a77b69052e-467a14ed4b2mr2348901cf.8.1734007941359;
        Thu, 12 Dec 2024 04:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaDZSwGXxYjd1DIh1/Q3QGUjXWEtvxdUTyx/9cTGDp2oBjGeLbR9wGeehKN43AJ3psBykxkA==
X-Received: by 2002:ac8:5d07:0:b0:467:6c95:19e5 with SMTP id d75a77b69052e-467a14ed4b2mr2348641cf.8.1734007940999;
        Thu, 12 Dec 2024 04:52:20 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46783eb0d91sm25201731cf.63.2024.12.12.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:52:20 -0800 (PST)
Message-ID: <24cea251-333a-49d3-b0ad-ad19ff5336a0@redhat.com>
Date: Thu, 12 Dec 2024 13:52:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] rust: net::phy fix module autoloading
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com
References: <20241211000616.232482-1-fujita.tomonori@gmail.com>
 <8d00ebff-5f5e-4b00-865c-aa7e48395d08@redhat.com>
 <20241212.214723.846689767325390398.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241212.214723.846689767325390398.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 13:47, FUJITA Tomonori wrote:
> On Thu, 12 Dec 2024 12:42:51 +0100 Paolo Abeni <pabeni@redhat.com> wrote:
>> Side note: the netdev CI is lamenting a linking issue on top of this
>> patch, but I could not reproduce the issue locally.
> 
> Hmm, I don't think this causes a compile error because it just changes
> the variable name. I confirmed that this works on hardware.
> 
> I don't know what the error message means but it might be an
> environment issue?

I believe it's a netdev (nipa) build system issue.

Thanks,

Paolo


