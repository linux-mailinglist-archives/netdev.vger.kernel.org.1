Return-Path: <netdev+bounces-43030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F97D1014
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BA0B213CA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EEE1A709;
	Fri, 20 Oct 2023 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS6GPOBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA771A29C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4EAC433C8;
	Fri, 20 Oct 2023 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697806808;
	bh=az42WckKqhe08bLeJJvuVT9KkX5siM3gUB6IQZ4i7OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oS6GPOBQiYJ9we+krvCWSMNAN0Vx3A39WNpq9lM8R+CRNyS0K7J26lvqpGWW6oj3j
	 9qbFVMSsDzjsZPkhiHteIQK1GRVYsatzZM8iApRoOAXP8fnENM+NzNKidfb6FcDcp7
	 fPMa7PHqYKUyC7lj3BYc5fjVQMs2jjKHWzHQWriTCoVLxVHfHN3CDKWTWHFF/dOIT+
	 uhiEZFa5tEFWd6e5wJDUYdkYlltUP02+r3XU380qVjb+7rlm2kXpV1JANuX0anUPmZ
	 At+UIsETPatxXSvy5DwRCkhtIoGASVJ2pT9IUKyz9DXR3cShom5O8ltY4PfJcpApui
	 6gUE5jnkQ0A5Q==
Date: Fri, 20 Oct 2023 15:00:04 +0200
From: Simon Horman <horms@kernel.org>
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 2/3] r8169: fix the KCSAN reported data-race in rtl_tx
 while reading TxDescArray[entry].opts1
Message-ID: <20231020130004.GE2208164@kernel.org>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
 <20231018193434.344176-2-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018193434.344176-2-mirsad.todorovac@alu.unizg.hr>

On Wed, Oct 18, 2023 at 09:34:36PM +0200, Mirsad Goran Todorovac wrote:
> KCSAN reported the following data-race:
> 
> ==================================================================
> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
> 
> race at unknown origin, with read to 0xffff888140d37570 of 4 bytes by interrupt on cpu 21:
> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
> __napi_poll (net/core/dev.c:6527)
> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> __do_softirq (kernel/softirq.c:553)
> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> irq_exit_rcu (kernel/softirq.c:647)
> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
> asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> call_cpuidle (kernel/sched/idle.c:135)
> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
> 
> value changed: 0xb0000042 -> 0x00000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> ==================================================================
> 
> The read side is in
> 
> drivers/net/ethernet/realtek/r8169_main.c
> =========================================
>    4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>    4356                    int budget)
>    4357 {
>    4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
>    4359         struct sk_buff *skb;
>    4360
>    4361         dirty_tx = tp->dirty_tx;
>    4362
>    4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>    4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
>    4365                 u32 status;
>    4366
>  → 4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
>    4368                 if (status & DescOwn)
>    4369                         break;
>    4370
>    4371                 skb = tp->tx_skb[entry].skb;
>    4372                 rtl8169_unmap_tx_skb(tp, entry);
>    4373
>    4374                 if (skb) {
>    4375                         pkts_compl++;
>    4376                         bytes_compl += skb->len;
>    4377                         napi_consume_skb(skb, budget);
>    4378                 }
>    4379                 dirty_tx++;
>    4380         }
>    4381
>    4382         if (tp->dirty_tx != dirty_tx) {
>    4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
>    4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>    4385
>    4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
>    4387                                               rtl_tx_slots_avail(tp),
>    4388                                               R8169_TX_START_THRS);
>    4389                 /*
>    4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
>    4391                  * too close. Let's kick an extra TxPoll request when a burst
>    4392                  * of start_xmit activity is detected (if it is not detected,
>    4393                  * it is slow enough). -- FR
>    4394                  * If skb is NULL then we come here again once a tx irq is
>    4395                  * triggered after the last fragment is marked transmitted.
>    4396                  */
>    4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>    4398                         rtl8169_doorbell(tp);
>    4399         }
>    4400 }
> 
> tp->TxDescArray[entry].opts1 is reported to have a data-race and READ_ONCE() fixes
> this KCSAN warning.
> 
>    4366
>  → 4367                 status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
>    4368                 if (status & DescOwn)
>    4369                         break;
>    4370
> 
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Marco Elver <elver@google.com>
> Cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Acked-by: Marco Elver <elver@google.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Reviewed-by: Simon Horman <horms@kernel.org>


