Return-Path: <netdev+bounces-120208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F7958924
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B0B1F223F7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DC3D982;
	Tue, 20 Aug 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW38f8zW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CF17BB7
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163764; cv=none; b=gihpwWR+geqx0DZvCbf04/GHS1l8sewcEwHrIfIMhZANrJXSHrGPf6N0llR+iKgNbNTlDT2WOdYQ7ZWhz4dg3JKZmJ6zxwLoG4OOCc+SyEJafgZMhrGDHDIGh+0ieTx3yfDB8d2hPPGFnWnO9ZDu2vhIzJLtfa8jiCb/vQPBrpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163764; c=relaxed/simple;
	bh=JMUhUT6W2HYaZx7JxKBEmyWn0Z0KJ0+5hlTFjYpF/fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n85PyRcdrKZnEaupXGSgnXW8cAWPY54lndpfMRmznVYWiB18QdQrXYQQAmxUhgXDUFED1VngLFbbzP4Ey8W8/2ai0ogPxWqqznZ6eCllCXKHMcxUMEi4A65vC1B8obKkiHR5ttlO4TQGo3IgJ9XPM/9QH4E2lzkp6hSLSTol9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW38f8zW; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d34be8b6dso12914795ab.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724163762; x=1724768562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjVdrNg7Szr58r06w+wCWlu6LMQmqh8/3aeMB6nMu00=;
        b=nW38f8zWapG2tu9xy7HpTE3zjH6jmtJnxqQF+EMP0PE/qwomVDoKiUW9QUAgwThiqQ
         TmnO7g/2zTuPcvYgMsUtEfWxonhGjLp1f3Ux84+oF6XOWXS36fTsYyjVWN8Zbt0fNA7+
         JWPZa9//ANcLO3W9OuKOsgoyqvjT81Bni3bv3PZ1BYCEEt14PePMfFLjkg9rjZpde8cl
         pUT+P1rFSAxljyyE14u1z/N4zpGj7QLzlPG0GNHSPALP3l3XlkM05B7itgEeWElGwsZ3
         W6+GtoE1xzj/MGEJjBfxog3Vsb2eXsTgs52OWEGY1SJ8gKhTqNqGU/P42jLnoYn1wsWp
         QfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163762; x=1724768562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjVdrNg7Szr58r06w+wCWlu6LMQmqh8/3aeMB6nMu00=;
        b=D+5cMfaY5p3Wl0YgjAfnQ4pUsfxMbVVxG+aQJLQu9k56HfA/ih3G6mpT3JI7x1Ljz/
         EpZUDzzWX9fUOGLsHrvsnKMSjb6GDLM8hcmDRR3VqH/7iWDkYpjAsI8JoyFKd5Fk6Y18
         EjFUZ60g8XKgK1scIFNOBrj17kpVz9K/dTeIx6KPZO8zUKmNq7ySgT9J4ozuoj9Hcz5t
         JWAYBIzy8YaI/fEtHcn/FDFceFNUU+btBzwmyn5lTb1PUXyf76Uy6nhcrexze2xcwJ1Y
         2cjf3gnpYKW2AtUWgMwt7sRmp8HoZ1LBtIB56FDa2whB2zrhDVDThQVJVX61E1JfN+sf
         wViA==
X-Forwarded-Encrypted: i=1; AJvYcCUxtjNtqZwKA4dVZAn0b/NX8Rux8Mm1PMGrsmaMVcoZN9vpq/mJZaRtzz89I+bzHWudPSSYrCO5lrGSbrXvlyo2UgtctgTB
X-Gm-Message-State: AOJu0YyBvTz3srrvjTaUPcOXNagLTYBgXbksoEmtcoUjfBbun6hC+56a
	/3s0NV+pAex1nDnmRcEXNSTilNHjfp1oWQ99lzzFSszesISU/+IiidflmYWH
X-Google-Smtp-Source: AGHT+IHsa3823H+36cr7fd+qRms8BldfcV04/eLtJa70Wsi2Wuz+4U89PBeEAmZqoWdYmCwKvrD+2A==
X-Received: by 2002:a92:c56c:0:b0:382:b82b:6e48 with SMTP id e9e14a558f8ab-39d26cebbaemr162310435ab.9.1724163762233;
        Tue, 20 Aug 2024 07:22:42 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d3bec1eb0sm22890125ab.49.2024.08.20.07.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 07:22:41 -0700 (PDT)
Message-ID: <24111cde-89e3-4629-af64-a2a7738caa8f@gmail.com>
Date: Tue, 20 Aug 2024 09:22:41 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/3] tcp_cubic: fix to match Reno additive
 increment
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org,
 Lisong Xu <xu@unl.edu>
