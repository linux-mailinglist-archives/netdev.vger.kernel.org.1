Return-Path: <netdev+bounces-202640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC967AEE6FC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211CA17FDFA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A11D63DD;
	Mon, 30 Jun 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FV0PdcUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D979D2
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309420; cv=none; b=MI31BabXS6uw4dfC2nZQTi6BTgoR5uq4vk3mXZaJYwJO+xjmahMp8viRiFVoto9g0kSUxaIhr7avgYxhEjKYj7eip33zfgKb0wAvs6ImEts42JquJbzkdX5Er7poKWfFFDiCzVJ6P0kjrVkv7nCiKmYFnIeZiVs99ed1Ozrvxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309420; c=relaxed/simple;
	bh=R0d/ERdaQn4TK2ldd5M0h1WnC1wENgcuveajp9u4IhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2xKwj3DQrOHXG/FjKHefUpTdazNaI9lbupaB3nuBSUuqDKpwUL1GCltgUmtA6dyGJAiBKJxiNRMh+zA8vr4wqeMGqsFa8J/a5nILFgpS1eIuzW/5NC5WedFw0BqnhG65KjpYJdn1Ekm1jxh+Ux2YK8lUN+8Z8HDncVl+aDe4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FV0PdcUi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d45f5fde50so85601185a.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751309417; x=1751914217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWYgsa+ABPUT6jCvmQa0OfSh8pPWa85zjvwjhLFmMDU=;
        b=FV0PdcUiM4Bp0QkR5sP69t1Xz6+B7YmTTNHkUF+8g+IrrZ8KvqfWjg4j6+rs1KXWXt
         OI/TZZL+Bgm+UXUeb5X+Oiu4Ok6ZmJWnjCd7stS+DS9VD6mvdcCCCHuhYSzsfofsOjM/
         RlhtTvq1XhL5QQBYRBuTwj5C3sbeopUVgIFI718rEudBmCqiHrLCuYLZwF0/nrPvTv1D
         qWyxNwsA316kQlBDDf7YyYGJrPnYss7ca0W9ffstxwQ/l4DfukKKrdH0P0PTK8wHrSXa
         RUKKXYs+SVu+rBFMce2Fv/t0XIeIlyH+QWWKCEf+EBdciD44VUCCRFjrIxx1svqu2M9e
         Oo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309417; x=1751914217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWYgsa+ABPUT6jCvmQa0OfSh8pPWa85zjvwjhLFmMDU=;
        b=hB922EFjvjC4eb6R9L0H1SQkecVzCEvvi1WCZW1gWp8flyqJBVWsgeSqMxOQcZHjNX
         3LL2zjLL2+AnspfunC4YweKHYkSofnpT1yQjd/SN/c8Sk/29oLLmO7gfUpWqf3soYGNP
         hyC5XXILcywqmFCvSMapqZRtQi/AR32uKR5SwhnGAdgusWJWkKhCnfLaIu+sXb77I5Tw
         QyQVenUtrLnPrcBHWh4ne2dcJfy3S88RCln2yIPCI+h7LHRHigXmNJriA4k7yqJz5FX2
         bvcOn5xmZCySvtXv+vZU3T/LkIMeVrdvz82lySoHTgGmKBI3s7WzVWxGvz5pQxXJWqTi
         +vmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQmT+2iOYhZwqlvBTnDiMU+zGUwoGbnHNFqUcYPbGgw3/fa44zYkEr/w9v7vyXb5+hfsjTyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBW072UbQD2F2WAxu8S6SkOcUdOmwqcfMbvBCfx46xGFJFbi/
	z3qwhOXzU2wRtMk0pvLwDZMhR0iQlSBzRBG8wJ7KpeQyEBnS1w0ePIJ7i4o8IHcGOw==
X-Gm-Gg: ASbGncsrOQA8ceWfoiqwgtuSgWSvZv2dZJlxP6cj7U3JGIkXWTrUk0BEVbZqxRHGp0T
	6PwzM1JF8fLVF0/Zy6+7nmVVYwi1yVHYnmRTMwFxRsa7OBAiEwfhuU6CF5DRc+XfaZyf2yjdmPl
	P/2+rR8GM10GLiVAopHgn0rccO9iR5dhW8bQn1IYFD2424GErg/Cgiv4mk2YDvmptXS0kXbUKQC
	+7qULudA1ss5qc/7RNBUM0vC9iPYZAMhZLZN8SS0xnSpc8PDwzA0+zt4cAF/elb8gNtuJYS/p15
	G+2x8PRyXR06p8aOlUpeI8OWOpRJKCE3ML2zJR1u2SkVEH3q9rGfsGtVk0+QChMLfhtphGL5c06
	oR06kHJLMgNVVh+ULySK9MFOH+PjqrA==
X-Google-Smtp-Source: AGHT+IEcSvATFMn0gIYcX6T4hAtmS1kHEFlAJ/Q97MBYfh1gyAdn3NR4kLKR1/GDwlYmDI+u8OpvmA==
X-Received: by 2002:a05:620a:3949:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7d4438f4d5dmr1943953585a.12.1751309417125;
        Mon, 30 Jun 2025 11:50:17 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:ca4a:289:b941:38b9:cf01? ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d4432410adsm640396285a.111.2025.06.30.11.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 11:50:16 -0700 (PDT)
