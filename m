Return-Path: <netdev+bounces-180200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4AA805EA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0580C188588F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3926A0FA;
	Tue,  8 Apr 2025 12:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FA26156E
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114472; cv=none; b=khNzUVCU9WH3fElUkQvzQc7mFKeh4QUrgyePWB1qfAuFIPPugtBxIBhz7vUQ23LX9d1ixOR276J7DrdP+9ZUZKVHw+Hm4PDmPUU/BJYUDRnAc/8Qd16NNAPJosezdyIBKp++AZGAhWHEU/HaMdrR9w0vpWy9AAR+l/7txknsJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114472; c=relaxed/simple;
	bh=Uuxh+Z6zisebBjdHxvzZB0InN02+vNPY39kZcrsUF4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUzGXC00cdBhXrV0+/xqzSHC4W1twIaCjRDxw1pLiYFaonVEsq3KTI+yn+zvqnP0sAewsmPMhw2YbnKU1w24g/QiVm/PgetybNn1IrN8Ef+PlQCTG6ZDgEpZsxUlA5r8q8saAnfcLBGR/1Z2HR0NhDNFQs+l/+mQbJUokHhTD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39d83782ef6so390394f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 05:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744114468; x=1744719268;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdsaHdCDds221ADrjohxLQMxcyyQbQKtVMJ7OJStf4o=;
        b=peW5nBEAXmgdMVktXVKX5yw81XRcGt0dbfWsjsiD2mGyFk1DTbXd9S/FSn3yELLUpT
         JHayieoTFI5rSy2ntLJZvebRDYWSV/oNBXXRVFkK4VuWBRT0022iEQPehgeZh3qfsjpy
         HqwwuVihXyX2moXnGK8C/CF1zglKZFiS7nsf52yFhHzejKF10Z+r2PpkAi/SppT5OGCz
         upbrt1tWYt3V5K/H/PD4Bi4ZSIaRqwUgZEEIdxTMDtWw/1BX8uA8Xn8XmL5sSomjNYSi
         gs5y8sDfKCjY7cJN61zyhGQqwtM5qX9jf1iMcyYdgEBhijH2Jztq2JDEE+SqNPOsLwwg
         Mg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVkjwP/NOyMFMUHzF141XOsGWTEcJG3BDZ1yi8C5Ej9vRXhBfssx9yJ9Q1LTGIQk+QTo7KTihM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/szl7NwPz7bfvTcVYjcCsYmF0UD4+4mxgqd6Qptct8DAjwz8
	xoUbRML39Q4C/gmAxStapRfmfvNKUuC1/bGodqbQKKVlj8XQA6mZ
X-Gm-Gg: ASbGncvI4SjRFy5XUOY6akmdVYSmFqdgt2Ymen1grRYZ+2VLswcmSTzHExakmXUEAjT
	+Q1HuzAsthARjsdGgakmS95rWf8lAHKfSg8y8MOxJHn5z8RzBIb4dkyPiIre1iNCHzIq85Ebc2x
	HyVTvRNVqU0sVrOMC7ktDz5JEJeb7c7FZT/09TdJw4Ed5g8gLfHkybRJSwoog/hCwPtJ0nYL2UN
	7fRVFZXIFB4Qk8xBCI923UfTmOcr+vTYVciMPP3O88n+hTaE3tzCdr5XZ7bM3Jvik0/Cxajm7wk
	3RRtW0zBfsChjJ8KXdo8MFw/GnbLXRXcpqpZ5emNG7zjb3bvlUpZFtMe14Vl4+cPNs92tbFya3G
	mGw==
X-Google-Smtp-Source: AGHT+IEjk3XnIJ77/ZFYuLW6AX2hFJiVzbw9FYmBh+POr9SF4t7waITxph+rV+9ZktCRiPS7S0v4jg==
X-Received: by 2002:a05:6000:22c7:b0:39b:fa24:9523 with SMTP id ffacd0b85a97d-39d820acaf4mr2861643f8f.7.1744114468115;
        Tue, 08 Apr 2025 05:14:28 -0700 (PDT)
Received: from [192.168.0.234] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795630sm167093295e9.29.2025.04.08.05.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 05:14:27 -0700 (PDT)
Message-ID: <20a20b0b-237c-42d2-8d17-a07ec87347c1@ovn.org>
Date: Tue, 8 Apr 2025 14:14:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, i.maximets@ovn.org
References: <20250407112923.20029-1-toke@redhat.com>
 <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/25 9:56 PM, Jamal Hadi Salim wrote:
