Return-Path: <netdev+bounces-286131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pBW6J6L//mkn1AAAu9opvQ
	(envelope-from <netdev+bounces-286131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9C4FEFFE
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AF2A30069B3
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56738237E;
	Sat,  9 May 2026 09:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6212F8EA2;
	Sat,  9 May 2026 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319258; cv=none; b=BNjewBm8wlouru6M3Y8GaYKV9K4XK4kBUI4rX3698hB9iL0GvzDiHGWTIo/+ZlNXIyO7Y446XneVUVTY3cOawPuWSVk0IgCEsDxzhqgej3ck++KGvUAX0WPz/71FgRW1y7pJ5ys7eClty1wKQvdS9LzkS95ii4AoYZmBH7vI2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319258; c=relaxed/simple;
	bh=Y1GYzWmY8vkMfw+j7QABBLA/mQnyTGHXjs+9F4rfKTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tR/HpRiBrxqtgujs13LUVRJZQ6JTE4hvqZS3d6cinH65bsXp6Atam2fDW+6qKN8ncRiv822Fpwqjqlwyu2ZbAABA2Hm/176gB5XsjpuLz6Is55VaHTsNtL9pEd3Q3sobhRfcHQEP/0B2Q4vkcrE/8Uy7hK5nt3TjGULdO/1w4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3W+KH__5peqZ7EA--.25316S2;
	Sat, 09 May 2026 17:33:59 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: xujiakai24@mails.ucas.ac.cn
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] netdevsim: Fix task hung by releasing bus lock before device ops
Date: Sat,  9 May 2026 09:33:59 +0000
Message-Id: <20260509093359.3451699-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
References: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3W+KH__5peqZ7EA--.25316S2
X-Coremail-Antispam: 1UD129KBjvAXoWDXr13Jw1DWF43WrykKr45Wrg_yoW7Xw43Ao
	W5XryUJr48G3WUJr1fJw15XryrGr1DXFsxAr4UCr1UWr17Jr4UJr1jkw1xAr4Utw1UtFy3
	Aw18tas5G3y5tr4kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYh7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUe7KsUUUUU
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Rspamd-Queue-Id: 34A9C4FEFFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286131-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[ucas.ac.cn];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mails.ucas.ac.cn:mid]
X-Rspamd-Action: no action

I found this issue through fuzzing.

Here is the full crash report produced by the fuzzer:

INFO: task syz-executor:15504 blocked for more than 424 seconds.
      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15504 tgid:15504 ppid:1      task_flags:0x400140 flags:0x00000002
Call Trace:
[<ffffffff867069b0>] context_switch kernel/sched/core.c:5387 [inline]
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c kernel/sched/core.c:7188
[<ffffffff8670a182>] __schedule_loop kernel/sched/core.c:7267 [inline]
[<ffffffff8670a182>] schedule+0xc4/0x35e kernel/sched/core.c:7282
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28 kernel/sched/core.c:7339
[<ffffffff86712a14>] __mutex_lock_common kernel/locking/mutex.c:726 [inline]
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e kernel/locking/mutex.c:820
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:873
[<ffffffff839164cc>] new_device_store+0x10a/0x6c2 drivers/net/netdevsim/bus.c:184
[<ffffffff82d41b12>] bus_attr_store+0x6a/0x9e drivers/base/bus.c:172
[<ffffffff80fb8126>] sysfs_kf_write+0xc2/0x11c fs/sysfs/file.c:142
[<ffffffff80fb17fc>] kernfs_fop_write_iter+0x32a/0x4c8 fs/kernfs/file.c:352
[<ffffffff80ceb5c8>] new_sync_write fs/read_write.c:595 [inline]
[<ffffffff80ceb5c8>] vfs_write+0x776/0xc9e fs/read_write.c:688
[<ffffffff80cebeea>] ksys_write+0x126/0x234 fs/read_write.c:740
[<ffffffff80cec066>] __do_sys_write fs/read_write.c:751 [inline]
[<ffffffff80cec066>] __se_sys_write fs/read_write.c:748 [inline]
[<ffffffff80cec066>] __riscv_sys_write+0x6e/0xa0 fs/read_write.c:748
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
INFO: task syz-executor:15582 blocked for more than 433 seconds.
      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15582 tgid:15582 ppid:15557  task_flags:0x400140 flags:0x00000000
Call Trace:
[<ffffffff867069b0>] context_switch kernel/sched/core.c:5387 [inline]
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c kernel/sched/core.c:7188
[<ffffffff8670a182>] __schedule_loop kernel/sched/core.c:7267 [inline]
[<ffffffff8670a182>] schedule+0xc4/0x35e kernel/sched/core.c:7282
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28 kernel/sched/core.c:7339
[<ffffffff86712a14>] __mutex_lock_common kernel/locking/mutex.c:726 [inline]
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e kernel/locking/mutex.c:820
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:873
[<ffffffff83915a5e>] del_device_store+0xf0/0x48c drivers/net/netdevsim/bus.c:234
[<ffffffff82d41b12>] bus_attr_store+0x6a/0x9e drivers/base/bus.c:172
[<ffffffff80fb8126>] sysfs_kf_write+0xc2/0x11c fs/sysfs/file.c:142
[<ffffffff80fb17fc>] kernfs_fop_write_iter+0x32a/0x4c8 fs/kernfs/file.c:352
[<ffffffff80ceb5c8>] new_sync_write fs/read_write.c:595 [inline]
[<ffffffff80ceb5c8>] vfs_write+0x776/0xc9e fs/read_write.c:688
[<ffffffff80cebeea>] ksys_write+0x126/0x234 fs/read_write.c:740
[<ffffffff80cec066>] __do_sys_write fs/read_write.c:751 [inline]
[<ffffffff80cec066>] __se_sys_write fs/read_write.c:748 [inline]
[<ffffffff80cec066>] __riscv_sys_write+0x6e/0xa0 fs/read_write.c:748
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
INFO: task syz-executor:15597 blocked for more than 422 seconds.
      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15597 tgid:15597 ppid:15595  task_flags:0x400140 flags:0x00000000
