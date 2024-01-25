Return-Path: <netdev+bounces-65957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33B83CA72
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE7B1F27304
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB213341D;
	Thu, 25 Jan 2024 18:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [85.214.160.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF76EB67
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.160.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205724; cv=none; b=n3nyiUkYZUsNv6aX6BILt8TJe/NR770i59fQ5ipq1QmnDMXKOVQTPL8lN2ncO6sp+Mtk/2Kb8M5wCwTzrWp/wmNaLILHXOQXNyO1seQWgif+/SHKlVNVPV9fMiav+KdBJ63VXgOhlRH2AEztJp0WYKm3l7m9BkKoG4qtJquB1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205724; c=relaxed/simple;
	bh=mLgNHGKLKeEJs1JAvBWl8le9l5hajd0AJBSbXb5Bm0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mkh8HEPfK4WHlx0VKM4HzSfv1dicQvgvaYx+J7pe2U2Z51Vs7YPP8ucZhcqoSfFdJgGUVufiEGaMcuzpwJ5B4uiPZeUqUFgv+FQN/rAfq1ifScQNLR8qNyMbvBoJpfJc95Xv80jDcv7lJYjmNqSrPoAONswq7mRaz+HPks/9aRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=none smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=85.214.160.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+netdev@zugschlus.de>)
	id 1rT42m-000Ukl-0X;
	Thu, 25 Jan 2024 19:01:40 +0100
Date: Thu, 25 Jan 2024 19:01:40 +0100
From: Marc Haber <mh+netdev@zugschlus.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,

On Sun, Jan 21, 2024 at 10:52:56PM +0100, Andrew Lunn wrote:
> On Sun, Jan 21, 2024 at 09:17:32PM +0100, Marc Haber wrote:
> > Hi,
> > 
> > I am running a bunch of Banana Pis with Debian stable and unstable but
> > with a bleeding edge kernel. Since kernel 6.6, especially the test
> > system running Debian unstable is plagued by self-detected stalls on
> > CPU. The system seems to continue running normally locally but doesn't
> > answer on the network any more. Sometimes, after a few hours, things
> > heal themselves.
> > 
> > Here is an example log output:
> > [73929.363030] rcu: INFO: rcu_sched self-detected stall on CPU
> > [73929.368653] rcu:     1-....: (5249 ticks this GP) idle=d15c/1/0x40000002 softirq=471343/471343 fqs=2625
> > [73929.377796] rcu:     (t=5250 jiffies g=851349 q=113 ncpus=2)
> > [73929.383205] CPU: 1 PID: 14512 Comm: atop Tainted: G             L     6.6.0-zgbpi-armmp-lpae+ #1
> > [73929.383222] Hardware name: Allwinner sun7i (A20) Family
> > [73929.383233] PC is at stmmac_get_stats64+0x64/0x20c [stmmac]
> > [73929.383363] LR is at dev_get_stats+0x44/0x144
> > [73929.383389] pc : [<bf126db0>]    lr : [<c09525e8>]    psr: 200f0013
> > [73929.383401] sp : f0c59c78  ip : f0c59df8  fp : c2bb8000
> > [73929.383412] r10: 00800001  r9 : c3443dd8  r8 : 00000143
> > [73929.383423] r7 : 00000001  r6 : 00000000  r5 : c2bbb000  r4 : 00000001
> > [73929.383434] r3 : 0004c891  r2 : c2bbae48  r1 : f0c59d30  r0 : c2bb8000
> > [73929.383447] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [73929.383463] Control: 30c5387d  Table: 49b553c0  DAC: a7f66f60
> > [73929.383486]  stmmac_get_stats64 [stmmac] from dev_get_stats+0x44/0x144
> 
> Hi Marc
> 
> https://elixir.bootlin.com/linux/v6.7.1/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L6949

That is just for reference to the source? Or am I supposed to do
something with that link?

> My _guess_ would be, its stuck in one of the loops which look like:
> 
> 		do {
> 			start = u64_stats_fetch_begin(&txq_stats->syncp);
> 			tx_packets = txq_stats->tx_packets;
> 			tx_bytes   = txq_stats->tx_bytes;
> 		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
> 
> Next time you get a backtrace, could you do:
> 
> make drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst. You can then
> use whatever it is reporting for:

I have checked out 2eb85b750512cc5dc5a93d5ff00e1f83b99651db (which is
the first bad commit that the bisect eventually identified) and tried
running:

[56/4504]mh@fan:~/linux/git/linux ((2eb85b750512...)) $ make BUILDARCH="amd64" ARCH="arm" KBUILD_DEBARCH="armhf" CROSS_COMPILE="arm-linux-gnueabihf-" drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
  SYNC    include/config/auto.conf.cmd
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
  HOSTCC  scripts/kallsyms
  UPD     include/config/kernel.release
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/utsrelease.h
  SYSNR   arch/arm/include/generated/asm/unistd-nr.h
  SYSTBL  arch/arm/include/generated/calls-oabi.S
  SYSTBL  arch/arm/include/generated/calls-eabi.S
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CC      arch/arm/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
  CHKSHA1 include/linux/atomic/atomic-instrumented.h
  MKLST   drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
./scripts/makelst: 1: arithmetic expression: expecting EOF: "0x - 0x00000000"
[57/4505]mh@fan:~/linux/git/linux ((2eb85b750512...)) $

That is not what it was suppsoed to yield, right?

> 
> PC is at stmmac_get_stats64+0x64/0x20c [stmmac]
> 
> to find where it is in the listing.
> 
> Once we know if its the RX or the TX loop, we have a better idea where
> to look for an unbalanced u64_stats_update_begin() /
> u64_stats_update_end().
> 
> > I am running a bisect attempt since before christmas, but since it takes
> > up to a day for the issue to show themselves on a "bad" kernel, I'll let
> > "good" kernels run for four days until I declare them good. That takes a
> > lot of wall clock (or better, wall calendar) time.
> 
> You might be able to speed it up with:
> 
> while true ; do cat /proc/net/dev > /dev/null ; done
> 
> and iperf or similar to generate a lot of traffic.

My bisect eventually completed and identified
2eb85b750512cc5dc5a93d5ff00e1f83b99651db as the first bad commit.
Sadly, it doesnt contain any loops, no calls to u64_stats_update_begin()
or u64_stats_update_end() or other suspicious things to the casual
reader.

I have backed out that commit out of 6.7.1 and have booted that kernel.
Not long enough to be able to say something yet.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

