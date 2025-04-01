Return-Path: <netdev+bounces-178568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EDAA77961
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69A816AF0F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77B1F1539;
	Tue,  1 Apr 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVPQvJ+t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7451F03C1
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506022; cv=none; b=QAg8ijm2FXatTwJwF3lVYXtj6TfVKM/fNYDf5rL8qIZt3QtlfwiM8b94Eg8gSTofNdMW2NLP11M5QHYKhdBXBUK1OFTiX2i6JlFAM6evAXW9+DgmeewY2BT5Q0fq6OJKfdmHYBmZBjlBbozIKaRB0xqB4/IGCB8/GQB7/K/hLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506022; c=relaxed/simple;
	bh=eXuN+GYWt27q9quy/yiuSyZGCuDlUf8hAuxc9QFf05A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI8jXpZdA+cLumFAK0Pd+qKI3ZUvD6nOk+BT1Z+FGWU8a3PkaDTb417rsilultUp7t4Y9WeOTZlFSYZjyMjHBLQLymrctmIjBYsmDihffrkjMG+ulwQWmJ9IRb5ltM6e8HArGtCS4kx77R32aSmCJdi8fkd18icpmGLm7keHgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVPQvJ+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743506019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyuutc9PeXY9tGsltbN84zDiDd1XgKUjGnAvVE3myf0=;
	b=eVPQvJ+t39bdP9V7cK+6EYkGGh77n5Q/Za8ZpOqRWHxWVlhagJI4tMFPR97FrWmzYLcOk1
	AqnIQ8VGIMBMEe6/4GI6geGZsKQnKaX31gfLmVtsiS1ZIwn9m1MzxTd65NazqPjfq++9MM
	JdnylS7xAGShs5Cb4kYPaRAHuc+BVyU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-F-SgJszUNmG0tGrOsSIQlw-1; Tue, 01 Apr 2025 07:13:38 -0400
X-MC-Unique: F-SgJszUNmG0tGrOsSIQlw-1
X-Mimecast-MFC-AGG-ID: F-SgJszUNmG0tGrOsSIQlw_1743506017
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d6c65dc52so36608525e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743506017; x=1744110817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyuutc9PeXY9tGsltbN84zDiDd1XgKUjGnAvVE3myf0=;
        b=Grt1d8d3SVMbO6Vg6QhI8KQTr028CpGk0tPUL0uK37ri4WCTGzjlvVhswXVaEaM09h
         p0P43aLub2E2eYyXi1DsdgIOxMH9X9AT16x2A9wfK51Qz3QAq1oY7ge4C2n9htuWo7r6
         PfI+XaSvlIrI6OW5HgW+WTbnemkJHkxjtf5MU0kMkrx8YExVWOCUZi/Y/pxiCKD1cSU9
         TbqztO63Hts8VROYg10l/GS313UzyJakQcBtOTgasWOMsNXtIhC8htWBcoDTTyoQBYDo
         PwadUCPLQh7DfkKMzn77pUWlTpQS2usEI6apcqlQQ7ZrQhdMRLoPeYyAgR2p8RBl9Jzh
         z8tw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ElBkJzx9XodpP7Bf3yIUmfJIiL22iaI9xBIHVbW1OfRMt49XVQw+nfARu4NHCaYNTzdMsDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyoGM0DDSocAW/VYpM2LDspjV+/QlCLm7ydEiMvpruaCppKO+
	1LyAQRbiVHxvTeeZ/N09HycNUXAt/EVFLDJb2OPy2A41vo5ViPLyZ5Jai/JGhfuSqOaKh811Pys
	+uJttgh0fYeJnvBtXnPABxgXFgbhz7d7+Xt4HjsK31YmOWFxuSvrCJg==
X-Gm-Gg: ASbGncsNEnXZ23a+ZfjLIA74euz47kb/RkanBawx+PtoNXgA0FueXQa+9WUyNKvV6I8
	uuTERvNMHlV9nSiPbuGEdE7gUVTqdLW6O+Zn/7OvRbaIbXqo/xR7Ems316UQw3eh6Rru1lN65H0
	KSn2nt7L/q6G1ipaGFemuj9LqNVssGdmSjynAf8nxb+o7/yJywxtwibI+mAoXWOganjZEXWE+4O
	aqbq79mFypL7rv97qPrnRZu/608cwPKq9orXjy7en609M98yeF9ViXRR8Vs1ce6jQmFheqIqAV2
	ma3h7WRXRr5Z8qd7yH+jPfsXM+ZMVTP3w3x69LRKAQLvMQ==
X-Received: by 2002:a05:600c:3150:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-43dbc6f89f7mr80386005e9.28.1743506017498;
        Tue, 01 Apr 2025 04:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB1t2RowSwKmhupv9C7Srpftmd9msTTSzuOJ2YeoUsVGmOMoMK48qhVxxi7g9VgrKpY/0h5Q==
X-Received: by 2002:a05:600c:3150:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-43dbc6f89f7mr80385735e9.28.1743506017118;
        Tue, 01 Apr 2025 04:13:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fba3b13sm157751425e9.3.2025.04.01.04.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:13:36 -0700 (PDT)
Message-ID: <18c69469-5357-422e-a7dd-9722d502fd95@redhat.com>
Date: Tue, 1 Apr 2025 13:13:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net_sched: sch_sfq: use a temporary work area for
 validating configuration
