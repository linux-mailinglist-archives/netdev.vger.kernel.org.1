Return-Path: <netdev+bounces-269352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMkfKTOxu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:17:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144272C7BE3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88AF031BD44E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990B3A6404;
	Thu, 19 Mar 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTS8pdAh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t1Imbv9j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7873A9620
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908114; cv=none; b=MgETHhFlMMceWBw2kDvWmF0c3ehbMyHT94S5YaSR5V/3358QMaJ8yUrF3Rbytwy/HsasEo6u6uu7QdEOjlJvsOy3shT9VSiMwSPSAmr89/ykP9fjU3MrQ7uyUClGQC5pe3CekLhYyR7z8FN8sU3weP6+TgDM2RKUotiwXORXaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908114; c=relaxed/simple;
	bh=QANDCGLwr0Rsph14eghi4C+OqJMt6Szo+XgLHBQngJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnyLlWh+9rNgQIbQwjXKzVCP8QTTRZr3yYG3Q1Z8jsP+7DvpWN79QLo7ape37JoiDbS57G5edtbsidxTebfa47Tqf2Qq5oiMLxr9naxgcxIZv6YcjUwaq0hDkTZL3Vnmp0gyoe3MKK5j4+JPTV6wk+gtvoS+7JRPpLzZiybDH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTS8pdAh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t1Imbv9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773908111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQwb/jbYCyylu7ufKUxxowBWIvCxOUbZAHno6gx/wM8=;
	b=iTS8pdAhB7DcHT3Br/KjUI21mfv3SWbKRXcHFkDFwBf5DVCLhJSYISSRRef9L1TuDV+ejC
	vdYpr1O31Wr1ILYHuCe3l3gjYWi0aSVHfOgFLgQGrT+Y3L/4+OO71LHV4ncV7sdv01rZam
	pCMZ0oKGAe1G2QDVKLmPtucIvxpsWiI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-F3mOmlDEN0u7bsAoQDC_ag-1; Thu, 19 Mar 2026 04:15:09 -0400
X-MC-Unique: F3mOmlDEN0u7bsAoQDC_ag-1
X-Mimecast-MFC-AGG-ID: F3mOmlDEN0u7bsAoQDC_ag_1773908108
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b47c19ed8so484203f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773908108; x=1774512908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQwb/jbYCyylu7ufKUxxowBWIvCxOUbZAHno6gx/wM8=;
        b=t1Imbv9j/e6hw7XS1ouBSd/haJaNcjAJYBjw4OGlkABVV/lEb6ipMtLDqa84sioeQT
         nK/6Vjh2bu5bbzmECOSTqjj/KijBEKmKnvwf+LS0Js1+Q79+emlLo6UDkynwLUaU/2tk
         N743OQbTAo8C81Qz/igjfe0eHnq4EkSJFKnvVrnVBo0840fquhOexp5pqC9M5wjQ2wF0
         tMb2Fi/0P20EBUvXPs7IwVQO7Bvlr/gmS2JmS7ZfCovFo2nxMOEzeKqd//k74nYbbXwq
         dgbcEYTnG8Rf58aVZLnMcSrlaENPWo911SQ7bpflqb5ADMdJ2UV9TsHoPO6No75bi7Xz
         3Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908108; x=1774512908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQwb/jbYCyylu7ufKUxxowBWIvCxOUbZAHno6gx/wM8=;
        b=Yis/H3IPQbpcLPuZJ5f4M+VeSRV/Y0R4nVVJWTtWvekvftV0nZgiQTd7cFNjHRn2YB
         89Gzx0ZrBdQuILSOG5eitHVCn3XO5TTja4TDr+LfSqF4H6hd6jrQ9HlMtivKoscmfBnw
         gBzuBpdW/ttiy5TLGp2b4ybLrBfl3kPyY+oNIglB8crbH0tfSp25T3yfhhA9FnPWTonF
         bpsqxnpld2t76Ewjm+q/Krj32UGYkPOfxMFa8MSXIr2XeMONuRIS/2W85hfVz5W3+gN7
         V1fBN4e9hEp9eBJNpLSOPDZdBUq4BhTm2qj6qXRJnWHqG7y5b3a83rdyAZhnnSZjdm0X
         3yrw==
