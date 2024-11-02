Return-Path: <netdev+bounces-141186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79269B9DFC
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A01F2207B
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A314F9F3;
	Sat,  2 Nov 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTjfl0/t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA56155336
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730537371; cv=none; b=YxXDoUamBqzWrdXLnoQ3MaD53XlHRQrdQGYzQSVoWCAVMszCeZ8tcLiBNeTtReADxVqGUu2SlJ8HGnILZbVZfSqh+lXTJBIPX2WW6vcU+PTXy1o+4U4l5coso5xFaLiTdOKUZL4GFsS3YKO+btfxvp/uVMyFMjINTz+8QlZ+nqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730537371; c=relaxed/simple;
	bh=TkXP/cpJPOoj9LYdp1iBbWo8Xo1nzK3OzNqjR58yWVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV3nLphrMcMYc+LCapIRrQfaTUT/j9fGZkNRH+h7a+emUSQm8YnR8TIX0LGQZ+ATSiAxfyzaxRmzgg2E8AyURKxndvL3x54kiHLkiI98xQQL1m78HvA/QZSkKzE7lM7vBjw5o64rhDKQ4Pm5KRca5onIya7kqgpghS4IdVA+ScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTjfl0/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730537368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q70AFy3BRDCTA52EifChE7qnVGXhJX/bCjYQddkFvAo=;
	b=ZTjfl0/tNsv4RCdukQGBZDIFaUIcOdRrLhUhw8hJ0+d46wwby6Q1f6B8zZJFQhfDWMR9Lb
	Wv2KzznOmVAP9mqjRNJnYwVv8Q8rC+v0d2a5jw7u1hMFMImduEbvCzrEz1OPUPS92eNxwK
	r+EYeKof0xkGZiEVo0pxy1nOj+JWeu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-XyfACOrSPkapBRifYZb5pA-1; Sat, 02 Nov 2024 04:49:27 -0400
X-MC-Unique: XyfACOrSPkapBRifYZb5pA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d56061a4cso1266989f8f.2
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 01:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730537366; x=1731142166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q70AFy3BRDCTA52EifChE7qnVGXhJX/bCjYQddkFvAo=;
        b=EUvJLm6aCh3HKddES+0Tzk0O5dfoJQPIZQYeVaKoLYvSm6uxGs9ZgIxg2Kuj/BGu/d
         0+/mMxAAGZV5mparMBlPgA+a9fWMBuoAe4KDVEAvwIJYd3Xb5I7qyguFs6L1p7DTmWqJ
         GzEe9C2DNwC9f9K3XhB1t0EWi6fDzpY2A/FSNa8BxjRhQMRVN180fGIJt95MOTjfGrEH
         eBBl7TRaNEA/b1RB6k7CF671gKmU+0sEpUTvEXnOGZzGBrec60PILn7ULPzInFHrVdV9
         QGAldntoC74veD3nuHGRqwF5koxQqZDmnDYrTuxZG/YJhtp69L/KyjjoiAHchK4jAsXy
         T5aA==
X-Gm-Message-State: AOJu0YzcnHAkrgQWHlI/4rYP4t1H6XA9Z0ztRQo7R6McQU1YjLLGQznm
	BMOk11XSyC8If87ZSeXHNiMPcJ925+yAro88qY1o0BcE+4oAB9incOoHlQ+NyG+21Tr9TgKApc1
	h29M1L5vCZLfM3f/dpZfVNdMiA1bi1+7YXS1+FQP6WbsBGHaEGVrVonVMt33elnfq
X-Received: by 2002:a5d:58d4:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-381b70f070amr9224345f8f.41.1730537365767;
        Sat, 02 Nov 2024 01:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+zLUnEC74BdsijZOr1b8YSLU7XQEs3dlPvpmKeaA99iIyoGz58ANXOMvTYvZenuUsyCqfxw==
X-Received: by 2002:a5d:58d4:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-381b70f070amr9224329f8f.41.1730537365402;
        Sat, 02 Nov 2024 01:49:25 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c13sm7598384f8f.13.2024.11.02.01.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 01:49:24 -0700 (PDT)
Message-ID: <141acc87-19a4-44b5-a222-3f159835c711@redhat.com>
Date: Sat, 2 Nov 2024 09:49:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
To: Vladimir Vdovin <deliran@verdict.gg>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 idosch@idosch.org, edumazet@google.com, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org
References: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <20241101104922.68956-1-deliran@verdict.gg>
 <20241101064511.1ef698db@kernel.org> <D5B0U1C0N9JC.3PXNVEEH12786@verdict.gg>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <D5B0U1C0N9JC.3PXNVEEH12786@verdict.gg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/1/24 18:34, Vladimir Vdovin wrote:
> On Fri Nov 1, 2024 at 4:45 PM MSK, Jakub Kicinski wrote:
>> On Fri,  1 Nov 2024 10:48:57 +0000 Vladimir Vdovin wrote:
>>> +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"
>>
>> This new test seems to fail in our CI:
>>
>> # TEST: ipv4: PMTU multipath nh exceptions                            [FAIL]
>> #   there are not enough cached exceptions
>>
>> https://netdev-3.bots.linux.dev/vmksft-net/results/840861/3-pmtu-sh/stdout
> 
> Yes it failed in V4 patch, in this V5 its already ok:
> 
> # TEST: ipv4: PMTU multipath nh exceptions                            [ OK ]
> ok 1 selftests: net: pmtu.sh
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/2-pmtu-sh/stdout
> 
> But in V5, there is failed test, not sure that this patch causes fail:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/31-busy-poll-test-sh/stdout
> 
>>
>> Also some process notes:
>>  - please don't post multiple versions of the patch a day:
>>    https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
>>  - please avoid posting new versions in-reply-to the old one
> Thanks, will keep it in mind next time, sorry for my ignorance

Some additional notes:

- please do answer to Ido's question: what about ipv6?
- move the changelog after the SoB tag and a '---' separator, so that it
will not be included into the git commit message
- post new revisions of the patch in a different thread

Thanks,

Paolo


