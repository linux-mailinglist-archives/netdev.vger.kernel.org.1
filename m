Return-Path: <netdev+bounces-225505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BDB94D7B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F182C3A67F8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514572608;
	Tue, 23 Sep 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuwTrJ4a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9326D4DA
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613520; cv=none; b=fVYlVgP0tqhWL1tjl2c1vtbl/YcMks/jCAcpDFQGBs581PaZM8ko5OmavK8GF1YAMwO9pYhpqWOJnxIRC7d5bHu6J8Litafl6AifZsDw+cP/MyxR8hpzAk0TTFu7UT76hdYkaDcIO/uyjf+mRgycF432jos2trl6FIPaxqfQkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613520; c=relaxed/simple;
	bh=ddQGYeKjVw7NbBw7gXNw/cQHqMfOOBRU5ItAYxje4pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkdqrGiaukhDTyzeed3oyqRZGzyMe3yoxuUJLl62uA27E03eLfz3u1aB8dQDZessv4/1AZUauoZAKiD2f8eL8W2XjiO7g7rnIow+Y2GU3XDqmR5KVhirWsYdRXwEkRZj6qsrZgmyL/ajHG9CN6n4VBnMKae3bPMRzZ3r9ernIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuwTrJ4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758613517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIaDMz1YoA70BA5LikkpXDzRFgHss3C8YjmIR9+lStM=;
	b=WuwTrJ4a/sZTKj0fyiTSIMI3Hre2ErZuaYrvdAYk2ElkC4+834EjN5bonFVecGnQzVELpy
	eAjmx9wOPdOifp3XxONrmLxrCLuH6xyyfTkhFZjWCRnb0gj3yZel/1nAtAXN5v0h5vBSaL
	AMw+vUxkP2Wp56AUXZDXklU605gIKo0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-BrLV7kFfMuuAmHPaCNRA5w-1; Tue, 23 Sep 2025 03:45:15 -0400
X-MC-Unique: BrLV7kFfMuuAmHPaCNRA5w-1
X-Mimecast-MFC-AGG-ID: BrLV7kFfMuuAmHPaCNRA5w_1758613514
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so916701f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613514; x=1759218314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIaDMz1YoA70BA5LikkpXDzRFgHss3C8YjmIR9+lStM=;
        b=R6uyKIVYeAfYcd7EpSmhJ/VV0m7AQ6eslY/cfXQjaMLIWD0EbCHlQpoPQ2rzQoM24U
         epGiD/Zl5WC7AydQ2GcwMW273EsVkcVdc8tp18XCSEgJYpMmSTPicp3wd7waE42jlGp5
         jNRA9H6ZRMSJEGnwMbeP/e4bqIXpAkBwzNejaHt9s0tXDb7q1OngKckRTBKnR8cqr17q
         /kqfY+qU0fivSnEYWq/3Zl/XtKv3vcwyum9JVIXMr5PGkWMEkb8VnjdCiam975XNRZSo
         E6hBrBK9/v92SFT8DZglucsaRklQasfpHkiQRC7QT5Ioax+k5UcA8XFAlbSlvEWlYzn0
         f+ow==
X-Gm-Message-State: AOJu0YxfqgjtrwLLKgCpZ4yPhIJjD3UfczOPpbkMiHh6wpuItzZn51hG
	RpW/5q+/JnSX2qqleTp7HnnR3XW+YqKZoVXSRDNwWERvYCr+sEFwvicN6O/43j/BhN919Ck4wdr
	OMXJBcTDKsWge0n2vVqSrWzADjOWOB+hEDSOZHx37P61B32KWzXijM03gDA==
X-Gm-Gg: ASbGncsAcSEWhNB3lQkp04GhOtMTERAe5ZqH/GdtXPfpu/iKjSWuqHcUH9nGYvOK76J
	vYmeBP7H7lX0sGDxiysAncTYb4yPmxHLoRb5l5325Cg6NV+h0d1lX8kbaaYfRHIMMNoTydsbY69
	XvGPp5Di1qKGWzuXVVRHXeVzfZIYPvsCLCIoJdPO+zD9y43Bytb9gdvM9nj6dDZGtgsJivuyGdj
	GQ8qm/S//pwTlEmCe5pRHyeIMoZ0z/3jxlhjScds58gW5SWyCPEZbEQmiJAO84KZ0KOTwaMQxIX
	wnN+5E2wQLUCK+VQqaqjAN6/mEe0LEcQbT4Qy3otzD1r2yjs1nee52/svKfW+Zib/LCg2zTdNpz
	vZ8Wxi9qoX+fH
