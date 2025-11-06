Return-Path: <netdev+bounces-236317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A04BCC3AC79
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 13:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17364EA177
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FA322C7D;
	Thu,  6 Nov 2025 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqe05Yjp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qI/KPMzH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F0322DA3
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430636; cv=none; b=NVAr+XZQIuKrkH7Rj9g8Mlw60GSwBLmv5UAWLzH87C6NsjyiUZ/Kgo2dBOlR6SGwJCD2GQ4xULxSKuMm265v2fwGSdbVI47KVwM4SYS7fCScyoA2KVDC04pjXJo3drDqdb2aZBDy+7IQd8/bhvM/eyBPkR9cwhAgFa4Fd8tGId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430636; c=relaxed/simple;
	bh=v9zYAiaJDgaVQYcRDd7YfoPoVoAk9XCmhHvvjCZbve4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TIIg28oT7K0N6eq1o7kx4EOjXSTK2ftyBycGuloMSz3pWQRWwupV/dkAWzXsV2qgJusbuFfG9WX+nehqBiyCQzgL4UqxruHo0ow5W8u/CiWsNQuSSNVzxlzZPTrJnnFz+ypvSEDoq+z7symLtbyy0VDQ2oeXJ/PQ94wNL6N4iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqe05Yjp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qI/KPMzH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762430633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueWgB3UuWMfwahhLGkCf04/sJ0pj16YsiviBfXwtyZQ=;
	b=dqe05Yjph2qfSWAzXpsqA0nxsqVXFVJv1kzB4ZFPvtf+QE9GpVcz5RNOfRFzOsG6miTq2K
	SAYRySzV8M5L17NIFi7gJJ9iJ/R/kRQDCDNBtRn5lNsTNQctxjRMUGPdsagR3sCO0BG3Vu
	ed312WjKA15WkQPuJ8CZBkvqq87WcIk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-pbtT_NeLPwySoslaD1U6qw-1; Thu, 06 Nov 2025 07:03:52 -0500
X-MC-Unique: pbtT_NeLPwySoslaD1U6qw-1
X-Mimecast-MFC-AGG-ID: pbtT_NeLPwySoslaD1U6qw_1762430631
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477632ef599so6144675e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762430631; x=1763035431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueWgB3UuWMfwahhLGkCf04/sJ0pj16YsiviBfXwtyZQ=;
        b=qI/KPMzH2fpKbal+l3E7zR3TnvZeJu9i7UA6GyY3yXkGNiCLCXPfYUZY093x1VPRhz
         1nNszLnZbIwDppOJWC08vNTPcWKUg/4WC2awORe8uRytY+r1yLOiGR9+QqvZNPjGvhI+
         dBhGOhIyz/F464piAfkfvAfly7G3d/5BKX5p86cPes+/8qrPFeBhTtrvntxHJqqTAyov
         8u/0BuE4nppDQvL6HKR0mG9XLgO9Abu0+3UkLmemeKxFU4OFzv+RiSnOCzw0RDAL9sgd
         ee1kJbJiLXV7jSHI8lfg7Kp7nsAxIYDKmN5wBs9f7tghfh5AIb7U5LFLIuX+XsJdUmO2
         8xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430631; x=1763035431;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueWgB3UuWMfwahhLGkCf04/sJ0pj16YsiviBfXwtyZQ=;
        b=eWYRMu6gBg7ZlSPFKMLHJrC2dRsWxY9p/HcTWIcKIdinUTEXmhpHEJjTxLOhgkKVE2
         p8AgFm7QLiBidEaycFgE/yjuH+0pxIojq5STX1LwwQ2W1ONAx1F1CYouYU/7d+wh6Fgj
         X5+iNcI+mb2y96CnO19MQoOd0rZNgz5VAZ8pdFWHd3ujS0sbxEkLs3004w6LJLAGABMM
         cCZNCEQVsng5EZvSwHtu3VYGy7SnL1Pqv/SQPuDigSmWuJFhY4tDHZan4SKB+hW1JVHv
         pCioFCs8npm00cSI1OcqkRJ5mbsBBi6KPTUGBYuEUrtogoIBJvLUUKZ2YE9TvKk+J0Pl
         b59g==
X-Forwarded-Encrypted: i=1; AJvYcCX41DsqFi8jmwMZs8AGH5fZiUvys57cR3gBHgad4GjuNmFO2VrzgidhzbAMyAj5kz0KxYufCg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3zCVNBqVIQQawMF+IAd7vkYMWiLGki+Ww4bNOAp9Ck2ifFwO
	xr+nciubMpxU8dfCtR8GDgSqV/3nj+3p6CCfQVty/giO+SJ2Zr/q8faztP3nNgvIQjU2fuXweOD
	EFs23CDJfIJvaiefzYfA4UHwUV97TK9Nek9cwe+jgE8aYKojrN1jxpiQHqw==
X-Gm-Gg: ASbGncuBDkp9pTvfmYSTl+P4GpVgz/tTXdqn/bq8Ru1/2ZtUGJSCx1uCv8EvuSxOH7E
	HAoowZZfuzsSV/OK2m0kudpMvy7rdJgNbvMBIaLn4l+OHeTKxfD23fDN0eZeZpQC9m6wLgHJecN
	jYd1CfiWn+Pvdl+4GQL5T9AwW54rF5sprt2V6mUMDRWQbxSUF43UFJihHE6S7KVD3Gdsp/ccCTy
	Z+gsEYC1ZUc0LZqZfjDJw44h7DtflN6KVPPS9bRcGwSYXzWr+BBcX+e9K9tw4FnUt1HnfZifYV8
	WgRDMTWpse9MZCVhGuEo+yZsFaMmivt2VV0zpA4haxb4DweVzmwsJGAnrSbGrs7b/l97PJmnwUG
	fwQ==
X-Received: by 2002:a05:600c:a39a:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4776728d457mr11280125e9.1.1762430631026;
        Thu, 06 Nov 2025 04:03:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXHeCbTPXP2ChPwuD9fei6bqVA6QG1MQwNS8dtmzbVKzxYBA9LAe71TTJsAmwhSLucuFcwkA==
X-Received: by 2002:a05:600c:a39a:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4776728d457mr11279615e9.1.1762430630560;
        Thu, 06 Nov 2025 04:03:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f804esm44269685e9.5.2025.11.06.04.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:03:50 -0800 (PST)
Message-ID: <544ea239-525e-4ece-9523-0ddf42e99af3@redhat.com>
Date: Thu, 6 Nov 2025 13:03:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 09/14] tcp: move increment of num_retrans
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-10-chia-yu.chang@nokia-bell-labs.com>
 <4eef8fe1-b2b8-47c8-a21a-bcb4b75c3a0e@redhat.com>
Content-Language: en-US
In-Reply-To: <4eef8fe1-b2b8-47c8-a21a-bcb4b75c3a0e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 12:56 PM, Paolo Abeni wrote:
> On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> Before this patch, num_retrans = 0 for the first SYN/ACK and the first
>> retransmitted SYN/ACK; however, an upcoming change will need to
>> differentiate between those two conditions. 
> 
> AFAICS, send_synack is invoked with a NULL dst only on retransmissions.
> Perhaps you could use that info instead? moving forward and backward a
> counter is not so nice.

... except you need to propagate the information to nested call.
Possibly adding a TCP_SYNACK_RETRANS synack_type would fit?

/P


