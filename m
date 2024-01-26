Return-Path: <netdev+bounces-66153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB683D86D
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C6281ECE
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB091125D9;
	Fri, 26 Jan 2024 10:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [85.214.160.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EBC13FE4
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.160.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266156; cv=none; b=axJfyxYC3z85fofwrLsPdUiU5rrI6I44VjqQ+qiMqslkPqnh353AAAaDeXKoUWE3BwgW24IYgreg745EsTwrj6g0cEzUpjINDxYrwHhn0/z9Gs9L86ZU2CobIg2jsPEJtNCOahzgQXAC4VWx5j3KcqF5cToU9NWtPFhGVQLczLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266156; c=relaxed/simple;
	bh=bkQpIPvys+JQRnDnCIXJmCYtSf+t3Ia+vj0ZsE9CRhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVLtBkKsynTa0hdB5h4MoTDXl9GlQ55xR17WDQXs1jl7Qu/fjmjJejiJudrGd8OlOi5LNZhiNivFNSrsaQVJMcJikESkeNTLQlhEbJb7LVL0XTCS0pHcZqkpmFBkM21Sleit3FakNHgG01T38nNxSYQNjMoEAYJY5HloXYgJz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=none smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=85.214.160.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+netdev@zugschlus.de>)
	id 1rTJlb-000taO-1d;
	Fri, 26 Jan 2024 11:48:59 +0100
Date: Fri, 26 Jan 2024 11:48:59 +0100
From: Marc Haber <mh+netdev@zugschlus.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <ZbOOG_yyCUgK_2b1@torres.zugschlus.de>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Jan 25, 2024 at 07:01:40PM +0100, Marc Haber wrote:
> On Sun, Jan 21, 2024 at 10:52:56PM +0100, Andrew Lunn wrote:
> > On Sun, Jan 21, 2024 at 09:17:32PM +0100, Marc Haber wrote:
> > > Hi,
> > > 
> > > I am running a bunch of Banana Pis with Debian stable and unstable but
> > > with a bleeding edge kernel. Since kernel 6.6, especially the test
> > > system running Debian unstable is plagued by self-detected stalls on
> > > CPU. The system seems to continue running normally locally but doesn't
> > > answer on the network any more. Sometimes, after a few hours, things
> > > heal themselves.
> > > 
> > > Here is an example log output:
> > > [73929.363030] rcu: INFO: rcu_sched self-detected stall on CPU
> > > [73929.368653] rcu:     1-....: (5249 ticks this GP) idle=d15c/1/0x40000002 softirq=471343/471343 fqs=2625
> > > [73929.377796] rcu:     (t=5250 jiffies g=851349 q=113 ncpus=2)
> > > [73929.383205] CPU: 1 PID: 14512 Comm: atop Tainted: G             L     6.6.0-zgbpi-armmp-lpae+ #1
> > > [73929.383222] Hardware name: Allwinner sun7i (A20) Family
> > > [73929.383233] PC is at stmmac_get_stats64+0x64/0x20c [stmmac]
> > > [73929.383363] LR is at dev_get_stats+0x44/0x144
> > > [73929.383389] pc : [<bf126db0>]    lr : [<c09525e8>]    psr: 200f0013
> > > [73929.383401] sp : f0c59c78  ip : f0c59df8  fp : c2bb8000
> > > [73929.383412] r10: 00800001  r9 : c3443dd8  r8 : 00000143
> > > [73929.383423] r7 : 00000001  r6 : 00000000  r5 : c2bbb000  r4 : 00000001
> > > [73929.383434] r3 : 0004c891  r2 : c2bbae48  r1 : f0c59d30  r0 : c2bb8000
> > > [73929.383447] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > > [73929.383463] Control: 30c5387d  Table: 49b553c0  DAC: a7f66f60
> > > [73929.383486]  stmmac_get_stats64 [stmmac] from dev_get_stats+0x44/0x144
> > 
> > Hi Marc
> > 
> > https://elixir.bootlin.com/linux/v6.7.1/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L6949
> 
> That is just for reference to the source? Or am I supposed to do
> something with that link?
> 
> > My _guess_ would be, its stuck in one of the loops which look like:
> > 
> > 		do {
> > 			start = u64_stats_fetch_begin(&txq_stats->syncp);
> > 			tx_packets = txq_stats->tx_packets;
> > 			tx_bytes   = txq_stats->tx_bytes;
> > 		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
> > 
> > Next time you get a backtrace, could you do:
> > 
> > make drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst. You can then
> > use whatever it is reporting for:

So, if I have in my current backtrace:
PC is at stmmac_get_stats64+0x48/0x20c [stmmac]
I look in the generated stmmac_main.lst for the function
stmmac_get_stats:
00005e9c <stmmac_get_stats64>:
{
    5e9c:       e92d47f0        push    {r4, r5, r6, r7, r8, r9, sl, lr}
    5ea0:       e52de004        push    {lr}            @ (str lr, [sp, #-4]!)
    5ea4:       ebfffffe        bl      0 <__gnu_mcount_nc>
                        5ea4: R_ARM_CALL        __gnu_mcount_nc
        u32 tx_cnt = priv->plat->tx_queues_to_use;
    5ea8:       e2805a03        add     r5, r0, #12288  @ 0x3000
    5eac:       e59535c0        ldr     r3, [r5, #1472] @ 0x5c0
    5eb0:       e5937078        ldr     r7, [r3, #120]  @ 0x78
        u32 rx_cnt = priv->plat->rx_queues_to_use;
    5eb4:       e5934074        ldr     r4, [r3, #116]  @ 0x74
        for (q = 0; q < tx_cnt; q++) {
    5eb8:       e3570000        cmp     r7, #0
    5ebc:       12802db9        addne   r2, r0, #11840  @ 0x2e40
    5ec0:       12822008        addne   r2, r2, #8
    5ec4:       13a06000        movne   r6, #0
    5ec8:       1a00000b        bne     5efc <stmmac_get_stats64+0x60>
    5ecc:       ea000026        b       5f6c <stmmac_get_stats64+0xd0>
        local_irq_restore(flags);
}

the address in the first line is the base address, so the line in
question is 0x5e9c+0x48=0x5ee4, which is already outside the function?!

> My bisect eventually completed and identified
> 2eb85b750512cc5dc5a93d5ff00e1f83b99651db as the first bad commit.
> Sadly, it doesnt contain any loops, no calls to u64_stats_update_begin()
> or u64_stats_update_end() or other suspicious things to the casual
> reader.
> 
> I have backed out that commit out of 6.7.1 and have booted that kernel.
> Not long enough to be able to say something yet.

That didn't fix the hangs, PC is at
stmmac_get_stats64+0x34/0x20c
stmmac_get_stats64+0x38/0x20c
stmmac_get_stats64+0x3c/0x20c
stmmac_get_stats64+0x40/0x20c
stmmac_get_stats64+0x44/0x20c
stmmac_get_stats64+0x48/0x20c
stmmac_get_stats64+0x4c/0x20c
stmmac_get_stats64+0x50/0x20c
stmmac_get_stats64+0x54/0x20c
stmmac_get_stats64+0x58/0x20c
stmmac_get_stats64+0x5c/0x20c
stmmac_get_stats64+0x60/0x20c
stmmac_get_stats64+0x64/0x20c
(sorted, uniq, about 66 instances in about 18 hours)

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