Message-ID: <60f44b58-fad9-4d73-a355-70f87662ea7c@mojatatu.com>
Date: Mon, 30 Jun 2025 15:50:13 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use-after-free in Linux tc subsystem (v6.15)
To: Jamal Hadi Salim <jhs@mojatatu.com>, Mingi Cho <mgcho.minic@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, security@kernel.org,
 Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAE1YQVoTz5REkvZWzq_X5f31Sr6NzutVCxxmLfWtmVZkjiingA@mail.gmail.com>
 <CAM_iQpV8NpK_L2_697NccDPfb9SPYhQ7BT1Ssueh7nT-rRKJRA@mail.gmail.com>
 <CAM_iQpXVaxTVALH9_Lki+O=1cMaVx4uQhcRvi4VcS2rEdYkj5Q@mail.gmail.com>
 <CAM_iQpVi0V7DNQFiNWWMr+crM-1EFbnvWV5_L-aOkFsKaA3JBQ@mail.gmail.com>
 <CAM0EoMm4D+q1eLzfKw3gKbQF43GzpBcDFY3w2k2OmtohJn=aJw@mail.gmail.com>
 <CAM0EoMkFzD0gKfJM2-Dtgv6qQ8mjGRFmWF7+oe=qGgBEkVSimg@mail.gmail.com>
 <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
 <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> On Thu, Jun 26, 2025 at 1:11 AM Mingi Cho <mgcho.minic@gmail.com> wrote:
>>
>> On Fri, Jun 20, 2025 at 8:24 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>
>>> On Wed, Jun 18, 2025 at 4:17 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>>
>>>> On Mon, Jun 16, 2025 at 9:03 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>>>>
>>>>> On Sun, Jun 15, 2025 at 10:02 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, Jun 12, 2025 at 2:18 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Mingi,
>>>>>>>
>>>>>>> Thanks for your report!
>>>>>>>
>>>>>>> I won't have time to look into this until this Sunday, if you or
>>>>>>> anyone else have
>>>>>>> time before that, please feel free to work on a patch. Otherwise, I will take a
>>>>>>> look this Sunday.
>>>>>>
>>>>>> I am testing the attached patch, I will take a deeper look tomorrow.
>>>>>
>>>>> It is more complicated than I thought. I think we need to rollback all
>>>>> the previous enqueue operations, but it does not look pretty either.
>>>>>
>>>>> Jamal, do you like the attached fix? I don't have any better ideas
>>>>> so far. :-/
>>>>>
>>>>
>>>> I just got back - let me look at it tomorrow. Immediate reaction is i
>>>> would suspect netem
>>>
>>> Spent time yesterday and there are two potential approaches
>>> (attached), both of which fix the issue but i am not satisfied with
>>> either.
>>>
>>> The root cause being exploited here is there are some qdisc's whose
>>> peek() drops packets - but given peek() doesnt return a code, the
>>> parent is unaware of what happened.
>>>
>>> drr_fix.diff
>>> avoids making a class active  by detecting whether drr_qlen_notify was
>>> called between after enqueue (even though that enqueue succeeded), in
>>> that case, returns a NET_XMIT_SUCCESS | __NET_XMIT_BYPASS which ensure
>>> we don't add the class to drr.
>>>
>>> This fixes the UAF but it would require an analogous fix for other
>>> qdiscs with similar behavior (ets, hfsc, ...)
>>>
>>> qfq_netem_child_fix.diff
>>> piggy backs on your tbf patch and detects whether
>>> qdisc_tree_reduce_backlog was called after qfq's peeked its child
>>> (netem in this repro) in enqueue.
>>> This would also require fixing other qdiscs.
>>>
>>> TBH, while both approaches fix the UAF, IMO they are short term hacks
>>> and i am sure Mingi and co will find yet another way to send netlink
>>> messages to config a _nonsensical hierarchy of qdiscs_ (as was this
>>> one!) to create yet another UAF.
>>>
>>> My suggestion is we go back to a proposal i made a few moons back:
>>> create a mechanism to disallow certain hierarchies of qdiscs, ex in
>>> this case disallow qfq from being the ancestor of "qdiscs that may
>>> drop during peek" (such as netem). Then we can just keep adding more
>>> "disallowed configs" that will be rejected via netlink.
>>> And TBH, i feel like obsoleting qfq altogether - the author doesnt
>>> even respond to emails.
>>>
>>> cheers,
>>> jamal
>>
>> Hello,
>>
>> I think the testcase I reported earlier actually contains two
>> different bugs. The first is returning SUCCESS with an empty TBF qdisc
>> in tbf_segment, and the second is returning SUCCESS with an empty QFQ
>> qdisc in qfq_enqueue.

Mingi, can you create a selftest for the drr UAF case with a qfq child
that you reproduced? Since you required setsockopt for creating GSO
packets, I don't believe you'll be able to use tdc for this.

