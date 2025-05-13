Return-Path: <netdev+bounces-190174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C7AB56C4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623B23A2F39
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7AE29992B;
	Tue, 13 May 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR7DvE41"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001401624C3
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145473; cv=none; b=b2cr3d8Fd0ANusA7fHpClSPZ1YZ5NBbCPEpZloPZ97Q7AzRV+NRHFnGSBVgtvNz4/Bn/LikyXxioP+lm9gXMrKTpKzye9ROMvPx3P5ehY6s4JoSQ+4I6vJFxagRazRMIQJXVwFJrcN1YaVUbgB3IeFT8thCJ3UFaYXlj7OGhkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145473; c=relaxed/simple;
	bh=dMhILKYSEIHwx/mdATpwjbSE3Ow6CEnfwJN+q7YsI6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JUAnbwrjkm1gemaU/vBAf82NqfxWithj2fAiR6aVpt2+LxkDqhqAPwq6hBQeGeTamcG5L0vnvJKd0xWytfoQhwJgTAAzOabb3ryT6y7CmP6REJj9R+53smbrO9ZEWiOh/Mk85VwcgNh1UapDqEy+jTSGCspKu5V4cNLJueCSoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR7DvE41; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747145470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqa1cvsTPvS6tlm3MCESIGryzfRhfbWwHAtU5YB6o48=;
	b=OR7DvE41zmOgUE/dn634lzUt0kcApAaxGBbXot8IK+Sp4+tZEKUQb/G9YqD0cn+HTVhF8V
	Wld8JhTLk2ec+CbOwbSylkIFh4BnTYrpOvQThobTpDlaC0Ejy9ath+pkgEowZCm36tcCc/
	Z3uq8dVL3bd09kEjKbmPI7UpRPbLNAg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-vQb_EvUiNEGL0UTozbfiCg-1; Tue, 13 May 2025 10:11:09 -0400
X-MC-Unique: vQb_EvUiNEGL0UTozbfiCg-1
X-Mimecast-MFC-AGG-ID: vQb_EvUiNEGL0UTozbfiCg_1747145468
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a206f05150so1559205f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747145468; x=1747750268;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqa1cvsTPvS6tlm3MCESIGryzfRhfbWwHAtU5YB6o48=;
        b=WrKuiar0iUGZY3vNc6frQw6nXNRmzhl9Ieu7773KUcQFrasJeONMxFdJk8C3f4//3q
         OI1NmXGB0tkCMaHbez/ml6oBJJ7KxT+VBFuvQriZxQhymVx1+5o0DssLYNXdDLXfe337
         HL62KHcjIzoCJ44jAs+wuLy7P0Kq4KM34fmlve/SpEk9C2yMP0EIZ1joENkqFMXJq4In
         /7Pes1VBnqqulmW81QZUd2CVsm0XO6rvXwsOEKFXmtM6Unthl0pGRnuINldnRatkIVr5
         rCSmJgFiGu6OWkmFwjPElkRdg2Y8xDaOtMikw2pCbZaf6fnaGrYP5uIOwLuw1QVQ0Q1Z
         6H0g==
X-Gm-Message-State: AOJu0YzhbAfiaIBrRfiT5/IDaiLfgg+pP4oGoiY9Bk1AZvo4XvMQKv1l
	zACzhzXzSJmmkIbJg9fV7ILszEaQWc05erUPj8vt42Mcz15Hv8aBGknEv1yrG5H+esmZ+z9fWZN
	HAq85Mko6FtzXz4KvzzbxMhfqZRwqxENngo/Uu7aIQkbBWf/7qDJK+tbstAvpg4wR
X-Gm-Gg: ASbGncsl3VO8fB1LSSaf0wPcYW98oKMKlbWFgcoADTHwj9S9pOluQ/fQqa8q9d4F62A
	Em3ml6WrcXvo01xVn9F+cpBn+evaq8tW581zOcB8MGTYvlQGLPkXe8cs9TFrVO3tCOi7WL1n0HE
	4XH/kyHQmdGbE6bcOG8KpPVrFSBbuY2BiMlEPtOoj93Gq4ufnqX4h2RK/IHg9odqDOymhpp0cqs
	sWgbfbnIkZQsCtkjmK3bfbVZtRFjNmp0Y7J8hA2P82mgynb3ieQlC8eG4ooKbudWgy+HNUo0OgI
	2//xz4vroJMqTEJFLIQ=
X-Received: by 2002:a05:6000:2902:b0:3a0:b4f1:8bd5 with SMTP id ffacd0b85a97d-3a1f64576a6mr15428744f8f.18.1747145467620;
        Tue, 13 May 2025 07:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpEH3rI8DYVYs80Inn10SvbBFCTFRhKYAg9izfbQ/Ck7u/ZE2Ic1n9i1regu53SbDmRPHwZQ==
X-Received: by 2002:a05:6000:2902:b0:3a0:b4f1:8bd5 with SMTP id ffacd0b85a97d-3a1f64576a6mr15428705f8f.18.1747145467203;
        Tue, 13 May 2025 07:11:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc2esm16795931f8f.90.2025.05.13.07.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 07:11:06 -0700 (PDT)
