Return-Path: <netdev+bounces-183946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206DA92D28
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F198C7A1426
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAF215063;
	Thu, 17 Apr 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eK9Jbj22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB0215055
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927990; cv=none; b=sP3xrUdrLUhdE/z3+VSFFHtktr9RFPubtPejIbP0XK06iixnhtvYLc+gN8knLEr2z0K2rWdPfkgSTVZAzccl3KFTyUMelkatxdIBjsGkSa8HUUk43ypYXRf+XdvcVeSCNy9lvxMk4COzWYPl6CFv/2uccFkdYaBLruFRviletiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927990; c=relaxed/simple;
	bh=wSArtfjIVmzriW52OyQGGYrpAKNFj13MoavbhgyY7UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYSixT501wGG6AZU2/U4KMaFzMIckl5UgaQvR6f0zTX/Vx052Q+iw5yinVv49B04TVnJi9OnGKruKXpKJ8h1zI8toLblQDH+bU8tiOYKeDriXxarAMcAYjZuy/c4bFfNHDjY0dCgtzl1pHJqYB5sn7NdmowEXwFUkm1kk4OyDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eK9Jbj22; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so1158547b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744927988; x=1745532788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOVLszDddjodAbgAT9v/2dm1cgKHeU/Jr3AgP103Kgk=;
        b=eK9Jbj22+7vlYw7KsQ4r7fAFLEVBWvJZVVa/SIIuIEvOTC7Ontb0Ng9YLVrsKrTXOU
         qRlx2pV+KbX9VQycBMDJw6FXVlAp/Jb+/O9Gt9Sls07uuAdPn9loBqonbb1POpBouEXQ
         qQhslTT/Norvt1ub5VepIxj8BgPy5FbdjG0yNTmEXP4PHjjHKz5ZqWF6eJdi5zT6vlxT
         eVPTEFbfQ5R8qOFWh5FKGkOFgaILUtZLnFkYVlkz+1P0zvc1MuO+KlKxWvFH6oCpcB7A
         MA8QpC7RUdwsaSHfJ6NmhRsF7JggGsMFmp9nzaYnYKw4utGHW1Mpi/wK0kkXr+9GZqbM
         u3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744927988; x=1745532788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOVLszDddjodAbgAT9v/2dm1cgKHeU/Jr3AgP103Kgk=;
        b=MEjFldGQRGmXS/hupxUVAN6uDj6awa8ZD85xj1f5A6uMvZbZ2SjqH4/fsMPcjvCEgo
         f2XmHs7IZKSKRbGox0WgQYNqLLe/q9USEbPnBwhThXk8rzT4nOuzADStVXfS/dPScK6H
         M9/ImGc1FpdTDq5UwRThB36ItQu6jyUB+QVQ+HjkF9W9c0KRgRO/xXMbLR/Gwb1CL3h3
         ogWcLCpKE9smxU9VQ6PrUWt12NJ6DoIW1SosWN6PSATbQKEk5CmVbdzAU9wP6BQ0dNxo
         GFaxNyldNGQ3qHZO8RVIOwChy4SYQqhn74XzfOFJtaLHclOfTxDDgQn5Og/AowO4eMLD
         GDdg==
X-Gm-Message-State: AOJu0YxskxaIPD1QsOGPXRzPeqsNQNgFKx5quv4fCBCuOdUeZo5ohDAM
	9jOtcll//oaEuyOWffpwmhFxsRr3gK6jE6wbWPLdB1vMQ0B2/UVJe71leSNgSQ==
X-Gm-Gg: ASbGncs3m28Plb88hHM8Y2+teLTIyyR60b3NtJVqRUMT8cYvIj5SIHnONPmWpvYe627
	GDqkPXu0VeK8NN0TN4rGc3OWNF5cOYqZDGW2fWHHe8hHbJfPRzjJbilIVqtDuhHnKNhIj6h672U
	4g+SjD4Ld+hXw3scat35ZOS/wPjmlPaLlhjUQHTYo0mczCT9cg0ZjNdCQfxX9QOKGHC9/9JD8SQ
	bAHUTalHgwVW5aJ/EsnpRWBQdZwTFSeMZeOD1nX91ya7AQlpXKFSdQuHngeZPzxS8JjuqAP0hN0
	lFn4+JpLLo7N6bvshT/w1RIKN0pvEP+bkegTTJQMg1xkQHTZ1F8BqbnMRJqArRx15DPYRoGKE7t
	kIJInAfbszSk=
X-Google-Smtp-Source: AGHT+IGF7kAD/NpWdbBAsUKP/oYVOCuoE16wkI7E+/v7/zx/azVnBG40JcFxfVp7fEb0LC0OqkvI3Q==
X-Received: by 2002:a05:6a00:1495:b0:736:6279:ca25 with SMTP id d2e1a72fcca58-73dc15cf685mr707794b3a.24.1744927988114;
        Thu, 17 Apr 2025 15:13:08 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm388095b3a.76.2025.04.17.15.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 15:13:07 -0700 (PDT)
Message-ID: <66475f1e-fc28-4198-ab66-75d4cdb9874c@mojatatu.com>
Date: Thu, 17 Apr 2025 19:13:03 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
 pctammela@mojatatu.com, Stephen Hemminger <stephen@networkplumber.org>
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <aAFVHqypw/snAOwu@pop-os.localdomain>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <aAFVHqypw/snAOwu@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 16:23, Cong Wang wrote:
> On Wed, Apr 16, 2025 at 07:24:22AM -0300, Victor Nogueira wrote:
>> As described in Gerrard's report [1], there are cases where netem can
>> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
>> qfq) break whenever the enqueue callback has reentrant behaviour.
>> This series addresses these issues by adding extra checks that cater for
>> these reentrant corner cases. This series has passed all relevant test
>> cases in the TDC suite.
>>
>> [1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/
>>
> 
> I am wondering why we need to enqueue the duplicate skb before enqueuing
> the original skb in netem? IOW, why not just swap them?

I thought of doing what, I think, you are suggesting, but I was afraid
of breaking netem. Stephen any comments?

cheers,
Victor

