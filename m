Return-Path: <netdev+bounces-86305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79C89E5C8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C361F21189
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB762158DC1;
	Tue,  9 Apr 2024 22:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CD158D6F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703170; cv=none; b=Q7POA+uWS6/9m8GOc/7lBU3LYoI2C4qQu5Fav+JqI7iJRsY4CwsLNFXvKmuFBIlEI37JdJLOmqIvbwKDQb+D2mjfKzDPFk+S5MNm2YCDVtW8L197L4HfP4Vz04y8TIPYvBzrmIxvVjW5rvq2alO6L6KWQxuIz1RZ+WRI7LQYv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703170; c=relaxed/simple;
	bh=O+mGXfs3RDsQTErSVM8OTaHI3QnXgNIs9P8CYq9GNoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbCUjriqcDz9YXVSXaNIwPrLuGs87Qnn4JWLiUdHpeRywzH4v43Jgp9GvdD/hp2ilgxQLge7gvxjvpRsDn0LsG2Hy7gCOQonRX1CTX+trzd/VaX2d8BfPp1SBtWW+vlJzHzAmnbz2jwRS2Zww+AUkVBunoBDfWdrgXB8Umqpn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.163])
	by sina.com (172.16.235.24) with ESMTP
	id 6615C68000007624; Tue, 10 Apr 2024 06:51:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 83548545089525
X-SMAIL-UIID: AA18EA2385864CD180945C3BC5570DCF-20240410-065148-1
From: Hillf Danton <hdanton@sina.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+d1ae9c954f73570e7b58@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (2)
Date: Wed, 10 Apr 2024 06:51:39 +0800
Message-Id: <20240409225139.1556-1-hdanton@sina.com>
In-Reply-To: <87a5m27r08.ffs@tglx>
References: <000000000000b77a880615a0ed2a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Apr 2024 12:46:31 +0200 Thomas Gleixner <tglx@linutronix.de>
> On Mon, Apr 08 2024 at 19:46, syzbot wrote:
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 11239 at kernel/time/hrtimer.c:1053 hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
> > RIP: 0010:hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
> > Call Trace:
> >  <IRQ>
> >  hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
> >  mac80211_hwsim_beacon+0x192/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2335
> >  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
> >  __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
> >  hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1773
> >  __do_softirq+0x2bc/0x943 kernel/softirq.c:554
> >  invoke_softirq kernel/softirq.c:428 [inline]
> >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
> >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
> >  </IRQ>
> 
> The code which arms the timer is not serialized against the callback so
> the following can happen:
> 
>     CPU1                        CPU2
> 
>     __run_hrtimer(timer)
>                                 if (!hrtimer_queued(timer))
>                                         hrtimer_start(timer);
> 
>        hrtimer_forward(timer)
>          WARN_ON(hrtimer_queued(timer)
> 
> This really wants to use hrtimer_active() which takes the running
> callback into account.
> 
Then the race window is still open with hrtimer_active() and serialization
outside hrtimer is needed.

	CPU1				CPU2
	---				---
					if (!hrtimer_is_active(timer))
	if (!hrtimer_is_active(timer))
		hrtimer_start(timer);
	__run_hrtimer(timer)
						hrtimer_start(timer);
	hrtimer_forward(timer)
	  WARN_ON(hrtimer_queued(timer))

