Return-Path: <netdev+bounces-236257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC2C3A6BD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AC4420D0F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD32E7F3E;
	Thu,  6 Nov 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJmiFkfl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qLlj/N5l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733182BCF4C
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426331; cv=none; b=Nbu+L6DrGaE7IvYDtMKMakAkhgyQMm8g6nqkGysgrjTjf4oKaK7afSNpfuNrs70a/m6rWQKbTxshchGGe3S87tZcXH2XBd8PB+pz0BjecT9PIOTP7k1xOZzcbQkOX7xhdDR2ZL2PaVbmREwyLCxB8IXJdVUQbvmxHqi0eI1MHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426331; c=relaxed/simple;
	bh=CbdUs/iXM+Uj8KShR/tvidX/R/SmO0CllzLd05WG1KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fX3TrlZzQjWjTm9GgiJSCtPQZ2YqQNVrCHmyKi0L2FNFsOGYWNLwTgQjRNj532aJMt0ROj7Xk35mpWddDZOFhm8E4/XaG2Aw+cONVc9tNIXxvU+uyC5IeOdvok1FaoHwHAHm+PnBv+naenwyuuxiMACOb4cZnTJBgDUpocLTJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJmiFkfl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qLlj/N5l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxOJ8kBHKmhzauAwHFhr3zg25OmNAVhyQxRjdqn5gCg=;
	b=eJmiFkfl70hSum6vqxdPcoy/rgRuC6/xCZcJ/hbKrtIFhQ1iVXeHk542NohhGC/q01ayAO
	fznwtk9aTM36n3bJEWOk+NTJ4IoKjUPiNVQ7xucduwwRH3olgYMjjL6mzNnx0mBiRSHpfP
	XT7myyrXy6wvivUHdksciWgd9j5WL4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-cZk-8f4aNmavDQSzg3l3jg-1; Thu, 06 Nov 2025 05:52:07 -0500
X-MC-Unique: cZk-8f4aNmavDQSzg3l3jg-1
X-Mimecast-MFC-AGG-ID: cZk-8f4aNmavDQSzg3l3jg_1762426326
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-427015f63faso454712f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426326; x=1763031126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxOJ8kBHKmhzauAwHFhr3zg25OmNAVhyQxRjdqn5gCg=;
        b=qLlj/N5lBoRPe9hSQzYxG9/SOhuUJI5i1XtAnDGraqy9TiQxA0RWyzreEiqZUTlxor
         hCst2YAqdAoUF7ZqtKBhPEthd6Y5sQpUUg7bY+E0Nd8uROhvw0xOLYdwY2NVRI+LBkuC
         G/lnkKvc7EQ9AAWqOjYq8fH9vMVnlDXL4UAJrGOTwTp1XQI8afIS22cGsdxBKc0oKC5g
         dBmL2Gt+7eLM4gw5M+F52jxifuVOvZKukFk5rGiHTeowCOHstZiiZRqDvEPNPF7CrtLg
         R5tsmxJDzu+WsaasAaaYTqqOGrrojlC8epBVgcPM21ZzLy5Mj9qerAUKlYlwmF+rHNf/
         O30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426326; x=1763031126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxOJ8kBHKmhzauAwHFhr3zg25OmNAVhyQxRjdqn5gCg=;
        b=WmbiGRtrb0mFdHerYYjVxNUnkA2jun49zf5Dg7Cy3ZsTxkxrWG6hsfKC4nbcdpkswC
         1EsCkZqadZ4MHqGkbIb7tv3EdbBGlQAjEiSPlev8DVmluYR6XO7lFp533ResXfz2sTPy
         iBTLAKE8hJXxUIeHoO0+pYr2xWDUoNWmDLXhuobng7LT17kUcEr5j/Zbarc9XMswSmIS
         yCwlhnx+CiKRWLKUNf5wl83MXa+1eiPzkC4Ch1iRS0fQegJlwTYe2B+3GKJgGKLX6TdL
         xeOySad+lponfeyjLl98YHKUV+dXMST76hkIaovcwcTeSRa5xA6iUfKSciSBiwf0omDb
         8L/g==
X-Forwarded-Encrypted: i=1; AJvYcCVBhBr9qla6zYCE7yIM7oF7MwZIdpwCJ9PJXNXWxkLs/dZtGQ4GTRvjRAryFAJ2CB4W+3rZE98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzcCE1A+RNHcvUPLX4isGsDyDh4AtbhffZ6NNhWOOOXcnd49dP
	/z0FcBwPrVCdbnCrfPjtiHLAl8Rmn9a5WfBJCegO+0kyZBFlSHNgjhHSxOVF2n2g0nQXax4JYMr
	i3UMoPatmTMTxP+XubsQ3j4/NZu95AijEDd3e9SRArGg+JnV4ZOz2FAuaMANP/nQiyg==
