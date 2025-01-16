Return-Path: <netdev+bounces-158807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAFDA13550
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E581886AD7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721919343E;
	Thu, 16 Jan 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH5Gn2pi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97614901B
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016236; cv=none; b=rp/p/wzdoYWKyRjJeIjwCFMLxXiBYtRW7DtbasDUtPNumD4QuysN9YIv9pO6BCJ8cWv8GeLEIlkCGedN/fKUe0OwoDNbi2mn2zZUUd9l9lPpKdA4gXnvD+qFy/f6hvRQTG2qhRvvyKNwryES86ZJZgpqPTPYITezKOtDFKLM2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016236; c=relaxed/simple;
	bh=2eztsll2IUwic4A2wJw5RVW5Iwnl6vtFO+h654v6qos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6JulBb/WS7Jo4sggyhJC09v/YPp4sn20r/OLfiNLTyzRtKrWu/p4ezNDdRWeCzOTLv9nGkttIJkIRh2qkSeZ9QljEipHX6yMEK/SBBWOSOT8AITdhiNsqj13IDnCVHSiZ+XMd9cNsdzvr+OA5hv2dY66MmTrCmLyJZVGreMEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fH5Gn2pi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737016232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZEUIROfCyIJHCHTs67tueEcM2jD78mmO9ooAQHY0yk=;
	b=fH5Gn2pi/k2VZpvMcz2m4We6W73w4LU/qioYx5+fnMGNv/wf86Vbxw8MILQzTq0a4cyEob
	lMCbn7gQ90y0okOxi90E675LQwMAbBQLlFSpnBnVGNdmpN2PHl43ESrstYuUxOaOJ4r2rJ
	Gm+Rnp5H4/85tyjP59/6JP1XUgafTto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-o3y51tg2Oi-8ja-9GZDg2Q-1; Thu, 16 Jan 2025 03:30:29 -0500
X-MC-Unique: o3y51tg2Oi-8ja-9GZDg2Q-1
X-Mimecast-MFC-AGG-ID: o3y51tg2Oi-8ja-9GZDg2Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43625ceae52so2726345e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 00:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737016228; x=1737621028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZEUIROfCyIJHCHTs67tueEcM2jD78mmO9ooAQHY0yk=;
        b=GuEcCzYeH5PhUl0uc3S0waNvTw2LXwgyTmvsCKJ5bWqQcykD52JbioHAUqHc7aQw8p
         fp5isbCHpa1yXnU6PRhWd5+5ZxK2tsveJOy4EndxglQ4ZZEsN4zusYuhnA77t8RzWBYZ
         XS3fsV2ImJRawmDmO68GUWaNS5HG4GC+Ewv39qiPdVq0NbuX+Fz/j/LrNtkbS5/Upo6x
         0oZoOFJxJXlgMhFpF5p+Cp6QHmYflXC5SwqSIDdpB4Mktp3Fgy+B+GvOAO5B+9TN9dfA
         Ffv2hnc1qMnY6sss1bwzlUxeFWxBR0WWuHlo38kLRVXzusw7K7VcrUAdDa4Pm4i6o9P3
         5ObQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJd2Y553XiTKmJ7QWShNr+jKGihxqsbZCpWhKbBiCHtZgF1kbLjjzzKLCTfeSzCX2V8M+dnz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uLDLlygBHySP485GjmXQDdCj7bTbDCiOjKO9ldy62EOEJ6DF
	iyS6BrUkG7pgWO9NaHl9ocgJYgpnSSxqDtLynelJHbrDMm0xkLoaAE6GG632qzOJWyGxpcEK3lq
	TO9wQsD+sfAoDzjF8T7INqGKqgIGv6Wif9UQUjexaqfnmZCW58ncpvQ==
