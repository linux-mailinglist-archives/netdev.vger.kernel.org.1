Return-Path: <netdev+bounces-138866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E859AF411
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507172870D3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAE215025;
	Thu, 24 Oct 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPUI+SQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D2174EDB
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802944; cv=none; b=kvX+8Dd+GBlRlxde93ydQnOCcoy1ZTKZK1wh0P9Ed78kmxXfHruee56QCgOu8AEwEigRekVhQQgNP+gHvjulZqMXaVRrcWlsc1a0JDxgXUAI0k0BmVsKf9rTmf25CNunjecBLrqKVOvgWHdT+5cPHp9mZP1LirpyxP4HFEEUBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802944; c=relaxed/simple;
	bh=ZAUQ19u6JPutuNoQlSUWmMCq3XVIJW31KqjukiyFV34=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XIQpHylSGGoy1qVhyUhU2UEfM+Fq1FM3I3Usdklt7N3BkL1EMtrteMR3DLRn6YVglky+V7PpEWeBpL+6V8LHF076nVsztCN7fWJ4et4KKTsIaV6l4vucB18Yvi4bWxpSNnTqKz97I9oNpBSqk9oO6FYY0H2hB+chIRuaegjBob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPUI+SQq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baec69eso13889375e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729802941; x=1730407741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=biv3pkIlLBuHm/xvNsHFLjitkwOHL4E9/BZq1CwD4Og=;
        b=QPUI+SQqJjWIDXcIr9DimMY+OSuK7UixDntgJ/pQMEDg3984kBic5e+vP3Jfikoe3j
         033UJlOV01YjP/MYRWAcXaUicmtsCxlzRp9EebWNyeRXqh3GpcMsf+bMknaZ5ngYoca+
         L1mRSxaIOsbnyxJabpRGM7iQNQZNNMd95JJDHIUY/fHGSqg3qT5ubXyl2zEfusOsKrcU
         FgthoZLE9a+Jq7IBAwSbVa3axr1KVGGpnRgJom9zZbHqaL3+ZNNn0ELI0M5a+IYMG6CQ
         uUykWJafZ3h106+PvFxp2NWyK9cZRA7kJQWISmMjm5042kvQ8534zFJVczGvv2QMJYqQ
         +FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802941; x=1730407741;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biv3pkIlLBuHm/xvNsHFLjitkwOHL4E9/BZq1CwD4Og=;
        b=g5UJHcYW77+D3Yb5PAWf6rS1pZt75quaNwuCvxPc0B7f8lLqCUMVGmUt3HlC5lolIx
         iCR3X6Q/Jhf72qCJxnAv/9IfvzulSswqN0S3RK79fRxSRIC3VepTIeKm8OPLA9NKi8cD
         mTCtdETqrYzRX8iYTNEfgYdSgLmXtCAD+pVPSZUcFMIT4XmjWzIS9mHzWdTwzrN6blaK
         XQxcagG0UQYJsQjC7lwAOGATo1GIt37Tt0tBbe9F9NDklgn79AjzmoWTiXKTlqry4Fl8
         Qsrxtmt9WpBdCh1hUKMbVBz+8VUNOmG1dSB1vSHsdu5SktgfHGHyo3zeIemOhI2/EqIT
         Z4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUXa1dMdFGGJte0eV6agZv2km2n1bc0JTXmtogeDjHpOPqaV9BWo3+7FIEcsc6UUcd1cqpav8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtBhD4ZKEPihHGM5NlhMHRtcel/6f5jX2+bgbgZJLrWkVszPZ
	T3sYN9hkHajmtH8CVzUiGfDgLGEHFx3JXBc7DXAC7pkzp/n4/L6l
X-Google-Smtp-Source: AGHT+IFn5pX3JQiTObiIyXNYZVPp7Fjb5sYcy+wxiIwwNeuWtyeoMznEFYic9bk6Fzl34WGWbMEBUw==
X-Received: by 2002:a05:600c:1d1c:b0:431:47d4:19c7 with SMTP id 5b1f17b1804b1-43186222f94mr65817335e9.3.1729802940356;
        Thu, 24 Oct 2024 13:49:00 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1db2csm56166365e9.40.2024.10.24.13.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:48:59 -0700 (PDT)
