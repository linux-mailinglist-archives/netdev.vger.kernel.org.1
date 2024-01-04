Return-Path: <netdev+bounces-61645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC40824778
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715CD1C21C63
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A642556C;
	Thu,  4 Jan 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gNH9KVOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EB28DA5
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so7261015e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704389433; x=1704994233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jKy45tTpBF8VrWktAGws3wr3SZV/flltFYKBFtql78=;
        b=gNH9KVOFQYQqrInrOaKGNkJ15tXEFl4iysSbaTO12M9giBPqZvCTz4jIfq+Zjufmne
         BSJ+ULojJp4yZjfWUJ5oFnRaua0NDE338wYLGS6z4/Zu30+m65ECfYnRw0wrycNMXmoA
         qcXl3b1s0WSCO31U4+Atj4zhqsy6jj2Sy5SshEZfzWz3kpk6M1eQQpcR0pZtDn1AT4Iz
         BpLFrQduy9aliyLav3K6j+XLRJydchBnJJOqo/XJUCQugRW5EmdN4Y7CfrNHhYjd/1FU
         fTflRV61mB0rxd+DqGC/zTtC4+tHft5/RFvOEgQbnugJ8sb+khjLIT8PNUcDhKmp0G8r
         dW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389433; x=1704994233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jKy45tTpBF8VrWktAGws3wr3SZV/flltFYKBFtql78=;
        b=QVCbss/wQuFuP+QCqkNC9qit4aw8/LMuxoCwmBSZYyrNemH5BVDs27f7CJoWVDNG1X
         bln/DCXcKT7fjFNevn4rBTo2Fv313SumiVkvjSFhV/bXdyitRDRutWZR3iopf+EVc0dv
         hpzqsIwjwjXoMWJm82MhYiYsYMT3dSmCtZ2CpIFsl08WPVxyKWOj3NcO865xJ4MPKK3h
         aRIq0jG/KJNxWT26Fb6mEjnazPabdzEuSe2BDf4gIkdtSlr+yjk8mI/0JIfWYNrGp8O+
         mhjW3V2cmY2YKbHWa1DCXgKzBK+duqh2NZ5tGgFqR5JpIaV6jbKtu0D3pn8dy2oRS+PG
         mWpQ==
X-Gm-Message-State: AOJu0YxZkCTTVv5hWSqw9P1y73vppelUT8+zDn9BVuqepvWiY2dED5SJ
	4A8maij3te05z0W/j3xRQ7mE7xGOQNX7
X-Google-Smtp-Source: AGHT+IH7v02jmFcnm02BO4OEGoG7+3cWGMprgrMDThkM/ZaCFX321w7OUFlnQld0EGr5QLANcFjw8Q==
X-Received: by 2002:a05:600c:45d4:b0:40d:1778:c839 with SMTP id s20-20020a05600c45d400b0040d1778c839mr374246wmo.141.1704389433542;
        Thu, 04 Jan 2024 09:30:33 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b0033662c2820bsm33125502wrv.117.2024.01.04.09.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:30:33 -0800 (PST)
Message-ID: <dca62206-165e-40bc-b834-0df2941fad41@arista.com>
Date: Thu, 4 Jan 2024 17:30:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Christian Kujau <lists@nerdbynature.de>,
 Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
 <20240104075742.71e4399f@kernel.org>
 <335a2669-6902-4f57-bf48-5650cbf55406@arista.com>
 <20240104085855.4c5c5a1f@kernel.org>
 <CANn89iJ79ibHGu-4MCLpkG3w7dr7jqbc7CX1T7Cm+d6vwnwLGg@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iJ79ibHGu-4MCLpkG3w7dr7jqbc7CX1T7Cm+d6vwnwLGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/4/24 16:59, Eric Dumazet wrote:
> On Thu, Jan 4, 2024 at 5:59 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 4 Jan 2024 16:42:05 +0000 Dmitry Safonov wrote:
>>>>> Keep silent and avoid logging when there aren't any keys in the system.
>>>>>
>>>>> Side-note: I also defined static_branch_tcp_*() helpers to avoid more
>>>>> ifdeffery, going to remove more ifdeffery further with their help.
>>>>
>>>> Wouldn't we be better off converting the prints to trace points.
>>>> The chances for hitting them due to malicious packets feels much
>>>> higher than dealing with a buggy implementation in the wild.
>>>
>>> Do you mean a proper stuff like in net/core/net-traces.c or just
>>> lowering the loglevel to net_dbg_ratelimited() [like Christian
>>> originally proposed], which in turns becomes runtime enabled/disabled?
>>
>> I mean proper tracepoints.
>>
>>> Both seem fine to me, albeit I was a bit reluctant to change it without
>>> a good reason as even pre- 2717b5adea9e TCP-MD5 messages were logged and
>>> some userspace may expect them. I guess we can try and see if anyone
>>> notices/complains over changes to these messages changes or not.

[to add up context]
I supposed it's only tests that grep for those messages, but I've looked
up the code-base and it's wired up to daemon's code to monitor messages
with a "filter" for rsyslogd. Certainly not an issue for arista as there
are people maintaining that (and AFAIK, rasdaemon is already used for
other traces), but I guess provides grounds for my concerns over other
projects.

>> Hm. Perhaps we can do the conversion in net-next. Let me ping Eric :)
> 
> Sure, let's wait for the next release for a conversion, thanks !
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

I'll do the conversion for net-next if you don't mind :-)

That will be pretty nice as it's going to be easy to exercise in tcp-ao
selftests. Grepping dmesg can't be selftested as reliably/non-flaky.

Thanks,
            Dmitry


