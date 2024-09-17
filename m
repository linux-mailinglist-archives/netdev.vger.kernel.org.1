Return-Path: <netdev+bounces-128701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AEF97B185
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42089285513
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B45166F3A;
	Tue, 17 Sep 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fMlqe6Uo"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488518E2A
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584012; cv=none; b=K8ttx0K0+e+4a3qG4s33aEa4F55ypk/QlETTevloMXnoi0Z+EkibiRwaBeUpMjKitxcvZpGAje5yD8UOJWXILvirFxQMdOu/ASZPjZCg71te+SUAoYujHSR7fGho6ZqFpAdKyGIWyq/Oup98z5CSB9SggoyKbFXVNSQHNSNz2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584012; c=relaxed/simple;
	bh=RP2pZiROi2Xkjh0+oIpXPf8pK71JrhY3aO0KpWXee9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2cJ0vrTO8YuVqq15oYaNBylu+xkxcp78vmIgCWdDplf1GOdU6YugsduoBQKtFOorBejMeHkoAiyEMgAYPxJ+zGwHQfDkRjirwtNvw3szdhXhL/utaBLUnfmGtk9eazIhmIJd4RcD0NzC7AXqgSqjahOBFK1w5ZdsZx0vxCpBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fMlqe6Uo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a55b2705-aace-439f-bbb5-9ee483b06af5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726584006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eegGBaAygOaLYVZ73ZF+hWGW4jgAbW8mG7UbsMPO9lk=;
	b=fMlqe6UovSHDQgQlE/peSO0nS0gcO78vwnJyWtqMM6kHKAp0yAmnh55GhWNN1ys2ZrYVle
	tpKJgONyriZ0F+oY1VsLgTG9mRCPdDAEqrq3GepCpSqKbCKz+4mf+/6UOkOT2ToQ9wl3KR
	QerS/mywNCBU2yn787sVFp6rXL+Otv0=
Date: Tue, 17 Sep 2024 10:40:00 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "Katakam, Harini" <harini.katakam@amd.com>
Cc: Andy Chiu <andy.chiu@sifive.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>, Ariane Keller
 <ariane.keller@tik.ee.ethz.ch>, Daniel Borkmann <daniel@iogearbox.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
 <michal.simek@amd.com>
References: <20240909230908.1319982-1-sean.anderson@linux.dev>
 <MN0PR12MB5953E38D1EEBF3F83172E2EEB79B2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <b26be717-a67e-4ee1-9393-3de6147b9c2e@linux.dev>
 <MN0PR12MB59535B22AA0E0CA115E94202B7642@MN0PR12MB5953.namprd12.prod.outlook.com>
 <MN0PR12MB5953CAF05CE80ECBE9494709B7612@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB5953CAF05CE80ECBE9494709B7612@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/17/24 07:24, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Pandey, Radhey Shyam
>> Sent: Thursday, September 12, 2024 8:05 PM
>> To: Sean Anderson <sean.anderson@linux.dev>; David S . Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
>> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev@vger.kernel.org;
>> Gupta, Suraj <Suraj.Gupta2@amd.com>; Katakam, Harini
>> <harini.katakam@amd.com>
>> Cc: Andy Chiu <andy.chiu@sifive.com>; linux-kernel@vger.kernel.org; Simon
>> Horman <horms@kernel.org>; Ariane Keller <ariane.keller@tik.ee.ethz.ch>; Daniel
>> Borkmann <daniel@iogearbox.net>; linux-arm-kernel@lists.infradead.org; Simek,
>> Michal <michal.simek@amd.com>
>> Subject: RE: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet count
>> overflow
>> 
>> > -----Original Message-----
>> > From: Sean Anderson <sean.anderson@linux.dev>
>> > Sent: Thursday, September 12, 2024 8:01 PM
>> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S . Miller
>> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski
>> > <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> netdev@vger.kernel.org;
>> > Gupta, Suraj <Suraj.Gupta2@amd.com>; Katakam, Harini
>> > <harini.katakam@amd.com>
>> > Cc: Andy Chiu <andy.chiu@sifive.com>; linux-kernel@vger.kernel.org; Simon
>> > Horman <horms@kernel.org>; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
>> Daniel
>> > Borkmann <daniel@iogearbox.net>; linux-arm-kernel@lists.infradead.org; Simek,
>> > Michal <michal.simek@amd.com>
>> > Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet count
>> > overflow
>> >
>> > On 9/11/24 03:01, Pandey, Radhey Shyam wrote:
>> > >> -----Original Message-----
>> > >> From: Sean Anderson <sean.anderson@linux.dev>
>> > >> Sent: Tuesday, September 10, 2024 4:39 AM
>> > >> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
>> > >> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> > >> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> > >> netdev@vger.kernel.org
>> > >> Cc: Andy Chiu <andy.chiu@sifive.com>; linux-kernel@vger.kernel.org; Simon
>> > >> Horman <horms@kernel.org>; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
>> > >> Daniel Borkmann <daniel@iogearbox.net>; linux-arm-
>> > >> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; Sean
>> > >> Anderson <sean.anderson@linux.dev>
>> > >> Subject: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet count
>> > >> overflow
>> > >>
>> > >> If coalece_count is greater than 255 it will not fit in the register and
>> > >> will overflow. This can be reproduced by running
>> > >>
>> > >>     # ethtool -C ethX rx-frames 256
>> > >>
>> > >> which will result in a timeout of 0us instead. Fix this by clamping the
>> > >> counts to the maximum value.
>> > > After this fix - what is o/p we get on rx-frames read? I think silent clamping is not
>> a
>> > great
>> > > idea and user won't know about it.  One alternative is to add check in
>> set_coalesc
>> > > count for valid range? (Similar to axienet_ethtools_set_ringparam so that user is
>> > notified
>> > > for incorrect range)
>> >
>> > The value reported will be unclamped. In [1] I improve the driver to
>> > return the actual (clamped) value.
>> >
>> > Remember that without this commit, we have silent wraparound instead. I
>> > think clamping is much friendlier, since you at least get something
>> > close to the rx-frames value, instead of zero!
>> >
>> > This commit is just a fix for the overflow issue. To ensure it is
>> > appropriate for backporting I have omitted any other
>> > changes/improvements.
>> 
>> But the point is the fix also can be to avoid setting coalesce count
>> to invalid (or not supported range) value - like done in existing
>> axienet_ethtools_set_ringparam() implementation.
> 
> Sean: I think above comment got missed out, so I am bringing it again
> to discuss and close on it.

