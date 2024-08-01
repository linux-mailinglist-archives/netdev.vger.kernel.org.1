Return-Path: <netdev+bounces-115001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2739B944E10
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2101F217A0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F531A31;
	Thu,  1 Aug 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqKeafmo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BF1E4AB
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522673; cv=none; b=hqA9tdicjPp3u+Xyyjr2+kQWF2QH9z2Lx9l1ZeZFCNmjpYNXti5R8SYLAYm6L+UdXnICDoAYpfOPn8VmiVaRC0Oa+rEc5lk5415ux1o8g/cCLR4ZYGVWYMxkFqCSPZ1r6jkaL78GesSVPFScJcSCaG9DaqMXgSM3ruN1weVGbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522673; c=relaxed/simple;
	bh=ENtCvcRenzl6Bx6mP+5RR0ettlSGFHjBT8v1sLaFNZs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QAVLsvb4aSXpuw+VCIEcToJWl0TEh8YfdqlUjMGuP3vwTsCyYsVNBdNJM0pnMn7OSDoyzDfjVetgfhqpZjGbCNJfPtmjG/hufGCRFHzI4QVkntnlXpSX9xT2Sfa0VeIrB2MmIxkk27rcqOGauqeHW6Q/ibmVPqDvvkmFAPhRftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqKeafmo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722522670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXdNNdQCLsX9fuzunWJ0RYw8CN3hw7rypg3fdF5shiA=;
	b=eqKeafmoe5owNEmPE4ucJ4g8MSgQdB8OB+7B8Uli7pQgvjcwnofZDMuPvrB0sAfiM/PLcX
	BUt3X0OjhwAdPhOrZZd8hu7WVfFjFF8ei9RYT4NexM4MSLDtrO6uBtovCuIdBqn0nR2gJ9
	PqkcwYeUuG7ti77NieMi2tbfNXaURaQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-jA66Y66QORi_7JnYj0IcSQ-1; Thu, 01 Aug 2024 10:31:08 -0400
X-MC-Unique: jA66Y66QORi_7JnYj0IcSQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef2b4482e5so15955371fa.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522667; x=1723127467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXdNNdQCLsX9fuzunWJ0RYw8CN3hw7rypg3fdF5shiA=;
        b=XFAOoPPoYn2JcFQS5pizftW0WURPEbiG9yHTd5+rpqPsmbfcflqoGB+booZqnuBisB
         llwIwiRNlUa21S7WG45hsPNhOSxTHlbjYII8BwiIkRNQHCblKD/ano7NmA4hq2AYdn7K
         XtBvFVuoNHuqBiE1EmssoxInQIDCGd23+8XVbmLAjLYSOZ0sOHcRFTHiT7AV2Aw+csvP
         +OqYJKFd80Hw7zlKOV5xeJu7DxGp4ILuogvUbZOxBxp4zcC0JbxaCBMWMEIdZ3fOLGqg
         45Gk1oK5RyBzm2ufDaocLFOC+wHeYPn9EFTAm1FlKCJMsbo10wjcr8ny0nCkJ+mJ4f4m
         F1hg==
X-Gm-Message-State: AOJu0YyZ1yHCyca+G6GVJBg4moO1b30y+m3PFXV1GQDF9I8QV1KCvv+i
	xJCuvABI8j13aNH+XJuzM15tPbCF0SzjnwaEE77yun0tzL5tvimdT9vMGJNDQ2j7NyCGKef+es0
	7vaoSVVOqlv6aWraUg3dD86sa91lKdLIhpnJZjihKWr5dhXgJg9pR+w==
X-Received: by 2002:a2e:87d4:0:b0:2ef:81:aa6 with SMTP id 38308e7fff4ca-2f15ab3fde2mr1751731fa.9.1722522667204;
        Thu, 01 Aug 2024 07:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4ngzbM9TMExdHa6mGwfjAwT/zP3M862SqZU4ZGogO7RiSbF07CTcL2y1hMEczfB+vhRP2Kg==
