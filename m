Return-Path: <netdev+bounces-226443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B4BA071E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9D17276B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82853019C1;
	Thu, 25 Sep 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlajCNj9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20327241663
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815415; cv=none; b=CvTWHkBTu4ZRum4SGnPAfvS543UJiasuPGDNtkXpHnn1Bc3u/fzvT0s9sFuY1oteJfGBkcLAwNU5na58CODY7joWntW/znLXMQ1M3kY/nvq5rpaMWKxcuY0nKMpT5GstLXUaQDjswYezLpeJ2yhA+l9VmpgqX8R5Q7PTgY8hQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815415; c=relaxed/simple;
	bh=6U561RsZS+7ehXxxbAaXaCZdLb/rf1WSXkRONpEB64k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sODJFnAvQYl/MSHy0TlRV6069lsnsA9dAw5mlk9e5txtm/0bZpzKUNEB1114YwBw2jTqsf3UCO6dj6ipFvesaRFdKCncSphbu+vwZvviCRo0N1JTPUE39OA6vIYTBeaD+3lXK4TSqY88djBZSDB3wtfcskWOPrHoE33lKXgYhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlajCNj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758815413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPOIdtGuD9l53wCDZgvs8CoLuOUrw0SyvwaoNtPWj00=;
	b=KlajCNj9lCk8wBeK4qdnUlVQEJtRwE5IKGgJpFGo59Pb/m0g4Q7DAneYwfOsjI0oXXWkuI
	CiasL9+qm9pnccELZBNN6aYCosQ1O17gXjjVvcQMayjrd2GMaIwLiX8uhbSa94xvipmE2a
	2corugSLr0C0HkTPpFgM0w2+Pbg7kcs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-3RiB5RFYNVWMk7DQO8Q2mg-1; Thu, 25 Sep 2025 11:50:11 -0400
X-MC-Unique: 3RiB5RFYNVWMk7DQO8Q2mg-1
X-Mimecast-MFC-AGG-ID: 3RiB5RFYNVWMk7DQO8Q2mg_1758815410
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45e037fd142so8716125e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815410; x=1759420210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPOIdtGuD9l53wCDZgvs8CoLuOUrw0SyvwaoNtPWj00=;
        b=KevZIDZ119vLyAetYdHz8TZKyaTwqw4M4FtbraqIWHydHtznOUVdMWcsfZ9dTRrOEa
         dTk42qLbMDDcAmabSmI/ahdEagoUqip9LzYidqbsQnNmRmFUkm1An9TMk/767svsWO5O
         Lrzbes6D1VUmf519scItyXLTvW12MPTNoI8MVekLCkF1LidZ0H3EHS3stvtFwG6AM4Of
         DFIxdmO2V8JsTDwiPm0dA06Z3wITMZWHzot3ZUzKh5+LWY2/lFEeDTJprHpCAg0kNAxX
         d6zrhcEhnG7HRE8ulDtnU0fArBW7773RK7gBPZtpFqOWjHqSQd+0n2m1MLJbrHHO6dpv
         cQDw==
X-Gm-Message-State: AOJu0YwKiQ5xyg9XiPYMOiYAAKIQbM2zCWQEDRlulcJRE8lUb6AmOmXr
	ZC42h/cdifEO2pLopvmdge4b0nZEJAa53a1xzgACwOLnZg5iz2l0du1j2RQ159lBr5e0SpPtitD
	ZInScAzxy9LKzC0Vv4/YDCvixMK54rgKg/RKYyzOjaqmN0K0aEwmIoiByow==
X-Gm-Gg: ASbGnctfv6+mKGoYA6cwaEPQ1rDuQgLgVTYkHL0wI0WlrawRChZQkPlmGTh0D2fowzp
	xHGWUk+wOPdCq6EQcj/Hj9HXV5HWpi4ypdrsLKW+Hjrb3ZQ4vIbXE8SqCQmag69/7kBanmi+qbS
	C2gIbi4WtO98++miuICE6m2ZLBPnERYM0YI6LY4okXmz0lPEVQvOHivF5HdhUFKK2H0wvlJ9HZq
	FE3gxNZNjOZ/9bqU0xtZmcLwpUaPWPwGFQXKLg7FgMSy4ySXNXQ4/7QCZheffP7iSzqSocNiyIs
	1rXPiYdIDWgEggI9vizPfMe/A0X5cFbPR8yRqvIEgITUD4/RkkZqfNR7IRiwgzQcMblIBsrP3Ha
	+l/Jx85U25SPU