Call Trace:
[<ffffffff867069b0>] context_switch kernel/sched/core.c:5387 [inline]
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c kernel/sched/core.c:7188
[<ffffffff8670a182>] __schedule_loop kernel/sched/core.c:7267 [inline]
[<ffffffff8670a182>] schedule+0xc4/0x35e kernel/sched/core.c:7282
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28 kernel/sched/core.c:7339
[<ffffffff86712a14>] __mutex_lock_common kernel/locking/mutex.c:726 [inline]
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e kernel/locking/mutex.c:820
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:873
[<ffffffff8549fd26>] rtnl_lock net/core/rtnetlink.c:80 [inline]
[<ffffffff8549fd26>] rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
[<ffffffff8549fd26>] rtnl_newlink+0x64c/0x1dc6 net/core/rtnetlink.c:4108
[<ffffffff854a34e0>] rtnetlink_rcv_msg+0x9e2/0xdbe net/core/rtnetlink.c:6995
[<ffffffff858203ca>] netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2550
[<ffffffff8548fe9a>] rtnetlink_rcv+0x26/0x30 net/core/rtnetlink.c:7022
[<ffffffff8581e6a8>] netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
[<ffffffff8581e6a8>] netlink_unicast+0x52a/0x888 net/netlink/af_netlink.c:1344
[<ffffffff8581f386>] netlink_sendmsg+0x980/0xd8a net/netlink/af_netlink.c:1894
[<ffffffff85365c18>] sock_sendmsg_nosec net/socket.c:787 [inline]
[<ffffffff85365c18>] __sock_sendmsg+0xcc/0x162 net/socket.c:802
[<ffffffff8536f6a0>] __sys_sendto+0x27a/0x34e net/socket.c:2265
[<ffffffff8536f834>] __do_sys_sendto net/socket.c:2272 [inline]
[<ffffffff8536f834>] __se_sys_sendto net/socket.c:2268 [inline]
[<ffffffff8536f834>] __riscv_sys_sendto+0xc0/0x158 net/socket.c:2268
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232

Showing all locks held in the system:
1 lock held by khungtaskd/43:
 #0: ffffffff889e8f60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2a/0x1a0 kernel/locking/lockdep.c:6771
3 locks held by kworker/u16:7/950:
 #0: ff60000080134140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x886/0x21ba kernel/workqueue.c:3277
 #1: ff20000003057b50 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x21ba kernel/workqueue.c:3277
 #2: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a net/core/rtnetlink.c:80
2 locks held by syslogd/3051:
2 locks held by getty/3104:
 #0: ff600000926110a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3a/0x46 drivers/tty/tty_ldsem.c:340
 #1: ff200000000bb2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x3e4/0x12d6 drivers/tty/n_tty.c:2211
6 locks held by kworker/u16:3/3136:
2 locks held by syz-executor/3139:
3 locks held by kworker/u16:10/4765:
 #0: ff6000008d5a6140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x886/0x21ba kernel/workqueue.c:3277
 #1: ff20000002377b50 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x21ba kernel/workqueue.c:3277
 #2: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a net/core/rtnetlink.c:80
7 locks held by syz-executor/15475:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: sb_start_write include/linux/fs/super.h:125 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2724 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e fs/read_write.c:684
 #1: ff6000008d69bc80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8 fs/kernfs/file.c:343
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8 fs/kernfs/file.c:344
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x10a/0x6c2 drivers/net/netdevsim/bus.c:184
 #4: ff600000b0c0b128 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1040 [inline]
 #4: ff600000b0c0b128 (&dev->mutex){....}-{4:4}, at: __device_attach+0x8e/0x490 drivers/base/dd.c:1076
 #5: ff6000008e375258 (&devlink->lock_key#22){+.+.}-{4:4}, at: devl_lock+0x22/0x2c net/devlink/core.c:292
 #6: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a net/core/rtnetlink.c:80
4 locks held by syz-executor/15504:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: sb_start_write include/linux/fs/super.h:125 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2724 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e fs/read_write.c:684
 #1: ff600000aa105480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8 fs/kernfs/file.c:343
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8 fs/kernfs/file.c:344
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x10a/0x6c2 drivers/net/netdevsim/bus.c:184
4 locks held by syz-executor/15575:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: sb_start_write include/linux/fs/super.h:125 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2724 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e fs/read_write.c:684
 #1: ff6000009624e880 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8 fs/kernfs/file.c:343
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8 fs/kernfs/file.c:344
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xf0/0x48c drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/15582:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: sb_start_write include/linux/fs/super.h:125 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2724 [inline]
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e fs/read_write.c:684
 #1: ff600000b1aba480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8 fs/kernfs/file.c:343
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8 fs/kernfs/file.c:344
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xf0/0x48c drivers/net/netdevsim/bus.c:234
2 locks held by syz-executor/15597:
 #0: ffffffff896a4b48 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xea/0x31c net/core/rtnetlink.c:573
 #1: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x64c/0x1dc6 net/core/rtnetlink.c:4108