To: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Octavian Purdila
 <tavip@google.com>, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
References: <20250328201634.3876474-1-tavip@google.com>
 <20250328201634.3876474-2-tavip@google.com>
 <Z+nYlgveEBukySzX@pop-os.localdomain>
 <5f493420-d7ff-43ab-827f-30e66b7df2c9@redhat.com>
 <CANn89iJW0VGQMvq6Bs8co8Bq6Dq1dUT7TN+EXg=GwYbSywUz0A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJW0VGQMvq6Bs8co8Bq6Dq1dUT7TN+EXg=GwYbSywUz0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/1/25 12:47 PM, Eric Dumazet wrote:
> On Tue, Apr 1, 2025 at 11:27 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 3/31/25 1:49 AM, Cong Wang wrote:
>>> On Fri, Mar 28, 2025 at 01:16:32PM -0700, Octavian Purdila wrote:
>>>> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
>>>> index 65d5b59da583..027a3fde2139 100644
>>>> --- a/net/sched/sch_sfq.c
>>>> +++ b/net/sched/sch_sfq.c
>>>> @@ -631,6 +631,18 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
>>>>      struct red_parms *p = NULL;
>>>>      struct sk_buff *to_free = NULL;
>>>>      struct sk_buff *tail = NULL;
>>>> +    /* work area for validating changes before committing them */
>>>> +    struct {
>>>> +            int limit;
>>>> +            unsigned int divisor;
>>>> +            unsigned int maxflows;
>>>> +            int perturb_period;
>>>> +            unsigned int quantum;
>>>> +            u8 headdrop;
>>>> +            u8 maxdepth;
>>>> +            u8 flags;
>>>> +    } tmp;
>>>
>>> Thanks for your patch. It reminds me again about the lacking of complete
>>> RCU support in TC. ;-)
>>>
>>> Instead of using a temporary struct, how about introducing a new one
>>> called struct sfq_sched_opt and putting it inside struct sfq_sched_data?
>>> It looks more elegant to me.
>>
>> I agree with that. It should also make the code more compact. @Octavian,
>> please update the patch as per Cong's suggestion.
> 
> The concern with this approach was data locality.

I did not consider that aspect.

How about not using the struct at all, then?

	int cur_limit;
	// ...
	u8 cur_flags;

the 'tmp' struct is IMHO not so nice.

> I had in my TODO list a patch to remove (accumulated over time) holes
> and put together hot fields.
> 
> Something like :
> 
> struct sfq_sched_data {
> int                        limit;                /*     0   0x4 */
> unsigned int               divisor;              /*   0x4   0x4 */
> u8                         headdrop;             /*   0x8   0x1 */
> u8                         maxdepth;             /*   0x9   0x1 */
> u8                         cur_depth;            /*   0xa   0x1 */
> u8                         flags;                /*   0xb   0x1 */
> unsigned int               quantum;              /*   0xc   0x4 */
> siphash_key_t              perturbation;         /*  0x10  0x10 */
> struct tcf_proto *         filter_list;          /*  0x20   0x8 */
> struct tcf_block *         block;                /*  0x28   0x8 */
> sfq_index *                ht;                   /*  0x30   0x8 */
> struct sfq_slot *          slots;                /*  0x38   0x8 */
> /* --- cacheline 1 boundary (64 bytes) --- */
> struct red_parms *         red_parms;            /*  0x40   0x8 */
> struct tc_sfqred_stats     stats;                /*  0x48  0x18 */
> struct sfq_slot *          tail;                 /*  0x60   0x8 */
> struct sfq_head            dep[128];             /*  0x68 0x200 */
> /* --- cacheline 9 boundary (576 bytes) was 40 bytes ago --- */
> unsigned int               maxflows;             /* 0x268   0x4 */
> int                        perturb_period;       /* 0x26c   0x4 */
> struct timer_list          perturb_timer;        /* 0x270  0x28 */
> 
> /* XXX last struct has 4 bytes of padding */
> 
> /* --- cacheline 10 boundary (640 bytes) was 24 bytes ago --- */
> struct Qdisc *             sch;                  /* 0x298   0x8 */
> 
> /* size: 672, cachelines: 11, members: 20 */
> /* paddings: 1, sum paddings: 4 */
> /* last cacheline: 32 bytes */
> };
> 
> 
> With this patch :
> 
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 65d5b59da583..f8fec2bc0d25 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -110,10 +110,11 @@ struct sfq_sched_data {
>         unsigned int    divisor;        /* number of slots in hash table */
>         u8              headdrop;
>         u8              maxdepth;       /* limit of packets per flow */
> -
> -       siphash_key_t   perturbation;
>         u8              cur_depth;      /* depth of longest slot */
>         u8              flags;
> +       unsigned int    quantum;        /* Allotment per round: MUST
> BE >= MTU */
> +
> +       siphash_key_t   perturbation;
>         struct tcf_proto __rcu *filter_list;
>         struct tcf_block *block;
>         sfq_index       *ht;            /* Hash table ('divisor' slots) */
> @@ -132,7 +133,6 @@ struct sfq_sched_data {
> 
>         unsigned int    maxflows;       /* number of flows in flows array */
>         int             perturb_period;

Would it make any sense to additionally move 'maxflows' and
'perturb_period' at the top, just after 'perturbation'?

Thanks,

Paolo


