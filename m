Return-Path: <netdev+bounces-202022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E214AEC086
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC731C4590B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48062201266;
	Fri, 27 Jun 2025 20:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900F15E8B;
	Fri, 27 Jun 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054506; cv=none; b=svY2gZM/4Uncqo24EbUxgY6dUSR1d1T/HXwR9tPTbSKxdjsytqEo8jYf/IgoLWx04Mg2EVvj1a3vCEKLY+gLRDhxp1RuUP64BmJZ7wZu8CAJV1PhyNXRFk/YcixlzFvy/6XoRDZe9Q/9VBpUxbWkjMMjWriDvPVFVcJgdcHmfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054506; c=relaxed/simple;
	bh=alEzDmtk2I2rFB/roV/8cjxA5f7pcGNJr887FkIlt8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxsAUsCHoHg3OHn6bJP2t15aNMStWa8DdPA5qdsyEv/wK0ru/pgXWqqgsYTjBjA9JIb4DWXyafDci37vXJfN2pPKQ3euEghAS6dWQcCbfmLx9Z9QTujikrc9QWh4hARzaYotGeQ6v+zGUr6hCaxzw1rNoCjqkzCQPJhsJ+jh1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uVEnR-000000003Fi-3XIT;
	Fri, 27 Jun 2025 19:31:37 +0000
Date: Fri, 27 Jun 2025 20:31:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH 0/6] net: dsa: mt7530: modernize MIB handling +
 fix
Message-ID: <aF7xlqRLXlZu0DZr@makrotopia.org>
References: <20250410163022.3695-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410163022.3695-1-ansuelsmth@gmail.com>

Hi Christian,

On Thu, Apr 10, 2025 at 06:30:08PM +0200, Christian Marangi wrote:
> This small series modernize MIB handling for MT7530 and also
> implement .get_stats64.
> 
> It was reported that kernel and Switch MIB desync in scenario where
> a packet is forwarded from a port to another. In such case, the
> forwarding is offloaded and the kernel is not aware of the
> transmitted packet. To handle this, read the counter directly
> from Switch registers.
> 
> Christian Marangi (6):
>   net: dsa: mt7530: generalize read port stats logic
>   net: dsa: mt7530: move pkt size and rx err MIB counter to rmon stats
>     API
>   net: dsa: mt7530: move pause MIB counter to eth_ctrl stats API
>   net: dsa: mt7530: move pkt stats and err MIB counter to eth_mac stats
>     API
>   net: dsa: mt7530: move remaining MIB counter to define
>   net: dsa: mt7530: implement .get_stats64

After this series being applied I see lockdep warnings every time
the interface counters are being read on MT7531 connected via MDIO:

[  234.374708] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:579
[  234.383200] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3667, name: ifconfig
[  234.391202] preempt_count: 1, expected: 0
[  234.395226] INFO: lockdep is turned off.
[  234.399150] CPU: 3 UID: 0 PID: 3667 Comm: ifconfig Tainted: G        W  O        6.16.0-rc1+ #0 NONE 
[  234.399158] Tainted: [W]=WARN, [O]=OOT_MODULE
[  234.399160] Hardware name: Bananapi BPI-R3 (DT)
[  234.399162] Call trace:
[  234.399165]  show_stack+0x28/0x78 (C)
[  234.399179]  dump_stack_lvl+0x68/0x8c
[  234.399184]  dump_stack+0x14/0x1c
[  234.399188]  __might_resched+0x138/0x250
[  234.399197]  __might_sleep+0x44/0x80
[  234.399201]  __mutex_lock+0x4c/0x934
[  234.399209]  mutex_lock_nested+0x20/0x28
[  234.399215]  mt7530_get_stats64+0x40/0x2ac
[  234.399222]  dsa_user_get_stats64+0x2c/0x40
[  234.399229]  dev_get_stats+0x44/0x1e0
[  234.399237]  dev_seq_printf_stats+0x24/0xe0
[  234.399244]  dev_seq_show+0x14/0x40
[  234.399248]  seq_read_iter+0x368/0x464
[  234.399257]  seq_read+0xd0/0xfc
[  234.399263]  proc_reg_read+0xa8/0xf0
[  234.399268]  vfs_read+0x98/0x2b0
[  234.399275]  ksys_read+0x54/0xdc
[  234.399280]  __arm64_sys_read+0x18/0x20
[  234.399286]  invoke_syscall.constprop.0+0x4c/0xd0
[  234.399293]  do_el0_svc+0x3c/0xd0
[  234.399298]  el0_svc+0x34/0xa0
[  234.399303]  el0t_64_sync_handler+0x104/0x138
[  234.399308]  el0t_64_sync+0x158/0x15c

Note that this only shows with some lock debugging options being set
and may not actually be a problem, but I believe it anyway should be
fixed somehow.

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set


Cheers


Daniel

