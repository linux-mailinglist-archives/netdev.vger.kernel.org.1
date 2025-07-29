Return-Path: <netdev+bounces-210786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259EB14CBF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6CA57AAC0E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1E28C027;
	Tue, 29 Jul 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MY7wuA95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7esAgUo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42C287253;
	Tue, 29 Jul 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787406; cv=none; b=QD1bZ/26Np6KpVBAekrFe4sIkSkHq6vnOXLCfRZeOuL0rzgAOyoLDlmYo48toEkqJl14BklokiYgsTmN3JrZLGtqB8Y93dqc3eiYba9Nrc65tZpiV1QO9NzDWcFlLFotNTZsx6ARgURmjjwoCD0A/Ia43DWLkoKI7XQKSJ6Y9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787406; c=relaxed/simple;
	bh=VtdVGvJ9BpFvpMHfJpxSNwbeYEVqnCV3pZEcvFFOXs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwU5/xnrW6vJcEfoy5TzaAIScurpH/6RYvQKPxZ7DsWHgPa+ULbzVyEy+tqDEw7ZT9FE++lT/0gkRmwDXwkMf37TZT7UgT03hJhbs0tjZMBz1Yewa+Ex4ubgwf9Vr6MWfPPZdLkSG1PapvaSURwJKXxYCd69ZWI0kzim2LMiBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MY7wuA95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7esAgUo; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 031F77A0E27;
	Tue, 29 Jul 2025 07:10:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 29 Jul 2025 07:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753787400; x=
	1753873800; bh=uz0hvXnxo0mJnDw9VTTIJ+27i/mSuwNaILzlSKmygME=; b=M
	Y7wuA95NZAqcOsg41cWptFhlKUPDdmP7oQYKQc0HGpftAccxbEyvxh/g8SJGv8MJ
	JeEiQXMmR4PLjSktRyBNKJax8D2nY6yMCblgVTNzNH/1BdF7v8cv+DBAExFJhm5v
	H+oSjP6FyurmaBQJ8wHaHZluZWVRb1nQnFCkHFU0pYIHH5EGOEVGKw/bXgdlEM6e
	Iyf1+PZDyIim7MuLA7ssb+gFAGUz0e06SW2cSSR+C+WY4zwve8Piyo58fMV+JMq0
	zvNYeK/pgMBVxLP0BhzBjbasraWpc0E9YEHcMZu+bOvQar3Zm8jdzut+qyYZ1xVg
	W7cKzsbKV4ds5QQi/+UyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753787400; x=1753873800; bh=uz0hvXnxo0mJnDw9VTTIJ+27i/mSuwNaILz
	lSKmygME=; b=E7esAgUob6iWYtH7AVVD7+VvPN6BEshcXlT6eA1ncDy6PK/dznI
	4Y7EzklnULs/fI5eaG8XVVgstrSYrLvMVZ6vU+zuEJJkJADGoD4qqYvAweWgisOd
	1j6SIPbfMF+dOsUfGFoHP7ORVzm6Xh6QOB76LLUIxe0+TO2WDwvk2ERd24SjPfiR
	dw6JkJ4HdhxGiP8/vCWrBxRrYEeSMsgtBbrBORZJRoMJxbpOfFWxiBVcMIKq1X1G
	19fImqUrRqtD0Oxwd/WJu0akhYsKOJTvUr/jqyOooOEtIE1ECgDI7T7aQ0jAdxfg
	KEVw/zG32Y1Bq0lfsmot/6g1u/uKM1pzvgQ==
X-ME-Sender: <xms:B6yIaF2I5XW3bufjSKGEsFDV-8G_y-A9MJT8D_wRGU6kxU5gW9Qj5Q>
    <xme:B6yIaBk0hQ1oLpQOQ8D1NkjXbEWeAmgtr4t6zAGYMlk_O1LdpcPCJDAteUk-rzvU2
    ZUZLWhaLQsvik9NJpE>
