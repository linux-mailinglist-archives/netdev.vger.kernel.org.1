Return-Path: <netdev+bounces-189755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE7AB37F1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4383B3CB0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA0293459;
	Mon, 12 May 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da4Tfz7x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B11EB3D;
	Mon, 12 May 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054695; cv=none; b=jpfmomOaBU4uIv2awEqDtkihg71X15J71l0HPwUUYFOfXFLqZI6yLGfKla12Zm4fBkTZvAgSvXixvTdo/mCNRz9i9rTXyu6KGHomiJ1OMNAk52PPubMICcs2a1awAaaekNaL5xMypeobHX9Hdqqb6+Eel1wpLqYQM5kjHxH1oOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054695; c=relaxed/simple;
	bh=AfD9tOaM66Cu3OzYAl7ZTm8Hk20KHJt3KcinQ34dMmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGvznU/7QMbfsnzNP+A9EvheK3q1VxOAIhyLgzcWa8EVhtW1Fc8cUK/LvQwcvClkzz1bHx+sfQs9kxwqTWjo6dtByeCzSiWZqhkHLGYGqxbu6zcANQiHj/bwEYUtCpblJLtKk/r2bu0sWGxrTKi4K4RaxaWUKTkRCndyOM/GANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da4Tfz7x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso32639195e9.3;
        Mon, 12 May 2025 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747054692; x=1747659492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUfHzzLkVUWyZNQomKkAfvfG+NNPVh/dAwIfVzHSOio=;
        b=da4Tfz7xA8JgrjYemPVaBlaz4w0nJcN8n8wAJlZnnbYATlXjzTmYDDtl/pawR6kkOg
         HlYOl907VRNXXIVAOy08splmmNR02qP36x6yNjOPrTpdd2zWf4QLtHmC3nVQB1KS7WSi
         yZDZr49KezHkpZV8Fyh3/Wc5uCNHc44BCjM0zUtvm/0wE0E/TrYhSBu4vEwRjyGB+570
         8pxPXWfNOxq27NgvFYp4B0Sl2umERDnhNeDTv/AfYlcyXNtvy8ZHd64V9TCiCyfQ6ITl
         SdDtoBp7FQdGor4MHJgQGVU3UehQeF+t7v+n+dg6d+FgM35JREGNXONzFFxDbfbOeUeD
         JNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747054692; x=1747659492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUfHzzLkVUWyZNQomKkAfvfG+NNPVh/dAwIfVzHSOio=;
        b=BZ/tt3YBu14Orw/EwlMk08BtWEAhibLUfz2X2Xhif3HJX/mKNcAcgSvJQe3o9O0e9K
         oTED/ak6mQlRXUmKJ9mKyx+JxYsdQ34fwAb0Z3Fe3DtCWzEbN5PizLCpgFjPGkLn95JW
         wEq6pySGtweOCQJPjudj6jC6XyuQw4wcGxkpgcwFH5qoGUwClOvjfPLJPZ93yMbbHsT5
         ATlM4ib2fukGz70PVpdB2GO/KEDkivEZaxETDYxzHohFcBI4fKHNCR1dGFg9d5b7uIGw
         MGZAURY8SXZiHFJEcTsYB/Nro4HOT/cNVKFDloDqZe2xUp32akRxkpaTsbBnh6gvrkMt
         rEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU54ImcOf/ETB2eAqN2/y7HP9XFD8m3GDt6isUy5IlE72c57N2D+S6IU/hEtRHcROLaFmoP0zHOYqYptYM=@vger.kernel.org, AJvYcCUrQJVVAAzn0LXlMH+WkYgG3lqooianXgm4CHPTipPHqomnVd49JDSAe0ctTArE7hQR1mQOysya@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2URdbVQWK2/tj1hL86fDiePIKIho5V+dj6inCkDqHZGh0z2R
	42HOfup2yqj7YEXUbHQqnZTH2K3IQWaB+8mIyM62+r8jvNxS8e5/
X-Gm-Gg: ASbGncsEx7PIxCLHHtf7eXkHUnYMf8XPdSXaw5XjXvRdBoHysdORQX0va2iPJiOYb66
	uAMa3tZFlF6Vw2xhYB+maa/BZ7CDd8a5rmxZjrtDGaTTron05qFNxLFoB2aa5H5nA8c76BHJbFc
	tugjR6ygXPWgBxMElebN+XGNePq+rZ2bWCxu8OmUhBbcmJJx56ZC2zsF1TLBxfTyEYbn3M371rH
	xgHfFb6KrPE3ItTGyaNpaSqrk423365BMQpoOo1p43UybKwyFJzJhc/12jLF1aoLh69appmKeS1
	r467xOVipNLwb5rU2T8trlXBRv3FSl+Gf3TT7UHDR1/RQUo+Luzkh3odfl2EyQ==
X-Google-Smtp-Source: AGHT+IE3qc4mSsKQFbTECg8BbO2NXy9TVSwu9MLdCGGNSU6yyCc3khR5s/jlk1z6qlpukuO/50zmlw==
X-Received: by 2002:a5d:6489:0:b0:391:253b:4046 with SMTP id ffacd0b85a97d-3a1f6431452mr9068500f8f.16.1747054691759;
        Mon, 12 May 2025 05:58:11 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd2dsm12404291f8f.9.2025.05.12.05.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:58:10 -0700 (PDT)
Message-ID: <b18480f2-30c9-4598-9660-c2ca317c5de2@gmail.com>
Date: Mon, 12 May 2025 13:59:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/19] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 vishal.moola@gmail.com
References: <20250509115126.63190-1-byungchul@sk.com>
 <CAHS8izPFiytN_bM6cu2X8qbvyVTL6pFMeobW=qFwjgHbg5La9Q@mail.gmail.com>
 <20250512123626.GB45370@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250512123626.GB45370@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/25 13:36, Byungchul Park wrote:
> On Fri, May 09, 2025 at 07:09:16AM -0700, Mina Almasry wrote:
>> On Fri, May 9, 2025 at 4:51 AM Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> The MM subsystem is trying to reduce struct page to a single pointer.
>>> The first step towards that is splitting struct page by its individual
>>> users, as has already been done with folio and slab.  This patchset does
>>> that for netmem which is used for page pools.
>>>
>>> Matthew Wilcox tried and stopped the same work, you can see in:
>>>
>>>     https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
>>>
>>> Mina Almasry already has done a lot fo prerequisite works by luck, he
>>> said :).  I stacked my patches on the top of his work e.i. netmem.
>>>
>>> I focused on removing the page pool members in struct page this time,
>>> not moving the allocation code of page pool from net to mm.  It can be
>>> done later if needed.
>>>
>>> There are still a lot of works to do, to remove the dependency on struct
>>> page in the network subsystem.  I will continue to work on this after
>>> this base patchset is merged.
>>>
>>> This patchset is based on mm tree's mm-unstable branch.
>>>
>>
>> This series largely looks good to me, but a couple of things:
>>
>> - For deep changes like this to the page_pool, I think we need a
>> before/after run to Jesper's currently out-of-tree benchmark to see
>> any regressions:
>> https://lore.kernel.org/netdev/20250309084118.3080950-1-almasrymina@google.com/
> 
> Sure.  I will check it.
> 
>> - Also please CC Pavel on iterations related to netmem/net_iov, they
>> are reusing that in io_uring code for iouring rx rc as well.
> 
> I will.  Thank you.

Mina, thanks for CC'ing. And since it's touching io_uring, future
versions need to CC it as well.

-- 
Pavel Begunkov