3 locks held by kworker/2:3/17058:
4 locks held by syz-executor/17064:
1 lock held by syz-executor/17066:
 #0: ffffffff88e31ad8 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x144/0x3d6 security/tomoyo/file.c:766
2 locks held by syz-executor/17067:
1 lock held by syz-executor/17070:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 43 Comm: khungtaskd Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8007c91c>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:149
[<ffffffff800032ce>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:155
[<ffffffff80060fbe>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff80060fbe>] dump_stack_lvl+0x12a/0x1a2 lib/dump_stack.c:120
[<ffffffff80061052>] dump_stack+0x1c/0x24 lib/dump_stack.c:129
[<ffffffff866ba6bc>] nmi_cpu_backtrace+0x3b0/0x3b2 lib/nmi_backtrace.c:113
[<ffffffff866ba974>] nmi_trigger_cpumask_backtrace+0x2b6/0x45a lib/nmi_backtrace.c:62
[<ffffffff8008aae0>] arch_trigger_cpumask_backtrace+0x2c/0x38 arch/riscv/kernel/smp.c:350
[<ffffffff866cee94>] trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
[<ffffffff866cee94>] __sys_info lib/sys_info.c:157 [inline]
[<ffffffff866cee94>] sys_info+0x20c/0x24e lib/sys_info.c:165
[<ffffffff8053fe46>] check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
[<ffffffff8053fe46>] watchdog+0x920/0x137c kernel/hung_task.c:561
[<ffffffff801f7d58>] kthread+0x336/0x47e kernel/kthread.c:436
[<ffffffff8006a302>] ret_from_fork_kernel+0x94/0xfce arch/riscv/kernel/process.c:230
[<ffffffff86726926>] ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:363
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 2
CPU: 2 UID: 0 PID: 3139 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : mod_node_page_state+0x28/0x6a mm/vmstat.c:731
 ra : mod_node_page_state+0x58/0x6a mm/vmstat.c:730
epc : ffffffff809bb55e ra : ffffffff809bb58e sp : ff200000063a7600
 gp : ffffffff8a395420 tp : ff6000008b193580 t0 : ffebffff15c2c000
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ff200000063a7630
 s1 : 0000000000000002 a0 : 0000000000000002 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : ffffffff8193bb24 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : ffffffff80c62208
 s2 : ff600000fffe99c0 s3 : 0000000000000024 s4 : ffffffffffffffff
 s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffebffff11077215
 s8 : 0000000000000160 s9 : ff1c000002b85800 s10: 1fec000011077215
 s11: ff600000883b9080 t3 : 4b952e4d00000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff809bb55e>] arch_local_irq_restore arch/riscv/include/asm/irqflags.h:51 [inline]
[<ffffffff809bb55e>] mod_node_page_state+0x28/0x6a mm/vmstat.c:730
[<ffffffff80c623ae>] lruvec_stat_mod_folio+0x200/0x25a mm/memcontrol.c:979
[<ffffffff80addf62>] mod_lruvec_page_state include/linux/vmstat.h:528 [inline]
[<ffffffff80addf62>] vfree+0x272/0xca8 mm/vmalloc.c:3471
[<ffffffff8053dea8>] kcov_put kernel/kcov.c:442 [inline]
[<ffffffff8053dea8>] kcov_put kernel/kcov.c:438 [inline]
[<ffffffff8053dea8>] kcov_close+0x42/0x70 kernel/kcov.c:543
[<ffffffff80cf2748>] __fput+0x382/0xac6 fs/file_table.c:510
[<ffffffff80cf2f3a>] ____fput+0x1c/0x26 fs/file_table.c:538
[<ffffffff801f13b2>] task_work_run+0x16a/0x25e kernel/task_work.c:233
[<ffffffff80169d02>] exit_task_work include/linux/task_work.h:40 [inline]
[<ffffffff80169d02>] do_exit+0x8e4/0x2a6c kernel/exit.c:975
[<ffffffff8016c3ea>] do_group_exit+0xd4/0x26c kernel/exit.c:1117
[<ffffffff801a6fb0>] get_signal+0x2070/0x22aa kernel/signal.c:3037
[<ffffffff80073742>] arch_do_signal_or_restart+0xcc4/0x1d72 arch/riscv/kernel/signal.c:534
[<ffffffff803eca40>] __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
[<ffffffff803eca40>] exit_to_user_mode_loop+0x9c/0x7a4 kernel/entry/common.c:98
[<ffffffff866faa3c>] __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
[<ffffffff866faa3c>] syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
[<ffffffff866faa3c>] syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
[<ffffffff866faa3c>] do_trap_ecall_u+0x490/0x5de arch/riscv/kernel/traps.c:345
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 17070 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : kasan_quarantine_put+0x8a/0x1fa mm/kasan/quarantine.c:236
 ra : kasan_quarantine_put+0x198/0x1fa mm/kasan/quarantine.c:234
epc : ffffffff80becf0a ra : ffffffff80bed018 sp : ff200000062279b0
 gp : ffffffff8a395420 tp : ff60000093cab580 t0 : ff20000006227990
 t1 : 0000000000000008 t2 : 5f726573755f776f s0 : ff200000062279f0
 s1 : 00000000000f1a70 a0 : 0000000000000003 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : ffffffff8193bb24 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000039dd5796
 s2 : ff60000096170400 s3 : 0000000000000002 s4 : ff60000080002c80
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000001000
 s8 : 0000000000000000 s9 : ff60000096170400 s10: ff600000b124c000
 s11: ff600000b124e000 t3 : 1243f8b800000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff80becf0a>] arch_local_irq_restore arch/riscv/include/asm/irqflags.h:51 [inline]