X-Received: by 2002:a05:6000:1887:b0:3ea:c893:95a7 with SMTP id ffacd0b85a97d-405c9446acfmr863467f8f.31.1758613514062;
        Tue, 23 Sep 2025 00:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJ5Hy5G84IeQDFp3qulWDkvJLd3K+sKIlJt6A5SEKpuB/r538fhY7bTK32U70jlHAc8iv3Q==
X-Received: by 2002:a05:6000:1887:b0:3ea:c893:95a7 with SMTP id ffacd0b85a97d-405c9446acfmr863446f8f.31.1758613513563;
        Tue, 23 Sep 2025 00:45:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee074106f4sm22648109f8f.25.2025.09.23.00.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 00:45:13 -0700 (PDT)
Message-ID: <fa753eac-3dd4-40d0-861e-3768d2ec2ddd@redhat.com>
Date: Tue, 23 Sep 2025 09:45:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] tcp: Update bind bucket state on port
 release
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>,
 kernel-team@cloudflare.com, Lee Valentine <lvalentine@cloudflare.com>
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
 <20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
 <b22af0eb-e50b-4d5c-a5bc-eb475388da10@redhat.com>
 <875xdi5yjy.fsf@cloudflare.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <875xdi5yjy.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry for the latency, I got lost in pending threads.

On 9/16/25 3:14 PM, Jakub Sitnicki wrote:
> On Tue, Sep 16, 2025 at 12:14 PM +02, Paolo Abeni wrote:
>> On 9/13/25 12:09 PM, Jakub Sitnicki wrote:
>>> Today, once an inet_bind_bucket enters a state where fastreuse >= 0 or
>>> fastreuseport >= 0 after a socket is explicitly bound to a port, it remains
>>> in that state until all sockets are removed and the bucket is destroyed.
>>>
>>> In this state, the bucket is skipped during ephemeral port selection in
>>> connect(). For applications using a reduced ephemeral port
>>> range (IP_LOCAL_PORT_RANGE socket option), this can cause faster port
>>> exhaustion since blocked buckets are excluded from reuse.
>>>
>>> The reason the bucket state isn't updated on port release is unclear.
>>> Possibly a performance trade-off to avoid scanning bucket owners, or just
>>> an oversight.
>>>
>>> Fix it by recalculating the bucket state when a socket releases a port. To
>>> limit overhead, each inet_bind2_bucket stores its own (fastreuse,
>>> fastreuseport) state. On port release, only the relevant port-addr bucket
>>> is scanned, and the overall state is derived from these.
>>
>> I'm possibly likely lost, but I think that the bucket state could change
>> even after inet_bhash2_update_saddr(), but AFAICS it's not updated there.
> 
> Let me double check if I understand what you have in mind because now I
> also feel a bit lost :-)
> 
> We already update the bucket state in inet_bhash2_update_saddr(). I
> assume we are talking about the main body, not the early bailout path
> when the socket is not bound yet [1].
> 
> This code gets called only in the obscure (?) case when ip_dynaddr [2]
> sysctl is set, and we have a routing failure during connection setup
> phase (SYN-SENT).
> 
> In such case, on source address update, call to
> inet_bind2_bucket_destroy() will recalculate port-addr bucket state,
> potentially "downgrading" it to (fastreuse=-1, fastreuseport=-1).
> 
> But if the "downgrade" happens, it changes nothing for the port bucket
> state, as we are about to re-add the socket into another port-addr
> bucket.

This was indeed the path I was looking for. I lost track of the fact
that the port bucket affected by the removed and add is the same, so
it's state does not change.

It clear now that you pointed that out, thanks!

Paolo


