Return-Path: <netdev+bounces-164807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D0A2F2F8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6547A0F3E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8512580C8;
	Mon, 10 Feb 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9KMfp+P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661592580C6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204215; cv=none; b=RZycpEMtvawA8Wx2F4p3L19eM2Y9D5NpGMKiSnDhHFvoarZMRZ5aM/JCoe/Hyug7JRfk25irEVCbHeWNoUNIFujmFMOpw4k0h3pwFRXAhEPvheHPxYOA1xZPTep6AbMPcwNt2Xu+fP5rZMsttSxMT5MY8UsaMSVbGYoRpeDAtzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204215; c=relaxed/simple;
	bh=QWJMiPIFSVZpyQB32shQEx2PcB33kxugWV3st0rQO7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUWSzW3zxzdjNddQ3kNZQMfX5ShJsLQN4pHq45ebUA182nCrOHRrHj8ZOr8YJ956wmN0wTiIdg/guzMa97Km7Y0KmJpPwHYH9v/pBFWvlmlPtjE8njuR9XHOQciHCgwEIhUxmL+FP0oF6PcLcP+1koIRESU5OLAUvdNhTrpsvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9KMfp+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739204213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyFmZfBea8rpKRY2BiekOOiAmH/0VdDYLIYFMIbeCYU=;
	b=K9KMfp+PLz/UEe5zKIfqtN21bVyzN9iSC04njpixWjANMWxAdo0m2XObsiB0JIjXMAqGGr
	r9ZXLQ+7t1tII3RGF0TjcK2zhT2I7gPA74JU8csYGIEMxBiRKdw6WN2IlQ8qNJJrbHBmQS
	lbN3UoKgqr82TrHp+PcqXxYIU2+/P1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-YfO3tmgUPhyS7xixLgUp5w-1; Mon, 10 Feb 2025 11:16:52 -0500
X-MC-Unique: YfO3tmgUPhyS7xixLgUp5w-1
X-Mimecast-MFC-AGG-ID: YfO3tmgUPhyS7xixLgUp5w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4392fc6bceaso12161035e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204210; x=1739809010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyFmZfBea8rpKRY2BiekOOiAmH/0VdDYLIYFMIbeCYU=;
        b=Hy5nAD+dk16xYBonEA6hobgHZ/1rasLonP8N8Kkj1r00znCICr6I7cK1WK5Tp23bYl
         wLNRb2pQ5gsn4WaJbs1LnwXREOQ+MQg/RBqqRuo7BxLqpihbB9t9K/oNrc574fPhSJ8K
         Dxtf/kb54kY2Ok8Yd5jn3JHukpn0SRpbAZhGH8nwEyYsscghdeoghXebqNe3hvH4BpWu
         IjG+jwlE4RGTUQDlY7eOWfxtxpQfYGk4UwQ8l2otxOmpG2pJ5nAU732BnQsjMmqQx48S
         NI1iwSBkdTrMz+//Tfqs1rAasH/hWyp6v/E6X1X/DeFpRZcuycw8FJsIEMYE2hN0UJ6i
         jaow==
X-Gm-Message-State: AOJu0YzQ8iAetO3Kqi+vcLoFF3KzWTStGZK08FnCDDKFU4q6RM7YDKbZ
	BxdM475JDXQ1VKVQoQ9h/v2EBstpQlW0pfodIzDboYybxXx1sW/m8hHhkW2YOmkcXz/IN2lIsQQ
	Yt9b8IFO7IjYFXFcbw4BhiwtqyGzLVfBb5cSrfB+62w6K0g1W+PbXtEW63HyF0w==
X-Gm-Gg: ASbGnctt+WTutinByXT2r4WJmTnv6M16WEPC0RdaUiuq7XLwthPEHuj/FX7xQ7wMM/H
	p+c35NAGVbx+6emnK64/bYsGz9aghxmFlZuSJvdxektLNaAI4KE86lwW4UDLnpq4uP6CYK7F0eb
	Nyp470133rQIb38tMVtn4pTX7pJogtDjhm4AwhiKjvxewvD+MEaEcRKFNdh8UGJtOSJy90G6JJa
	6OMceIYf8rmKw5JWa3CWTK9wPr4mNtTWdTVR0SknxghZMHorWaaeVEzm7ZvFqx3Bxb0T49TugCL
	vDSNZLd34QDZ/UhnbNnpEgwgrxcY+ShK6t0=
X-Received: by 2002:a05:600c:4754:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-4392498ac55mr128463785e9.10.1739204210262;
        Mon, 10 Feb 2025 08:16:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcrNkuAavqmGxf8yNf2vorhPIbCt0V1zsF64gXNcir6puZ7oOYZEhmCNA2GP8hCPxFr0Wgzg==
X-Received: by 2002:a05:600c:4754:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-4392498ac55mr128463545e9.10.1739204209880;
        Mon, 10 Feb 2025 08:16:49 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf3c70sm185066365e9.26.2025.02.10.08.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 08:16:49 -0800 (PST)
Message-ID: <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
Date: Mon, 10 Feb 2025 17:16:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>
References: <cover.1738940816.git.pabeni@redhat.com>
 <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/10/25 4:13 PM, Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 5:00 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> Paolo Abeni wrote:
>>> While benchmarking the recently shared page frag revert, I observed a
>>> lot of cache misses in the UDP RX path due to false sharing between the
>>> sk_tsflags and the sk_forward_alloc sk fields.
>>>
>>> Here comes a solution attempt for such a problem, inspired by commit
>>> f796feabb9f5 ("udp: add local "peek offset enabled" flag").
>>>
>>> The first patch adds a new proto op allowing protocol specific operation
>>> on tsflags updates, and the 2nd one leverages such operation to cache
>>> the problematic field in a cache friendly manner.
>>>
>>> The need for a new operation is possibly suboptimal, hence the RFC tag,
>>> but I could not find other good solutions. I considered:
>>> - moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rxtx'
>>>   group. It arguably belongs to such group, but the change would create
>>>   a couple of holes, increasing the 'struct sock' size and would have
>>>   side effects on other protocols
>>> - moving the sk_tsflags just before 'sk_stamp'; similar to the above,
>>>   would possibly reduce the side effects, as most of 'struct sock'
>>>   layout will be unchanged. Could increase the number of cacheline
>>>   accessed in the TX path.
>>>
>>> I opted for the present solution as it should minimize the side effects
>>> to other protocols.
>>
>> The code looks solid at a high level to me.
>>
>> But if the issue can be adddressed by just moving a field, that is
>> quite appealing. So have no reviewed closely yet.
>>
> 
> sk_tsflags has not been put in an optimal group, I would indeed move it,
> even if this creates one hole.
> 
> Holes tend to be used quite fast anyway with new fields.
> 
> Perhaps sock_read_tx group would be the best location,
> because tcp_recv_timestamp() is not called in the fast path.

Just to wrap my head on the above reasoning: for UDP such a change could
possibly increase the number of `struct sock` cache-line accessed in the
RX path (the `sock_write_tx` group should not be touched otherwise) but
that will not matter much, because we expect a low number of UDP sockets
in the system, right?

Side note: FWIW I think we will have 2 holes, 4 bytes each, one after
`sk_forward_alloc` and another one after `sk_mark`.

I missed that explicit alignment of the `tcp_sock_write_tx` group; that
will prevent the overall grow of `struct tcp_sock`, and will avoid bad
side effects while changing the struct layout.

I expect the change you propose would perform alike the RFC patches, but
I'll try to do an explicit test later (and report here the results).

Thanks,

Paolo


