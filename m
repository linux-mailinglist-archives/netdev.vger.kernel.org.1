Return-Path: <netdev+bounces-200303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD7AE47C0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115DA18837C0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4625394B;
	Mon, 23 Jun 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wLlW136u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53C26FA5E
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690861; cv=none; b=O7ZOHBjy5UD+BraUvMf5Efs6tKT+JmRTySEHSdqYM3IDWSgrxhRptgqKGQ+/D6IZJwLfTqiGmv0lBaz6BCXdjXqTMSf4GK9p+EDCXOEFfQDERulcVAAEmJ6V5UMw7nEnb0m3fYjN8/78XjGkDy3uJTl4xaJfygZkfd5/Dyxdc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690861; c=relaxed/simple;
	bh=DWG8vtTRJO+BwOywGgWtNmxhuxvbJmczNlvdJL8Ky58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbMzqIg/PIhfvwj6SaV1wLD1kojPASW20OLEcgO26uYJa1HQHHE0hIw7BbUZ5kufzfUvyTWATDsQZI/B2M5HhqObxKnExmKRT5mqnyp14yjGQbQrf9WAxnX3F0Yy8B8r/4m7ScaF2kz8VO9t75ekrggDDfUjCGhLZMQefJ0QBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wLlW136u; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3209ce08acso1327876a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750690858; x=1751295658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Efb7h4IiluZ8rF9i5BpJjDumz0UB34EpNqVIk+T6z0=;
        b=wLlW136uAiMH7DxLLvH7WmLv1A5VP+RO7/RYN59n8y2CD5Vtlvz/e1IPQAHwHtMawZ
         Li+cnta3H1udrgJ6Bt2TLWMdSxOPwASQo+RcYHqni185Cw4j4jm3aEUMZi5oZd6E68iR
         H41iJx712BaVxL+qOE5MlMexH5sC+Zp/REquWEdMkjQvN4TgB08JD718jgLXFumeRXCi
         IZeyiEV2J2aLzVOLX8ZUnbddrjv4dR8zpXPrcNepSh4PlaRg22C7XH4PDVoSd2Vj+Hkg
         rw3+M1Ue2IGhJ89VeekClTjnE+o8zScdjouP5tCu2oAVcymsHWya2lw5sUeq5sj2w/32
         0iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690858; x=1751295658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Efb7h4IiluZ8rF9i5BpJjDumz0UB34EpNqVIk+T6z0=;
        b=ZEj0T5NZ7FqN8zTWGg6Adzw7vKYmm6JL8aIZlV9q6PIiAVH2CeS2dt3jyNnLMrO8jN
         0VSn6Jrqju3wUHK6SDJKHwRzD305Mzz+M1xoXGrep6YWSZvSz+3a5dFMbKTAXPct7Jb9
         vV7jKUdnu1Ek0BXmmQSuHdLTZQu0RYKJ0mmaOfYCea+Q8WLFu7jKKyjqUIhHqLYaPj8d
         OmYPtoLtp7iDRAaqwshEGvwO/T0W/8RWYVGj2L+EDkx5ZmDrPhzhgt3oDgxop4D31J/d
         iWsMDFl6qIsCQEVqG8qw8IBYYHFJbFi9ud5CHccNnotG+rwjt1WVLM9hk1gWWgjl7UjZ
         trjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWemovAYjL+1nBNjh09YU7AYCeliwntzES2KLebJnxvrEcdEStd00aWdXJ2vRairxeEFqdm02w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUs5ljOOXwSICn7oHe2bn0BKd9/ANdfXMDj40QxzWYKVne/4H
	ru/40zrkPBrjWs7L9btGyvufs7drBXwhGYJs0N87uazXk+MRdSdBr8zlb4pqRn9qMwM=
X-Gm-Gg: ASbGncs+bqBQWZWn9xZTSki8oJ8eXFyJaL/Yk3JltO0o4PJRXY/ifTxjcTF/upgQmE+
	IZpPWDfSkOvIwps+4hmM1E8pdBBbmHUhilSVppdTIFRmPwODPF59BzCKqUzN/jtIIwXffBIuWps
	+K3ZPPjw6HUDIhe9D25fP6Ljt7or5rwnjXtT6dE9sqpQN+FfFkzwf6CkiCqO0qgvZ/yMtlNPmdg
	0S44j0j+v4CQBIkzbzWohlP5cILJgTtXMINY3rMv/Dv2XtvABArx7I0dpic4a2mF44DENkiEte3
	psBqfxpcx3p+27p2GMzSokFjsOun0jXmpd5BfACIwRCNb0+eo9fcZyTU4g==
X-Google-Smtp-Source: AGHT+IGUUjQjuUqX05UT3HAo2u5Qjh7WVT+efnt7MqKr01cpayVTTMTARQsofUWceMLkZlA6eMUkqA==
X-Received: by 2002:a17:90b:2ec3:b0:312:1c83:58e9 with SMTP id 98e67ed59e1d1-3159d62aba3mr18008699a91.5.1750690858254;
        Mon, 23 Jun 2025 08:00:58 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315ac2991a7sm6350927a91.25.2025.06.23.08.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:00:57 -0700 (PDT)
Message-ID: <1ccc3268-5977-40e4-8790-d0fe535a1329@kernel.dk>
Date: Mon, 23 Jun 2025 09:00:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] io_uring cmd for tx timestamps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1750065793.git.asml.silence@gmail.com>
 <efd53c47-4be9-4a91-aef1-7f0cb8bae750@kernel.dk>
 <20250617152923.01c274a1@kernel.org>
 <520fa72f-1105-42f6-a16f-050873be8742@kernel.dk>
 <20250617154103.519b5b9d@kernel.org>
 <1fb789b2-2251-42ed-b3c2-4a5f31bca020@kernel.dk>
 <20250620124643.6c2bdc14@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250620124643.6c2bdc14@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 1:46 PM, Jakub Kicinski wrote:
> On Fri, 20 Jun 2025 08:31:25 -0600 Jens Axboe wrote:
>> On 6/17/25 4:41 PM, Jakub Kicinski wrote:
>>> On Tue, 17 Jun 2025 16:33:20 -0600 Jens Axboe wrote:  
>>>> Can we put it in a separate branch and merge it into both? Otherwise
>>>> my branch will get a bunch of unrelated commits, and pulling an
>>>> unnamed sha is pretty iffy.  
>>>
>>> Like this?
>>>
>>>  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git timestamp-for-jens  
>>
>> Branch seems to be gone?
> 
> Ah, I deleted when I was forwarding to Linus yesterday.
> I figured you already pulled, sorry about that.
> I've pushed it out again now.

I've pulled it now, thanks Jakub.

-- 
Jens Axboe