Message-ID: <cbba5990-959b-476f-a3fd-6b346a7d58ee@redhat.com>
Date: Tue, 13 May 2025 16:11:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/11] net: ti: prueth: Adds link detection,
 RX and TX support.
To: Parvathi Pudi <parvathi@couthit.com>
References: <20250503121107.1973888-1-parvathi@couthit.com>
 <20250503131139.1975016-5-parvathi@couthit.com>
 <ce36ce0e-ad16-4950-b601-ae1a555f2cfb@redhat.com>
 <1918420534.1246603.1746786066099.JavaMail.zimbra@couthit.local>
 <1183e3e4-fa93-4fe6-bfe5-e58b7852d294@redhat.com>
 <876351908.1270745.1747138715014.JavaMail.zimbra@couthit.local>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <876351908.1270745.1747138715014.JavaMail.zimbra@couthit.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Apparently you unintentionally stripped the recipients list. Let me
re-add the ML.

On 5/13/25 2:18 PM, Parvathi Pudi wrote:
>> On 5/9/25 12:21 PM, Parvathi Pudi wrote:
>>>> On 5/3/25 3:11 PM, Parvathi Pudi wrote:
>>>>> +/**
>>>>> + * icssm_emac_rx_thread - EMAC Rx interrupt thread handler
>>>>> + * @irq: interrupt number
>>>>> + * @dev_id: pointer to net_device
>>>>> + *
>>>>> + * EMAC Rx Interrupt thread handler - function to process the rx frames in a
>>>>> + * irq thread function. There is only limited buffer at the ingress to
>>>>> + * queue the frames. As the frames are to be emptied as quickly as
>>>>> + * possible to avoid overflow, irq thread is necessary. Current implementation
>>>>> + * based on NAPI poll results in packet loss due to overflow at
>>>>> + * the ingress queues. Industrial use case requires loss free packet
>>>>> + * processing. Tests shows that with threaded irq based processing,
>>>>> + * no overflow happens when receiving at ~92Mbps for MTU sized frames and thus
>>>>> + * meet the requirement for industrial use case.
>>>>
>>>> The above statement is highly suspicious. On an non idle system the
>>>> threaded irq can be delayed for an unbound amount of time. On an idle
>>>> system napi_poll should be invoked with a latency comparable - if not
>>>> less - to the threaded irq. Possibly you tripped on some H/W induced
>>>> latency to re-program the ISR?
>>>>
>>>> In any case I think we need a better argumented statement to
>>>> intentionally avoid NAPI.
>>>>
>>>> Cheers,
>>>>
>>>> Paolo
>>>
>>> The above comment was from the developer to highlight that there is an
>>> improvement in
>>> performance with IRQ compared to NAPI. The improvement in performance was
>>> observed due to
>>> the limited PRU buffer pool (holds only 3 MTU packets). We need to service the
>>> queue as
>>> soon as a packet is written to prevent overflow. To achieve this, IRQs with
>>> highest
>>> priority is used. We will clean up the comments in the next version.
>>
>> Do you mean 'IRQ _thread_ with the highest priority'? I'm possibly
>> missing something, but I don't see the driver setting the irq thread
>> priority.
>>
>> Still it's not clear to me why/how scheduling a thread should guarantee
>> lower latency than serving the irq is softirq context, where no
>> reschedule is needed.
>>
>> I think you should justify this statement which sounds counter-intuitive
>> to me.
>>
>> Thanks,
>>
>> Paolo
> 
> I might not have been clear in my earlier communication. The driver does not
> configure the IRQ thread to run at the highest priority. Instead, the highest
> real-time priority is assigned to the user applications using "chrt" to ensure
> timely processing of network traffic.

I don't follow. Setting real-time priority for the user-space
application thread will possibly increase the latency for the irq thread.

> This commit in the TI Linux kernel can be used as a reference for the transition
> from NAPI-based polling to IRQ-driven packet processing:
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?id=7db2c2eb0e33821c2f1abea14f079bc23b7bde56
> 
> This change is based on performance limitations observed with NAPI polling under
> high UDP traffic. Specifically, during iperf tests with UDP traffic at 92 Mbps
> and MTU-sized frames, ingress queue overflows were observed. This occurs because
> the hardware ingress queues have limited buffering capacity, resulting in dropped
> frames.
> 
> Based on the stated limitations with NAPI polling, we believe that switching to a
> threaded IRQ handler is a reasonable solution. I'll follow up with the developers
> in the background to gather additional context on this implementation and will try
> to collect relevant bench-marking data to help justify the approach further. In
> the meantime, do you see any concern moving forward with the use of threaded IRQs
> for now?

The IRQ thread is completely under the scheduler control. It can
experience unbound latency (i.e. if there are many other running thread
in the same CPU). You need to tune the scheduling priority for the
specific setup/host, and likely will not work well (or at all) in other
scenarios.

See commit 4cd13c21b207 and all it's follow-ups to get an idea of the
things that could go wrong. Note that such commit moved the network
processing into thread scope only on quite restrictive conditions.
Having the packet processing unconditionally threaded could be much worse.

/P