[<ffffffff80becf0a>] kasan_quarantine_put+0x8a/0x1fa mm/kasan/quarantine.c:234
[<ffffffff80be8d24>] __kasan_slab_free+0x6a/0x7e mm/kasan/common.c:295
[<ffffffff80b39284>] kasan_slab_free include/linux/kasan.h:235 [inline]
[<ffffffff80b39284>] slab_free_hook mm/slub.c:2689 [inline]
[<ffffffff80b39284>] slab_free mm/slub.c:6246 [inline]
[<ffffffff80b39284>] kfree+0x30a/0x6e2 mm/slub.c:6561
[<ffffffff8149f2ee>] tomoyo_find_next_domain+0x7d0/0x1e48 security/tomoyo/domain.c:893
[<ffffffff814b1224>] tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
[<ffffffff814b1224>] tomoyo_bprm_check_security+0x128/0x1c4 security/tomoyo/tomoyo.c:92
[<ffffffff81461316>] security_bprm_check+0x278/0x28e security/security.c:820
[<ffffffff80d085b8>] search_binary_handler fs/exec.c:1654 [inline]
[<ffffffff80d085b8>] exec_binprm fs/exec.c:1696 [inline]
[<ffffffff80d085b8>] bprm_execve fs/exec.c:1748 [inline]
[<ffffffff80d085b8>] bprm_execve+0x80c/0x1878 fs/exec.c:1724
[<ffffffff80d0acda>] do_execveat_common.isra.0+0x45e/0x59e fs/exec.c:1846
[<ffffffff80d0ef52>] __do_sys_execve fs/exec.c:1930 [inline]
[<ffffffff80d0ef52>] __se_sys_execve fs/exec.c:1924 [inline]
[<ffffffff80d0ef52>] __riscv_sys_execve+0x8c/0xc4 fs/exec.c:1924
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 17064 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : arch_local_irq_restore arch/riscv/include/asm/irqflags.h:52 [inline]
epc : lock_acquire kernel/locking/lockdep.c:5871 [inline]
epc : lock_acquire+0x2a8/0x50e kernel/locking/lockdep.c:5825
 ra : lockdep_recursion_finish kernel/locking/lockdep.c:470 [inline]
 ra : lock_acquire kernel/locking/lockdep.c:5870 [inline]
 ra : lock_acquire+0x276/0x50e kernel/locking/lockdep.c:5825
epc : ffffffff802fe96a ra : ffffffff802fe938 sp : ff200000000e7030
 gp : ffffffff8a395420 tp : ff6000008e4eb580 t0 : 0000000000000000
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ff200000000e7110
 s1 : ffffffff9176ce80 a0 : 0000000000000000 a1 : ffffffff88169438
 a2 : 0000000000000016 a3 : ffffffff8a4a70a0 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000050 a7 : ffffffff80aa2f74
 s2 : ff600000ffa29788 s3 : 0000000000000001 s4 : 0000000000000000
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffff80aa2f74
 s8 : ffffffff86a68788 s9 : 0000000000000002 s10: ffffffff9176ce80
 s11: ff600000ffa29788 t3 : fbb730c400000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff802fe96a>] arch_local_irq_restore arch/riscv/include/asm/irqflags.h:51 [inline]
[<ffffffff802fe96a>] lock_acquire kernel/locking/lockdep.c:5871 [inline]
[<ffffffff802fe96a>] lock_acquire+0x2a8/0x50e kernel/locking/lockdep.c:5825
[<ffffffff86721cd2>] __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
[<ffffffff86721cd2>] _raw_spin_lock+0x32/0x48 kernel/locking/spinlock.c:158
[<ffffffff80aa2f74>] spin_lock include/linux/spinlock.h:342 [inline]
[<ffffffff80aa2f74>] pte_offset_map_lock+0x1d6/0x3d2 mm/pgtable-generic.c:404
[<ffffffff80a5258e>] get_locked_pte+0x70/0xc2 mm/memory.c:2284
[<ffffffff80a526fc>] insert_page+0x11c/0x232 mm/memory.c:2387
[<ffffffff80a52a96>] vm_insert_page+0x284/0x3ae mm/memory.c:2575
[<ffffffff8053dc36>] kcov_mmap+0xb4/0x11c kernel/kcov.c:514
[<ffffffff80af0dfe>] vfs_mmap include/linux/fs.h:2071 [inline]
[<ffffffff80af0dfe>] mmap_file mm/internal.h:168 [inline]
[<ffffffff80af0dfe>] __mmap_new_file_vma mm/vma.c:2496 [inline]
[<ffffffff80af0dfe>] __mmap_new_vma mm/vma.c:2562 [inline]
[<ffffffff80af0dfe>] __mmap_region+0x10b4/0x2800 mm/vma.c:2771
[<ffffffff80af6c24>] mmap_region+0x3e8/0x500 mm/vma.c:2856
[<ffffffff80a7c7d0>] do_mmap+0x944/0x1048 mm/mmap.c:560
[<ffffffff809b7d5a>] vm_mmap_pgoff+0x27c/0x41e mm/util.c:581
[<ffffffff80a7959c>] ksys_mmap_pgoff+0x2ce/0x6fa mm/mmap.c:606
[<ffffffff800749f4>] riscv_sys_mmap arch/riscv/kernel/sys_riscv.c:29 [inline]
[<ffffffff800749f4>] __do_sys_mmap arch/riscv/kernel/sys_riscv.c:38 [inline]
[<ffffffff800749f4>] __se_sys_mmap arch/riscv/kernel/sys_riscv.c:34 [inline]
[<ffffffff800749f4>] __riscv_sys_mmap+0x11c/0x18c arch/riscv/kernel/sys_riscv.c:34
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15504 tgid:15504 ppid:1      task_flags:0x400140 flags:0x00000002
Call Trace:
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c
[<ffffffff8670a182>] schedule+0xc4/0x35e
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c
[<ffffffff839164cc>] new_device_store+0x10a/0x6c2
[<ffffffff82d41b12>] bus_attr_store+0x6a/0x9e
[<ffffffff80fb8126>] sysfs_kf_write+0xc2/0x11c
[<ffffffff80fb17fc>] kernfs_fop_write_iter+0x32a/0x4c8
[<ffffffff80ceb5c8>] vfs_write+0x776/0xc9e
[<ffffffff80cebeea>] ksys_write+0x126/0x234
[<ffffffff80cec066>] __riscv_sys_write+0x6e/0xa0
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
INFO: task syz-executor:15582 blocked for more than 433 seconds.
      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15582 tgid:15582 ppid:15557  task_flags:0x400140 flags:0x00000000
