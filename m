Return-Path: <netdev+bounces-200531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEDAE5E8B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5D1B66149
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3515C24A06D;
	Tue, 24 Jun 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiOfyI7f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B687462
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751724; cv=none; b=ibpEzDYRk6zScEwDfxcw6EqOqLlHYXATpQqVWmc5wAIgLpxddMbWu4w1K/A+ptQsWGux8PDRP8VQXJ8Nzh4MkYycrAwhWffbVN2yYa+8mBl/iimqDEWD1n+05YfelOygyRbI7t7cESjEex4FO/z8mWfoYkBWx9qO9Fu+aKV60Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751724; c=relaxed/simple;
	bh=e9wFSVPFjQv/DZcjLNfcLmibUrKTrpfnsLDEtV2IrMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJ2qVwaV7eRkbkAWgSt2R/pMpeu11JR2xIwy+2mCZ37VRxI2FDvEK2JxfarnvUkZ0TO4bFQUxkqMCO2Fj4YBWIsJbGIBTcIWhh+jf1kBaWfKoyW823QjK6F5nXrIkVgfGPud4HUIA9t+n+GK6wgfHV/384xq8zGV1jyWR+mpqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiOfyI7f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750751720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpkxXx2MnjWXEMAjHvYgX0J7Vat2pAbc89ov0K8ObjU=;
	b=ZiOfyI7fK7RnbQoZohD68ORX/Bb7bZJD53rEInXCXztvOvT4rOpUhk+CSI/ShL1YpFDjUX
	VN+3mR9v+01V3doxiFrvMdIVIaNghg2jF/XBbhb/dhr0tXgxYwuhNiJsgZgEMoJ/dXTFlS
	Z0Iop7OZwEneXhnyQMlfRx2S5QI9mJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-Km-Iy5mLONCBK8OslmNrLQ-1; Tue, 24 Jun 2025 03:55:18 -0400
X-MC-Unique: Km-Iy5mLONCBK8OslmNrLQ-1
X-Mimecast-MFC-AGG-ID: Km-Iy5mLONCBK8OslmNrLQ_1750751717
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a578958000so1815974f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750751717; x=1751356517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpkxXx2MnjWXEMAjHvYgX0J7Vat2pAbc89ov0K8ObjU=;
        b=Id0IlWgikly74Uo6cX7CJzvVT8HrrZ8r7NEcz7JeplLmlwY5O+HefmL7teNIbP+bTA
         OZmB0p/lzMjOFhAm38gIalpYdWg0Se6l1LOLXUvUp3lAFIX2DWtOxfQzUXLGNkmBLR7A
         5EzhCft5fU5ZPC1Erb3Yid/uiaejCpOEL1RCemfnPj1iHjBbtHmN6mmOjhBfBu6P/ccT
         WZQ/LynmgJc+F6L8YmPFxLkKQ0cPWnqduA8g5f4SYuxxp3BBgSG3poWNJGKXp2irbp8i
         tLie8FKYLc9+NRqv24U5chO18NoIlWOSSpGh+Q6E+RN1zK8H7HTW2HdKC1BdsHDGLRXG
         +EjA==
X-Forwarded-Encrypted: i=1; AJvYcCWdTH+f7GO13zsClsh2H37E/aUuBGHvSycI8taInUS53LooRHVra/GmjwpcsMm1ISrKVgWeCX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ln5NmFwATJwgjXQZu1DzSdG7vHtqRfFzixKisoLpp4+9HRD6
	Aw4vcmlBS16KmJXflABrN/wbrCahZrsbhcXUinQRQpw+rZBZTQiUCtOL1/ymXw/DTaWGkgssQ0E
	WbY3Ww25Qjdsda579rqP9utpGjNxBaYdJUVg0Qgx5mmoYl4q3fjOiQjkMSg==
