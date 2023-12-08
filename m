Return-Path: <netdev+bounces-55489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC380B0A4
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9623E1F212BE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02065ABAB;
	Fri,  8 Dec 2023 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuKS3EA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0E10E0
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 15:38:55 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d3c7ef7b31so25880887b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 15:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702078734; x=1702683534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIjQQFFUX9zSCnboPsw1mgqaTeX8KFxb01r9jhyevlI=;
        b=RuKS3EA5DLzyJTFtGnvREy3PWOi3puxGlxrXtumKyQ84De2f7NElL17U6r0rFnyGUq
         UdsE2N2O+kG6ijnUCkwv46FuOBPJCErIDdUZfIBB4WVLvAhWCDwyaae++LHkqb27pPuP
         naZrdpAO0cy4RHtnvRgZopHA63kw8ulUr7uf+xSJeVM3JfC43PXC8KlXtroo3TAzJzaL
         iijHTcVE1QhiLPsUon1oGNUXTQ1bF+sYsfoBkvkhLxgfB8wFvUsK1MpEo5GhqVi8rnFv
         Iduwhp0nov6d+MkdrMA6m5OzhaWSJuPck6wYXXsOMyUpvAj7UkWch940RswxUjVpwDbd
         zYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078734; x=1702683534;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIjQQFFUX9zSCnboPsw1mgqaTeX8KFxb01r9jhyevlI=;
        b=B8LvD9XAyY2tYHYo2vH7BxB36IvB4/WOnZyzm+BndHXzi29qSPzAuHdg7D8frHSg4Q
         v5yBDThS1bJRdajf97KOmK40i8AW5WAcdESzdqh7YGcamHGbgSMff3x/ELFXH815Njk5
         Vi4/9UIyNB5xUu2vihoUbh1JNXy91p0H8E1uCxy+1oo8ONQahewf9xZCH1JzZzj4ivJs
         wgj9GMMEVHa1mITL9xI4aTmOF713pRMBrGYr35libQcK/EOXbTu6jsiwPolAlvhi0+9Z
         GWe+i3X0dDxwF8/dSUNE7mGmKKLMrA1GLBZV2lckjs/O1GMHTncJTw0bsmMwy7EZq+Ua
         favQ==
X-Gm-Message-State: AOJu0YyypyZzriGmq6v1BWgkxV8pI9gfnDLhSHTY4DBvJr5DLF2qPLdd
	KQ9ybD5noeYloInXRktwtT8=
X-Google-Smtp-Source: AGHT+IFXydUFGphkyg8Jj9oxaVv8btnoFVZq80DimopoNHcfuwJISBuGJah4DheF7k6VQlDz3W4CNQ==
X-Received: by 2002:a81:8312:0:b0:5d3:42a1:8ce1 with SMTP id t18-20020a818312000000b005d342a18ce1mr780611ywf.23.1702078734401;
        Fri, 08 Dec 2023 15:38:54 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:65fe:fe26:c15:a05c? ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm85630ywk.78.2023.12.08.15.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 15:38:54 -0800 (PST)
Message-ID: <3cea4a80-09c0-4a58-87e9-25073b4e9c9f@gmail.com>
Date: Fri, 8 Dec 2023 15:38:52 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-2-thinker.li@gmail.com>
 <353fc304-389b-4c16-b78f-20128d688370@kernel.org>
 <92dcf735-6e9c-48dc-a020-d4e2658dff19@gmail.com>
In-Reply-To: <92dcf735-6e9c-48dc-a020-d4e2658dff19@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/8/23 15:19, Kui-Feng Lee wrote:
> 
> 
> On 12/8/23 14:43, David Ahern wrote:
>> On 12/8/23 12:45 PM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Check f6i->fib6_node and hlist_unhashed(&f6i->gc_link) before 
>>> inserting a
>>> f6i (fib6_info) to tb6_gc_hlist.
>>>
>>> The current implementation checks if f6i->fib6_table is not NULL to
>>> determines if a f6i is on a tree, however it is not enough. When a 
>>> f6i is
>>> removed from a fib6_table, f6i->fib6_table is not reset. However, 
>>> fib6_node
>>> is always reset when a f6i is removed from a fib6_table and is set 
>>> when a
>>> f6i is added to a fib6_table. So, f6i->fib6_node is a reliable way to
>>> determine if a f6i is on a tree.
>>
>> Which is an indication that the table is not the right check but neither
>> is the fib6_node. If expires is set on a route entry, add it to the
>> gc_list; if expires is reset on a route entry, remove it from the
>> gc_list. If the value of expires is changed while on the gc_list list,
>> just update the expires value.
>>
> 
> I don't quite follow you.
> If an entry is not on a tree, why do we still add the entry to the gc 
> list? (This is the reason to check f6i->fib6_node.)
> 
> The changes in this patch rely on two indications, 1. if a f6i is on a 
> tree, 2. if a f6i is on a gc list (described in the 3rd paragraph of
> the comment log.)
> An entry is added to a gc list only if it has expires and is not on the 
> list yet. An entry is removed from a gc list only if it is on a gc list.
> And, just like what you said earlier, it just updates the expires value
> while an entry is already on a gc list.

Add more context here.

Use rt6_route_rcv() as an example. It looks up or adds a route first.
Then it changes expires of the route at the very end of the function.
There is gap between looking up and the modification. The f6i found here
can be removed from the tree in-between. If the f6i here is added to the
gc list even it has been removed from the tree, fib6_info_release() at 
the end of rt6_route_rcv() might free the f6i while the f6i is still in
the gc list.

This is why it checks if a f6i is on the tree with the protection of
tb6_lock.

