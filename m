Return-Path: <netdev+bounces-202441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF5AEDF41
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DD21885F75
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9A28AB03;
	Mon, 30 Jun 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex5kdQ+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC739ACF
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290618; cv=none; b=TIwBAbBZEDgb07qv81O94XKLBZQPzEmSabVHeGoxn5s3SVeSICuL4p8ajsCRv8lvHUIgmJtThVbEEb60R9VAypv+vEGcT6Fyu7dhc6lb43fQ0KNBZtwJdZ1Lz+nkSp+kwL+nkJXKKrm61vLIgSPnBJQyOlP751bCzoVShcSeyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290618; c=relaxed/simple;
	bh=BFR7gn43FkzRf73e6DDZB7sokWYSyEkwUkdRPA6a1Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moCMiJJ8g+aYFC4TUMTNBvZwDhA/HBeXvG6sSkQt5Zl4DQGlMTJrzT1PVxvBL7fCql5MAhALkHiyb5e9LlYObltgJ8XSZ7Tis9bBdXH6JB5ozNJYeOts72LM16bBFjSFP6knRRBOmUYGlX+dnqRBRlzzqYhZdIbskgZAcNACWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex5kdQ+r; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453066fad06so29232495e9.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751290614; x=1751895414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdwwDcP0H8I8HsWyMq9eFxFrgnk5s8D54zSqCns0r/Y=;
        b=Ex5kdQ+rs1+TQWb3V0lxe1nKyIGDmYHTn8IlozAQGWhI6M1CX+SYC8BGgDgIxVjQRN
         SspWAk/uhW+kdxYstxZh7u/BVIn8xhWwQ61JIa6td11S6gG3uPTERCjf1/KqcGKkVhPp
         XVcEkhgaf/K2hz5aDQ8hUPJfMG6N6KiyAADpOXJ/7bdU7d/mriwDzYVytgvEypiEhjNb
         mQ6X/gvZ7r12JbFg4DTKiZcZItYYXUvFgNaYI4B21ag9U+9EDvWKMNq3eDb+ZutQAlBw
         PfNyHCX6ZC/jiICbFH/oyaqaGuhATzCSg/AWb8PRKRWPxFCPo6KP5yuoH011HQPFP0KM
         s/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290614; x=1751895414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdwwDcP0H8I8HsWyMq9eFxFrgnk5s8D54zSqCns0r/Y=;
        b=m2ixF+1vgWuMycLTcPH0kQPAwAHDJttzWsZOVqGn9cvhatVhWwJOLUsMqimaRK4y/1
         R/ryCKaLUGw3kynbhUujsqnuKFa4OLKjxw0MnIkTe/vw5YOxBA3rbwNNhSarOb5BLWra
         y9CnmF/L9+zykFpdguaQ2Rm9U2aD1iYSKZwcpDu49sbsqehsdbcBI4BB/dB7dO0ds5qY
         WHD5exUrkYr922KtMqV15UwQTEwkWYBsekmDoqVgfePcbKNqhp5Nb3m5WzKfI8OvrtqM
         zgESSTf17itKCmyaJoKUnSJT0EqnWCckMfE9wiPRB18haucD7qjAbbuuulRJl6SQCUsL
         KCtg==
X-Forwarded-Encrypted: i=1; AJvYcCXlu2Q/1z4XXitEy+ANQFkVo4bL3tR0e3fqNZNsVUcnM2txa+y0PAvc6qP/nHsm8sO9a/NYlDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13BIh0mtVI14UTlaIeYZXTrmK+1IsC6ScoyRCB8DtnI/lI1JY
	R37uVvXVLdEn6U+eGN8u7KTlxqAqME3xJR05ngwpqENzOC9WsJUbsg3tgC7kxJ7Swk0=
X-Gm-Gg: ASbGnct4LGdcrCqYLIvv1zBKTine1VGBICtMY5f/aYNFjySlKWFrKx/DwK7TPyzg9GL
	J4L7QQdlRWyewI6fC2suTWtgGgQxWgTfdAp61/yZDRRwk9nHN0PSD0FQDdB7kA4txURkqVVBw0u
	ekqlHiHBHdT8vypG2uuRataA4MMQNdc7Q0QDg8wtKdQsivN2iA80GgY2P+oliou6uRxj35wpu/i
	HPeVYPE0V15Av1LrAzGYknG1gjTnqqRvn2LDzrn5GioXoRtVtTsimuji6iDoYTYzfDGCHH+YYLk
	rTA3FSzh/UhE7wDpBzoi7CfYpnH2PaHVj48nDmqbzWkgjfO0Bu6luqHTx03Tb8IOSVkj6LUx9mU
	qWapnqE2D/npc1hda8vlMUENaFzIHOJZuMIrjg7BZYZnQFRqX+1cpxqEZ4EnYSlifg3jsmO7XAD
	4k8dnxo3AgATqcvy0=
