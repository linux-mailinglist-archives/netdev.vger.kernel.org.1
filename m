Return-Path: <netdev+bounces-174391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2332AA5E75A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473E9171009
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE81F03EA;
	Wed, 12 Mar 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BKOYh3zK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BB1F03E4
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818349; cv=none; b=FkVh1Jm6VBmstdNuHclGyj8BkuIfXNFQ9pfMZBJAT1ERjdjsxIfu7gN4lE37Q4ZBxaDmPAsBZJZhkbq46Um7Ykme59NciDSB6fNs1goZB51FhKxJp1AKwdu6vqXdOS/IEMzhCBClCF4jekiNna1qAdMuHRRWwyvOoTz89meBOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818349; c=relaxed/simple;
	bh=AuZv26cr7lHrMbYGNJbiZ1aRWIK9hvhulDXP+/RYiNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaGxAsxkJPGRHyzr2PDRxExECChF/BU4TR9KWevWfSzu2rHEHpCwcYaYLJgdD2plR+cTYkgi1gGKrSxcel/JTOZ3w0QId9zzDGwC8MKCBf90eNKyFV4MyYihqoiZQ53UFzj/fjMncLtw8C8Q1mInzmiG1ZkJU5IhPMu34njFjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BKOYh3zK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so3120245ab.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741818346; x=1742423146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSxLEUnXDfNo3BaRJq6V3iL8+SYQQvXG3RkjMXQIopg=;
        b=BKOYh3zKjos5f8CCDTL4TNtN8m7tp8DmreXn2/JmUnVUdd/X2zvL5W95k6+raU3UEJ
         5YYCnSt28lXRXcWFQyQDUDqh/yC7V5LBecZYlAv56qpxTl/orWZmRhYqrOTudS5QlKDZ
         UNyxf03nGhJLXftHhGGLFH+fNtociRY5xw/Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818346; x=1742423146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSxLEUnXDfNo3BaRJq6V3iL8+SYQQvXG3RkjMXQIopg=;
        b=qKkQTRqHa7bJlVL0JntFe1ijkSRIg0MfI9K2/cFVjaXtO7XUxdk3a9l6zKECWDan23
         Ru+k4qlnB3uxUEHIW9CPWnLXwd0FSnFuYy/WiwEXjrTD2aHk9xLbbFwehvMlNKOVlB9v
         9N5efZVKoDd5YrNNp9EVQ0Lef2aifRIQVcKDvohMV0afGxG/JCyO5GTdZZbYfKkxJnpY
         BO08GHvNYu3U2KLfCdzdrjroKw2CLPDCwVnoZ1j/ZfuURtB7wgMHiOHFQeLLKR5ff9W4
         QPWo+xeaOcGqV32v3v2urCO2bcWMFx1AqshgbSNmxcDtkHeNvYRVP0NpGIH7QHvRFB5x
         K8Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVyiPXzZQoOFPJocX1GWECNYLR571FpV/LCDYqZgQqEiS136XW6ZGvyDd3PS2raqVkQUIvNsLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyP+egWGyOwaeRLWE/RsWTq/s5VU4yXq2x0WEve9KjPx99pLAf
	1+irDgGDQEpMp7aWdGqQSIwBwzzJK4XTU8GB2BT/i0oaFA2VZLx7rIQAdTTaSgQ=
X-Gm-Gg: ASbGnctUtXBoQsLkhGXBw/R/ne2mSgRCwgwDDIleFVGpOr7KVnbnOBIRqe7d2vdxlpn
	V3sRmi9J2H+3LOIePbxe0soNz4HkZJleTOOaUXwx2VcddU2NjgRiCqjHCiIWJJBddUUsxJZ3X2j
	7MLwhnPDSkUSyZO+0KDf3A2Oq3nCJe+CbSONHZo6nVlZHMD8ypTHUPhP8sh5Jt0/BzUAJyx5InW
	vXEZgsmB2sL4v29h5nGPRo8P+P/qx7ZbA7kMqxONfiqk3CU52gnsxFeSlBNsW4dt4JOCuylUfy5
	VUXAIjj6aVDMSVkg9E6/V5B1IET8Y/M6GkKzOu1RxA08liKJ++cv893rg5bpLMgWNg==
X-Google-Smtp-Source: AGHT+IFNcRakkZPrPnLiFi/w3gmdyjDbwaT6Q9VXreFedauQLPsD8HCejdLMRBQMfi3+VwjEEU++bw==
X-Received: by 2002:a05:6e02:1c2b:b0:3d3:d00c:3602 with SMTP id e9e14a558f8ab-3d46890f7c1mr94762255ab.10.1741818346307;
        Wed, 12 Mar 2025 15:25:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637031a4sm13552173.11.2025.03.12.15.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 15:25:45 -0700 (PDT)
Message-ID: <29f8c81f-c5c6-4939-823e-6baf2e78309c@linuxfoundation.org>
Date: Wed, 12 Mar 2025 16:25:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: Matthew Wilcox <willy@infradead.org>, shuah <shuah@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
 <almasrymina@google.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org,
 conduct@kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
 <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>
 <Z9BSlzpbNRL2MzPj@casper.infradead.org>
 <8fa8f430-5740-42e8-b720-618811fabb22@huawei.com>
 <52f4e8b1-527a-42fb-9297-2689ba7c7516@kernel.org>
 <d143b16a-feda-4307-9e06-6232ecd08a88@kernel.org>
 <Z9HY42sGyOOz4oCm@casper.infradead.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Z9HY42sGyOOz4oCm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 12:56, Matthew Wilcox wrote:
> On Wed, Mar 12, 2025 at 12:48:56PM -0600, shuah wrote:
>> This message is a rude personal attack. This isn't the way to treat your
>> peers in the community. Apology is warranted.
> 
> I apologise for using the word "fucking".

Sorry. This response just isn't sufficient.

Mathew, you know better than this to repeat the offensive word
in you response.

It is not okay to insult a fellow developer by calling them

    "speclial *** snowflake"

Please find a better way to say you don't like these patches.

thanks,
-- Shuah (on behalf of the CoC committee)