X-ME-Received: <xmr:B6yIaE92kE7af3oLLAmaicbk-DkGnrfdyQLbt-z1jkjni8tyQXJPEUpiPjC1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggjseht
    tdertddttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquh
    gvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeevkefhgfdtvdevjeev
    vdfgffeffeettdefhfdtgfeuteegveeuffdtfffhudehvdenucffohhmrghinhepshihii
    hkrghllhgvrhdrrghpphhsphhothdrtghomhdpghhoohhglhgvrghpihhsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquh
    gvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvg
    htrdgtohhmpdhrtghpthhtohepshihiigsohhtodeiieegudgriedufhgvtdgvvdgvkeel
    rggvkegtheesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnug
    horhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohephhhorhhmsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B6yIaHJnOpqlNpRNpbq8sn62fTxdr-oDXQgxgr5uqigfVY3eeFN4NQ>
    <xmx:B6yIaBj2UK-j61KSmzNV1gKF7sck7P9DR054tA1Mda4gfWnIMKJBdw>
    <xmx:B6yIaL95oo0pr_D_4LSwqoWliFWwqmQ5bVE2EAvu21VnzDegvE0kSA>
    <xmx:B6yIaOMPEYvcSdbJzeG01J_1gVci0o8EI0DTlGBAi4O2ktnPLQDSGA>
    <xmx:CKyIaM7yBZZbMVp8YNgsWJxzA4wvtTvTLJQxk7WluVQcr7jnhI3wl66q>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 07:09:59 -0400 (EDT)
Date: Tue, 29 Jul 2025 13:09:57 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
Message-ID: <aIisBdRAM2vZ_VCW@krikkit>
References: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
 <aIiqAjZzjl7uNeSb@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIiqAjZzjl7uNeSb@gauss3.secunet.de>

Hi Steffen,

2025-07-29, 13:01:22 +0200, Steffen Klassert wrote:
> On Tue, Jul 29, 2025 at 12:08:31AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    038d61fd6422 Linux 6.16
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b88cf0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4066f1c76cfbc4fe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ca1782580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140194a2580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/6505c612be11/disk-038d61fd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e466ef29c1ca/vmlinux-038d61fd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b6d3d8fc5cbb/bzImage-038d61fd.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 36 at net/xfrm/xfrm_state.c:3284 xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3284
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> > Workqueue: netns cleanup_net
> > RIP: 0010:xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3284
> > Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 68 fa 0b f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 56 c8 ec f7 e8 51 e8 a9 f7 90 <0f> 0b 90 e9 fd fd ff ff e8 43 e8 a9 f7 90 0f 0b 90 e9 60 fe ff ff
> > RSP: 0018:ffffc90000ac7898 EFLAGS: 00010293
> > RAX: ffffffff8a163e8f RBX: ffff888034008000 RCX: ffff888143299e00
> > RDX: 0000000000000000 RSI: ffffffff8db8419f RDI: ffff888143299e00
> > RBP: ffffc90000ac79b0 R08: ffffffff8f6196e7 R09: 1ffffffff1ec32dc
> > R10: dffffc0000000000 R11: fffffbfff1ec32dd R12: ffffffff8f617760
> > R13: 1ffff92000158f40 R14: ffff8880340094c0 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff888125d23000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fbd9e960960 CR3: 00000000316d3000 CR4: 0000000000350ef0
> > Call Trace:
> >  <TASK>
> >  xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4348
> >  ops_exit_list net/core/net_namespace.c:200 [inline]
> >  ops_undo_list+0x49a/0x990 net/core/net_namespace.c:253
> >  cleanup_net+0x4c5/0x800 net/core/net_namespace.c:686
> >  process_one_work kernel/workqueue.c:3238 [inline]
> >  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
> >  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
> >  kthread+0x711/0x8a0 kernel/kthread.c:464
> >  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> 
> Hi Sabrina, your recent ipcomp patches seem to trigger this issue.
> At least reverting them make it go away. Can you please look
> into this?

I haven't looked at the other reports yet, but this one seems to be a
stupid mistake in my revert patch. With these changes, the syzbot
repro stops splatting here:


#syz test

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 5120a763da0d..0a0eeaed0591 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
+	xfrm_state_flush(net, 0, false);
 	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 97ff756191ba..5f1da305eea8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3278,7 +3278,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
+	xfrm_state_flush(net, 0, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));


-- 
Sabrina

