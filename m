Return-Path: <netdev+bounces-64514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EB8357D3
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD791F218BF
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F4383B8;
	Sun, 21 Jan 2024 20:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [85.214.160.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D1DF51
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.160.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705870766; cv=none; b=K49ZZqNGAHWJQ8ZqaPeJ78Mb4PE/btgWaniR7rP2YULQpW7yFzyYxomajG3O7fDHTVZf+yPyaiQM5l1BD6WDz2L7M11AOXb+JiqPLl8O4xv5+P2ZEFuZMBZcRA+cukxvnLUyGbI7KXz7T0zf3XC3GcFYw6JeOm/opj6LCk/RnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705870766; c=relaxed/simple;
	bh=3eiUalLXvwM/OGUNv09l6AsNv04YUsekNNQtJym5bWA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V5eVmluyDHHxwxhaiRDC+yAzDaf2wqykcdRyTx2QKL0jxs0zusOUGBKLfMYsV4x8m4+gEnrEFaZyVf5fk/1UUrT9bifMRA3BOfS4e5rK+7KWxh6J96P0rofGeXuLwKeb7Lr6vMj91KuBj4fPr2LTjOVqxnCKk+Xx3XmVrEzvYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=none smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=85.214.160.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+netdev@zugschlus.de>)
	id 1rReG4-008Dvg-2d;
	Sun, 21 Jan 2024 21:17:32 +0100
Date: Sun, 21 Jan 2024 21:17:32 +0100
From: Marc Haber <mh+netdev@zugschlus.de>
To: alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <Za173PhviYg-1qIn@torres.zugschlus.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,

I am running a bunch of Banana Pis with Debian stable and unstable but
with a bleeding edge kernel. Since kernel 6.6, especially the test
system running Debian unstable is plagued by self-detected stalls on
CPU. The system seems to continue running normally locally but doesn't
answer on the network any more. Sometimes, after a few hours, things
heal themselves.

Here is an example log output:
[73929.363030] rcu: INFO: rcu_sched self-detected stall on CPU
[73929.368653] rcu:     1-....: (5249 ticks this GP) idle=d15c/1/0x40000002 softirq=471343/471343 fqs=2625
[73929.377796] rcu:     (t=5250 jiffies g=851349 q=113 ncpus=2)
[73929.383205] CPU: 1 PID: 14512 Comm: atop Tainted: G             L     6.6.0-zgbpi-armmp-lpae+ #1
[73929.383222] Hardware name: Allwinner sun7i (A20) Family
[73929.383233] PC is at stmmac_get_stats64+0x64/0x20c [stmmac]
[73929.383363] LR is at dev_get_stats+0x44/0x144
[73929.383389] pc : [<bf126db0>]    lr : [<c09525e8>]    psr: 200f0013
[73929.383401] sp : f0c59c78  ip : f0c59df8  fp : c2bb8000
[73929.383412] r10: 00800001  r9 : c3443dd8  r8 : 00000143
[73929.383423] r7 : 00000001  r6 : 00000000  r5 : c2bbb000  r4 : 00000001
[73929.383434] r3 : 0004c891  r2 : c2bbae48  r1 : f0c59d30  r0 : c2bb8000
[73929.383447] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[73929.383463] Control: 30c5387d  Table: 49b553c0  DAC: a7f66f60
[73929.383486]  stmmac_get_stats64 [stmmac] from dev_get_stats+0x44/0x144
[73929.383564]  dev_get_stats from dev_seq_printf_stats+0x40/0x194
[73929.383593]  dev_seq_printf_stats from dev_seq_show+0x18/0x4c
[73929.383617]  dev_seq_show from seq_read_iter+0x3c4/0x57c
[73929.383647]  seq_read_iter from seq_read+0x9c/0xdc
[73929.383674]  seq_read from proc_reg_read+0xb0/0xe4
[73929.383706]  proc_reg_read from vfs_read+0xa8/0x2f4
[73929.383735]  vfs_read from ksys_read+0x78/0x10c
[73929.383757]  ksys_read from ret_fast_syscall+0x0/0x4c
[73929.383781] Exception stack(0xf0c59fa8 to 0xf0c59ff0)
[73929.383800] 9fa0:                   024b7190 00000498 00000003 024cac10 00000400 00000001
[73929.383817] 9fc0: 024b7190 00000498 b6ef6d20 00000003 0000000a be9eb15c 00000000 00000000
[73929.383831] 9fe0: 00000003 be9eb030 b6e90eeb b6e0ab06

The issue is still present in Linux 6.7. I tried transplanting the stmmac
sub directory from Linux 6.5 to Linux 6.6, but the changes were too big,
the result doesn't even build.

I am running a bisect attempt since before christmas, but since it takes
up to a day for the issue to show themselves on a "bad" kernel, I'll let
"good" kernels run for four days until I declare them good. That takes a
lot of wall clock (or better, wall calendar) time.

If you might have some ideas why this is happening on my Banana Pis,
I'm open to suggestions. Tentative patches against 6.6.$HIGH or
6.7.$CURRENT would be appreciated as well.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

