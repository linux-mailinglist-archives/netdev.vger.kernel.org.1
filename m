Return-Path: <netdev+bounces-224258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF9B832AD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF36E7A2CFC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69422D877E;
	Thu, 18 Sep 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4MQMJSM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375DE2D7DE0
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177521; cv=none; b=hdeeXMe5k7F45PpF++ZpoqFy2dwd0uKNyC3Giy6RGiuih7eKfAbLV9IFA0yGeZZVTBFagAk6xr5biUAbNm1gzGOYmgZqSCVNfgM8w3OxWoF2PnTfjhuI7DzsYAxx2pYBvTgHpDqntqOt5CTEWw/r6cEA+xQvN3nJTjBGfmISaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177521; c=relaxed/simple;
	bh=MffHabKJWJgBDpbBp/RnSbCqMNSaz0/BKhxnO9id7TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFZe+FiA6SOUZqqxyTUXg/A55adGV4zja3Qm0g7bSTfShMtnU92Xbk/5TnI8r+mol5Ka7jiqVdE0jh+MQw4FdV67H1syD+JAeAjHCYFALRiZVXRT87nd8f0Uof6PHRwPZnKGQ/SNKuTrBM0Yr4RO6/dBgO8OGbx4BNq76LvQnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4MQMJSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758177519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAh/Fi6nEUMMctigFaFR9qoWP7lVgNdylmJvPXd/YqM=;
	b=J4MQMJSMVqxDNQfkDfEEq3W3WsOQHyt5N/9QapAqs0AFJU6hE27HWzxEc838hMZ5M8wr2V
	I4BScBJQEAT2s3gTHdfuL1BDbuknoT69wAyuckdfopYxyGZ9zXXPuyrUPyGJJk5U63cqPn
	WjNkIJhihTp0bhHphw8nAhC42eLe73A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-AJCDWURdM3yuIsH2IRPEMQ-1; Thu, 18 Sep 2025 02:38:35 -0400
X-MC-Unique: AJCDWURdM3yuIsH2IRPEMQ-1
X-Mimecast-MFC-AGG-ID: AJCDWURdM3yuIsH2IRPEMQ_1758177514
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e997eb7232so189817f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 23:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177514; x=1758782314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAh/Fi6nEUMMctigFaFR9qoWP7lVgNdylmJvPXd/YqM=;
        b=hemNW39E7iUP8FPeCqxxsOcYgi01zChM+8IiMbuRxWok4EbXcaQDop42t2nB2WZkO6
         21eHR4Nn0fyvU8gET28R9XNtzZ/p7EKYHnC8ba+rXGlreN910cZJV3e/5CCOUGoyM/5U
         KdXeaeaMwqWbMFrPddDViC+/vkyWCm+APHu9slx2flk7cU+iUgdVcVuQ+72Rt4ffynPb
         BXzRvLaRkFLVjnLg7YAq2bKbqD5WdC82U3MQxfUmIpGr/fp+MutAv/L+HdzuirO21YSx
         zECz36DGUVilrHRhIxcNjzJIDGdxtubRwMQf5Hj5rMKvT5hlOywulhwf+mlvPw8uE43M
         UiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCViusgoXFyWVSOGLLnuLM6lbX81Xo29sSzNqgEwO726f4rnnAmAibDtilt9WqKCL80xax3sB9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhgR8QbR043/SlbDIwD5njqi1S/iB9QYMBE52OHQjoBYcfknJG
	ekMrqv5lGpRXnLft7giphhU4MAy/s+rEe4SYEG/P07h9f15RtKJfizAeFc+ikKLWx+fdpuoWFTJ
	oc4OWjkGfyzw89jtKRBAKMWCXLAHt/+C7XuOzNkhczg1CZ/8XcL2V+OntFw==