References: <20240817163400.2616134-1-mrzhang97@gmail.com>
 <20240817163400.2616134-3-mrzhang97@gmail.com>
 <CANn89iKPnJzZA3NopjpVE_5wiJtxf6q2Run8G2S8Q4kvwPT-QA@mail.gmail.com>
 <adb76a64-18de-41b4-a12d-e6bc3e288252@gmail.com>
 <CANn89iK+d65eT3sP8Wo8cGb4a_39cDF_kHG=Fn5cmcv93gzBvg@mail.gmail.com>
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CANn89iK+d65eT3sP8Wo8cGb4a_39cDF_kHG=Fn5cmcv93gzBvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/20/24 07:56, Eric Dumazet wrote:
> On Mon, Aug 19, 2024 at 11:03 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>> On 8/19/24 03:22, Eric Dumazet wrote:
>>> On Sat, Aug 17, 2024 at 6:35 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>>>> The original code follows RFC 8312 (obsoleted CUBIC RFC).
>>>>
>>>> The patched code follows RFC 9438 (new CUBIC RFC):
>>> Please give the precise location in the RFC (4.3 Reno-Friendly Region)
>> Thank you, Eric,
>> I will write it more clearly in the next version patch to submit.
>>
>>>> "Once _W_est_ has grown to reach the _cwnd_ at the time of most
>>>> recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
>>>> the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
>>>> the same congestion window increment rate as Reno, which uses AIMD
>>>> (1,0.5)."
>>>>
>>>> Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event
>>>>
>>>> Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
>>> RFC 9438 is brand new, I think we should not backport this patch to
>>> stable linux versions.
>>>
>>> This would target net-next, unless there is clear evidence that it is
>>> absolutely safe.
>> I agree with you that this patch would target net-next.
>>
>>> Note the existence of tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
>>> and tools/testing/selftests/bpf/progs/bpf_cubic.c
>>>
>>> If this patch was a fix, I presume we would need to fix these files ?
>> In my understanding, the bpf_cubic.c and bpf_cc_cubic.c are not designed to create a fully equivalent version of tcp_cubic, but more focus on BPF logic testing usage.
>> For example, the up-to-date bpf_cubic does not involve the changes in commit 9957b38b5e7a ("tcp_cubic: make hystart_ack_delay() aware of BIG TCP")
>>
>> Maybe we would ask BPF maintainers whether to fix these BPF files?
> We try (as TCP maintainers) to keep
> tools/testing/selftests/bpf/progs/bpf_cubic.c up to date with the
> kernel C code.
> Because _if_ someone is really using BPF based cubic, they should get
> the fix eventually.
>

I got your point. Yes, we should fix those BPF based cubic files if this patch was confirmed.


> See for instance
>
> commit 7d21d54d624777358ab6c7be7ff778808fef70ba
> Author: Neal Cardwell <ncardwell@google.com>
> Date:   Wed Jun 24 12:42:03 2020 -0400
>
>     bpf: tcp: bpf_cubic: fix spurious HYSTART_DELAY exit upon drop in min RTT
>
>     Apply the fix from:
>      "tcp_cubic: fix spurious HYSTART_DELAY exit upon drop in min RTT"
>     to the BPF implementation of TCP CUBIC congestion control.
>
>     Repeating the commit description here for completeness:
>
>     Mirja Kuehlewind reported a bug in Linux TCP CUBIC Hystart, where
>     Hystart HYSTART_DELAY mechanism can exit Slow Start spuriously on an
>     ACK when the minimum rtt of a connection goes down. From inspection it
>     is clear from the existing code that this could happen in an example
>     like the following:
>
>     o The first 8 RTT samples in a round trip are 150ms, resulting in a
>       curr_rtt of 150ms and a delay_min of 150ms.
>
>     o The 9th RTT sample is 100ms. The curr_rtt does not change after the
>       first 8 samples, so curr_rtt remains 150ms. But delay_min can be
>       lowered at any time, so delay_min falls to 100ms. The code executes
>       the HYSTART_DELAY comparison between curr_rtt of 150ms and delay_min
>       of 100ms, and the curr_rtt is declared far enough above delay_min to
>       force a (spurious) exit of Slow start.
>
>     The fix here is simple: allow every RTT sample in a round trip to
>     lower the curr_rtt.
>
>     Fixes: 6de4a9c430b5 ("bpf: tcp: Add bpf_cubic example")
>     Reported-by: Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>
>     Signed-off-by: Neal Cardwell <ncardwell@google.com>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
Thank you for pointing out this patch as an example.

