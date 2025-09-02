Return-Path: <netdev+bounces-219039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7967B3F7F6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1916D654
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE672E7F38;
	Tue,  2 Sep 2025 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwFC0Qf6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98471F237A
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800756; cv=none; b=AAjXxUkYAlmqJbbjvQLlWlq1/uAo5l0BDv4rtP79MeAVBGbJs+qKu6ZevzxeIfziAlNCr9nvlMRLsnY2k4sllL2fnGjWFPNGGFRSK6TO5WAey4qoE/DzB4NORB80LPXWUtokA+Ogbm/ZqhigDa3Wi341TpmAqEgpoz12CqeHkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800756; c=relaxed/simple;
	bh=zJuMtqWN5nf+Dc87lFiX1BeYhPM+TGBGxDmoQ+gslaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDKBubFC5vmu0pWQXUX4xqK+c0yn/wDvuRPtjSaUv3r5386IZc8ILnltpsLBDr2aCzmS2gKZ6Pu+ade+QDpgQdWoi2qdW/Rq9SJTX8GEA9a0uPmDxx4tOeAtviyoLd8JiL/is4uVyLElWVPAE7RCkGDQEQVnOyX1a091twctuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwFC0Qf6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/S5MChsN4vwFWUggW1BSz4RudX6X7SrO72jBVRdjPg=;
	b=YwFC0Qf6Om5aGSJxb+mBBwXuOs9wZ0XEHlHkNcZsxlBrX/OH0Eix7cHIlgmE5bdlvIktKO
	P9vyfG5oLBvnp4cMUacKEMoCdzlTjhWJ9jzT9hdgP0esENtlPWwF9pxB9W3WlRQ0DsLWSW
	a0d3/UXZSVhoL+naG/n0s4uQwjKukmw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-sFBlA3iUP3qWMBFBQZBEOA-1; Tue, 02 Sep 2025 04:12:32 -0400
X-MC-Unique: sFBlA3iUP3qWMBFBQZBEOA-1
X-Mimecast-MFC-AGG-ID: sFBlA3iUP3qWMBFBQZBEOA_1756800752
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e96dc23e87aso6426644276.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 01:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800752; x=1757405552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/S5MChsN4vwFWUggW1BSz4RudX6X7SrO72jBVRdjPg=;
        b=jcLBKDyNZ4T8TSyBujqimrYgid2BkN2KQSyhV9+qV6XRNCtbeP8b1vGWMtuvCfCPA6
         IBSNRmi2jnMthQNLLnPVphPX/4RdVnxcMncIi2FixRxTbz/0xcscxilCbDMx17qXNUTX
         uhBjkRilVZW5xXGtLssXoi998DpOYiIJ24dGcu4aaZnpfsExH7v/5rtoMcHGFqyaK+DP
         Dzv/g7Mf+OAVLe7gU7LbtCajhckzLrgieev3/qdd7HqtiSW2Ru+kahkEmtcI7tG4xHU6
         L4PPYTLDiaWOv0atc27OZhe0zOYfKxaXffzVmMzSJa9j0uMg/Q+cneAStV2xw9f73FmW
         XK6w==
X-Gm-Message-State: AOJu0Yx4mkoPyMEguMIq7Coc7yLAGkJny5nDowFKeUSGX7Yqi15H/GkR
	EkphO4driQsbYx6Ko3UyYjAwecpMtJTS8IJsos458r4hDw+wOaFj04FhGdzPfRkjwC0gJxBT9xf
	aqCW+OB2E2NXIgKcNP9tudTKdfN35mgVXwVOpJfCg2M+CTjWd0tpBP+hXpw==
X-Gm-Gg: ASbGncva8/iBoiJbyIELbTCWJatioGY5oUhfl1RYxILdBgOaHFhXmsSKzLGp+1pvyUE
	1ia11H9/InmAcd+fF8FwJypoXTZBSL0/lSBhtWRB0wAXRUybtNTudsixeuwJ0sXvqHFtLrQgK1o
	/8fxfU1bfkaW+Tj7bEAvq5pqQ4YtFB1Gr4f9e8PRi6HGiRsHvo9HxOgm3sVL0UQaRQMHMqLMMK7
	cfxjBz4ZR0j0iRRlxGfX2VU7wuFOCxNKU6pAfqa91fUp84C9/OaQOwMiqkWwldsRXeDCCZCEQfN
	g8smimtpxSWzZd69XJVE3VQVfxXQqLZnC1OSL+uhBR/YBN6WtXd1wFOhCJJjPLKA6kWI1Q+ULQV
	o5Ia+wOYf8cQ=
X-Received: by 2002:a05:6902:1506:b0:e95:2817:1e5a with SMTP id 3f1490d57ef6-e98a5786655mr12518112276.13.1756800751581;
        Tue, 02 Sep 2025 01:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnJ64kV3LRZj2otjAvG4Is9EPhI9yBZdrK5BoXJGmEtor+Hu/aL9cy+JTfeDZRsk/ozjuBrQ==
X-Received: by 2002:a05:6902:1506:b0:e95:2817:1e5a with SMTP id 3f1490d57ef6-e98a5786655mr12518095276.13.1756800751161;
        Tue, 02 Sep 2025 01:12:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe05cad6sm386983276.17.2025.09.02.01.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:12:30 -0700 (PDT)
Message-ID: <6efc1a99-b5b1-4a22-9655-fb9193e02a7f@redhat.com>
Date: Tue, 2 Sep 2025 10:12:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 14/15] net: homa: create homa_plumbing.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-15-ouster@cs.stanford.edu>
 <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com>
 <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/25 12:53 AM, John Ousterhout wrote:
> On Tue, Aug 26, 2025 at 9:17 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>> +             header_offset = skb_transport_header(skb) - skb->data;
>>> +             if (header_offset)
>>> +                     __skb_pull(skb, header_offset);
>>> +
>>> +             /* Reject packets that are too short or have bogus types. */
>>> +             h = (struct homa_common_hdr *)skb->data;
>>> +             if (unlikely(skb->len < sizeof(struct homa_common_hdr) ||
>>> +                          h->type < DATA || h->type > MAX_OP ||
>>> +                          skb->len < header_lengths[h->type - DATA]))
>>> +                     goto discard;
>>> +
>>> +             /* Process the packet now if it is a control packet or
>>> +              * if it contains an entire short message.
>>> +              */
>>> +             if (h->type != DATA || ntohl(((struct homa_data_hdr *)h)
>>> +                             ->message_length) < 1400) {
>>
>> I could not fined where `message_length` is validated. AFAICS
>> data_hdr->message_length could be > skb->len.
>>
>> Also I don't see how the condition checked above ensures that the pkt
>> contains the whole message.
> 
> Long messages consist of multiple packets, so it is fine if
> data_hdr->message_length > skb->len. That said, Homa does not fragment
> a message into multiple packets unless necessary, so if the condition
> above is met, then the message is contained in a single packet (if for
> some reason a sender fragments a short message, that won't cause
> problems).

Let me rephrase: why 1400? is that MRU dependent, or just an arbitrary
threshold? What if the NIC can receive 8K frames (or max 1024 bytes long
one)? What if the stack adds a long encapsulation?

What if an evil/bugged peer set message_length to a random value (larger
than the amount of bytes actually sent or smaller than that)?

Cheers,

Paolo


