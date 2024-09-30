Return-Path: <netdev+bounces-130355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E92698A28C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFED51F23858
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3562126C07;
	Mon, 30 Sep 2024 12:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2A1367
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699604; cv=none; b=mi7REmGWJzW7stq3/hvkRFOV1re6bXl7hzV0EgLyxXJmQ/KtNf4hGhmmFI8qRX2sACd9HC/MQDyPehUexUxX4zqnsRbbsa7eSOstXzqprpvyUqKGCioNPvJGuXQitFxhBq+CE0b/5LIF8Ket6guDF2dzitB5rdsiS7OPcqD7jX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699604; c=relaxed/simple;
	bh=ZmIMd9CxD3goe6qpo6vgQZOjgkRBAsdDm47UnFTSl3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjR2ToxMajkNjzs7BemjrO11Y5VR4FYzYJnCCZwjq9REwJke7qVVRAVMd9tBqEFTaPc9Dxf6euZPNUifh3IcZgt8HBcr8gvMUppp24tpp9OoXaviB7yXV7krgeTrTKTrmPoDMSU9LOhCtcLhVZFGWHTfDMkVtCLXxjhn1avT81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.162])
	by sina.com (10.185.250.24) with ESMTP
	id 66FA994300002973; Mon, 30 Sep 2024 20:27:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 56998710748373
X-SMAIL-UIID: 6385258744A54465BDD893B3A4B606C9-20240930-202751-1
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
Date: Mon, 30 Sep 2024 20:27:38 +0800
Message-Id: <20240930122738.1668-1-hdanton@sina.com>
In-Reply-To: <CANn89iJwe-Q2Ve3O1OP4WTVuD6eawFvV+3eDvuvs4Xk=+j5yBg@mail.gmail.com>
References: <000000000000657ecd0614456af8@google.com> <3483096f-4782-4ca1-bd8a-25a045646026@suse.de> <20240928122112.1412-1-hdanton@sina.com> <20240929114601.1584-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 10:32:32 +0200 Eric Dumazet <edumazet@google.com>
> On Sun, Sep 29, 2024 at 1:46 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Sat, 28 Sep 2024 20:21:12 +0800 Hillf Danton <hdanton@sina.com>
> > > On Mon, 25 Mar 2024 14:08:36 +0100 Eric Dumazet <edumazet@google.com>
> > > > On Mon, Mar 25, 2024 at 1:10 PM Denis Kirjanov <dkirjanov@suse.de> wrote:
> > > > >
> > > > > Hmm, report says that we have a net_device freed even that we have a dev_hold()
> > > > > before __ethtool_get_link_ksettings()
> > > >
> > > > dev_hold(dev) might be done too late, the device is already being dismantled.
> > > >
> > > > ib_device_get_netdev() should probably be done under RTNL locking,
> > > > otherwise the final part is racy :
> > > >
> > > > if (res && res->reg_state != NETREG_REGISTERED) {
> > > >      dev_put(res);
> > > >      return NULL;
> > > > }
> > >
> > > Given paranoia in netdev_run_todo(),
> > >
> > >               /* paranoia */
> > >               BUG_ON(netdev_refcnt_read(dev) != 1);
> > >
> > > the claim that dev_hold(dev) might be done too late could not explain
> > > the success of checking NETREG_REGISTERED, because of checking
> > > NETREG_UNREGISTERING after rcu barrier.
> > >
> > >       /* Wait for rcu callbacks to finish before next phase */
> > >       if (!list_empty(&list))
> > >               rcu_barrier();
> > >
> > >       list_for_each_entry_safe(dev, tmp, &list, todo_list) {
> > >               if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
> > >                       netdev_WARN(dev, "run_todo but not unregistering\n");
> > >                       list_del(&dev->todo_list);
> > >                       continue;
> > >               }
> > >
> > As simply bumping kref up could survive the syzbot reproducer [1], Eric's reclaim
> > is incorrect.
> 
> I have about 50 different syzbot reports all pointing to netdevsim and
> sysfs buggy interaction.
> 
> We will see if you can fix all of them :)
>
Looks like something I know
[1] https://lore.kernel.org/all/20220819220827.1639-1-hdanton@sina.com/
[2] https://lore.kernel.org/all/20231011211846.1345-1-hdanton@sina.com/
[3] https://lore.kernel.org/all/20240719112012.1562-1-hdanton@sina.com/

BTW I won the 2020 google OSPB Award (How many cents did you donate that year?).

And my current target is the Independent Observer at the 2025 Linux Plumbers
Conference if the LT king thinks observers are welcome.

Now turn to uaf. As the netdev_hold() in ib_device_set_netdev() matches the
netdev_put() in free_netdevs(), in combination with the dev_hold() in
ib_device_get_netdev(), the syz report discovers a valid case where kref fails
to prevent netdev from being freed under feet, even given the paranoia
in netdev_run_todo().

Hillf