> On Mon, Apr 7, 2025 at 7:29 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> While developing the fix for the buffer sizing issue in [0], I noticed
>> that the kernel will happily accept a long list of actions for a filter,
>> and then just silently truncate that list down to a maximum of 32
>> actions.
>>
>> That seems less than ideal, so this patch changes the action parsing to
>> return an error message and refuse to create the filter in this case.
>> This results in an error like:
>>
>>  # ip link add type veth
>>  # tc qdisc replace dev veth0 root handle 1: fq_codel
>>  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 33); do echo action pedit munge ip dport set 22; done)
>> Error: Only 32 actions supported per filter.
>> We have an error talking to the kernel
>>
>> Instead of just creating a filter with 32 actions and dropping the last
>> one.
>>
>> Sending as an RFC as this is obviously a change in UAPI. But seeing as
>> creating more than 32 filters has never actually *worked*, it could be
>> argued that the change is not likely to break any existing workflows.
>> But, well, OTOH: https://xkcd.com/1172/
>>
>> So what do people think? Worth the risk for saner behaviour?
>>
> 
> I dont know anyone using that many actions per filter, but given it's
> a uapi i am more inclined to keep it.
> How about just removing the "return -EINVAL" then it becomes a
> warning? It would need a 2-3 line change to iproute2 to recognize the
> extack with positive ACK from the kernel.

The warning is hard to act upon programmatically.  If some software is
trying to install those rules, it would expect a failure code if the
actions cannot be actually installed.  It's also not common to handle
extack in a success scenario.  Besides, TCA_ACT_MAX_PRIO itself is part
of uAPI, it makes sense to be that violation of this limit should cause
a failure.  Truncating the chain may cause unexpected consequences for
the user, i.e. traffic handled incorrectly, unless the user happened
to parse extack, which is not really machine-readable.

Throughout the years we've been adding extra validation to various parts
of tc, and these would also technically be uAPI changes.  I'm not sure
why this change would be any different.  In OVS we've been struggling for
a long time with various kernel inconsistencies in tc netlink API and
are forced to request ECHO for each request and compare rules we request
with what kernel actually installed [1].  This is a significant performance
and complexity burden that I hope can go away eventually.

To my knowledge, OVS doesn't hit this particular issue with the number of
actions, at least I've never seen it, but it's still a problem that the
kernel behavior is inconsistent.

So, I'd vote for adding the proper validation and allow users to detect
those failures when they happen.

Best regards, Ilya Maximets.

[1] https://github.com/openvswitch/ovs/commit/464b5b13e6d251c65b3158af5df16057243f1619

> 
> cheers,
> jamal
> 
> 
>> [0] https://lore.kernel.org/r/20250407105542.16601-1-toke@redhat.com
>>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  net/sched/act_api.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>> index 839790043256..057e20cef375 100644
>> --- a/net/sched/act_api.c
>> +++ b/net/sched/act_api.c
>> @@ -1461,17 +1461,29 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
>>                     struct netlink_ext_ack *extack)
>>  {
>>         struct tc_action_ops *ops[TCA_ACT_MAX_PRIO] = {};
>> -       struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
>> +       struct nlattr *tb[TCA_ACT_MAX_PRIO + 2];
>>         struct tc_action *act;
>>         size_t sz = 0;
>>         int err;
>>         int i;
>>
>> -       err = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla, NULL,
>> +       err = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO + 1, nla, NULL,
>>                                           extack);
>>         if (err < 0)
>>                 return err;
>>
>> +       /* The nested attributes are parsed as types, but they are really an
>> +        * array of actions. So we parse one more than we can handle, and return
>> +        * an error if the last one is set (as that indicates that the request
>> +        * contained more than the maximum number of actions).
>> +        */
>> +       if (tb[TCA_ACT_MAX_PRIO + 1]) {
>> +               NL_SET_ERR_MSG_FMT(extack,
>> +                                  "Only %d actions supported per filter",
>> +                                  TCA_ACT_MAX_PRIO);
>> +               return -EINVAL;
>> +       }
>> +
>>         for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
>>                 struct tc_action_ops *a_o;
>>
>> --
>> 2.49.0
>>


