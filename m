Return-Path: <netdev+bounces-286218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIGvDn+h/2mw8gAAu9opvQ
	(envelope-from <netdev+bounces-286218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:05:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB505016C4
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12FA8300A8CA
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D837EFE8;
	Sat,  9 May 2026 21:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75725333F;
	Sat,  9 May 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360700; cv=none; b=BGpcLkNibiLf29rS3/jW9pyqhF6R9Wz+D6i0UsU9FoqO25tqhineFfsVl/Pk+fxmF7ZK5TWnM1N2HhNorIYzeuJKogcZWz6Y+SgKAk72gDEdlJScvGeP0PhL1zZqZIJ9Yv/5UQ3jb0hUagAlMz17+eYBybgi6n8IdmzWKxQEDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360700; c=relaxed/simple;
	bh=08lThNnhevMm71QOCq37Tyz24IUFKenJcrFBUwo74DQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Bpszat1n4gaVg0bE40NyreTFtLWfSJL0I6TZcR00dQCAQj3g7oy/ZZpLcCqnubs/LgNdtdqOxM/WrGKranuZTwzdXSCZzH6nPRSbd2ZPWwo0bXyPY3yzWnsnKfCDEtTctfVFJwY3YI/dAn5UNeNMROWOATeHpUz7JCe5zd8+4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3983D92009C; Sat,  9 May 2026 23:04:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 324DB92009B;
	Sat,  9 May 2026 22:04:50 +0100 (BST)
Date: Sat, 9 May 2026 22:04:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] FDDI: defza: Sanitise the reset safety timer
Message-ID: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7DB505016C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[angie.orcam.me.uk:mid]
X-Rspamd-Action: no action

The reset actions of the DEFZA adapters are exceedingly slow, taking up 
to 30 seconds to complete by the device spec and typically in the range 
of 10 seconds in reality, as required for the device RTOS to boot, still 
quite a lot.  Therefore a state machine is used that's interrupt driven, 
however a safety mechanism is required in case of adapter malfunction, 
so that if no state change interrupt has arrived in time, then the 
situation is taken care of.

The safety mechanism depends on the origin of the reset.  For regular 
adapter initialisation at the device probe time a sleep is requested.  
However a reset is also required by the device spec when the adapter has 
transitioned into the halted state, such as in response to a PC Trace 
event in the course of ring fault recovery, possibly a common network 
event.  In that case no sleep is possible as a device halt is reported 
at the hardirq level.

