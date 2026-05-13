Return-Path: <netdev+bounces-287630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML9RKO6PBGpYLgIAu9opvQ
	(envelope-from <netdev+bounces-287630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A11A553576D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E6063030F7B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADED42189F;
	Wed, 13 May 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="OmlfdabT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="go/biU1R"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2B313E24;
	Wed, 13 May 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683300; cv=none; b=l2QqQANfzJAz4zc1ZTnuUWhjd7xLluaUTNCi80zQYTtqlLbdo+L5TK+T07/MCnadv0uGMDSRFQAS0ndPxMkRCBn14q7aUYjWDYqJryqefHKmfx9MJ9vD7V5aV0QaZqsuPP/63qzPDbXdX9VzhXCacJARwkqT4dZSyIHm9c4mojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683300; c=relaxed/simple;
	bh=qNgXJvbsLIcsIkCAQt+hbx2gxOBgKFnGhfiMpsUtuKM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=u2yLzxC4RgiAWhny9SnkpTsfoeVH9q27M9WDuNAN65ZOPWeZIjKNPmS0qD3ZLFyIZvsnxQOmk/lA9P5+/VPIv77dU4bTY78WzYbw7yIKP1guLtJBoBu536ohGSXu2ct+XaPMk1XT3yh+low7J7WFw52RN0ekCjljJnJ+v2bimAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=OmlfdabT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=go/biU1R; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BE161D00125;
	Wed, 13 May 2026 10:41:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 10:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1778683291; x=1778769691; bh=H+GvKvCtKswoDd20kyu6c
	69y++9vdRjqJHz+B29Lo4w=; b=OmlfdabToR0xhakvous5BbAwdSZboTr5OWaJH
	PYjnlFEYCnBSwMb+KvF2rTdiQ7B35di2FwNjEpSnjhiIU8HQGGZEhTEpBuJHVBhx
	T3WpaukXQDWMwJlhdtWGtG3p/9lv5DCDXNRIlbKba+ogZUNC/5W5WEWTeS2gDbIz
	ZamWAbgZ9dXgCCs6JRXFxo7ZK4RV9biapMdhtMl5GylsedS8o1sfahBlBS6ycZYJ
	nsvtkngCUmBO9iMLULQZB+zfrMlR2ynuCjesFBESSG3d15WqlK2thR6g0HYtbGDu
	nwPW6p17e3uCpN14YErb/DznW9YdTLLGCHM9k4pZWv4aRL91Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778683291; x=1778769691; bh=H+GvKvCtKswoDd20kyu6c69y++9vdRjqJHz
	+B29Lo4w=; b=go/biU1RvzIl35pEErD1fNwxHvkc7SV9Zgi8jzEJXdatIf+IGks
	UgqKhPH52Bwi14gA5EuTDUx/OzSIQ4kdVuaAcydMQGnv0klO7cyjSOwV9S2ISTNc
	fAlobjioXLsABjRuW4Yc2eHtnTgZZNxtHNJhpyFM8QrQ1CylpbYSQpFBLbyCO0mR
	3xFrUJaDJObgMYsG1z9RNH2SkfEswvT7IwiQr5SmHrehD1l6PT2EvtdGC/WlrLAb
	UdT/NdUdSxFq6G7yLZSedzBd9MM7lnF9VYw7wIycyztg0x2RbOJHTc/jvlDcxu0G
	6iHLqIPnpfhCIbLhhT69bEq+9h9/6GVOT+w==
X-ME-Sender: <xms:mo0Eamy4w7tDuBiUwq3DWY6TeUuaDT3w_gDQhV6CraeyYPkoAdCsCg>
    <xme:mo0EaitEOIdFOV6kWb4xg-QW0EDKHQw9AYPVWpepymtntsBhLrFlorRZY0Vh6HAG2
    kZdfE68-eVacg68ZRY7Vcid8ZZILlDbRb8-4MuOZtxOjUvexRbrcP0>
X-ME-Received: <xmr:mo0EapCk3gpm5ktked6rkXmMgv4yeUrwPErV1MNiwZp3dnX5sQ_3T5_Drln7VoAkbc6bW-rSYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepkeetfeduhfehhfegteeukedtjeeiheeijedugefhvddufffggfejffevtdfhgfel
    necuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhogh
    hlvggrphhishdrtghomhdpghhoohdrghhlnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehshiiikhgrlhhlvghrqdgsuhhgshesghhoohhglhgvghhr
    ohhuphhsrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehshiiisghothdoudgusgehke
    gusggstggtsghfleeftgeihegtkeefsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgr
    ihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:mo0EakFYMbXlN1Zm8-Ewo7a0m0_SeauJDrQdak0KfJFTHbxMTLVhHg>
    <xmx:mo0EapAy36gPZhiJiytpeyWnULr6l4-5eo0oMHV1Nr8l2ejNODjbeg>
    <xmx:mo0Eaqnoqhs5Bv2yEruVasqKAQBr_DFyMqdLAU8SjJfCCh25homM0Q>
    <xmx:mo0EavO9trpZ8nUcyo6aSV_K8H8IUffC19qb73nIltpz0S6Y9IMuvQ>
    <xmx:m40EaklswtP7gDC8Up9e3UeMcpahlC2EZ_7zZphZgLyHmtgE3TyTTKud>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 10:41:30 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 020AF1C04E2; Wed, 13 May 2026 07:41:28 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 002901C04DB;
	Wed, 13 May 2026 16:41:28 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: syzbot <syzbot+1db58dbbccbf93c65c83@syzkaller.appspotmail.com>
cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in rlb_choose_channel (2)
In-reply-to: <6a043a69.170a0220.1fd042.0004.GAE@google.com>
References: <6a043a69.170a0220.1fd042.0004.GAE@google.com>
Comments: In-reply-to syzbot <syzbot+1db58dbbccbf93c65c83@syzkaller.appspotmail.com>
   message dated "Wed, 13 May 2026 01:46:33 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <197246.1778683288.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 16:41:28 +0200
Message-ID: <197247.1778683288@vermin>
X-Rspamd-Queue-Id: A11A553576D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287630-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url,messagingengine.com:dkim,storage.googleapis.com:url,googlegroups.com:email];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,1db58dbbccbf93c65c83];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

