Return-Path: <netdev+bounces-125620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0A96DF5D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E6D1C22852
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550619C579;
	Thu,  5 Sep 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QankzAG5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274B47F69
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553070; cv=none; b=VgYXOjHz9Vgv9ok3h5a0pQZQyuM6L5Zbfe1UbO4BwmT99OT0QaUEYu4ioahstVfDox2TIFcptr9kVuXAeB1IYglIZ81u6ZUZW0euC1pluKd+a88p6rrGIhJJdKGwsok5VWIjIEpuShHEVfUXtJL4+7mSsUIJPP+xKEdQQxmTxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553070; c=relaxed/simple;
	bh=TtkVEd7odVy9sS0nFNXSGIiJsEOWc6az6pfqn5WX9qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uU6OnDUNOoKs/KmHAjSgHzSZg45OxAfJsdbnM0B8El2gjIWXwrUOdpqRYzfHonYUuNkmpFrfrMdeKJCLXys6txEBSQzpLgGKIDqcezv2obw1I75jPHr22XAlxr31OMLKH/NMIIlxpMz463+w4raRP16ukCbhVeaa1MY8jWMJnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QankzAG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725553067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaE5XqWoFR9AdfJpm9q1/ADqgtzDcMWaCwCzCaQbFu4=;
	b=QankzAG5YXiX0tAxHM3aCiwo5QvmjnjdVyrH7WlSukHmP4ucTJafjH2A/r+6PnVFeJAkD/
	dC0DzlCK1+I6yB17rkAdVM7BwRqvZqbmeo0tlucdvEL4VGClPLNB+rQl/s5lMGg6AzqxFW
	pbbyEWGX1G8SXkvUamNL6YxZm3txat4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-WJzf_4JJPh-rr67nDRmt3g-1; Thu, 05 Sep 2024 12:17:46 -0400
X-MC-Unique: WJzf_4JJPh-rr67nDRmt3g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3756212a589so687213f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 09:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725553065; x=1726157865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaE5XqWoFR9AdfJpm9q1/ADqgtzDcMWaCwCzCaQbFu4=;
        b=etuwBXtDTJb4ewRjc88oBdXxHrWM2h4jUNMG5EvE7ny2/EN5ACl+kuFVeU9eY54xHc
         w+HXUSqZZgIP7fzURgnA6IRfTxA311IS6FCzB5QJrWXR3fRXafM6pZrzNE3qARAVbwEl
         kH+btvQY5qkmRbWT9sNQU70FT0to/iYygWLcXYL6KYDVFqHQYCl60LGVJGQ1I4MBQlsR
         ruJYaZIJGFTk7C0CN4KX7KpccEeBhbz4S0XL1+w2LnurEpKsIHb9c/TbR91X2YHoNYdI
         lbFpbqxycSZw+cGnwmYFJU8a+gbpA0jRU81xRq97wKgrhottCp+urGln8oH1anRrdpRT
         HsKw==
X-Gm-Message-State: AOJu0YzFWFbT5K0TJrv1/kidpg5RamTmrAvNaDf5hrRnMxsAf6aRCypy
	EeVAQfW05bck/Ttw2W1/ul4eXD5TrlJ5v3Kehbu0NbTQdZmla9WyUdtkFS2p/Z9BTq4W45rbWSk
	dAe4IL7PUnbKxmk4YMbqXaSFQ0Hc8Ne77+KNEAv1zQn5Poy7Pzghu1Q==
X-Received: by 2002:adf:f7c8:0:b0:374:c512:87ce with SMTP id ffacd0b85a97d-374c5128a82mr12130910f8f.30.1725553065031;
        Thu, 05 Sep 2024 09:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvu/apiMAq4RvAl5wSKKN+12JGeZYYbO4xdhF9luYBHaFwsBjDjg3e4qWvyCzXP2gyQw0nog==
X-Received: by 2002:adf:f7c8:0:b0:374:c512:87ce with SMTP id ffacd0b85a97d-374c5128a82mr12130890f8f.30.1725553064557;
        Thu, 05 Sep 2024 09:17:44 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e109sm19554723f8f.67.2024.09.05.09.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:17:44 -0700 (PDT)
Message-ID: <46484afd-7b50-465d-b763-0ac60201bd3d@redhat.com>
Date: Thu, 5 Sep 2024 18:17:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 02/15] netlink: spec: add shaper YAML spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1725457317.git.pabeni@redhat.com>
 <a0585e78f2da45b79e2220c98e4e478a5640798b.1725457317.git.pabeni@redhat.com>
 <20240904180330.522b07c5@kernel.org>
 <d4a8d497-7ec8-4e8b-835e-65cc8b8066b6@redhat.com>
 <20240905080502.3246e040@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905080502.3246e040@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 17:05, Jakub Kicinski wrote:
> On Thu, 5 Sep 2024 16:51:00 +0200 Paolo Abeni wrote:
>> On 9/5/24 03:03, Jakub Kicinski wrote:
>>> On Wed,  4 Sep 2024 15:53:34 +0200 Paolo Abeni wrote:
>>>> +      -
>>>> +        name: node
>>>> +        type: nest
>>>> +        nested-attributes: node-info
>>>> +        doc: |
>>>> +           Describes the node shaper for a @group operation.
>>>> +           Differently from @leaves and @shaper allow specifying
>>>> +           the shaper parent handle, too.
>>>
>>> Parent handle is inside node scope? Why are leaves outside and parent
>>> inside? Both should be at the same scope, preferably main scope.
>>
>> The group() op receives as arguments, in the main scope:
>>
>> ifindex
>> node
>> leaves
>>
>> 'parent' is a nested attribute for 'node', exactly as 'handle'. We need
>> to specify both to identify the 'node' itself (via the 'handle') and to
>> specify where in the hierarchy the 'node' will be located (via the
>> 'parent'). Do I read correctly that you would prefer:
>>
>> ifindex
>> node_handle
>> node_parent
>> leaves
> 
> I don't see example uses in the cover letter or the test so there's
> a good chance I'm missing something, but... why node_parent?
> The only thing you need to know about the parent is its handle,
> so just "parent", right?
> 
> Also why node_handle? Just "handle", and other attrs of the node can
> live in the main scope.

I added the 'node_' prefix in the list to stress that such attributes 
belong to the node.

In the yaml/command line will be only 'handle', 'parent'.

> Unless you have a strong reason to do this to simplify the code -
> "from netlink perspective" it looks like unnecessary nesting.
> The operation arguments describe the node, there's no need to nest
> things in another layer.

Ok, the code complexity should not change much. Side question: currently 
the node() operation allows specifying all the b/w related attributes 
for the 'node' shaper, should I keep them? (and move them in the main 
yaml scope)

Thanks,

Paolo