Call Trace:
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c
[<ffffffff8670a182>] schedule+0xc4/0x35e
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c
[<ffffffff83915a5e>] del_device_store+0xf0/0x48c
[<ffffffff82d41b12>] bus_attr_store+0x6a/0x9e
[<ffffffff80fb8126>] sysfs_kf_write+0xc2/0x11c
[<ffffffff80fb17fc>] kernfs_fop_write_iter+0x32a/0x4c8
[<ffffffff80ceb5c8>] vfs_write+0x776/0xc9e
[<ffffffff80cebeea>] ksys_write+0x126/0x234
[<ffffffff80cec066>] __riscv_sys_write+0x6e/0xa0
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
INFO: task syz-executor:15597 blocked for more than 422 seconds.
      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15597 tgid:15597 ppid:15595  task_flags:0x400140 flags:0x00000000
Call Trace:
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c
[<ffffffff8670a182>] schedule+0xc4/0x35e
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c
[<ffffffff8549fd26>] rtnl_newlink+0x64c/0x1dc6
[<ffffffff854a34e0>] rtnetlink_rcv_msg+0x9e2/0xdbe
[<ffffffff858203ca>] netlink_rcv_skb+0x206/0x3be
[<ffffffff8548fe9a>] rtnetlink_rcv+0x26/0x30
[<ffffffff8581e6a8>] netlink_unicast+0x52a/0x888
[<ffffffff8581f386>] netlink_sendmsg+0x980/0xd8a
[<ffffffff85365c18>] __sock_sendmsg+0xcc/0x162
[<ffffffff8536f6a0>] __sys_sendto+0x27a/0x34e
[<ffffffff8536f834>] __riscv_sys_sendto+0xc0/0x158
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a

Showing all locks held in the system:
1 lock held by khungtaskd/43:
 #0: ffffffff889e8f60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2a/0x1a0
3 locks held by kworker/u16:7/950:
 #0: ff60000080134140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x886/0x21ba
 #1: ff20000003057b50 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x21ba
 #2: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a
2 locks held by syslogd/3051:
2 locks held by getty/3104:
 #0: ff600000926110a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3a/0x46
 #1: ff200000000bb2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x3e4/0x12d6
6 locks held by kworker/u16:3/3136:
2 locks held by syz-executor/3139:
3 locks held by kworker/u16:10/4765:
 #0: ff6000008d5a6140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x886/0x21ba
 #1: ff20000002377b50 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x21ba
 #2: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a
7 locks held by syz-executor/15475:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff6000008d69bc80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x10a/0x6c2
 #4: ff600000b0c0b128 (&dev->mutex){....}-{4:4}, at: __device_attach+0x8e/0x490
 #5: ff6000008e375258 (&devlink->lock_key#22){+.+.}-{4:4}, at: devl_lock+0x22/0x2c
 #6: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a
4 locks held by syz-executor/15504:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff600000aa105480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x10a/0x6c2
4 locks held by syz-executor/15575:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff6000009624e880 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xf0/0x48c
4 locks held by syz-executor/15582:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff600000b1aba480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xf0/0x48c
2 locks held by syz-executor/15597:
 #0: ffffffff896a4b48 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xea/0x31c
 #1: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x64c/0x1dc6
3 locks held by kworker/2:3/17058:
4 locks held by syz-executor/17064:
1 lock held by syz-executor/17066:
 #0: ffffffff88e31ad8 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x144/0x3d6
