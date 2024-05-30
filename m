Return-Path: <netdev+bounces-99560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC88D54A2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9304FB231EA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9715886D;
	Thu, 30 May 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AYHdsBGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753918756D
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104886; cv=none; b=oAT7Dlcm/wKe24gctlEkdYvGUpEZeaAcJyXB5c7G1A4u6YI7UmaozKg83Vn0fsDZDRgXPQAUXdakQmPuLFW2awNFH/PBrIA5uFyVOHJBJx6PNq4zwZGsaT40Ij9CAFLcm+bu+cmUfLaivVIefQ3a7CkC2o0HQqUDcoIN5F3G5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104886; c=relaxed/simple;
	bh=xQf3+db6goqW+mpmc7MT050eItGsukw/bLM83pJIUQI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VrNSEvkMDEabHefB4KBMtubJ1MHFTNroU3WLprLYNSlE2rOXxxV6+QTSwtX9ajwp2BPDs+GePKmCQ+E9fk22VkYVnRs/ivQ41VQ85qvB3QAC6e+YXg2e1KlCTEDY0s2reyC7YCbG3ROzV1LwFhxM+NHcNgoBeLlaChrBmwVf8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AYHdsBGV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42121d28664so13708575e9.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717104883; x=1717709683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y9iF7yZOVexA2PTNdZtyuxTvN7QgJb8qCnOyjtizDcg=;
        b=AYHdsBGVv6yHaR00mSoJB1lBm2L6MBne60u9VrsdVvFyCC1Rqj786mMcJwZlX2ayrl
         yOOuDCvmoXwY0oDhrg/GWD1/NbS4TO9GwfrWhw6k3HGYBXEZ3FPrtoEaTu5T9r/cd6k+
         5bIXRSVIfmNMHNaL0OGV4+8TMC3n61PHmaraz7MGNAOJzs0Hmoxg44o7qrssvMAOiENc
         4nm47D9TjwuC3BCY5X3FtRvGr2rnq2/UgTeGmc0riPYT/RlD4lSOve1qWJYRzcg32AnZ
         PruhqzHnLsAt0CQuCiEDDoO0UIvw0vZEq+OKGByuL566k2vd2jq4BNBKsDJehs+NiaeH
         5lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717104883; x=1717709683;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9iF7yZOVexA2PTNdZtyuxTvN7QgJb8qCnOyjtizDcg=;
        b=eZg5K8qkMhm5fKmqs+QC+ZBXpAb/hXGLqLF0eGuc2KEP/bevK1wvbZaIsbSB+hztJT
         hefDZKIyRi7wEwK75kwtL7yQSq6EI1ScioKxP3i8aF4gQ5svkehEOvPTBiDxpbpu+ho6
         Ucs0rK6to5HR3MTHZvBhk37I2zQ7b6rhp4gc7uP5mGqWkaXCG/ag846zOo9SWNpwWUYQ
         BpMj1pOXMxBEnxpfDRUu4brZ9bFTr53FY1xDZnWsENP3JUNbT/uwelTlBLXLCXCpL3RN
         waUUSZhxgt1jUuVIcV7hNThsLfAjAe3IEybu8Z7Oqsw+45nlyQsDD/6iQiMbVDQaP9Qv
         PSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAdP4K5STGwn+gTd7AOqnB/+QoWMP0rXOcrob5SuP6hK6Db42saU6LUiAREKjzoryOCeMxLjLHel95CMOxGqfr6LiDPlZn
X-Gm-Message-State: AOJu0YzfHYSNsMOhKK7i/conkfrwVanEeNky140PeqqBAsRSCCERZlOf
	fBOpHfuuqKRL+xf+9W7t2pFZevb9k6OHqES1zGJKSx6M3yaLfsL+FdgsGxhzZk8=
X-Google-Smtp-Source: AGHT+IF/qY9sf2iRdrWElnw0VkO2r3K3lbTeB08MGHEPDhfPwNNCWb2YoF/RhIb237odOSSc5QIx7w==
X-Received: by 2002:a05:600c:4f82:b0:41b:d8ef:8dcd with SMTP id 5b1f17b1804b1-4212e0ade30mr202165e9.28.1717104883354;
        Thu, 30 May 2024 14:34:43 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-25-143.comnet.bg. [109.160.25.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85c8fsm17133266b.183.2024.05.30.14.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 14:34:42 -0700 (PDT)
Message-ID: <b4818488-a315-43bf-86bc-85cd6b854f0a@blackwall.org>
Date: Fri, 31 May 2024 00:34:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Allow configuration of multipath hash seed
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
 <878qzr9qk6.fsf@nvidia.com>
 <a9a50b48-d85f-4465-a7b0-dec8b3f49281@blackwall.org>
 <4b67d969-b069-4e1a-9f09-f0308a25b03b@blackwall.org>
Content-Language: en-US
In-Reply-To: <4b67d969-b069-4e1a-9f09-f0308a25b03b@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 21:07, Nikolay Aleksandrov wrote:
> On 5/30/24 20:27, Nikolay Aleksandrov wrote:
>> On 5/30/24 18:25, Petr Machata wrote:
>>>
>>> Nikolay Aleksandrov <razor@blackwall.org> writes:
>>>
>>
> [snip]
[snip snip]
>>>
>>> I kept the RCU stuff in because it makes it easy to precompute the
>>> siphash key while allowing readers to access it lock-free. I could
>>> inline it and guard with a seqlock instead, but that's a bit messier
>>> code-wise. Or indeed construct in-situ, it's an atomic access plus like
>>> four instructions or something like that.
>>
>> You can READ/WRITE_ONCE() the full 8 bytes every time so it's lock-free
>> and consistent view of both values for observers. For fast-path it'll
>> only be accessing one of the two values, so it's fine either way. You
>> can use barriers to ensure latest value is seen by interested readers,
>> but for most eventual consistency would be enough.
>>
> 
> Actually aren't we interested only in user_seed in the external reader
> case? We don't care what's in mp_seed, so this is much simpler.
> 

Oh, I misunderstood you, didn't I? :) Were you talking about
constructing the siphash key in the fast-path above? If yes,
then sure it's a few instructions but nothing conditional.
I don't think we need anything atomic in that case.


