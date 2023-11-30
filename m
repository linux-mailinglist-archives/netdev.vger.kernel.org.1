Return-Path: <netdev+bounces-52439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427B7FEBE1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20812281C3D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529638F8E;
	Thu, 30 Nov 2023 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FfUvEDc8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CE8F
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:32:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a049d19b63bso94391666b.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701336726; x=1701941526; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=P/v+E0O4KgB3PzqewrGMsWduXZyX66RbKGdE2wkw244=;
        b=FfUvEDc8NR0BjvjpVmqhxF2bcMWWClLVD5pj6ZjwEbrVuo6rFhvqjDq5ZwQZMf6vP3
         u0C3DfGKRoFy0WRXRb4P33mX1IB+mxTWmuVMR7AQV2WZiVRoGjUmcaw77szT7z97HwEh
         r0NrDG9J2tXe0kCwhDgNpqZJ0qyzdxE+jIlqhCQPnmFjJUFuQVkrw6vGswrzPAT89/Jf
         gYNq3oMJIq5f+ALc8gQvamOa2CFFZVTMbrVOeILjcEAwhrMuLtKum2WXOl9a8wkExcId
         VvlKUpy+nFScHSlpsLMLqx3LSw0TftJnLDYPaegzm/5N5AomH++fSFqwyHIkyEipM7fE
         94FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336726; x=1701941526;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/v+E0O4KgB3PzqewrGMsWduXZyX66RbKGdE2wkw244=;
        b=HSSEhuOtyBpnGv6nhhZaO9TRv7GVRIOTDgDV9SeIH238ly5CEMqKFvdD1BhHwEHMc+
         7+acNeSdKtz9vrQqPR0GxeM9qsts82/+wqf6yJ34EzKIuqUIjZdMUNyzlVqxVZDCjFHY
         M5ZPTz/z+RHaJu0uBLd1H5J2SkhneJFak2zTDu2bz8YwgyTXE3WFaXXubBtkW46q/2oy
         uZoagJdhKs8MDPiN2v37PMZiUMl96ZSV3vwaSzZcFgSAAa5g1b19vNt+ZPKLP8SvkRV3
         PlWWbCgA6nXgfj3w7ptlOHOYDRBuM0thEM8JZVZBcER2CLLIHfiW8V0kHWAOnW37oDRG
         ceAA==
X-Gm-Message-State: AOJu0Yykn84Gqht1e3P/Hx/OOd8+YRAVJcsOzg4jNYFVr9JYgE3OVlIr
	7TWSqoudVAe4A38f1gzNFpPNt735AmSTyOPj2OwXNQ==
X-Google-Smtp-Source: AGHT+IGXjWVuBYY5l5aHrCHU2RKffK8zb0E2vHCoOtW2t/1OT/SnCOt9wG+d9OOCYiT2ZpuE2FHs5Q==
X-Received: by 2002:a17:906:f80c:b0:a0d:e65a:277d with SMTP id kh12-20020a170906f80c00b00a0de65a277dmr7340847ejb.12.1701336726466;
        Thu, 30 Nov 2023 01:32:06 -0800 (PST)
Received: from cloudflare.com (79.184.129.107.ipv4.supernova.orange.pl. [79.184.129.107])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906128b00b009ff8f199f21sm483466ejb.19.2023.11.30.01.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:32:05 -0800 (PST)
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
 <87r0k82tbi.fsf@cloudflare.com>
 <a00cb120e5224a20931dcba10987cc80@AcuMS.aculab.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 'Jakub Kicinski'
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen
 Hemminger <stephen@networkplumber.org>, Eric Dumazet
 <edumazet@google.com>, 'David Ahern' <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
Date: Thu, 30 Nov 2023 10:29:33 +0100
In-reply-to: <a00cb120e5224a20931dcba10987cc80@AcuMS.aculab.com>
Message-ID: <87msuv37u4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 30, 2023 at 09:04 AM GMT, David Laight wrote:
> From: Jakub Sitnicki
>> Sent: 29 November 2023 20:17
>> 
>> Hey David,
>> 
>> On Wed, Nov 29, 2023 at 07:26 PM GMT, David Laight wrote:
>> > Commit 227b60f5102cd added a seqlock to ensure that the low and high
>> > port numbers were always updated together.
>> > This is overkill because the two 16bit port numbers can be held in
>> > a u32 and read/written in a single instruction.
>> >
>> > More recently 91d0b78c5177f added support for finer per-socket limits.
>> > The user-supplied value is 'high << 16 | low' but they are held
>> > separately and the socket options protected by the socket lock.
>> >
>> > Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
>> > fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
>> > always updated together.
>> >
>> > Change (the now trival) inet_get_local_port_range() to a static inline
>> > to optimise the calling code.
>> > (In particular avoiding returning integers by reference.)
>> >
>> > Signed-off-by: David Laight <david.laight@aculab.com>
>> > ---
>> 
>> Regarding the per-socket changes - we don't expect contention on sock
>> lock between inet_stream_connect / __inet_bind, where we grab it and
>> eventually call inet_sk_get_local_port_range, and sockopt handlers, do
>> we?
>> 
>> The motivation is not super clear for me for that of the changes.
>
> The locking in the getsockopt() code is actually quite horrid.
> Look at the conditionals for the rntl lock.
> It is conditionally acquired based on a function that sets a flag,
> but released based on the exit path from the switch statement.
>
> But there are only two options that need the rtnl lock and the socket
> lock, and two trivial ones (including this one) that need the socket
> lock.
> So the code can be simplified by moving the locking into the case branches.
> With only 2 such cases the overhead will be minimal (compared the to
> setsockopt() case where a lot of options need locking.
>
> This is all part of a big patchset I'm trying to write that converts
> all the setsockopt code to take an 'unsigned int optlen' parameter
> and return the length to pass back to the caller.
> So the copy_to_user() of the updated length is done by the syscall
> stub rather than inside every separate function (and sometimes in
> multiple places in a function).
>
> After all, if the copy fails EFAULT the application is broken.
> It really doesn't matter if any side effects have happened.
> If you get a fault reading from a pipe the data is lost.

OK, so you're trying to refactor the setsockopt handler. Now it makes
more sense what is driving this work. Thanks for the context.

[...]

