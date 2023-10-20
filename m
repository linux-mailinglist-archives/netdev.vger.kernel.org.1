Return-Path: <netdev+bounces-43031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4447D101D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE44B2136D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD21A70E;
	Fri, 20 Oct 2023 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2SgyYv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7C1A709
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D351C433C8;
	Fri, 20 Oct 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697806827;
	bh=FF6yIFgoZsRm6vs9OFR60yPujPa1CtpzINti2B/DlPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2SgyYv8aEte9ACMcLyW24NZiEiMTnJxONXzWhc9dOSd8nJdnNFhQrig3QpEAPWNh
	 mUq2PIfl9TLdVBJehXxRX7Gu9nUwHEWel3hcEWH6cRl2R5aqi8jOkuR3kCpHH/Y40b
	 4iC/D/qKtxlPVbSMargJ6wNfufPOQrbmZJw9j/9+8lMiHOaNtIstf35/EpFz3OaH22
	 PnetrhLkJagA9y8fxIoKbPFCV2cL2BtodTdd6hBbwN0KkY5yX198rhh5dBY6gn3irs
	 Kc9kVTF+MubqO1J//EkB5jTkkylD6qhcBB06r+N5axxqDlC5dwagWAUckF2FcdFEhi
	 gOSvtfkafrtlw==
Date: Fri, 20 Oct 2023 15:00:23 +0200
From: Simon Horman <horms@kernel.org>
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 3/3] r8169: fix the KCSAN reported data race in rtl_rx
 while reading desc->opts1
Message-ID: <20231020130023.GF2208164@kernel.org>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
 <20231018193434.344176-3-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018193434.344176-3-mirsad.todorovac@alu.unizg.hr>

On Wed, Oct 18, 2023 at 09:34:38PM +0200, Mirsad Goran Todorovac wrote:
> KCSAN reported the following data-race bug:
> 
> ==================================================================
> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
> 
> race at unknown origin, with read to 0xffff888117e43510 of 4 bytes by interrupt on cpu 21:
> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
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
> value changed: 0x80003fff -> 0x3402805f
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> ==================================================================
> 
> drivers/net/ethernet/realtek/r8169_main.c:
> ==========================================
>    4429
>  → 4430                 status = le32_to_cpu(desc->opts1);
>    4431                 if (status & DescOwn)
>    4432                         break;
>    4433
>    4434                 /* This barrier is needed to keep us from reading
>    4435                  * any other fields out of the Rx descriptor until
>    4436                  * we know the status of DescOwn
>    4437                  */
>    4438                 dma_rmb();
>    4439
>    4440                 if (unlikely(status & RxRES)) {
>    4441                         if (net_ratelimit())
>    4442                                 netdev_warn(dev, "Rx ERROR. status = %08x\n",
> 
> Marco Elver explained that dma_rmb() doesn't prevent the compiler to tear up the access to
> desc->opts1 which can be written to concurrently. READ_ONCE() should prevent that from
> happening:
> 
>    4429
>  → 4430                 status = le32_to_cpu(READ_ONCE(desc->opts1));
>    4431                 if (status & DescOwn)
>    4432                         break;
>    4433
> 
> As the consequence of this fix, this KCSAN warning was eliminated.
> 
> Fixes: 6202806e7c03a ("r8169: drop member opts1_mask from struct rtl8169_private")
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Acked-by: Marco Elver <elver@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


