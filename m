Return-Path: <netdev+bounces-183643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6BA91605
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955B61887B89
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE10B22CBE2;
	Thu, 17 Apr 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHfJo7WF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01522C339
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876887; cv=none; b=gpWC73s9mBLbIzjGIgUKC5MtB1YnTvzZs5b1UERNs0g1y1ycP22CuU+DyuWdqDA+OJA1PJc6V30zyNgLbPOPjgD1uP9t4ptCT9vkYPl1P3PGkpBMwGWdOcYT+85cJzn7BWajwE6yxP2b2wwHk2sQLVvLCglNN42fK1llWIafKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876887; c=relaxed/simple;
	bh=mbIJn3m25HB/f+imm3wATVam8c+NosvFbYpGMY2/ufA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a33TRkUn9+CO3Zy7LbkHMV1anGG7YNT09ZPUyALhZasqBKyVPE0kPcvSyt+FtZfq+yOhyMh0JhRARH0fvC0VX09zTM3PbuxW5+A+1r1Nau1oZuzm6yC7uomRbmqqVsQGUIxSSP7utsv9jwnkC/Fzi5lW5MSC3zA/AD958ydLbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHfJo7WF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744876884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftRBl7J66GuD2x2LGUC/bS7+8GxCtzSAHVhHuUVU4wQ=;
	b=AHfJo7WFk7OWw33pCCiFbX6H/n+aJeXxUpE6zuy4WYN2M/5u1QqIwRJcNpXcVLYM0V2lBP
	F9XEdhP2MyP7yaZRXiB6nNi8V6NaLa0U4DIGjq55t3lKzv/YuramoAcXvaxED3M0/sao+E
	uZtD9rE3mSxz29aIZUiHQXzAd+4AlC0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-dZSDD_PWOLCOEnFsIIx-5g-1; Thu, 17 Apr 2025 04:01:21 -0400
X-MC-Unique: dZSDD_PWOLCOEnFsIIx-5g-1
X-Mimecast-MFC-AGG-ID: dZSDD_PWOLCOEnFsIIx-5g_1744876881
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6eada773c0eso15051206d6.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876881; x=1745481681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftRBl7J66GuD2x2LGUC/bS7+8GxCtzSAHVhHuUVU4wQ=;
        b=n5GZXjkof/tN3K7QhVsiztAOPfSzwabrHhXStig5FUE7uSUO4t+J3ctgbLU4w+S+Uc
         jHTZhLXn4oEJgUsuohhdrITikpr+IFZXtzIZ2hWZheqSM6JZip9EnbJ6GKLre4nx8wv0
         2q0Jtz8LIPjrHdH1qOlGDAO0xLdt4vh7HlFtOOg8ZL07H//B3B4cojs2QvZcHMBMLjmo
         mJ/qyjmQXwYkBhxAyhxMYDduJsts3n9YrFqVNmbyD+8EMLzo9uiCcVrS4oEQcLVhBuj0
         Nca5dcGFTmN50oRMffwWhIns1vxhrGJIKQFMXygLkKyPtxv8TyESgxJWk8PKRHL4eVDf
         Z+0A==
X-Gm-Message-State: AOJu0YyqRnpBjq5AY8Heb9sFh+ZrIu/OEYF/isrmSDUL0XaD94GHhzBU
	jTTcnvxWK+gOqWyUv3pTTUpK/NwRdJHQ3+cuE82G7TvBmDQAoVU5XDy4hVmgxlae4+9I/WxFfAs
	YYDBUtvMAiMPX0Q1dWPO68k1G0u8h3aNBPD+xxO5eL0GeaFFqbUQSBg==
