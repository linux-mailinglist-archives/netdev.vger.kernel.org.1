Return-Path: <netdev+bounces-70016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C6284D588
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D57A1F25D48
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE21386D6;
	Wed,  7 Feb 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="l7WMbH8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4961386C2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342288; cv=none; b=kZNCxVJr8/sJLRM6kjzRnRGyIM/QYFB5pTvPmDDq34jpjH7ThYXaUyCl+OVDPTzw+4aLl/dRsNa3I2z0IaG/5twbgtd1o5WJBPP7j94Ut/oyIevUtVGLokhicJBsY6x2aA4Q3nAMksMquniRd/CN9bPZaQtFeB0+gUVaAZWirdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342288; c=relaxed/simple;
	bh=obT2Z/aJ730VP/iV5WyRDjhNPEiflKyDEtjCCxkToZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwlhDRm8BH3ASBSLwW3Bgb0raxa9D5TkMPmkyjbtmJHKqOTAtz9adnFvleTWamG6kUqsm8IkbO8775i3EFIzQg3tv9bp9DHFXglDE0ILw1+LjPzINC6Rd48JsQz9Zv5nI6ivGBJOk4Ow1QoYrD0FgEXeyNm198r3SwPUj7JaSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=l7WMbH8L; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so644774a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707342286; x=1707947086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMeyh/ayqE2Fu390iVkFp0DIMmV6RiRjOTVvkRZb/1o=;
        b=l7WMbH8LuD//Axbzgfu9zfRS1TOHx7zR55+JjPJudh3bQW0K1KQZCbj+9AZaE5mvcv
         9MjgQLFnGazj7M8FKAVg+hi+Ww4If1I0Jqd6NGaZAcNUFsErb4k8z+GfsJPhW5ykp+ky
         cAT9+J3HkP2bywfzamep5wxtI7ywvjToYIniWKztqjt5CXbADl9E4ewVHwCFZ2qU02r5
         No3QMbYqlpNZrX2W5Kjg0q70MGRyLx58a+gKvIagpt5QH3t9gBwrmZZlv4+R9fxKDumJ
         nzTpUyfX7e9HPu/3cGhfym7Bn0ngo24CqqRfKrCaeKpKmoUo6xC2O1UTEHm00O1KqIRi
         5m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342286; x=1707947086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMeyh/ayqE2Fu390iVkFp0DIMmV6RiRjOTVvkRZb/1o=;
        b=VNq3P3DJP5DZnkbqIJNeY0PsilCfpZSR0WXmYSbuwAedmqhU8RYUO2hpclXhNqnhsM
         QCvyogLIzy+59mg2Znp1mHL7wWbnjcVY5VX2PDTByiv+Xm+o8KjbZmw5gC/t9lFwGk14
         1IZ2J+PHTU39VqXQmGD44knMhISebOiTonxCr8zSJ4HOAPVnIvGVJimMWuHn35Y+B1/u
         V7vo/r4aaJIP8btHe7P+9LJ1rPjdNwO1V/WM8MV6OuJqeK9l2efJpLy1hlbUyj+VdXzf
         GvQ7eQjGPZFhgq0y+h+6WEnnlC7pwOlXqUpQk774QdzsaSAa87WaJMZGJRYWh/+zgrk1
         r2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDuN15kVZNqYIHthhFHh0MqHvMXGO8KAOS0YxMLJfXWcuEexKOzxvSnxY/sBJZxCZXYyAnB+gvTVmwWhOokrtUbvaXAOON
X-Gm-Message-State: AOJu0YwEXakpTkOJ9NG0aVOTJqLOT25TLmbE6zu3wNwrQpSalQ0WC0+6
	OT/8TyFxfVZa0TV1DPHGp8Td8dgwwwNrSSlamDzw8oEutkDBHDuiU6xVuA0mZw==
X-Google-Smtp-Source: AGHT+IHQ7WBRMGAqPDfOL1vSOv5kszaOG8XPuQIGFi60JAPBli0CuLdrpRIH2/Lnnx/wapF3/VM+pg==
X-Received: by 2002:a17:90a:e2cb:b0:296:f32e:c3b9 with SMTP id fr11-20020a17090ae2cb00b00296f32ec3b9mr1638223pjb.26.1707342286139;
        Wed, 07 Feb 2024 13:44:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWc4p3XGqmXweUPY5MzXPlgJsmIRFFI0LO+vM9y7k+x7chRkiErPeDOl38ipGsNvj5rpWN2hU0kWNUCeo9gssihCFoZIoo3Q8EQ1Ux+3KmS1CuQsltElS1I/YxGTzN0Zeb6RtTw/TWc5mmy1iGKy8vE8CFS5MRHWiXjfrY6vV6HeyHALkosu12MiNdLoS/f/JKaHuh6mKxGQLJ9DQbuLSc7TXoq3fXxyJUwmjj3CxQvAYG0UQUajeaTPNcCim3r6ARI2nPbT7cudu9binV61Kh7pFF0K9mcZDU=
Received: from ?IPV6:2804:7f1:e2c1:c110:4997:fa3c:54c0:a69b? ([2804:7f1:e2c1:c110:4997:fa3c:54c0:a69b])
        by smtp.gmail.com with ESMTPSA id se7-20020a17090b518700b0029464b5fcdbsm2235294pjb.42.2024.02.07.13.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 13:44:45 -0800 (PST)
Message-ID: <8a616c28-c886-4ae7-82d0-cc8e37a9d175@mojatatu.com>
Date: Wed, 7 Feb 2024 18:44:41 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: act_mirred: Don't zero blockid when netns
 is going down
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com, pctammela@mojatatu.com
References: <20240207205335.1465818-1-victor@mojatatu.com>
 <CANn89iKk-mG3-QPUNymbcBJZxLH02Nqz0u+ZOtgRoDOPTXd7Fw@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CANn89iKk-mG3-QPUNymbcBJZxLH02Nqz0u+ZOtgRoDOPTXd7Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/02/2024 18:32, Eric Dumazet wrote:
> On Wed, Feb 7, 2024 at 9:54 PM Victor Nogueira <victor@mojatatu.com> wrote:
>>
>> While testing tdc with parallel tests for mirred to block we caught an
>> intermittent bug. The blockid was being zeroed out when a parallel net
>> namespace was going down and, thus, giving us an incorrect blockid value(0)
>> whenever we tried to dump the mirred action. Since we don't increment the
>> block refcount in the control path (and only use the ID), we don't need to
>> zero the blockid field whenever the net namespace is going down.
>>
> 
> You mention netns being removed, but the issue is more about unregistering
> a net device ?
> Ie the following would also trigger the bug ?
> 
> ip link add dev dummy type dummy
> ip link del dummy

Indeed you are right.
I focused on the net namespace part because this is what triggered the 
bug in our testing. I'll send a v2 with a better commit message.

cheers,
Victor