syzbot <syzbot+1db58dbbccbf93c65c83@syzkaller.appspotmail.com> wrote:

>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    c21b90f77687 x86/CPU/AMD: Prevent improper isolation of s=
h..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=3D10ec7dba58000=
0
>kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4caf64b1ee83d=
ac0
>dashboard link: https://syzkaller.appspot.com/bug?extid=3D1db58dbbccbf93c=
65c83
>compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
>Unfortunately, I don't have any reproducer for this issue yet.
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/2f3edabe3b67/dis=
k-c21b90f7.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/539b63753e79/vmlinu=
x-c21b90f7.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/48e6e7cbc4ca/b=
zImage-c21b90f7.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
>Reported-by: syzbot+1db58dbbccbf93c65c83@syzkaller.appspotmail.com
>
>ip6_tunnel: ip6tnl1 xmit: Local address not yet configured!
>ip6_tunnel: ip6tnl1 xmit: Local address not yet configured!
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>WARNING: possible recursive locking detected
>syzkaller #0 Tainted: G             L     =

>--------------------------------------------
>kworker/u8:3/47 is trying to acquire lock:
>ffff88807a618e98 (&bond->mode_lock){+.-.}-{3:3}, at: spin_lock include/li=
nux/spinlock.h:342 [inline]
>ffff88807a618e98 (&bond->mode_lock){+.-.}-{3:3}, at: rlb_choose_channel+0=
x37/0x19a0 drivers/net/bonding/bond_alb.c:562
>
>but task is already holding lock:
>ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: spin_lock_bh include=
/linux/spinlock.h:348 [inline]
>ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: rlb_update_rx_client=
s drivers/net/bonding/bond_alb.c:466 [inline]
>ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: bond_alb_monitor+0xe=
8a/0x17e0 drivers/net/bonding/bond_alb.c:1618
>
>other info that might help us debug this:
> Possible unsafe locking scenario:
>
>       CPU0
>       ----
>  lock(&bond->mode_lock);
>  lock(&bond->mode_lock);
>
> *** DEADLOCK ***
>
> May be due to missing lock nesting notation
>
>7 locks held by kworker/u8:3/47:
> #0: ffff8880516b7140 ((wq_completion)bond5#2){+.+.}-{0:0}, at: process_o=
ne_work kernel/workqueue.c:3277 [inline]
> #0: ffff8880516b7140 ((wq_completion)bond5#2){+.+.}-{0:0}, at: process_s=
cheduled_works+0xa35/0x1860 kernel/workqueue.c:3385
> #1: ffffc90000b77c40 ((work_completion)(&(&bond->alb_work)->work)){+.+.}=
-{0:0}, at: process_one_work kernel/workqueue.c:3278 [inline]
> #1: ffffc90000b77c40 ((work_completion)(&(&bond->alb_work)->work)){+.+.}=
-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3385
> #2: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:300 [inline]
> #2: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:838 [inline]
> #2: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: bond_alb_monitor+0=
xf8/0x17e0 drivers/net/bonding/bond_alb.c:1546
> #3: ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: spin_lock_bh in=
clude/linux/spinlock.h:348 [inline]
> #3: ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: rlb_update_rx_c=
lients drivers/net/bonding/bond_alb.c:466 [inline]
> #3: ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: bond_alb_monito=
r+0xe8a/0x17e0 drivers/net/bonding/bond_alb.c:1618
> #4: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:300 [inline]
> #4: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:838 [inline]
> #4: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: arp_xmit+0x23/0x27=
0 net/ipv4/arp.c:663
> #5: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disabl=
e include/linux/bottom_half.h:20 [inline]
> #5: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_b=
h include/linux/rcupdate.h:891 [inline]
> #5: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmi=
t+0x2b6/0x3950 net/core/dev.c:4791
> #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:300 [inline]
> #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:838 [inline]
> #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: bond_start_xmit+0x=
b4/0x1900 drivers/net/bonding/bond_main.c:5591
>
>stack backtrace:
>CPU: 0 UID: 0 PID: 47 Comm: kworker/u8:3 Tainted: G             L      sy=
zkaller #0 PREEMPT(full) =

