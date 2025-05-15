Return-Path: <netdev+bounces-190656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEBAB8209
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58607B1708
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02D2874F6;
	Thu, 15 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHOKPIFp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC1F09AD
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300061; cv=none; b=mjVKSdrI1HI7RYVVHRDHoUC8toRSJaactiwEKfwPn0W3moVYXERJzdP6z7LnTggyklm0QcooqHpu6pINEfuCR7lboY0vLGgLzeKyhoDRFY+oeuZ12u2JhS6mzkDLZzL4WSQ8fidvfUvXdBP9ZehgXRG+37z9K3WcIDGB/eEEzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300061; c=relaxed/simple;
	bh=Ik3I2MkzSjLoPITJGS+Lz0I4027rnhcahKmKU0rhTU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZAoVkFK5ndK/FJnjWHM64mcaofJcO05L27Uqbug4x6HETT3JR65mTMhas669mBFHD9tsAYSL4nAp2S0dVBfBzrIVDe+UdJSzsWNZ4jBEgLBvtNaX+ib/FetSS9Rg6LdxwDYGinIhD9xCqJ8ACVq2qJ7tMuoswOemqnF7l632Etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHOKPIFp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747300058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7BWWrJviHxFybRk4KEuN/3UoBAdFc9hHZEf43H00c8=;
	b=BHOKPIFp160VUDqy14VCVqc6dQ3MKEBVjB3DuaqI9gY0yRmFbtdKcJgIIw5HVJqZYPtNkN
	LQqkGXJmLiYQDrWOS6+KTYiHQ9GUh98X/dTT+dgCZLBDqzU915tenAwZoLhlvsJtnfjBfz
	apZvnfVC8vesVeP5CA51dsqwbEX+ZYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-BUkuFoJcPFSEHuhLuEgKfA-1; Thu, 15 May 2025 05:07:37 -0400
X-MC-Unique: BUkuFoJcPFSEHuhLuEgKfA-1
X-Mimecast-MFC-AGG-ID: BUkuFoJcPFSEHuhLuEgKfA_1747300056
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442dc702850so4199435e9.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747300056; x=1747904856;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7BWWrJviHxFybRk4KEuN/3UoBAdFc9hHZEf43H00c8=;
        b=NsOFEWwb6bdwDTDL/jpiVl1tq4PHLp8tIQQ34uFKb7cnXP2Akw7qYlqTIq1Vw6gng7
         PDNRpeKy3jIZKk1ZXRF0Jhx1P1R3OX/Sw+FWwA278bN4h9BvMLtc0kkYYZkuL2MN5ugN
         YbtfgJtqhPrO6Iwva/ecMa5ZFK82yjOQ60lhupVyK+JvxVc7cUps4YB9Gw9yFe9WbvMF
         T/RMpuC2n61Ez1Zv30YNMLhrQU+bOESxHccezDHlhUeH0Mvs8spzuLFd/KMwz3BJRWXV
         n6k5zl1LU1QI6PLTNeQ5/hyfXKH7mVi23uuTDySnj1kDnXmz/2L/a0std/ZC8BgVoQKq
         0/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBPKRuoKdXSKgMZm2PsjizVVOLi4vBud680pmoUxCjxupdFvG5WtOaDdNiu5Ssb2Vg9l8Tbmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNoZwtioV/jSmF5tRlJ1T1YY3UjKupnGcq6I8WrAdSmpEcR1M
	ZSnykJ/LPGdVSVL6QMzsYCNZB1ITBV87vEjphKL6wPe6EcCxfI6XtzayMM5/B/r7IZ4Bpw86HMZ
	X116DkZ/URgJVg7Rhiv0FO4anbB99VQx61uYsoiIhVyv1WCGMgxfGjQ==
X-Gm-Gg: ASbGncueCtqrrroODSPiq2yH33kFHHGbDP4DoGVm8l1L5sRMU5p9LDZ9qLwWzP++szV
	5/J2fq2ezuF2li2QZLm0dVS12kGZ/weqv/S/ipZsr13sevh0Tn70vt7qVPtd57lO5RWOKVoRi78
	LkrT3GfNJxQb7v2okiznLvut1Zb1J+JeoDjKKoKnNM0KKo6wqNv5qtLvreMG3K3ok2pRFgZ/Lhh
	zd3/ZFxDP7pm40R0yIpYwHSXJnRjqLZHcG7oIA1y9uAoYTbaOFpvbGnIrGY3n3Ezn2WPQ1Cx0q7
	9OqKD9ZqlfOjnjgDmqawbLQQYP4TTyVlyrR0sqX6UXWxHTsPl4lwbHJ73Ec=
X-Received: by 2002:a05:600c:1d1c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-442f2178679mr67983655e9.31.1747300055704;
        Thu, 15 May 2025 02:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtH0OlsI2VyfWjC+w6cgjXFzubp+EuImwpxVv6AW1/4AjSEgQ642Dr+JGZlhFvcEZbUhcT/Q==
X-Received: by 2002:a05:600c:1d1c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-442f2178679mr67983265e9.31.1747300055273;
        Thu, 15 May 2025 02:07:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690a1sm63048215e9.3.2025.05.15.02.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:07:34 -0700 (PDT)
Message-ID: <a72ac9ee-941c-4e3c-ad11-8c629ee2f480@redhat.com>
Date: Thu, 15 May 2025 11:07:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509214801.37306-2-chia-yu.chang@nokia-bell-labs.com>
 <44cd376a-8fee-4d82-a465-a0e80e67135c@redhat.com>
Content-Language: en-US
In-Reply-To: <44cd376a-8fee-4d82-a465-a0e80e67135c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 10:51 AM, Paolo Abeni wrote:
> On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> +struct dualpi2_sched_data {
>> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
>> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
>> +
>> +	/* Registered tc filters */
>> +	struct tcf_proto __rcu *tcf_filters;
>> +	struct tcf_block *tcf_block;
>> +
>> +	/* PI2 parameters */
>> +	u64	pi2_target;	/* Target delay in nanoseconds */
>> +	u32	pi2_tupdate;	/* Timer frequency in nanoseconds */
> 
> AFAICS this can be written from user-space, without any upper bound,
> causing an integer overflow after converting the frequency from seconds
> to nsec.

Sorry, I misread the time conversion (is nsec to usec). But with
unbounded TCA_DUALPI2_TUPDATE the overflow can still happen.

/P