X-Gm-Gg: ASbGnctoPsMckR7t6ZbrC0enIIPHARk2gRVXJqitZtFgf0mtyILVj+8FwAekJ5dalti
	aQDgHf5zyg5Ar8UAvn9QDNQYUJlDRopmxcJYi4fjL8ElgmuEoLL9ToALjPxfXj/WlRlre+KgXgo
	JsnI94ZaKJRYKOVKtoBm97JtrFoEaTmNyMfsLdhaqroDaWZ9u9I8r9UMCOIH539fTySXxWy1u+P
	v60ULZagq/MqPIUeUICDA0h5gebhzAMkvBofmOovIJTbrfux17TQNCugD5zbPvVheBWAUHb0yDc
	p3d0mnlJU5LTAqdf+jyLey37VP0EIA==
X-Received: by 2002:a5d:5847:0:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a6d12a3530mr13087344f8f.21.1750751717366;
        Tue, 24 Jun 2025 00:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSWZGTRp8ExVr9yKqiiok8IvwH9m8HDH6VYeRCLAIzHh84U3gt3QKPOICF98mqcBHXa2mjuw==
X-Received: by 2002:a5d:5847:0:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a6d12a3530mr13087317f8f.21.1750751716992;
        Tue, 24 Jun 2025 00:55:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810b5eesm1219529f8f.85.2025.06.24.00.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 00:55:16 -0700 (PDT)
Message-ID: <93633df1-fa0c-49d8-b7e9-32ca2761e63f@redhat.com>
Date: Tue, 24 Jun 2025 09:55:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of
 sk->sk_rmem_alloc
To: Jakub Kicinski <kuba@kernel.org>, jbaron@akamai.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuni1840@gmail.com>
References: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
 <20250619061427.1202690-1-kuni1840@gmail.com>
 <20250623163551.7973e198@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250623163551.7973e198@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 1:35 AM, Jakub Kicinski wrote:
> On Wed, 18 Jun 2025 23:13:02 -0700 Kuniyuki Iwashima wrote:
>> From: Jason Baron <jbaron@akamai.com>
>> Date: Wed, 18 Jun 2025 19:13:23 -0400
>>> For netlink sockets, when comparing allocated rmem memory with the
>>> rcvbuf limit, the comparison is done using signed values. This means
>>> that if rcvbuf is near INT_MAX, then sk->sk_rmem_alloc may become
>>> negative in the comparison with rcvbuf which will yield incorrect
>>> results.
>>>
>>> This can be reproduced by using the program from SOCK_DIAG(7) with
>>> some slight modifications. First, setting sk->sk_rcvbuf to INT_MAX
>>> using SO_RCVBUFFORCE and then secondly running the "send_query()"
>>> in a loop while not calling "receive_responses()". In this case,
>>> the value of sk->sk_rmem_alloc will continuously wrap around
>>> and thus more memory is allocated than the sk->sk_rcvbuf limit.
>>> This will eventually fill all of memory leading to an out of memory
>>> condition with skbs filling up the slab.
>>>
>>> Let's fix this in a similar manner to:
>>> commit 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")
>>>
>>> As noted in that fix, if there are multiple threads writing to a
>>> netlink socket it's possible to slightly exceed rcvbuf value. But as
>>> noted this avoids an expensive 'atomic_add_return()' for the common
>>> case.  
>>
>> This was because UDP RX path is the fast path, but netlink isn't.
>> Also, it's common for UDP that multiple packets for the same socket
>> are processed concurrently, and 850cbaddb52d dropped lock_sock from
>> the path.
> 
> To be clear -- are you saying we should fix this differently?
> Or perhaps that the problem doesn't exist? The change doesn't
> seem very intrusive..

AFAICS the race is possible even with netlink as netlink_unicast() runs
without the socket lock, too.

The point is that for UDP the scenario with multiple threads enqueuing a
packet into the same socket is a critical path, optimizing for
performances and allowing some memory accounting inaccuracy makes sense.

For netlink socket, that scenario looks a patological one and I think we
should prefer accuracy instead of optimization.

Thanks,

Paolo



