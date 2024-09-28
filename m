Return-Path: <netdev+bounces-130186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40600988F28
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13C0B21211
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA48187353;
	Sat, 28 Sep 2024 12:21:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5BC139
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727526095; cv=none; b=dqaPpnRJHb9VsXLGmz0pzRwldDAMJnmyfX6LXz7pcMPSnkirzx1UiujABW/Y8hHZm/lksJTMztsX0M7TCxpl/RhEK6kpjBq/PpTO25tIiQiv9p3wJmV5tidrJY6VkOETR7/LNTQrRlBQ12m1SrR3DBjtgC4ovyKLHCMBrTSD23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727526095; c=relaxed/simple;
	bh=3vNRQfb8vdVrkvVrzATImGjzZL6Z7WiQUS82zKMTPuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZUe59yyybp5M8xdaFLMCFyUoANWYEt8SqEmxtgdQhUDYVjXbRu8WyUZ72oMB8MH/OoN9c4J6cBE3TJa6lNdcsp7jpT1vRliB9jZzS6l7rrduNjAs4BKseJPeiFxqBVQLe6mR1RvSZGkUVCSwMP3kyXiESNLsHcFFVaz3ulgYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.191])
	by sina.com (10.185.250.23) with ESMTP
	id 66F7F4C100001548; Sat, 28 Sep 2024 20:21:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3802538913194
X-SMAIL-UIID: 00372D9D6125415B8635D32FD6DBA2C8-20240928-202124-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Denis Kirjanov <dkirjanov@suse.de>,
	syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Date: Sat, 28 Sep 2024 20:21:12 +0800
Message-Id: <20240928122112.1412-1-hdanton@sina.com>
In-Reply-To: <CANn89iKbygQsCLcb0STk7DVnseNQ6rkSxeJ1cFGDaufDo5eSgg@mail.gmail.com>
References: <000000000000657ecd0614456af8@google.com> <3483096f-4782-4ca1-bd8a-25a045646026@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 14:08:36 +0100 Eric Dumazet <edumazet@google.com>
> On Mon, Mar 25, 2024 at 1:10 PM Denis Kirjanov <dkirjanov@suse.de> wrote:
> > On 3/22/24 23:10, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    61387b8dcf1d Merge tag 'for-6.9/dm-vdo' of git://git.kerne..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11effbd1180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c6aea81bc9ff5e99
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/b972a52930fa/disk-61387b8d.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/caa2592898b6/vmlinux-61387b8d.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/4187257afcc5/bzImage-61387b8d.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x186/0x190 net/ethtool/ioctl.c:441
> > > Read of size 8 at addr ffff888021f46308 by task kworker/0:4/5169
> > >
> > > CPU: 0 PID: 5169 Comm: kworker/0:4 Not tainted 6.8.0-syzkaller-05562-g61387b8dcf1d #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> > > Workqueue: infiniband ib_cache_event_task
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> > >  print_address_description mm/kasan/report.c:377 [inline]
> > >  print_report+0xc3/0x620 mm/kasan/report.c:488
> > >  kasan_report+0xd9/0x110 mm/kasan/report.c:601
> > >  __ethtool_get_link_ksettings+0x186/0x190 net/ethtool/ioctl.c:441
> > >  __ethtool_get_link_ksettings+0xf5/0x190 net/ethtool/ioctl.c:445
> >
> > Hmm, report says that we have a net_device freed even that we have a dev_hold()
> > before __ethtool_get_link_ksettings()
> 
>  dev_hold(dev) might be done too late, the device is already being dismantled.
> 
> ib_device_get_netdev() should probably be done under RTNL locking,
> otherwise the final part is racy :
> 
> if (res && res->reg_state != NETREG_REGISTERED) {
>      dev_put(res);
>      return NULL;
> }

Given paranoia in netdev_run_todo(),

		/* paranoia */
		BUG_ON(netdev_refcnt_read(dev) != 1);

the claim that dev_hold(dev) might be done too late could not explain
the success of checking NETREG_REGISTERED, because of checking 
NETREG_UNREGISTERING after rcu barrier.

	/* Wait for rcu callbacks to finish before next phase */
	if (!list_empty(&list))
		rcu_barrier();

	list_for_each_entry_safe(dev, tmp, &list, todo_list) {
		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
			netdev_WARN(dev, "run_todo but not unregistering\n");
			list_del(&dev->todo_list);
			continue;
		}