X-Gm-Gg: ASbGnctXEMxfqy3/TeIVH26tK0fjoj8gnMy/2A+2uSecJ40aMlavcJg9JEEHQBC2Ypp
	x0reUXsjiKIY/s0edKZtk1TzJg7tzkgqqP7iVRjdZKH8HuDPCbF5Y5GfPSewmHnLvaFkU3aps0b
	uS5nYLFKcMosGmeloXGHrFOV/FNHyrSTBKU85iODDF9IuL8Bk4PQ9V5TCc7Ck5jlK4WmxRHrEAX
	AdFai5JSikFkJyzS67CKL49DxfLJNPaAOUChm1aOUCSfgtF5a24ovTP1lBt/x4EzT9sGJ6icaZg
	zHuQqyNHuHU=
X-Received: by 2002:a05:600c:3403:b0:435:b064:7dce with SMTP id 5b1f17b1804b1-436f5881e7amr202155475e9.18.1737016228488;
        Thu, 16 Jan 2025 00:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPrV96aV7twv8muydNx92g+OaEo99Iw1nAHPgeYJuiraeo+QDDiA2MyvmPqhMhKNCQKQ7fsA==
X-Received: by 2002:a05:600c:3403:b0:435:b064:7dce with SMTP id 5b1f17b1804b1-436f5881e7amr202155065e9.18.1737016228043;
        Thu, 16 Jan 2025 00:30:28 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c697sm20168955f8f.52.2025.01.16.00.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:30:27 -0800 (PST)
Message-ID: <66ba9652-5f9e-4a15-9eec-58ad78cbd745@redhat.com>
Date: Thu, 16 Jan 2025 09:30:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
To: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 petrm@mellanox.com, security@kernel.org, g1042620637@gmail.com
References: <20250111145740.74755-1-jhs@mojatatu.com>
 <Z4RWFNIvS31kVhvA@pop-os.localdomain> <87zfjvqa6w.fsf@nvidia.com>
 <CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>
 <Z4iM3qHZ6R9Ae1uk@pop-os.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z4iM3qHZ6R9Ae1uk@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/16/25 5:36 AM, Cong Wang wrote:
