Return-Path: <netdev+bounces-185305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3FFA99BAD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CCC7AC3EC
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F61FECBD;
	Wed, 23 Apr 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUSXpVHu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EA2701A4
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448754; cv=none; b=g2mlIJZ/5qNMHlYDm3tLjmIQqJFOot+eebVXHarZnxvsx5bQCyS+naKqatG7jGWNNgPoQ1SfvuWCRwe6AY6l83Z/KJwBEwjxBHhLeCKoOi9J7wEAcGPKNU8DnBLSCpDsKJlK19YjqQ6+4gV8U3sUy6+LOaUFuOO4eK4SZX2PA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448754; c=relaxed/simple;
	bh=BHZ5vJEdymKCnahTwxzWRvNj6cuypo4/6UzPJ0XF9kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Die+d32HQy/TX/oLe2raY7aq2Y16Z8xUqCEQkFkwohA8MTuz03TCjzF6vpmWffN0RQcM3UdrIizgEn7/hKVzVvIPhY0Hn+tobYnTLORtdkWF1VP380wDtB+8bayFY5eRZH2y0wmX8HAqM+jI3yhsqxL2pN637jKx6ykfS014Ebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUSXpVHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534D2C4CEE2;
	Wed, 23 Apr 2025 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745448754;
	bh=BHZ5vJEdymKCnahTwxzWRvNj6cuypo4/6UzPJ0XF9kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KUSXpVHug4VIRPALPLl1uAM38EQy1UrL2anX+JA8HWfckrYYfH6bOYp39AbBLCpl1
	 s1FLl9uoRs6Ev/TtppTgNJXP8AFiZqZocav6TgDUaleCcPON9ALwPMAsknD0sROZAA
	 5iK7jqj+SEdH7jSbA5bmTibmR8HxikiLKhyn8PPVHS98EakhDENYrB1RBWTwQSQxM/
	 ay1ttm67c+XGACXXWEuTaHCGKmu6RaPzQEjzTrnlHriyVb8B1I14Rs6pYWwrydaLN/
	 i8cb3M7TfL+Ioj5wJUYnBT2UBPY1CquLQI14uXCHE+i6gQhSFNMPvkfDzxNzk38WO3
	 WVW+f1MQnl/Sw==
Date: Wed, 23 Apr 2025 15:52:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250423155233.33ac2bd3@kernel.org>
In-Reply-To: <20250423145736.95775-1-kuniyu@amazon.com>
References: <20250423064026.636c822f@kernel.org>
	<20250423145736.95775-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 07:12:55 -0700 Kuniyuki Iwashima wrote:
> > >  	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
> > > -		pfcp_dellink(pfcp->dev, &list);
> > > -
> > > -	unregister_netdevice_many(&list);
> > > -	rtnl_unlock();
> > > +		pfcp_dellink(pfcp->dev, dev_to_kill);  
> > 
> > Kuniyuki, I got distracted by the fact the driver is broken but I think
> > this isn't right.  
> 
> I guess it was broken recently ?  at least I didn't see null-deref
> while testing ffc90e9ca61b ("pfcp: Destroy device along with udp
> socket's netns dismantle.").

Not sure, nothing seems to have changed since?

I wiped my kernel, rebuilt net-next and still triggers:

vng -b \
	-f tools/testing/selftests/net/config \
	-f kernel/configs/debug.config \
	-f tools/testing/selftests/drivers/net/config \
	--configitem CONFIG_PFCP=y

vng -r arch/x86/boot/bzImage -v --user root

bash-5.1# ip link add type pfcp
[   62.098561][  T662] BUG: unable to handle page fault for address: ffe21c00131f5000
[   62.099024][  T662] #PF: supervisor read access in kernel mode
[   62.099024][  T662] #PF: error_code(0x0000) - not-present page
[   62.099024][  T662] PGD 3fdf1067 P4D 3fdf0067 PUD 3fdef067 PMD 0 
[   62.099024][  T662] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[   62.099024][  T662] CPU: 3 UID: 0 PID: 662 Comm: ip Not tainted 6.15.0-rc2-virtme #1 PREEMPT(full) 
[   62.099024][  T662] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   62.099024][  T662] RIP: 0010:kasan_check_range+0x161/0x1c0
[   62.099024][  T662] Code: 2c 48 89 c2 48 85 c0 75 b0 48 89 da 4c 89 d8 4c 29 da e9 49 ff ff ff 48 85 d2 74 b3 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 a5 <80> 38 00 74 f2 e9 74 ff ff ff b8 01 00 00 00 e9 e6 36 1e ff 48 29
[   62.099024][  T662] RSP: 0018:ffa0000002b8ee00 EFLAGS: 00010282
[   62.099024][  T662] RAX: ffe21c00131f5000 RBX: ffe21c00131f5001 RCX: ffffffff8f04f9da
[   62.099024][  T662] RDX: ffe21c00131f5001 RSI: 0000000000000008 RDI: ff11000098fa8000
[   62.099024][  T662] RBP: ffe21c00131f5000 R08: 0000000000000000 R09: ffe21c00131f5000
[   62.099024][  T662] R10: ff11000098fa8007 R11: ffffffff9118a620 R12: ff11000098fa8000
[   62.099024][  T662] R13: ff1100003c8fb8f8 R14: ff1100003c8fb8f8 R15: dffffc0000000000
[   62.099024][  T662] FS:  00007f033a740440(0000) GS:ff11000099128000(0000) knlGS:0000000000000000
[   62.099024][  T662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.099024][  T662] CR2: ffe21c00131f5000 CR3: 0000000010fca003 CR4: 0000000000771ef0
[   62.099024][  T662] PKRU: 55555554
[   62.099024][  T662] Call Trace:
[   62.099024][  T662]  <TASK>
[   62.099024][  T662]  dev_fetch_sw_netstats+0xea/0x310
[   62.099024][  T662]  dev_get_stats+0x98/0xc30
[   62.099024][  T662]  rtnl_fill_stats+0x40/0xa70
[   62.099024][  T662]  rtnl_fill_ifinfo.constprop.0+0x120c/0x2d50
[   62.099024][  T662]  rtmsg_ifinfo_build_skb+0x134/0x230
[   62.099024][  T662]  rtmsg_ifinfo_event.part.0+0x2d/0x120
[   62.099024][  T662]  rtmsg_ifinfo+0x5b/0xa0
[   62.099024][  T662]  __dev_notify_flags+0x1b8/0x250
[   62.099024][  T662]  rtnl_configure_link+0x1d3/0x260
[   62.099024][  T662]  rtnl_newlink_create+0x358/0x8f0