Message-ID: <51744a97-92d1-4d4f-b0b2-147f44321fc3@gmail.com>
Date: Thu, 24 Oct 2024 23:49:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: wwan: fix global oob in wwan_rtnl_policy
To: Lin Ma <linma@zju.edu.cn>
References: <20241015131621.47503-1-linma@zju.edu.cn>
Content-Language: en-US
Cc: loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241015131621.47503-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.2024 16:16, Lin Ma wrote:
> The variable wwan_rtnl_link_ops assign a *bigger* maxtype which leads to
> a global out-of-bounds read when parsing the netlink attributes. Exactly
> same bug cause as the oob fixed in commit b33fb5b801c6 ("net: qualcomm:
> rmnet: fix global oob in rmnet_policy").
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:388 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
> Read of size 1 at addr ffffffff8b09cb60 by task syz.1.66276/323862
> 
> CPU: 0 PID: 323862 Comm: syz.1.66276 Not tainted 6.1.70 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x177/0x231 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:284 [inline]
>   print_report+0x14f/0x750 mm/kasan/report.c:395
>   kasan_report+0x139/0x170 mm/kasan/report.c:495
>   validate_nla lib/nlattr.c:388 [inline]
>   __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
>   __nla_parse+0x3c/0x50 lib/nlattr.c:700
>   nla_parse_nested_deprecated include/net/netlink.h:1269 [inline]
>   __rtnl_newlink net/core/rtnetlink.c:3514 [inline]
>   rtnl_newlink+0x7bc/0x1fd0 net/core/rtnetlink.c:3623
>   rtnetlink_rcv_msg+0x794/0xef0 net/core/rtnetlink.c:6122
>   netlink_rcv_skb+0x1de/0x420 net/netlink/af_netlink.c:2508
>   netlink_unicast_kernel net/netlink/af_netlink.c:1326 [inline]
>   netlink_unicast+0x74b/0x8c0 net/netlink/af_netlink.c:1352
>   netlink_sendmsg+0x882/0xb90 net/netlink/af_netlink.c:1874
>   sock_sendmsg_nosec net/socket.c:716 [inline]
>   __sock_sendmsg net/socket.c:728 [inline]
>   ____sys_sendmsg+0x5cc/0x8f0 net/socket.c:2499
>   ___sys_sendmsg+0x21c/0x290 net/socket.c:2553
>   __sys_sendmsg net/socket.c:2582 [inline]
>   __do_sys_sendmsg net/socket.c:2591 [inline]
>   __se_sys_sendmsg+0x19e/0x270 net/socket.c:2589
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x45/0x90 arch/x86/entry/common.c:81
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f67b19a24ad
> RSP: 002b:00007f67b17febb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f67b1b45f80 RCX: 00007f67b19a24ad
> RDX: 0000000000000000 RSI: 0000000020005e40 RDI: 0000000000000004
> RBP: 00007f67b1a1e01d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd2513764f R14: 00007ffd251376e0 R15: 00007f67b17fed40
>   </TASK>
> 
> The buggy address belongs to the variable:
>   wwan_rtnl_policy+0x20/0x40
> 
> The buggy address belongs to the physical page:
> page:ffffea00002c2700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb09c
> flags: 0xfff00000001000(reserved|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000001000 ffffea00002c2708 ffffea00002c2708 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner info is not present (never set?)
> 
> Memory state around the buggy address:
>   ffffffff8b09ca00: 05 f9 f9 f9 05 f9 f9 f9 00 01 f9 f9 00 01 f9 f9
>   ffffffff8b09ca80: 00 00 00 05 f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9
>> ffffffff8b09cb00: 00 00 00 00 05 f9 f9 f9 00 00 00 00 f9 f9 f9 f9
>                                                         ^
>   ffffffff8b09cb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> According to the comment of `nla_parse_nested_deprecated`, use correct size
> `IFLA_WWAN_MAX` here to fix this issue.
> 
> Fixes: 88b710532e53 ("wwan: add interface creation support")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

A bit late, but still: nice catch!

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>


