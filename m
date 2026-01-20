Return-Path: <netdev+bounces-251404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2600BD3C36C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 124F0508390
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2183B95FE;
	Tue, 20 Jan 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+bpFxo/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR/ygaxN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADB3D3013
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900686; cv=none; b=o+nb5nR0mw6nA7lz38oCxO7Q0HWorzKv+yXVo+vi7MLldnhB7LN3uRbskshNGzmmgkh0uRGs9e+zJo0Y/k8ORNf5D4bIGKhlSimS3T9KJbAz8Likybud8+FQUlW0YUs85Ef357ilPn91KX9pbtAP6it466DfIVhW/oVr3rLuxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900686; c=relaxed/simple;
	bh=E+QXFyWrXJl3NrTbjno9Yjjm8q55di1CIMTELCxyZ28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDv9/PGv29ZwwJp2ICwgqR5DwuuWBwjyvzLFRtRlYNa8YraZbWUsvdLavRVxdoguDOB4ozf0lMDTBNOLkT2sSRqSK9c9/BFbOH2vsMwM2JAiaKiqOokuJJkhSh8KcMnxG2YQWSlzsezvpOV4gLh/tP+IyzMs7mcqxZegwqYHROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+bpFxo/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bR/ygaxN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768900683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vww5UVPBP3X5tU61IJRnGob2IQlavU8zzle14fb9pfQ=;
	b=Q+bpFxo/34/3TmCsH5Xx5L05abmd4M6DUgcxnmNv2l80OmgTOOeKqvyuDjwpV/hq5fPx28
	Jxx6cSW1lQBEJzcfF+X9ER3cVptZmCCPEpkX0A0KIcHs6Hzyd5qaOSDo+Gmg63Ap/xCTAS
	DHu+C27WfHSDkizP8zlYbq1mNI1fQ/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-csW7sTyWOZKOSkuAxt_LzQ-1; Tue, 20 Jan 2026 04:18:01 -0500
X-MC-Unique: csW7sTyWOZKOSkuAxt_LzQ-1
X-Mimecast-MFC-AGG-ID: csW7sTyWOZKOSkuAxt_LzQ_1768900681
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so46953845e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768900680; x=1769505480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vww5UVPBP3X5tU61IJRnGob2IQlavU8zzle14fb9pfQ=;
        b=bR/ygaxN65sG2sI/Hkd/bxzQxRrOtop57H6wWLcND2lG7wIQl7wSu8OpK4WjGrZSwB
         lNv7zLHXuiCMNI49FrbZzw9+cFzICi3tTCC6PrQnOFJjxzcyKX3Qgh1p5lgVHYLQgu1Z
         Li6CLwmZQ/KCj9OsejbpZl99Gt6A5xlqKhmVIJ6jhzmbW+9K1rn5MnR/cIiBxUi6VL4Q
         MgK/YP6JaU0WRm5rnWE9q4CCDfADY62zAXFNAj1SgThXavGlPMB6N64h9+OK4lwR4WMj
         9zbWEcpcKFS+IbSTyiUBsIyCejk6SksAJS+c9ncDvAn8G2i80FNR7WHQhLGEF4hwLkBC
         yq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900680; x=1769505480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vww5UVPBP3X5tU61IJRnGob2IQlavU8zzle14fb9pfQ=;
        b=V6DqLTBIE538vC8OcbjJd4O0H71keJyckRkzJbtJDetxnUbaSgNVwHUOSuVk0mo/Np
         Ale6fFbCV2YG5wJgrWcH6aisaFaHDLYu6xNSHVormwiz7H/rOH5i9NLGMUPWGyXvWlIP
         1154WhMFWtTo4TuIWEVoRhgyn99JbonHqyZEAQenbSzRLe4JfmA1CocbD4AQ34ooG+wd
         ANUbuAS5li2rP9GPRUgd1aAKExDKsvPRBWBH+tcyguAj7ukMliY0vupru9u4dLnFL6nP
         uqqPGV3S2HImonIs08sVjDdVoIWThuO1QvkxBExVsUrcEEJgKlKAPtWf1Xs8WbZMN1zp
         n7uw==
