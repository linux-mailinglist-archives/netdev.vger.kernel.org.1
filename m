Return-Path: <netdev+bounces-129938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A129871D4
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988DC2899FD
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13A1AD5DE;
	Thu, 26 Sep 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAaHI01v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E91AD9EC
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347414; cv=none; b=u4fFf5b2Fd5Gj9fYKGfqYajTr8x7SY1XW4pbnlCTTvd9CRcxaBrdcGxResOlTfPrSefohiX80s1H0lcnELOolET0WM70i9RoCv0o42rXnT0j3v9O6UqgLlprMBH78wDocskyqsc8mYKKDJat1K6WH/LKXYERAcwnTBG19RtFUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347414; c=relaxed/simple;
	bh=5Gakt2DoJ4z1UuRlr/M2fgCvIvW1bB1P+wsWFM/1UXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rePV/yfgU/dRaproCXIjVK/eetrDFzz1b8qOpJbr7fJn7AKl6VryV/XfqM4nK/idPD1YpPXnOb/x19BTRWLKM4EfEYudXM7jo4g9f2YRUj/0umGc9FSPXO6fkUyPzgvy+itu+LHoJw18Kw5TY7eob9UJxJbMtlQMQPG2FCXn7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAaHI01v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727347411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgJFx8nZqn+WqDlfG0TuNzZ6hrFBH4AJtRN/e2xgEmY=;
	b=TAaHI01vKsxo19iAEtSxrV81/N+DNvrM1n1weRfYbszNyYEwfROk32BwHetb020hLCV2/K
	dJj4Txsgn9Vcoas8CzV3qacorQ/pH1WNw7Rz1SVqfmVse96c2g6JOaXQko9lZ3XjighSTB
	sPLKxGjl7wXEPHWEAzjx2Z78630WKFQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-j2SYXcfnP6umT0mJz4D96g-1; Thu, 26 Sep 2024 06:43:28 -0400
X-MC-Unique: j2SYXcfnP6umT0mJz4D96g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f789363755so6235811fa.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 03:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347406; x=1727952206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgJFx8nZqn+WqDlfG0TuNzZ6hrFBH4AJtRN/e2xgEmY=;
        b=fmO/RgPAvPtysqxvV2GyMgKoJN9HLmKupozALoVdrPmH1mh5IUDLmd1Q9man/pIuPP
         ooKubiB9dmC9P5Vel+8zUVCwpecpLBdKbX01zKCxCqag057VrhbG8m+gER6MDn3i/pXo
         u2RUI5rzcSgfYePmVY8lwyeGYZo8g6PgOa5LN9MD0R78DFg1kchvuPtCok9AZayrMkkS
         IVs3grs/1uveHtnjEovj8qE5cgH3rvJR0XQQwVWjk8WRQECcBy0u8/aL/fAFSdVZH8vJ
         Q4bKH7csp9cxp+wJURSI1+tF25Knlln0ufiUODscjd/izMJbEdqDW4TJjJLjQnPgi/FD
         94dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9tqV6Pchu9XY/HzWCssm34+Sa9EEN/ZNvSUbplJ6w+tSEB1+AwiOQsz6wLCqJp9J0pLsm02Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cmEsRA1vLP+/aZgYnqtZe5bN2bEt5nGWEm4uWY2i6ougS8Cc
	s2hKgAlRrQqQIp8DDr7tv6fdLCIFr8bue/n5AZrZg6i+CmZhyy71GpDTBGbLJL4xnG4XmSQRAfU
	p/YMczO8R4D2EZE3SJP70sC29Gtb42kemn6jkTUOjw6sjxk/cQt1Ytg==
X-Received: by 2002:a2e:4602:0:b0:2ef:2e6b:4105 with SMTP id 38308e7fff4ca-2f91b25afe5mr30703611fa.34.1727347406415;
        Thu, 26 Sep 2024 03:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL/PYxkjSU1JsKxYIpPrTXtY7FH9B3Um4PVDhdD0TzBbEadjJ07Xh+OZpgtn7pXCfi6/oLsg==
X-Received: by 2002:a2e:4602:0:b0:2ef:2e6b:4105 with SMTP id 38308e7fff4ca-2f91b25afe5mr30703511fa.34.1727347405828;
        Thu, 26 Sep 2024 03:43:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a168bdsm43512635e9.37.2024.09.26.03.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:43:25 -0700 (PDT)
Message-ID: <ba889ffb-ba6f-450a-be9b-9fa75b20ee86@redhat.com>
Date: Thu, 26 Sep 2024 12:43:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/14] Netfilter fixes for net
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com
References: <20240924201401.2712-1-pablo@netfilter.org>
 <c51519c0-c493-4408-9938-5fb650b4ed8b@redhat.com>
 <20240926103737.GA15517@breakpoint.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240926103737.GA15517@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/24 12:37, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>> On 9/24/24 22:13, Pablo Neira Ayuso wrote:
>>> The following patchset contains Netfilter fixes for net:
>>>
>>> Patch #1 and #2 handle an esoteric scenario: Given two tasks sending UDP
>>> packets to one another, two packets of the same flow in each direction
>>> handled by different CPUs that result in two conntrack objects in NEW
>>> state, where reply packet loses race. Then, patch #3 adds a testcase for
>>> this scenario. Series from Florian Westphal.
>>
>> Kdoc complains against the lack of documentation for the return value in the
>> first 2 patches: 'Returns' should be '@Return'.
> 
> :-(
> 
> Apparently this is found via
> 
> scripts/kernel-doc -Wall -none <file>
> 
> I'll run this in the future, but, I have to say, its encouraging me
> to just not write such kdocs entries in first place, no risk of making
> a mistake.
> 
> Paolo, Pablo, what should I do now?

If an updated PR could be resent soon, say within ~1h, I can wait for 
the CI to run on it, merge and delay the net PR after that.

Otherwise, if the fixes in here are urgent, I can pull the series as-is, 
and you could follow-up on nf-next/net-next.

The last resort is just drop this from today's PR.

Please LMK your preference,

Paolo




