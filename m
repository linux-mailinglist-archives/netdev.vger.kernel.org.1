Return-Path: <netdev+bounces-205441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DDAFEB53
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2665D5C0544
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9D2E7BA8;
	Wed,  9 Jul 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1firUzt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D42E7640
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069470; cv=none; b=nee+ATar33z7JDY/QknCWNUaJP06a63NXROO36lHfwZaa2ZWmgWbONQqGfJcBDbgtLJFqhHoOkpFw87ekRMIP4X/oDu4S7p/5j3RovWnoDO6DXvxFaLZS1MhXKEXChQeHChVd2qp9kaSvq+LpYJe2S4c4Gi2s6xJ7yFo1QL27j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069470; c=relaxed/simple;
	bh=aciBxMorgcnxml2dz0hEXnAFfDQ4Hq6ZDMSr0RlpZOc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UT4QX2hWig2LfUCd19r0dM3SYkhIxCXhan1VYLR+LumcKWPDEQKohihh9Dm4YivWud1Iw9bijUWEVijoUlmY/n2pdw6YMqxFZZhDrpWY5GAhO3gZsaMxZKIdRCevkzl5ATbBXwvTeP0OegiupyOeIpBAQZPh96+iO1cD356ZAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1firUzt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752069468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OqCYNbHde+oj8u7v3nO86EHv4Rdw2RpeFK65Esh3UY=;
	b=d1firUztnNicBOAdSaLaOrXxoYERaxQ+TN8GuoJcGNvXIH/7c4F4scOkYpj0eNI6lh8ral
	yFKdU05CtTrAFUF8HU2SWbzyRcPbOB7vThBIH5wYhwqt9peSITm0F7ZO4/zocP8DPvttwK
	x1h1iKupnJteZOhS5Y+cKWtxwUXhu5A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-5e_autBhNMOHT0JTMl42aQ-1; Wed, 09 Jul 2025 09:57:46 -0400
X-MC-Unique: 5e_autBhNMOHT0JTMl42aQ-1
X-Mimecast-MFC-AGG-ID: 5e_autBhNMOHT0JTMl42aQ_1752069466
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb5f70b93bso91755986d6.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 06:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069466; x=1752674266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OqCYNbHde+oj8u7v3nO86EHv4Rdw2RpeFK65Esh3UY=;
        b=eEPBh6A70lCdSUTvZ5T8gup20jxlnGa4hPdTkzT2e+avWIwE2IVr95HWijLAUuJuz5
         hbchwNBoq1FkF4a57RYaBhuG7rcs6g2vI2YcZxDLaLhRdikBMVc8EI0mweVYvh4l5fzg
         SXhJJEgbjx3bqfRFgPUb7HaXE2UrFMxX3kjeYWEsoD/NbpAxQ3DKNeLECMj78sexkqmp
         QuyzY7VEx+DJ+X7UiaC+7IEzFCKrXyFYay9j+CKYETkcz+6AJ5fZ8YAcjI2O3AUTS1W2
         ggLxWe9WSQcvfFeBrNTgZKLJeF2GKrbX7xKZ97G6GjItap0VA+T9ndKJfFg6K9hRjGv+
         N7nw==
X-Forwarded-Encrypted: i=1; AJvYcCUbIkq7psVJu18qpsLevxSi0dkGdnkzK3M2K37aLGJhz0GPIC2MwVFYy5iK/LCFvIZ6SX4vEPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYfKlFv5RTkgKnxzqUfmSKHKRGD2hh02r1EEKfnIarNhKrwIQ
	MBlvLmAdb/R/jboDDKqYK2icnaE5C8wtBA/eM7YIC/LMX2tGY6Ob2ZIdCskMr3bKfyKTv/Gy9IH
	9PeIy5n3o++Z0zKo3SNfrCrc8WEjilOzOLcXfIGwLJAYE6lFQTA0FcBZbFw==
X-Gm-Gg: ASbGnctjzhC/YWko+QHak5YBdW78hoqSqVTML8Z1uZ5/Wc1+Qi1/gEnT8F1ppxKhqWd
	P6T0hAyklzPpE7jwbCRquqDia9E3WYnHvd90zQwx8eRy3oC5vuuFXmWPLH3N5Tm0QFz1tqYjLCP
	BwUkc9ijabz7pPhxeG8qAkAyny2kbCM4HWDS/7mqQaUcLeT1c34NvxhcOdOGtVi+pb/xWvQh63y
	+d0jfwFAis/NCGG8zwPWRMKnhKOvsLdeK4OLCGLDi8p49l1eaL0OTjh2t8PxUrQKnpqjkBIam2A
	IdYmcqJNnNEcGBW/ML4vG9urv2YTI3gaSg3LxriWlEGzixjEkXv1tNaCgTVMpa26Sdxj
X-Received: by 2002:a05:6214:5f0a:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-7048b84f81fmr47113366d6.19.1752069466278;
        Wed, 09 Jul 2025 06:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcAp3iZpe0X7o1M9/EPYvjmMQs313LShghAvdJjRZHmp4+jzUA1+znSQ7TVfsCLnAaxXLSKA==
X-Received: by 2002:a05:6214:5f0a:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-7048b84f81fmr47112836d6.19.1752069465726;
        Wed, 09 Jul 2025 06:57:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd6b5sm92513406d6.49.2025.07.09.06.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 06:57:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <798d0707-8f05-4ffd-9ee5-7d3945276ee8@redhat.com>
Date: Wed, 9 Jul 2025 09:57:44 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
 Erik Lundgren <elundgren@meta.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <aG49yaIcCPML9GsC@gmail.com>
Content-Language: en-US
In-Reply-To: <aG49yaIcCPML9GsC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 6:00 AM, Breno Leitao wrote:
> Hello Waiman, Boqun,
>
> On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
>> lockdep_unregister_key() is called from critical code paths, including
>> sections where rtnl_lock() is held. For example, when replacing a qdisc
>> in a network device, network egress traffic is disabled while
>> __qdisc_destroy() is called for every network queue.
>>
>> If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
>> which gets blocked waiting for synchronize_rcu() to complete.
>>
>> For example, a simple tc command to replace a qdisc could take 13
>> seconds:
>>
>>    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>>      real    0m13.195s
>>      user    0m0.001s
>>      sys     0m2.746s
>>
>> During this time, network egress is completely frozen while waiting for
>> RCU synchronization.
>>
>> Use synchronize_rcu_expedited() instead to minimize the impact on
>> critical operations like network connectivity changes.
>>
>> This improves 10x the function call to tc, when replacing the qdisc for
>> a network card.
>>
>>     # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>>       real     0m1.789s
>>       user     0m0.000s
>>       sys      0m1.613s
> Can I have this landed as a workaround for the problem above, while
> hazard pointers doesn't get merged?
>
> This is affecting some systems that runs the Linus' upstream kernel with
> some debug flags enabled, and I would like to have they unblocked.
>
> Once hazard pointer lands, this will be reverted. Is this a fair
> approach?
>
> Thanks for your help,
> --breno

I am fine with this patch going in as a temporary workaround. Boqun, 
what do you think?

Cheers,
Longman