X-Gm-Gg: ASbGnct2Rj2JJr+8ywzXFyhSLPPw34cTVq7X8KfhO+n/cYtDRpPolqzYlV+LUIfRpaR
	hLHpZWioV0eTyYcObgtRa6HCR5QTxMh6I3HduCWDBTli1N9eNRVEwqmAxN+Ef2LLPDqgXhYjmXd
	mh5L1B5QgcapMjjj41IzY6YWStfLzPLZGvPhWDYL/8FfcT7qsOAv53zHT7p9yjAwuva28ncZsCE
	+f4I1R9Sq7ZO+kJ/XtbUMIFL4O5CKO6ueI5TnteWfgXO05UF8RPNdVsU0KLtT23RdtJ6Tzergvx
	pqslXU8kOqJmZb/AeYhkzptXuHKOvXQgwQOIV8eD4Q==
X-Received: by 2002:a05:6214:238c:b0:6e8:ddf6:d137 with SMTP id 6a1803df08f44-6f2b2f391a5mr81152246d6.18.1744876881285;
        Thu, 17 Apr 2025 01:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZEExXhG3D7PDOy9wbg64kxSzVMk8qG5CEf5EbB1KnD81xALQUO7/A9SSzykTzKL1UIe90fg==
X-Received: by 2002:a05:6214:238c:b0:6e8:ddf6:d137 with SMTP id 6a1803df08f44-6f2b2f391a5mr81151906d6.18.1744876880888;
        Thu, 17 Apr 2025 01:01:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f99bsm126450786d6.25.2025.04.17.01.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:01:20 -0700 (PDT)
Message-ID: <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
Date: Thu, 17 Apr 2025 10:01:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move ovs_frag_data_storage
 into the struct ovs_pcpu_storage
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de> <f7tbjsxfl22.fsf@redhat.com>
 <20250416164509.FOo_r2m1@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416164509.FOo_r2m1@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 6:45 PM, Sebastian Andrzej Siewior wrote:
> On 2025-04-15 12:26:13 [-0400], Aaron Conole wrote:
>> I'm going to reply here, but I need to bisect a bit more (though I
>> suspect the results below are due to 11/18).  When I tested with this
>> patch there were lots of "unexplained" latency spikes during processing
>> (note, I'm not doing PREEMPT_RT in my testing, but I guess it would
>> smooth the spikes out at the cost of max performance).
>>
>> With the series:
>> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec  9417             sender
>> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec                  receiver
>>
>> Without the series:
>> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec  149             sender
>> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec                  receiver
>>
>> And while the 'final' numbers might look acceptable, one thing I'll note
>> is I saw multiple stalls as:
>>
>> [  5]  57.00-58.00  sec   128 KBytes   903 Kbits/sec    0   4.02 MBytes
>>
>> But without the patch, I didn't see such stalls.  My testing:
>>
>> 1. Install openvswitch userspace and ipcalc
>> 2. start userspace.
>> 3. Setup two netns and connect them (I have a more complicated script to
>>    set up the flows, and I can send that to you)
>> 4. Use iperf3 to test (-P5 -t 300)
>>
>> As I wrote I suspect the locking in 11 is leading to these stalls, as
>> the data I'm sending shouldn't be hitting the frag path.
>>
>> Do these results seem expected to you?
> 
> You have slightly better throughput but way more retries. I wouldn't
> expect that. And then the stall.
> 
> Patch 10 & 12 move per-CPU variables around and makes them "static"
> rather than allocating them at module init time. I would not expect this
> to have a negative impact.
> Patch #11 assigns the current thread to a variable and clears it again.
> The remaining lockdep code disappears. The whole thing runs with BH
> disabled so no preemption.
> 
> I can't explain what you observe here. Unless it is a random glitch
> please send the script and I try to take a look.

I also think this series should not have any visible performance impact
on not RT OVS tests. @Aaron: could you please double check the results
(both the good on unpatched kernel and the bad with the series applied)
are reproducible and not due some glitches.

@Sebastian: I think the 'owner' assignment could be optimized out at
compile time for non RT build - will likely not matter for performances,
but I think it will be 'nicer', could you please update the patches to
do that?

Thanks!

Paolo


