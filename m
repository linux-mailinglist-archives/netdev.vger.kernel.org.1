Return-Path: <netdev+bounces-122161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2F960349
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004CEB2260C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AB158D79;
	Tue, 27 Aug 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnMrOiD2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C085192594
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744183; cv=none; b=G/7s9RTbSvsC3jdxQ6bPRnAzjlAKR5atJKMtlupsfVjpeQapa6t49RpcrVgvyyHkH1WF7b2ZUtIWc6xwwuk2RR+WFEq/apFQNXBYNfr8LjWveQZw8xsO6grB3Ahv9w1FUUu6kCyhAYZyKQZZd2PAJv8m0xsWvrUU0iKsNkaUR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744183; c=relaxed/simple;
	bh=GS7NIROer0N7jdT2XAq7ukHZhWnhYgni1yTkl9nePnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sqif0OQa0N3WoZktsU1TSZ+tiOK/C7E/ZleAfAh0ZTgAfjhyQTsdOzgzqKA1Sxf2b76aoe1opjLVyrC/jr7VtesBanS9Opx3gWh0xJh6jWix/SjtxxlDOLBGDG3B39Ch8zGlR6TGECh2u/j3bywMW1td0d/WU7U51L8Awv8AXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnMrOiD2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724744180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LsZphpGyQjEKKfv5ANUImVoE/5KSt/7XDVfbDuFFCbg=;
	b=BnMrOiD2m9H1vev62QFqknYm/PCNESHYo96icX7hiiFYpFnVqCBBGsjGqWUkcDjH5AoYiU
	LJnqVhxO2VZ3FHhYgiQ5UGjEOlQ8z5Tg0ofs/BNnLnS2bqN3F5gThWZ3XADf7SGg+a1y+5
	Te0zETR5M+RfzRYzPbmE0PhhvbGyLHA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-FeXQKxSvNG6rycoRaut_zg-1; Tue, 27 Aug 2024 03:36:19 -0400
X-MC-Unique: FeXQKxSvNG6rycoRaut_zg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso48305635e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744178; x=1725348978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsZphpGyQjEKKfv5ANUImVoE/5KSt/7XDVfbDuFFCbg=;
        b=AAqN+lL5E15TxOUnlCTlR+JglTvzYs5WhU2zD4vyCFDvW0thXMvZY0lhq4wKnwBpum
         frFic+9CL6neMioQPZUqCuEFrCprOnls7BqOAjmMVEU7PjGnIubA538VgxJ31Bl4mENB
         IJJKZlSrZRdtHaAE/iR7iobm9f5XPhL1qGHJmqZ72jTbGjxP/gU2h4lnLeDtfUgXXVaG
         xTB3KfEpzqEJyGIG2ijvWzhvbjCY3tf7WrHAqekBKm1r7HlA7d/BynhDjxEJoIbjvREK
         w7U9L2jK2iOBCGOhpF4m9JFPaEBZVESAiBcLHF/eb/e8ldOnnqp2nkXVSm+kp7+CrMKS
         IqLw==
X-Gm-Message-State: AOJu0YwnOzNWNqrWBFrdc5pylURDr405y8/jdeWp2fxi7rn4fJ37kpcO
	tRyDMD04e2FNNKaJC/IqYzqQXdzU+tK7+GzdZY7+CDzMDDuAV9JnBKAnjxTdgnHkIKMEQx5C42E
	DBbEgu9FEkIxJa8BfFfHG5A5fKy0R0//6lV/O7K1Of+BY3evqa3aWsA==
X-Received: by 2002:a05:600c:3c90:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-42b9ae247abmr13456295e9.29.1724744177829;
        Tue, 27 Aug 2024 00:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm47AyuEz110b144AegRCrXe/dhTUT0kcMyP02h/3EXfAZJ8CQjbimTuZa8RA50K6xQ+Rgkg==
X-Received: by 2002:a05:600c:3c90:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-42b9ae247abmr13456015e9.29.1724744177386;
        Tue, 27 Aug 2024 00:36:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb6bsm12442373f8f.21.2024.08.27.00.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:36:16 -0700 (PDT)
Message-ID: <47cde674-9f24-4b14-a3d2-216904617c8f@redhat.com>
Date: Tue, 27 Aug 2024 09:36:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 03/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <c5ad129f46b98d899fde3f0352f5cb54c2aa915b.1724165948.git.pabeni@redhat.com>
 <20240822191042.71a19582@kernel.org>
 <0e5c2178-22e2-409e-8cbd-9aaa66594fdc@redhat.com>
 <20240826185555.3f460af4@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240826185555.3f460af4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/24 03:55, Jakub Kicinski wrote:
> On Fri, 23 Aug 2024 10:52:04 +0200 Paolo Abeni wrote:
>>>> + * comprising the shaper scope and a scope-specific id.
>>>> + */
>>>> +struct net_shaper_ops {
>>>> +	/**
>>>> +	 * @group: create the specified shapers scheduling group
>>>> +	 *
>>>> +	 * Nest the @leaves shapers identified by @leaves_handles under the
>>>> +	 * @root shaper identified by @root_handle. All the shapers belong
>>>> +	 * to the network device @dev. The @leaves and @leaves_handles shaper
>>>> +	 * arrays size is specified by @leaves_count.
>>>> +	 * Create either the @leaves and the @root shaper; or if they already
>>>> +	 * exists, links them together in the desired way.
>>>> +	 * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
>>>
>>> Or SCOPE_NODE, no?
>>
>> I had a few back-and-forth between the two options, enforcing only QUEUE
>> leaves or allowing even NODE.
>>
>> I think the first option is general enough - can create arbitrary
>> topologies with the same amount of operations - and leads to slightly
>> simpler code, but no objections for allow both.
> 
> Ah, so we can only "grow the tree from the side of the leaves",
> so to speak? We can't create a group in the middle of the hierarchy?

With the posted code, we can't. It can be implemented, but I think it 
will make the interface confusing.

> I have no strong use for groups in between, maybe just mention in
> a comment or cover letter.

I'll do, thanks.



> 
>>>> +static int net_shaper_fill_handle(struct sk_buff *msg,
>>>> +				  const struct net_shaper_handle *handle,
>>>> +				  u32 type, const struct genl_info *info)
>>>> +{
>>>> +	struct nlattr *handle_attr;
>>>> +
>>>> +	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC)
>>>> +		return 0;
>>>
>>> In what context can we try to fill handle with scope unspec?
>>
>> Uhmm... should happen only in buggy situation. What about adding adding
>> WARN_ON_ONCE() ?
> 
> That's better, at least it will express that it's not expected.

I added the WARN in my local build, and that reminded me the tree root 
(netdev) has UNSPEC parent. So I think we are better off with simply a 
comment there.

Thanks,

Paolo