I am investigating whether this will work within the broader context of
the changes I want to make. I will reply when I have had a chance to work
on it.

--Sean

>> 
>> And we don't clamp on every dma_start().
>> 
>> >
>> > --Sean
>> >
>> > [1] https://lore.kernel.org/netdev/20240909235208.1331065-6-
>> > sean.anderson@linux.dev/
>> >
>> > >>
>> > >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> > >> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet
>> > >> driver")
>> > >> ---
>> > >>
>> > >> Changes in v2:
>> > >> - Use FIELD_MAX to extract the max value from the mask
>> > >> - Expand the commit message with an example on how to reproduce this
>> > >>   issue
>> > >>
>> > >>  drivers/net/ethernet/xilinx/xilinx_axienet.h      | 5 ++---
>> > >>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
>> > >>  2 files changed, 8 insertions(+), 5 deletions(-)
>> > >>
>> > >> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> > >> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> > >> index 1223fcc1a8da..54db69893565 100644
>> > >> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> > >> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> > >> @@ -109,11 +109,10 @@
>> > >>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet
>> > >> */
>> > >>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits
>> > >> */
>> > >>
>> > >> -#define XAXIDMA_DELAY_MASK		0xFF000000 /* Delay timeout
>> > >> counter */
>> > >> -#define XAXIDMA_COALESCE_MASK		0x00FF0000 /* Coalesce
>> > >> counter */
>> > >> +#define XAXIDMA_DELAY_MASK		((u32)0xFF000000) /* Delay
>> > >> timeout counter */
>> > >
>> > > Adding typecast here looks odd. Any reason for it?
>> > > If needed we do it in specific case where it is required.
>> > >
>> > >> +#define XAXIDMA_COALESCE_MASK		((u32)0x00FF0000) /*
>> > >> Coalesce counter */
>> > >>
>> > >>  #define XAXIDMA_DELAY_SHIFT		24
>> > >> -#define XAXIDMA_COALESCE_SHIFT		16
>> > >>
>> > >>  #define XAXIDMA_IRQ_IOC_MASK		0x00001000 /* Completion
>> > >> intr */
>> > >>  #define XAXIDMA_IRQ_DELAY_MASK		0x00002000 /* Delay
>> > >> interrupt */
>> > >> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> > >> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> > >> index 9eb300fc3590..89b63695293d 100644
>> > >> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> > >> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> > >> @@ -252,7 +252,9 @@ static u32 axienet_usec_to_timer(struct axienet_local
>> > >> *lp, u32 coalesce_usec)
>> > >>  static void axienet_dma_start(struct axienet_local *lp)
>> > >>  {
>> > >>  	/* Start updating the Rx channel control register */
>> > >> -	lp->rx_dma_cr = (lp->coalesce_count_rx <<
>> > >> XAXIDMA_COALESCE_SHIFT) |
>> > >> +	lp->rx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
>> > >> +				   min(lp->coalesce_count_rx,
>> > >> +
>> > >> FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>> > >>  			XAXIDMA_IRQ_IOC_MASK |
>> > >> XAXIDMA_IRQ_ERROR_MASK;
>> > >>  	/* Only set interrupt delay timer if not generating an interrupt on
>> > >>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
>> > >> @@ -264,7 +266,9 @@ static void axienet_dma_start(struct axienet_local
>> > >> *lp)
>> > >>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>> > >>
>> > >>  	/* Start updating the Tx channel control register */
>> > >> -	lp->tx_dma_cr = (lp->coalesce_count_tx <<
>> > >> XAXIDMA_COALESCE_SHIFT) |
>> > >> +	lp->tx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
>> > >> +				   min(lp->coalesce_count_tx,
>> > >> +
>> > >> FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>> > >>  			XAXIDMA_IRQ_IOC_MASK |
>> > >> XAXIDMA_IRQ_ERROR_MASK;
>> > >>  	/* Only set interrupt delay timer if not generating an interrupt on
>> > >>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
>> > >> --
>> > >> 2.35.1.1320.gc452695387.dirty
>> > >


