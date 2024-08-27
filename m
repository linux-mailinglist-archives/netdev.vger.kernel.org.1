Return-Path: <netdev+bounces-122175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E879603AF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413E7B21094
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92571482E6;
	Tue, 27 Aug 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7mEJIPA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01949433D8
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745303; cv=none; b=Eygn2thvCmMLMUBPZkeCOvM/V1oehA7Doxm7xC7kUPiKVd93S7RPQr3KsYiy2fnioFAPwM31lBoQvph1aP4CPWRMawByV2DZq4G735bxlGXb4y5b5vNPKU6QzLbafS0KPl2snYAWCofftNhQebJF8FiqJmUBVzT0sBIfozApSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745303; c=relaxed/simple;
	bh=rYoONTNjD2DISWpSOaelDNyjaOOr/W5TbUVH3V68qvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPerOITPdp/2bl+R9IOdUDECDlFtuijtXvnYs3halLD6wR+nvTp2ikkFu32QPeIVxcFf+RjhBGHbcowEZGrLvzfJ/nj8XWs+jtkZYBN09inPk0eyEhLts7hDGp1PhmMzYBsj+kQyXaQrufnY2HNGe0NrFMr7HhR9UICUaOrs03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7mEJIPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724745300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7HqZk4LyvN6WhMaYb7yu4ztG7CW2OvDPQsufnBfYXI=;
	b=h7mEJIPAvksOrQBcQ/E6Y62XRsc5+tltZXG+wpv6N6kiNEAORAu8nQM6stKGhnUWP8voXi
	lCq09pV5KtFDBA9vOyq/7Qx4PMWwh5X1LPzvZgjkDGUtwEoxMEe2HTFBuzmd9MKDiz5ecx
	scRxsaJM4vuujChrQdeq+OSohlIAaEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-1KaRYvfRNz2lApjmiciA3A-1; Tue, 27 Aug 2024 03:54:56 -0400
X-MC-Unique: 1KaRYvfRNz2lApjmiciA3A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371881b6de3so3131882f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745295; x=1725350095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7HqZk4LyvN6WhMaYb7yu4ztG7CW2OvDPQsufnBfYXI=;
        b=vlY1t3Ou54sl5GfUwrB0rC51JuybJI+cnnIrXqGTF9d89m2BADwUf/KsCf2IusLBi9
         QiNBvPVUjVAHqo+2GiMm05A6ez/vcwGb2ifdyWYQxilfvbqQovRMkqbJHztGlhZmt7fJ
         Brux8mYlZWPXdSf3if2bWINTNLvWVKkMqbIXNrkgBfHWmkvjpoh3c6dNH3xJEJaIn5qW
         qFa/ioMNv51a1paFV1VnjzbguI8emrKfHUBb3DKTbXQVEDRj5P0tBsvjKvBW54y8WnuE
         ySk/ajfy3L6Sh6TIsxD1fxfugp85hqu2ycNq2Z7YvH+Bmr7e/rTxEBLT84XsP//WHG0w
         qB+w==
X-Gm-Message-State: AOJu0YxsgNP9v3uF0cAiaeHPvDFUpXnC33G96yYaqAL0NvZhe3/LM6cd
	gxt7maDLk5N7FQlS7A0TtfDvpGKNx0WPE6FrT7vECz6lmQCdKb6bYv0MoHn2rOLiDfQ/Itd3SjP
	0hhYWXzY6PgIVp5a0l0rWlQtpWCqs1ihUo+wE9NRy2rtpD7zPoTXkUw==
X-Received: by 2002:a5d:6901:0:b0:367:9851:4f22 with SMTP id ffacd0b85a97d-3748c82cda8mr1350842f8f.58.1724745295432;
        Tue, 27 Aug 2024 00:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv7Y0lu1cGl4um4/khA8w7cx56aV5+ettR/FxTE4XgPqkk7V6C6BZ5hVjjbx1ORX3u+UBKpg==
