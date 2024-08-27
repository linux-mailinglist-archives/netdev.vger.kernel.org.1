Return-Path: <netdev+bounces-122165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC1960370
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AD11C22715
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485CC158218;
	Tue, 27 Aug 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaQz+IjN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEC156887
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744513; cv=none; b=UJuw2lKlV447iLIHVROoNAFDoIbo1ikJ5kK2iXoN60XESDruAq3oNLDsXgfT+WskmhOglqkPWMOFqbg5RgOin0NRoJWQyI8dkeNMMc9VnuoGilyBAUFDLf3eDghSqpKWE1I7lqS2T7EEOxfY+d0k38j8iDfixYlmV/hc/1JRQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744513; c=relaxed/simple;
	bh=zelOIQePu7H4uuGbqSZhIFcd309RvgW1+Nbh7fryVXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pow98YyFqPbVgGdwfywzdeKNGkMqiRxyLy+0seIYZRWvW69cgCWfhw4oyd2tvOmQOaYPWid1wPHQzWlLPLRzZHUDco5+kav36mdBaGlD5/7qWo9t+f9dL+d2u8QZ4kECs6dxFAdsCgbmhMLFPwDAOszX8lTWBWOcKA213OS5Auo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaQz+IjN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724744510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rkmXht8ELAj8/Z1M413Q0lIBoYimB7MGM/7Iwz5T8A=;
	b=FaQz+IjNFlkQBHmaMoBMncLsxfmX+eBc9ruWcd2oiECpmeES9GL3W0cCTsoPefCNSVsmrx
	XUhEbLo7aFtpbzZ/X1GjDDp/E2wBEDzyT5usKSesh6DeHqKB/0lS034lPaKyPUXMYWVc7Q
	TGRdCufih90MkQJ63CMy4yU3CujnlW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-fHDbzGZENvitnAgV0xE2MQ-1; Tue, 27 Aug 2024 03:41:48 -0400
X-MC-Unique: fHDbzGZENvitnAgV0xE2MQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-371ab0c02e0so4193426f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744507; x=1725349307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rkmXht8ELAj8/Z1M413Q0lIBoYimB7MGM/7Iwz5T8A=;
        b=aRkyQeucr0cVJnhYrKA6PwX21TIJeD//+mtse6W6uuovY7vLzM/KI+QIuToSva9a6R
         JP+dFORM47TBCHv71X0SSzaDoPdA1s3VS83YnvpjJAAGSM2AwGLR9ws8sLwpoIVrbbcG
         PL9nNSSphFUgH8/GBlA3+8yFtVVLPgWy5QspLG1MdQt7h3HSWdxBQ3cNUG0YID7l849I
         Uvf+HVaBMCkquyUgywh0NRucZZmc9vBBwtRXn0lArwJFmOR/meFrTR9pFZ7U9zaamYjE
         X/GU4xZ4K7y3R2bpZWyVm8Sbd7VeK6GL7QfapPi6IHZ4uQn5j28nFl5mQdzwldzPjVwm
         0djA==
X-Gm-Message-State: AOJu0YxBxUDVanjVbs9WnBwuAmQONC+wGY+dzzBvn32fHMYNYDPIHOnE
	gyNlB+D5Stm2+U7kf0e62JtOnR9Ads3AN2q1epiwPygYgx11PRJRQEaYsChe1sCZnYDWQNhJJ7F
	KFCfkzhQS/4a2tGgXEy69i0qSWwgWTJoORyi65z8IhutghugrRUvf7w==
X-Received: by 2002:adf:a3cd:0:b0:371:869b:4e5e with SMTP id ffacd0b85a97d-3731184053emr10030767f8f.1.1724744507339;
        Tue, 27 Aug 2024 00:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZE9Kc58SP3ARGp/nCOgTYwrQVtiO2LVg9tB14o5e4cuJhSWDcyiBRkvA+vZ7QJnBkKXp9g==
X-Received: by 2002:adf:a3cd:0:b0:371:869b:4e5e with SMTP id ffacd0b85a97d-3731184053emr10030747f8f.1.1724744506777;
        Tue, 27 Aug 2024 00:41:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ffb4dsm12470636f8f.74.2024.08.27.00.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:41:46 -0700 (PDT)
Message-ID: <db504183-1019-4fbb-bee9-7fc19f8bbe7d@redhat.com>
Date: Tue, 27 Aug 2024 09:41:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
 <20240822184824.3f0c5a28@kernel.org>
 <ad5be943-2aa6-4f60-be90-929f889e6057@redhat.com>
 <20240826185055.38e1857f@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240826185055.38e1857f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 03:50, Jakub Kicinski wrote:
> On Fri, 23 Aug 2024 10:35:05 +0200 Paolo Abeni wrote:
>>>> +        name: node
>>>> +        doc: |
>>>> +             The shaper allows grouping of queues or others
>>>> +             node shapers, is not attached to any user-visible
>>>
>>> Saying it's not attached is confusing. Makes it sound like it exists
>>> outside of the scope of a struct net_device.
>>
>> What about:
>>
>>     Can be placed in any arbitrary location of
>>     the scheduling tree, except leaves and root.
> 
> Oh, I was thinking along the same lines above.
> Whether "except leaves or root" or "inner node" is clearer is up to you.

I agree "inner node" should be clear.

>>>> +      -
>>>> +        name: weight
>>>> +        type: u32
>>>> +        doc: |
>>>> +          Weighted round robin weight for given shaper.
>>>
>>> Relative weight of the input into a round robin node.
>>
>> I would avoid mentioning 'input' unless we rolls back to the previous
>> naming scheme.
> 
> Okay, how about:
> 
> 	Relative weight used by a parent round robin node.

Fine by me.

>>>> +           Differently from @leaves and @shaper allow specifying
>>>> +           the shaper parent handle, too.
>>>
>>> Maybe this attr is better called "node", after all.
>>
>> Fine by me, but would that cause some confusion with the alias scope
>> value?
> 
> But to be clear, the "root" describes the node we're creating, right?

Yes. I guess the possible confusion I mentioned will not be so 
confusing, after all. I'll go with this option.

Thanks,

Paolo


