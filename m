Return-Path: <netdev+bounces-122372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FE960DBA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B84528504A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7511C462C;
	Tue, 27 Aug 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu1mC7A+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774A1A08A3
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769466; cv=none; b=ZtuV+h71zEKHOJXh8df8BipHon5YMwyrqDxGoEi+L9bWDj9+tqnPv/ebAjFVaV7563xrgYy6C/T4z9J5huKTkxOlv6N3ECWAqsAz3BrmX/7ATctV9wE4uISd+T083HB7iV7FjqGA+cz/S+Wc7OfS6hWdTaj01nQV95S89XUHGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769466; c=relaxed/simple;
	bh=/VSWJxpbeKbERts67JOYEZWcbCN2U58acHAy4yrCB1I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BVzxnTeX0uOjsrcU95xkCP+M68eHrIwwwRkDaPjBwIHS7JL+Hh7ojxFxfIzguNZWhhgS5tk2b11eTx9TmFWeiG/BhhhUR+ZL6hqmC+1e8eJqyg22lW2LIott1eTPxlC0ovfZ0fPJzjdgroC9ljNq4R9+xVhpc3qoIompxUjt9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iu1mC7A+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724769463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEhcbeXRJn5xtFQ8a897zYLaPxadlkDTNr9MeXDdA2s=;
	b=Iu1mC7A+TGqQX06pdeA/iPMHS8T/seov5aAmZtXa1pkSw7d9SVjRPgQQgniztCZxXf4P72
	gjI5nQ+naCorfeB0GgM+oL2hSDlJzgTG7VmHlaKR+sskpS+8GqombSlkVBlT22t3OALgGR
	Y5HgCfKKuUhMVVxijYeAyL26tiHnLO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-tFtvVvhYPr-RiFC6ua11Fw-1; Tue, 27 Aug 2024 10:37:42 -0400
X-MC-Unique: tFtvVvhYPr-RiFC6ua11Fw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367990b4beeso2843942f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769461; x=1725374261;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEhcbeXRJn5xtFQ8a897zYLaPxadlkDTNr9MeXDdA2s=;
        b=sgN9sRxCa11rRMe2qgJAa79vnEZUTN5HPUOF6zWiJ/eG73vNrkmi8fJIY0AK8eCn//
         DMiWl1/PVQffQeidvKRmeugFAFZzAsvzHtpp8GYG0JWGLtI/vjlX0dZBH1OF0Cz/HKeH
         Y8f9tPsZq2Yw/AT4j2jXpRVHL3onOhFQxixfIURBA/2WeBskgumQa+J/KX+liotWpE27
         HXEnmzujv5/KyqHl7uCCE0qFiWg42PSKiQGiey/4UzLY9YyrjVByZu4ql1+c6hIVeMMP
         c/4Sim67F2OMVjYrNiodnRA1mh5O+tBXTMYsUlq0FnD6rb+IsOz/4SNixCEmPIn99y29
         dcxA==
X-Gm-Message-State: AOJu0YziLMh64FpjR2I9Kj7oAQzPEXGSqhxiluV9YL7iK3ot+dfMVfV5
	i8JiC1ewULpVaLInp0vSWPHIrT14XhslQougC2xtYDwKZXY3QSIDpR6Jlfj9QRi1s76k6QYZIbp
	NwAwsDJHIXZ+ujblqYaCMHG8M6ND1DcBkOWu3xwOv4JYv6INpg21pLg==
X-Received: by 2002:a5d:66c1:0:b0:371:882d:ce9d with SMTP id ffacd0b85a97d-373118643dbmr8728168f8f.36.1724769461322;
        Tue, 27 Aug 2024 07:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJu/KLQ1cDHcg02QLVSVBXPQJsUybfFeaGE1FTFZSuU7LYsAIKcvnqm75d/ZyUL2959xTnVA==
X-Received: by 2002:a5d:66c1:0:b0:371:882d:ce9d with SMTP id ffacd0b85a97d-373118643dbmr8728145f8f.36.1724769460803;
        Tue, 27 Aug 2024 07:37:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410:c8c6:fe2f:6a21:6a5a? ([2a0d:3344:1b67:7410:c8c6:fe2f:6a21:6a5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5159450sm188000645e9.17.2024.08.27.07.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:37:40 -0700 (PDT)
Message-ID: <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
Date: Tue, 27 Aug 2024 16:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion> <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
 <20240822155608.3034af6c@kernel.org> <Zsh3ecwUICabLyHV@nanopsycho.orion>
 <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion>
 <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
 <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
Content-Language: en-US
In-Reply-To: <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 11:31, Jiri Pirko wrote:
> Fri, Aug 23, 2024 at 04:23:30PM CEST, pabeni@redhat.com wrote:
>> On 8/23/24 15:36, Jiri Pirko wrote:
>>> Fri, Aug 23, 2024 at 02:58:27PM CEST, pabeni@redhat.com wrote:
>>>> I personally think it would be much cleaner to have 2 separate set of
>>>> operations, with exactly the same semantic and argument list, except for the
>>>> first argument (struct net_device or struct devlink).
>>>
>>> I think it is totally subjective. You like something, I like something
>>> else. Both works. The amount of duplicity and need to change same
>>> things on multiple places in case of bugfixes and extensions is what I
>>> dislike on the 2 separate sets.
>>
>> My guestimate is that the amount of deltas caused by bugfixes and extensions
>> will be much different in practice with the two approaches.
>>
>> I guess that even with the net_shaper_ops between devlink and net_device,
>> there will be different callbacks implementation for devlink and net_device,
>> right?
>>
>> If so, the differentiated operation list between devlink and net_device will
>> trade a:
>>
>> {
>> 	struct {net_device, netlink} =
>> net_shaper_binding_{netdevice_netlink}(binding);
>>
>> preamble in every callback of every driver for a single additional operations
>> set definition.
> 
> So?

The amount of code we would need to change in case of core changes would 
probably be similar with either the differentiated operations list or not.

>> It will at least scale better with the number of driver implementing the
>> interface.
>>
>>> Plus, there might be another binding in
>>> the future, will you copy the ops struct again then?
>>
>> Yes. Same reasons of the above.
> 
> What's stopping anyone from diverging these 2-n sets? I mean, the whole
> purpose it unification and finding common ground. Once you have ops
> duplicated, sooner then later someone does change in A but ignore B.
> Having the  "preamble" in every callback seems like very good tradeoff
> to prevent this scenario.

The main fact is that we do not agree on the above point - unify the 
shaper_ops between struct net_device and struct devlink.

I think a 3rd party opinion could help moving forward.
@Jakub could you please share your view here?

Thanks,

Paolo


