Return-Path: <netdev+bounces-130789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084998B8C2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26991F22C73
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F2719F473;
	Tue,  1 Oct 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgJFx5S9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A019FA60
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776669; cv=none; b=AablVFt82dPLV5QzesevzCq8KezkKqs+SMBdnCyIDAz22tQeqENjVXVQEucT+wmpEhMhXbTaIO0NgrSBDhjfT9uMBapCrLKiUP5eIx024/UNIdoO0GGqQUGQgYtZO3VlyIkcNoSVouexUbJ1eo8fcsuj29h0Ts1HUsJqQdAxofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776669; c=relaxed/simple;
	bh=rxUrGpEEGAnsWx51O21NHfh5y7MXMRSuN80UhN6iT7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpBN9F5VGLsHHkRSO4gGiHyGkE2JN+zwEdJx/4MVu71zj+wWQJMXqb1jl2iItRl1ADHKIiOSgdhkcLmEy/SZU7SR7Bo1i7Y/IVseNrbhoznPEhJaOPvt2Kz09zz78AJiH3HSoMsRFCZWC/NQ7wlT5JRUSSUNCkOe0JbP9acQXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgJFx5S9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727776666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2e7tlSi8NnWU4FbxZPb0ucXiGt/CmkFpgiyu54v8N0o=;
	b=VgJFx5S9ozGdjuaT44RN9vE0vLl3p8KmBAonqJWi7V7tK3OoMSQrVFj8IRy1FCx1hX8IiP
	5zx+S9QelOQwucOoMTj4vojtX0XqMvxbbRBgzljP86MMVmpkiWJuonnlQEq3JP9D2NlWZW
	VzuFeEn1OUT93KeTAmjOsVxOkWhWhGw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-NenBybQMPdC-9w8VHer65g-1; Tue, 01 Oct 2024 05:57:45 -0400
X-MC-Unique: NenBybQMPdC-9w8VHer65g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso32954895e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 02:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776664; x=1728381464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e7tlSi8NnWU4FbxZPb0ucXiGt/CmkFpgiyu54v8N0o=;
        b=sgj1zdPLw0sbxRMhjzMHUiDFvf2leyVCqaif+2zRBuACXOSGC4kHbybnekuR9hCj3d
         0nXsxq7RzlwN4cF9lSpdUkucDeNDMP60khnf/LYHZJ/OG9C9rJjpNcEtOv2DZx10DQy0
         MD57QMvH3+eHCLtcRQqcNnniwA0hshlS/AkkS+IwkPQkatL16kgHv4VC4ZSzSS1JBOdh
         6VVk/nw0vjWvH52bL7yq143jRkopUfGe2F2SfRNP4QNF6/6UfDVZGfD9FEynQ8xea5Ui
         x7axBU7bDTPxQFBTo1WliX+xKjybidoxKe1nifQrNEfgrAnJ5V1lzwcrV+L6SPOPhHqY
         lxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRgSnSLf0oJBMrAY6blMwdz5rb1pTi1RDBpGB7bpHTwg3vtfUMlKh32Q/drWaNXbR8fPT3iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4v5b1a2gCd+lf48ApVKg34BwzS+6gSwxAeEO6v88TnH7ROef
	sXwVLKdNKllfh5IKHWJWqJj9FqWgJ3gMciipiZO+QIhftgYjD6LoXcRLo41lAoL+d+xs4ykNA7Y
	5xymcX/Is7ZEsLiyqG1wyqVDAaRkFgd/t/4EiaazJGvpZvmADcGZNoA==
X-Received: by 2002:a05:600c:348b:b0:42b:af5a:109 with SMTP id 5b1f17b1804b1-42f584646b9mr101820035e9.24.1727776663691;
        Tue, 01 Oct 2024 02:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvRb3UFanL3QsCroBCHKmI0vfS658AuQBmgg+NvQ0aTJLYVxFsk7RtChEUebBcYYEYdrMxeQ==
X-Received: by 2002:a05:600c:348b:b0:42b:af5a:109 with SMTP id 5b1f17b1804b1-42f584646b9mr101819875e9.24.1727776663280;
        Tue, 01 Oct 2024 02:57:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e2ffa1sm126550145e9.41.2024.10.01.02.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 02:57:42 -0700 (PDT)
Message-ID: <e7afc629-5428-46d8-8db0-07d3588eb2c9@redhat.com>
Date: Tue, 1 Oct 2024 11:57:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
To: Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
 <66f525aab17bb_8456129490@willemb.c.googlers.com.notmuch>
 <66f526c06b0fa_851bd294af@willemb.c.googlers.com.notmuch>
 <CANn89iKTN0NgEcUAhBf19siC2FJ9hGpQppHf4wKmH7HgAtkn9g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKTN0NgEcUAhBf19siC2FJ9hGpQppHf4wKmH7HgAtkn9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/26/24 11:19, Eric Dumazet wrote:
> On Thu, Sep 26, 2024 at 11:17 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> Willem de Bruijn wrote:
>>> Eric Dumazet wrote:
>>>> One path takes care of SKB_GSO_DODGY, assuming
>>>> skb->len is bigger than hdr_len.
>>>>
>>>> virtio_net_hdr_to_skb() does not fully dissect TCP headers,
>>>> it only make sure it is at least 20 bytes.
>>>>
>>>> It is possible for an user to provide a malicious 'GSO' packet,
>>>> total length of 80 bytes.
>>>>
>>>> - 20 bytes of IPv4 header
>>>> - 60 bytes TCP header
>>>> - a small gso_size like 8
>>>>
>>>> virtio_net_hdr_to_skb() would declare this packet as a normal
>>>> GSO packet, because it would see 40 bytes of payload,
>>>> bigger than gso_size.
>>>>
>>>> We need to make detect this case to not underflow
>>>> qdisc_skb_cb(skb)->pkt_len.
>>>>
>>>> Fixes: 1def9238d4aa ("net_sched: more precise pkt_len computation")
>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>> ---
>>>>   net/core/dev.c | 10 +++++++---
>>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index f2c47da79f17d5ebe6b334b63d66c84c84c519fc..35b8bcfb209bd274c81380eaf6e445641306b018 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -3766,10 +3766,14 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
>>>>                              hdr_len += sizeof(struct udphdr);
>>>>              }
>>>>
>>>> -           if (shinfo->gso_type & SKB_GSO_DODGY)
>>>> -                   gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
>>>> -                                           shinfo->gso_size);
>>>> +           if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
>>>> +                   int payload = skb->len - hdr_len;
>>>>
>>>> +                   /* Malicious packet. */
>>>> +                   if (payload <= 0)
>>>> +                           return;
>>>> +                   gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
>>>> +           }
>>>
>>> Especially for a malicious packet, should gso_segs be reinitialized to
>>> a sane value? As sane as feasible when other fields cannot be fully
>>> trusted..
>>
>> Never mind. I guess the best thing we can do is to leave pkt_len as
>> skb->len, indeed.
> 
> It is unclear if we can change a field in skb here, I hope that in the
> future we can make virtio_net_hdr_to_skb() safer.

A problem with virtio_net_hdr_to_skb() is that is needs to cope with 
existing implementation bending the virtio spec to its limits, and the 
spec definition allowed for some 'fun'. Sanitize everything is likely to 
break existing users.

On a somewhat related note, I'm trying to push a new virtio-spec GSO 
feature (UDP tunnel support) that will inevitably increase the attack 
surface. On the flip side the general idea is to be as strict as 
possible with the definition of the new allowed gso types, to try to 
avoid the above kind of scenarios (for such gso types).

The above just FYI,

Paolo