X-Received: by 2002:a05:600c:1ca5:b0:46e:2637:d182 with SMTP id 5b1f17b1804b1-46e32a08feamr49009355e9.28.1758815410231;
        Thu, 25 Sep 2025 08:50:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFifX77hGxL2O4FYAU+ptB+L8YPLKwsnLSuT5OPi4ABcaTgR4jE6/4IbKEl3gD+G+IQTmbShw==
X-Received: by 2002:a05:600c:1ca5:b0:46e:2637:d182 with SMTP id 5b1f17b1804b1-46e32a08feamr49008725e9.28.1758815409731;
        Thu, 25 Sep 2025 08:50:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf6ecbsm42448815e9.22.2025.09.25.08.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 08:50:09 -0700 (PDT)
Message-ID: <2152c576-68ce-4bc4-9658-bb1e8ccce423@redhat.com>
Date: Thu, 25 Sep 2025 17:50:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/15] quic: provide common utilities and data
 structures
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev,
 davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1758234904.git.lucien.xin@gmail.com>
 <a7fb75136c7c2e51b7081d3bff421e01b435288f.1758234904.git.lucien.xin@gmail.com>
 <871ed254-c3d8-49aa-9aac-eeb72e82f55d@redhat.com>
 <CADvbK_e20TrcgprXmnZzvoEO6yzoo4Zx7B0qFS0kQPT8Sf63LQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADvbK_e20TrcgprXmnZzvoEO6yzoo4Zx7B0qFS0kQPT8Sf63LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/25 6:06 PM, Xin Long wrote:
> On Tue, Sep 23, 2025 at 7:21 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 9/19/25 12:34 AM, Xin Long wrote:
>>> +static int quic_uhash_table_init(struct quic_uhash_table *ht, u32 max_size, int order)
>>> +{
>>> +     int i, max_order, size;
>>> +
>>> +     /* Same sizing logic as in quic_shash_table_init(). */
>>> +     max_order = get_order(max_size * sizeof(struct quic_uhash_head));
>>> +     order = min(order, max_order);
>>> +     do {
>>> +             ht->hash = (struct quic_uhash_head *)
>>> +                     __get_free_pages(GFP_KERNEL | __GFP_NOWARN, order);
>>> +     } while (!ht->hash && --order > 0);
>>
>> You can avoid a little complexity, and see more consistent behaviour,
>> using plain vmalloc() or alloc_large_system_hash() with no fallback.
>>
> I wanted to use alloc_large_system_hash(), but the memory allocated
> by it is usually NOT meant to be freed at runtime. I don't see a free_
> function to do it either.
> 
> If QUIC works as a kernel module, what should I do with this memory
> in module_exit()?

Right, I did not think about such case. I suggest using a plain
vmalloc() without the loop than.

>>> +/* rfc9000#section-a.3: DecodePacketNumber()
>>> + *
>>> + * Reconstructs the full packet number from a truncated one.
>>> + */
>>> +s64 quic_get_num(s64 max_pkt_num, s64 pkt_num, u32 n)
>>> +{
>>> +     s64 expected = max_pkt_num + 1;
>>> +     s64 win = BIT_ULL(n * 8);
>>> +     s64 hwin = win / 2;
>>> +     s64 mask = win - 1;
>>> +     s64 cand;
>>> +
>>> +     cand = (expected & ~mask) | pkt_num;
>>> +     if (cand <= expected - hwin && cand < (1ULL << 62) - win)
>>> +             return cand + win;
>>> +     if (cand > expected + hwin && cand >= win)
>>> +             return cand - win;
>>> +     return cand;
>>
>> The above is a bit obscure to me; replacing magic nubers (62) with macro
>> could help. Some more comments also would do.
>>
> The code is exactly from the commented doc:
> /* rfc9000#section-a.3: DecodePacketNumber()
> 
> See:
> https://datatracker.ietf.org/doc/html/rfc9000#section-a.3
> 
> I will bring some comments from there.

You can quote or make a synopsis of the RFC where it makes sense. In any
case, please try to reduce magic numbers usage.

Thanks,

Paolo


