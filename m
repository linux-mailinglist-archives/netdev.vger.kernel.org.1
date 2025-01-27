Return-Path: <netdev+bounces-161056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5AA1D0B0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2BB3A637C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A016CD1D;
	Mon, 27 Jan 2025 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmHDGUrS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56815696E
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737956239; cv=none; b=k7n7fxiKEtzEaaF6T/haEyCr4iVI+yEGrWgEYmEfTnVAy2D0S7qwOQ20g4q8lS5nZ6x2NDqHlmMT143uglwSomYz2a3UmJKNBx0GjQ5anIWP+snawjnixu+yWGEIy9kOpfBxiZ4FCgi4xI4Vlnj6nEWgejxE0Dd5p7WN7Q3eIXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737956239; c=relaxed/simple;
	bh=bLD2EWuUPmsgCtgji9updHdwiTh+VTqIgZh3/uNsvOY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HO5tmcks94jYVSSYRI7/qG1ppLC0YZaT5nSBWc4mcsDMEPIiGIdFCgWjsfLciMlccNtGVpPtRwZrbIIlc72fXYHxTmn2t1jhQ1+zgZbXfKG+DWq1GP2HnpEfMY9qKFGRCN9d7k0CvIcYbifp1bMWvTzg4OgUoeQpRfMx5uNhqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmHDGUrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737956236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSE/Ol0JxTU1WHL/Q25yYd5SaYMCxKx8zTy8OtH2Clc=;
	b=PmHDGUrSVfmuHBueaH/u+Ge55K638niKW+HYgecEswnSdTArZg7kOBYwlNPX4vU4fErI73
	k0Un2aGG955HP56bX/5YQmkVUtaQFfVnhcbFfQhhErGLQXON1NTq8SmYbfvQxWelEiZZ5R
	K2o6k99ShKSf9mcx1iuFbKjVc8SQNs0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-v1uEUD4hNPSYDJ719b_Zqw-1; Mon, 27 Jan 2025 00:37:15 -0500
X-MC-Unique: v1uEUD4hNPSYDJ719b_Zqw-1
X-Mimecast-MFC-AGG-ID: v1uEUD4hNPSYDJ719b_Zqw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so12211461a91.2
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 21:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737956234; x=1738561034;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uSE/Ol0JxTU1WHL/Q25yYd5SaYMCxKx8zTy8OtH2Clc=;
        b=HZS/K/PlN4nfaIoT33QbMHikI+Jgg0X9rRmMSMpoGrpOXzaMrca3B2csQwRYUf2rDM
         xBVYDvZK+thjB8AUHRKX3l4ZfHaJnTFZbQ5dbfML/VZlmdU6P/+EvIQcakV44AQ5m5jT
         RPi9toaQkb+DtmEy9w0KD6S37UYJgioPwixkFEUoNsL4t3tjK+QkFHdpw4WIjQYWzglE
         1l6M+AFfTp/RbLp5K61KxjzHYOB7EGPck5Szdxdk+Xjj/qhppodGNN2ubc5mzjsTqPGv
         ha+En24Ozy1vLEs3tGJ7Qb1w9ydK3ZwD4tBzUiAOe294+HKK1bZUGe8WIDi4B3/qbmq7
         aEjg==
X-Forwarded-Encrypted: i=1; AJvYcCWtkbDHXgIxOf3cNP8YwjnIDznL2GsFyaiT1jcCdXIQgCj3BExygMx9fVbO7/ZfGDp8MtD4zq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oyp+zYxyB5BxZOZpcmKJ4H5HNoJxKliRA7+hYmEJFXOkLtMe
	+1mO8Wzpbh7wnDsxHfOLj6kR77zKUIO4RGhe2Q3y+ZjifBxLJs41l6/a4UmbB/nT6HeSMM130vZ
	n3TAQX2sAjup91ykNiW5WaIsSxDMUQc5czihBum4Md+MonIKZZICJXA==
X-Gm-Gg: ASbGncuqNI+xUaRPteWa9ev/jLLetWRWC/TNoNxhDbQecTKmyo/z40J117uhQ43/mD6
	Dl+vdX5qsPibddp10ezTEAwCLUTlOGTh3kWmfRP4jt4GUT9It2FTSV5J8d6pAlB1yJHExB13Vom
	CuCOukl8buhvK88QYYYr65yLvDcKzpCgBZatnBNPqQJJPoV6uRDIUSOXz+/csuHRhr6lfOYB++D
	OM33q91reeBzUrQ3p7hLAS39KO9eE1R8ZhwmzcKOCrfKiw2CMnjzENaDQ+yiVjJous6i4yJEe7b
	ww==
