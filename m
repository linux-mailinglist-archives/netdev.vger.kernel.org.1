Return-Path: <netdev+bounces-185516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D86A9AC11
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EB16A51E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8231D23D29B;
	Thu, 24 Apr 2025 11:33:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987A23816F
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494397; cv=none; b=s283f1KgfYTRNueM3KeKt2rrxjXKBtJKeMLae3k8JzeZUw+MT6yhip/DdpLpzGRa9RSrGaEly7SNaa7c00kYtxIatoyV5ZWc12AClzDnYljbjx82Aq6Cpk2SyLq9P48krv88gtSyKlbpPpJRHZSsQnH8DnwLikwXpZQuqv5oClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494397; c=relaxed/simple;
	bh=jApDZhqpWgZhrw7+xKexH6+5kJ7S00zVkH84/nOW8rE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=T9M9Zjtx868QWH+vU+Uz+r09dIoQArGxoKa+CGiQH89hzp0vMSUZDwqpw18/fmfg2pmYpY+JMRXfgRjfODQdV0zWPpsBYcUGmAkfN75TJWYvflOmvyE635X1d6TspIx1gImG9qnFpJmG+0E5EGlF/0ZjzSgA8D10OAR7zz0dFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so8759465e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745494392; x=1746099192;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qysaWPGR4kx1KRyaPfNKtdkOTIfkWPtl6HnHLktm75o=;
        b=azbF1jmQlarTEEO/SoqeCtw42C8G4wRU8/OLNXHa8psZyQB2f7zk2M53qBpXDonUMd
         q3eKUJagyVP87nxQ9bFc/mhBBXsg3wU52NPgjMebunj/3KjafSxHFDtm1a6weXS0I91O
         15PF3ROpTe0RtdWv/yj6b2qQqZ0d+OO4xLUJbSLSXKKHVsm/8AyOYjqPHB5z252mBg3n
         HbFRXypqJf7L6uB1v+4nn40K6xdYYbC0GKe9JHRtp9X/DmbhRgI16HaZV6efL9U9IjDY
         UdoZSVQcv0iMpBiQ9xTT8uFkxqKZXJ81fOY4ddUtvBQQx70HLaAVbrTOIWZVh8v5qdh1
         jijA==
X-Gm-Message-State: AOJu0YwZvCArTTpcJX7xUsyap1+uKNT9B5UJirpftj6TrRcvEdcDq+5A
	8XxGYbIZJDgVUw2+sUDSIltEoz+SXsJOENnMWD6BESOOYE2d1NfbO3VGxt5k
X-Gm-Gg: ASbGncsFVirwUTj2cvGYJYvuhdCDaPbjJ9MNWv/ghlbIJnPO1Dvx0TvTtf8NCemJ3Va
	PWoMKPG5c0kHHT6T2yOJAtHwfIRVZAxq5RYLKzz+I5o8Yi5LW7zH4ZRWJ84mMw0zzi2HvBW7LJB
	fx5emT9o2KxR8QiKJQxsjmv8aRijJMSqJse3KXSrcTqkecOJ9aIL/StdSCGDcVvl+5cIqOhGw4M
	Qre4Ls10rDOvxM9HpNPIfes10YNF/7fKe3IMwUUD8D+Cn08UydxTpGGgWbGhh4qkFsHocDjosRb
	ANWEi99HoHFpCWiq4RH17Uuh+/R/BiHISqRFBQ==
X-Google-Smtp-Source: AGHT+IHFnwWjhh9WoKjcvB31S3YpA93ckgAl2yXU3HGAZV5080i4xXOntPR0NTXsZqKQX5rZBmw+/Q==
X-Received: by 2002:a05:600c:3553:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-4409bcfc1ebmr18164855e9.6.1745494391198;
        Thu, 24 Apr 2025 04:33:11 -0700 (PDT)
Received: from [10.148.85.1] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e0241sm17591885e9.37.2025.04.24.04.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:33:09 -0700 (PDT)
Message-ID: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
Subject: [question] robust netns association with fib4 lookup
From: Ferenc Fejes <ferenc@fejes.dev>
To: netdev <netdev@vger.kernel.org>
Cc: "<idosch@nvidia.com>" <idosch@nvidia.com>, kuniyu@amazon.com
Date: Thu, 24 Apr 2025 13:33:08 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

tl;dr: I want to trace fib4 lookups within a network namespace with eBPF.  =
 This
works well with fib6, as the struct net ptr passed as an argument to
fib6_table_lookup [0], so I can read the inode from it and pass it to users=
pace.


Additional context. I'm working on a fib table and fib rule lookup tracer
application that hooks fib_table_lookup/fib6_table_lookup and fib_rules_loo=
kup
with fexit eBPF probes and gathers useful data from the struct flowi4 and f=
lowi6
used for the lookup as well as the resulting nexthop (gw, seg6, mpls tunnel=
) if
the lookup is successful. If this works, my plan is to extend it to neighbo=
ur,
fdb and mdb lookups.

Tracepoints exist for fib lookups v4 [1] and v6 [2] but in my tracer I woul=
d
like to have netns filtering. For example: "check unsuccessful fib4 rule an=
d
table lookups in netns foo". Unfortunately I can't find a reliable way to
associate netns info with fib4 lookups. The main problems are as follows.

Unlike fib6_table_lookup for v6, fib_table_lookup for v4 does not have a st=
ruct
net argument. This makes sense, as struct net is not needed there. But with=
out
it, the netns association is not as easy as in the v6 case.

On the other hand, fib_lookup [3], which in most cases calls fib_table_look=
up,
has a struct net parameter. Even better, there is the struct fib_result ptr
returned by fib_table_lookup. This would be the perfect candidate to hook i=
nto,
but unfortunately it is an inline function.

If there are custom fib rules in the netns, __fib_lookup [4] is called, whi=
ch is
hookable. This has all the necessary info like netns, table and result. To =
use
this I have to add the custom rule to the traced netns and remove it
immediately. This will enforce the __fib_lookup codepath. But I feel that a=
t
some point this bug(?) will be fixed and the kernel will notice the absence=
 of
custom rules and switch back to the original codepath.

But this option is useless for tracing unsuccessful lookups. The stack look=
s
like this:
__fib_lookup                    <-- netns info available
  fib_rules_lookup              <-- losing netns info... :-(
    fib4_rule_action            <-- unsuccessful result available
      fib_table_lookup          <-- source of unsuccessful result

My current workaround is to restore the netns info using the struct flowi4
pointer. When we have the stack above, I use an eBPF hashmap and use the fl=
owi4
pointer as the key and netns as the value. Then in the fib_table_lookup I l=
ook
up the netns id based on the value of the flowi4 pointer. Since this is the
common case, it works, but looks like fib_table_lookup is called from other
places as well (even its rare).

Is there any other way to get the netns info for fib4 lookups? If not, woul=
d it
be worth an RFC to pass the struct net argument to fib_table_lookup as well=
, as
is currently done in fib6_table_lookup? Unfortunately this includes some ca=
llers
to fib_table_lookup. The netns id would also be presented in the existing
tracepoints ([1] and [2]). Thanks in advance for any suggestion.

Best,
Ferenc


[0] https://elixir.bootlin.com/linux/v6.15-rc3/source/net/ipv6/route.c#L222=
1
[1] https://elixir.bootlin.com/linux/v6.15-rc3/source/include/trace/events/=
fib.h
[2] https://elixir.bootlin.com/linux/v6.14/source/include/trace/events/fib6=
.h
[3] https://elixir.bootlin.com/linux/v6.15-rc3/source/include/net/ip_fib.h#=
L374