2 locks held by syz-executor/17067:
1 lock held by syz-executor/17070:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 43 Comm: khungtaskd Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8007c91c>] dump_backtrace+0x2e/0x3c
[<ffffffff800032ce>] show_stack+0x30/0x3c
[<ffffffff80060fbe>] dump_stack_lvl+0x12a/0x1a2
[<ffffffff80061052>] dump_stack+0x1c/0x24
[<ffffffff866ba6bc>] nmi_cpu_backtrace+0x3b0/0x3b2
[<ffffffff866ba974>] nmi_trigger_cpumask_backtrace+0x2b6/0x45a
[<ffffffff8008aae0>] arch_trigger_cpumask_backtrace+0x2c/0x38
[<ffffffff866cee94>] sys_info+0x20c/0x24e
[<ffffffff8053fe46>] watchdog+0x920/0x137c
[<ffffffff801f7d58>] kthread+0x336/0x47e
[<ffffffff8006a302>] ret_from_fork_kernel+0x94/0xfce
[<ffffffff86726926>] ret_from_fork_kernel_asm+0x16/0x18
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 2
CPU: 2 UID: 0 PID: 3139 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : mod_node_page_state+0x28/0x6a
 ra : mod_node_page_state+0x58/0x6a
epc : ffffffff809bb55e ra : ffffffff809bb58e sp : ff200000063a7600
 gp : ffffffff8a395420 tp : ff6000008b193580 t0 : ffebffff15c2c000
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ff200000063a7630
 s1 : 0000000000000002 a0 : 0000000000000002 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : ffffffff8193bb24 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : ffffffff80c62208
 s2 : ff600000fffe99c0 s3 : 0000000000000024 s4 : ffffffffffffffff
 s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffebffff11077215
 s8 : 0000000000000160 s9 : ff1c000002b85800 s10: 1fec000011077215
 s11: ff600000883b9080 t3 : 4b952e4d00000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff809bb55e>] mod_node_page_state+0x28/0x6a
[<ffffffff80c623ae>] lruvec_stat_mod_folio+0x200/0x25a
[<ffffffff80addf62>] vfree+0x272/0xca8
[<ffffffff8053dea8>] kcov_close+0x42/0x70
[<ffffffff80cf2748>] __fput+0x382/0xac6
[<ffffffff80cf2f3a>] ____fput+0x1c/0x26
[<ffffffff801f13b2>] task_work_run+0x16a/0x25e
[<ffffffff80169d02>] do_exit+0x8e4/0x2a6c
[<ffffffff8016c3ea>] do_group_exit+0xd4/0x26c
[<ffffffff801a6fb0>] get_signal+0x2070/0x22aa
[<ffffffff80073742>] arch_do_signal_or_restart+0xcc4/0x1d72
[<ffffffff803eca40>] exit_to_user_mode_loop+0x9c/0x7a4
[<ffffffff866faa3c>] do_trap_ecall_u+0x490/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 17070 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : kasan_quarantine_put+0x8a/0x1fa
 ra : kasan_quarantine_put+0x198/0x1fa
epc : ffffffff80becf0a ra : ffffffff80bed018 sp : ff200000062279b0
 gp : ffffffff8a395420 tp : ff60000093cab580 t0 : ff20000006227990
 t1 : 0000000000000008 t2 : 5f726573755f776f s0 : ff200000062279f0
 s1 : 00000000000f1a70 a0 : 0000000000000003 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : ffffffff8193bb24 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000039dd5796
 s2 : ff60000096170400 s3 : 0000000000000002 s4 : ff60000080002c80
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000001000
 s8 : 0000000000000000 s9 : ff60000096170400 s10: ff600000b124c000
 s11: ff600000b124e000 t3 : 1243f8b800000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff80becf0a>] kasan_quarantine_put+0x8a/0x1fa
[<ffffffff80be8d24>] __kasan_slab_free+0x6a/0x7e
[<ffffffff80b39284>] kfree+0x30a/0x6e2
[<ffffffff8149f2ee>] tomoyo_find_next_domain+0x7d0/0x1e48
[<ffffffff814b1224>] tomoyo_bprm_check_security+0x128/0x1c4
[<ffffffff81461316>] security_bprm_check+0x278/0x28e
[<ffffffff80d085b8>] bprm_execve+0x80c/0x1878
[<ffffffff80d0acda>] do_execveat_common.isra.0+0x45e/0x59e
[<ffffffff80d0ef52>] __riscv_sys_execve+0x8c/0xc4
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 17064 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : lock_acquire+0x2a8/0x50e
 ra : lock_acquire+0x276/0x50e
epc : ffffffff802fe96a ra : ffffffff802fe938 sp : ff200000000e7030
 gp : ffffffff8a395420 tp : ff6000008e4eb580 t0 : 0000000000000000
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ff200000000e7110
 s1 : ffffffff9176ce80 a0 : 0000000000000000 a1 : ffffffff88169438
 a2 : 0000000000000016 a3 : ffffffff8a4a70a0 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000050 a7 : ffffffff80aa2f74
 s2 : ff600000ffa29788 s3 : 0000000000000001 s4 : 0000000000000000
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffff80aa2f74
 s8 : ffffffff86a68788 s9 : 0000000000000002 s10: ffffffff9176ce80
 s11: ff600000ffa29788 t3 : fbb730c400000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff802fe96a>] lock_acquire+0x2a8/0x50e
