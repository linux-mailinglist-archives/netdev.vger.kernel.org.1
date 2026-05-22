Return-Path: <netdev+bounces-290840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uADnAItXEGopWgYAu9opvQ
	(envelope-from <netdev+bounces-290840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:18:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3B5B4F8D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D5F30C0CE7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D53A1691;
	Fri, 22 May 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Y2AUhD+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89339B949
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455479; cv=none; b=t77crvx78LsX8zDA6ub5vB3oYSGVXQNuddIuhovEa1HmQbeMf72JJsdYudcX1JNDyoh2HCsoJpL5+0ynuk2gg1BMAf2CjcClMKDGKgixO5Xrk+KqODONydW23DXZGZcEkKWOHV5GfkcYDEzilhQgHofZ+Jk2mUioi+7Eibj671k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455479; c=relaxed/simple;
	bh=klVSu0JLLTlpiCCBXhux3M842iPuadk8WNWrHaeJb+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GMDDxC4b/hq/T0as7nsouhSjJdR40Lyf3sJrzd9YwAuG/zGKbZvYaXM7LjCguyn+N5P8eb7f63X7FKyVgRU0zmkm9iLbWTgLvA9poNwUi8cfmwrdExqAhngg0Qiz7a753IgEoLFvswOlSMyVZdFrItSzQd2IEwRZDs4xBNtDjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Y2AUhD+D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-452aacde862so583628f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779455476; x=1780060276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JseKq7JVatXXIQ/Mz6pwa6sbVEoI7fROPI77w2S8ngw=;
        b=Y2AUhD+DJIIfEo//AiChddjcuLMYKoFiuuTyPFawNntrq7AYL7aP9XZKNLDK/7XZ1g
         Qrerd3FCY3ZYkizOsqtwUNx9gURpBG1grq8yGxDWXbdGAgxbRWXvgK+N/9lIGBqpESvQ
         9zN9MlurkTqZZ6Dl7YmqjVRJFn/lef499Ul7ri7oV6tqM1FEx3nogjOXZd5BsHDyUkUe
         CESuRF9sBXdr8cNcQPGvrBLKQepPbbMP4mojAfZ2bkZFrYP9UIXKPXdxrNRRYueaJ9C2
         zYNKVwcw6bwR+4zP5Vvt2osF6pVkPLFVX7tvaw90CHPEtFZfCNPOnYd1K/bnZdJIo3Ns
         kXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455476; x=1780060276;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JseKq7JVatXXIQ/Mz6pwa6sbVEoI7fROPI77w2S8ngw=;
        b=DW141zVYqcc32ArG+6lsDoPdfCYhSApdz8hoM47G94NkG2GCdyQPc4Ohu6VWLag2Ca
         JSRWk6itV2/REqwAs1DtMNpHcURDDwCLd4FCQF28V8PGSfoufa4zie5c25woCCoqHOPn
         fCCnAJ+aqmhishBrWIMfld6r0Y9xh8RbhCLMnNN9c/vTeeakuM4YgXio4Y0lLgmq6A8S
         /x94uN+ZFG3MORryiJWjeNgeolZohn9bo0QltZ2aI63X5NGyW2Cu4ayFOOLVL1wmfa6e
         RINB/fyPH3Rp6D51Xb32IbkV/x/A/u1ICpcBK9yCpo7EHdqS5AJJ2buJwsIZIa+/dz2c
         OGZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9COim/WaHTRzyoc3HGL9VtsXAi67qVThwo4Tblkh5aM/5dViXtakQy7ypI4XBPxe1It/bJ1k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvEzCawspuulve785+0C0MFYfGlClogf/oNuB03YmqlQ19lZb
	0G93mPc5v4AfH4vKyWJ0azYP7ostEkSgetVAPgmQD/750rTAiMO144Oml599kYYYecM=
X-Gm-Gg: Acq92OEzQclSpOHD0kJsOaRgezsFT+GlYe7Qf/v5rBelJWsTcwwVv6uG3ro49TjKX0k
	2swhtr1zmJwcpw4C/CUa7u4cOVYbto8LfpaHJ9DtRJX5VHSq5h5b6lS9N8VDllbA8c40c+WKguk
	RKs2yhVt8e+Jh/K9CQ19t9QulVheIxathDSV75F68m3ciWLxP8pr9l1UqCny98QPZYUWWi1j0iY
	24I7to2KtGNeAjCoJxPgmEdJz4mgDSucxOlCF+eHqWQJ6SFQmgE57L8+3jLUzW16d3iJt1oO8PP
	/jKL15c60t4KiIvMMddJAq7gQ2MnK5PmkDSPzhFNg7FgtwgsygtGOyb2/MBaAAxdIyvgEeR+CTf
	GOZbUNjrE6zoU2N8cOhADZjdYeN+qk2/tIT3vZ1MCtk3q4N1e6NvZ6EKCtsk/8i+7Xlb19UPiYD
	wz4ZBgRigwwepPGa2B94hiaTz/PIG8Se1/d+RaZE1m7MZQuFD5MJTkcr64q4a8eQWNjjaD4N37N
	JBO
X-Received: by 2002:a05:600c:474d:b0:490:3d89:4bd1 with SMTP id 5b1f17b1804b1-49042ae9a03mr20898385e9.5.1779455475752;
        Fri, 22 May 2026 06:11:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm50131665e9.8.2026.05.22.06.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 06:11:15 -0700 (PDT)
Message-ID: <f5f83336-8d24-4060-b846-c55492ee10bc@6wind.com>
Date: Fri, 22 May 2026 15:11:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] net: neighbour: reject neighbor creation on IFF_NOARP
 devices
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
References: <98be20ee-c914-4c93-b4bd-d04ddcc349cf@I-love.SAKURA.ne.jp>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <98be20ee-c914-4c93-b4bd-d04ddcc349cf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-290840-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com]
X-Rspamd-Queue-Id: 56A3B5B4F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 15/05/2026 à 17:05, Tetsuo Handa a écrit :
> syzbot is reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem.
> 
> I asked AI Mode in Google Search to analyze a log from my debug printk()
> patch in linux-next-20260508. It performed a meticulous trace of
> __dev_hold() and __dev_put() frequency, and identified that a reference
> acquired via ___neigh_create() remains unreleased at the end of the device
> unregistration timeline.
> 
>   Call trace for vcan0[24] +1 at
>        __dev_hold include/linux/netdevice.h:4470 [inline]
>        netdev_hold include/linux/netdevice.h:4513 [inline]
>        ___neigh_create+0xcb3/0x2360 net/core/neighbour.c:664
>        neigh_add+0xc51/0xf70 net/core/neighbour.c:2136
>        rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:7005
>        netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
>        netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>        netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
>        netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
>        sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
> 
> For devices that do not require address resolution, such as CAN devices
> (vcan) or loopback (lo) which carry the IFF_NOARP flag, explicit neighbor
> creation requests (via Netlink RTM_NEWNEIGH) shouldn't be permitted.
The patch was dropped, but just for the record, it is valid to add a neighbor to
an NOARP device.
For example, a GRE device is flagged NOARP, but for multi-point GRE, neighbors
are used:

$ ip -details link list dev gre1
9: gre1@ntfp2: <NOARP,UP,LOWER_UP> mtu 1476 qdisc noqueue state UNKNOWN mode
DEFAULT group default qlen 1000
    link/gre 10.125.0.1 brd 0.0.0.0 promiscuity 0  allmulti 0 minmtu 68 maxmtu
65511
    gre remote any local 10.125.0.1 dev ntfp2 ttl 64 addrgenmode eui64
numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size
65536 tso_max_segs 65535 gro_max_size 65536
$ ip neigh list dev gre1
10.200.0.1 lladdr 10.125.0.3 PERMANENT
192.168.0.2 lladdr 10.125.0.2 PERMANENT

My two cents,
Nicolas