X-Gm-Message-State: AOJu0YwFMY0zKP+BpuzUVB4IKHDQeZKTB3xQJ/c0sdwm2xJzYT3rHYGH
	ZEBeJzCr7reAF7LER3b5vvc3Eqc2ehWFECdC1BP2HazASWGlW19/kvuBj9m20Mi+h8gmQByuudV
	mOwLQYtg7GFBlM6el4NWETci2HdtjnxiqUDoK1s1YZJR4S8YYSv4IFr953w==
X-Gm-Gg: ATEYQzzBEUv073nMZQgZgQ33WDtgnn27mSSgjezdmdzgZlBaubdR63q+pXCA8yED4BX
	d3yuajKFG3D8ShR8zDAg+pO2qKlLwT65gOhb9Rl2pgyjw/KqaP1tan43SKqPtMbHihPA0WoDmx8
	4na9ByRdZEPKfD43ESv9K23rCzjHEl6UVk74EGTmBB1AU3vHemeNGYD/65OlCX235Ka59rnh+CL
	7WTDtVo2pYBqkCgnUu+WsKi8a1XaD0/RDcJXKLys0npedujdC3U4e0RQ5K3KVsAVG3sMVoaa/pG
	ey8F5WOSccIxWkon1zudFB3Way5bJrHbpPaWzRUnhxZ2eQPiwMi6cD/RA9RWgzoPIqDdeSg09Gw
	cGoWzJHeb4pqQEu1UxQNP3I899BijqOJBQuXTSFv2v34VFgS9uZrsmiZi
X-Received: by 2002:a05:6000:420f:b0:439:f64b:a82b with SMTP id ffacd0b85a97d-43b527a4623mr11039696f8f.6.1773908108427;
        Thu, 19 Mar 2026 01:15:08 -0700 (PDT)
X-Received: by 2002:a05:6000:420f:b0:439:f64b:a82b with SMTP id ffacd0b85a97d-43b527a4623mr11039647f8f.6.1773908107942;
        Thu, 19 Mar 2026 01:15:07 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184961csm15529582f8f.6.2026.03.19.01.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 01:15:07 -0700 (PDT)
Message-ID: <6be7d6f0-08ce-466c-87cc-bc2ad3f26aab@redhat.com>
Date: Thu, 19 Mar 2026 09:15:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
 <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,solid-run.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-269352-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 144272C7BE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 3/18/26 5:11 AM, Jason Wang wrote:
> On Wed, Mar 18, 2026 at 12:07 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Fri, Mar 13, 2026 at 3:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>> index 75dabb763c65..48de4a16a96a 100644
>>> --- a/include/linux/virtio_net.h
>>> +++ b/include/linux/virtio_net.h
>>> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>>>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
>>>  }
>>>
>>> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
>>> +                                        struct virtio_net_hdr *hdr,
>>> +                                        bool little_endian)
>>> +{
>>> +       u16 hdr_len;
>>> +
>>> +       hdr_len = skb_transport_offset(skb);
>>> +
>>> +       if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
>>> +               hdr_len += sizeof(struct udphdr);
>>> +       else
>>> +               hdr_len += tcp_hdrlen(skb);
>>
>> Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
>>
>>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
>>                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
>>                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
>>                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
>>                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
>>                         hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>>         else
>>                         return -EINVAL;
>>
>> To be more robust, I'd suggest moving it there.
>>
>> But I have another question, the logic above depends on the headlen is
>> correctly set:
>>
>>                 /* This is a hint as to how much should be linear. */
>>                 hdr->hdr_len = __cpu_to_virtio16(little_endian,
>>                                                  skb_headlen(skb));
>>
>> Is the headlen guaranteed to be correct in all cases (e.g for nested
>> setups or dodgy packets?)
> 
> Speak too fast, I miss
> 
> hdr_len = skb_transport_offset(skb);
> 
> This is probably another call to
> 
> 1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
> 2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().

It looks like that the above leads to more complex code with a bunch of
additional conditionals, which possibly the compiler can't optimize out,
and IMHO not nice layering violation, see the already mentioned previous
iteration:

https://lore.kernel.org/all/cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com/

What about instead simply rename virtio_net_set_hdrlen() to
__virtio_net_set_hdrlen(), virtio_net_set_tnl_hdrlen() to
__virtio_net_set_tnl_hdrlen(), and add explicitly mention in a comment
that such functions must be invoked only after virtio_net_hdr_from_skb()
validation?

/P


