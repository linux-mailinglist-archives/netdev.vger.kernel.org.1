Return-Path: <netdev+bounces-74919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99F867604
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C279AB28D56
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911F47F7E8;
	Mon, 26 Feb 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="B7Q7sYMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC25EC7
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951981; cv=none; b=UrBBADQIoLIGMMRuPoPRiBRc71W7O1TSHPAE2EduGImYmZcDJDx4MCSBPelufelu9bkyEWtbke4IKY5nb4EKk2DcOd+h41dJasxhTsvttVQEdxNrn9we8VxZBtEY+Zd4wAVxiccvTDTBgK/rikiMBtZJVCwaKT65DEV4J8hL77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951981; c=relaxed/simple;
	bh=titE56FlJl3hqXS9Fw3Xp5ov0sJVkKaI8t50GpSw+5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIV1mqKAZsvxZyXfq5Y+SL63sCDopeZakG/zxAsh6euKs6bMghwxH4rkrIYITrNE+lfdvum4TALMBHZLDqIKRyIN7La+KgcazuzCLKb7GjP5oWs5iL8sPpcIwh63UddT1Vy6WWYXn9SgVMDkD3RCxqnnKTUZwm0Sbl5sgpTIp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=B7Q7sYMf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d26227d508so33180651fa.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 04:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708951977; x=1709556777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvKY8egBITSvg7eGivJmR08wh/1LCGSVapnsSF/ZFdA=;
        b=B7Q7sYMfG5Q7qqEDyZ0W3i0vsWXSlYp/dsKzo9wM8o/10H5Z/+AWqWCCK3QkurnS4j
         nK8f5ZZTcH6rMlMir5e+BZIWQnTVZm8uqqzw2Iq5eawV+CbW0ls0chVgMS/pom6jKrXY
         bYRoVUBnoRzbxq3kENr/9FY6H571EueKnyaLhHKqCc8Q9MjZbPUEqswsY3KwhBR792uH
         dmZ1mFWe3fiUJWJLccBgUaTFkTUFx3cJF6S+YiDZAq0dARlf5bpuJNJy0sy3ABn3avwP
         XDQ0m5yC9nk4eSpVVXXoyfoyn4bMSvXGA3dThADqlRr5S0RDbNAw2yHplxTwQJkm4wAq
         fhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708951977; x=1709556777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvKY8egBITSvg7eGivJmR08wh/1LCGSVapnsSF/ZFdA=;
        b=ZgN0VnR+PeyPjP/0qocYn/ehUsjZaUzj3cbDXZIJB7JoN1F5Enp+Y4k/ykXCLoamzT
         mjsaJj2+pjN1/Rw6hhjg9T64T+KXZcKl83r7lpMKjShY775KRVo0/NGr/RTZQjAOOI4p
         eN+j4ji2XyI2Ihcypol1htvAVuDGAUmjVnthdTLFrUvIF6ev1HhpTQn4lwcRSTtd+Nn+
         UhJJrpS1DvERvV4gp026k7Pf1P4wkbAKjnpl+XAinbuml9B+DWsREvHS0uufOaMvIq0p
         XDsgtuuuH5U2MiRk9fpc2meOI2lj3Gu6/kuK5hJWHXREa76cXYowIx+r3Z5D82kIYPYj
         xL/Q==
X-Gm-Message-State: AOJu0Yx3v4AXGtRGkNEfWmR2BaSu3vuA/udl4Ri1J++7xGpW6ezCSeWV
	uJIzpTt6VXzsXxfGzFNDvje38wl06eG4NVelVgQhfLZNfhqQC1H19RPIpcXgAvY=
X-Google-Smtp-Source: AGHT+IFu2x/lLm1my6ABgx4FESQyrIC9uBUkdhcWddGI/6V4lRKv8j3o7bvS75xXMvoM0SXSXCgGeA==
X-Received: by 2002:a2e:b8c4:0:b0:2d2:8fb4:46cf with SMTP id s4-20020a2eb8c4000000b002d28fb446cfmr1049487ljp.15.1708951976668;
        Mon, 26 Feb 2024 04:52:56 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b00412a482cd90sm3638986wmg.25.2024.02.26.04.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:52:56 -0800 (PST)
Date: Mon, 26 Feb 2024 13:52:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net] netlink: validate length of NLA_{BE16,BE32} types
Message-ID: <ZdyJp3kb--fjF09V@nanopsycho>
References: <20240225225845.45555-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225225845.45555-1-pablo@netfilter.org>

Sun, Feb 25, 2024 at 11:58:45PM CET, pablo@netfilter.org wrote:
>syzbot reports:
>
>=====================================================
>BUG: KMSAN: uninit-value in nla_validate_range_unsigned lib/nlattr.c:222 [inline]
>BUG: KMSAN: uninit-value in nla_validate_int_range lib/nlattr.c:336 [inline]
>BUG: KMSAN: uninit-value in validate_nla lib/nlattr.c:575 [inline]
>BUG: KMSAN: uninit-value in __nla_validate_parse+0x2e20/0x45c0 lib/nlattr.c:631
> nla_validate_range_unsigned lib/nlattr.c:222 [inline]
> nla_validate_int_range lib/nlattr.c:336 [inline]
> validate_nla lib/nlattr.c:575 [inline]
> __nla_validate_parse+0x2e20/0x45c0 lib/nlattr.c:631
> __nla_parse+0x5f/0x70 lib/nlattr.c:728
> nla_parse_deprecated include/net/netlink.h:703 [inline]
> nfnetlink_rcv_msg+0x723/0xde0 net/netfilter/nfnetlink.c:275
> netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2543
> nfnetlink_rcv+0x372/0x4950 net/netfilter/nfnetlink.c:659
> netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
> netlink_unicast+0xf49/0x1250 net/netlink/af_netlink.c:1367
> netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1908
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>Uninit was created at:
> slab_post_alloc_hook mm/slub.c:3819 [inline]
> slab_alloc_node mm/slub.c:3860 [inline]
> kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
> kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
> __alloc_skb+0x352/0x790 net/core/skbuff.c:651
> alloc_skb include/linux/skbuff.h:1296 [inline]
> netlink_alloc_large_skb net/netlink/af_netlink.c:1213 [inline]
> netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1883
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>NLA_BE16 and NLA_BE32 minimum attribute length is not validated, update
>nla_attr_len and nla_attr_minlen accordingly.
>
>After this update, kernel displays:
>
>  netlink: 'x': attribute type 2 has an invalid length.
>
>in case that the attribute payload is too small and it reports -ERANGE
>to userspace.
>
>Fixes: ecaf75ffd5f5 ("netlink: introduce bigendian integer types")
>Reported-by: syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com
>Reported-by: xingwei lee <xrivendell7@gmail.com>
>Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