A timer is therefore set up to ensure progress in case no adapter state 
change interrupt has arrived in time, but as from commit 168f6b6ffbee 
("timers: Use del_timer_sync() even on UP") a warning is issued as the 
timer is deleted in the hardirq handler upon an expected state change:

  defza: v.1.1.4  Oct  6 2018  Maciej W. Rozycki
  tc2: DEC FDDIcontroller 700 or 700-C at 0x18000000, irq 4
  tc2: resetting the board...
  ------------[ cut here ]------------
  WARNING: kernel/time/timer.c:1611 at __timer_delete_sync+0x104/0x120, CPU#0: swapper/0/0
  Modules linked in:
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.0.0-dirty #2 VOLUNTARY 
  Stack : 9800000002027d08 00000000140120e0 0000000000000000 ffffffff8089d468
          0000000000000000 0000000000000000 ffffffff807ed6b8 ffffffff80897458
          ffffffff80897400 9800000002027b88 0000000000000000 7070617773203a6d
          0000000000000000 9800000002027ba4 0000000000001000 6465746e69617420
          0000000000000000 ffffffff807ed6b8 00000000140120e0 0000000000000009
          000000000000064b ffffffff800dd14c 0000000000000036 9800000002184000
          0000000000000000 0000000000000020 0000000000000000 ffffffff80910000
          ffffffff8085c000 9800000002027c70 0000000000000001 ffffffff80045fa0
          0000000000000000 0000000000000000 0000000000000000 0000000000000009
          000000000000064b ffffffff800502b8 ffffffff807ed6b8 ffffffff80045fa0
          ...
  Call Trace:
  [<ffffffff800502b8>] show_stack+0x28/0xf0
  [<ffffffff80045fa0>] dump_stack_lvl+0x48/0x7c
  [<ffffffff80068c98>] __warn+0xa0/0x128
  [<ffffffff8004120c>] warn_slowpath_fmt+0x64/0xa4
  [<ffffffff800dd14c>] __timer_delete_sync+0x104/0x120
  [<ffffffff804934ac>] fza_interrupt+0xc74/0xeb8
  [<ffffffff800c6390>] __handle_irq_event_percpu+0x70/0x228
  [<ffffffff800c6560>] handle_irq_event_percpu+0x18/0x78
  [<ffffffff800cc320>] handle_percpu_irq+0x50/0x80
  [<ffffffff800c5970>] generic_handle_irq+0x90/0xd0
  [<ffffffff806e956c>] do_IRQ+0x1c/0x30
  [<ffffffff8004ad4c>] handle_int+0x148/0x154
  [<ffffffff800ab7c0>] do_idle+0x40/0x108
  [<ffffffff800abb0c>] cpu_startup_entry+0x2c/0x38
  [<ffffffff806dfec8>] kernel_init+0x0/0x108
  
  ---[ end trace 0000000000000000 ]---
  tc2: OK
  tc2: model 700 (DEFZA-AA), MMF PMD, address 08-00-2b-xx-xx-xx
  tc2: ROM rev. 1.0, firmware rev. 1.2, RMC rev. A, SMT ver. 1
  tc2: link unavailable
  ------------[ cut here ]------------
  WARNING: kernel/time/timer.c:1611 at __timer_delete_sync+0x104/0x120, CPU#0: swapper/0/0
  Modules linked in:
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W           7.0.0-dirty #2 VOLUNTARY 
  Tainted: [W]=WARN
  Stack : 9800000002027d08 00000000140120e0 0000000000000000 ffffffff8089d468
          0000000000000000 0000000000000000 ffffffff807ed6b8 ffffffff80897458
          ffffffff80897400 9800000002027b88 0000000000000000 0000000000000000
          0000000000000000 9800000002027ba4 0000000000001000 0000000000000000
          0000000000000000 ffffffff807ed6b8 00000000140120e0 0000000000000009
          000000000000064b ffffffff800dd14c 0000000000000036 9800000002184000
          0000000000000000 0000000000000020 0000000000000000 ffffffff80910000
          ffffffff8085c000 9800000002027c70 0000000000000001 ffffffff80045fa0
          0000000000000000 0000000000000000 0000000000000000 0000000000000009
          000000000000064b ffffffff800502b8 ffffffff807ed6b8 ffffffff80045fa0
          ...
  Call Trace:
  [<ffffffff800502b8>] show_stack+0x28/0xf0
  [<ffffffff80045fa0>] dump_stack_lvl+0x48/0x7c
  [<ffffffff80068c98>] __warn+0xa0/0x128
  [<ffffffff8004120c>] warn_slowpath_fmt+0x64/0xa4
  [<ffffffff800dd14c>] __timer_delete_sync+0x104/0x120
  [<ffffffff804934ac>] fza_interrupt+0xc74/0xeb8
  [<ffffffff800c6390>] __handle_irq_event_percpu+0x70/0x228
  [<ffffffff800c6560>] handle_irq_event_percpu+0x18/0x78
  [<ffffffff800cc320>] handle_percpu_irq+0x50/0x80
  [<ffffffff800c5970>] generic_handle_irq+0x90/0xd0
  [<ffffffff806e956c>] do_IRQ+0x1c/0x30
  [<ffffffff8004ad4c>] handle_int+0x148/0x154
  [<ffffffff806de8a4>] arch_local_irq_disable+0x4/0x28
  [<ffffffff800ab7d0>] do_idle+0x50/0x108
  [<ffffffff800abb0c>] cpu_startup_entry+0x2c/0x38
  [<ffffffff806dfec8>] kernel_init+0x0/0x108
  
  ---[ end trace 0000000000000000 ]---
  tc2: registered as fddi0