[<ffffffff86721cd2>] _raw_spin_lock+0x32/0x48
[<ffffffff80aa2f74>] pte_offset_map_lock+0x1d6/0x3d2
[<ffffffff80a5258e>] get_locked_pte+0x70/0xc2
[<ffffffff80a526fc>] insert_page+0x11c/0x232
[<ffffffff80a52a96>] vm_insert_page+0x284/0x3ae
[<ffffffff8053dc36>] kcov_mmap+0xb4/0x11c
[<ffffffff80af0dfe>] __mmap_region+0x10b4/0x2800
[<ffffffff80af6c24>] mmap_region+0x3e8/0x500
[<ffffffff80a7c7d0>] do_mmap+0x944/0x1048
[<ffffffff809b7d5a>] vm_mmap_pgoff+0x27c/0x41e
[<ffffffff80a7959c>] ksys_mmap_pgoff+0x2ce/0x6fa
[<ffffffff800749f4>] __riscv_sys_mmap+0x11c/0x18c
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15582 tgid:15582 ppid:15557  task_flags:0x400140 flags:0x00000000
Call Trace:
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c
[<ffffffff8670a182>] schedule+0xc4/0x35e
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c
[<ffffffff83915a5e>] del_device_store+0xf0/0x48c
[<ffffffff82d41b12>] bus_attr_store+0x6a/0x9e
[<ffffffff80fb8126>] sysfs_kf_write+0xc2/0x11c
[<ffffffff80fb17fc>] kernfs_fop_write_iter+0x32a/0x4c8
[<ffffffff80ceb5c8>] vfs_write+0x776/0xc9e
[<ffffffff80cebeea>] ksys_write+0x126/0x234
[<ffffffff80cec066>] __riscv_sys_write+0x6e/0xa0
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
INFO: task syz-executor:15597 blocked for more than 422 seconds.
      Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:15597 tgid:15597 ppid:15595  task_flags:0x400140 flags:0x00000000
Call Trace:
[<ffffffff867069b0>] __schedule+0x1a2e/0x513c
[<ffffffff8670a182>] schedule+0xc4/0x35e
[<ffffffff8670a518>] schedule_preempt_disabled+0x16/0x28
[<ffffffff86712a14>] __mutex_lock+0xbee/0x1b0e
[<ffffffff86713948>] mutex_lock_nested+0x14/0x1c
[<ffffffff8549fd26>] rtnl_newlink+0x64c/0x1dc6
[<ffffffff854a34e0>] rtnetlink_rcv_msg+0x9e2/0xdbe
[<ffffffff858203ca>] netlink_rcv_skb+0x206/0x3be
[<ffffffff8548fe9a>] rtnetlink_rcv+0x26/0x30
[<ffffffff8581e6a8>] netlink_unicast+0x52a/0x888
[<ffffffff8581f386>] netlink_sendmsg+0x980/0xd8a
[<ffffffff85365c18>] __sock_sendmsg+0xcc/0x162
[<ffffffff8536f6a0>] __sys_sendto+0x27a/0x34e
[<ffffffff8536f834>] __riscv_sys_sendto+0xc0/0x158
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a

Showing all locks held in the system:
1 lock held by khungtaskd/43:
 #0: ffffffff889e8f60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2a/0x1a0
3 locks held by kworker/u16:7/950:
 #0: ff60000080134140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x886/0x21ba
 #1: ff20000003057b50 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x21ba
 #2: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a
2 locks held by syslogd/3051:
2 locks held by getty/3104:
 #0: ff600000926110a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3a/0x46
 #1: ff200000000bb2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x3e4/0x12d6
6 locks held by kworker/u16:3/3136:
2 locks held by syz-executor/3139:
3 locks held by kworker/u16:10/4765:
 #0: ff6000008d5a6140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x886/0x21ba
 #1: ff20000002377b50 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x21ba
 #2: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a
7 locks held by syz-executor/15475:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff6000008d69bc80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x10a/0x6c2
 #4: ff600000b0c0b128 (&dev->mutex){....}-{4:4}, at: __device_attach+0x8e/0x490
 #5: ff6000008e375258 (&devlink->lock_key#22){+.+.}-{4:4}, at: devl_lock+0x22/0x2c
 #6: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x22/0x2a
4 locks held by syz-executor/15504:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff600000aa105480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946a58 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x10a/0x6c2
4 locks held by syz-executor/15575:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff6000009624e880 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xf0/0x48c
4 locks held by syz-executor/15582:
 #0: ff6000009335a410 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x9d0/0xc9e
 #1: ff600000b1aba480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x252/0x4c8
 #2: ff6000008b946968 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x4c8
 #3: ffffffff8979c780 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xf0/0x48c
2 locks held by syz-executor/15597:
 #0: ffffffff896a4b48 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xea/0x31c
 #1: ffffffff89f64220 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x64c/0x1dc6
3 locks held by kworker/2:3/17058:
4 locks held by syz-executor/17064:
1 lock held by syz-executor/17066:
 #0: ffffffff88e31ad8 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x144/0x3d6
2 locks held by syz-executor/17067:
1 lock held by syz-executor/17070:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 43 Comm: khungtaskd Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8007c91c>] dump_backtrace+0x2e/0x3c
[<ffffffff800032ce>] show_stack+0x30/0x3c
[<ffffffff80060fbe>] dump_stack_lvl+0x12a/0x1a2
[<ffffffff80061052>] dump_stack+0x1c/0x24
[<ffffffff866ba6bc>] nmi_cpu_backtrace+0x3b0/0x3b2
[<ffffffff866ba974>] nmi_trigger_cpumask_backtrace+0x2b6/0x45a
[<ffffffff8008aae0>] arch_trigger_cpumask_backtrace+0x2c/0x38
[<ffffffff866cee94>] sys_info+0x20c/0x24e
[<ffffffff8053fe46>] watchdog+0x920/0x137c
[<ffffffff801f7d58>] kthread+0x336/0x47e
[<ffffffff8006a302>] ret_from_fork_kernel+0x94/0xfce
[<ffffffff86726926>] ret_from_fork_kernel_asm+0x16/0x18
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 2
CPU: 2 UID: 0 PID: 3139 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : mod_node_page_state+0x28/0x6a
 ra : mod_node_page_state+0x58/0x6a