X-Received: by 2002:a5d:6901:0:b0:367:9851:4f22 with SMTP id ffacd0b85a97d-3748c82cda8mr1350825f8f.58.1724745294838;
        Tue, 27 Aug 2024 00:54:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff633sm12474250f8f.77.2024.08.27.00.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:54:54 -0700 (PDT)
Message-ID: <1a364cc3-3b22-447d-bfa8-376de41d1f64@redhat.com>
Date: Tue, 27 Aug 2024 09:54:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <20240822174319.70dac4ff@kernel.org>
 <d9cfa04f-24dd-4064-80bf-cada8bdcf9cb@redhat.com>
 <20240826191413.1829b8b6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240826191413.1829b8b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 04:14, Jakub Kicinski wrote:
> On Fri, 23 Aug 2024 09:51:24 +0200 Paolo Abeni wrote:
>> On 8/23/24 02:43, Jakub Kicinski wrote:
>>> On Tue, 20 Aug 2024 17:12:21 +0200 Paolo Abeni wrote:
>>>> * Delegation
>>>>
>>>> A containers wants to limit the aggregate B/W bandwidth of 2 of the 3
>>>> queues it owns - the starting configuration is the one from the
>>>> previous point:
>>>>
>>>> SPEC=Documentation/netlink/specs/net_shaper.yaml
>>>> ./tools/net/ynl/cli.py --spec $SPEC \
>>>> 	--do group --json '{"ifindex":'$IFINDEX',
>>>> 			"leaves": [
>>>> 			  {"handle": {"scope": "queue", "id":'$QID1' },
>>>> 			   "weight": '$W1'},
>>>> 			  {"handle": {"scope": "queue", "id":'$QID2' },
>>>> 			   "weight": '$W2'}],
>>>> 			"root": { "handle": {"scope": "node"},
>>>> 				  "parent": {"scope": "node", "id": 0},
>>>
>>> In the delegation use case I was hoping "parent" would be automatic.
>>
>> Currently the parent is automatic/implicit when creating a node directly
>> nested to the the netdev shaper.
>>
>> I now see we can use as default parent the current leaves' parent, when
>> that is the same for all the to-be-grouped leaves.
>>
>> Actually, if we restrict the group operation to operate only on set of
>> leaves respecting the above, I *guess* we will not lose generality and
>> we could simplify a bit the spec. WDYT?
> 
> I remember having a use case in mind where specifying parent would be
> very useful. I think it may have been related to atomic changes.
> I'm not sure if what I describe below is exactly that case...
> 
> Imagine:
> 
> Qx -{hierarchy}---\
>                     \{hierarchy}-- netdev
> Q0-------P0\ SP----/
> Q1--\ RR-P1/
> Q2--/
> 
> Let's say we own queues 0,1,2 and want to remove the SP layer.
> It's convenient to do:
> 
> 	$node = get($SP-node)
> 	group(leaves: [Q0, Q1, Q2], parent=$node.parent)
> 
> And have the kernel "garbage collect" the old RR node and the old SP
> node (since they will now have no children). We want to avoid the
> situations where user space has to do complex transitions thru
> states which device may not support (make sure Q1, Q2 have right prios,
> delete old RR, now we have SP w/ 3 inputs, delete the SP, create a new
> group).

FTR, while updating the group() implementation to infer the root's 
parent handle in most cases, I stumbled upon a similar scenario.

> For the case above we could technically identify the correct parent by
> skipping the nodes which will be garbage collected later. 

I think that implementation would be quite non trivial/error prone, and 
I think making the new root's parent explicit would be more clear from 
user-space perspective.

What I have now in my local tree is a group() implementation the 
inherits the newly created root's parent handle from the leaves, if all 
of them have the same parent prior to the group() invocation. Otherwise 
it requires the user to specify the root's parent handle. In any case, 
the user-specified root's parent handle value overrides the 
'inherited'/guessed one.

It will cover the above and will not require an explicit parent in most 
case. Would that be good enough?

Thanks,

Paolo