X-Gm-Gg: ASbGncttNMlms+b+/dy1vAoM+D5RCqMbx2Ye+HmFCOyOe9JuxoveRjMg+n5mkqjKgDp
	10vIR4nDP28s4tgVJOgqch1mFBoBzpIRQTMjV6OmGOjxzAOS9h1CouzvjMgHswdaepTgx4LRge3
	FciKNa4AnL2CVDisfACmq7MYQpglcYtX7gLUGAyCBZcyTW0iqvezdYyi8MuK11S8rZ63X+TkM0+
	GwChSEz2uoPGnXbIHYHiLbrPqDrw9h4l3vOzetK/beRxi0kT+nNla1SC3tJn63geS4uw3hmo2kK
	SUUvnnZi246ldnA/hJdILD/ddC1T/PhLQK3JYhE8fjrY67XGAMtI1/zE8maGb0bmwX70UuRloMi
	smA==
X-Received: by 2002:a05:6000:611:b0:429:cacf:108c with SMTP id ffacd0b85a97d-429e32c4be0mr5980304f8f.10.1762426325692;
        Thu, 06 Nov 2025 02:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHqila1jvcrQqf57AY1Nt5LaHHx3HeOmGn3k/9mQ7w8szVJ5v4JMHdYk8g3JnaWmX1aJ24xQ==
X-Received: by 2002:a05:6000:611:b0:429:cacf:108c with SMTP id ffacd0b85a97d-429e32c4be0mr5980281f8f.10.1762426325296;
        Thu, 06 Nov 2025 02:52:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm4405107f8f.17.2025.11.06.02.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:52:04 -0800 (PST)
Message-ID: <4133dc32-d639-40a9-b49a-d893caae1821@redhat.com>
Date: Thu, 6 Nov 2025 11:52:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] net/rds: Give each connection its own
 workqueue
To: Allison Henderson <allison.henderson@oracle.com>,
 "achender@kernel.org" <achender@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20251029174609.33778-1-achender@kernel.org>
 <20251029174609.33778-3-achender@kernel.org>
 <0bee7457-eddc-493f-bdb9-a438347958f9@redhat.com>
 <68454b958581aa1d085678b3b6926318ee5754dc.camel@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <68454b958581aa1d085678b3b6926318ee5754dc.camel@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 10:23 PM, Allison Henderson wrote:
> On Tue, 2025-11-04 at 15:57 +0100, Paolo Abeni wrote:
>> On 10/29/25 6:46 PM, Allison Henderson wrote:
>>> From: Allison Henderson <allison.henderson@oracle.com>
>>>
>>> RDS was written to require ordered workqueues for "cp->cp_wq":
>>> Work is executed in the order scheduled, one item at a time.
>>>
>>> If these workqueues are shared across connections,
>>> then work executed on behalf of one connection blocks work
>>> scheduled for a different and unrelated connection.
>>>
>>> Luckily we don't need to share these workqueues.
>>> While it obviously makes sense to limit the number of
>>> workers (processes) that ought to be allocated on a system,
>>> a workqueue that doesn't have a rescue worker attached,
>>> has a tiny footprint compared to the connection as a whole:
>>> A workqueue costs ~800 bytes, while an RDS/IB connection
>>> totals ~5 MBytes.
>>
>> Still a workqueue per connection feels overkill. Have you considered
>> moving to WQ_PERCPU for rds_wq? Why does not fit?
>>
>> Thanks,
>>
>> Paolo
>>
> Hi Paolo
> 
> I hadnt thought of WQ_PERCPU before, so I did some digging on it.  In our case though, we need FIFO behavior per-
> connection, so if we switched to queues per cpu, we'd have to pin a CPU to a connection to get the right behavior.  And
> then that brings back head of the line blocking since now all the items on that queue have to share that CPU even if the
> other CPUs are idle.  So it wouldn't quite be a synonymous solution for what we're trying to do in this case.  I hope
> that made sense?  Let me know what you think.

Still the workqueue per connection gives significant more overhead than
your estimate above. I guess ~800 bytes is sizeof(struct workqueue_struct)?

Please note that such struct contains several dynamically allocated
pointers, among them per_cpu ones: the overall amount of memory used is
significantly greater than your estimate. You should provide a more
accurate one.

Much more importantly, using a workqueue per connection provides
scalibility gain only in the measure that each workqueue uses a
different pool and thus creates additional kthread(s). I'm haven't dived
into the workqueue implementation but I think this is not the case. My
current guestimate is that you measure some gain because the per
connection WK actually creates (or just use) a single pool different
from rds_wq's one.

Please double check the above.

Out of sheer ignorance I suspect/hope that replacing the current
workqueue with alloc_ordered_workqueue() (possibly UNBOUND?!?) will give
the same scalability improvement with no cost.

/P


