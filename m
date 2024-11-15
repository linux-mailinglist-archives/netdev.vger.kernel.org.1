Return-Path: <netdev+bounces-145142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E154E9CD563
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE528128A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D6B3D966;
	Fri, 15 Nov 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CvmGgETw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B520B20
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637857; cv=none; b=DJXtbx6COen/HTZmwZLjGQQuqH0Aqf0M7BupQ2JcUDa6Sbc4Jkaq4Wb8Sc1tMI/u2aiuCRB6fV7xBGGQyf4K4+LSDnoPkqlBpZxZBKgIdENXazbIJMsnLahaeJ1kzMSgVLc4RUDlCiXcXctxXMWL6+K2JScWcdmGTL6nnAUo51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637857; c=relaxed/simple;
	bh=iMquVi9choIkJjLf1YAvCgElQDRqj32XPrIJupcdXEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFns9qAZNwGjlGU5s/Nr7on84E32NYhDpTsWUC4Z7r74+vegTffV9ljS7kTeQ32WKlmL1/+6RTbjqp49ddRKe3hq6WCNE82LD5O+2Ria+/kag8uOYIFcIbXbVyp2L3LK9nJn/FnwPq6Wy87Aq3WANbpBmz1dY/MZ8erpTjzsFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CvmGgETw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1274207a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731637855; x=1732242655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaXOpBj87loeZ2zsjL0hh+1z03QAQErfUtdqSTsxwMw=;
        b=CvmGgETwE1drhJUsqitmh0rAGCQXdjKczqGt80h9QsZXT+RHmI47HoFUXQzKHJ67at
         vlnmNWpC8K3CdtRO7pZNcy2RpJhFyYov1WuEjzH43QHhVUn1Prg9c6SMKf6g6feeMnFF
         fgXYiH5pduzY6jvKK8YxtqzClzJt+LR9K4XCvad1CLtCuNq4+8wVhq6uo0dNshKAH2Vr
         AkpAJFRgCQUJeBNHjtK1H5OJFKVl20rrZnyyE131EXJyoLUeS6LKs1cUS+jg16TZQUN8
         nBi4EPbYVjmAX2LHMoJg4DxKEpb41XNJSAidl4EF5wZLhP0TbJ7yFRcJ2vqqCBG21pTm
         Vafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731637855; x=1732242655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXOpBj87loeZ2zsjL0hh+1z03QAQErfUtdqSTsxwMw=;
        b=lY6bfcBe9xIol8f5A6aw8J2Ws3gP6i6110JtgycnPVL4Q9MYZJYirktPRCgT/pYuSR
         3b94cQeO2J52+I9a26h52QVpMH3ufsyFRs+H8Dz5DdMBopq4HY2Z9p1Q69BRly9fitCU
         ju83aEGKg7sgSaNgwyibLNVEWKnzm2ga1IP6KdZoD/BnCg1Cdv5TPrw3JWFoSSm8ABSg
         hpC3JzcO89/qelffamZZzdzY/i7juVDjIilrLIUqqRjG4zHw8n7ngmbyckRoMfmVhuYd
         atk+Jm8ODs2CEtVLXEW75JrCx4skxlaGfysM7bj5B9726Lx0udNueXsHd9bMgoVQY7V8
         /h/g==
X-Forwarded-Encrypted: i=1; AJvYcCV+tr81gjJ+iLOa03TQOgHTpML9ycIo5fQtFXb4GHBP3aArQLjLEeABPL5vGFJRXIPQn3CJUGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLocQyoCG6cGpaemcnLEiNCYbx282yjvpiRWbrG69xyBZ9vFSm
	mlCFOUt69QXO7I5zboi800pJSJwbIpQo9/KHE0PPSbvZw8cFamNlIVL5exxW9QY=
X-Google-Smtp-Source: AGHT+IGmYzDpWpA2GVCwMs7w1OReL4VK06XcHWAw3RQaVC4cjRvbZKrqDaz2HxQ13e5u9Hy4V+/1eg==
X-Received: by 2002:a05:6a20:6a1a:b0:1db:f0e0:cfd with SMTP id adf61e73a8af0-1dc90c08d8dmr1481512637.44.1731637855560;
        Thu, 14 Nov 2024 18:30:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:db2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477139130sm341454b3a.85.2024.11.14.18.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 18:30:55 -0800 (PST)
Message-ID: <970c7945-3dc4-4f07-94d5-19080efb2f21@davidwei.uk>
Date: Thu, 14 Nov 2024 18:30:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
 <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
 <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-14 18:15, Luiz Augusto von Dentz wrote:
> Hi David,
> 
> On Thu, Nov 14, 2024 at 7:42 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-11-14 15:27, Michal Luczaj wrote:
>>> The bt_copy_from_sockptr() return value is being misinterpreted by most
>>> users: a non-zero result is mistakenly assumed to represent an error code,
>>> but actually indicates the number of bytes that could not be copied.
>>>
>>> Remove bt_copy_from_sockptr() and adapt callers to use
>>> copy_safe_from_sockptr().
>>>
>>> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
>>> scrub parts of uninitialized buffer.
>>>
>>> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
>>> and hci_sock_setsockopt().
>>>
>>> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
>>> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
>>> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
>>> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
>>> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>>  include/net/bluetooth/bluetooth.h |  9 ---------
>>>  net/bluetooth/hci_sock.c          | 14 +++++++-------
>>>  net/bluetooth/iso.c               | 10 +++++-----
>>>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
>>>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
>>>  net/bluetooth/sco.c               | 11 ++++++-----
>>>  6 files changed, 33 insertions(+), 40 deletions(-)
>>>
>> ...
>>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>>> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
>>> --- a/net/bluetooth/rfcomm/sock.c
>>> +++ b/net/bluetooth/rfcomm/sock.c
>>> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>>>
>>>       switch (optname) {
>>>       case RFCOMM_LM:
>>> -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
>>> -                     err = -EFAULT;
>>> +             err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
>>> +             if (err)
>>>                       break;
>>> -             }
>>
>> This will return a positive integer if copy_safe_from_sockptr() fails.
> 
> What are you talking about copy_safe_from_sockptr never returns a
> positive value:
> 
>  * Returns:
>  *  * -EINVAL: @optlen < @ksize
>  *  * -EFAULT: access to userspace failed.
>  *  * 0 : @ksize bytes were copied

Isn't this what this series is about? copy_from_sockptr() returns 0 on
success, or a positive integer for number of bytes NOT copied on error.
Patch 4 even updates the docs for copy_from_sockptr().

copy_safe_from_sockptr()
	-> copy_from_sockptr()
	-> copy_from_sockptr_offset()
	-> memcpy() for kernel to kernel OR
	-> copy_from_user() otherwise

And copy_from_user() follows the same 0 for success or N > 0 for
failure. It does not EFAULT on its own AFAIK.

The docs for copy_safe_from_sockptr() that you've linked contains the
exact misunderstanding that Michal is correcting.

> 
>> Shouldn't this be:
>>
>> err = -EFAULT;
>> if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
>>         break;
> 
> 
> 

