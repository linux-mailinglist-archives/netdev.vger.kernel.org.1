Return-Path: <netdev+bounces-135687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4699EE19
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5631C211A6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6E824A0;
	Tue, 15 Oct 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bH2f/BKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FD1FC7C3
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000005; cv=none; b=sNOfKLxRrbbX53rsZGgnq4K3Mz4nELrdpsUci4Yhq5+bJJy1LBgqVG12QleZfjI5W3C5ucuEWzG/Hy6OJIrUIp83rYHO3dXsOW8c7gtaxZiJD7HIvww1nOvFK3O9Fa5OO8xGzottPLFASo/trWlzRJGPZOyI06dC2tiX0LjrS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000005; c=relaxed/simple;
	bh=q62JnlpGvQrNlL5bd2tboYXBr4WTw0avkPIpj98C1ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuOsbbLGali7T09/LxPszmPl2GGHf0mUa7DQcYFiGybdVUFYu3+etAsGWpCrBVSZnaPnG5xhnPJJtb9QzMAEEjCkT4qKyy8OWa8XCUAQxB6c9B7A5xbfNXvFApGhEOJNF+Dp2svqqwsEWqJsy1LVzswnJJFsLSWLZX7a0hPDwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bH2f/BKR; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2883e3f5419so2007527fac.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729000003; x=1729604803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+cS+yYy++qjTT7dM/j+ez5JiqVIlQGcvtkUSzcKR6nA=;
        b=bH2f/BKRZM2mAmWAyZ8uwkvL2rs8uO4nY2Oz4ZfnwdXWPVASOT2rqg02OAcxCaFZ+E
         up5eknN28DbyIzwWeGPSDG1d35z1V0DhbYHGF+Uij9Gn20b5RXEKVq7/lvEFlhInt055
         tx0Bpwzr1Ra/Nb+L2Obus9IKzqq4vSyC3YkGxTmX8YZ733cQJCP8LdlezMgU+jjjVhIB
         o249CUQhp+41euHfpuhcKz/qbyzf/nbvWv1m2d6xR4JkNmwzI0TvjxxLyWDroulkCK9O
         YSXLu13EUWlWnguyBhrIMW+AL6YFrZ1wAod3LYvmZ7gBzmB7HB44lIbuEsM2ECdMQSKI
         QSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000003; x=1729604803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cS+yYy++qjTT7dM/j+ez5JiqVIlQGcvtkUSzcKR6nA=;
        b=PpYmqRewbGz3R87rfaqCtNLgn0Of6WuTdWxzugHNzSGcGXLC3Po/pluMI6nH3383Ws
         /ZJEB0i8JbbQ3N/ZqWa2KSoeefqNiDihoMqiSKc2ERJDbbGX0VAyhNeRPKILQbTa096a
         I8z0P/+IGhdAvxpmDdocrUsI1bG0Tunru/u89BYyKc50v0GnQMR+OTJRWihYT0XFgHgT
         zqToExzFU232RNlsC3AicRTCmg6+jjBRMtgPUSd1QLO7Qv0szM4bHKtgB8cAk1JoFFCc
         PQPB1/zmx8CpQWv25HyiVjcIr65NAFe2ZIT34j1aYne5cfNEbxYr7wP37SmH2FCqgj7h
         i3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJzdjDakkqXT30gs/2fZrJtn/Y7HffKpiIJUXhCnHpJ6Ch72XH2SNirbtKgcgBN+/Z8m0d1W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8dSSuzQFB2DmXcpU1iRqgOpPuNsfBnlbvBvSBw9ik7PZhYv8
	E2lXPcboBfPpP/YrTlMHlSRK4bc1KIyCQQ+cLJ8wrcF+yexYGUHgp/t4ea1nHW3TFs44DZDbO91
	VuvvA5s/vS/UP2rHgrz03+NO7Y6ePvKxWK21gFQ==
X-Google-Smtp-Source: AGHT+IEYlnTWfFWQ/I/EEX0CtwI4n+u4/5Onk4nA64oS/h4StMzYNdzAJiuW3+5Y0RW1u/msH971/mQA4eRlCU2fCQk=
X-Received: by 2002:a05:6870:56a5:b0:284:ff51:58ad with SMTP id
 586e51a60fabf-2886ddfbf2cmr11429139fac.27.1729000002788; Tue, 15 Oct 2024
 06:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015131621.47503-1-linma@zju.edu.cn>
In-Reply-To: <20241015131621.47503-1-linma@zju.edu.cn>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Tue, 15 Oct 2024 15:46:06 +0200
Message-ID: <CAMZdPi_nPx+FaNsEzmN9L=uFGr5xPRud8L3CodgTtSsSsFKSpw@mail.gmail.com>
Subject: Re: [PATCH net v1] net: wwan: fix global oob in wwan_rtnl_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 15:16, Lin Ma <linma@zju.edu.cn> wrote:
>
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
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x177/0x231 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:284 [inline]
>  print_report+0x14f/0x750 mm/kasan/report.c:395
>  kasan_report+0x139/0x170 mm/kasan/report.c:495
>  validate_nla lib/nlattr.c:388 [inline]
>  __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
>  __nla_parse+0x3c/0x50 lib/nlattr.c:700
>  nla_parse_nested_deprecated include/net/netlink.h:1269 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3514 [inline]
>  rtnl_newlink+0x7bc/0x1fd0 net/core/rtnetlink.c:3623
>  rtnetlink_rcv_msg+0x794/0xef0 net/core/rtnetlink.c:6122
>  netlink_rcv_skb+0x1de/0x420 net/netlink/af_netlink.c:2508
>  netlink_unicast_kernel net/netlink/af_netlink.c:1326 [inline]
>  netlink_unicast+0x74b/0x8c0 net/netlink/af_netlink.c:1352
>  netlink_sendmsg+0x882/0xb90 net/netlink/af_netlink.c:1874
>  sock_sendmsg_nosec net/socket.c:716 [inline]
>  __sock_sendmsg net/socket.c:728 [inline]
>  ____sys_sendmsg+0x5cc/0x8f0 net/socket.c:2499
>  ___sys_sendmsg+0x21c/0x290 net/socket.c:2553
>  __sys_sendmsg net/socket.c:2582 [inline]
>  __do_sys_sendmsg net/socket.c:2591 [inline]
>  __se_sys_sendmsg+0x19e/0x270 net/socket.c:2589
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x45/0x90 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f67b19a24ad
> RSP: 002b:00007f67b17febb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f67b1b45f80 RCX: 00007f67b19a24ad
> RDX: 0000000000000000 RSI: 0000000020005e40 RDI: 0000000000000004
> RBP: 00007f67b1a1e01d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd2513764f R14: 00007ffd251376e0 R15: 00007f67b17fed40
>  </TASK>
>
> The buggy address belongs to the variable:
>  wwan_rtnl_policy+0x20/0x40
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
>  ffffffff8b09ca00: 05 f9 f9 f9 05 f9 f9 f9 00 01 f9 f9 00 01 f9 f9
>  ffffffff8b09ca80: 00 00 00 05 f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9
> >ffffffff8b09cb00: 00 00 00 00 05 f9 f9 f9 00 00 00 00 f9 f9 f9 f9
>                                                        ^
>  ffffffff8b09cb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> According to the comment of `nla_parse_nested_deprecated`, use correct size
> `IFLA_WWAN_MAX` here to fix this issue.
>
> Fixes: 88b710532e53 ("wwan: add interface creation support")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