epc : ffffffff809bb55e ra : ffffffff809bb58e sp : ff200000063a7600
 gp : ffffffff8a395420 tp : ff6000008b193580 t0 : ffebffff15c2c000
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ff200000063a7630
 s1 : 0000000000000002 a0 : 0000000000000002 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : ffffffff8193bb24 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : ffffffff80c62208
 s2 : ff600000fffe99c0 s3 : 0000000000000024 s4 : ffffffffffffffff
 s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffebffff11077215
 s8 : 0000000000000160 s9 : ff1c000002b85800 s10: 1fec000011077215
 s11: ff600000883b9080 t3 : 4b952e4d00000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff809bb55e>] mod_node_page_state+0x28/0x6a
[<ffffffff80c623ae>] lruvec_stat_mod_folio+0x200/0x25a
[<ffffffff80addf62>] vfree+0x272/0xca8
[<ffffffff8053dea8>] kcov_close+0x42/0x70
[<ffffffff80cf2748>] __fput+0x382/0xac6
[<ffffffff80cf2f3a>] ____fput+0x1c/0x26
[<ffffffff801f13b2>] task_work_run+0x16a/0x25e
[<ffffffff80169d02>] do_exit+0x8e4/0x2a6c
[<ffffffff8016c3ea>] do_group_exit+0xd4/0x26c
[<ffffffff801a6fb0>] get_signal+0x2070/0x22aa
[<ffffffff80073742>] arch_do_signal_or_restart+0xcc4/0x1d72
[<ffffffff803eca40>] exit_to_user_mode_loop+0x9c/0x7a4
[<ffffffff866faa3c>] do_trap_ecall_u+0x490/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 17070 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : kasan_quarantine_put+0x8a/0x1fa
 ra : kasan_quarantine_put+0x198/0x1fa
epc : ffffffff80becf0a ra : ffffffff80bed018 sp : ff200000062279b0
 gp : ffffffff8a395420 tp : ff60000093cab580 t0 : ff20000006227990
 t1 : 0000000000000008 t2 : 5f726573755f776f s0 : ff200000062279f0
 s1 : 00000000000f1a70 a0 : 0000000000000003 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : ffffffff8193bb24 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000039dd5796
 s2 : ff60000096170400 s3 : 0000000000000002 s4 : ff60000080002c80
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000001000
 s8 : 0000000000000000 s9 : ff60000096170400 s10: ff600000b124c000
 s11: ff600000b124e000 t3 : 1243f8b800000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff80becf0a>] kasan_quarantine_put+0x8a/0x1fa
[<ffffffff80be8d24>] __kasan_slab_free+0x6a/0x7e
[<ffffffff80b39284>] kfree+0x30a/0x6e2
[<ffffffff8149f2ee>] tomoyo_find_next_domain+0x7d0/0x1e48
[<ffffffff814b1224>] tomoyo_bprm_check_security+0x128/0x1c4
[<ffffffff81461316>] security_bprm_check+0x278/0x28e
[<ffffffff80d085b8>] bprm_execve+0x80c/0x1878
[<ffffffff80d0acda>] do_execveat_common.isra.0+0x45e/0x59e
[<ffffffff80d0ef52>] __riscv_sys_execve+0x8c/0xc4
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 17064 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : lock_acquire+0x2a8/0x50e
 ra : lock_acquire+0x276/0x50e
epc : ffffffff802fe96a ra : ffffffff802fe938 sp : ff200000000e7030
 gp : ffffffff8a395420 tp : ff6000008e4eb580 t0 : 0000000000000000
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ff200000000e7110
 s1 : ffffffff9176ce80 a0 : 0000000000000000 a1 : ffffffff88169438
 a2 : 0000000000000016 a3 : ffffffff8a4a70a0 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000050 a7 : ffffffff80aa2f74
 s2 : ff600000ffa29788 s3 : 0000000000000001 s4 : 0000000000000000
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffff80aa2f74
 s8 : ffffffff86a68788 s9 : 0000000000000002 s10: ffffffff9176ce80
 s11: ff600000ffa29788 t3 : fbb730c400000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000009
[<ffffffff802fe96a>] lock_acquire+0x2a8/0x50e
[<ffffffff86721cd2>] _raw_spin_lock+0x32/0x48
[<ffffffff80aa2f74>] pte_offset_map_lock+0x1d6/0x3d2
[<ffffffff80a5258e>] get_locked_pte+0x70/0xc2
[<ffffffff80a526fc>] insert_page+0x11c/0x232
[<ffffffff80a52a96>] vm_insert_page+0x284/0x3ae
[<ffffffff8053dc36>] kcov_mmap+0xb4/0x11c
[<ffffffff80af0dfe>] __mmap_region+0x10b4/0x2800
[<ffffffff80af6c24>] mmap_region+0x3e8/0x500
[<ffffffff80a7c7d0>] do_mmap+0x944/0x1048
[<ffffffff809b7d5a>] vm_mmap_pgoff+0x27c/0x41e
[<ffffffff80a7959c>] ksys_mmap_pgoff+0x2ce/0x6fa
[<ffffffff800749f4>] __riscv_sys_mmap+0x11c/0x18c
[<ffffffff80078fb2>] syscall_handler+0x94/0x118
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de
[<ffffffff867267f6>] handle_exception+0x15e/0x16a

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


