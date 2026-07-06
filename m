Return-Path: <netdev+bounces-304840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qn7DOeZIS2p9OgEAu9opvQ
	(envelope-from <netdev+bounces-304840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 08:19:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140B70CD4F
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 08:19:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=b7BOw4+f;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304840-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304840-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6091330036E3
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495BA3C1095;
	Mon,  6 Jul 2026 06:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BE3C0634;
	Mon,  6 Jul 2026 06:18:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318710; cv=none; b=tXAVu1kreRonQEKxTkB63d+DfwB7BLpStiGIcqltPzR2C0CQ8pl3FTYgKgozVqyNLyJQbiwF+iGS3/QWEEB+TXh2xfkilyNSqg9DJLkdkmf+Bj7zMBYpfmHPl6E4G3f5pYfb/qcjPrIeZ62JGSIbNbAoNiOg+8B2tbex5qNw/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318710; c=relaxed/simple;
	bh=rlzJi+w5pTVlNbGPp8zxuDj9vBrmk0/GV9kbg45qOCI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igTam+hVtkwJsbd3TkEf/1+tCnGybVQUtdCY7i09s8aOVj6AI9ZXq+kMzq/ITi1rqN8XXyBCjyQNjTIc9RP7MSoqQ5hPzsNOwIfMgibbDyy7S2tRoQ6/8CtzDQPPuaqBLEe0NEYFSBBRgVbwCrAdC62gKxEUeX0KOKhqH/famcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=b7BOw4+f; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6FAE4206B0;
	Mon,  6 Jul 2026 08:18:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LikC3xw6zmZr; Mon,  6 Jul 2026 08:18:23 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BD74E201D5;
	Mon,  6 Jul 2026 08:18:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BD74E201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783318703;
	bh=n9FT2Biw8AjI4t21xCaa7W5yfp4/uLPWUAUCJ93irr0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=b7BOw4+fsXY9qVWQWuiToIxEPuyWdGLf154j++u/JMy5W0ZMtGuI5KMOuB01Mhlyc
	 CG8UvzowFpcEo9k4IvEmn6dsKKpukub0v6pGsVZAyL2btq7IucumsUOhO6p2dDN1cs
	 p8gJx6WkMHhbdLvj8iFHRRLtYrQdOrpwr9GIEgf9BmyvYMNQHOmz26fWYtCMYCPhMx
	 UrRM+hGAtbDrtT3YVHb7aqyGbI94aux3Ejd12g4ihQJxOY4k24U8L7Cnm04RnEdq/y
	 SQNPSwMJP/4nE9/TDmsD3gJzV8H0+jPplxbIdh6K61hNu/1o4U1/Iz1jZjZpB3ihXP
	 53zZuxlExIQMA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 08:18:22 +0200
Received: (nullmailer pid 3240584 invoked by uid 1000);
	Mon, 06 Jul 2026 06:18:21 -0000
Date: Mon, 6 Jul 2026 08:18:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cen Zhang <zzzccc427@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<baijiaju1990@gmail.com>
Subject: Re: [PATCH v2] xfrm: cache the offload ifindex for netlink dumps
Message-ID: <aktIrbQDaG5M-3MJ@secunet.com>
References: <20260627035058.2745055-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260627035058.2745055-1-zzzccc427@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4140B70CD4F

On Sat, Jun 27, 2026 at 11:50:58AM +0800, Cen Zhang wrote:
> copy_to_user_state_extra() only holds a reference to the outer xfrm_state.
> That does not pin x->xso.dev. NETDEV_DOWN and NETDEV_UNREGISTER can race
> through xfrm_dev_state_flush(), xfrm_state_delete(), and
> xfrm_dev_state_free(), which clears xso->dev and drops the netdev
> reference before the GETSA dump reaches xso_to_xuo() and reads
> xso->dev->ifindex.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> XFRM_MSG_GETSA dump path:           NETDEV teardown path:
> 1. xfrm_get_sa() gets xfrm_state    1. xfrm_dev_state_flush() finds x
> 2. copy_to_user_state_extra() sees  2. xfrm_state_delete() removes x
>    x->xso.dev                          from the SAD
> 3. copy_user_offload() calls        3. xfrm_dev_state_free() clears
>    xso_to_xuo()                        xso->dev
> 4. xso->dev->ifindex dereferences   4. netdev_put() drops the device
>    a detached net_device               reference
> 
> Avoid following the live net_device from the dump paths. Cache the
> attached ifindex in xfrm_dev_offload when state or policy offload is bound
> to a device, and serialize that snapshot instead. This preserves the
> user-visible XFRMA_OFFLOAD_DEV value without depending on the embedded
> net_device lifetime.
> 
> Validation reproduced this kernel report:
> Oops: general protection fault
> 
> Call Trace:
>  <TASK>
>  copy_to_user_state_extra+0xb8d/0x1370 [xfrm_user]
>  ? __pfx_copy_to_user_state_extra+0x10/0x10 [xfrm_user]
>  ? __asan_memset+0x23/0x50
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __alloc_skb+0x342/0x960
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __asan_memset+0x23/0x50
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __nlmsg_put+0x147/0x1b0
>  dump_one_state+0x1c7/0x3e0 [xfrm_user]
>  xfrm_state_netlink+0xcb/0x130 [xfrm_user]
>  ? __pfx_xfrm_state_netlink+0x10/0x10 [xfrm_user]
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? xfrm_user_state_lookup.constprop.0+0x230/0x310 [xfrm_user]
>  xfrm_get_sa+0x102/0x250 [xfrm_user]
>  ? __pfx_xfrm_get_sa+0x10/0x10 [xfrm_user]
>  xfrm_user_rcv_msg+0x504/0xaa0 [xfrm_user]
>  ? __pfx_xfrm_user_rcv_msg+0x10/0x10 [xfrm_user]
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? stack_trace_save+0x8e/0xc0
>  ? __pfx_stack_trace_save+0x10/0x10
>  netlink_rcv_skb+0x11f/0x350
>  ? __pfx_xfrm_user_rcv_msg+0x10/0x10 [xfrm_user]
>  ? __pfx_netlink_rcv_skb+0x10/0x10
>  ? __pfx_mutex_lock+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  xfrm_netlink_rcv+0x65/0x80 [xfrm_user]
>  netlink_unicast+0x600/0x870
>  ? __pfx_netlink_unicast+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_stack_trace_save+0x10/0x10
>  netlink_sendmsg+0x75d/0xc10
>  ? __pfx_netlink_sendmsg+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ____sys_sendmsg+0x77a/0x900
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_____sys_sendmsg+0x10/0x10
>  ? __pfx_copy_msghdr_from_user+0x10/0x10
>  ? release_sock+0x1a/0x1d0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? netlink_insert+0x143/0xec0
>  ___sys_sendmsg+0xff/0x180
>  ? __pfx____sys_sendmsg+0x10/0x10
>  ? _raw_spin_lock_irqsave+0x85/0xe0
>  ? do_getsockname+0xf9/0x170
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? fdget+0x53/0x3b0
>  __sys_sendmsg+0x111/0x1a0
>  ? __pfx___sys_sendmsg+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __sys_getsockname+0x8c/0x100
>  do_syscall_64+0x102/0x5a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Patch applied, thanks a lot!