X-Received: by 2002:a2e:87d4:0:b0:2ef:81:aa6 with SMTP id 38308e7fff4ca-2f15ab3fde2mr1751611fa.9.1722522666499;
        Thu, 01 Aug 2024 07:31:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adaadsm61258015e9.12.2024.08.01.07.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 07:31:05 -0700 (PDT)
Message-ID: <07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com>
Date: Thu, 1 Aug 2024 16:31:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <m25xslp8nh.fsf@gmail.com>
Content-Language: en-US
In-Reply-To: <m25xslp8nh.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 23:13, Donald Hunter wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
> 
>> diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
>> new file mode 100644
>> index 000000000000..7327f5596fdb
>> --- /dev/null
>> +++ b/Documentation/netlink/specs/shaper.yaml
> 
> It's probably more user-friendly to use the same filename as the spec
> name, so net-shaper.yaml

No big objection on my side, but if we enforce 'Name:' to be $(basename 
$file .yaml), the 'Name' field becomes redundant.

[...]
>> +    render-max: true
>> +    entries:
>> +      - name: unspec
>> +        doc: The scope is not specified
> 
> What are the semantics of 'unspec' ? When can it be used?

I guess at this point it can be dropped. It was introduced in a previous 
incarnation to represent the port parent - the port does not have a 
parent, being the root of the hierarchy.

>> +      -
>> +        name: port
>> +        doc: The root for the whole H/W
>> +      -
>> +        name: netdev
>> +        doc: The main shaper for the given network device.
> 
> What are the semantic differences between netdev and port?

netdev == Linux network device
port == wire plug

>> +      -
>> +        name: queue
>> +        doc: The shaper is attached to the given device queue.
>> +      -
>> +        name: detached
>> +        doc: |
>> +             The shaper is not attached to any user-visible network
>> +             device component and allows nesting and grouping of
>> +             queues or others detached shapers.
> 
> I assume that shapers are always owned by the netdev regardless of
> attach status?

If you mean that it's up to the netdev clean them up on (netdev) 
removal, yes.

>> +>> +      -
>> +        name: inputs
>> +        type: nest
>> +        multi-attr: true
>> +        nested-attributes: ns-info
>> +        doc: |
>> +           Describes a set of inputs shapers for a @group operation
> 
> The @group renders exactly as-is in the generated htmldocs. There may be
> a more .rst friendly markup you can use that will render better.

Uhm... AFAICS the problem is the target (e.g. 'group') is outside the 
htmldoc section itself, I can't find any existing markup to serve this 
purpose well. What about sticking to quotes '' everywhere?

FTR, I used @ following the kdoc style.

[...]
>> +    -
>> +      name: group
>> +      doc: |
>> +        Group the specified input shapers under the specified
>> +        output shaper, eventually creating the latter, if needed.
>> +        Input shapers scope must be either @queue or @detached.
> 
> It says above that you cannot create a detached shaper, so how do you
> create one to use as an input shaper here? Is this group op more like a
> multi-create op?

The group operation has the main goal of configuring a single WRR or SP 
scheduling group atomically. It can creates the needed shapers as 
needed, see below.

The need for such operation sparks from some H/W constraints:

https://lore.kernel.org/netdev/9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch/

>> +        Output shaper scope must be either @detached or @netdev.
>> +        When using an output @detached scope shaper, if the
>> +        @handle @id is not specified, a new shaper of such scope
>> +        is created and, otherwise the specified output shaper
>> +        must be already existing.
>> +        The operation is atomic, on failures the extack is set
>> +        accordingly and no change is applied to the device
>> +        shaping configuration, otherwise the output shaper
>> +        handle is provided as reply.
>> +      attribute-set: net-shaper
>> +      flags: [ admin-perm ]
> 
> Does there need to be a reciprocal 'ungroup' operation? Without it,
> create / group / delete seems like they will have ambiguous semantics.

I guess we need a better description. Can you please tell where/how the 
current one is ambiguous?

Thanks,

Paolo