X-Received: by 2002:a05:6a00:989:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72dafba3219mr53726562b3a.21.1737956233966;
        Sun, 26 Jan 2025 21:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/TqssDmvWN5ryUQzgtXvQ2YFb2l8lfzcBQQ6GtdZ/r9rC4GQ9Xe2PYMi0tKnJZJMOA4H7hA==
X-Received: by 2002:a05:6a00:989:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72dafba3219mr53726536b3a.21.1737956233619;
        Sun, 26 Jan 2025 21:37:13 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:a03a:475d:8280:d9b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c82fsm6173868b3a.126.2025.01.26.21.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 21:37:13 -0800 (PST)
Date: Mon, 27 Jan 2025 14:37:03 +0900 (JST)
Message-Id: <20250127.143703.343581919278286700.syoshida@redhat.com>
To: martin.lau@linux.dev, stfomichev@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have
 ETH_HLEN
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <35e5479b-420c-4fd9-80d9-c04530ef1dc2@linux.dev>
References: <5e342fea-764b-48a0-afda-4adfb504bd46@linux.dev>
	<Z5L-ubBI7z1J6IDi@mini-arch>
	<35e5479b-420c-4fd9-80d9-c04530ef1dc2@linux.dev>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 11:22:16 -0800, Martin KaFai Lau wrote:
> On 1/23/25 6:45 PM, Stanislav Fomichev wrote:
>> On 01/23, Martin KaFai Lau wrote:
>>> On 1/23/25 11:18 AM, Stanislav Fomichev wrote:
>>>> On 01/22, Shigeru Yoshida wrote:
>>>>> The function bpf_test_init() now returns an error if user_size
>>>>> (.data_size_in) is less than ETH_HLEN, causing the tests to
>>>>> fail. Adjust the data size to ensure it meets the requirement of
>>>>> ETH_HLEN.
>>>>>
>>>>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>>>>> ---
>>>>>    .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
>>>>>    .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
>>>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> index c7f74f068e78..df27535995af 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> @@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
>>>>>    	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry
>>>>>    	prog_id");
>>>>>    	/* send a packet to trigger any potential bugs in there */
>>>>> -	char data[10] = {};
>>>>> +	char data[ETH_HLEN] = {};
>>>>>    	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>>>>>    			    .data_in = &data,
>>>>> -			    .data_size_in = 10,
>>>>> +			    .data_size_in = sizeof(data),
>>>>>    			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
>>>>>    			    .repeat = 1,
>>>>>    		);
>>>>
>>>> We should still keep 10, but change the ASSERT_OK below to expect the
>>>> error instead. Looking at the comment above, the purpose of the test
>>>> is to exercise that error case.
>>>>
>>>
>>> I think the bpf_prog_test_run_opts in this dev/cpumap test is to check
>>> the
>>> bpf_redirect_map() helper, so it expects the bpf_prog_test_run_opts to
>>> succeed.
>>>
>>> It just happens the current data[10] cannot trigger the fixed bug
>>> because
>>> the bpf prog returns a XDP_REDIRECT instead of XDP_PASS, so
>>> xdp_recv_frames
>>> is not called.
>>>
>>> To test patch 1, a separate test is probably needed to trigger the bug
>>> in
>>> xdp_recv_frames() with a bpf prog returning XDP_PASS.
>> Ah, yes, you're right, I missed the remaining parts that make sure
>> the redirect happens
> 
> Thanks for confirming and the review.
> 
> Applied the fix.

Hi Martin, Stanislav,

Thank you for your comments and feedback!

> Shigeru, please followup with a selftest to test the "less than
> ETH_HLEN" bug addressed in Patch 1. You can reuse some of the
> boilerplate codes from the xdp_cpumap_attach.c. The bpf prog can
> simply be "return XDP_PASS;" and ensure that
> BPF_F_TEST_XDP_LIVE_FRAMES is included in the
> bpf_test_run_opts. Thanks.

I'm not very familiar with bpf and its selftests, but I will try to
make a new test according to your advice.

Thanks,
Shigeru