>Tainted: [L]=3DSOFTLOCKUP
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/18/2026
>Workqueue: bond5 bond_alb_monitor
>Call Trace:
> <TASK>
> dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
> check_deadlock kernel/locking/lockdep.c:3093 [inline]
> validate_chain kernel/locking/lockdep.c:3895 [inline]
> __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
> lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
> __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
> _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
> spin_lock include/linux/spinlock.h:342 [inline]
> rlb_choose_channel+0x37/0x19a0 drivers/net/bonding/bond_alb.c:562
> rlb_arp_xmit drivers/net/bonding/bond_alb.c:680 [inline]
> bond_xmit_alb_slave_get+0x1071/0x20a0 drivers/net/bonding/bond_alb.c:149=
3
> bond_alb_xmit+0x24/0x40 drivers/net/bonding/bond_alb.c:1528
> __bond_start_xmit drivers/net/bonding/bond_main.c:5569 [inline]
> bond_start_xmit+0x6a2/0x1900 drivers/net/bonding/bond_main.c:5593
> __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
> netdev_start_xmit include/linux/netdevice.h:5377 [inline]
> xmit_one net/core/dev.c:3888 [inline]
> dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3904
> __dev_queue_xmit+0x14d9/0x3950 net/core/dev.c:4870
> NF_HOOK+0x33a/0x3c0 include/linux/netfilter.h:-1
> arp_xmit+0x16c/0x270 net/ipv4/arp.c:665
> rlb_update_client+0x2a8/0x6b0 drivers/net/bonding/bond_alb.c:455
> rlb_update_rx_clients drivers/net/bonding/bond_alb.c:473 [inline]
> bond_alb_monitor+0xf6a/0x17e0 drivers/net/bonding/bond_alb.c:1618

	Just looking at the stack, I suspect that this is either a false
positive, or the NF_HOOK action (a netfilter rule) is reinjecting the
ARP packet in to the same bond that created it.

	If the packet is being reinjected to the same interface that
generated it in rlb_update_client, then I believe the above would be the
expected behavior.

	On the other hand, if the network configuration is nested bonds,
then the rlb_arp_xmit -> rlb_choose_channel call path above would be
operating on a different instance of the bond->mode_lock, and would not
actually deadlock.

	-J

> process_one_work kernel/workqueue.c:3302 [inline]
> process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
> worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
> kthread+0x388/0x470 kernel/kthread.c:436
> ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> </TASK>
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
>If the report is already addressed, let syzbot know by replying with:
>#syz fix: exact-commit-title
>
>If you want to overwrite report's subsystems, reply with:
>#syz set subsystems: new-subsystem
>(See the list of subsystem names on the web dashboard)
>
>If the report is a duplicate of another one, reply with:
>#syz dup: exact-subject-of-another-report
>
>If you want to undo deduplication, reply with:
>#syz undup

---
	-Jay Vosburgh, jv@jvosburgh.net