The immediate origin of the new warning is the switch away from aliasing 
del_timer_sync() to del_timer() (timer_delete_sync() to timer_delete() 
in terms of current function names) for UP configurations, which however 
is the only choice for this driver anyway as no SMP hardware supports 
the TURBOchannel bus this device interfaces to.  Therefore there is a 
very remote issue only this is a sign of.

Specifically if an adapter reset issued upon a transition to the halted 
state times out and first triggers fza_reset_timer() for another reset 
assertion, which then schedules fza_reset_timer() for reset deassertion 
and then that second call is pre-empted after poking at the hardware, 
but before the timer has been rearmed and owing to high system load 
causing exceedingly high scheduling latency control is not handed back 
before a transition to the uninitialised state has caused the timer to 
be deleted even before it has been started, then fza_reset_timer() will 
be called yet again and issue another reset even though by then the 
adapter has already recovered.

Prevent this situation from happening by switching to timer_delete() for 
the transition to the halted state and protect the code region affected 
with a spinlock, also to make sure add_timer() has not been called twice 
in a row due to an execution race between the interrupt handler and the 
timer handler (though it could only happen on SMP, but let's keep the 
driver clean).  It's a very unlikely sequence of events to happen and 
therefore there's no point in trying to be overly clever about it, such 
as by placing printk() calls outside the protection.  For the transition 
to the uninitialised state switch to timer_delete_sync_try() instead, so 
that a timer isn't deleted that's just been rearmed by the timer handler 
and needs to watch for the device to come out of reset again (again, an 
SMP scenario only).

Retain timer_delete_sync() invocations outside the hardirq context for a 
stray timer not to fire once device structures have been released.

Fixes: 61414f5ec9834 ("FDDI: defza: Add support for DEC FDDIcontroller 700 TURBOchannel adapter")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/fddi/defza.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

linux-defza-timer-lock.diff
Index: linux-macro/drivers/net/fddi/defza.c
===================================================================
--- linux-macro.orig/drivers/net/fddi/defza.c
+++ linux-macro/drivers/net/fddi/defza.c
@@ -984,7 +984,7 @@ static irqreturn_t fza_interrupt(int irq
 
 		case FZA_STATE_UNINITIALIZED:
 			netif_carrier_off(dev);
-			timer_delete_sync(&fp->reset_timer);
+			timer_delete_sync_try(&fp->reset_timer);
 			fp->ring_cmd_index = 0;
 			fp->ring_uns_index = 0;
 			fp->ring_rmc_tx_index = 0;
@@ -1018,7 +1018,9 @@ static irqreturn_t fza_interrupt(int irq
 			fp->queue_active = 0;
 			netif_stop_queue(dev);
 			pr_debug("%s: queue stopped\n", fp->name);
-			timer_delete_sync(&fp->reset_timer);
+
+			spin_lock(&fp->lock);
+			timer_delete(&fp->reset_timer);
 			pr_warn("%s: halted, reason: %x\n", fp->name,
 				FZA_STATUS_GET_HALT(status));
 			fza_regs_dump(fp);
@@ -1027,6 +1029,8 @@ static irqreturn_t fza_interrupt(int irq
 			fp->timer_state = 0;
 			fp->reset_timer.expires = jiffies + 45 * HZ;
 			add_timer(&fp->reset_timer);
+			spin_unlock(&fp->lock);
+
 			break;
 
 		default:
@@ -1046,7 +1050,9 @@ static irqreturn_t fza_interrupt(int irq
 static void fza_reset_timer(struct timer_list *t)
 {
 	struct fza_private *fp = timer_container_of(fp, t, reset_timer);
+	unsigned long flags;
 
+	spin_lock_irqsave(&fp->lock, flags);
 	if (!fp->timer_state) {
 		pr_err("%s: RESET timed out!\n", fp->name);
 		pr_info("%s: trying harder...\n", fp->name);
@@ -1069,6 +1075,7 @@ static void fza_reset_timer(struct timer
 		fp->reset_timer.expires = jiffies + 45 * HZ;
 	}
 	add_timer(&fp->reset_timer);
+	spin_unlock_irqrestore(&fp->lock, flags);
 }
 
 static int fza_set_mac_address(struct net_device *dev, void *addr)

