Return-Path: <netdev+bounces-190652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8884BAB8176
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798134C1DAE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67128C852;
	Thu, 15 May 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcMCj7gs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B32288CA8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299089; cv=none; b=YcoNGshRzxO/V+foZIuuOob2x0ZKcFb9dPSfvMTnG6FMbIv9wz17k/5+trAGCIhVIpCMfApcg07csvzSqO13uU4rF+DPX3IcM7k1Ak4pEGndbY8p3wMiOe2HM3OYC79TWKKDW5+Xi5aoi4DYvZ9oLoxTMoeAfZ82GC3BsH4YvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299089; c=relaxed/simple;
	bh=cRaLKFS/ocOSt0LrfepYH/n4LjEiQxhtD/kKJKa7j+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IOGZyYUQR7zUu7GbrmUgkc6qJQBmn25SI9dcW/AyN4/c8xuYu5EcNMnQNZhaQ30sqZnY3+sVI6ajPI67eDqDtBuXw4oLHFSRaKL6mh4KChJl4qD97CmYrQG3BbsROWs7U4Hdp4a93BaNbdu7piZ39Ymmumss6Y+uv32y7iDg6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcMCj7gs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747299086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOj3E0hi0DP4y3uOIqOU1f5cPS83JsYc9D6Xvq8dj04=;
	b=XcMCj7gsPvT4Q9y4ysmP+tcwkIWgeiwhTZ1gHJs3vyAYywDhgHJ7JnYml3Su3RITstpjWD
	+qEO92ckbJZsKjkpyGaVti5BGolpq52vU5Bo7sj/YPbdIH37KR3HdtQuO9uMjwyNWotZtN
	wspJAe7G+xBzKa1WCJxqP6YBHXcGO2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-5DyaM1WsNCec0ytQj1M25g-1; Thu, 15 May 2025 04:51:24 -0400
X-MC-Unique: 5DyaM1WsNCec0ytQj1M25g-1
X-Mimecast-MFC-AGG-ID: 5DyaM1WsNCec0ytQj1M25g_1747299084
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso3667175e9.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 01:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299083; x=1747903883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOj3E0hi0DP4y3uOIqOU1f5cPS83JsYc9D6Xvq8dj04=;
        b=GA7dBBSq1Orz5dRpUEdSSFZWK3tUSo0abicb1hBZoeZX+A9czHovcvUrbUHOoP9DM2
         JmXpOSlJjSg3kFyNRf2ASwG/AxdMr5aQhi/V3nsoeCI5NiCaANXFBQDH8veUQjZA/7rn
         nKW7pLGWMNZa4+qTIsPD8hrhaBWGJwqmdivZEtziQLPZnr7qBWZgZ7z1A6ZKekGMIWyq
         3VMqavL41K7Ktx1HMDWDGWnVe0IRXVfA/UWAy/FElf29E1rBwdfLl0pwpHwYJVmHPK6i
         Gv+/Abj2vjuQE26y2JDXCZMPt5/bB9S9Uspx3i3FgJpRvjAgoMmz6Hw1Gn8ltoAPrDnF
         Badw==
X-Forwarded-Encrypted: i=1; AJvYcCUbsDsv7DLoWvs7EyvT/CjuLGrn8k4HKTNM5JeNW3Xc8JULsWoDzx7byAVZuUi6qIqmKhkwPrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbef8SJt7qSwO1H/2D7X62VO5jQj+6zIS7TlveEmMjxvga2D7b
	K/8DjSbzAyP1FGM3uGt+5a9XQD0pu2SyqAS0kvwNZ0C5A+AZRjUAwumqH96YmKoMsMcIRev3VgC
	QV1WrND0m+GLK9teKKubL0WYfZFVcwOQGpbE4H1WOWPNwemM5APAI/pJSI1tWgxuX
X-Gm-Gg: ASbGnct2Wcl3sqTTe4EoV9uBHYObrxqY2ERuHjP70Bi8QTyhOcVf9paopl3HeCZs47i
	zQ8FSPBU+qjQflPviyYglklhc7SvWky/QsEHTIb7lToeDBOa7zfwqYkAR6IxybVMa1T1wMkGi2f
	rSjn2Gc9qf9dgh1TM8J5gxk8aDO4sBLVBoB6I8BEnc+vYqPEZDeBukszIRaQ4qS53OlbgQ+d9iM
	lvTiFwSLiKfo3VB8wX/7Ging7b0wBR/6coSppCkHE3pAlePExuIHZXmYS1kHLH5LTJocZBoIjrc
	XKkcWtZy0Wd+Up1qFdKNukcHGAfm6KsQeRTdTNzUaRBJEAMJclxsM1LknMk=
X-Received: by 2002:a05:600c:4ed3:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-442f96e6f53mr12410615e9.1.1747299083427;
        Thu, 15 May 2025 01:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1IDiAKMJgGPDA6+WopmhoDhZGpoHt2rO7LudOPFoe7c++mdWYWTOkVWXB6G/HeyCcgPa9w==
X-Received: by 2002:a05:600c:4ed3:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-442f96e6f53mr12410285e9.1.1747299083028;
        Thu, 15 May 2025 01:51:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd47d39sm59873815e9.1.2025.05.15.01.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:51:22 -0700 (PDT)
Message-ID: <44cd376a-8fee-4d82-a465-a0e80e67135c@redhat.com>
Date: Thu, 15 May 2025 10:51:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509214801.37306-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> +struct dualpi2_sched_data {
> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
> +
> +	/* Registered tc filters */
> +	struct tcf_proto __rcu *tcf_filters;
> +	struct tcf_block *tcf_block;
> +
> +	/* PI2 parameters */
> +	u64	pi2_target;	/* Target delay in nanoseconds */
> +	u32	pi2_tupdate;	/* Timer frequency in nanoseconds */

AFAICS this can be written from user-space, without any upper bound,
causing an integer overflow after converting the frequency from seconds
to nsec.

> +static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
> +{
> +	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
> +
> +	WRITE_ONCE(q->pi2_prob, calculate_probability(q->sch));

This runs without acquiring the qdisc_lock(). The state accessed by
calculate_probability() could be inconsistent. You likely need to
acquire the qdisc_lock here.

/P


