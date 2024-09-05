Return-Path: <netdev+bounces-125587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F696DC62
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514F21F2129D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C47344C;
	Thu,  5 Sep 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqw5ddVM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02917BC9
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547868; cv=none; b=qXs2NOFUdDXmGZDp5G3LG65N5IcOlNsP5P9uk36IC0kqG/KQBSGo+L3jwN9x7anyF4sNRrvEpdpu6QjoU0whIEeqmZJlD8LhGAo2eME7PEVcJ1QqLZNiwAvbNxO7uAjLImxPQa6IpIzrBAxaomy1p0whlG/rB9v28tJgdXuccvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547868; c=relaxed/simple;
	bh=DXnE+H4PA15l2efCjpToTy4stM4DGyHdIRIGqpAVubQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZYsA7ZI9XahcbuCRhknBlq648AWVtbqEodYlBZpovwVIP/nYgTDXI9KoQFZ1LRE04Cf/gdnHOyhK7Z2FCfIfQUSeShx17WlWyDaM4g2kqGAHzsk+Ghp3US34LApzVw2zw1V6c8iYBvtWc6i11hvb3AUz11fCwDTpukOiaPb/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oqw5ddVM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725547866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjDLxH2EfA3DU902vxXAkThT3VRFvWvYfVI7PX/CbZY=;
	b=Oqw5ddVMQHCNoKGX39asWT/qydiyMYh6GHR9m+4XjV+svqTeduJpDBsQ8x5zTFwjsB+XkQ
	kIt2IRuP/1Ez+7F5XNQw2/IYO1oPC6nAiNy2a98qwAQzpXfA0aXSbSI+ihwiW5NirtkDAs
	aqVg8QxMh7mGMBA/hldr3ifXucPPSTg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-mTEiDwFuOfOSrK5rSietJw-1; Thu, 05 Sep 2024 10:51:05 -0400
X-MC-Unique: mTEiDwFuOfOSrK5rSietJw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb2899d57so7822495e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 07:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547864; x=1726152664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjDLxH2EfA3DU902vxXAkThT3VRFvWvYfVI7PX/CbZY=;
        b=gv4sh0Ys+2IlcRMa5b6nI/3EnJDfh1K3FY9nopU2Aav895L7gPJ0pwirEenfNjd+s6
         XZpmAQLAQLEYUlEzc6bdLxE4TND8q6LJwkRCTQD6NbFqhbQhnUePDfhwK3lP1VGwUgO0
         aMwrpjxUCsn1YHVnuuPDOLt7IFA5bt1OqB35wIeB5sk6cBr+ip+SWLzUiqwp2VIS6L7g
         84QcWZAySKApSeHSq9uFiBmNFQgG2MPSevsEEDpx8YaA3JaW645Yh07QAX9uD2m6RDSu
         jD+s4N5I2CU+q4XuNPY8PrmvQZfz0wJod8lInzLB0q9uKFB+sb627M6rVEBteFIjlKm/
         YUnQ==
X-Gm-Message-State: AOJu0YwqlzHyEm5PpyqUzyuBY3UcyQheFEvgTUen2lpAnRdHOgo3XtZC
	o8MbVzaVEJhu5JqkCqLhDwVOAMM6SdHx5YzCE5GgNplCbvFYnACLUNVjSUlYjKOC9TdsfMoCI22
	k+BT9q2x7d4J7hU2VsxYkMHe1u9jKDXtHnL8FUYCLx2ePGnAsZh+X2g==
X-Received: by 2002:a05:600c:1c0d:b0:426:62df:bdf0 with SMTP id 5b1f17b1804b1-42c9544efe0mr44830035e9.10.1725547863787;
        Thu, 05 Sep 2024 07:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+mxxSbfA8ZexGHgb2jl/rcVnqHxUEl8BQPmLlO1R2KY8k74Z16bOlqrrkUBsrNQuk+5Wy/A==
X-Received: by 2002:a05:600c:1c0d:b0:426:62df:bdf0 with SMTP id 5b1f17b1804b1-42c9544efe0mr44829735e9.10.1725547863293;
        Thu, 05 Sep 2024 07:51:03 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639643esm276394535e9.1.2024.09.05.07.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:51:02 -0700 (PDT)
Message-ID: <d4a8d497-7ec8-4e8b-835e-65cc8b8066b6@redhat.com>
Date: Thu, 5 Sep 2024 16:51:00 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240904180330.522b07c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

oops,

I unintentionally stripped the recipients list, in my previous reply. 
Re-adding all of them. I'm sorry for the duplicates.

On 9/5/24 03:03, Jakub Kicinski wrote:
> On Wed,  4 Sep 2024 15:53:34 +0200 Paolo Abeni wrote:
>> +      -
>> +        name: node
>> +        type: nest
>> +        nested-attributes: node-info
>> +        doc: |
>> +           Describes the node shaper for a @group operation.
>> +           Differently from @leaves and @shaper allow specifying
>> +           the shaper parent handle, too.
> 
> Parent handle is inside node scope? Why are leaves outside and parent
> inside? Both should be at the same scope, preferably main scope.

The group() op receives as arguments, in the main scope:

ifindex
node
leaves

'parent' is a nested attribute for 'node', exactly as 'handle'. We need 
to specify both to identify the 'node' itself (via the 'handle') and to 
specify where in the hierarchy the 'node' will be located (via the 
'parent'). Do I read correctly that you would prefer:

ifindex
node_handle
node_parent
leaves
?

I think the former is more clean/clear.

>> +      -
>> +        name: shaper
>> +        type: nest
>> +        nested-attributes: info
>> +        doc: |
>> +           Describes a single shaper for a @set operation.
> 
> Why does this level of nesting exist? With the exception of ifindex
> all attributes for SET are nested inside this..

Yep, we can drop the nesting level, I think. I used the nesting to be 
have a syntax similar to the with group() operation.

Thanks,

Paolo