> On Mon, Jan 13, 2025 at 06:47:02AM -0500, Jamal Hadi Salim wrote:
>> On Mon, Jan 13, 2025 at 5:29 AM Petr Machata <petrm@nvidia.com> wrote:
>>>
>>>
>>> Cong Wang <xiyou.wangcong@gmail.com> writes:
>>>
>>>> On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
>>>>> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
>>>>> index f80bc05d4c5a..516038a44163 100644
>>>>> --- a/net/sched/sch_ets.c
>>>>> +++ b/net/sched/sch_ets.c
>>>>> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
>>>>>  {
>>>>>      struct ets_sched *q = qdisc_priv(sch);
>>>>>
>>>>> +    if (arg == 0 || arg > q->nbands)
>>>>> +            return NULL;
>>>>>      return &q->classes[arg - 1];
>>>>>  }
>>>>
>>>> I must miss something here. Some callers of this function don't handle
>>>> NULL at all, so are you sure it is safe to return NULL for all the
>>>> callers here??
>>>>
>>>> For one quick example:
>>>>
>>>> 322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
>>>> 323                                 struct gnet_dump *d)
>>>> 324 {
>>>> 325         struct ets_class *cl = ets_class_from_arg(sch, arg);
>>>> 326         struct Qdisc *cl_q = cl->qdisc;
>>>>
>>>> 'cl' is not checked against NULL before dereferencing it.
>>>>
>>>> There are other cases too, please ensure _all_ of them handle NULL
>>>> correctly.
>>>
>>> Yeah, I looked through ets_class_from_arg() callers last week and I
>>> think that besides the one call that needs patching, which already
>>> handles NULL, in all other cases the arg passed to ets_class_from_arg()
>>> comes from class_find, and therefore shouldn't cause the NULL return.
>>
>> Exactly.
>> Regardless - once the nodes are created we are guaranteed non-null.
>> See other qdiscs, not just ets.
> 
> The anti-pattern part is that we usually pass the pointer instead of
> classid with these 'arg', hence it is unsigned long. In fact, for
> ->change(), classid is passed as the 2nd parameter, not the 5th.
> The pointer should come from the return value of ->find().
> 
> Something like the untested patch below.
> 
> Thanks.
> 
> ---->
> 
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index f80bc05d4c5a..3b7253e8756f 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -86,12 +86,9 @@ static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
>  	return 0;
>  }
>  
> -static struct ets_class *
> -ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
> +static struct ets_class *ets_class_from_arg(unsigned long arg)
>  {
> -	struct ets_sched *q = qdisc_priv(sch);
> -
> -	return &q->classes[arg - 1];
> +	return (struct ets_class *) arg;
>  }
>  
>  static u32 ets_class_id(struct Qdisc *sch, const struct ets_class *cl)
> @@ -198,7 +195,7 @@ static int ets_class_change(struct Qdisc *sch, u32 classid, u32 parentid,
>  			    struct nlattr **tca, unsigned long *arg,
>  			    struct netlink_ext_ack *extack)
>  {
> -	struct ets_class *cl = ets_class_from_arg(sch, *arg);
> +	struct ets_class *cl = ets_class_from_arg(*arg);
>  	struct ets_sched *q = qdisc_priv(sch);
>  	struct nlattr *opt = tca[TCA_OPTIONS];
>  	struct nlattr *tb[TCA_ETS_MAX + 1];
> @@ -248,7 +245,7 @@ static int ets_class_graft(struct Qdisc *sch, unsigned long arg,
>  			   struct Qdisc *new, struct Qdisc **old,
>  			   struct netlink_ext_ack *extack)
>  {
> -	struct ets_class *cl = ets_class_from_arg(sch, arg);
> +	struct ets_class *cl = ets_class_from_arg(arg);
>  
>  	if (!new) {
>  		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
> @@ -266,7 +263,7 @@ static int ets_class_graft(struct Qdisc *sch, unsigned long arg,
>  
>  static struct Qdisc *ets_class_leaf(struct Qdisc *sch, unsigned long arg)
>  {
> -	struct ets_class *cl = ets_class_from_arg(sch, arg);
> +	struct ets_class *cl = ets_class_from_arg(arg);
>  
>  	return cl->qdisc;
>  }
> @@ -278,12 +275,12 @@ static unsigned long ets_class_find(struct Qdisc *sch, u32 classid)
>  
>  	if (band - 1 >= q->nbands)
>  		return 0;
> -	return band;
> +	return (unsigned long)&q->classes[band - 1];
>  }
>  
>  static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
>  {
> -	struct ets_class *cl = ets_class_from_arg(sch, arg);
> +	struct ets_class *cl = ets_class_from_arg(arg);
>  	struct ets_sched *q = qdisc_priv(sch);
>  
>  	/* We get notified about zero-length child Qdiscs as well if they are
> @@ -297,7 +294,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
>  static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
>  			  struct sk_buff *skb, struct tcmsg *tcm)
>  {
> -	struct ets_class *cl = ets_class_from_arg(sch, arg);
> +	struct ets_class *cl = ets_class_from_arg(arg);
>  	struct ets_sched *q = qdisc_priv(sch);
>  	struct nlattr *nest;
>  
> @@ -322,7 +319,7 @@ static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
>  static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
>  				struct gnet_dump *d)
>  {
> -	struct ets_class *cl = ets_class_from_arg(sch, arg);
> +	struct ets_class *cl = ets_class_from_arg(arg);
>  	struct Qdisc *cl_q = cl->qdisc;
>  
>  	if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats, true) < 0 ||

The blamed commit is quite old, and the fix will be propagated on
several stable trees. Jamal's option is IMHO more suitable to such goal,
being less invasive and with possibly less conflict.

Would you be fine with Jamal's fix and following-up with the above on
net-next?

Thanks,

Paolo


