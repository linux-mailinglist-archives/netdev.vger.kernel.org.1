Return-Path: <netdev+bounces-119895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39F957653
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343181F238D8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872C158DD8;
	Mon, 19 Aug 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrmstc5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660471591E3
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101403; cv=none; b=MGX/FTFNlHi/FlCrHsVZ7udjTp6yeZRohVMbrGAYgTyFb5B2xrwsprCaF6DPEate+XJl/aisaHqg+Rb2tmb1UYHJPIfoiwzKRgW4ug+euogndUvp7lMj75GbfKDryptiwRTNTr36k+e9L25isr+Dr9LiqG8NSX9ZqGFIqitp184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101403; c=relaxed/simple;
	bh=9Tb0kq05khWT7O94ce6l3/EAz3jdv5NQs2Ugo70A+3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLbQXNrrtvdRm3vHaIEd+66Tjg4rIIF3oObbtMAKACok60a7Nf/UFc0vhOXpx5yxL975dGi5bTbmyISCGWB9XRfEaaKfOCOhqmvT3AvSsbOMEsu+Zvd25zSAEmbPwCD7QP3Ph2d4FVwhxrx2FGs0MMS47OHbr00ppl3GP/VMIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrmstc5Z; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f8f0198beso165314239f.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724101401; x=1724706201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Tb0kq05khWT7O94ce6l3/EAz3jdv5NQs2Ugo70A+3Q=;
        b=Hrmstc5ZEIjZSCHnH0w4h8+gvZiUh4PTdd0kmZrC1K/UTqas0kKMpV9/esmLH0hyMM
         vZeYJ78eDApJr0QxRhy0lntDfclqfRygVJwyw/V8KxXrA/XrQee8g54YGB2DBXMnXAAD
         5ZzHZQTW3VoBDEwUAv0IznC4tJ/4oIMKJJLmQA1vOj9X14Fox1SyBNe9IQQi3uFpK6rE
         cotrJObhA+eJhCSWeifGdXYkkW5KPAIE5DPhTs+N95DjeBTnfIxOohzxaij/x9owhePh
         JbdQ/otZ5aBI070mYmVCRsmS7VsoQk99puw/lMgj6XE34NSwar0gEQdwEfkYhR31DSCt
         SSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101401; x=1724706201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Tb0kq05khWT7O94ce6l3/EAz3jdv5NQs2Ugo70A+3Q=;
        b=lwH6BcUHXGC6BL1tkhm5h1TNDBX55GVnPFTZJRmV48T/y005Ma0UMyGlDRAy3u3mAK
         qr6JFaPhe+5j1HwzvpVF0I/qHos/FN9xbLSG5r8vnJxsORaMjIE984icc46mUV2S5uxQ
         gA896svD1WlgMVdJ6hZMNROjvHSCDwiF+ZdJW7ErlceS0PWMsX5j1a/Om3LXaFy8vLAP
         1GtCfuqMZNZ4M5YeOoqHUYk7MIFFUGNvxcVaH0Vok2InPpoT3vqA+h4EZuYhNpavY2+6
         0ilH+Y5hCPhizCdb/rE8gkCQu1B0B14qHabWmBJvjQbv7pfV6lo/xpXX8ZoVtaPuc95q
         pO7A==
X-Forwarded-Encrypted: i=1; AJvYcCW9zzkSQiF4BVq9MGb7y8sJKBdMndK5r8574s945MI5WkHfYgqNbsLRmUHWOPYiu4Ucfg8pR6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHjTwLDJMmcy5TiAJTuSibtSJJNpnpISfLF1wHAKPMpfD8loc
	u0GVuNxoxNX2PbcXN5QsHhZcpKlEBxba2+BRC/9Npj7NHXxD67U/
X-Google-Smtp-Source: AGHT+IE5NdfDauglm2+uBOlPYEKxcKEpKcZvsV3utkV0/On4GK7OVxmR3q8XjtkIXw/33H2UOk+1OA==
X-Received: by 2002:a05:6602:15d3:b0:7fa:a253:a1cc with SMTP id ca18e2360f4ac-824f263255fmr1482192039f.3.1724101401202;
        Mon, 19 Aug 2024 14:03:21 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f3e3f2sm3336973173.100.2024.08.19.14.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:03:20 -0700 (PDT)
Message-ID: <adb76a64-18de-41b4-a12d-e6bc3e288252@gmail.com>
Date: Mon, 19 Aug 2024 16:03:20 -0500
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
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CANn89iKPnJzZA3NopjpVE_5wiJtxf6q2Run8G2S8Q4kvwPT-QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/19/24 03:22, Eric Dumazet wrote:
> On Sat, Aug 17, 2024 at 6:35 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>> The original code follows RFC 8312 (obsoleted CUBIC RFC).
>>
>> The patched code follows RFC 9438 (new CUBIC RFC):
> Please give the precise location in the RFC (4.3 Reno-Friendly Region)

Thank you, Eric,
I will write it more clearly in the next version patch to submit.

>
>> "Once _W_est_ has grown to reach the _cwnd_ at the time of most
>> recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
>> the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
>> the same congestion window increment rate as Reno, which uses AIMD
>> (1,0.5)."
>>
>> Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event
>>
>> Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
> RFC 9438 is brand new, I think we should not backport this patch to
> stable linux versions.
>
> This would target net-next, unless there is clear evidence that it is
> absolutely safe.

I agree with you that this patch would target net-next.

> Note the existence of tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
> and tools/testing/selftests/bpf/progs/bpf_cubic.c
>
> If this patch was a fix, I presume we would need to fix these files ?
In my understanding, the bpf_cubic.c and bpf_cc_cubic.c are not designed to create a fully equivalent version of tcp_cubic, but more focus on BPF logic testing usage.
For example, the up-to-date bpf_cubic does not involve the changes in commit 9957b38b5e7a ("tcp_cubic: make hystart_ack_delay() aware of BIG TCP")

Maybe we would ask BPF maintainers whether to fix these BPF files?

