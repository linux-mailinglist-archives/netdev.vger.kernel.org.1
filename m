Return-Path: <netdev+bounces-76901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0786F537
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 14:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424E91C2088E
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039C59B5E;
	Sun,  3 Mar 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBMKzgTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFF59B47
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473998; cv=none; b=SaokwgUqsO2ah92YZi9pGeq5PH/AzLc+i8+DKdQBLbA2AXswG6rNwZ+cBtmD4Kh56jNutXb6+J7GQBl0vAUTA0GuMLtgvrfqhWihyvBWNzEKrjDR+tfb42J8wmC+razTvkWyJrZ7mqo9MX2VXFrsCH39MZ9TkMkciT80BIto+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473998; c=relaxed/simple;
	bh=m9WfCAt/9mCpF3w2n1SiZvJlN2JVM0mWtPd73kqnbIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoyYhOiAMpxpkPAsZHhyK760BZxSmDybfp54wv59tNKfg+AkOjjCRMUQav9l6n3Ac6MCGuAMDwQibRlE8WZXX85lArcHwMqo6sMi9jgHz5IP83HSFWhtVwBOWtaXzy+HNfKsVGkbWsNLbl/PEnK7L1RBTtXfmCqrZ/ewrQWUGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBMKzgTu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so15283a12.1
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709473995; x=1710078795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mnrk0wQk2IOhQbi+YVbVoXdcHS2VPAuCcAxwDINWAIc=;
        b=FBMKzgTum4afzJnaWyLec9vm7iCL79oOqNgSqvEIxqE8Kzf/SRgkfUwbP84K2SSOio
         NtfSOW1tqSFJEurlJJLyJCkuNCuWQAT6YsjyYudN0FGZE467/c6zs6EzHhc+2Fir/UJ6
         KC4EoxtZZDSIuoPEvsCvF7HLYUzpswP+pngIR4E8/i0eEKN4JXv9nPkSDbFIPMDgO47H
         3Ue1Cz9PSL/c7sCiMbcRwcnJG/8ir2WVu2e0T35OTHgUWsUEWUbjT4bYXc7yg/Jmob2N
         dwpW/iy11vm1fUk83trdCYgj49xL8Quexbdh7hu/TO6BSHAHNen3yITnrC5mCjnCvjf6
         fr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709473995; x=1710078795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mnrk0wQk2IOhQbi+YVbVoXdcHS2VPAuCcAxwDINWAIc=;
        b=AYpoy+0KDPD3/1NdCPyZUHwBItCNEw9Moo0ADNgIUfTj5nwhBL/iYFLEwOnnbeZjex
         znWABRRSbDjmAH3c2cShuicE/q0Qro9ZNznIiFFYXM2MJm3ssPH+W/BB92LQ6ZiuEyVb
         x2oP9ScKImZGkE4/LsCQUKfZ6ans/vYt/RaI/16XOPNHKRGqYIa441dwCDYHxYu5xFxc
         V8tgw1SAs1VTRyKuYZdXNUjQZDgAN6418096nyjJn8vnaN1xVrVWoWwFHBYP7Vh0wI0m
         LvnsQ3/Fv+GrH8okSs4lEHLz9Xu34Ofg0cWJcFJTmUmImAVywPMT6/d9fDClxnz6g1Uk
         mDCw==
X-Forwarded-Encrypted: i=1; AJvYcCXZHzPp0GTSEZzJSzdXhlW2mRuqhXsGkXr5t9QdN4++Ut9ztaSS0ws5BAUxH4RMMb4vbJU0+thSAgXfSO/TNvDqYP35Yl1r
X-Gm-Message-State: AOJu0Yxrnpk/e5e2xLX2h04MUqQiNgOegipLoWtwRbXGbNMFPRE4p6RL
	SmOtmXT05F1CTOLXuHGia0kC91MI2BUF5O+zYYigC5NJCRVKuFFPt1auzNCpmvAwCVgqmIrYAju
	PRUJ5SXtPBJ3WZCeAI7VxwQyTQLLSK2sLVQ6IxJGNi0V1WvvrwA==
X-Google-Smtp-Source: AGHT+IGm6U2vFqkDC1iJlypsmF5quRLbtAk1KeFZnVmMmjjpFw/WI0WgD+eiHeIPaYKOLxyRAxvAjWmbR8uqqt6iYWM=
X-Received: by 2002:a05:6402:5215:b0:566:f626:229b with SMTP id
 s21-20020a056402521500b00566f626229bmr160373edd.7.1709473994912; Sun, 03 Mar
 2024 05:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b69bf20612bf586e@google.com> <tencent_ECF3CC90A7DB86E312FF464F09BF2EEAAE06@qq.com>
In-Reply-To: <tencent_ECF3CC90A7DB86E312FF464F09BF2EEAAE06@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 3 Mar 2024 14:53:03 +0100
Message-ID: <CANn89i+fJis6omMAuEmgkFy7iND97cA8WecRSVG6P=z15DpHnQ@mail.gmail.com>
Subject: Re: [PATCH] skbuff: fix uninit-value in nr_route_frame
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com, davem@davemloft.net, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ralf@linux-mips.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 2:24=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> [Syzbot reported]
> BUG: KMSAN: uninit-value in nr_route_frame+0x4a9/0xfc0 net/netrom/nr_rout=
e.c:787
>  nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
>  nr_xmit+0x5a/0x1c0 net/netrom/nr_dev.c:144
>  __netdev_start_xmit include/linux/netdevice.h:4980 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4994 [inline]
>  xmit_one net/core/dev.c:3547 [inline]
>  dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
>  __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  raw_sendmsg+0x64e/0xc10 net/ieee802154/socket.c:299
>  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3819 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
>  alloc_skb include/linux/skbuff.h:1296 [inline]
>  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6394
>  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
>  sock_alloc_send_skb include/net/sock.h:1855 [inline]
>  raw_sendmsg+0x367/0xc10 net/ieee802154/socket.c:282
>  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> [Fix]
> Let's clear all skb data at alloc time.

This can not be serious.

>
> Reported-and-tested-by: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>


Fix net/netrom instead.

