Return-Path: <netdev+bounces-105005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C347A90F6E6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8A41C2090A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93BE158A3A;
	Wed, 19 Jun 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kGR16u6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518F158D66
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824793; cv=none; b=RT64LnCz7odL9GxrmoT4SyM7vspAKuIum/TjWN1f/7/vgDMoO7KujtG0Z/W7RUnoNVP5ZODWT51Pclc9jGambeN8HUsBpnYcuq/FZJBknbbTEWNwdH0eRqm+RWHXdvPBfHreJeFkZ7bK/JpXEwPKZzGg+15MiyWmvLcJ+GF/Z2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824793; c=relaxed/simple;
	bh=WKlVuElq8g7Y/hwi6mN+k+DpIfkuXNWnHL/7uYy560I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6gwcNwerH+gLgel20FgEUmLJ5IL9baB+G5oU6MeGMGP8NW9KufdUm3G5Yy9VyTLgQ1wtv7eAbd1nAeiXlv7PCmtTg4xd72Bolcn0akBQ/V+Em9LCFfz2PhDHrCrSLcardC+s6Z3xcq/mrmvjJF20hXgIqG8EfCfL4hJLzTcSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kGR16u6L; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718824792; x=1750360792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSreXENQd3JlCrrR2MArkt+0PkSwHAeiPFsex6JSDyw=;
  b=kGR16u6LFSH/Xa3quHzc9Lv5rjemNGkNieZsb8W/uSvc/g0W1liC7SjI
   L3pnLcfAZ9pHPf2yLTXU5Nzk9sHM+gDakzof/hVXyrJYEv+qHgR4O27z1
   f1TwiCPhfWv4ApeC8ZkMLZpLvy6HprZL1kqKNSmqJ2DFSmbS2cFd8UUxt
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,251,1712620800"; 
   d="scan'208";a="661640350"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 19:19:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:45118]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.246:2525] with esmtp (Farcaster)
 id 5d9908ab-e39f-420e-9875-3eb3ab7a8114; Wed, 19 Jun 2024 19:19:48 +0000 (UTC)
X-Farcaster-Flow-ID: 5d9908ab-e39f-420e-9875-3eb3ab7a8114
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Jun 2024 19:19:44 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Jun 2024 19:19:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Wed, 19 Jun 2024 12:19:30 -0700
Message-ID: <20240619191930.99009-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <17997c8f-bba1-4597-85c7-5d76de63a7a7@rbox.co>
References: <17997c8f-bba1-4597-85c7-5d76de63a7a7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 19 Jun 2024 20:14:48 +0200
> On 6/17/24 20:21, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Mon, 17 Jun 2024 01:28:52 +0200
> >> (...)
> >> Another AF_UNIX sockmap issue is with OOB. When OOB packet is sent, skb is
> >> added to recv queue, but also u->oob_skb is set. Here's the problem: when
> >> this skb goes through bpf_sk_redirect_map() and is moved between socks,
> >> oob_skb remains set on the original sock.
> > 
> > Good catch!
> > 
> >>
> >> [   23.688994] WARNING: CPU: 2 PID: 993 at net/unix/garbage.c:351 unix_collect_queue+0x6c/0xb0
> >> [   23.689019] CPU: 2 PID: 993 Comm: kworker/u32:13 Not tainted 6.10.0-rc2+ #137
> >> [   23.689021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> >> [   23.689024] Workqueue: events_unbound __unix_gc
> >> [   23.689027] RIP: 0010:unix_collect_queue+0x6c/0xb0
> >>
> >> I wanted to write a patch, but then I realized I'm not sure what's the
> >> expected behaviour. Should the oob_skb setting follow to the skb's new sock
> >> or should it be dropped (similarly to what is happening today with
> >> scm_fp_list, i.e. redirect strips inflights)?
> > 
> > The former will require large refactoring as we need to check if the
> > redirect happens for BPF_F_INGRESS and if the redirected sk is also
> > SOCK_STREAM etc.
> > 
> > So, I'd go with the latter.  Probably we can check if skb is u->oob_skb
> > and drop OOB data and retry next in unix_stream_read_skb(), and forbid
> > MSG_OOB in unix_bpf_recvmsg().
> > (...)
> 
> Yeah, sounds reasonable. I'm just not sure I understand the retry part. For
> each skb_queue_tail() there's one ->sk_data_ready() (which does
> ->read_skb()). Why bother with a retry?

Exactly.


> 
> This is what I was thinking:
>

When you post it, please make sure to CC bpf@ and sockmap maintainers too.