X-Forwarded-Encrypted: i=1; AJvYcCXXYWdRY66NWNTcMnaXNESi0rLGHgPuhIdFLdHULWsR88dKWxBvwA7U2E/kiLDiYsOLtxWf7I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDG/OPdTP4cHSrZLPRbm59ncCMZ3VgaOmdZqS/QGl0uPWuCFU
	d3BX14zQUsys07iZ6gWqGCL23vpX0RYzUSRL3P5vmG6kp8UeLwsdqMHGZk90/ClvRtdE1nusK1k
	LRJKfRqVChg+xb6hYg2lrhNGb3hB0Xzsqn6JxMUldlE7Ls0tAeun6TR4gRA==
X-Gm-Gg: AY/fxX4pYL/0MQy0gq5IuvBhmai5jKrKjR+SyQTZ9r8gbBJOjcLKAUNU+AgU7+BBKsJ
	Sw7UOJjYDKuUmcOrsp5dJsVucySrxPPeU5nlYvXu4mNAkmt6Bshd5lnnDUik+VYfzHvVpPbWSN4
	hL1IZrct0eh4Ws6ckHYu6DFkinzRJalJiEjnvkMRERIjGGrkMs/1DJUw9uVBlWM0p3ChOW603Q8
	kv5QdwbkxoVAbwOIGX87nBfVQrK8iBRNw6fHt5jfLGkxXARoKz44jfPFAFgJYTAGn9kNzNXw8R0
	xiI7Tz4J65cJIucC50BwBF7b5xpq9n8AEdr8BGEK1pKUNhdabRmMibBjXj7zJVXsEUeq16Tg6HS
	3oa1RcJudtW9u
X-Received: by 2002:a05:600c:4ec7:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-4801e30b6f4mr149566245e9.11.1768900680513;
        Tue, 20 Jan 2026 01:18:00 -0800 (PST)
X-Received: by 2002:a05:600c:4ec7:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-4801e30b6f4mr149565965e9.11.1768900680040;
        Tue, 20 Jan 2026 01:18:00 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm28167300f8f.27.2026.01.20.01.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:17:59 -0800 (PST)
Message-ID: <e4d81c37-ad4d-40fc-80ff-dc047f772b5c@redhat.com>
Date: Tue, 20 Jan 2026 10:17:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/11] BIG TCP without HBH in IPv6
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 10:26 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is part 1 of v2 of "BIG TCP for UDP tunnels". Due to the
> number of patches, I'm splitting it into two logical parts:
> 
> * Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4.
> * Fix up things that prevent BIG TCP from working with UDP tunnels.
> 
> The current BIG TCP IPv6 code inserts a hop-by-hop extension header with
> 32-bit length of the packet. When the packet is encapsulated, and either
> the outer or the inner protocol is IPv6, or both are IPv6, there will be
> 1 or 2 HBH headers that need to be dealt with. The issues that arise:
> 
> 1. The drivers don't strip it, and they'd all need to know the structure
> of each tunnel protocol in order to strip it correctly, also taking into
> account all combinations of IPv4/IPv6 inner/outer protocols.
> 
> 2. Even if (1) is implemented, it would be an additional performance
> penalty per aggregated packet.
> 
> 3. The skb_gso_validate_network_len check is skipped in
> ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
> would make sense to do the actual validation, just taking into account
> the length of the HBH header. When the support for tunnels is added, it
> becomes trickier, because there may be one or two HBH headers, depending
> on whether it's IPv6 in IPv6 or not.
> 
> At the same time, having an HBH header to store the 32-bit length is not
> strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
> just restores the length from skb->len. The same thing can be done for
> BIG TCP IPv6. Removing HBH from BIG TCP would allow to simplify the
> implementation significantly, and align it with BIG TCP IPv4, which has
> been a long-standing goal.
> 
> v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/
> 
> v2 changes:
> 
> Split the series into two parts. Address the review comments in part 2
> (details follow with part 2).
> 
> P.S. Author had her name changed since v1; it's the same person.

I went through the series as careful as I could and it looks good to me
- actually it cleans up the GRO/GSO nicely.

Acked-by: Paolo Abeni <pabeni@redhat.com>

Still I think we need the tcpdump part being available before merging
the code; AFAICS the related PR has moved forward a bit since v1 here:

https://github.com/the-tcpdump-group/tcpdump/pull/1329
https://github.com/the-tcpdump-group/tcpdump/pull/1396

But it's not ready yet.

/P