X-Google-Smtp-Source: AGHT+IFymWzqvKJ+op+IiT4M5lFo9uoNbT8pG0o9KMRPDLVBnzqb4HgS0qmG4SkZG8pxYPgparGW9Q==
X-Received: by 2002:a05:600c:8b52:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-45390699e19mr138201995e9.17.1751290614188;
        Mon, 30 Jun 2025 06:36:54 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc79:8145:5c0f:2a85:2335? (p200300ed774bfc7981455c0f2a852335.dip0.t-ipconnect.de. [2003:ed:774b:fc79:8145:5c0f:2a85:2335])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad01csm167072785e9.22.2025.06.30.06.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:36:53 -0700 (PDT)
Message-ID: <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
Date: Mon, 30 Jun 2025 15:36:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
 <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
 <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/30/25 1:34 PM, Jamal Hadi Salim wrote:
> Hi,
> 
> On Mon, Jun 30, 2025 at 5:04 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>
>> Hi,
>>
>> On 6/29/25 9:50 PM, Cong Wang wrote:
>>> On Sun, Jun 29, 2025 at 10:29:44AM -0400, Jamal Hadi Salim wrote:
>>>>> On "What do you think the root cause is here?"
>>>>>
>>>>> I believe the root cause is that qdiscs like hfsc and qfq are dropping
>>>>> all packets in enqueue (mostly in relation to peek()) and that result
>>>>> is not being reflected in the return code returned to its parent
>>>>> qdisc.
>>>>> So, in the example you described in this thread, drr is oblivious to
>>>>> the fact that the child qdisc dropped its packet because the call to
>>>>> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
>>>>> activate a class that shouldn't have been activated at all.
>>>>>
>>>>> You can argue that drr (and other similar qdiscs) may detect this by
>>>>> checking the call to qlen_notify (as the drr patch was
>>>>> doing), but that seems really counter-intuitive. Imagine writing a new
>>>>> qdisc and having to check for that every time you call a child's
>>>>> enqueue. Sure  your patch solves this, but it also seems like it's not
>>>>> fixing the underlying issue (which is drr activating the class in the
>>>>> first place). Your patch is simply removing all the classes from their
>>>>> active lists when you delete them. And your patch may seem ok for now,
>>>>> but I am worried it might break something else in the future that we
>>>>> are not seeing.
>>>>>
>>>>> And do note: All of the examples of the hierarchy I have seen so far,
>>>>> that put us in this situation, are nonsensical
>>>>>
>>>>
>>>> At this point my thinking is to apply your patch and then we discuss a
>>>> longer term solution. Cong?
>>>
>>> I agree. If Lion's patch works, it is certainly much better as a bug fix
>>> for both -net and -stable.
>>>
>>> Also for all of those ->qlen_notify() craziness, I think we need to
>>> rethink about the architecture, _maybe_ there are better architectural
>>> solutions.
>>>
>>> Thanks!
>>
>> Just for the record, I agree with all your points and as was stated this
>> patch really only does damage prevention. Your proposal of preventing
>> hierarchies sounds useful in the long run to keep the backlogs sane.
>>
>> I did run all the tdc tests on the latest net tree and they passed. Also
>> my HFSC reproducer does not trigger with the proposed patch. I do not have
>> a simple reproducer at hand for the QFQ tree case that you mentioned. So
>> please verify this too if you can.
>>
>> Otherwise please feel free to go forward with the patch. If I can add
>> anything else to the discussion please let me know.
>>
> 
> Please post the patch formally as per Cong request. A tdc test case of
> the reproducer would also help.
> 
> cheers,
> jamal

I sent a patch, though I am not terribly familiar with the tdc test case 
infrastructure. If it is a no-op for you to translate the repro above into 
the required format, please feel free to do that and post a patch for that. 
Otherwise I can have a closer look at it tomorrow.

Thanks,
Lion