X-Gm-Gg: ASbGncv732+w+p8cDz9A8IGkq7mIK3RBr2brBSOqCvcSdzYjdsB6vpCD4a5DbUUwZW5
	M6VpQMT6PTqM5yscHvUpEck9OzLJUpbQnVs1dY5V66KazmObeZLtaaMsuW8vxjFTYAvR/rap9ds
	EMElib9jcSg0lLvgUKYMAtC9cMzUH3BqdyXNj2PCVb0eOkVSDu1qVm0+n0c1H6JvVSsT8EWB5lF
	2Ri8XlUhjZHMrlGQLLzivZRzWODJYFbnWs/6WEgQcEEwdi4C5xD7B1BcreEGh5mPC8xOYEd6UXw
	qCsttHJA81NZuiiieDx3A9eLSUL68MXLNCZuW8r80VCXif4vuoZ8NIIkel3d375bc9+6DS2zAIB
	BJs97XaJjJjkp
X-Received: by 2002:a05:6000:609:b0:3ea:4e8b:c96a with SMTP id ffacd0b85a97d-3ecdfa5a880mr3923200f8f.57.1758177514283;
        Wed, 17 Sep 2025 23:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYIWByUp4nurHftESIgNoGeT5ZQqqoziYnGSKq/FbF6K+OJ6fdnu+DMh24+hq7Z6VzRaH89Q==
X-Received: by 2002:a05:6000:609:b0:3ea:4e8b:c96a with SMTP id ffacd0b85a97d-3ecdfa5a880mr3923178f8f.57.1758177513844;
        Wed, 17 Sep 2025 23:38:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1ad6sm2143474f8f.54.2025.09.17.23.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 23:38:33 -0700 (PDT)
Message-ID: <9ea17c90-4df5-4c0b-b574-c82e9411b6d8@redhat.com>
Date: Thu, 18 Sep 2025 08:38:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-11-edumazet@google.com>
 <513d3647-55a8-45ed-8c61-b7bf61eec9f4@redhat.com>
 <CANn89iJLC=sAS_9=dOaRv0P69+8cG8ZEW5boq9f4JxeXYDeBzQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJLC=sAS_9=dOaRv0P69+8cG8ZEW5boq9f4JxeXYDeBzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/25 6:32 PM, Eric Dumazet wrote:
> On Wed, Sep 17, 2025 at 9:15 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 9/16/25 6:09 PM, Eric Dumazet wrote:
>>> Move skb freeing from udp recvmsg() path to the cpu
>>> which allocated/received it, as TCP did in linux-5.17.
>>>
>>> This increases max thoughput by 20% to 30%, depending
>>> on number of BH producers.
>>>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> ---
>>>  net/ipv4/udp.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>> index 7d1444821ee51a19cd5fd0dd5b8d096104c9283c..0c40426628eb2306b609881341a51307c4993871 100644
>>> --- a/net/ipv4/udp.c
>>> +++ b/net/ipv4/udp.c
>>> @@ -1825,6 +1825,13 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
>>>       if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
>>>               sk_peek_offset_bwd(sk, len);
>>>
>>> +     if (!skb_shared(skb)) {
>>> +             if (unlikely(udp_skb_has_head_state(skb)))
>>> +                     skb_release_head_state(skb);
>>> +             skb_attempt_defer_free(skb);
>>> +             return;
>>> +     }
>>> +
>>>       if (!skb_unref(skb))
>>>               return;
>>
>> What about consolidating the release path with something alternative
>> like the following, does the skb_unref()/additional smp_rmb() affects
>> performances badly?
>>
>> Thanks,
>>
>> Paolo
>> ---
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index cc3ce0f762ec..ed2e370ad4de 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -1836,7 +1836,7 @@ void skb_consume_udp(struct sock *sk, struct
>> sk_buff *skb, int len)
>>          */
>>         if (unlikely(udp_skb_has_head_state(skb)))
>>                 skb_release_head_state(skb);
>> -       __consume_stateless_skb(skb);
>> +       skb_attempt_defer_free(skb);
> 
> This will not work, skb_attempt_defer_free(skb) wants to perform an skb_unref(),
> from skb_defer_free_flush()

Whoops, I missed that, thanks for pointing out!

I'm fine with this.

Cheers,

Paolo


